#!/bin/bash

function add_to_gitignore {
    echo "###" >> $1
    echo "# Automatinc added files from WP Plugin Devops" >> $1
    echo "###" >> $1
    echo "composer.lock" >> $1
    echo "test" >> $1
    echo "webserver" >> $1
    echo "vendor" >> $1
    echo "wordpress" >> $1
}

GITIGNORE_FILE="${PLUGIN_PATH}/.gitignore"

if [ -e $GITIGNORE_FILE ]; then
    read -p ".gitignore file exists would you like to add not necessary files to it (y/n): " add_gitignore

    if [ "y" = $add_gitignore ]; then
        add_to_gitignore $GITIGNORE_FILE
    elif [ "n" = $add_gitignore ]; then
        echo "No files added to .gitignore."
    else
        echo "Please answer with (y) or (n). Installation interrupted."
        exit 1;
    fi
else
    read -p ".gitignore file not found. Would you like to create one and add not necessary files to it (y/n): " add_gitignore

    if [ "y" = $add_gitignore ]; then
        add_to_gitignore $GITIGNORE_FILE
    elif [ "n" = $add_gitignore ]; then
        echo "No files added to .gitignore."
    else
        echo "Please answer with (y) or (n). Installation interrupted."
        exit 1;
    fi
fi

read -p "Create a main plugin file? (y/n) " add_plugin_file

if [ "y" = $add_plugin_file ]; then
    cp ${DEVOPS_PATH}/plugin.php ${PLUGIN_PATH}/plugin.php
    echo "plugin.php added."
elif [ "n" = $add_plugin_file ]; then
    echo "No Plugin file added."
else
    echo "Please answer with (y) or (n). Installation interrupted."
    exit 1;
fi

TEST_PATH=${PLUGIN_PATH}/tests

read -p "Create test files for PHPUnit? (y/n) " add_test_files

if [ "y" = $add_test_files ]; then
    mkdir -p $TEST_PATH
    cp -R ${DEVOPS_PATH}/phpunit.xml ${PLUGIN_PATH}/phpunit.xml
    cp -R ${DEVOPS_PATH}/tests/phpunit/. $TEST_PATH/phpunit/
    echo "PHPUnit est files added."
elif [ "n" = $add_test_files ]; then
    echo "No test files added."
else
    echo "Please answer with (y) or (n). Installation interrupted."
    exit 1;
fi

read -p "Create test files for behat? (y/n) " add_test_files

if [ "y" = $add_test_files ]; then
    mkdir -p $TEST_PATH
    cp -R ${DEVOPS_PATH}/behat.yml ${PLUGIN_PATH}/behat.yml
    cp -R ${DEVOPS_PATH}/tests/behat/. $TEST_PATH/behat/
    echo "behat test files added."
elif [ "n" = $add_test_files ]; then
    echo "No test files added."
else
    echo "Please answer with (y) or (n). Installation interrupted."
    exit 1;
fi

TRAVIS_FILE=${PLUGIN_PATH}/.travis.yml

read -p "Create a travis file? (y/n) " add_travis_files

if [ "y" = $add_travis_files ]; then
    cp -R ${DEVOPS_PATH}/.travis.yml ${PLUGIN_PATH}/.travis.yml
    echo "Test files added."
elif [ "n" = $add_travis_files ]; then
    echo "No test files added."
else
    echo "Please answer with (y) or (n). Installation interrupted."
    exit 1;
fi

read -p "Create a docker compose? (y/n) " add_docker_compose_file

if [ "y" = $add_docker_compose_file ]; then
    sed 's/.\/bin\/docker\/nginx\/default.conf/.\/vendor\/awsmug\/wp-plugin-devops\/bin\/docker\/nginx\/default.conf/' ${DEVOPS_PATH}/docker-compose.yml.dist > ${DOCKER_COMPOSE_FILE}
    echo "Compose files added."
elif [ "n" = $add_docker_compose_file ]; then
    echo "No compose files added."
else
    echo "Please answer with (y) or (n). Installation interrupted."
    exit 1;
fi