Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A276410AB806
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A6B10EBD7;
	Thu, 26 Mar 2026 18:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ordw5dqB";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B22310EBA2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:56 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d75371d873so1396948a34.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551296; x=1775156096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MC2lsh0Qhp0IwkFoRFt/G0LqEbae5jgNK4VV9aW2FC4=;
 b=ordw5dqBedSX8l7xx0U5UZdDgw1SS2elvb1K+EwAXGgwIEi1hxPiDsSKlYTetLqzGq
 IeSvz0te3GMTVfgC72XVE5o4e+kWRMZ9x/GksXPffWnLCIX2/zI5VRY7bQtGQWwl/rbS
 SUW/g6AdDRvGp3SzRa+yjudbhc950Bb+7pxGxVgblI4Vt3ET3P+7gqbbIXhveELgUz46
 Plxq5L+6SCLn8FEh6s8TtZZSbJd5Wtj228OTPTnWO88EIxh0EFyzhqPxaI3zQod62mKe
 rMi5M5iO/iXj2VhLxac39lZwjJm1qrbmvHf/JpPBESt7qx3+hmBJIRWTpxQmqwE97O9P
 LbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551296; x=1775156096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MC2lsh0Qhp0IwkFoRFt/G0LqEbae5jgNK4VV9aW2FC4=;
 b=hNO2IjrV1hDZgIfe5+HgUw+cFHLrK1I9G1uKlumNuXhkuHSpI1q13QdgrX8fvIiKe8
 w8iKNZ+JGx18FOTwVG26YVUhDmJtP04jfe6cdHleMSyIK293p3Pd1nFw+vVpNLODBBX+
 kPQcR0UmS6bxmVkUbkn2D0fVoQDRvxsOS9t+SxkHkrt/LOUCfBMVR+uLGK7r3FS2I4p4
 /aZkV9CYq1kuMBMw2ame5Qbyy892d0xNCQpxnDdiyJzD8RKJrtRkTrY2XMDjDcGk1SHJ
 231Tun+jscgnCtjB0jFLnmU+VZio1HYxGzWp8ou0yjWtGFUUaAPa9uqSB+Adebm4owNR
 y26Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLBshRwVYW9RAB0Uoznqw9ZPfMmg2N6tmXyKu7CXBYoqE+b/sZ3f1f7x5iXHCdJV1qPTZnRDSigHA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywd5zIzPBlRMeL/7x8cL0lnpZIMM0OE0N0DXn+yRsbaL1ddzYEF
 YGM+jToIL5raICbUHE2YEIoqO9dZ3d6/VoOi8FyLqMTnlnKjUZe2FUnWnPgPkA==
X-Gm-Gg: ATEYQzxCZk6UtE/w/TzVSSBUGREse3FM0RgxBkWxJR6nA6CJYJ0aM60EaomMs4cL8kl
 z7dLR3hsiZXfa9WeNgw1yaqMcfcRdPrcMo5cixvcyoz17ffJNcSWwrjDBfZ1Hgz9KZxMtWSJRaa
 5rCJ3Pd+Un3q53cuG11QxMdM04mOMI8OH1AB6v8sfND+HcqtVew0h69Qqjf/6cexOaVCjjZJLCC
 cFqnIHChYX7l/lpTHfwTm5JrlBdELgZWYhxqwxQ18YQ6mhefHOfhf6dHvBO5rcpJCeW4xb59HYs
 Z1gpXRMbB49xmLYqUImGsQKEpiyZxjJQNaeZCiKRo2d+byGZkx5pFwXSTWamx7CyA4SdFvrz7x+
 75cCG9yHJ4CG3m/lX1ZCtxflKuntvjX+zavhBo5iGk/ixyEicPrUiOCkK4ZjHpUBPAyyhOxeE3S
 P3TYOXDV/GCUCQ/VWlFUcmx/9ZyrRuJkXUSKElsGtNZLGe0+Fi
X-Received: by 2002:a05:6820:1686:b0:662:f2ea:8f9b with SMTP id
 006d021491bc7-67dff41d463mr4535409eaf.20.1774551295761; 
 Thu, 26 Mar 2026 11:54:55 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 17/69] dyndbg: replace classmap list with a vector
Date: Thu, 26 Mar 2026 12:53:21 -0600
Message-ID: <20260326185413.1205870-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classes are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members.
The "select-by-modname" condition is reused to find the start,end of
the subrange.

NOTE: This "filter-by-modname" on classmaps should really be done in
ddebug_add_module(1); ie at least one step closer to ddebug_init(2),
which already splits up pr-debug descriptors into subranges by
modname, then calls (1) on each.  (2) knows nothing of classmaps
currently, and doesn't need to.  For now, just add comment.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 62 ++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 92627a03b4d1..9fd36339db52 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -84,7 +84,6 @@ enum class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a18f4bc63473..94a66c8537ab 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,10 +45,11 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
-	struct list_head link, maps;
+	struct list_head link;
 	const char *mod_name;
-	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct ddebug_class_map *classes;
+	unsigned int num_ddebugs, num_classes;
 };
 
 struct ddebug_query {
@@ -149,12 +150,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							  const char *class_string, int *class_id)
+							const char *class_string,
+							int *class_id)
 {
 	struct ddebug_class_map *map;
-	int idx;
+	int i, idx;
 
-	list_for_each_entry(map, &dt->maps, link) {
+	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -165,7 +167,6 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -227,7 +228,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1134,9 +1135,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1220,30 +1222,31 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt,
-					 struct ddebug_class_map *classes,
-					 int num_classes)
+static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
 	struct ddebug_class_map *cm;
-	int i, j, ct = 0;
+	int i, nc = 0;
 
-	for (cm = classes, i = 0; i < num_classes; i++, cm++) {
+	/*
+	 * Find this module's classmaps in a subrange/wholerange of
+	 * the builtin/modular classmap vector/section.  Save the start
+	 * and length of the subrange at its edges.
+	 */
+	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
-
-			v2pr_info("class[%d]: module:%s base:%d len:%d ty:%d\n", i,
-				  cm->mod_name, cm->base, cm->length, cm->map_type);
-
-			for (j = 0; j < cm->length; j++)
-				v3pr_info(" %d: %d %s\n", j + cm->base, j,
-					  cm->class_names[j]);
-
-			list_add(&cm->link, &dt->maps);
-			ct++;
+			if (!nc) {
+				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
+					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
+				dt->classes = cm;
+			}
+			nc++;
 		}
 	}
-	if (ct)
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
+	if (nc) {
+		dt->num_classes = nc;
+		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+	}
 }
 
 /*
@@ -1275,10 +1278,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1391,8 +1393,8 @@ static void ddebug_remove_all_tables(void)
 	mutex_lock(&ddebug_lock);
 	while (!list_empty(&ddebug_tables)) {
 		struct ddebug_table *dt = list_entry(ddebug_tables.next,
-						      struct ddebug_table,
-						      link);
+						     struct ddebug_table,
+						     link);
 		ddebug_table_free(dt);
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.53.0

