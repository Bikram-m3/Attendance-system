var crypto = require('crypto');
var uuid = require('uuid');
var express = require('express');
var mysql = require('mysql');
var bodyparser = require('body-parser');
var async = require("async");
var cors = require("cors");



var con = mysql.createConnection({
    host: ' 127.0.0.1',
    user: 'root',
    password: '',
    database: 'wifi_attendance'
});



var app = express();
app.use(cors());
app.use(bodyparser.json());//accepts json parameter
app.use(bodyparser.urlencoded({ extended: true }));


//password encryptions.....
var genRandomString = function (length) {
    return crypto.randomBytes(Math.ceil(length / 2)).toString('hex').slice(0, length);/*return required number of hex character */
};

var sha512 = function (password, salt) {
    var hash = crypto.createHmac('sha512', salt);
    hash.update(password);
    var value = hash.digest('hex');
    return {
        salt: salt,
        passwordHash: value
    };
};

//function for encrypt and decrypt password........
function saltHashPassword(userPassword) {
    var salt = genRandomString(16);
    var passwordData = sha512(userPassword, salt);
    return passwordData;
}

function checkHashPassword(userPassword, salt) {
    var passwordData = sha512(userPassword, salt);
    return passwordData;
}



//initial path...................................
app.get('/', function (req, res) {
    console.log(req.header('API-KEY'));
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
           console.log(err);
        });

        if (result && result.length) {
            res.send('<h1>I Am Watching You!</h1>');
        } else {
        }

    });
});



 //teacher and admin regester......................................................
app.get('/teacherregister/', (req, res, next) => {
    var uid = uuid.v4();
    var hash_pass = saltHashPassword(req.header('username'));//hashed password
    var password = hash_pass.passwordHash;//get hashed pass
    var salt = hash_pass.salt;//salt pass....


    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            
        });

        if (result && result.length) {

            con.query('SELECT * FROM `login` WHERE username=?', [req.header('username')], function (errr, result, fields) {
                con.on('error', function (errr) {
                    res.json(errr);
                    res.status(400).send(JSON.stringify(errr));
                });
                if (result && result.length) {
                    res.status(401).send(JSON.stringify('User already exists !!!'));
                }
                else {
                    con.query('INSERT INTO `login`(`name`, `username`, `roll`, `phone`, `role`, `uid`, `encrypted_password`, `salt_password`) VALUES (?,?,?,?,?,?,?,?)', [req.header('name'), req.header('username'), req.header('roll'), req.header('phone'), req.header('role'), uid, password, salt], function (err, result, fields) {
                        con.on('error', function (err) {
                            res.status(403).send(JSON.stringify(err));

                        });
                        res.status(200).send(JSON.stringify('User Added !!!'));
                    });
                }

            });

        } else {
            
        }

    });

});

//get admin List........................
app.get('/adminList/', (req, res, next) => {
    var role = '2'

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            
        });

        if (result && result.length) {

            con.query('SELECT `name`, `username`, `roll`, `phone`, `role`, `uid` FROM `login` WHERE role=?', [role], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });


        } else {
            
        }

    });
});


//get total class....................................
app.get('/gettotalattend/', (req, res, next) => {


    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT * FROM `teacherAttend` WHERE teacherID=? AND sem=? AND sub=? AND depart=? AND shift=? AND batch=?', [req.header('teacherID'),req.header('sem'),req.header('sub'),req.header('depart'),req.header('shift'),req.header('batch')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });


        } else {
             
        }

    });
});



//get deviceID list................................
app.get('/deviceID/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            
        });

        if (result && result.length) {


            con.query('SELECT `uid` FROM `login`', [], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });



        } else {
            
        }

    });
});


//student register................................................
app.get('/studentregister/', (req, res, next) => {
    var uid = uuid.v4();
    var hash_pass = saltHashPassword(req.header('username'));//hashed password
    var password = hash_pass.passwordHash;//get hashed pass
    var salt = hash_pass.salt;//salt pass....


    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            
        });

        if (result && result.length) {

            con.query('SELECT * FROM `login` WHERE username=?', [req.header('username')], function (errr, result, fields) {
                con.on('error', function (errr) {
                    res.json(errr);
                    res.status(400).send(JSON.stringify(errr));
                });
                if (result && result.length) {
                    res.status(401).send(JSON.stringify('User already exists !!!'));
                }
                else {
                    con.query('INSERT INTO `login`(`name`, `username`, `roll`, `phone`, `role`, `uid`, `encrypted_password`, `salt_password`) VALUES (?,?,?,?,?,?,?,?)', [req.header('name'), req.header('username'), req.header('roll'), req.header('phone'), req.header('role'), uid, password, salt], function (err, result, fields) {
                        con.on('error', function (err) {
                            res.status(403).send(JSON.stringify(err));
                        });

                        con.query('INSERT INTO `detail`(`username`, `faculty`, `shift`, `Batch`,`sem`) VALUES (?,?,?,?,?)', [req.header('username'), req.header('depart'), req.header('shift'), req.header('batch'),req.header('sem')], function (err, result, fields) {
                            con.on('error', function (err) {
                                res.status(404).send(JSON.stringify(err));
                            });

                            res.status(200).send(JSON.stringify('Student Added !!!'));


                        });
                    });
                }

            });

        } else {
            
        }

    });

});



//web login api.......................................
app.get('/weblogin/', (req, res, next) => {
    var post_data = req.body;

    var user_password = req.header('password');
    var user = req.header('username');

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
           
        });

        if (result && result.length) {


            con.query('SELECT * FROM `login` WHERE username=?', [user], function (err, result1, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result1 && result1.length) {
                    var salt = result1[0].salt_password;
                    var encrypted_password = result1[0].encrypted_password;

                    var hashed_password = checkHashPassword(user_password, salt).passwordHash;

                    if (encrypted_password == hashed_password) {

                        res.status(200).send(JSON.stringify(result1[0].uid));

                    }
                    else {
                        res.status(400).send(JSON.stringify('Wrong Password !!!'));
                    }

                } else {
                    res.status(401).send(JSON.stringify('User Not Exists !!!'));
                }

            });


        } else {
            
        }

    });
});



//get countes........................
app.get('/counts/', (req, res, next) => {

console.log("works");
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT faculty, COUNT(*) FROM `detail` GROUP BY faculty ORDER BY COUNT(*) DESC', [], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });


        } else {
             
        }

    });
});


//filter Users count........................
app.get('/UsersCountBydepart/', (req, res, next) => {
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT `username` FROM `detail` WHERE faculty=? AND sem=? AND shift=?', [req.header('depart'), req.header('sem'), req.header('shift')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    console.log(result);
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data Found !!!'));
                }

            });
        } else {
             
        }

    });
});


//login api.......................................
app.post('/login/', (req, res, next) => {
    var post_data = req.body;

    var user_password = post_data.password;
    var user = post_data.email;
    var UID = post_data.uid;

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
           
        });

        if (result && result.length) {
            con.query('SELECT * FROM `login` WHERE username=?', [user], function (err, result1, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result1 && result1.length) {
                    var salt = result1[0].salt_password;
                    var encrypted_password = result1[0].encrypted_password;

                    var hashed_password = checkHashPassword(user_password, salt).passwordHash;

                    if (encrypted_password == hashed_password) {

                        if(result1[0].role == 1){

                            con.query('UPDATE `login` SET `uid`=? WHERE username=?', [UID,user], function (err, result, fields) {
                                con.on('error', function (err) {
                                    res.status(404).send(JSON.stringify(err));
                                });
                
                                res.status(200).send(JSON.stringify(result1[0]));
                            });
                        }else{

                            con.query('SELECT login.name, login.username, login.roll, login.phone, login.role, login.uid,detail.faculty, detail.shift, detail.Batch, detail.sem FROM `login`,`detail` WHERE login.username = detail.username AND login.username=?', [user], function (err, result2, fields) {
                                con.on('error', function (err) {
                                    res.status(404).send(JSON.stringify(err));
                                });

                                if (result2 && result2.length){

                                    con.query('UPDATE `login` SET `uid`=? WHERE username=?', [UID,user], function (err, result, fields) {
                                        con.on('error', function (err) {
                                            res.status(404).send(JSON.stringify(err));
                                        });
                        
                                        res.status(200).send(JSON.stringify(result2[0]));
                                    });


                                }
                            });


                        }

                    }
                    else {
                        res.status(400).send(JSON.stringify('Wrong Password !!!'));
                    }

                } else {
                    res.status(401).send(JSON.stringify('User Not Exists !!!'));
                }

            });


        } else {
            
        }

    });
});


//get attendance list by depart................................
app.get('/departattendance/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            console.log(err);
        });

        if (result && result.length) {


            con.query('SELECT login.username,login.roll,login.name,attendance.teacherID, attendance.attend, attendance.sem, attendance.sub, attendance.year, attendance.month, attendance.day, attendance.depart, attendance.shift ,attendance.AUID ,detail.Batch FROM `login`,`attendance`,`detail` WHERE  login.username = attendance.username AND login.username = detail.username AND attendance.depart=? AND attendance.sem=? AND attendance.shift=? AND attendance.sub=? AND detail.Batch=?', [req.header('depart'),req.header('sem'),req.header('shift'),req.header('sub'),req.header('batch')], function (err, result, fields) {
                con.on('error', function (err) {
                    console.log(err);
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Record Found..!!!'));
                }

            });



        } else {
            
        }

    });
});


//get attendance list by roll................................
app.get('/rollattendance/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            console.log(err);
        });

        if (result && result.length) {


            con.query('SELECT `username` FROM `login` WHERE roll=?', [req.header('roll')], function (err, result1, fields) {
                con.on('error', function (err) {
                    console.log(err);
                });

                con.query('SELECT login.username,login.roll,login.name,attendance.teacherID, attendance.attend, attendance.sem, attendance.sub, attendance.year, attendance.month, attendance.day, attendance.depart, attendance.shift ,attendance.AUID ,detail.Batch FROM `login`,`attendance`,`detail` WHERE  login.username = attendance.username AND login.username = detail.username AND attendance.sem=? AND attendance.sub=? AND attendance.username=?', [req.header('sem'),req.header('sub'),result1[0].username], function (err, result, fields) {
                    con.on('error', function (err) {
                        console.log(err);
                    });
    
                    if (result && result.length) {
                        res.status(200).send(JSON.stringify(result));
    
                    } else {
                        res.status(401).send(JSON.stringify('No Record Found..!!!'));
                    }
    
                });


            });

        } else {
            
        }

    });
});

//get attendance by AUID........................
app.get('/auidattendance/', (req, res, next) => {
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT login.name,login.roll FROM `login`,`attendance` WHERE login.username=attendance.username AND attendance.AUID=?', [req.header('AUID')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });


        } else {
             
        }

    });
});


//get department list................................
app.get('/depart/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            
        });

        if (result && result.length) {


            con.query('SELECT * FROM `dipartment`', [], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });



        } else {
            
        }

    });
});


//get change Password................................
app.get('/changepassword/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
            console.log(err);
           
        });

        if (result && result.length) {


            con.query('SELECT `encrypted_password`, `salt_password` FROM `login` WHERE username=?', [req.header('username')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                    console,log(err);
                });

                if (result && result.length) {
                    var salt = result[0].salt_password;
                    var encrypted_password = result[0].encrypted_password;

                    var hashed_password = checkHashPassword(req.header('oldpassword'), salt).passwordHash;

                    if (encrypted_password == hashed_password) {

                        var newhash_pass = saltHashPassword(req.header('newpassword'));//hashed password
                        var newpassword = newhash_pass.passwordHash;//get hashed pass
                        var newsalt = newhash_pass.salt;//salt pass....

                        con.query('UPDATE `login` SET `encrypted_password`=?,`salt_password`=? WHERE username=?', [newpassword,newsalt,req.header('username')], function (err, result, fields) {
                            con.on('error', function (err) {
                                res.status(403).send(JSON.stringify(err));
    
                            });
                            res.status(200).send(JSON.stringify('Password Updated..!!!'));
                        });

                    }
                    else {
                        res.status(400).send(JSON.stringify('Wrong old Password !!!'));
                    }

                } else {
                    res.status(401).send(JSON.stringify('User Not Exists !!!'));
                }

            });



        } else {
            
        }

    });
});

//get course........................
app.get('/course/', (req, res, next) => {


    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT * FROM `course`', [], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });


        } else {
             
        }

    });
});


//filter Users by roll........................
app.get('/filterUsersByRoll/', (req, res, next) => {
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT `name`, `username`, `roll`, `phone`, `role`, `uid` FROM `login` WHERE roll=?', [req.header('roll')], function (err, result1, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result1 && result1.length) {

                    if(result1[0].role==0){

                        con.query('SELECT login.name, login.username, login.roll, login.phone, login.role, login.uid,detail.faculty,detail.shift,detail.sem FROM `login`,`detail` WHERE login.username=detail.username AND roll=?', [req.header('roll')], function (err, result2, fields) {
                            con.on('error', function (err) {
                                res.status(402).send(JSON.stringify(err));
                            });

                            if (result2 && result2.length) {
                                res.status(200).send(JSON.stringify(result2));
                            }else{
                                res.status(401).send(JSON.stringify('No Data !!!'));
                            }
    
    
                        
                        });


                    }else{
                        res.status(200).send(JSON.stringify(result1));
                    }

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });
        } else {
             
        }

    });
});



//update users sem.........................................
app.get('/updateuserssem/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('UPDATE `detail` SET `sem`=? WHERE faculty=? AND shift=? AND sem=?', [req.header('newsem'), req.header('depart'), req.header('shift'),req.header('oldsem')], function (err, result1, fields) {
                con.on('error', function (err) {
                     
                });


                res.status(400).send(JSON.stringify('Semester Updated !!!'));

            });
        } else {
             
        }

    })


});


//filter Users by name........................
app.get('/filterUsersByName/', (req, res, next) => {
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT `name`, `username`, `roll`, `phone`, `role`, `uid` FROM `login` WHERE name=?', [req.header('name')], function (err, result1, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result1 && result1.length) {

                    if(result1[0].role==0){

                        con.query('SELECT login.name, login.username, login.roll, login.phone, login.role, login.uid,detail.faculty,detail.shift,detail.sem FROM `login`,`detail` WHERE login.username=detail.username AND name=?', [req.header('name')], function (err, result2, fields) {
                            con.on('error', function (err) {
                                res.status(402).send(JSON.stringify(err));
                            });

                            if (result2 && result2.length) {
                                res.status(200).send(JSON.stringify(result2));
                            }else{
                                res.status(401).send(JSON.stringify('No Data !!!'));
                            }
    
    
                        
                        });


                    }else{
                        res.status(200).send(JSON.stringify(result1));
                    }
                    

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });
        } else {
             
        }

    });
});


//filter Users by department........................
app.get('/filterUsersBydepart/', (req, res, next) => {
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT login.name, login.username, login.roll, login.phone, login.role, login.uid, detail.faculty,detail.Shift,detail.Batch,detail.sem FROM login login INNER JOIN detail detail ON login.username = detail.username WHERE detail.faculty=? AND detail.shift=? AND detail.Batch=?', [req.header('depart'), req.header('shift'), req.header('batch')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    console.log(result);
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data Found !!!'));
                }

            });
        } else {
             
        }

    });
});

//update users profile................................
app.get('/updateusers/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('UPDATE `login` SET `name`=?,`phone`=? WHERE username=?', [req.header('name'), req.header('phone'), req.header('username')], function (err, result1, fields) {
                con.on('error', function (err) {
                     
                });


                res.status(400).send(JSON.stringify('User Updated !!!'));

            });
        } else {
             
        }

    })


});


//filter course........................
app.get('/filtercourse/', (req, res, next) => {


    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT * FROM `course` WHERE faculty=? AND sem=?', [req.header('depart'), req.header('sem')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                if (result && result.length) {
                    res.status(200).send(JSON.stringify(result));

                } else {
                    res.status(401).send(JSON.stringify('No Data !!!'));
                }

            });
        } else {
             
        }

    });
});



//add subjects................................
app.get('/addsubjects/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('SELECT * FROM `course` WHERE faculty =? AND sem=? AND subject=?', [req.header('depart'), req.header('sem'), req.header('sub')], function (err, result, fields) {
                con.on('error', function (err) {
                     
                });

                if (result && result.length) {
                    res.status(400).send(JSON.stringify('Already Added !!!'));

                } else {

                    con.query('INSERT INTO `course`(`faculty`, `sem`, `subject`) VALUES (?,?,?)', [req.header('depart'), req.header('sem'), req.header('sub')], function (err, result, fields) {
                        con.on('error', function (err) {
                            res.status(402).send(JSON.stringify(err));
                        });

                        console.log(req);
                        res.status(200).send(JSON.stringify('Added Sucessfully'));



                    });

                }
            });
        } else {
             
        }

    })


});


//update subjects................................
app.get('/updatesubjects/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('UPDATE `course` SET faculty=?,sem=?,subject=? WHERE faculty =? AND sem=? AND subject=?', [req.header('depart'), req.header('sem'), req.header('sub'), req.header('olddepart'), req.header('oldsem'), req.header('oldsub')], function (err, result1, fields) {
                con.on('error', function (err) {
                     
                });


                res.status(400).send(JSON.stringify('Subject Updated !!!'));

            });
        } else {
             
        }

    })


});


//attendance list update................................
app.post('/attendanceUpdate/', (req, res, next) => {
    var data = req.body;
    console.log("1st" + data[0].username);
    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {
            for (let i = 0; i < data.length; i++) {

                if (data[i].deviceId == "null") {

                    con.query('SELECT `Batch` FROM `detail` WHERE username=?', [data[i].username], function (err, result1, fields) {
                        con.on('error', function (err) {
                             
                        });

                        if (result1 && result1.length) {
                            var userName = data[i].username;
                            var batch=result1[0].Batch;
                            con.query('INSERT INTO `attendance`(`username`, `teacherID`, `attend`, `sem`, `sub`, `year`, `month`, `day`, `depart`, `shift`, `AUID`) VALUES (?,?,?,?,?,?,?,?,?,?,?)', [userName, req.header('teacherID'), '1', req.header('sem'), req.header('sub'), req.header('year'), req.header('month'), req.header('day'), req.header('depart'), req.header('shift'),req.header('AUID')], function (err, result, fields) {
                                con.on('error', function (err) {
                                     
                                });
                                
                            });
                        }
                    });

                } else {
                    con.query('SELECT `uid` FROM `login` WHERE username=?', [data[i].username], function (err, result2, fields) {
                        con.on('error', function (err) {
                             
                        });

                        if (result2 && result2.length) {
                            if (result2[0].uid == data[i].deviceId) {

                                con.query('INSERT INTO `attendance`(`username`, `teacherID`, `attend`, `sem`, `sub`, `year`, `month`, `day`, `depart`, `shift`, `AUID`) VALUES (?,?,?,?,?,?,?,?,?,?,?)', [data[i].username, req.header('teacherID'), '1', req.header('sem'), req.header('sub'), req.header('year'), req.header('month'), req.header('day'), req.header('depart'), req.header('shift'),req.header('AUID')], function (err, result, fields) {
                                    con.on('error', function (err) {
                                         
                                    });

                                });
                            }
                        }
                    });
                }
            }


            con.query('SELECT `Batch` FROM `detail` WHERE username=?', [data[0].username], function (err, result3, fields) {
                con.on('error', function (err) {
                     
                });

                if (result3 && result3.length) {

                        con.query('INSERT INTO `teacherAttend`(`AUID`, `teacherID`, `sem`, `sub`, `depart`, `shift`, `batch`, `day`, `month`, `year`) VALUES (?,?,?,?,?,?,?,?,?,?)', [req.header('AUID'), req.header('teacherID'), req.header('sem'), req.header('sub'), req.header('depart'), req.header('shift'),result3[0].Batch, req.header('day'), req.header('month'), req.header('year')], function (err, result, fields) {
                            con.on('error', function (err) {     
                            });

                            res.status(400).send(JSON.stringify('Attendance List Updated !!!'));



                        });
                    
                }
            });




        }

    })


});

//delete users................................
app.get('/deleteusers/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('DELETE FROM `login` WHERE username=?', [req.header('username')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                con.query('DELETE FROM `detail` WHERE username=?', [req.header('username')], function (err, result, fields) {
                    con.on('error', function (err) {
                        res.status(402).send(JSON.stringify(err));
                    });

                    res.status(200).send(JSON.stringify('User Deleted !!!'));

                });
            });
        } else {
             
        }

    })


});


//delete subjects................................
app.get('/deletesubjects/', (req, res, next) => {

    con.query('SELECT `API_KEY` FROM `app_crid` WHERE API_KEY=?', [req.header('API-KEY')], function (err, result, fields) {
        con.on('error', function (err) {
             
        });

        if (result && result.length) {

            con.query('DELETE FROM `course` WHERE faculty =? AND sem=? AND subject=?', [req.header('depart'), req.header('sem'), req.header('sub')], function (err, result, fields) {
                con.on('error', function (err) {
                    res.status(402).send(JSON.stringify(err));
                });

                res.status(200).send(JSON.stringify('Subject Deleted !!!'));

            });
        } else {
             
        }

    })


});



//bottom part...........................
var http = require('http').Server(app);

http.listen(7001, () => {
    console.log('Listening on port 7001...');

})