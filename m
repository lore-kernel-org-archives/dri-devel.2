Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BEDC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61A510F510;
	Thu,  2 Jul 2026 16:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rfjDNOTZ";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23E910F510
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:40 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-69eb8b6bea8so977513eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010500; x=1783615300; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ohhoTzQSG8OS6K4D/PO7jPPOwrBM058caScQKdaFQN0=;
 b=rfjDNOTZYlOREVz3CnBKhzZvDybCkIzJB7cF/VHj20pGmX7Ps6GDUpidrz867Fx3gv
 PWrhddnSkLiuYvr3SLeccknwYjd6VCo4yI966N05C2gyk2HWhMI1VgX9p1DYzXVGHHhe
 JUYbD4LwwWPx2TrdRvdJ3NtS4Th54oghTW4hYDxSACO1104yEoGnnnab1XkpVdJOC4Wd
 WsH6KGIbvMqIhqxLQGjAgdQwxbLnjSN7wVTUWLGIB+Qsrdq+zSMn04wUsNArKf8Kt2nA
 UNkrPRRnm/eITlIg2GOcRsI+oOJm19yUeUkCp/vmbNAJ7Ua+JG+Y2xxyrNvMV9ad4kRW
 p/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010500; x=1783615300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohhoTzQSG8OS6K4D/PO7jPPOwrBM058caScQKdaFQN0=;
 b=VMw7vUtaI9pD72ixB8BJRt6zT3O+r/TQh+VVL3UxuwwNb7VnMl3hpwagMQhrTigbiI
 olLNzwwhyFmAeDNfa1x+kxC5VW6rRZ2ypjaWZ0KHVmWC1YvqfntAxs2cZ4YDyO4oWi5x
 6V0qQTTo4nyH8zn2ae62ibMsjxRF+ixKjdfpYqvO2KgbxXqOlm3C/s7d67FgFIdXI4we
 9H7mnxjEx6iABHx9KPPhE5hj1dGyTBF1diW20UobLy4Mf3b2r90Vu2RfhMCcDcOqQ49A
 dteEAi9FGa9vGxf1WbaL1KH1Ba3dsSayvBC9NeKkIePE9cno+9/jONLGpz0DKGrlIQMx
 9hwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7U5DtLfLA6ekmThwCIig4XmD4eR5Fn8RVSGQ8MQngZrxj6jd09XjuA4bTyD3e8v/REjHCqipKnys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9mW2TdWVR8oRF2GYmN/jUdE+r+okfWQ2H0UMMM1muGo/fkmmL
 LZTBwqecQAVybAbAm1seLosnykt04dGZ1lcxL0EkMSV4izo7mL4aIRZl
X-Gm-Gg: AfdE7cnZv4vk6HtdZS9C8yV/kEmSn+ShmA6C0ydHDRpuKe8eSK9eVELwTC5e2cT685L
 IZ2uDAFGzDu8UncsJLycMxP4hPIl0fMqt4NNZfYmKVWFKxVdKfWfXIh9APowL0LbEkEHBFIDjJx
 kqkun4A9Y3oV6FRphhptGW8TvM8rDyYvhCaSZjrdmTITDR+tvPapZgtzK7l7lobcuSAHSO56hUi
 2cYulwjTFZ8Rub6fTnEgCZkFv9mLWkE/fiJUFiuWDsqSl49UQtNw43rjV7eUvkdghKh7LvqwQRC
 7RVp9AsrrYo/wq8XtzCkZOFX5k3bOZmMlTgNjsdztHz7sKXYhkOKBD5elL5c6Tr295oPDCJaG0F
 t/k9JjE6VgHhcmlwcnDBE6cBhzkXTs+dR1VxSXUjMqvPwBJzOoqInrAf67hkPRURJGQj/LMxevK
 2WF5tnXhuobG2E+igyuCT0QbcXyP2FtifxveatTfToR63MZ/xobUs=
X-Received: by 2002:a05:6820:5706:10b0:6a3:d6d:1949 with SMTP id
 006d021491bc7-6a30d6d1993mr2494084eaf.37.1783010499610; 
 Thu, 02 Jul 2026 09:41:39 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:09 -0600
Subject: [PATCH v5 17/18] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-17-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=5915;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Q+GlU+k7b5DOi//BqRBfTakK1fGt0RvNMJQ5eSDbR/g=;
 b=rWO8qG1nvm+O3OCiXMMXYrje5bjKYgAW/mb+2+TU8eYDSDN4Zf3gyxcuqw4pWRwq17JhL7swy
 Ej+dZIcOKgzD5iJRQC4CCjIrT6eyECJD9HpltJlkWMNRlhbro6wo1X6
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
 lib/dynamic_debug.c | 80 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a9965ec1807a..1d5b9f68791a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1175,34 +1175,34 @@ static const struct proc_ops proc_fops = {
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
-	if (nc) {
-		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
-	}
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
+	if (__nc)							\
+		__di->_vec.start = __start;				\
+	__di->_vec.len = __nc;						\
+})
 
 /*
  * Allocate a new ddebug_table for the given module
@@ -1211,6 +1211,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1223,17 +1225,21 @@ static int ddebug_add_module(struct _ddebug_info *di)
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
2.54.0

