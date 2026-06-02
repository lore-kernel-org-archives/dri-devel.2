Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AE8CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E7710F65D;
	Tue,  2 Jun 2026 22:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K0A7Y20L";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72C610F663
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:49:14 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso67089295e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440553; x=1781045353; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IygGhm9kuf41mq4yQ0C6MVtWUwR88txz1bUI5vUU+BQ=;
 b=K0A7Y20LMUwTuiy6DRA2KHCtJJb6xbTK2jG/wpLeNEHzcMBlojnSd7EI/TgvBZiDr0
 Gosu5QaOJC1kj9V/0WOS/frBQlOJn+h2MseeK+h9PYEtnFOBED+z/p/zwAnmHG3nirmQ
 msrDImnXS03JF4HTm5mz/n6Wlz9bvUkANV5gWyxF8y0VxBMQqKDA26wpTSjrilvExRGr
 CwPE9G8pjXRKiNXFW7blp8pAw2ic0NJAux8DfgaJ3oHt38NYyR3hWjSW7tZHoMPot/BI
 vRVHRz92pV2SpskhviyCR6b9el3Kk86gA74DGC6J6MnXLjU3uvjv/S293kOjQxB8ivNy
 42Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440553; x=1781045353;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IygGhm9kuf41mq4yQ0C6MVtWUwR88txz1bUI5vUU+BQ=;
 b=F5veaxf8mF34vDzcY6u3BY3NE5b16JE8KAHQUNyP1beion+9PxEMLtTcG+6HOmG857
 xZJiVYXLcJNxDGK26UveslA7Y4alWb4MBbYCDALxW9GIfgSDkp6URyFowTwV48TiZx8l
 At2d7K/kVjMs2HXlOoUPRh2S1jUDlwOSwWmf9k1t+JlxCqP7P/Kqg7fAevhLieL0r5Eq
 /88cNFM2e1NZw1vSf2ytP871e/avw3vJMpbF7MYkiqeyqgXhSkNQ9v9Or2EdJgHtdinW
 bUAv0+ibbkBsJscmGIO3uwaAx1kI9yTtJDAfFhnJU2zL2pMR3uUrzGRJ7FDINbjzDWwl
 qAMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9NQHjzEonWM8V+MwetPBlOmZi/DpUjjpsviABaMkfENu7/a3YM+RDKpVwuJ6iFoMAZJtE8gtZF50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxzC3vuxLMSMLTZ1bmyfclkLIR0ve77AR0lDnObE7LuLiB2sDX
 qtbT8QaonfUAj/9kXOeJH/qu+v7U/h1V6AbHZ9mCBFGktl0Tpa2vxeMl
X-Gm-Gg: Acq92OHy6aZXuePkKIsLKhZmWkX9gX8F1cHcJK3jCyN2YIDQzBqOWTd9lsPjhtxetGw
 YSQqK51GMO8XOE5GdGuDvRnS2JeoHRz0yHZg0r+XIqHJu75n5rc2rb0EYwgjILgF510+qM1X8Ba
 vPQ2K44B9neOiNXOvNCO87LaIhZbOlbW+vfIKEOCNuwBZ9vGID3PXXfTixI8Y5WPESgSUiFnTSI
 hwPzG3ZkaJqRQVrgMBbDmeTJaw5u9Vt2s6uoKwbreL/iR9YGw+wUI+CiisiCrfekffuuvEI6VqD
 IrRCZi7dUzbc0Knq915eR5SB4hwOFACm2ZKVtIYjWIHMDVgsW1VQJ6GYIJNvmzhQwCVZ4Nvm0TN
 KW0I6lVyQTE35FGbsLXD4p4fEKIncTep8ptvVkFsElQUnLYxBlQkG8VoMhBVpEuYMync+/hrvbL
 o+vLOFbMHgvZZILRUvdCivMGmnDBwoqOnVV0tM8HyyEgsVTmtuiF3w
X-Received: by 2002:a05:600c:3150:b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-490b60de830mr11022245e9.18.1780440553275; 
 Tue, 02 Jun 2026 15:49:13 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:49:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:19 +0000
Subject: [PATCH v4 22/25] selftests-dyndbg: add a dynamic_debug run_tests
 target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-dd-maint-2-v4-22-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=13257;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=lZo1ZwCzw1HsSSPAASSDUG29+dnu3/idhHrKphEKq70=;
 b=DmnkSXiB0uqHymu5fqWRAi4RCcgYvoJN+rpT74y9XcfhBkPGQZ+mFR1oe1wbAwpPcRhKUTSdX
 AxqYc3XQ1byCnnVa9TKQv4Q7gx1rh+3/TlBNLg3DySrs4cgjPltjoQs
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add a selftest script for dynamic-debug.  The config requires
CONFIG_TEST_DYNAMIC_DEBUG=m and CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m,
which tacitly requires either CONFIG_DYNAMIC_DEBUG=y or
CONFIG_DYNAMIC_DEBUG_CORE=y

ATM this has just basic_tests(), which modify pr_debug() flags in the
builtin params module.  This means they're available to manipulate and
observe the effects in "cat control".

This is backported from another feature branch; the support-fns (thx
Lukas) have unused features at the moment, they'll get used shortly.

The script enables simple virtme-ng testing:

   [jimc@gandalf b0-ftrace]$ vrun_t
   virtme-ng 1.32+115.g07b109d
   doing: vng --name v6.14-rc4-60-gd5f48427de0c \
	  --user root -v -p 4 -a dynamic_debug.verbose=3 V=1 \
	  -- ../tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
   virtme: waiting for virtiofsd to start
   ..

And add dynamic_debug to TARGETS, so `make run_tests` sees it properly.
For the impatient, set TARGETS explicitly:

  [root@v6 selftests]# make TARGETS=dynamic_debug run_tests
  make[1]: Nothing to be done for 'all'.
  TAP version 13
  1..1
  # timeout set to 45
  # selftests: dynamic_debug: dyndbg_selftest.sh
  # # BASIC_TESTS    95.422122] dyndbg: query 0: 0"=_" mod:*
  ...

NOTES

check KCONFIG_CONFIG to avoid silly fails.  Several tests are
dependent upon config choices. Lets avoid failing where that is noise.

The KCONFIG_CONFIG var exists to convey the config-file around.  If
the var names a file, read it and extract the relevant CONFIG items,
and use them to skip the dependent tests, thus avoiding the fails that
would follow, and the disruption to whatever CI is running these
selftests.

If the envar doesn't name a config-file, ".config" is assumed.

CONFIG_DYNAMIC_DEBUG=y:

basic-tests() and comma-terminator-tests() test for the presence of
the builtin pr_debugs in module/main.c, which I deemed stable and
therefore safe to count.  That said, the test fails if only
CONFIG_DYNAMIC_DEBUG_CORE=y is set.  It could be rewritten to test
against test-dynamic-debug.ko, but that just trades one config
dependence for another.

Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v4: squash down a few missing "" quotes around $vars
v3: use ksft_* exit codes

v2:
drop commit-msg mention of yet-to-be-submitted tests
move RvB after SoB

script fixups per sashiko review

   1. CONFIG_DYNAMIC_DEBUG=y is set correctly.
   2. All subshell captures $( ( ... ) 2>&1 ) are fixed.
   3. All echo variables are safely quoted to prevent word-splitting.
   4. Standardized on modern /sys/kernel/tracing/ paths.
   5. exit $exp_exit_code correctly propagates failure status.

fixup-quoting-selftest
---
 MAINTAINERS                                        |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 258 +++++++++++++++++++++
 5 files changed, 277 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cf80e7ac039..b3d41824220a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9087,6 +9087,7 @@ F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
+F:	tools/testing/selftests/dynamic_debug/*
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e41..17c4ddbcee89 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -27,6 +27,7 @@ TARGETS += drivers/net/team
 TARGETS += drivers/net/virtio_net
 TARGETS += drivers/platform/x86/intel/ifs
 TARGETS += dt
+TARGETS += dynamic_debug
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += fchmodat2
diff --git a/tools/testing/selftests/dynamic_debug/Makefile b/tools/testing/selftests/dynamic_debug/Makefile
new file mode 100644
index 000000000000..6d06fa7f1040
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# borrowed from Makefile for user memory selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := dyndbg_selftest.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dynamic_debug/config b/tools/testing/selftests/dynamic_debug/config
new file mode 100644
index 000000000000..ec478b17873d
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/config
@@ -0,0 +1,8 @@
+
+# basic tests ref the builtin params module
+CONFIG_DYNAMIC_DEBUG=y
+
+# more testing is possible with these,
+# but insisting on them here skips testing entirely for such configs
+# CONFIG_TEST_DYNAMIC_DEBUG=m
+# CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
new file mode 100755
index 000000000000..1239f1e10591
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -0,0 +1,258 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+V=${V:=0}  # invoke as V=1 $0  for global verbose
+RED="\033[0;31m"
+GREEN="\033[0;32m"
+YELLOW="\033[0;33m"
+BLUE="\033[0;34m"
+MAGENTA="\033[0;35m"
+CYAN="\033[0;36m"
+NC="\033[0;0m"
+error_msg=""
+
+# Standard kselftest exit codes
+ksft_pass=0
+ksft_fail=1
+ksft_skip=4
+
+[ -e /proc/dynamic_debug/control ] || {
+    echo -e "${RED}: this test requires CONFIG_DYNAMIC_DEBUG=y ${NC}"
+    exit $ksft_skip # nothing to test here, no good reason to fail.
+}
+
+# need info to avoid failures due to untestable configs
+
+[ -f "$KCONFIG_CONFIG" ] || KCONFIG_CONFIG=".config"
+if [ -f "$KCONFIG_CONFIG" ]; then
+    echo "# consulting KCONFIG_CONFIG: $KCONFIG_CONFIG"
+    grep -q "CONFIG_DYNAMIC_DEBUG=y" $KCONFIG_CONFIG ; LACK_DD_BUILTIN=$?
+    grep -q "CONFIG_TEST_DYNAMIC_DEBUG=m" $KCONFIG_CONFIG ; LACK_TMOD=$?
+else
+    # if no config, try runtime probes
+    modprobe -n test_dynamic_debug 2>/dev/null ; LACK_TMOD=$?
+    # assume builtin dyndbg if control exists (checked above)
+    LACK_DD_BUILTIN=0
+fi
+
+function vx () {
+    echo "$1" > /sys/module/dynamic_debug/parameters/verbose
+}
+
+function ddgrep () {
+    grep "$1" /proc/dynamic_debug/control
+}
+
+function doprints () {
+    cat /sys/module/test_dynamic_debug/parameters/do_prints
+}
+
+function ddcmd () {
+    exp_exit_code=0
+    num_args=$#
+    if [ "${@:$#}" = "pass" ]; then
+	num_args=$#-1
+    elif [ "${@:$#}" = "fail" ]; then
+        num_args=$#-1
+	exp_exit_code=1
+    fi
+    args=${@:1:$num_args}
+    output=$( (echo "$args" > /proc/dynamic_debug/control) 2>&1)
+    exit_code=$?
+    error_msg=$(echo "$output" | cut -d ":" -f 5 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function handle_exit_code() {
+    local exp_exit_code=0
+    [ $# == 4 ] && exp_exit_code=$4
+    if [ "$3" -ne $exp_exit_code ]; then
+        echo -e "${RED}: $BASH_SOURCE:$1 $2() expected to exit with code $exp_exit_code, got $3"
+	[ "$3" == 1 ] && echo "Error: '$error_msg'"
+        exit $ksft_fail
+    fi
+}
+
+# $1 - pattern to match, pattern in $1 is enclosed by spaces for a match ""\s$1\s"
+# $2 - number of times the pattern passed in $1 is expected to match
+# $3 - optional can be set either to "-r" or "-v"
+#       "-r" means relaxed matching in this case pattern provided in $1 is passed
+#       as is without enclosing it with spaces
+#       "-v" prints matching lines
+# $4 - optional when $3 is set to "-r" then $4 can be used to pass "-v"
+function check_match_ct {
+    pattern="\s$1\s"
+    exp_cnt=0
+
+    [ "$3" == "-r" ] && pattern="$1"
+    let cnt=$(ddgrep "$pattern" | wc -l)
+    if [ "$V" -eq 1 ] || [ "$3" == "-v" ] || [ "$4" == "-v" ]; then
+        echo -ne "${BLUE}" && ddgrep "$pattern" && echo -ne "${NC}"
+    fi
+    [ $# -gt 1 ] && exp_cnt=$2
+    if [ $cnt -ne $exp_cnt ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO check failed expected $exp_cnt on $1, got $cnt"
+        exit $ksft_fail
+    else
+        echo ": $cnt matches on $1"
+    fi
+}
+
+# $1 - trace instance name
+# #2 - if > 0 then directory is expected to exist, if <= 0 then otherwise
+# $3 - "-v" for verbose
+function check_trace_instance_dir {
+    if [ -e /sys/kernel/tracing/instances/$1 ]; then
+        if [ "$3" == "-v" ] ; then
+            echo "ls -l /sys/kernel/tracing/instances/$1: "
+            ls -l /sys/kernel/tracing/instances/$1
+        fi
+	if [ "$2" -le 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does exist"
+	    exit $ksft_fail
+	fi
+    else
+	if [ "$2" -gt 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does not exist"
+	    exit $ksft_fail
+        fi
+    fi
+}
+
+function tmark {
+    echo $* > /sys/kernel/tracing/trace_marker
+}
+
+# $1 - trace instance name
+# $2 - line number
+# $3 - if > 0 then the instance is expected to be opened, otherwise
+# the instance is expected to be closed
+function check_trace_instance {
+    output=$(tail -n9 /proc/dynamic_debug/control | grep ": Opened trace instances" \
+	    | xargs -n1 | grep $1)
+    if [ "$output" != "$1" ] && [ $3 -gt 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not opened"
+        exit $ksft_fail
+    fi
+    if [ "$output" == "$1" ] && [ $3 -le 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not closed"
+        exit $ksft_fail
+    fi
+}
+
+function is_trace_instance_opened {
+    check_trace_instance "$1" $BASH_LINENO 1
+}
+
+function is_trace_instance_closed {
+    check_trace_instance "$1" $BASH_LINENO 0
+}
+
+# $1 - trace instance directory to delete
+# $2 - if > 0 then directory is expected to be deleted successfully, if <= 0 then otherwise
+function del_trace_instance_dir() {
+    exp_exit_code=1
+    [ "$2" -gt 0 ] && exp_exit_code=0
+    output=$( (rmdir /sys/kernel/tracing/instances/$1) 2>&1)
+    exit_code=$?
+    error_msg=$(echo "$output" | cut -d ":" -f 3 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function error_log_ref {
+    # to show what I got
+    : echo "# error-log-ref: $1"
+    : echo cat \$2
+}
+
+function ifrmmod {
+    lsmod | grep "$1" 2>&1>/dev/null && rmmod $1
+}
+
+# $1 - text to search for
+function search_trace() {
+    search_trace_name 0 1 "$1"
+}
+
+# $1 - trace instance name, 0 for global event trace
+# $2 - line number counting from the bottom
+# $3 - text to search for
+function search_trace_name() {
+	if [ "$1" = "0" ]; then
+	    buf=$(cat /sys/kernel/tracing/trace)
+	    line=$(tail -$2 /sys/kernel/tracing/trace | head -1 | sed -e 's/^[[:space:]]*//')
+	else
+	    buf=$(cat /sys/kernel/tracing/instances/$1/trace)
+	    line=$(tail -$2 /sys/kernel/tracing/instances/$1/trace | head -1 | \
+		   sed -e 's/^[[:space:]]*//')
+	fi
+	if [ "$2" = 0 ]; then
+	    # whole-buf check
+	    output=$(echo "$buf" | grep "$3")
+	else
+	    output=$(echo "$line" | grep "$3")
+	fi
+	if [ "$output" = "" ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO search for '$3' failed \
+		    in line '$line' or '$buf'"
+	    exit $ksft_fail
+	fi
+	if [ "$V" = 1 ]; then
+	    echo -e "${MAGENTA}: search_trace_name in $1 found: \n$output \nin:${BLUE} $buf ${NC}"
+        fi
+}
+
+# $1 - error message to check
+function check_err_msg() {
+    if [ "$error_msg" != "$1" ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error message '$error_msg' \
+		does not match with '$1'"
+        exit $ksft_fail
+    fi
+}
+
+function basic_tests {
+    echo -e "${GREEN}# BASIC_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP"
+	exit $ksft_skip
+    fi
+    ddcmd =_ # zero everything
+    check_match_ct =p 0
+
+    # module params are builtin to handle boot args
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module params +mpf
+    check_match_ct =pmf 4
+
+    # multi-cmd input, newline separated, with embedded comments
+    cat <<"EOF" > /proc/dynamic_debug/control
+      module params =_				# clear params
+      module params +mf				# set flags
+      module params func parse_args +sl		# other flags
+EOF
+    check_match_ct =mf 3
+    check_match_ct =mfsl 1
+    ddcmd =_
+}
+
+tests_list=(
+    basic_tests
+)
+
+# Run tests
+
+ifrmmod test_dynamic_debug
+
+for test in "${tests_list[@]}"
+do
+    $test
+    echo ""
+done
+echo -en "${GREEN}# Done on: "
+date
+echo -en "${NC}"
+
+exit $ksft_pass

-- 
2.54.0

