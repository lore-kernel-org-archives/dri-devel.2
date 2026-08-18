Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FC0C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CE310E365;
	Tue, 18 Aug 2026 19:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="aUaVOvCN";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18ED10E365
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787081747; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VcQmkrG7Qc2qpxrRcu1/48680MZyd1pNOT1RXzrzJq8a9oaUOCQAQG3ppScJhS7UDg8pqvt+HtLfcVDGV7HLupe55dfCOBspcUn6H3HhDpeWIkcOwHzmq+qCB7ZQbbE03B1Hr9HHzqTyhKDnWV/Sfj+8j/MbjhN5W2Vs9751O8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787081747;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3R4z8w+QHgM4Q1+ZK9P0FEEDJT5aPEH3SWPi3BtNoVw=; 
 b=d7YFzIwEpqqWakKkhwf4kOqKDjn0MM9F8dQjDMC0af54YRDLYHiIp4C16ZTkTPRSD9bf+NWHlwYS5/VAmZ3Gvi3ZxTbYwpq0fMbYbj/OAd8zX6dtzZ8FO4RsynmnjeSFKftrkb2twCbMcs4OhpUXQoWUV5Ab+kBLqFuK0b30jZ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787081747; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=3R4z8w+QHgM4Q1+ZK9P0FEEDJT5aPEH3SWPi3BtNoVw=;
 b=aUaVOvCNgCLJqed5EFm1/OFo6/jBHZCXPx4hFPEERCcUy491wbYNuS9ssJiMrgNt
 p2VDKl9Gv0zVWCijtjLwDv1QD4dNFVSKqJCcD8sVkwFx/t4XvZDjbPAVUF4kzNQNvIh
 V+6XXylw8OlL/GKgEfPr/TFBUVH/jAwbEmMsStko=
Received: by mx.zohomail.com with SMTPS id 1787081743868794.3790675315197;
 Tue, 18 Aug 2026 12:35:43 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 18 Aug 2026 21:35:24 +0200
Subject: [PATCH] drm/panthor: Display priorities of panthor groups over debugfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-panthor-sched-group-prio-v1-1-1836857c53e9@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNSw6CQBBEr0J6bUcgisBVDIthaKBN5mPPYEgId
 3cU3dVLql5tEEiYArTZBkIvDuxsguKUgZ6VnQh5SAxlXlZ5XVzQKxtnJxj0TANO4haPXtihbur
 bWKniWjU5pLkXGnn9qu/dwWHpH6Tjx/drCD2X9BmPGvQqEGpnDMc2G8Sg4aDP/4CW1gjdvr8Bk
 RY/u7YAAAA=
X-Change-ID: 20260814-panthor-sched-group-prio-c987f6a15690
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
Some additional notes: I noticed panthor apparently uses
xa_for_each{_marked} by guarding it with xa_lock/xa_unlock. That appears
to be unnecessary, judging by the documentation of it and that nobody
else does this.
---
 drivers/gpu/drm/panthor/panthor_drv.c   |  1 +
 drivers/gpu/drm/panthor/panthor_sched.c | 89 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.h |  5 ++
 3 files changed, 95 insertions(+)

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
index 5832dccfc093..44b61e946e2d 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2023 Collabora ltd. */
 
+#include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_exec.h>
 #include <drm/drm_file.h>
@@ -4198,3 +4199,91 @@ int panthor_sched_init(struct panthor_device *ptdev)
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
+static int show_file_groups(struct panthor_file *pfile, struct seq_file *m)
+{
+	struct panthor_group *group;
+	unsigned long i;
+
+	if (IS_ERR_OR_NULL(pfile->groups))
+		return -ENOENT;
+
+	xa_for_each_marked(&pfile->groups->xa, i, group, GROUP_REGISTERED) {
+		seq_printf(m, " Group %lu: priority %s\n", i,
+			   panthor_sched_prio_str(group->priority));
+	}
+
+	return 0;
+}
+
+static int show_each_file(struct seq_file *m, void *arg)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *ddev = node->minor->dev;
+	int (*show)(struct panthor_file *, struct seq_file *) =
+		node->info_ent->data;
+	struct drm_file *file;
+	int ret = 0;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &ddev->filelist_mutex) {
+		list_for_each_entry(file, &ddev->filelist, lhead) {
+			struct task_struct *task;
+			struct panthor_file *pfile = file->driver_priv;
+			struct pid *pid;
+
+			/*
+			 * Although we have a valid reference on file->pid, that does
+			 * not guarantee that the task_struct who called get_pid() is
+			 * still alive (e.g. get_pid(current) => fork() => exit()).
+			 * Therefore, we need to protect this ->comm access using RCU.
+			 */
+			rcu_read_lock();
+			pid = rcu_dereference(file->pid);
+			task = pid_task(pid, PIDTYPE_TGID);
+			seq_printf(m, "client_id %8llu pid %8d command %s:\n",
+				file->client_id, pid_nr(pid),
+				task ? task->comm : "<unknown>");
+			rcu_read_unlock();
+
+			ret = show(pfile, m);
+			if (ret < 0)
+				break;
+
+			seq_puts(m, "\n");
+		}
+	}
+
+	return ret;
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
base-commit: 0e118b936dc5904cf0d9859882a40c96057b083d
change-id: 20260814-panthor-sched-group-prio-c987f6a15690

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

