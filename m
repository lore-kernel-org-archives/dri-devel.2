Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DF2C9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD84E10F22A;
	Wed, 23 Sep 2026 22:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FalIwamI";
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE80010F217
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:45 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-6b34face6d0so185996eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202945; x=1790807745; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YFfpY9RKNpyGZptjFUYIPxK+/JHfBQcKAOCTZ1dhBB8=;
 b=FalIwamIVXx+uC/MrKB2rClWvGz3WvxXnyHGAKGhGwJ+1e23oEi0m1UoaOt5Qzfayi
 4n/B4iSxWfuLPp5VEuj5GlsUq0Q4FUVHYLkZzJs95cKjAeUFolOeflhhdnm8Oaj1r75f
 +lziPQHUaViu8lVkHbRQd2GmfWLFbyMSLHPOxoQ/eHCGrfG4nEqsyimvVYM0rZsC1Ax/
 FeMtcMt+HMQ6MdU/iN8i7NU7JEe04woz9Kmb7TrXTRwgKJeE8ZZzQPkmRX2sXPOcnCGn
 E/BK+dyCFc4IX3xUOmC6Eikn4tDPgGSFrD3oRLr9ehWwKIOKs7UMf249sxG3W7FPo+g7
 n/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202945; x=1790807745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YFfpY9RKNpyGZptjFUYIPxK+/JHfBQcKAOCTZ1dhBB8=;
 b=WiQbh8+MMDYhOWcxgxYm1+cbMpSXvOlkmxVSZh4ySRqSk/g7ABQ/FnbA5i7jzdlmbX
 F5ljK84uJI96/X8wYHisTxYXqnSnhfVzI3gF6KyeqX+oT/8IvzFzieyE11HzZiX0YnLe
 rxPynEi/Ne3hKlDzRf4rPdKapyCazkYn3eU8kPGdr6B6OIGdQrxAF5wLgnT8jMq8a9Na
 bGFiuR5R/4vnm32icO/DxFJZ5b1xU+bRv3PgdoXTVQQFIuoWfO/ILct1eK5JCj7P3lLt
 hnzHofihXVKQreAM7Ra5z4z4xRVWhOs0RFKL9C5rB+mVcX8+aqej6kcXcMBTcmyZnJ3o
 1gxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIxcE9zqgiGoSmOZVT8+E6XA0iB+YUa/2iIRAOBw8A+Du0gRW1/2Ywfb2XruCXGj329r+INdJQyiM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kjx/87HUJ8Go/x3OdFYiBZswqbUpaqReW+irU1GUszmL9qbGvZ
 g9xp3ToPdkSlqQlpSu2gG2pkd9bQ1MwHfeSt4sMdt/GqVmgyJfCrE7NO
X-Gm-Gg: AYBFou2esdsD9O3+RbWdpG9c3IkkBgO4mpORaRkSiF789gycp40BgnafrfSNP0auTHj
 ZuYkuyNMNttUb02ZNXWarSQO69MOaftf34yf0i5iH3QypJkitXYz76e/IJPi9sPKIg3LYL7PmrS
 TlxFfpWPyqxEvM0xNbL0xHdHm6WGFROWqTL9M7jMHbf4w0WJZDxYJHoSLAk3es64iHDad533h/z
 Cc7NV0199muz9TktIMhIhzknUSb9k53nA5nnd3ktEfKWH4rxIoEM6pO7sONFd1KsVSNJAW6OLuR
 X8lkV+I151wk4IOj0PnJXMKRSVtO4uuO+QOAUF5TxLwFt4woviyKS4L5qmPztCZ7M/xhQZee+9u
 HG4Og6xmYNpftvbiYKPFGHIdlTqQpQPBKs4whRHYUZCnnoqCZzuZY5ZWw1RY+5mEa2aU/G4uuL1
 xKvfSpFdG4mg7Qy/msUjT75BMboxEmRUqLPcuPjS1rkNOzLnfiWpM1rLdJG5nb/XI4r5kGGK+Z6
 qd8PHIF+otyixrzSM25MPhqnz3cm3IPqmA40ICHHLnu6Y1BinUGXIlmiNoCPVYVK7aX4M3cRyXV
 G05ZSUuo8fgw/tqhn0rC
X-Received: by 2002:a05:6820:4b97:b0:6b5:ec2f:3568 with SMTP id
 006d021491bc7-6d43f4baf36mr568755eaf.25.1790202945099; 
 Wed, 23 Sep 2026 15:35:45 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:53 -0600
Subject: [PATCH v11 29/38] dyndbg: control-parser: treat comma as a token
 separator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-29-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=4314;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=BFGfVMUIUlRIm2JaJRLPto2g8rjGdT6CEXAVSmQr/a8=;
 b=d5+MQwqqnsKPmHlPuUCttE4PkQ7Wy7yoFwYejLCbxsCnQG3UvsatUX9GpXn09cb+z3WKXqaaR
 HvFmmuDzGv7B8sMzShv1xHHeYfmjW7kSdoSPA1xOTIEEw9Xy5PFUlUu
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

Treat comma as a token terminator, just like a space. This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

Add corresponding Strategy 2 control-file fingerprinting checks to
verify the exact control-file state of kernel/params callsites after
commas-as-spaces, ignored-commas, and quoted-commas queries.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst       |  4 +++-
 lib/dynamic_debug.c                                     | 17 +++++++++++++----
 .../testing/selftests/dynamic_debug/dyndbg_selftest.sh  |  4 ++--
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9c2f096ed1d8..b9fbb2a12955 100644
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
@@ -172,6 +173,7 @@ module
 	module sunrpc
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
+	module,sunrpc	# with ',' as token separator
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8eef2e7387a9..6482fd28def4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -323,6 +323,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
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
@@ -336,8 +344,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -353,7 +361,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -628,7 +636,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 6f1d11828b79..a357905e3606 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -537,8 +537,8 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
-#K= 2b4b152bdb82e6e4a5be18ca26025895 FT_test_classes.1
-#K= 5516e3d13cba7ea4197a7fb6c033887a FT_test_classes.2
+#K= 91838b4012c50a1dc1d9e210ba8d68f8 FT_test_classes.1
+#K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
 #K= 2cee6842c9cdee5cb3bf50b2e3914813 FT_test_classes.3
 #K= 81b16613f8d444485e2bc5aa4d38d024 FT_classmap_inheritance.1
 #K= c14c8aa758e24046b3237d20e2189bf7 FT_classmap_inheritance.2

-- 
2.55.0

