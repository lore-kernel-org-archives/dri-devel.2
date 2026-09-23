Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF6C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC97110F20F;
	Wed, 23 Sep 2026 22:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SRn7iDL9";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9520810F1F7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:18 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-466ccbd4773so462594fac.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202918; x=1790807718; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7MkNMRdspTbVvOyjj4mP3KDq+HvnZxjdiab1bd88pGA=;
 b=SRn7iDL97z+cut00rJh/6TWpSp/rc90Z1dhZVnVJIIrX+UDmdWSABUQk0Iq2l94nQ2
 yFY4BuqKIsX65CH2+0pQ3Vb+aQ7tgaRsCP6RJWHza6DAl2v/IUAg9hM9ob4uwFnvFxpt
 X/ln5uUqXFtuxRO+vo+Frd3K9l0l8qMC1y3kvvIwZHAml/jdLi5kkcIzjm1tKfMjA4OG
 km9JU3UaR9bqLqyOunuw9LLRB7dvDmASM4x3GIekrvw2SMUyF0xJ1tjMQCYQmNr9PuWJ
 E7AmNTkLXD8nR8jQzu0jl/6SnNRrShnLtyZgHORJ2ONoF1ahvghJlq8qYEof10sKsx0a
 4sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202918; x=1790807718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7MkNMRdspTbVvOyjj4mP3KDq+HvnZxjdiab1bd88pGA=;
 b=DYdpNdOF8KYcwF3yEU3VdLKrR/rz+yRTq8AokM/s3b6oKrFPNu4bDJg+xTiTK9fyMA
 S8Uyr7OXSo+1j9FHvZxUpKTJKqUumrslDJ6GC0Mcq4VTpYUoUyJ2AKqsC6u1JREe5tZh
 l9py4fLPIr8Qre/nlNSYm2pyN7z86K1pUe/owi7GYdcct6oeHuBF03Sx/lZAMmjXVdRi
 8WQI9ZNmEY0PB3PBq88cGpi08ooBmOY5IFOLLr3Pgg7dzLAlgbauZIkYjV1JeeH+p5Ec
 sdSynMY+6WpquOZtNPUzeeMEJ9aO0udSWpVjuPbLuO5cHpjMVOMy02mLhcTc7d7Ymmpo
 WVIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpTUu6MRtHC9grEJUXsnkURvoZgsUDNDzy3Jp6aQOcnYLYbgz/t275j1G3D3+hH7YJhmPk/go4gp0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kEHRXD15UGG3oJWpjWtH59O+iPW32xgU8yx5An2CfVebdMZw5W
 1aJ6EpnrpupMPzNM/YIY5wCxv5MsV6epo3TG0UYZDtmwyOcfArXEzle1
X-Gm-Gg: AYBFou2cPRaMbdMEUE8fRyuj0Y9poYAfF9xHP7oJbUJiZiKtzdyEuISMxL7PYOF+MyJ
 sVAC/H48tKSfkEMBh4zWwCOpcd8kgcQM5T0PqDQeUpleuOyr34jVQWZzty06Lmac5wi6Us+2p+w
 3QN/M4gxLaZ6hqyl9HClxF58ZJJ9Ati61cSSQCAcmxakuaHeISF1n8PkKmuzNFZZdJLnuA6EWKf
 X+WFGxxGCu84SAnfKZW0pvh2PwTrM20McIEu0cZofXYFKMU5/n1FcslYi5sZ+52VISUpxD6D26t
 Nrq250/EuIi3LImG1hXkfqsLMA1RDU/VoqUDmOp130p3YQ2vY9lQWsXwAHKqV7GmV6ZGlbh8Il/
 Zyx3UBrR1QjYwP+0RLlip2wf+85qVobFPKQILJ0/GddK+3faIZxMufcf2PpMqOF167s8Gd6vTZK
 8BqnvbD07gAIvkhJCrqYt5fzMTatKmD//RmwJQzufbFeCRDPQnA0OjPAW6ZR4dGBo5lKarf5CAA
 xK8qJ2cjvJQctSon/VgOVNwxsNsBEpYBbe7EME/0Ee071XvKdQnm+Nu2CVBKzT6rZ8kHV2o2Xk2
 iaXPXRzH404xM5Os6fU=
X-Received: by 2002:a05:6870:6590:b0:48f:e290:5afd with SMTP id
 586e51a60fabf-491ec0cb1fdmr583623fac.62.1790202917649; 
 Wed, 23 Sep 2026 15:35:17 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:41 -0600
Subject: [PATCH v11 17/38] dyndbg: replace classmap list with an
 array-slice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-17-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5766;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=I+Xnq26sBTEovU8k68EHi/UbMNiSRxDxIqjGuZzsVq0=;
 b=qYmb/qIjTvx2Z2xKJ0hdaGoZ++bj5qRSayQs2SlUI0rpMOgmmtP8o/QD+pp0vr10imBEKm4J6
 yNiL5fpJ6GzCQ5he2TW8hnWRytO9cXguLK/YO/hTlKONu4w8Loh1PhP
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

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classmaps are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members of
the classmap structs.  The "select-by-modname" condition is reused to
find the start,end of the subrange of classmaps belonging to the module.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: RvB after SoB
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 64 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 85863e24ad13..02a1abdc5b3f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -84,7 +84,6 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 474df0dbedc1..1c0604d7e3cc 100644
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
@@ -149,12 +150,13 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
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
@@ -235,7 +237,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1067,9 +1069,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1153,30 +1156,34 @@ static const struct proc_ops proc_fops = {
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
+		} else if (nc) {
+			/* end of matching classmaps */
+			break;
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
@@ -1208,10 +1215,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1324,8 +1330,8 @@ static void ddebug_remove_all_tables(void)
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
2.55.0

