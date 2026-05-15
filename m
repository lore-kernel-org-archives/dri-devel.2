Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189EDCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F98010F563;
	Fri, 15 May 2026 15:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="V2sqb+kr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABDE10F55C
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r/1HeWLU1dTDy8jp0AqyVuXeq3BFTN0vMnIeW3li62E=; b=V2sqb+krI6m5NPNvh31PIBp3eI
 9y10N1dapvOePR8t2IWNdyfTxESKDgeX+3jKQXERPhFCjYjY+3L6/MtiVtP5rGf6TmHoFzS7oq6v5
 Mp5fwqfGWPmZSdzoaSHVLU2o5UmFprXhdaIJAhS+UWkQ1YbN7W4R3NKkeYq/OAggnBvxXiP19BJq5
 XDE0Roy7Pna9W8RjdnUZMg0Im3f0WWwNSPTbboNpkBp5sbc1FQ6r0zh7MBo6P1pfiAcPXmtRx+zc5
 5YmjajKNtqBNSUkoz4UgSQQD1X+/364Sc3GroMx7I7QXBMA58OBX5vdURmTlfNQJknJ7EHc7w6NmW
 5zQk4AVw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wNu9I-000ZQ7-Be; Fri, 15 May 2026 17:08:24 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 15 May 2026 12:07:14 -0300
Subject: [PATCH 1/2] drm/v3d: Fix use-after-free of CPU job query arrays on
 error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-v3d-cpu-job-leaks-v1-1-7f147cbbf935@igalia.com>
References: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
In-Reply-To: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4172; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=DwCvExWXLFFuCRVHV5nir81rx8AjQn6nd8Org2LSa0o=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFnsZo/uzDM6nyd8ubv1nU2Wt1zVVI7z1457tZY83yIq3
 cHIITGjk9GYhYGRi0FWTJHlx5PYWkaxcnbNZeUXYQaxMoFMYeDiFICJKOhzMFwR2eRa1Chp5mi8
 tP6fhpWwullBBi+L3IVyhq3dUooaAR+PxtxMeVlgK8f1xeyP9uUojafsW/gTPtZJ5zxt+8Ywz+l
 X07Xl0r+PduWe0+uw0mPK6Ll88oOosFitWOklGUdr/mAti6Uuu/mPVRSW7yjolffdXZf0+fKnzm
 ttz+cZTEvz378hVmCOvUvx/mUiHCuFN06Mfi+k1by0bta7xOVPb21a2NKSfGjytdpX/Y3yh7utd
 k2XUJ2v8zm9m63Xcr7ZjXOztxu5nN719qSXzv7QbVctA+bvmvFVYM8iyeDZ7L/t/WROSLN5+Mgr
 FCrP7jtqPi+GK/ZimecJUfn6hMdnz5bYCSrmCkg1/+8BAA==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The CPU job ioctl's fail label calls kvfree() on cpu_job's timestamp and
performance query arrays after v3d_job_cleanup(), which drops the job's
last reference and frees cpu_job. Reading cpu_job at that point is a
use-after-free. Also, on the early v3d_job_init() failure path, it is a
NULL dereference, since v3d_job_deallocate() zeroes the local pointer.

In the success path, the arrays are released from the scheduler's
.free_job callback, but on the error path, they are freed manually, as
the job was never pushed to the scheduler. While the success path deals
with this correctly, the fail path doesn't.

On top of that, the manual kvfree() calls only free the array storage;
they don't drm_syncobj_put() the per-query syncobjs that
v3d_timestamp_query_info_free() and v3d_performance_query_info_free()
release on the success path. So the same fail path that triggers the
use-after-free also leaks one syncobj reference per query.

Unify the CPU job teardown into the CPU job's kref destructor, mirroring
v3d_render_job_free(). The scheduler's .free_job slot reverts to the
generic v3d_sched_job_free() and the fail label drops the manual
kvfree() calls, leaving a single teardown path that is reached from both
the scheduler and the ioctl error path. That removes the use-after-free,
the NULL dereference, and the syncobj leak by construction.

Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c  | 16 +---------------
 drivers/gpu/drm/v3d/v3d_submit.c | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 1855ef5b3b5f..94bf628dc91c 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -125,20 +125,6 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
 	}
 }
 
-static void
-v3d_cpu_job_free(struct drm_sched_job *sched_job)
-{
-	struct v3d_cpu_job *job = to_cpu_job(sched_job);
-
-	v3d_timestamp_query_info_free(&job->timestamp_query,
-				      job->timestamp_query.count);
-
-	v3d_performance_query_info_free(&job->performance_query,
-					job->performance_query.count);
-
-	v3d_job_cleanup(&job->base);
-}
-
 static void
 v3d_switch_perfmon(struct v3d_dev *v3d, struct v3d_job *job)
 {
@@ -830,7 +816,7 @@ static const struct drm_sched_backend_ops v3d_cache_clean_sched_ops = {
 
 static const struct drm_sched_backend_ops v3d_cpu_sched_ops = {
 	.run_job = v3d_cpu_job_run,
-	.free_job = v3d_cpu_job_free
+	.free_job = v3d_sched_job_free
 };
 
 static int
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee4512db294b..e3a6e7cc7bd5 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -123,6 +123,21 @@ v3d_render_job_free(struct kref *ref)
 	v3d_job_free(ref);
 }
 
+static void
+v3d_cpu_job_free(struct kref *ref)
+{
+	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
+					       base.refcount);
+
+	v3d_timestamp_query_info_free(&job->timestamp_query,
+				      job->timestamp_query.count);
+
+	v3d_performance_query_info_free(&job->performance_query,
+					job->performance_query.count);
+
+	v3d_job_free(ref);
+}
+
 void v3d_job_cleanup(struct v3d_job *job)
 {
 	if (!job)
@@ -1302,7 +1317,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
 
 	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
-			   v3d_job_free, 0, &se, V3D_CPU);
+			   v3d_cpu_job_free, 0, &se, V3D_CPU);
 	if (ret) {
 		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
@@ -1385,8 +1400,6 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	v3d_job_cleanup((void *)csd_job);
 	v3d_job_cleanup(clean_job);
 	v3d_put_multisync_post_deps(&se);
-	kvfree(cpu_job->timestamp_query.queries);
-	kvfree(cpu_job->performance_query.queries);
 
 	return ret;
 }

-- 
2.54.0

