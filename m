Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9E5C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6755610E27F;
	Mon, 31 Aug 2026 15:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jt/ZmtOR";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A820D10E27F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788189387; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZMC5Z0/lnhEyE9GMP0RHE+uP4zyU1iNGMfGVdIgJ0VFi/mJmhB3+7kO/zE+oHVEI6XRxxWC+Zclzr7qMqI1KXwYE4mM9X6OntbEG7xBkigGUXqKcjcRx2P5RZhM/kzrqXMt7wnjgmfToPyZ2P0Y7X9xnk8+5UDGnkwYkJJW0Sq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788189387;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Qwh+rmSgudMmhXTNrd4dkGXzYDff0nYK+SVL6o+ZchU=; 
 b=REosNPAOtuANPx2Z3gD9kXy+joIheoLSgMhiULm+B7etiTe6vKaWC//u01fGuJi4zjzHJPX4qz4rzpEc1K9wai1I15lAz3qnM1oDJHameN7P4ue9cclAGZnbNM8zrrtUjvkZkP/1D7Zm8TnswORyetnB7bquZ4174sP7fIIUgmo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788189387; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=Qwh+rmSgudMmhXTNrd4dkGXzYDff0nYK+SVL6o+ZchU=;
 b=jt/ZmtORMBg+mQs0Lyw6FFA8IEZonr587GsLjZXw/YFlRGOYaFKNS8Qdbmnj+yff
 S/g6LX3LhkoDhBVtZhuGybdphCZZbnFC+wh66gXH9NGfNDNWuAraLfT9pCqqwVtUMsn
 EdUHtrpRWzwp8lx31sY2HNHk1Ys+7tK88sjaiOlM=
Received: by mx.zohomail.com with SMTPS id 1788189384416881.6750529072829;
 Mon, 31 Aug 2026 08:16:24 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 31 Aug 2026 17:16:08 +0200
Subject: [PATCH v2] drm/panthor: Display priorities of panthor groups over
 debugfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-panthor-sched-group-prio-v2-1-a74c79b4b830@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOSw6CQAyGr0K6tspDcHDlPYyLYahSIwx2BoIx3
 N0RdWm66Zf8ryc4EiYH++gJQiM7tl2AdBWBaXR3IeQ6MKRxWsQq2WKvO99YQWcaqvEiduixF7Z
 oSrU7FzrJizKGYO+Fzjwt0cfTh91QXcn4d95XIXQfQqf/yKDSjtDYtmW/j2ppsWVnNr8HO5o8v
 LMadt7KY1k9Jov1O1D9HzgmGE5lhcp3Js+oPBh7u+nKil6HTjjN8/wCmqebBhABAAA=
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
index 60b2417deb81..791e9b7615c9 100644
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
+		seq_printf(m, "Group %2lu: client_id %8llu pid %8d command %s priority %s queue count %u\n",
+			   i, file->client_id, group->task_info.pid, group->task_info.comm,
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
base-commit: 47b823940e38607dad180eb2f82094ae65565a4b
change-id: 20260814-panthor-sched-group-prio-c987f6a15690

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

