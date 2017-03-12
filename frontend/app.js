var app = angular.module('GreenField', []);

app.controller("home", function($scope, $http) {


  $scope.prepareBody = function() {

    var node = document.getElementById('tableHeader');
    while (node.hasChildNodes()) {
        node.removeChild(node.firstChild);
    }

    node = document.getElementById('tableBody');
    while (node.hasChildNodes()) {
        node.removeChild(node.firstChild);
    }
  };

    $scope.query1 = function(_branch) {
      $http.get('query1.php', {
        params: {branchNo: _branch}
      }).then(function(response) {
        $scope.posts = response.data.posts;

        $scope.queryTitle = 'Query 1';


        $scope.prepareBody();

        var node = document.getElementById('tableHeader');
        var streetHeader = document.createElement('th');
        streetHeader.innerHTML = 'Address';

        var managerHeader = document.createElement('th');
        managerHeader.innerHTML = 'Manager Name';

        var headerRow = document.createElement('tr');
        headerRow.appendChild(streetHeader);
        headerRow.appendChild(managerHeader);

        node.appendChild(headerRow);

        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var streetNode = document.createElement('td');
          streetNode.innerHTML = post['address'];
          var nameNode = document.createElement('td');
          nameNode.innerHTML = post['fullName'];
          row.appendChild(streetNode);
          row.appendChild(nameNode);
          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');
      }, function() {

      });

    };


    $scope.query2 = function() {
      $http.get('query2.php', {}).then(function(response) {
        $scope.posts = response.data.posts;
        $scope.prepareBody();

        $scope.queryTitle = 'Query 2';

        var node = document.getElementById('tableHeader');
        var streetHeader = document.createElement('th');
        streetHeader.innerHTML = 'Address';

        var managerHeader = document.createElement('th');
        managerHeader.innerHTML = 'Supervisor Name';

        var headerRow = document.createElement('tr');
        headerRow.appendChild(streetHeader);
        headerRow.appendChild(managerHeader);

        node.appendChild(headerRow);


        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var streetNode = document.createElement('td');
          streetNode.innerHTML = post['address'];
          var nameNode = document.createElement('td');
          nameNode.innerHTML = post['fullName'];
          row.appendChild(streetNode);
          row.appendChild(nameNode);
          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');

      }, function() {

      });
    };

    $scope.query3 = function(_branch, _firstName, _lastName) {
      $http.get('query3.php', {
        params: {branchName: _branch, firstName: _firstName, lastName:_lastName}
      }).then(function(response) {

        $scope.posts = response.data.posts;

        $scope.queryTitle = 'Query 3';

        $scope.prepareBody();

        var node = document.getElementById('tableHeader');
        var propertyHeader = document.createElement('th');
        propertyHeader.innerHTML = 'Property Name';

        var headerRow = document.createElement('tr');
        headerRow.appendChild(propertyHeader);

        node.appendChild(headerRow);


        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var propertyNode = document.createElement('td');
          propertyNode.innerHTML = post['address'];
          row.appendChild(propertyNode);
          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');

      }, function() {

      });
    };

    $scope.query4 = function(_city, _rooms, _lowest, _highest) {
      $http.get('query4.php', {
        params: {city: _city, rooms: _rooms, lowest: _lowest, highest: _highest}
      }).then(function(response) {
        $scope.posts = response.data.posts;

        $scope.queryTitle = 'Query 4';


        $scope.prepareBody();

        var node = document.getElementById('tableHeader');
        var addressHeader = document.createElement('th');
        addressHeader.innerHTML = 'Address';

        var roomHeader = document.createElement('th');
        roomHeader.innerHTML = 'Rooms';

        var rentHeader = document.createElement('th');
        rentHeader.innerHTML = 'Rent';

        var headerRow = document.createElement('tr');
        headerRow.appendChild(addressHeader);
        headerRow.appendChild(roomHeader);
        headerRow.appendChild(rentHeader);

        node.appendChild(headerRow);


        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var addressNode = document.createElement('td');
          addressNode.innerHTML = post['address'];
          var roomNode = document.createElement('td');
          roomNode.innerHTML = post['rooms'];
          var rentNode = document.createElement('td');
          rentNode.innerHTML = post['rent'];
          row.appendChild(addressNode);
          row.appendChild(roomNode);
          row.appendChild(rentNode);
          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');

      }, function() {

      });
    };

    $scope.query5 = function() {
      $http.get('query5.php', {}).then(function(response) {
        $scope.posts = response.data.posts;

        $scope.prepareBody();

        $scope.queryTitle = 'Query 5';


        var node = document.getElementById('tableHeader');
        var countHeader = document.createElement('th');
        countHeader.innerHTML = 'Count';

        var branchHeader = document.createElement('th');
        branchHeader.innerHTML = 'Branch Number';

        var headerRow = document.createElement('tr');
        headerRow.appendChild(branchHeader);
        headerRow.appendChild(countHeader);

        node.appendChild(headerRow);


        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var countNode = document.createElement('td');
          countNode.innerHTML = post['count'];
          var branchNode = document.createElement('td');
          branchNode.innerHTML = post['branchNumber'];
          row.appendChild(branchNode);
          row.appendChild(countNode);
          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');

      }, function() {

      });
    };

    $scope.query6 = function(_propertyID, _firstName, _lastName, _homePhone, _workPhone, _contactFirstName, _contactLastName, _contactPhone, _startDate, _endDate, _depositAmount) {
      $http.get('query6.php',
        {params: {
          propertyID: _propertyID,
          firstName: _firstName,
          lastName: _lastName,
          homePhone: _homePhone,
          workPhone: _workPhone,
          contactFirstName: _contactFirstName,
          contactLastName: _contactLastName,
          contactPhone: _contactPhone,
          startDate: _startDate,
          endDate: _endDate,
          deposit: _depositAmount
        }}).then(function(response) {
          $scope.posts = response.data.posts;

          $scope.prepareBody();

          $scope.queryTitle = 'Query 6';

          var node = document.getElementById('tableBody');
          var row = document.createElement('tr');
          row.innerHTML = $scope.posts[0]['status'];


          node.appendChild(row);


          $('#modal1').modal('toggle');


        }, function() {

          $scope.prepareBody();

          $scope.queryTitle = 'Query 6';

          var node = document.getElementById('tableBody');
          var row = document.createElement('tr');
          row.innerHTML = 'Failure';


          node.appendChild(row);


        });
    };


    $scope.query7 = function(_firstName, _lastName) {
      $http.get('query7.php', {
        params: {firstName: _firstName, lastName: _lastName}
      }).then(function(response) {
        $scope.posts = response.data.posts;

        $scope.prepareBody();

        $scope.queryTitle = 'Query 7';


        var node = document.getElementById('tableHeader');

        var idHeader = document.createElement('th');
        idHeader.innerHTML = 'Lease ID';

        var nameHeader = document.createElement('th');
        nameHeader.innerHTML = 'R Name';

        var homePhoneHeader = document.createElement('th');
        homePhoneHeader.innerHTML = 'H Phone';

        var workHeader = document.createElement('th');
        workHeader.innerHTML = 'W Phone';

        var contactHeader = document.createElement('th');
        contactHeader.innerHTML = 'C Name';

        var contactPhoneHeader = document.createElement('th');
        contactPhoneHeader.innerHTML = 'C Phone';

        var startHeader = document.createElement('th');
        startHeader.innerHTML = 'Start';

        var endHeader = document.createElement('th');
        endHeader.innerHTML = 'End';

        var rentHeader = document.createElement('th');
        rentHeader.innerHTML = 'Rent';
http://linux.students.engr.scu.edu/~iamirtha/COEN178/
        var depositHeader = document.createElement('th');
        depositHeader.innerHTML = 'Deposit';

        var headerRow = document.createElement('tr');
        headerRow.appendChild(idHeader);
        headerRow.appendChild(nameHeader);
        headerRow.appendChild(homePhoneHeader);
        headerRow.appendChild(workHeader);
        headerRow.appendChild(contactHeader);
        headerRow.appendChild(contactPhoneHeader);
        headerRow.appendChild(startHeader);
        headerRow.appendChild(endHeader);
        headerRow.appendChild(rentHeader);
        headerRow.appendChild(depositHeader);

        var node = document.getElementById('tableHeader');
        node.appendChild(headerRow);


        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var nameNode = document.createElement('td');
          nameNode.innerHTML = post['fullName']; 
	  var idNode = document.createElement('td');
          idNode.innerHTML = post['leaseID'];
          var homePhoneNode = document.createElement('td');
          homePhoneNode.innerHTML = post['homePhone'];
          var workPhoneNode = document.createElement('td');
          workPhoneNode.innerHTML = post['workPhone'];
          var contactNode = document.createElement('td');
          contactNode.innerHTML = post['contactName'];
          var contactPhoneNode = document.createElement('td');
          contactPhoneNode.innerHTML = post['contactPhone'];
          var depositNode = document.createElement('td');
          depositNode.innerHTML = post['depositAmount'];
          var rentNode = document.createElement('td');
          rentNode.innerHTML = post['rentAmount'];
          var startNode = document.createElement('td');
          startNode.innerHTML = post['startDate'];
          var endNode = document.createElement('td');
          endNode.innerHTML = post['endDate'];
          row.appendChild(idNode);
          row.appendChild(nameNode);
          row.appendChild(homePhoneNode);
          row.appendChild(workPhoneNode);
          row.appendChild(contactNode);
          row.appendChild(contactPhoneNode);
          row.appendChild(startNode);
          row.appendChild(endNode);
          row.appendChild(depositNode);
          row.appendChild(rentNode);



          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');

      }, function() {

      });
    };

    $scope.query8 = function() {
      $http.get('query8.php', {}).then(function(response) {
        $scope.posts = response.data.posts;

        $scope.queryTitle = 'Query 8';


        $scope.prepareBody();


        var node = document.getElementById('tableHeader');
        var nameHeader = document.createElement('th');
        nameHeader.innerHTML = 'Name';


        var headerRow = document.createElement('tr');
        headerRow.appendChild(nameHeader);

        node.appendChild(headerRow);


        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var nameNode = document.createElement('td');
          nameNode.innerHTML = post['fullName'];
          row.appendChild(nameNode);
          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');

      }, function() {

      });
    };

    $scope.query9 = function(_cityName) {
      $http.get('query9.php', {
        params: {cityName: _cityName}
      }).then(function(response) {
        $scope.posts = response.data.posts;

        $scope.queryTitle = 'Query 9';


        $scope.prepareBody();

        var node = document.getElementById('tableHeader');
        var avgHeader = document.createElement('th');
        avgHeader.innerHTML = 'Average Rent';
        var cityHeader = document.createElement('th');
        cityHeader.innerHTML = 'City';

        var headerRow = document.createElement('tr');
        headerRow.appendChild(cityHeader);
        headerRow.appendChild(avgHeader);

        node.appendChild(headerRow);


        var bodyNode = document.getElementById('tableBody');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var avgNode = document.createElement('td');
          avgNode.innerHTML = post['avgRent'];
          var cityNode = document.createElement('td');
          cityNode.innerHTML = post['city'];
          row.appendChild(cityNode);
          row.appendChild(avgNode);
          bodyNode.appendChild(row);

        }


        $('#modal1').modal('toggle');

      }, function() {

      });
    };

    $scope.query10 = function() {
      $http.get('query10.php').then(function(response) {
        $scope.posts = response.data.posts;

        $scope.prepareBody();

        $scope.queryTitle = 'Query 10';


        var node = document.getElementById('tableHeader');
        var addressHeader = document.createElement('th');
        addressHeader.innerHTML = 'Address';
        var nameHeader = document.createElement('th');
        nameHeader.innerHTML = 'Name';
        var endHeader = document.createElement('th');
        endHeader.innerHTML = 'End Date';
        node.appendChild(nameHeader);
        node.appendChild(addressHeader);
	node.appendChild(endHeader);

        var bodyNode = document.getElementById('tableBody');

        var enclosing = document.createElement('tr');

        for (var i = 0; i < $scope.posts.length; i++) {
          var post = $scope.posts[i];
          var row = document.createElement('tr');
          var streetNode = document.createElement('td');
          streetNode.innerHTML = post['address'];
          var nameNode = document.createElement('td');
          nameNode.innerHTML = post['fullName'];
	  var endNode = document.createElement('td');
          endNode.innerHTML = post['endDate'];
          row.appendChild(nameNode);
          row.appendChild(streetNode);
          row.appendChild(endNode);

          bodyNode.appendChild(row);

        }

        $('#modal1').modal('toggle');

      }, function() {

      });
    };

});
