Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054F8C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7F110EE5A;
	Tue, 14 Jul 2026 21:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EBoSN8Tn";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D0510EE62
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:16:40 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493ec555a26so30535615e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784063799; x=1784668599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wrK+Sd17cLzydvVRL/tfKym7HELklqSlzTyYKNyJadE=;
 b=EBoSN8TnB1S8OBgM27K/PmwVw+i5Cqvc0L6/js/TbXsby/lpxn6e/3VRyH4DvQfI+s
 MtgX7eG4CalYzwhp93uwgL4adzBugWXmNsVMH+cbUj7f5U4Y9OwMNs1Yx/bUJFq/3aOG
 MnhMg4KE4xWZ/gQ7wdBrGjk+0+XPIBnE2BTCFyFIXmKsif5fkxZfRpk8/edUgX3vYSj/
 DpVFED95ZwvDX9GRE8tWUJcZ4VoEYcF/ltxfhoWQHdxWsLR1KNHSnvJG/Linab6UaWTq
 oO67PvNCOcO/tzMkdOzwuf/rm0sc2UA5gt/T6EJjRSocigX1FL/QHXdDJlddMVwXp4TX
 JgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784063799; x=1784668599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wrK+Sd17cLzydvVRL/tfKym7HELklqSlzTyYKNyJadE=;
 b=JMqSVazEcCPVSIMCbaTac2ueimct+D3lQpJy715HSO4G8aVgdkpNjzizHUydaLpsHw
 HEeOEW66gSXSesX+QXeij8vHBWi3T0OaZ1xycsKmc3RSvu+gefCKzlvXPyzYkguFWnA5
 x4ZKHb7uU7sUta+JzSOLen114HmPxcEHB+VEccvbbrZVuFz5MwlJBLyAaccfXRRHodzn
 7xjrcth8IA1re/OMbjbWBVDOvFwMs3cBeoWN4I9hOo3foEHjefqc4aO3fnj2IV7UUYl1
 H8YLVQBtCH5rnUMZWSvhx1q6PFYZXCj0O0jBcqre3+xkqtv/8/uF/H4wY/QDQ6yXB23m
 ADwQ==
X-Gm-Message-State: AOJu0YwHrfjGzWSIo5GGXE2A/Ji/JNn/sHc5gevm6qZ2JPBsIE4sxrym
 AQsPogiUkFnoXEkgSnSnls6x/oNmHwj8yXoYmabL/euCso/rbRZfuftU
X-Gm-Gg: AfdE7cmk9hX+H4JRc4ioeP2A5P6fiUvZHJ9gtHtDANLr8Q8CtXqHJLlJ+ocu13b8mej
 TZ0ElH0Ji1rQbHL5JGTgnaU41eCmumjmq7EQ9EYqLRZHLoQukHD7Rs2qwLh7T2K5/n4r5k9JwES
 tl1kZ8Qxf/jhUAbRwTxPYvndUiQcqX7LFBhhmsZgZCAn2XCW1ee8at4g8AQiyHUnZaQUULDHX+r
 bGCVEZNzwBu4AYq5ohVXDKmbq9lFUm8K9SLYX+dKnoBOkmbZGrFkYCs9ezHfj3zR213WG4yPHGR
 SudPfg7aslP1JZsCMarfZhbSeqWYfTlWc1vrwrXDJpAda9lMgBBvTjlkjHuA8kmtSZDMj60TBhb
 8d2XPv41rucMjaeHvEDGJyykAYtagiqtFvkIR2a23PRUfuHfqpX4kVED/E6ZBrt1yHlZZlcLGH7
 lg8KOeCeBMReGntoMZbFP3
X-Received: by 2002:a05:600c:3e0d:b0:493:b499:3ef2 with SMTP id
 5b1f17b1804b1-4953c299474mr4035745e9.37.1784063798959; 
 Tue, 14 Jul 2026 14:16:38 -0700 (PDT)
Received: from fedora ([94.205.182.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm149843875e9.12.2026.07.14.14.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:16:38 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 6/6] drm/nouveau: expose per-client GPU usage via fdinfo
Date: Wed, 15 Jul 2026 01:14:29 +0400
Message-ID: <20260714211429.238355-7-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
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

nouveau implemented no DRM fdinfo. Wire it up and report per-client memory
and per-engine busy time, which monitoring tools consume generically.

Memory: add a GEM .status callback reporting residency and emit the
standard stats via drm_show_memory_stats(). This works for every client
regardless of submission path.

Engine busy time: account it from the DRM scheduler the EXEC/VM_BIND path
already uses, similar to amdgpu. Each job's drm_sched fence carries
scheduled/finished timestamps; (finished - scheduled) is folded into a
per-client per-engine counter when the job retires (nouveau_sched_free_
job, the per-job hook the scheduler always calls). In-flight jobs are
tracked on a per-client list and walked at fdinfo read time, adding
(now - scheduled) so a currently-running client is accounted without
waiting for its jobs to retire; the resulting non-monotonic correction
on retire is permitted by drm-usage-stats. The drm_sched core back-fills
the scheduled timestamp of in-order retiring jobs, so summing these
intervals approximates the channel's busy wall-clock.

The engine a job is accounted against is recorded on its channel at
allocation time. Only clients using the newer EXEC uAPI produce
drm-engine-* values, legacy GEM_PUSHBUF submissions bypass the scheduler
and are not accounted (memory still is). Of the engine classes the current
uAPI can select, gfx/ce/dec are reachable. enc/jpg/ofa are defined for
when per-engine channels become selectable.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 16 +++++
 drivers/gpu/drm/nouveau/nouveau_chan.h  |  2 +
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 19 ++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h   | 27 ++++++++
 drivers/gpu/drm/nouveau/nouveau_exec.c  |  3 +
 drivers/gpu/drm/nouveau/nouveau_gem.c   | 16 +++++
 drivers/gpu/drm/nouveau/nouveau_sched.c | 87 +++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_sched.h | 11 ++++
 8 files changed, 181 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 291203121f0c..63966444d45e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -439,6 +439,22 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 	if (ret)
 		goto done;
 
+	/* Record the channel's engine class for DRM fdinfo accounting. */
+	switch (engine) {
+	case NV_DEVICE_HOST_RUNLIST_ENGINES_CE:
+		chan->chan->fdinfo_engine = NOUVEAU_FDINFO_ENGINE_CE;
+		break;
+	case NV_DEVICE_HOST_RUNLIST_ENGINES_MSPDEC:
+	case NV_DEVICE_HOST_RUNLIST_ENGINES_MSVLD:
+	case NV_DEVICE_HOST_RUNLIST_ENGINES_MSPPP:
+		chan->chan->fdinfo_engine = NOUVEAU_FDINFO_ENGINE_DEC;
+		break;
+	case NV_DEVICE_HOST_RUNLIST_ENGINES_GR:
+	default:
+		chan->chan->fdinfo_engine = NOUVEAU_FDINFO_ENGINE_GFX;
+		break;
+	}
+
 	/* If we're not using the VM_BIND uAPI, we don't need a scheduler.
 	 *
 	 * The client lock is already acquired by nouveau_abi16_get().
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/nouveau/nouveau_chan.h
index bb34b0a6082d..22c484dd0bbe 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.h
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
@@ -20,6 +20,8 @@ struct nouveau_channel {
 	u64 inst;
 	u32 token;
 
+	u8 fdinfo_engine;
+
 	struct nvif_object vram;
 	struct nvif_object gart;
 	struct nvif_object nvsw;
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 49f73f295664..a0264496a7d6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -35,8 +35,10 @@
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_ttm.h>
+#include <drm/drm_file.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
 #include <core/gpuobj.h>
@@ -262,6 +264,9 @@ nouveau_cli_init(struct nouveau_drm *drm, const char *sname,
 	INIT_LIST_HEAD(&cli->worker);
 	mutex_init(&cli->lock);
 
+	spin_lock_init(&cli->fdinfo.lock);
+	INIT_LIST_HEAD(&cli->fdinfo.jobs);
+
 	mutex_lock(&drm->client_mutex);
 	ret = nvif_client_ctor(&drm->_client, cli->name, &cli->base);
 	mutex_unlock(&drm->client_mutex);
@@ -1347,6 +1352,18 @@ nouveau_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+static void
+nouveau_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct nouveau_cli *cli = nouveau_cli(file);
+
+	/* Per-engine busy time of this client's EXEC jobs, then the standard
+	 * per-region memory stats
+	 */
+	nouveau_sched_show_fdinfo(cli, p);
+	drm_show_memory_stats(p, file);
+}
+
 static const struct file_operations
 nouveau_driver_fops = {
 	.owner = THIS_MODULE,
@@ -1360,6 +1377,7 @@ nouveau_driver_fops = {
 	.compat_ioctl = nouveau_compat_ioctl,
 #endif
 	.llseek = noop_llseek,
+	.show_fdinfo = drm_show_fdinfo,
 	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
@@ -1372,6 +1390,7 @@ driver_stub = {
 			   DRIVER_RENDER,
 	.open = nouveau_drm_open,
 	.postclose = nouveau_drm_postclose,
+	.show_fdinfo = PTR_IF(IS_ENABLED(CONFIG_PROC_FS), nouveau_show_fdinfo),
 
 #if defined(CONFIG_DEBUG_FS)
 	.debugfs_init = nouveau_drm_debugfs_init,
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index a8ca86556e2f..ced15ee1aa65 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -65,6 +65,19 @@
 struct nouveau_channel;
 struct platform_device;
 
+/* Engine classes tracked for DRM fdinfo per-client utilisation. The value
+ * NOUVEAU_FDINFO_ENGINE_COUNT doubles as "not accounted"
+ */
+enum nouveau_fdinfo_engine {
+	NOUVEAU_FDINFO_ENGINE_GFX,	/* graphics/compute (GR) */
+	NOUVEAU_FDINFO_ENGINE_CE,	/* copy */
+	NOUVEAU_FDINFO_ENGINE_DEC,	/* video decode */
+	NOUVEAU_FDINFO_ENGINE_ENC,	/* video encode */
+	NOUVEAU_FDINFO_ENGINE_JPG,	/* jpeg */
+	NOUVEAU_FDINFO_ENGINE_OFA,	/* optical flow */
+	NOUVEAU_FDINFO_ENGINE_COUNT,
+};
+
 #include "nouveau_fence.h"
 #include "nouveau_bios.h"
 #include "nouveau_sched.h"
@@ -114,6 +127,20 @@ struct nouveau_cli {
 	struct work_struct work;
 	struct list_head worker;
 	struct mutex lock;
+
+	/* Per-client engine busy-time accounting for DRM fdinfo.
+	 *
+	 * @engine_ns holds the accumulated busy time of retired jobs per
+	 * engine; @jobs is the list of in-flight jobs, walked at fdinfo read
+	 * time to additionally account currently-running work. Both are
+	 * protected by @lock (a leaf spinlock taken from the job free path and
+	 * from the fdinfo show callback)
+	 */
+	struct {
+		spinlock_t lock;
+		struct list_head jobs;
+		u64 engine_ns[NOUVEAU_FDINFO_ENGINE_COUNT];
+	} fdinfo;
 };
 
 struct nouveau_cli_work {
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index a08ab1cfea9b..1215f0669d0d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -255,6 +255,9 @@ nouveau_exec_job_init(struct nouveau_exec_job **pjob,
 	if (ret)
 		goto err_free_pushs;
 
+	/* Account this job's busy time against the channel's engine in fdinfo */
+	job->base.engine = job->chan->fdinfo_engine;
+
 	return 0;
 
 err_free_pushs:
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 20dba02d6175..76fbde516722 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -214,10 +214,26 @@ nouveau_gem_object_close(struct drm_gem_object *gem, struct drm_file *file_priv)
 	ttm_bo_unreserve(&nvbo->bo);
 }
 
+static enum drm_gem_object_status
+nouveau_gem_object_status(struct drm_gem_object *gem)
+{
+	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
+	enum drm_gem_object_status status = 0;
+
+	/* nouveau has no userspace madvise/purgeable concept, so only
+	 * residency is reported
+	 */
+	if (nvbo->bo.resource)
+		status |= DRM_GEM_OBJECT_RESIDENT;
+
+	return status;
+}
+
 const struct drm_gem_object_funcs nouveau_gem_object_funcs = {
 	.free = nouveau_gem_object_del,
 	.open = nouveau_gem_object_open,
 	.close = nouveau_gem_object_close,
+	.status = nouveau_gem_object_status,
 	.export = nouveau_gem_prime_export,
 	.pin = nouveau_gem_prime_pin,
 	.unpin = nouveau_gem_prime_unpin,
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 2cbae003d6de..219cc8f621ce 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: MIT
 
+#include <linux/ktime.h>
 #include <linux/slab.h>
+#include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
 #include <drm/drm_syncobj.h>
 
@@ -22,6 +24,64 @@ enum nouveau_sched_priority {
 	NOUVEAU_SCHED_PRIORITY_COUNT,
 };
 
+/* Busy time of a single job for fdinfo accounting: (finished - scheduled)
+ * once the job has retired, or (now - scheduled) while it is still running
+ *
+ * The drm_sched core back-fills the scheduled timestamp of an in-order
+ * retiring job with the previous job's finished timestamp, so summing these
+ * intervals over a channel's jobs approximates its busy wall-clock without
+ * double counting work that overlapped in the pipe
+ */
+static u64
+nouveau_job_busy_ns(struct nouveau_job *job)
+{
+	struct drm_sched_fence *s_fence = job->base.s_fence;
+
+	if (!s_fence ||
+	    !test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
+		return 0;
+
+	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
+		return ktime_to_ns(ktime_sub(ktime_get(),
+					     s_fence->scheduled.timestamp));
+
+	return ktime_to_ns(ktime_sub(s_fence->finished.timestamp,
+				     s_fence->scheduled.timestamp));
+}
+
+static const char * const
+nouveau_fdinfo_engine_name[NOUVEAU_FDINFO_ENGINE_COUNT] = {
+	[NOUVEAU_FDINFO_ENGINE_GFX] = "gfx",
+	[NOUVEAU_FDINFO_ENGINE_CE]  = "ce",
+	[NOUVEAU_FDINFO_ENGINE_DEC] = "dec",
+	[NOUVEAU_FDINFO_ENGINE_ENC] = "enc",
+	[NOUVEAU_FDINFO_ENGINE_JPG] = "jpg",
+	[NOUVEAU_FDINFO_ENGINE_OFA] = "ofa",
+};
+
+void
+nouveau_sched_show_fdinfo(struct nouveau_cli *cli, struct drm_printer *p)
+{
+	u64 engine_ns[NOUVEAU_FDINFO_ENGINE_COUNT];
+	struct nouveau_job *job;
+	unsigned int i;
+
+	spin_lock(&cli->fdinfo.lock);
+	for (i = 0; i < NOUVEAU_FDINFO_ENGINE_COUNT; i++)
+		engine_ns[i] = cli->fdinfo.engine_ns[i];
+
+	/* Add the busy time of currently in-flight jobs so a running client is
+	 * accounted without waiting for its jobs to retire
+	 */
+	list_for_each_entry(job, &cli->fdinfo.jobs, fdinfo_entry)
+		engine_ns[job->engine] += nouveau_job_busy_ns(job);
+	spin_unlock(&cli->fdinfo.lock);
+
+	for (i = 0; i < NOUVEAU_FDINFO_ENGINE_COUNT; i++)
+		drm_printf(p, "drm-engine-%s:\t%llu ns\n",
+			   nouveau_fdinfo_engine_name[i], engine_ns[i]);
+}
+
 int
 nouveau_job_init(struct nouveau_job *job,
 		 struct nouveau_job_args *args)
@@ -30,6 +90,8 @@ nouveau_job_init(struct nouveau_job *job,
 	int ret;
 
 	INIT_LIST_HEAD(&job->entry);
+	INIT_LIST_HEAD(&job->fdinfo_entry);
+	job->engine = NOUVEAU_FDINFO_ENGINE_COUNT;
 
 	job->file_priv = args->file_priv;
 	job->cli = nouveau_cli(args->file_priv);
@@ -308,6 +370,16 @@ nouveau_job_submit(struct nouveau_job *job)
 	list_add(&job->entry, &sched->job.list.head);
 	spin_unlock(&sched->job.list.lock);
 
+	/* Track in-flight jobs for fdinfo per-engine accounting. The job is
+	 * removed (and its busy time folded in) from nouveau_sched_free_job(),
+	 * which the scheduler guarantees to call once for every pushed job.
+	 */
+	if (job->engine < NOUVEAU_FDINFO_ENGINE_COUNT) {
+		spin_lock(&job->cli->fdinfo.lock);
+		list_add_tail(&job->fdinfo_entry, &job->cli->fdinfo.jobs);
+		spin_unlock(&job->cli->fdinfo.lock);
+	}
+
 	drm_sched_job_arm(&job->base);
 	job->done_fence = dma_fence_get(&job->base.s_fence->finished);
 	if (job->sync)
@@ -388,6 +460,21 @@ nouveau_sched_free_job(struct drm_sched_job *sched_job)
 {
 	struct nouveau_job *job = to_nouveau_job(sched_job);
 
+	/* Fold the retired job's busy time into the per-client per-engine
+	 * counter and stop tracking it as in-flight. Done before
+	 * nouveau_job_fini() since that releases the scheduler fences this
+	 * reads. The job's finished fence has signalled by now, so
+	 * nouveau_job_busy_ns() returns (finished - scheduled)
+	 */
+	if (job->engine < NOUVEAU_FDINFO_ENGINE_COUNT) {
+		struct nouveau_cli *cli = job->cli;
+
+		spin_lock(&cli->fdinfo.lock);
+		cli->fdinfo.engine_ns[job->engine] += nouveau_job_busy_ns(job);
+		list_del(&job->fdinfo_entry);
+		spin_unlock(&cli->fdinfo.lock);
+	}
+
 	nouveau_job_fini(job);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 20cd1da8db73..fa80f9b996b1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -56,6 +56,14 @@ struct nouveau_job {
 	struct drm_file *file_priv;
 	struct nouveau_cli *cli;
 
+	/* fdinfo per-engine busy-time accounting: @engine is the engine class
+	 * this job runs on (NOUVEAU_FDINFO_ENGINE_COUNT == not accounted)
+	 * @fdinfo_entry links the job into cli->fdinfo.jobs while it is in
+	 * flight.
+	 */
+	enum nouveau_fdinfo_engine engine;
+	struct list_head fdinfo_entry;
+
 	enum dma_resv_usage resv_usage;
 	struct dma_fence *done_fence;
 
@@ -96,6 +104,9 @@ int nouveau_job_submit(struct nouveau_job *job);
 void nouveau_job_done(struct nouveau_job *job);
 void nouveau_job_free(struct nouveau_job *job);
 
+struct drm_printer;
+void nouveau_sched_show_fdinfo(struct nouveau_cli *cli, struct drm_printer *p);
+
 struct nouveau_sched {
 	struct drm_gpu_scheduler base;
 	struct drm_sched_entity entity;
-- 
2.55.0

