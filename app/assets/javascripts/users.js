
input_picture_changed = function() {

    var size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
        alert('Maximum file size is 5MB, Please choose a smaller file.')
    }
    else {
        // 检查是否支持FileReader对象
        if (typeof FileReader != 'undefined') {
            var acceptedTypes = {
                'image/png': true,
                'image/jpeg': true,
                'image/gif': true
            };
            if (acceptedTypes[this.files[0].type] === true) {
                var reader = new FileReader();
                reader.onload = function (event) {
                    var image = document.getElementById('avatar_preview')
                    image.src = event.target.result;
                };
                reader.readAsDataURL(this.files[0]);
            }
        }
    }
};