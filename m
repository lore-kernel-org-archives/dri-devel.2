Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E36CD6E5D
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0BC11327B;
	Mon,  1 Jun 2026 12:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i6KzDIMv";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED6611327B
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:41 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490aebf33e9so2363685e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315540; x=1780920340; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=psUPNABkqP2HblkW4UQMkjLqK/FIcVyd+7kBKIY+9Ns=;
 b=i6KzDIMvp0jL3JaU+mspCJ7pzSF92CufqOPPdGVGnY2Vhx666uhj0AfadKBtB+SBHI
 D531dl6Y0n9+w8EQAMBp8cjVi7L7mfdO4BMn31slUNBGYrgxid9ibuchmDzg9VNtoxzv
 tUpF+VOkIvydRJLFrvyBGktmtudbfbOsWaOBcmDwkS3We9HHc6n/3lJzXV+/UYgXRAuC
 oAqgtujJJNqaKxrlsuYGBesQfL2b4+lnQTLuDPJvPEFkkwsTpAdRub3uPFGnrWdOs4mr
 qEDXA/oMjunJmgnM23nH9BKWpULsmca9rdxtmbQnRGeR7L6n7Gpj9cFHMJAkTKi7VR15
 Owbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315540; x=1780920340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=psUPNABkqP2HblkW4UQMkjLqK/FIcVyd+7kBKIY+9Ns=;
 b=J0CuFm5YiO0pZcZUtpCewwzj+2ga2Aht7jPOHx0xC89GVx35wbQgsg2jZXSuiXDjxV
 4nGYwzqC7HtraiW01Xi8pO2tap05x41cxLO99oA6MSuExerGNX0NxI+4C+PePBYSqf4+
 epgUiYMqw0ciXBvZG0RyUppWqUKx22+iXJrEZcQgFy0f6z5foTshDBrf8DoZ8rS5oNm1
 S20oRdfZG1xghuHD/6MSbR8OnhjMTn/7oTZ7+903pMzBFSaLdo8lj9yi2DkhCAHCS3XJ
 Pk5nMO+iphrCAUHZ8o9+fWfwd0P8RMmASIHEMlqSDEu+YDegPne3YrEUZYycCQ2JGg2j
 0kmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ85vIgRNYz7VqP0dd6pWCQ1Bb7S/bvY8hgTpXTaz25T52zZsqN1NAVd6QKC1bvo2/U+QYRN3quXF1Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5YEQL1ghbvxNQcWBS/rShkJnZD9rOI2xQeUvmj417kyxpLAJ1
 MK6foXkc6PDDi6PeN55VFG39dK3paKbURq6uCMrKmlfvhLvmX/Sh9V/x
X-Gm-Gg: Acq92OFRSBgA9jBp/u0aDVEVBL16/qYa4F7Bw4m0Wvid25ylmu072cQPXr6C2uNNsuD
 duONKYYAj9lBSKnj7pJ60zTBPqc7IYOcpZFc4++jFPB84NElpORDCvmWEJkUoQ3iT9WCo8MIRbv
 E0qfacGd1+sa/bzD7dTqJi90XhxaAxYax9fCY/4K7Bu9rLHAtsX1pl/TzykcTyyk67OKWEFSmxF
 PSgE9PxECF5iPVLCrGB/GCJFMG1g6FZrJo2f4RnyhfcwVzd0RFQlk1E0qVrn4mK8CdSfQ7IOAVL
 Cqtny5JosbkDeLLbQE/mMtMwgT4Hzx1OnfcdiDcuyk+HTlfRa08AcIe5VEPwu4jIFU6oECLB36I
 xraB8JbqAopJ4yk2jaxN+zOs41VbmwO6K5m+5MEWGOz/ohgQPJtuY89+iKJCDAYwWfcedKJw6ct
 i2h9bRTHl9suPUHOJsAlEY5Mb4dTtV8C2bJAcM2cH9BbE/VuoSrDU3
X-Received: by 2002:a05:600c:6214:b0:490:44eb:c1d7 with SMTP id
 5b1f17b1804b1-490a297e571mr244455875e9.30.1780315539522; 
 Mon, 01 Jun 2026 05:05:39 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:02 +0000
Subject: [PATCH v3 16/24] dyndbg: replace classmap list with an array-slice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-16-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=6627;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=8WCc/AQmafTM88wpYes/98KA5fKAXXEB1IR6mZSzU94=;
 b=BjD5WAdaTH7kvHi8eul+ofgcHgnzf3gOV8ajOPS8GZk/X+MyPdcJxzy0lW6SPdRV68tdhY2+U
 tlTnnUrLcHYAyJJnECmztA9CYP+DuQxdktTirj4eCXhXYOTAL57yCVY
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

Just like dyndbg's descriptors, classes are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members of
the classmap structs.  The "select-by-modname" condition is reused to
find the start,end of the subrange of classmaps belonging to the module.

NOTES:

There are multiple modules named "main" but thats an artifact of how
KBUILD_MODNAME gets its value, and none of those repeats are
contiguous.  The legacy code segmenting the builtin descriptors
depends upon this, we are "reusing" that dependency.

The "filter-by-modname" on classmaps should really be done in
ddebug_add_module(1); ie closer to dynamic_debug_init(2), which
already splits up pr-debug descriptors into subranges by modname, then
calls (1) on each.  (2) knows nothing of classmaps currently, and
doesn't need to.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: RvB after SoB
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 65 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 867e3978675f..0443781ed95b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -73,7 +73,6 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index bb7e16d38f19..34d002e0a08c 100644
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
@@ -1062,9 +1063,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1148,30 +1150,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1203,10 +1209,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1319,8 +1324,8 @@ static void ddebug_remove_all_tables(void)
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
2.54.0

