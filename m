Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E95C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C5710FC07;
	Fri, 25 Sep 2026 18:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="BsqarFCC";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A01310FC07
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790361946; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h9n6vpWOnSjDB9/gG+H+cq1ZBwayCyU4k8BqOGXiNDBm2tFN+d1t64XZNB3CnuJT5GV1uvkgf/Voo5nNTQbaGKxwnCXJRpcqecwOsJK0WYa8fCqwy0GruJ9GkKe3E00u6H08r+U8T5AOIpJOakcPxt+dpK8W+QmiuAbyhlhutDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790361946;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qA5nkyPf4OsAk/8123sJ/LUfYJEvp6UZplI2BJVIXLE=; 
 b=jtqtUXkU/jOGNvo7Ny6GuLbZpHdoN14AAIz0vi0dTiibnl/qddYpzAB8tzZvVYt9ly50czblO/9fxen6exiqkThGaFBynomFBoFpebmyBjzvo2Ri//dz4yzEtE6I6zkHyE9c6uXfcEoGW3BCaNPTFf/W/gpwxZhMVSmbVmjeGEk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790361946; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=qA5nkyPf4OsAk/8123sJ/LUfYJEvp6UZplI2BJVIXLE=;
 b=BsqarFCCXnnsOy1uQKUACC0RG4ZwL0kqXJPcsNYkNFFTV+jlHNf62ADfZ3ZJ9xB7
 kdW1Nr/nv7Yg4DsKFGeaZrVy2jhBq8bk7UGzZMCnzqA+/MSDX5/ZyhvWL55oY+x9Ttu
 daBkDrV+rQYzFMCdc+/0kudjF6o6sWPeyeMppHcQ=
Received: by smtp.zohomail.com with SMTPS id 179036194590339.126525813651256; 
 Fri, 25 Sep 2026 11:45:45 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 25 Sep 2026 19:45:24 +0100
Subject: [PATCH v11 03/15] drm/panfrost: Move debugfs initialisation to
 relevant subsystems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-claude-fixes-v11-3-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
In-Reply-To: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12684;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=KpBZvM+jDCQcDp+jAb4hb9VNZO+PYTWBYmA084H6WNg=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFDmIQ9oyBUBkTXPcCpAnhgi2D5Ql+txxpxN
 D5ETEww+OKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBQwAKCRAOJn5M7lND
 PUSEC/wK2j5WdRq4iMRVV6imZqnjsTDqwebGFTlNno7b9FrxGS+UN5PByiApV19j6jSLwUA+STq
 035wPGRgTuWHDSeNSAw23flnVgaxP0+ZG6WWr1+XQRLPXR4ucuQ4tTRdzwtalb+tTbCnP22N4fS
 kQf5GoChEggxvs9tawgpbXoOOg6o2Ib4ps37Ftr0rPM4t9bDb/zjL/d8+wsOCrcNxdgL/wpLBJX
 tLQOUC4+mFiAiOc42/GkSKZu5R8hJ/bOabxhlN/FdnpJa6IcDFHryUaDaL+trdlWJtYnmgmvwT7
 35Ka7/Izxh6nQCQBdIUYBpFdTKZNoDc0Ivv7DzumptbNEHgMxeGk2ev5Gzo4R5WzlvesIJnEs7B
 IyWKkRCfWFP73OhnafQ8v3nfgRJd9/dkrIruWsRwYzAinqya1/pempkNgJMwBKXMxTwHCRSLdx7
 r6FtKVxwA4LgAkWsArMBb9mEVpDbO02j89ZfTed+2rUctjTClafJwEVoRpTVOghL9Ran8=
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
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
index c1a2e93a2b9b..5bf528f41278 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -561,3 +561,11 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
 	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
 	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
 };
+
+#ifdef CONFIG_DEBUG_FS
+void panfrost_device_debugfs_init(struct drm_minor *minor)
+{
+	panfrost_gem_debugfs_init(minor);
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
index 59af79a534fa..55fc22e8d4d4 100644
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
index 383ac8cd5645..518f24549b9d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 
 #include <drm/panfrost_drm.h>
+#include <drm/drm_debugfs.h>
 #include <drm/drm_print.h>
 #include "panfrost_device.h"
 #include "panfrost_gem.h"
@@ -735,8 +736,8 @@ static void panfrost_gem_debugfs_bo_print(struct panfrost_gem_object *bo,
 		totals->reclaimable += resident_size;
 }
 
-void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
-				    struct seq_file *m)
+static void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
+					   struct seq_file *m)
 {
 	struct gem_size_totals totals = {0};
 	struct panfrost_gem_object *bo;
@@ -756,4 +757,28 @@ void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
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
+int panfrost_gem_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_create_files(panfrost_debugfs_list,
+				 ARRAY_SIZE(panfrost_debugfs_list),
+				 minor->debugfs_root, minor);
+
+	return 0;
+}
 #endif
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index 5c823cdbd980..3008afcf4bff 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -164,8 +164,7 @@ int panfrost_gem_sync(struct drm_gem_object *obj, u32 type,
 void panfrost_gem_internal_set_label(struct drm_gem_object *obj, const char *label);
 
 #ifdef CONFIG_DEBUG_FS
-void panfrost_gem_debugfs_print_bos(struct panfrost_device *pfdev,
-				    struct seq_file *m);
+int panfrost_gem_debugfs_init(struct drm_minor *minor);
 #endif
 
 #endif /* __PANFROST_GEM_H__ */
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 476c936b54e6..00fb36c577df 100644
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
 
@@ -1138,3 +1140,100 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
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

