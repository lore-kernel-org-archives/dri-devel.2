Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C43606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=B2iEMcPT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC38810E091;
	Sat, 31 Oct 2026 08:37:15 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FD210E091
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 08:37:09 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36661f953e4so2272847eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1793435829; x=1794040629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JGTlKeifjArZrE5QjdVxeEEwfoKkEK/kcyQWuyAcxng=;
 b=B2iEMcPTgqLrnX+88ylZc1yaTb3d4AmT6cQH1DnJgzU8ZvXsYB8bXG8afMK4/apieP
 ZV52V2qK2gaVZ9X7c7M13WIrTe6xIQtKrvfhCIJ43q2dGdHYdPgSZU8vD050JTqavFUr
 Y5CbLPXS2qzrNe0K9Rr8UKTUd+m1LOrtdoSbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793435829; x=1794040629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGTlKeifjArZrE5QjdVxeEEwfoKkEK/kcyQWuyAcxng=;
 b=yNEhThE6aobt7tkMI/ICZwxgRlLuZ6M2X/6LuEeuixzhA7sVJ0/J5LRmJBOaouBJSs
 ZbLuyiAaqHi8IuBxCJCnXQZC/dQizB9+Z8lFNvmVITYIsALnOHgeNrtfwJCXxP+TnldF
 6RodMiGP4DbWbOhbWWOQ+Klw6Ai4BWvrbuIoso9XYuYqjGxVXsONaDkR58Ek0ISf7i0D
 EBskJ7SBXfiyv8Wz/Uh1VvAWKjUiGElscfPa6Y1q8mHfXBHnGbYLJo/uu10mvTr8P0bp
 pYc/GA8L8b4r348KijBSSbytdrjjiSQUQBxY+pb0poSF1g+mu9uMhMJ1dsg+5ilsVjio
 rxHw==
X-Gm-Message-State: AFq9FYKCiW36JBoOlZ6zUzxuENQ4MjcMeckkYtCu7Ri9o4IMFr+hElml
 /j9kgoLk6Ee1qbpzGvWAAxNxRJK2Tb902kDh7VVhd8si20TOOvE2+M5Zl7PdXgBnebM=
X-Gm-Gg: AYBFou0BIi35k0V8OfD8WWmpS7OPL/rvLmyR/lrTTDi4lwIDIWEJmq+hxcmzJMZwn9M
 DiII24BpIVA75wT5xIl23xYgNHfUkO1inYBJBWmTq4XnwMPO8H+5QVCiTlxl5ykZygVE+Q7Licj
 ZUZmO70iXZWBqUk+5WknicO02uW8D7TcKxYdlWnsAclTXcBuHMz/pdREihiiz/ArpLcyhC/3KDI
 KOrccbqAjhmkAVOTuWrgIvAoMq7rrYFpLC/lhaLJWN6cMFpycz3qeOZvQi08qSfXmOSGFmJdWH8
 tGDm7BAukGfDDLFcjnxKwf7POCxKrCud37P/jXROUfYWStjH9lxwQkU8TPWhiq4GXxbdeOCbDqq
 S8uS5gMZfTRn3Wy3A30/mdJ7rIMInOZ9cC3g3pk9egXH9kAXmqOEQIAmE1G5SjNz9/d/1t5EoVO
 QUD/jii11HK+fvyCTW6kfTr7o40pEvzLyjjLtCGdylUn/YSLq0qKE33dhEv8Chi3runqYt2iMbg
 +qT7ZDfaQwjSgzXsuxxwj1g4JKWTc79kjcnYuoMgsq7U8ES3y1F55A9wzGW6ThIylL0iJpX2xFX
 YtWQtnMPO0th7fy2qdjCK6BFDoG4sqI=
X-Received: by 2002:a05:693c:414f:20b0:369:e930:6bc4 with SMTP id
 5a478bee46e88-36a423f6f4amr7002919eec.30.1793435828892; 
 Sat, 31 Oct 2026 01:37:08 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm14322826eec.18.2026.10.31.01.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 01:37:08 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH] accel/rocket: Report per-core engine usage through fdinfo
Date: Sat, 31 Oct 2026 17:36:42 +0900
Message-ID: <20261031083642.1076356-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is no way to tell how much of the NPU a client uses, or whether its
jobs reach more than one core. Implement the DRM usage stats: account the
time each job occupies a core and report it per client as
drm-engine-npu<n>, along with drm_show_memory_stats() for the BOs.

Jobs can outlive the file that submitted them, so the counters are
refcounted and each job holds a reference. The time covers the whole
period a job owns a core, so it also includes handling the completion
interrupt and the gaps between the tasks of a multi-task job.

For example, teflon running a model two operations deep 3001 times gives:

  drm-engine-npu0:	22719385 ns
  drm-engine-npu1:	23345296 ns
  drm-engine-npu2:	0 ns

The NPU is busy 15.6% of the wall clock time and one core is never used.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_drv.c | 60 +++++++++++++++++++++++++++++--
 drivers/accel/rocket/rocket_drv.h | 14 ++++++++
 drivers/accel/rocket/rocket_job.c |  7 ++++
 drivers/accel/rocket/rocket_job.h |  4 +++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883..5b81d1ecc0e4 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -3,8 +3,10 @@
 
 #include <drm/drm_accel.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
 #include <drm/rocket_accel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -68,6 +70,25 @@ rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
 	kref_put(&domain->kref, rocket_iommu_domain_destroy);
 }
 
+static void
+rocket_engine_usage_destroy(struct kref *kref)
+{
+	kfree(container_of(kref, struct rocket_engine_usage, kref));
+}
+
+struct rocket_engine_usage *
+rocket_engine_usage_get(struct rocket_file_priv *rocket_priv)
+{
+	kref_get(&rocket_priv->engine_usage->kref);
+	return rocket_priv->engine_usage;
+}
+
+void
+rocket_engine_usage_put(struct rocket_engine_usage *usage)
+{
+	kref_put(&usage->kref, rocket_engine_usage_destroy);
+}
+
 static int
 rocket_open(struct drm_device *dev, struct drm_file *file)
 {
@@ -86,10 +107,19 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
 	}
 
 	rocket_priv->rdev = rdev;
+
+	rocket_priv->engine_usage = kzalloc_flex(*rocket_priv->engine_usage,
+						 elapsed_ns, rdev->num_cores);
+	if (!rocket_priv->engine_usage) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+	kref_init(&rocket_priv->engine_usage->kref);
+
 	rocket_priv->domain = rocket_iommu_domain_create(rdev->cores[0].dev);
 	if (IS_ERR(rocket_priv->domain)) {
 		ret = PTR_ERR(rocket_priv->domain);
-		goto err_free;
+		goto err_put_engine_usage;
 	}
 
 	file->driver_priv = rocket_priv;
@@ -109,6 +139,8 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
 	mutex_destroy(&rocket_priv->mm_lock);
 	drm_mm_takedown(&rocket_priv->mm);
 	rocket_iommu_domain_put(rocket_priv->domain);
+err_put_engine_usage:
+	rocket_engine_usage_put(rocket_priv->engine_usage);
 err_free:
 	kfree(rocket_priv);
 err_put_mod:
@@ -125,6 +157,7 @@ rocket_postclose(struct drm_device *dev, struct drm_file *file)
 	mutex_destroy(&rocket_priv->mm_lock);
 	drm_mm_takedown(&rocket_priv->mm);
 	rocket_iommu_domain_put(rocket_priv->domain);
+	rocket_engine_usage_put(rocket_priv->engine_usage);
 	kfree(rocket_priv);
 	module_put(THIS_MODULE);
 }
@@ -139,7 +172,29 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 	ROCKET_IOCTL(FINI_BO, fini_bo),
 };
 
-DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
+static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct rocket_device *rdev = to_rocket_device(file->minor->dev);
+	struct rocket_file_priv *rocket_priv = file->driver_priv;
+	unsigned int core;
+
+	/*
+	 * These are estimates: the time is taken around the whole period a job
+	 * occupies a core, so it also covers handling the completion interrupt
+	 * and, for a job made of several tasks, the gaps between them.
+	 */
+	for (core = 0; core < rdev->num_cores; core++)
+		drm_printf(p, "drm-engine-npu%u:\t%llu ns\n", core,
+			   rocket_priv->engine_usage->elapsed_ns[core]);
+
+	drm_show_memory_stats(p, file);
+}
+
+static const struct file_operations rocket_accel_driver_fops = {
+	.owner = THIS_MODULE,
+	DRM_ACCEL_FOPS,
+	.show_fdinfo = drm_show_fdinfo,
+};
 
 /*
  * Rocket driver version:
@@ -150,6 +205,7 @@ static const struct drm_driver rocket_drm_driver = {
 	.open			= rocket_open,
 	.postclose		= rocket_postclose,
 	.gem_create_object	= rocket_gem_create_object,
+	.show_fdinfo		= rocket_show_fdinfo,
 	.ioctls			= rocket_drm_driver_ioctls,
 	.num_ioctls		= ARRAY_SIZE(rocket_drm_driver_ioctls),
 	.fops			= &rocket_accel_driver_fops,
diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99ccc..eff5c2ac54d1 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -16,6 +16,15 @@ struct rocket_iommu_domain {
 	struct kref kref;
 };
 
+/*
+ * Time each core has spent running a client's jobs, in nanoseconds, indexed by
+ * core. Jobs hold a reference, as they can outlive the file that submitted them.
+ */
+struct rocket_engine_usage {
+	struct kref kref;
+	u64 elapsed_ns[];
+};
+
 struct rocket_file_priv {
 	struct rocket_device *rdev;
 
@@ -24,9 +33,14 @@ struct rocket_file_priv {
 	struct mutex mm_lock;
 
 	struct drm_sched_entity sched_entity;
+
+	struct rocket_engine_usage *engine_usage;
 };
 
 struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv);
 void rocket_iommu_domain_put(struct rocket_iommu_domain *domain);
 
+struct rocket_engine_usage *rocket_engine_usage_get(struct rocket_file_priv *rocket_priv);
+void rocket_engine_usage_put(struct rocket_engine_usage *usage);
+
 #endif
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ce994748dd5d..c0ffbccfb6cc 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -13,6 +13,7 @@
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/clock.h>
 
 #include "rocket_core.h"
 #include "rocket_device.h"
@@ -265,6 +266,7 @@ static void rocket_job_cleanup(struct kref *ref)
 	unsigned int i;
 
 	rocket_iommu_domain_put(job->domain);
+	rocket_engine_usage_put(job->engine_usage);
 
 	dma_fence_put(job->done_fence);
 	dma_fence_put(job->inference_done_fence);
@@ -351,6 +353,7 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 
 	scoped_guard(mutex, &core->job_lock) {
 		core->in_flight_job = job;
+		job->start_ns = local_clock();
 		rocket_job_hw_submit(core, job);
 	}
 
@@ -379,6 +382,9 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 				return;
 			}
 
+			core->in_flight_job->engine_usage->elapsed_ns[core->index] +=
+				local_clock() - core->in_flight_job->start_ns;
+
 			iommu_detach_group(NULL, iommu_group_get(core->dev));
 			dma_fence_signal(core->in_flight_job->done_fence);
 			pm_runtime_put_autosuspend(core->dev);
@@ -587,6 +593,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 
 	rjob->rdev = rdev;
 	rjob->domain = rocket_iommu_domain_get(file_priv);
+	rjob->engine_usage = rocket_engine_usage_get(file_priv);
 
 	ret = drm_sched_job_init(&rjob->base,
 				 &file_priv->sched_entity,
diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/rocket_job.h
index 4ae00feec3b9..14aa78aebc99 100644
--- a/drivers/accel/rocket/rocket_job.h
+++ b/drivers/accel/rocket/rocket_job.h
@@ -38,6 +38,10 @@ struct rocket_job {
 
 	struct rocket_iommu_domain *domain;
 
+	/* When the job was handed to a core, and where to account the time */
+	u64 start_ns;
+	struct rocket_engine_usage *engine_usage;
+
 	struct kref refcount;
 };
 

base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
-- 
2.53.0

