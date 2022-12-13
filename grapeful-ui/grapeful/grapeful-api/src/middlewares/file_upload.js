const multer = require('multer');
const uuid = require('uuid');

const storage = multer.diskStorage({
    destination: function(req, file, cb){
        cb(null, 'uploads');
    },
    filename: function(req,file,cb) {
        const originalName = file.originalname;
        const nameArray = originalName.split('.'); //used to split the file name and store in array
        const extension = nameArray[nameArray.length - 1];

        const newFilename = uuid.v1() + "." + extension;

        cb(null, newFilename);
    }
});

const upload = multer({
    storage: storage
});

module.exports = upload;