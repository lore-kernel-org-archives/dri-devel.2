Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0643C98314
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E37210F214;
	Wed, 23 Sep 2026 22:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fC3U7DF0";
	dkim-atps=neutral
Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com
 [74.125.231.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3FD10F1F7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:20 +0000 (UTC)
Received: by mail-oi2-f13.google.com with SMTP id
 5614622812f47-4c2c08ff3f8so1018447b6e.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202920; x=1790807720; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zfwGwbUwBRuvPTUiKX1AIC4L/SKKbUUkwfFbVYVud+k=;
 b=fC3U7DF0GDaTVrz1j+Qpnyk/duATgRpv39nt4I6WekYYZ0FZ5FdkHa7gYVE6v9SawB
 AMEZ043ogrQ3G9PZBueRhiDwD/FYHUPF24nbdBlcSfZlYjHdSG3iXWyYLltXhVZP/cWs
 6G65oiwFsS3UM/J7qfF9uM/lQ+1NMNraMx+cQd73Im9yEaUlgtzxYXeik3evt/97CpVL
 RetGghGzMc8aLrJ/yC30EtHqQaYxjRKcsInzHbzJ+xYKe1appCqheaaCE8uNPPAKKqvx
 WHHdh7WiBO5eXuOj9ekYzdfEY341IhyOcbFbHYgSgnROSr065rIE78WrHsvCCFnh8wYP
 C8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202920; x=1790807720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zfwGwbUwBRuvPTUiKX1AIC4L/SKKbUUkwfFbVYVud+k=;
 b=e2cYxlGhN3NvQiNZNMlifirdSntZWEnmBPy7BR/ImnM1ZrE9BnvGAlbxD4CzYjB7c4
 LZVtSqYxOVBoWgN79M+GKbtbMXUE8KPRXfhrmK0lgaZDvUTVdUx7OUfB4hpMFX128Un4
 Kce/Nh+IdVESV7msF6JK04Vb6DCRvhe/63hAJ1StkMccaqW9+WDB4kRE3gVLzScA1MIr
 +iaV3s/VQc0PhgWHQUNu/7DFWkgQ0LWR5qAtcNQqSy6Jp/+53VU+O7xTnvX5vQo5k8Ru
 Wo4AUgnu0TlA5mbPHFjO63P/9MfCzbOAeJY4jbTRxZKA6Y5FaU82tmiku+F08aiVqNcL
 8ZWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9yGIBbrLmeq486Zpp+4XVlv3GL7u1FOFPGObqDXfBw8pkIcnwCMT52i78ZLB8txmreJGLeXiX8RM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m9uf9ubPE9rmpczNzje7MeOAT38FwpMjyiIjKY3lomAHycuzkJ
 jV3N7nXQFoGGhK308tgjQ1iDaWCuh9XlAK5S+67VmggXMpGHqdVX8Ywp
X-Gm-Gg: AYBFou3nQ85qXqHVrCn6Dq63N0ZMQmfCdLu6cn2OVwkvTslEHEqkvgAljJampBRXtol
 genKFvmteal7Dnbm9FGG7JJAhCt+QxPcrsFYzYe+OyIx/i/xQJ+c52rRQofKl/LYYeoZTz1AujP
 z5EsKi0gYz8YOOB+rtXF4JYIxTWowOdEvunSbDHjgiKIhUldp+xFEPTIuSJBtvfWovNApbHY9Jh
 zBW8FdzTBK+J1GrdHctpOu5yZqRSe0ZVHzrzdlkmqztSczuWQ1QSQ4WHlxOXWbou+cR2o0WVuEh
 FoZ2BLWRqho9bFtL1Zpf7twb6NiB2rGj060fmHof4g7DOjISOcndifk6+ovHBGNnzpj0exSMG4P
 gQkdr70oMs/X2VtapP8+K3jrG8FwGmyKuG7sOW4CXt4V8VdvJCWBIj6ElGQGkup4LfsAUBXQ/ig
 dCk99pGIkizrOVDRSXvliIn5rZnaAp29vS8YG0UtPpjpkvXSaWt58908XHErzdti7Z20L1u89lZ
 drTsexDooxsAC46pMw1CxIaNuax4OI80SFkJHq3DC34OezGzZ37Mkqc8Jq2nbTuM52iZ+4z6Bd6
 A9HYipvgAuzYAd/SyhKs
X-Received: by 2002:a05:6808:15a0:b0:4d6:9252:4644 with SMTP id
 5614622812f47-4d72ea60fb1mr765397b6e.56.1790202919796; 
 Wed, 23 Sep 2026 15:35:19 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:42 -0600
Subject: [PATCH v11 18/38] dyndbg: macrofy a 2-index for-loop pattern
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-18-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=zCwr+VGqKnNAOkzayghTBT7W0F9XwKbxJ4/xtvRrwII=;
 b=MtxKW5tqPWiU+c3h1aFiaFOnaqcptE3iPisUyD4ekvG6WyZ6vBzitYfyBmZ8s+ZdbA9UiPRPj
 IK6yKEbDE07BHfoCfxQJDvGQ52SxUshC0CGJ1Kcd+c1y+apgADflV6h
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

dynamic-debug currently has 2 __sections (__dyndbg, __dyndb_classes),
struct _ddebug_info keeps track of them both, with 2 members each:
_vec and _vec#_len.

We need to loop over these sections, with index and record pointer,
making ref to both _vec and _vec_len.  This is already fiddly and
error-prone, and will get worse as we add a 3rd section.

Lets instead embed/abstract the fiddly-ness in the `for_subvec()`
macro, and avoid repeating it going forward.

This is a for-loop macro expander, so it syntactically expects to
precede either a single statement or a { block } of them, and the
usual typeof or do-while-0 tricks are unavailable to fix the
multiple-expansion warning.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1c0604d7e3cc..84a311fac657 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -149,6 +149,20 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a member in @_box
+ */
+#define for_subvec(_i, _sp, _box, _vec)			\
+	for ((_i) = 0, (_sp) = (_box)->_vec;		\
+	     (_i) < (_box)->num_##_vec;			\
+	     (_i)++, (_sp)++)		/* { block } */
+
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
 							int *class_id)
@@ -156,7 +170,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1166,8 +1180,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",

-- 
2.55.0

