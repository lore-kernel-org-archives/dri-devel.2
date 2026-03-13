Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFEA105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F90210EC02;
	Fri, 13 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gl67R/Mn";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2C110EBFD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:31 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-467166cb638so881895b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408211; x=1774013011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaAiGHt7PLiNFokoH+wcRTOWenkuKwVpfHhxx7Kp6sw=;
 b=Gl67R/MnwuYOdXexmVDmFg7n8BKqxcoW2rhWwCgLzyDeCKC6fdW8VNKK579IxOSUAV
 QbTNUlIaps765yTrVGJbaJIE586LVTHGuci8hOzdXF6fWCoPxqxxoAkn7e+CcXeX4495
 erx0wCWX8UMsM6Mw7GxbPkfTcUKGAV3b4zbmklu8609L08TNi3Q/jqHDquqCzwG4uuoz
 SVROOIKqH3+UNENDIfHlii6bC9wnh1HvycC5CMhNdzkFUGWZ2yJdYXS47R3nN2aYbAYp
 t9wvcjqZFf+B9JwGm04sIRiHZrVDlbPd0tgX0dgg9Ws0ZISLA2Ykd6w6kLRJXqv6Th92
 pFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408211; x=1774013011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MaAiGHt7PLiNFokoH+wcRTOWenkuKwVpfHhxx7Kp6sw=;
 b=nEAL9r4/KLr5gc2JmbLGNIpZ2FIcEvkNMy0v2olWcgXRwBfGuYsd9Q3TdXK42lXOaz
 FS06UO0EqEPEIk1pt/Qj/GMi1Hr8isz0AOqTdfmrsYuXuCZ8jkwOMxeu3PqTONX3YyTz
 MixkTm0+5Fi7p4mgfds/b6g/s3Gd5F1xmvWnQbTcg60VmFe9pC/KeVKCvxIO5YT+P6fT
 zBC/U9Rv+OGrgynMvKYYfK/hWKqF6K2Xnrh/u0qwYr7kejrrUPcYvIARN2GxOmttrYnz
 V8g43oVtzqqJcP96adyTD4+IhJDgBuomr1GZSNEa0lOvgWOhkaSP01osT408TvCBspm4
 264Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjfshzlO4vFvZmn5d3k6Vp1n3Rpj10zIFJihzZO/ZcjmtdgkvpwOVJzbKDG9XpjvpFOI8nYWdZIcI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZ7a0ZwvrLiO+Q9OE2VUeGXloy4dVJdPtV+ZLp9sjyntSZAHFF
 vD9ibFD+IVuIJKJsu3dO7aDid0RUP3Vz2qmUuXqfsSjxPiVZbwP6b6DB
X-Gm-Gg: ATEYQzxXsRr4sPfovPxekIZoTZXu2/tz4oFnkN+hk2XTu27+NgRFUY58kgGjzCZ6ZPZ
 EfnftLmErip8YDJRY6K6jPke/jEiUAedgnb8HGuPuovcNL/GT9g8NEufqe6CIYMGICEhajVXCHM
 mnqyDq5yD8pXWSQFRZ01AKABEMITepx0dNbf6sWHEg9+cHiPzzE9athlVMOEOHp/3H6R0+UoLDC
 PmtRV7CMiBoBtOiKpWiacGLJjqGLRNdJj7vCh5NWMI1t4ESEg5tnN537EVoS6MKgZEfhmA7Gy36
 kUhwLdIXbjiXEi7uuaIjdSnMjvk1EJqVmLH55dkHw2LtPI0T2JQZ8ij5jrFAEruc7pz+/uUXErB
 jLbasnW+SHokcpS0xKny5B8ffica2Q2Qo3LyT7fXhXKW3hxW2zmlSOW9ZkmOYnwTqrvmyjpr7Ra
 +S3fZRklo7RAsGynZjZyxy3Lq0HRwa6CEdbNh4yKAlVWp0C6hg
X-Received: by 2002:a05:6808:4f4e:b0:45c:925b:5848 with SMTP id
 5614622812f47-467574304eemr1623103b6e.45.1773408210779; 
 Fri, 13 Mar 2026 06:23:30 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 17/65] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Date: Fri, 13 Mar 2026 07:19:42 -0600
Message-ID: <20260313132103.2529746-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

The body of ddebug_attach_module_classes() is dominated by a
code-block that finds the contiguous subrange of classmaps matching on
modname, and saves it into the ddebug_table's info record.

Implement this block in a macro to accommodate different component
vectors in the "box" (as named in the for_subvec macro).  We will
reuse this macro shortly.

And hoist its invocation out of ddebug_attach_module_classes() up into
ddebug_add_module().  This moves the filtering step up closer to
dynamic_debug_init(), which already segments the builtin pr_debug
descriptors on their mod_name boundaries.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
reordered params to match kdoc
---
 lib/dynamic_debug.c | 57 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f47fdb769d7a..df7223532cf5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -170,8 +170,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+							 const char *class_string,
+							 int *class_id)
 {
 	struct _ddebug_class_map *map;
 	int i, idx;
@@ -1247,30 +1247,35 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	struct _ddebug_class_map *cm;
-	int i, nc = 0;
-
-	/*
-	 * Find this module's classmaps in a subrange/wholerange of
-	 * the builtin/modular classmap vector/section.  Save the start
-	 * and length of the subrange at its edges.
-	 */
-	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
-			if (!nc) {
-				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->info.maps.start = cm;
-			}
-			nc++;
-		}
-	}
-	if (nc) {
-		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
-	}
+	vpr_info("module:%s attached %d classes\n", dt->mod_name, dt->info.maps.len);
 }
 
+/*
+ * Walk the @_box->@_vec member, over @_vec.start[0..len], and find
+ * the contiguous subrange of elements matching on ->mod_name.  Copy
+ * the subrange into @_dst.  This depends on vars defd by caller.
+ *
+ * @_i:   caller provided counter var, init'd by macro
+ * @_sp:  cursor into @_vec.
+ * @_box: contains member named @_vec
+ * @_vec: member-name of a type with: .start .len fields.
+ * @_dst: an array-ref: to remember the module's subrange
+ */
+#define dd_mark_vector_subrange(_i, _sp, _box, _vec, _dst) ({		\
+	typeof(_dst) __dst = (_dst);					\
+	int __nc = 0;							\
+	for_subvec(_i, _sp, _box, _vec) {				\
+		if (!strcmp((_sp)->mod_name, (_dst)->mod_name)) {	\
+			if (!__nc++)					\
+				(__dst)->info._vec.start = (_sp);	\
+		} else {						\
+			if (__nc)					\
+				break; /* end of consecutive matches */ \
+		}							\
+	}								\
+	(__dst)->info._vec.len = __nc;					\
+})
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1278,6 +1283,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
+	struct _ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1300,6 +1307,8 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 
 	INIT_LIST_HEAD(&dt->link);
 
+	dd_mark_vector_subrange(i, cm, di, maps, dt);
+
 	if (di->maps.len)
 		ddebug_attach_module_classes(dt, di);
 
-- 
2.53.0

