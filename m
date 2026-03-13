Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC21105F7AF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107F510EC0B;
	Fri, 13 Mar 2026 13:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yy/QNenN";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4BB10EC0B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:56 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-46708149af2so1223422b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408236; x=1774013036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLJ6/kh9zV3xnzIvFpZnDpL3mZ5cCxT808iTivJti0s=;
 b=Yy/QNenNDnw4PYnk3Xybt51oWUzkpoDPlcd2IEdm4Vgj4KPpT3OYpjRRXJQ1iYB6MN
 SEwu348LRBeoG8nUqsY2JvhSrbj5t0i/frgPnrbx3G6iqGEpjY/C3RlE/dQcXvJYuD2o
 z2/HHYWr4TlCY7Ng32HVr1GByMCrhd2v1hVbYa+LFeiKvjBMDcuJ/VhRbIHroSVzbi/e
 5vQuHPiI8/fu+tAfGymgGT4P1+GTukvuPtJ37PJVVAvz5QD6+dIiqEn8b+fszdK/M0xc
 rKhh2Xx9FCt0mao7ha8SbLbH1Q4oWljlGRH0Mjy/4dp2LjXiKB1wo+8hMeosNHbvbrj8
 Adqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408236; x=1774013036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fLJ6/kh9zV3xnzIvFpZnDpL3mZ5cCxT808iTivJti0s=;
 b=EhdV9+WydChVhbBMxxIMhRZQacQd/az39L+leVgyssLd9Zp5RxsTSmregtcPn7AzqU
 BOK8inpZiCTvZpKtPctEpSH2EbLa+4+MsKUDHkWvy9Vntwd9GuO9zl5IQSDbeiKU6nKO
 gZySxqxZTZdfChhwdZqdGcejDnF0I9r2TI5XsIaGNRUsNwft7U/okjYmhu/AqMnD8nkB
 n+nPr/ukVHA7Cc9TiiwY13zt5KC7zUPGHQJuIooLpwam7yWLJhiXw94ImO3yHNMd9T+U
 XTXmCQi/gROtfuhgq51vqnyp1w9ZPJx3obztptJGvffDJmUUtOuoDUfiqC3/aTR27Q8X
 8Y7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTtzyNrQ2PQXPxiQ0xCry04gSbguy4KuaGwar+ZvMPzvQapNIHefkaluIRSGMXBDPxo5zHBXbRlx4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxe/o5GOfupYeXNj3jF+2mw+nSQD8ljhUrcbEO9f0PM1PLwWlM/
 1OjPgS3OivjEBBcXPNYYCsQB5X4yDQLfcsBUEa7bPR/sv8kkWQ//8vGa
X-Gm-Gg: ATEYQzx5RZG0XWkldHrAzWFlAzizADvcBuZ0ninqqRaC4wZC4FeDTUijd/6vMJF3HNz
 Hsn8gRSuXWt77NWtG1H8n5WK+0gJxM6yrIx8Mcu706HGTrMwmmWEkpDYaXVDcch5M7EOgxMc227
 VeK0dbRx3D6Xcy3P7A99vxPGTWWpsEUNAf+w0vPIEy7cSia4x4MiOIXXSLktjbG85Ugg2isrrId
 3rbFwEuwbPK4Y5keEfOTQMGOpx64SjhhHE2DEKyePp+MEHHaygPk7S8OqLe7Yp0qtO+Kb1ALg7C
 /2bBUXJy72vGoNwwEXLFVzA6t1QVvTA5TnnPsliqeKqBA83xN5FvrjnggNK4CSzeWcz/YdMUYVO
 4EO1eIHvvCkcVVVJuY0T5GakIXBDlt9wKP91b7O9+cf6gMlwSUe8CaFINBNksenlpK3807Tahq3
 Dz3hWhv2/XOfIt9C80zF7L4WzD4bq0N53wuuv+bBwN0mY+H1Wi
X-Received: by 2002:a05:6808:19aa:b0:467:284:b3cb with SMTP id
 5614622812f47-4675701cd1dmr1819155b6e.2.1773408235774; 
 Fri, 13 Mar 2026 06:23:55 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jim Cromie <jim.cromie@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 pmladek@suse.com, ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 27/65] dyndbg: treat comma as a token separator
Date: Fri, 13 Mar 2026 07:19:52 -0600
Message-ID: <20260313132103.2529746-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

 drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the many ways a boot-line +args can be assembled and then passed
in/down/around shell based tools, this may allow side-stepping all
sorts of quoting hassles thru those layers.

existing query format:

 modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

new format:

 modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

ALSO

selftests-dyndbg: add comma_terminator_tests

New fn validates parsing and effect of queries using combinations of
commas and spaces to delimit the tokens.

It manipulates pr-debugs in builtin module/params, so might have deps
I havent foreseen on odd configurations.

Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  9 +++++---
 lib/dynamic_debug.c                           | 17 +++++++++++----
 .../dynamic_debug/dyndbg_selftest.sh          | 21 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9c2f096ed1d8..dbf901150587 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -78,11 +78,12 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
 Command submissions are bounded by a write() system call.
 Multiple commands can be written together, separated by ``;`` or ``\n``::
@@ -167,9 +168,11 @@ module
     The given string is compared against the module name
     of each callsite.  The module name is the string as
     seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
+    suffix and with ``-`` changed to ``_``.
 
-	module sunrpc
+    Examples::
+
+	module,sunrpc	# with ',' as token separator
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e383e93dc784..a77c6e9ff90c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -320,6 +320,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	return nfound;
 }
 
+static char *skip_spaces_and_commas(const char *str)
+{
+	str = skip_spaces(str);
+	while (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -333,8 +341,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -350,7 +358,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -622,7 +630,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 465fad3f392c..c7bf521f36ee 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -216,7 +216,7 @@ function check_err_msg() {
 function basic_tests {
     echo -e "${GREEN}# BASIC_TESTS ${NC}"
     if [ $LACK_DD_BUILTIN -eq 1 ]; then
-	echo "SKIP"
+	echo "SKIP - test requires params, which is a builtin module"
 	return
     fi
     ddcmd =_ # zero everything
@@ -238,8 +238,27 @@ EOF
     ddcmd =_
 }
 
+function comma_terminator_tests {
+    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP - test requires params, which is a builtin module"
+	return
+    fi
+    # try combos of spaces & commas
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module,params,=_		# commas as spaces
+    ddcmd module,params,+mpf		# turn on module's pr-debugs
+    check_match_ct =pmf 4
+    ddcmd ,module ,, ,  params, -p
+    check_match_ct =mf 4
+    ddcmd " , module ,,, ,  params, -m"	#
+    check_match_ct =f 4
+    ddcmd =_
+}
+
 tests_list=(
     basic_tests
+    comma_terminator_tests
 )
 
 # Run tests
-- 
2.53.0

