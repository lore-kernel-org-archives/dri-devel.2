Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AB7C982D0
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD8710EC81;
	Wed, 16 Sep 2026 15:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mErAqwQ9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3547010E3CF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:33:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DD20043E30;
 Wed, 16 Sep 2026 15:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBF7FC2BCC7;
 Wed, 16 Sep 2026 15:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789572782;
 bh=9rDKS7sHJtsb0Bx6Y5Jcawy/ppk1uKvlwlGnLM9zpRk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=mErAqwQ9xGkbfa+0iu8Ncu3x5XA4/bZCC9flFu1ekP5T2Xygqcrzy5oGQa498xqSo
 6/MjlwG5DhycvydpApm4oPYAPnI8SKGsr5iNOH5BwDRo7y43x+9sqY3Kgk27GDj+vN
 j8xsMJUH6U4+5ACNP381qRoIPAx3proPY785jcKpPzrTmty1+S+I9qDBi8KhPH+vWl
 iieaqVxqwNQH7f3NIa5TwjNRO0cYJPwUJxbJGbsFEvKy1UwnpfdceCNzMNZbX11oXV
 eVWEIea8wK2nii4FBQAw7glrIPZ9DJk8RyyWulWJDhrEkT9mMY+zYU9CYPxamQSpur
 X864+QKwjQKAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A92F8C982C3;
 Wed, 16 Sep 2026 15:33:02 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Wed, 16 Sep 2026 09:33:21 -0600
Subject: [PATCH v10 29/38] dyndbg: control-parser: treat comma as a token
 separator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-dd-cmap-part2-clean-v10-29-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
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
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789572777; l=4314;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZrDeIcpsLRk/IxP797PogO5syy10nLdePZS+aXPsHJY=;
 b=GB4bsD2HatYcvN0T3z+I9+kLJpIBpn05xlf9MnaBSAgf6+dfC1nEFUw6wpW8Aa3GIrOiPOFgT
 MCJY5DQZWhjDM33VBjQGivsYj/HMtGw2qeA2DJJ2B8Zg9q0svgRKM7P
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
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
Reply-To: jim.cromie@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jim Cromie <jim.cromie@gmail.com>

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
index 2347d13e1d30..0720fc4f7a90 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -322,6 +322,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
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
@@ -335,8 +343,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -352,7 +360,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -627,7 +635,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 8d3f1e49e9e1..d485b9245164 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -544,8 +544,8 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
-#K= 69f1958beef98211d4181f9ded9787c4 FT_test_classes.1
-#K= 5516e3d13cba7ea4197a7fb6c033887a FT_test_classes.2
+#K= 8f18ea82c09460434b6e9e4cd12543e8 FT_test_classes.1
+#K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
 #K= 20d4545f9753e677e72e3adf52527fd3 FT_test_classes.3
 #K= 934d8677872fe26bd636a6c3d6416aa2 FT_classmap_inheritance.1
 #K= cd1389958807063baa1ea4b06c61fa02 FT_classmap_inheritance.2

-- 
2.55.0


