Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAE6C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F5A10F20D;
	Wed, 23 Sep 2026 22:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NkRnPw9r";
	dkim-atps=neutral
Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com
 [74.125.231.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBB610F1F7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:11 +0000 (UTC)
Received: by mail-oo2-f41.google.com with SMTP id
 006d021491bc7-6b1ae7166edso823816eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202911; x=1790807711; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iEU8DzU4LKP6MP5zfWJjBY2eD90eHdHMK7FISxZUBG0=;
 b=NkRnPw9r8GjryMZv2z1rAMif6V+B78jENvqneaYgrbkkq47Qd3ItwTgkzIGG4IX9XF
 pn/4+ntmL3hJIuP/GWoMLxD+WphDiYB5smwInacNbozneoGHwwzVuoGoQNT17EoeHpJH
 fwQmp3I7k9B75E1xeMX2vKkBivNGHPm87mS4s/WNcoVkdnSV+U7XlfQ7JYzqtQS7BaDS
 n/B0mFhSFNd+uIBAj4AaHvHQQqCmsOi9lIWqQuqbxIWtuWzGrna76WkBPf5gYeE054XJ
 VdV0AfRWG7N5ISGwR193QBkuOFonqPjSAR5K5KufLsdvARnjhDbu3L4kQl94HW88IuXz
 HL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202911; x=1790807711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iEU8DzU4LKP6MP5zfWJjBY2eD90eHdHMK7FISxZUBG0=;
 b=WU7h/vXBsiSeaA5XJ0MXal4gwVoIAomM+2hb04iyltW3hDwZV+8cy4Y+wpcvftA7BQ
 bXLNX6O4kMlS+oNzaGJtsK+uRUj33e1RfTJb+ZnguNRUHUCU1OS8rWgEKCk6fW9B9Z2A
 bAVTd5mLW+Tf+DPnHEFo/Zhu2YMirOReOR0mt2dmWAZu5AIf9Dneh8w+IUg3Q8zjG0Rv
 I5w5lvz6LbTbC8Kb4oQ8C870xbHVzdLGFJFLgSTAEmP6YgjkxNZgZd90SidqkUPB7lVj
 tvrK/9wn85ooNwcSv1RiaasZtNBqpDCVhR2krFzUKF/20ymTfOD3IGgYnemQ96PlZN5U
 9FVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxLxKGHMeVBxi9nN81c4T9+nb/BIkieKjG6xlP7Tkxv0x21PAELS4tJbs0D1e6IHyv9g+cFHgux7M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mS8PzQpV9Sx73awoVzCMt6mMhjTtqcLZ+u4zJDI1FK0qxKI+MU
 RqGNYSaGJg0yy7RUmILnH+QEYEgWKZqKVezG30ZZPcwbiF0LIyhlsO/7
X-Gm-Gg: AYBFou0uYk7E25lyHzeU5Sl1skC1DsppziWW+X5qQ2WB305T6+93ReLMjZJqnC9yq2O
 y69hQZii3m6Q2p1CuCILj8Rb+QV5c5kHmf7Gk51RFSPDsJNdK9VUvxQlD8+Wom1Bu9sJfok599g
 N0LMRh3h1WwkwpkUCy5pxn7OvtMwJp4NBR6gDxeVDG5oejPlfsWhHggKIWIa4PQnQCPA6HNWdqU
 SOuo+p0NzaHYcvhgxheF9szgoqppSknffSH9I06qRii7dkdiHiLfJIOqrDDgyfjI07lT0dRTU5W
 clAo/9kBLRmKB1ZofpMifblMbfegBkx+94jyKaZgoeJst7qNjyaC037uT00KvO2l289wvodlHR6
 ys993HXjLy5XNDEI5s7rrFj+gwccscHDkPiAZhPJQX+y2HU3N+BUSXRH0gwT+3P8TQGQTNhVRAc
 p9noTaX5EBG7Kf1vEZ2nWKnKTM7jNQ2SwVPrAI0RqWHTRpP/InsVM0S4Z/24ZAAf0czKZabXxMv
 6C7Rgkn0MxJSM6F7ANU9hRAEvE28gRW6eRZM8xuMGWQuiYhjP857mHl9hEdEIpwooUs7rzOjwuC
 fFrK2FqP5zO14cP6rFc=
X-Received: by 2002:a05:6820:1f11:b0:6be:4eb3:e1be with SMTP id
 006d021491bc7-6d43fe7221bmr682739eaf.39.1790202910732; 
 Wed, 23 Sep 2026 15:35:10 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:38 -0600
Subject: [PATCH v11 14/38] dyndbg: Bind callsites and classmaps to
 DDEBUG_MODNAME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-14-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5456;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=PHoWIplF+5KumvZl2vjWPwHFDGEYzydpXULFGLWX+GU=;
 b=LjYzw8LB+6ZB21y1mMCWFEMn/XAOgL43i4lFx863vkE7v0z325lnonpCcasvD71zJJpFrS42U
 AX9WB85DgD+DgWvAaQU7P6zjMY5/w4G0hoNtK1VONpxpL4pCJa4wwW5
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

Currently, dyndbg binds KBUILD_MODNAME directly into callsite and
classmap declarator macros.

For built-ins, KBUILD_MODNAME defaults to the basename of the source
file. For many subsystems, this fragments what should be a single
module into separate file basenames: kernel/power/ produces "main",
"suspend", "hibernate", "snapshot", and "swap" when all should be
"power". Conversely, multiple unrelated built-in files across the tree
(init/main.c, kernel/power/main.c) all collide under "main".

While consolidating these fragments into unified subsystem names is
desirable for query targeting and classmaps, attempting a bulk heuristic
renaming across Kbuild introduces broad churn and disrupts control file
output across the kernel. Module naming should remain under explicit
maintainer control instead.

Define DDEBUG_MODNAME in include/linux/dynamic_debug.h guarded with
#ifndef, defaulting cleanly to KBUILD_MODNAME. Bind DDEBUG_MODNAME into
callsite and classmap declarator macros instead of hardcoding
KBUILD_MODNAME.

This establishes an opt-in hook allowing subsystem maintainers to
consolidate their module fragments if desired (e.g. via
ccflags-y += -DDDEBUG_MODNAME='"power"' in a subsystem Makefile)
while preserving existing module-name invariants by default.

What's Unchanged:
- Default module names remain strictly identical to KBUILD_MODNAME.
- Zero callsite memory overhead or layout changes in struct _ddebug.
- dynamic_debug/control output remains unchanged across the tree.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h                      | 12 +++++++--
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 29 +++++++++++-----------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index baf5c0853f45..85863e24ad13 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -10,6 +10,14 @@
 
 #define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
+/*
+ * DDEBUG_MODNAME: Subsystem/module name hook for callsites and classmaps.
+ * Defaults to KBUILD_MODNAME.
+ */
+#ifndef DDEBUG_MODNAME
+#define DDEBUG_MODNAME KBUILD_MODNAME
+#endif
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -121,7 +129,7 @@ struct ddebug_class_param {
 	static struct ddebug_class_map __aligned(8) __used		\
 		__section("__dyndbg_classes") _var = {			\
 		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
+		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
 		.class_names = _var##_classnames,			\
@@ -160,7 +168,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
-		.modname = KBUILD_MODNAME,			\
+		.modname = DDEBUG_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index a7a554bffebf..c279c795867b 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -260,34 +260,35 @@ function FT_grammar_errs {
     ddcmd =_
 }
 
-# these queries run against the builtin module: params, and change
-# flags.  The control file state-of-interest is found by path,
-# kernel/params.c, to avoid module keyword entirely
+# these queries run against the builtin file: kernel/params.c, and change
+# flags.  The control file state-of-interest is found by path $f,
+# perfectly binding the stimulus scope to the observation slice.
 function FT_basic_queries {
     v_echo "${GREEN}# BASIC_TESTS ${NC}"
     if [ $LACK_DD_BUILTIN -eq 1 ]; then
-	echo "SKIP - test requires params, which is a builtin module"
+	echo "SKIP - test requires dynamic_debug built into kernel"
 	return
     fi
+    local f='kernel/params.c'
     ddcmd =_ # zero everything
 
-    ddcmd "module params +mf" 'kernel/params.c'
-    ddcmd "module params +l"  'kernel/params.c'
-    ddcmd "module params -m"  'kernel/params.c'
-    ddcmd "module params =_"  'kernel/params.c'
+    ddcmd "file $f +mf" "$f"
+    ddcmd "file $f +l"  "$f"
+    ddcmd "file $f -m"  "$f"
+    ddcmd "file $f =_"  "$f"
 
     # multi-query commands split on ; on a single line
-    ddcmd "module params +mf ; module params func parse_args +sl"  'kernel/params.c'
+    ddcmd "file $f +mf ; file $f func parse_args +sl" "$f"
 
     # verify multi-cmd input, newline separated, with embedded comments
     ddcmd =_ # reset before multiline query to capture full transition
-    ddcmd "module params =_		# clear params
-      module params +ml			# set flags
-      module params func parse_args +fs # set other flags" \
-	  'kernel/params.c'
+    ddcmd "file $f =_		# clear params
+      file $f +ml		# set flags
+      file $f func parse_args +fs # set other flags" \
+	  "$f"
 
     # clear flags and verify
-    ddcmd "module params =_"  'kernel/params.c'
+    ddcmd "file $f =_" "$f"
 }
 
 # Built-in Feature Tests (Can run on any CONFIG_DYNAMIC_DEBUG kernel, modular or monolithic)

-- 
2.55.0

