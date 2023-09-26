package com.home.ormjpa.commands;

import jakarta.servlet.http.HttpServletRequest;

public interface Command {

    String execute(HttpServletRequest request);
}
