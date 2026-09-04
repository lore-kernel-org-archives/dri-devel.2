Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04882C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538FE10E0EB;
	Fri,  4 Sep 2026 17:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WUspQdC6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5172C10E0EB
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 17:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788543509; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DMmuDQCoVURACoylxNlrDTWGD4xmPuPutKR29iKrvYugqgOJM+zv5l/Jd0VXjujuvspPe6XmVj2nlJ4d/R7wlyRaTdAFofUPJNk8Am66ByH5x7a5LUi9lu+0QyUeaKRuE1bEp9AkqGLBJGkq5iVDRi0YzlfjZCL10c8X2NOE68g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788543509;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mbgZvM7xkVgSImbz5HrGSlrEC5Uq6gmeWqTe1iVYHgs=; 
 b=ByRtpFCInWU3XH6pqJBgO3z8pLI5RwatQ5CBXidyiAtp4CGmAc14pO7Rh4AUEa/4hqEQ7NxZCFvkVU3gsA1Y2ayox+VI8cCvT9cZpV6t3TgU3NLoM54YprC6M4oVSrmXITX2itZ+PGsXiR4sOVdKn484YBXpUDpdh380cEf9iXw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788543509; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=mbgZvM7xkVgSImbz5HrGSlrEC5Uq6gmeWqTe1iVYHgs=;
 b=WUspQdC6+N1STCL9QueteIAoUOjMLRtyYKIEkb0026Ycy+tOuCxrfVAxEcbl4hqg
 tXyXr+sjY0FGKP1daPrKQZ4/uEryPkcUKXzCdIQ/tLcMo9dE5yAMEpLJeoE18T/qrtf
 CZ9SiX8qbjjrSRGbbNM/wrwUan9eYbPq4gthHc/U=
Received: by mx.zohomail.com with SMTPS id 1788543507298300.5394887204635;
 Fri, 4 Sep 2026 10:38:27 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 04 Sep 2026 19:38:09 +0200
Subject: [PATCH v3] drm/panthor: Display priorities of panthor groups over
 debugfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-panthor-sched-group-prio-v3-1-678afcca08b8@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oy27DIBBFf8Vi3anA+AFZ9T+qLABPYqrYOAO2E
 kX+92Ini6pSq1ldae6558EiksfIDsWDES4++jDmIN8K5noznhF8lzMredlwJSqYzJj6QBBdjx2
 cKcwTTOQDOK3aU2NE3WjOcn0iPPnbjv48PnOc7Re6tPFeH4TXOW+m5xuzJiK4MAw+HYqOBhh8d
 DDiLcEmAFwDl2yj9T6mQPfdexF7+aWo/lZcBORTslF162qJ+sOFy8XYQOY9r+7gpfwBk+IfWJl
 hpq1cq21lleS/Yeu6fgO8b4ibXwEAAA==
X-Change-ID: 20260814-panthor-sched-group-prio-c987f6a15690
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

Analogous to what was added in Commit d41c79838c47 ("drm/panfrost:
Display list of device JM contexts over debugfs") for panfrost, add
similar debugfs information for panthor.

The group priority does not change over the lifetime of the group, so no
effort to synchronise with the scheduler lock is being made.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v3:
- Move group number to after the per-file specific information, which
  helps readability
- Link to v2: https://patch.msgid.link/20260831-panthor-sched-group-prio-v2-1-a74c79b4b830@collabora.com

Changes in v2:
- Take groups xa lock around the loop in show_file_groups to guard
  against group object UAF
- Flatten the listing, removing most of the code in show_each_file,
  printing that info for each group instead
- Also show queue count for each group
- Link to v1: https://patch.msgid.link/20260818-panthor-sched-group-prio-v1-1-1836857c53e9@collabora.com
---
 drivers/gpu/drm/panthor/panthor_drv.c   |  1 +
 drivers/gpu/drm/panthor/panthor_sched.c | 73 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.h |  5 +++
 3 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 46a3080b0b20..8cdba0c1a14b 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1769,6 +1769,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
 {
 	panthor_mmu_debugfs_init(minor);
 	panthor_gem_debugfs_init(minor);
+	panthor_sched_debugfs_init(minor);
 }
 #endif
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 60b2417deb81..ac6aee554820 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2023 Collabora ltd. */
 
+#include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_exec.h>
 #include <drm/drm_file.h>
@@ -4175,3 +4176,75 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	ptdev->scheduler = sched;
 	return 0;
 }
+
+#ifdef CONFIG_DEBUG_FS
+
+static const char *
+panthor_sched_prio_str(enum panthor_csg_priority prio)
+{
+	switch (prio) {
+	case PANTHOR_CSG_PRIORITY_LOW:
+		return "LOW";
+	case PANTHOR_CSG_PRIORITY_MEDIUM:
+		return "MEDIUM";
+	case PANTHOR_CSG_PRIORITY_HIGH:
+		return "HIGH";
+	case PANTHOR_CSG_PRIORITY_RT:
+		return "REAL-TIME";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static int show_file_groups(struct drm_file *file, struct seq_file *m)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct panthor_group *group;
+	unsigned long i;
+
+	if (IS_ERR_OR_NULL(pfile->groups))
+		return -ENOENT;
+
+	xa_lock(&pfile->groups->xa);
+	xa_for_each_marked(&pfile->groups->xa, i, group, GROUP_REGISTERED) {
+		seq_printf(m, "client_id %8llu pid %8d command %s: group %2lu priority %s queue count %u\n",
+			   file->client_id, group->task_info.pid, group->task_info.comm, i,
+			   panthor_sched_prio_str(group->priority), group->queue_count);
+	}
+	xa_unlock(&pfile->groups->xa);
+
+	return 0;
+}
+
+static int show_each_file(struct seq_file *m, void *arg)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *ddev = node->minor->dev;
+	int (*show)(struct drm_file *, struct seq_file *) =
+		node->info_ent->data;
+	struct drm_file *file;
+	int ret;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &ddev->filelist_mutex) {
+		list_for_each_entry(file, &ddev->filelist, lhead) {
+			ret = show(file, m);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static struct drm_info_list panthor_sched_debugfs_list[] = {
+	{ "sched_groups", show_each_file, 0, show_file_groups },
+};
+
+void panthor_sched_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_create_files(panthor_sched_debugfs_list,
+				 ARRAY_SIZE(panthor_sched_debugfs_list),
+				 minor->debugfs_root, minor);
+}
+
+#endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 9a8692de8ade..d87cbdba4d40 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -10,6 +10,7 @@ struct drm_file;
 struct drm_gem_object;
 struct drm_sched_job;
 struct drm_memory_stats;
+struct drm_minor;
 struct drm_panthor_group_create;
 struct drm_panthor_queue_create;
 struct drm_panthor_group_get_state;
@@ -55,4 +56,8 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
 void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile);
 
+#ifdef CONFIG_DEBUG_FS
+void panthor_sched_debugfs_init(struct drm_minor *minor);
+#endif
+
 #endif

---
base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
change-id: 20260814-panthor-sched-group-prio-c987f6a15690

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

