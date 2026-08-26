Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03653C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C9310E33E;
	Wed, 26 Aug 2026 21:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AQA3YRKM";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCEAB10E33E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787779116; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LSLVKPusSK8NTJQSdBl0sd5v6IHIuTqTFHytSIXRTSggPr7TjxGIzp1zm26nIjdZbP5p7kaQ18lNHuLlvHcKeZPjrQE0fqf1aHLkuu3mt2RCFFhPVO4DJ1ACo3nRQadi5IKS/V6ggAL3PNbPH1EnQPEnMo6KCjjzIXjk39JEd2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787779116;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w4NjAOv8haxbtWQWq7kg/kHBpDV1YcwUEy2S/D8q5ks=; 
 b=oHzSFYAnSlmtt65nmadFm4BaffJOLBtwqZIe2t5V7OoYSBK+oqBaQ2vxwfRiEB01AJCa6Y+Yo3qy/gOUyyfcNbFIwvJGXkJGLYVkQYAlpIxFmZq3UGpsOyTZ32KT+ayS8Mw5cV6xCCbBoNMtWM/tUxHthFH14Kwg0EGo5HbhWto=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787779116; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=w4NjAOv8haxbtWQWq7kg/kHBpDV1YcwUEy2S/D8q5ks=;
 b=AQA3YRKMzKkPYQok+OWOTQhdVdcNst6HXoh4uY71kzjW5cb5RS42VF1QKbejeacU
 k9VKN/JTS5cy7yrBJMuE3iNmSuHtsuXLavtZmail0b4CK665gtVYEnxkn2Yw4Z0z3ib
 Pd9QujYkrXb6MUTIG/Ve3Bvlw9Lt/qWW9MRO4aCc=
Received: by mx.zohomail.com with SMTPS id 1787779115371369.79024996846704;
 Wed, 26 Aug 2026 14:18:35 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 26 Aug 2026 22:18:06 +0100
Subject: [PATCH v6 04/16] drm/panfrost: Move debugfs initialisation to
 relevant subsystems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-claude-fixes-v6-4-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
In-Reply-To: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12625;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=DZWyR/kYubtvf3s/OLBgSowWCeMeWaF9EEwJkXQFV/I=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqj1gLsKeFY+tKB97jFxd9H7AW7n2nfZGJDh7UC
 BZ8A0AnEv6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCao9YCwAKCRAOJn5M7lND
 Pc3pC/4mRtuFNB3xCQAm1JvjMHpb5LWaQnAwIIbX/OL8yGyiU/15ZFZzEnZhpXtmh3Pbx7oOROb
 I3zj48t7vixbbUuddBd0IP4mqPJOC0xqzbHTZTVAOcyYIxKf4WIM6dX1D6FJYAr8AcEisBL2WmA
 zrzP0DfLJ6nSTZHr3ZRXNKagCkne/7iRMVU2QFjENL/wWPn5fce4LfHzDRAFrsVD/tTMxgPQPM2
 2lRovgZ7dkWW3RxE12NAiZTn8egMFKMI8SWHbNdVmvVvUNtFpR4bDqtCfSNss9KyqaczCWLSySO
 plm3iTgYeRwfXKGZq4cFadc0fQLsQqj0Sq+D/NM2pgbLEatKsw4mb0MxjBbA3Bv2If5UnwsVzJK
 ksfWiIFBIApDGI9HtkuXXR7MRronczjG9ghs+BmsvhJrgGZucI+r+u52NmLlMSAU/JGkLRsozUM
 8zur5oMv5vQ6c9/ks7Z9pdEp4v3HyRrYzNikgTnYHvvBkfddrR/wW7SWoXjUhpGhYj0TE=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Because debugfs knobs are a device interface, and also the different knobs
deal with specific subsystems, it's best to move their initialisations away
from panfrost_drv.c and into the subsystem they provide information about.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c |   8 ++
 drivers/gpu/drm/panfrost/panfrost_device.h |   4 +
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 129 +----------------------------
 drivers/gpu/drm/panfrost/panfrost_gem.c    |  29 ++++++-
 drivers/gpu/drm/panfrost/panfrost_gem.h    |   3 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    |  99 ++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h    |   4 +
 7 files changed, 144 insertions(+), 132 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 7daa2143f3c4..6e3fcd53b690 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -591,3 +591,11 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
 	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
 	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
 };
+
+#ifdef CONFIG_DEBUG_FS
+void panfrost_device_debugfs_init(struct drm_minor *minor)
+{
+	panfrost_gems_debugfs_init(minor);
+	panfrost_sched_debugfs_init(minor);
+}
+#endif // CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 1fe1554f2652..a0b9a2145fc9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -341,4 +341,8 @@ panfrost_device_schedule_reset(struct panfrost_device *pfdev)
 	queue_work(pfdev->reset.wq, &pfdev->reset.work);
 }
 
+#ifdef CONFIG_DEBUG_FS
+void panfrost_device_debugfs_init(struct drm_minor *minor);
+#endif // CONFIG_DEBUG_FS
+
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index ec8c1c08e147..f77780c72a1a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -792,133 +792,6 @@ static const struct file_operations panfrost_drm_driver_fops = {
 	.show_fdinfo = drm_show_fdinfo,
 };
 
-#ifdef CONFIG_DEBUG_FS
-static int panthor_gems_show(struct seq_file *m, void *data)
-{
-	struct drm_info_node *node = m->private;
-	struct panfrost_device *pfdev = to_panfrost_device(node->minor->dev);
-
-	panfrost_gem_debugfs_print_bos(pfdev, m);
-
-	return 0;
-}
-
-static void show_panfrost_jm_ctx(struct panfrost_jm_ctx *jm_ctx, u32 handle,
-				 struct seq_file *m)
-{
-	struct drm_device *ddev = ((struct drm_info_node *)m->private)->minor->dev;
-	const char *prio = "UNKNOWN";
-
-	static const char * const prios[] = {
-		[DRM_SCHED_PRIORITY_HIGH] = "HIGH",
-		[DRM_SCHED_PRIORITY_NORMAL] = "NORMAL",
-		[DRM_SCHED_PRIORITY_LOW] = "LOW",
-	};
-
-	if (jm_ctx->slot_entity[0].priority !=
-	    jm_ctx->slot_entity[1].priority)
-		drm_warn(ddev, "Slot priorities should be the same in a single context");
-
-	if (jm_ctx->slot_entity[0].priority < ARRAY_SIZE(prios))
-		prio = prios[jm_ctx->slot_entity[0].priority];
-
-	seq_printf(m, " JM context %u: priority %s\n", handle, prio);
-}
-
-static int show_file_jm_ctxs(struct panfrost_file_priv *pfile,
-			     struct seq_file *m)
-{
-	struct panfrost_jm_ctx *jm_ctx;
-	unsigned long i;
-
-	xa_lock(&pfile->jm_ctxs);
-	xa_for_each(&pfile->jm_ctxs, i, jm_ctx) {
-		jm_ctx = panfrost_jm_ctx_get(jm_ctx);
-		xa_unlock(&pfile->jm_ctxs);
-		show_panfrost_jm_ctx(jm_ctx, i, m);
-		panfrost_jm_ctx_put(jm_ctx);
-		xa_lock(&pfile->jm_ctxs);
-	}
-	xa_unlock(&pfile->jm_ctxs);
-
-	return 0;
-}
-
-static struct drm_info_list panthor_debugfs_list[] = {
-	{"gems",
-	 panthor_gems_show, 0, NULL},
-};
-
-static int panthor_gems_debugfs_init(struct drm_minor *minor)
-{
-	drm_debugfs_create_files(panthor_debugfs_list,
-				 ARRAY_SIZE(panthor_debugfs_list),
-				 minor->debugfs_root, minor);
-
-	return 0;
-}
-
-static int show_each_file(struct seq_file *m, void *arg)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *ddev = node->minor->dev;
-	int (*show)(struct panfrost_file_priv *, struct seq_file *) =
-		node->info_ent->data;
-	struct drm_file *file;
-	int ret;
-
-	ret = mutex_lock_interruptible(&ddev->filelist_mutex);
-	if (ret)
-		return ret;
-
-	list_for_each_entry(file, &ddev->filelist, lhead) {
-		struct task_struct *task;
-		struct panfrost_file_priv *pfile = file->driver_priv;
-		struct pid *pid;
-
-		/*
-		 * Although we have a valid reference on file->pid, that does
-		 * not guarantee that the task_struct who called get_pid() is
-		 * still alive (e.g. get_pid(current) => fork() => exit()).
-		 * Therefore, we need to protect this ->comm access using RCU.
-		 */
-		rcu_read_lock();
-		pid = rcu_dereference(file->pid);
-		task = pid_task(pid, PIDTYPE_TGID);
-		seq_printf(m, "client_id %8llu pid %8d command %s:\n",
-			   file->client_id, pid_nr(pid),
-			   task ? task->comm : "<unknown>");
-		rcu_read_unlock();
-
-		ret = show(pfile, m);
-		if (ret < 0)
-			break;
-
-		seq_puts(m, "\n");
-	}
-
-	mutex_unlock(&ddev->filelist_mutex);
-	return ret;
-}
-
-static struct drm_info_list panfrost_sched_debugfs_list[] = {
-	{ "sched_ctxs", show_each_file, 0, show_file_jm_ctxs },
-};
-
-static void panfrost_sched_debugfs_init(struct drm_minor *minor)
-{
-	drm_debugfs_create_files(panfrost_sched_debugfs_list,
-				 ARRAY_SIZE(panfrost_sched_debugfs_list),
-				 minor->debugfs_root, minor);
-}
-
-static void panfrost_debugfs_init(struct drm_minor *minor)
-{
-	panthor_gems_debugfs_init(minor);
-	panfrost_sched_debugfs_init(minor);
-}
-#endif
-
 /*
  * Panfrost driver version:
  * - 1.0 - initial interface
@@ -950,7 +823,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.gem_prime_import	= panfrost_gem_prime_import,
 	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,
 #ifdef CONFIG_DEBUG_FS
-	.debugfs_init = panfrost_debugfs_init,
+	.debugfs_init = panfrost_device_debugfs_init,
 #endif
 };
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 15105b7f954b..54717fdb8624 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 
 #include <drm/panfrost_drm.h>
+#include <drm/drm_debugfs.h>
 #include <drm/drm_print.h>
 #include "panfrost_device.h"
 #include "panfrost_gem.h"
@@ -736,8 +737,8 @@ static void panfrost_gem_debugfs_bo_print(struct panfrost_gem_object *bo,
 		totals->reclaimable += resident_size;
 }
 
-void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
-				    struct seq_file *m)
+static void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
+					   struct seq_file *m)
 {
 	struct gem_size_totals totals = {0};
 	struct panfrost_gem_object *bo;
@@ -757,4 +758,28 @@ void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
 	seq_printf(m, "Total size: %zd, Total resident: %zd, Total reclaimable: %zd\n",
 		   totals.size, totals.resident, totals.reclaimable);
 }
+
+static int panfrost_gems_show(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = m->private;
+	struct panfrost_device *pfdev = to_panfrost_device(node->minor->dev);
+
+	panfrost_gem_debugfs_print_bos(pfdev, m);
+
+	return 0;
+}
+
+static struct drm_info_list panfrost_debugfs_list[] = {
+	{"gems",
+	 panfrost_gems_show, 0, NULL},
+};
+
+int panfrost_gems_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_create_files(panfrost_debugfs_list,
+				 ARRAY_SIZE(panfrost_debugfs_list),
+				 minor->debugfs_root, minor);
+
+	return 0;
+}
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index 5c823cdbd980..49bb5691087e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -164,8 +164,7 @@ int panfrost_gem_sync(struct drm_gem_object *obj, u32 type,
 void panfrost_gem_internal_set_label(struct drm_gem_object *obj, const char *label);
 
 #ifdef CONFIG_DEBUG_FS
-void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
-				    struct seq_file *m);
+int panfrost_gems_debugfs_init(struct drm_minor *minor);
 #endif
 
 #endif /* __PANFROST_GEM_H__ */
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 6f920fd0fc4e..5016d2d53da2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -8,6 +8,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/dma-resv.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
 #include <drm/panfrost_drm.h>
 
@@ -1137,3 +1139,100 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 	panfrost_jm_ctx_put(jm_ctx);
 	return 0;
 }
+
+#ifdef CONFIG_DEBUG_FS
+static void show_panfrost_jm_ctx(struct panfrost_jm_ctx *jm_ctx, u32 handle,
+				 struct seq_file *m)
+{
+	struct drm_device *ddev = ((struct drm_info_node *)m->private)->minor->dev;
+	const char *prio = "UNKNOWN";
+
+	static const char * const prios[] = {
+		[DRM_SCHED_PRIORITY_HIGH] = "HIGH",
+		[DRM_SCHED_PRIORITY_NORMAL] = "NORMAL",
+		[DRM_SCHED_PRIORITY_LOW] = "LOW",
+	};
+
+	if (jm_ctx->slot_entity[0].priority !=
+	    jm_ctx->slot_entity[1].priority)
+		drm_warn(ddev, "Slot priorities should be the same in a single context");
+
+	if (jm_ctx->slot_entity[0].priority < ARRAY_SIZE(prios))
+		prio = prios[jm_ctx->slot_entity[0].priority];
+
+	seq_printf(m, " JM context %u: priority %s\n", handle, prio);
+}
+
+static int show_file_jm_ctxs(struct panfrost_file_priv *pfile,
+			     struct seq_file *m)
+{
+	struct panfrost_jm_ctx *jm_ctx;
+	unsigned long i;
+
+	xa_lock(&pfile->jm_ctxs);
+	xa_for_each(&pfile->jm_ctxs, i, jm_ctx) {
+		jm_ctx = panfrost_jm_ctx_get(jm_ctx);
+		xa_unlock(&pfile->jm_ctxs);
+		show_panfrost_jm_ctx(jm_ctx, i, m);
+		panfrost_jm_ctx_put(jm_ctx);
+		xa_lock(&pfile->jm_ctxs);
+	}
+	xa_unlock(&pfile->jm_ctxs);
+
+	return 0;
+}
+
+static int show_each_file(struct seq_file *m, void *arg)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *ddev = node->minor->dev;
+	int (*show)(struct panfrost_file_priv *, struct seq_file *) =
+		node->info_ent->data;
+	struct drm_file *file;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ddev->filelist_mutex);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(file, &ddev->filelist, lhead) {
+		struct task_struct *task;
+		struct panfrost_file_priv *pfile = file->driver_priv;
+		struct pid *pid;
+
+		/*
+		 * Although we have a valid reference on file->pid, that does
+		 * not guarantee that the task_struct who called get_pid() is
+		 * still alive (e.g. get_pid(current) => fork() => exit()).
+		 * Therefore, we need to protect this ->comm access using RCU.
+		 */
+		rcu_read_lock();
+		pid = rcu_dereference(file->pid);
+		task = pid_task(pid, PIDTYPE_TGID);
+		seq_printf(m, "client_id %8llu pid %8d command %s:\n",
+			   file->client_id, pid_nr(pid),
+			   task ? task->comm : "<unknown>");
+		rcu_read_unlock();
+
+		ret = show(pfile, m);
+		if (ret < 0)
+			break;
+
+		seq_puts(m, "\n");
+	}
+
+	mutex_unlock(&ddev->filelist_mutex);
+	return ret;
+}
+
+static struct drm_info_list panfrost_sched_debugfs_list[] = {
+	{ "sched_ctxs", show_each_file, 0, show_file_jm_ctxs },
+};
+
+void panfrost_sched_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_create_files(panfrost_sched_debugfs_list,
+				 ARRAY_SIZE(panfrost_sched_debugfs_list),
+				 minor->debugfs_root, minor);
+}
+#endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index c3f57e41a571..3e3b9717838f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -74,4 +74,8 @@ int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
 
+#ifdef CONFIG_DEBUG_FS
+void panfrost_sched_debugfs_init(struct drm_minor *minor);
+#endif
+
 #endif

-- 
2.55.0

