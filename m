Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E84C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9D110F216;
	Wed, 23 Sep 2026 22:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="inEnUWyV";
	dkim-atps=neutral
Received: from mail-oa2-f37.google.com (mail-oa2-f37.google.com
 [74.125.231.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E581310F205
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:29 +0000 (UTC)
Received: by mail-oa2-f37.google.com with SMTP id
 586e51a60fabf-46accbdfc39so1371147fac.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202929; x=1790807729; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fyx2/lMMioIYQr8FsSk4heofJSR1CaO/m9JvXNhTKXg=;
 b=inEnUWyVrINTmJ68D5XcyaNqe0kKs+A2rdFGdayiShp+mkPh5sOombCdbSx+G836T9
 GPKAhzSf/m0ktuEFzhPQBlyEfKlf5k1/mJkUPsPRCg9nt8WrmapERywUq47j0ZujDwHJ
 NHMiNe/B9e3/8HC6DANbeQykGdj79Qkx0O0N7pCHERrOM/thfbPwOIaWDIFvXG03smwG
 dbIKKAW74daDlyHgugp6eGMduL73J1Gz0e1zf0m5F0MsojQTCgwcu/92j50Efurl7HcN
 k1DHn/w8XPUK5hC9vFKyIqS6XK2G7Ny1v2p+xxStBAOJ34aYNlZKlORO9gc7E9z7vtjs
 CD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202929; x=1790807729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fyx2/lMMioIYQr8FsSk4heofJSR1CaO/m9JvXNhTKXg=;
 b=M86yGcqxbP2ss0Ar/GLZh8OpoKATrPc/GekaADpIb0djJLNkwZEKmJgYksYWtNmvy3
 LcSARqURQoXki69XLsk6X5YJt+cCm6nmNhWRHrP04Xs1i8Yn00Z1jdcWNEN0vmgVdRZI
 6gnxtY3bxSbiuogXPTspNfyQYy4Z2ru1YFssCs6iDFuP0M6JpfzdmeoaOR4OkJ1c1YMv
 FCbmb0/saanznR3ATMRXKysYZL01yJ6Wlm0z2d940MdGiSbz7JoRHgfa0YRyr5nh5y8h
 jf7cD2wPzREvAQqB62iJZpOrrAFOKtEhXjq/mu/a0sEm/y7d3EbzEff7n/Rq1k60Alks
 1boA==
X-Forwarded-Encrypted: i=1;
 AKwUvByOlPBaIMOcY02gTkNhezPDLMna3sNafG1kHyni+j/QWMxi0Xdt9/3s61Ry6jghV47KZiPv04x3qbQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkz6nmyoqGZTlx2ZvVSRZjKWWKr87YxHReOxm8kHPWfS3iks1R
 0oLAX4oV5AS/V24tQyhMozoVyAM/sgDA8S4ANOJCz5aT4R143pZjHlPR
X-Gm-Gg: AYBFou3/ORRzOnZ8Rrmh7m3zsvXRbAONVqFNi83gSbck6K0vgzPGEVkynm9M1UmDBES
 NkUxjLfaV4Zv8qahU/UJAL5HFBgOYB8X57DBoqmHqjYEOWE1dxKJs1xPQ4489/MLAKrBn3qdtXe
 oomnTxl08nYDUOhDJ91ojsK6DndFgok+vmgi4HwLjyqXT4tdMjFey9UxZgp0JNKOVGNSfeYrzlH
 Il3Cb75Hg57Hc+mAfcHfaN+bG1U2E/Fi/+ZZ7nPlRT9jw1p20caluXohanPw8JmzMnDyp6oH/Uf
 Dr+pi2NTaHz+L9zaCmbNF4imU6AtrhoiLF+tdCLrutNnRjq032rhOqef2m1GvqSOYguZZNjcHdj
 VsNHXHNEhNA7FiAq6MeL9QpSoc5QAUm3o0CcuAWvosjt2afZ+uGazcanS5QahKNok1tPjMwyd0n
 s+6ES4O9xweZLDQfaF0KHMNjbfzCbC6GAX/mzv87UFrGcnlqMSJWic4r6xq4K4oBx2UtfKMuKz5
 zupnTWJ0W+rWM4PXllNZ2m6d7wlSYRGcjddc5pJDOXIw+/pFWu4aA5+iwi5cmQfMPorft8vTcbb
 gvGkc36OCv9EH5VCb33L
X-Received: by 2002:a05:6808:1996:b0:4d6:9153:2964 with SMTP id
 5614622812f47-4d72b7338f5mr695991b6e.53.1790202928885; 
 Wed, 23 Sep 2026 15:35:28 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:46 -0600
Subject: [PATCH v11 22/38] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-22-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5946;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UtRUTMOEcHAABn0fA/3Tsdm7e2FonxveFSA9Gb6l2hE=;
 b=Q24ZotreobGZfIqTRvWMRFHmUcoi1ByJ37Tnxztz6NXIJr2FHoGYP6QDLtarpJR3FGJ3gqt85
 lMnKhHKFIQnBmjmqW7JDO+RHjgQDlMJxue3aCDGulmrBh5Y+joXJEmD
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

The body of ddebug_attach_module_classes() is just a code-block that
finds the contiguous subrange of classmaps matching on modname, and
saves it into the ddebug_table's info record.

Implement this block in a macro to accommodate different component
vectors in the "box" (as named in the for_subvec macro).  We will
reuse this macro shortly.

And hoist its invocation out of ddebug_attach_module_classes() up into
ddebug_add_module().  This moves the filtering step up closer to
dynamic_debug_init(), which already segments the builtin pr_debug
descriptors on their mod_name boundaries.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v8: set maps.len = nc unconditionally
v3: expand block-comment in ddebug_add_module

v2: move RvB after SoB

finish hoist - drop old fn - ddebug_attach_module_classes

the v1 rev left the old ddebug_attach_module_classes in place, but it
is completely redundant now, since it already lost the list-linking
job it was doing.

It was being cut out later in the patchset (in the unsent API
adaptation phase), but for cleaner review, lets excise it now.

OLD all-in-1-series (pre split into reviewable chunks)

v10?- reordered params to match kdoc

v12- refactor/rename: s/dd_mark_vector_subrange/dd_set_module_subrange/

1. Renamed the macro from dd_mark_vector_subrange to
   dd_set_module_subrange to better reflect its purpose of narrowing a
   vector to a module-specific subrange.

2. Simplified the arguments by removing the redundant _dst, as the _di
   pointer already provides access to the target _ddebug_info struct.

3. Refactored for Clarity: Instead of overwriting the struct's start
   pointer while the for_subvec loop is using it to iterate, I
   introduced a temporary __start variable. This avoids the "subtle"
   side effect and makes the logic easier to follow.

4. Updated Documentation: Improved the comment block to explicitly
   state that the macro scans for the first match and counts
   contiguous elements.

fiuxp
---
 lib/dynamic_debug.c | 79 +++++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1627e40efc8f..18289ca7170b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1174,33 +1174,34 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
-{
-	struct ddebug_class_map *cm;
-	int i, nc = 0;
-
-	/*
-	 * Find this module's classmaps in a subrange/wholerange of
-	 * the builtin/modular classmap vector/section.  Save the start
-	 * and length of the subrange at its edges.
-	 */
-	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
-			if (!nc) {
-				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->info.maps.start = cm;
-			}
-			nc++;
-		} else if (nc) {
-			/* end of matching classmaps */
-			break;
-		}
-	}
-	dt->info.maps.len = nc;
-	if (nc)
-		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
-}
+/*
+ * dd_set_module_subrange - find matching subrange of classmaps
+ * @_i:   caller-provided index var
+ * @_sp:  cursor into @_vec
+ * @_di:  pointer to the struct _ddebug_info to be narrowed
+ * @_vec: name of the vector member (must have .start and .len)
+ *
+ * Narrow a _ddebug_info's vector (@_vec) of classmaps to the
+ * contiguous subrange of elements where ->mod_name matches
+ * @__di->mod_name.  This is primarily for builtins, loadable modules
+ * have only their classmaps, and dont need this sub-selection.
+ */
+#define dd_set_module_subrange(_i, _sp, _di, _vec) ({			\
+	struct _ddebug_info *__di = (_di);				\
+	typeof(__di->_vec.start) __start = NULL;			\
+	int __nc = 0;							\
+	for_subvec(_i, _sp, __di, _vec) {				\
+		if (!strcmp((_sp)->mod_name, __di->mod_name)) {		\
+			if (!__nc++)					\
+				__start = (_sp);			\
+		} else if (__nc) {					\
+			break; /* end of consecutive matches */		\
+		}							\
+	}								\
+	__di->_vec.len = __nc;						\
+	if (__nc)							\
+		__di->_vec.start = __start;				\
+})
 
 /*
  * Allocate a new ddebug_table for the given module
@@ -1209,6 +1210,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1221,17 +1224,21 @@ static int ddebug_add_module(struct _ddebug_info *di)
 		return -ENOMEM;
 	}
 	/*
-	 * For built-in modules, name (as supplied in di by its
-	 * callers) lives in .rodata and is immortal. For loaded
-	 * modules, name points at the name[] member of struct module,
-	 * which lives at least as long as this struct ddebug_table.
+	 * For built-in modules, di is a partial cursor into the
+	 * builtin dyndbg data; the descriptors are the subrange
+	 * matching the modname, but the classmaps are the full set.
+	 * We find and set the relevant subrange of classmaps here.
+	 *
+	 * The modname string is in .rodata, the descriptors and
+	 * classmaps are in writable .data. All are immortal.
+	 *
+	 * For loaded modules, mod_name points at the name[] member
+	 * of struct module, and the descriptors and classmaps point
+	 * at the module's ELF sections; all have lifetimes matching
+	 * the module's presence.
 	 */
 	dt->info = *di;
-
-	INIT_LIST_HEAD(&dt->link);
-
-	if (di->maps.len)
-		ddebug_attach_module_classes(dt, di);
+	dd_set_module_subrange(i, cm, &dt->info, maps);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);

-- 
2.55.0

