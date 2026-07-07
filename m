Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE82DC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BFF10EC35;
	Tue,  7 Jul 2026 22:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrSfnDbH";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54DB10EC35
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 22:13:47 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-51bfe810293so23436031cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783462426; x=1784067226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1LaC9IIFzyk6p/WaQGjqPnbklVJuUu7ipxHSql4Nv4U=;
 b=LrSfnDbHsau3juAOw+YHamKgU8FrotBA2cULuw9lyHwiOyjNqexmunf+PgL+6uwn9F
 ijc1sy9rsPV6xbdXE9S7V6Tn3deyHEB0ZoMMSIIfE9T4XDgdkFWByUnSucqTgobdmt6T
 n9N67XRfMH6y+1RL42GEMfFCsPDLVg/Ma1F5VyihdsH/s0/X0YWFRm46p1hwDHpKGcJH
 /QnfCB0KCcohz0FCHxwP7Vb926Qovr4hGpp9sE3fQma1byEGKyDmOVdQ0d4slgkuY102
 MtRXkDm0gnvvx/k4SXvM4Yb0sZVB2ZrMhONjywK/WxD5ulFyIKdojN/qqnW1ALnjST4y
 LlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783462426; x=1784067226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1LaC9IIFzyk6p/WaQGjqPnbklVJuUu7ipxHSql4Nv4U=;
 b=p3j79C5qzZOCSAp3POaCgN1CNbdunC8T2sBaq7Qbcmb4m19ITIZmfI1sux1YMeErqf
 ED0lacl2t2B2cDzG6nI8mC52DS4aGNwolJJDBrIAJ6HHXjtSt9fzDnOgi0aMHF/xFFyt
 aORDWkmo/WJVo6AMdXm65Uq8uB0B34CX3t5qKqAyVlBWuQ3Xx03ksjIrLkhxEq10kkpD
 ou/FfFAYpPsz055YokRLb2qHHOxAt+gfkKHn1QRVoAz3QM/0U2Ccis6YvAFfYngiuvjr
 szaqTa3vTyDv6WhQ8zd0xPZZAyhaa55rpjRL/RtsF4FhiEh09fKA5w8IKSN7WCbIvj7T
 2YWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxubLyO8OFq9Uvs7kGyIOfPjCCGHVWVeWkBGQq3BSbKy5gcane0O9D0f89PWUTBHhBuST8dTjITSg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2S+ryajC2pgHV13hGi4T7K2eI/3j9zn+xseBVOA8w1v638yC+
 g5nUxXxxMLhPHBPzD8wPAXqveC48KyeZn9yihilaVnvnHR/DVhitIUS7
X-Gm-Gg: AfdE7cnZ91MJcXdTISTi2eyI5fhoa1xkc024zYaqkIDnhNKO4wOZQ2l9E+S4ES4rVu8
 JjhTgofUcWtHy+k94Yg19LaXoCtGKD06ohaxgUPcpQO09s2vywjHfECEghrtRFR44RsqQmGn1RY
 EoPByl37+TDgzhuE6MNr4TGz/hMYivfnMrXaX+zz2X6bG9jZ+my2HxcK2C9G5P5qRrIxbe1k76t
 yCAC7jixUheYHQDHzLRjbvYmVQLBTTFCTimYlYryM0W5eXfJpkJHtbh9pHkcQhnmgEyF9Le+Nt/
 p1YKj+ZJuM7W2tiTeZvnyS6AyZJ4GoQeXDiavr8Rb0M08FNMoXscxyVylVRXGLIhrPC+heCe8J8
 RvpNToQKIbdHkTMSHdNryi5TnB1G8XdHNQTxFaHKgFh8ANxXcUqNJyu5FllxCJTVjt9J4s3rZ1S
 3e27Iw6WbOaUxpOghpauC7fcugnqogOZt6lWIAWe/E2CKLE6zVpAHVQihO0tAqFZMWW/KYZxPa5
 c76ggEYWEW3uk8XVC4fY4BLy6GnU7TC
X-Received: by 2002:ac8:57d3:0:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-51c8b2ec1a2mr706861cf.28.1783462426371; 
 Tue, 07 Jul 2026 15:13:46 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41df52a6sm119682621cf.27.2026.07.07.15.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:13:45 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	Maira Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] drm/v3d: bound CPU-job query writes to their destination BO
Date: Tue,  7 Jul 2026 18:13:34 -0400
Message-ID: <20260707221334.3854433-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

The V3D_SUBMIT_CPU CPU jobs take user-supplied offsets and indices and
consume them at exec time without checking that the accesses stay inside
their BO:

  - TIMESTAMP_QUERY and RESET_TIMESTAMP_QUERY write one u64 per query
    into bo[0] at a fully user-controlled per-query offset.
  - COPY_TIMESTAMP_QUERY copies one u64 per query into bo[0] at
    offset + i * stride, and reads each result from a user-controlled
    offset in the source bo[1].
  - COPY_PERFORMANCE_QUERY writes nperfmons * DRM_V3D_MAX_PERF_COUNTERS
    counter slots plus an availability slot into bo[0] at the same
    geometry.
  - INDIRECT_CSD reads three u32 work-group counts from bo[0] at a
    user-controlled offset, then writes each count back into the
    indirect BO at a user-controlled u32 index (wg_uniform_offsets[]).

A render-node user (DRM_RENDER_ALLOW, no master, no capability) can make
the handlers read or write past a BO's vmap mapping.

Validate the full access extent against the BO size once the BOs are
looked up, before the job is queued, rejecting out-of-range geometry
with -EINVAL. The copy extent offset + (count - 1) * stride + write_size
is computed in u64, mirroring the u8 * pointer arithmetic in the
executors: (count - 1) * stride is a u32 * u32 product that is exact in
u64, so one overflow check on the total guards the bound. The
performance slot count and the bare timestamp, copy-source and indirect
offsets are computed in u64 the same way, so a user value cannot wrap
the comparison.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Fixes: 34a101e64296 ("drm/v3d: Create a CPU job extension for the reset timestamp job")
Fixes: 6745f3e44a20 ("drm/v3d: Create a CPU job extension to copy timestamp query to a buffer")
Fixes: 209e8d2695ee ("drm/v3d: Create a CPU job extension for the copy performance query job")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v4:
 - Rebase onto drm-misc-next (Maira Canal): this is a fix, but a
   reasonably large change and not a critical bug.
 - Reconcile with the "drm/v3d: Miscellaneous fixes" series [1]. Drop the
   INDIRECT_CSD NULL indirect-BO reject: [1] patch 2/3 ("drm/v3d: Reject
   invalid indirect BO handle in indirect CSD setup") already returns
   -ENOENT for a bad handle at parse time, so that check is redundant.
   This patch assumes that series lands first. The out-of-bounds
   offset/index checks here are still novel and unfixed by [1].
 - Declare the loop index i as u32 rather than int (Sashiko, Maira
   Canal): a signed index could go negative once count exceeds INT_MAX.
 - Trim the TIMESTAMP_QUERY comment and restore the v2 wording of the
   COPY_PERFORMANCE_QUERY comment (Maira Canal).
 - INDIRECT_CSD: name the rewrite target dst and the counts BO src, add
   the "3 == x, y, z workgroup dims" and 0xffffffff-sentinel comments,
   and rename the local to indirect_csd (Maira Canal).

[1] https://lore.kernel.org/dri-devel/20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com/
v3: https://lore.kernel.org/all/20260617125811.3692951-1-michael.bommarito@gmail.com/
v2: https://lore.kernel.org/all/20260614211644.217116-1-michael.bommarito@gmail.com/
v1: https://lore.kernel.org/all/20260614131058.2525157-1-michael.bommarito@gmail.com/

 drivers/gpu/drm/v3d/v3d_submit.c | 126 +++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed50..277823b774bed 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2023 Raspberry Pi
  */
 
+#include <linux/overflow.h>
+
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
 
@@ -1300,6 +1302,126 @@ static const unsigned int cpu_job_bo_handle_count[] = {
 	[V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY] = 1,
 };
 
+/* Reject offset + (count - 1) * stride + write_size if it leaves the BO. */
+static int
+v3d_check_copy_extent(struct drm_device *dev, size_t bo_size,
+		      u32 offset, u32 stride, u32 count, u64 write_size)
+{
+	u64 last;
+
+	if (!count)
+		return 0;
+
+	/*
+	 * The executors walk a u8 * cursor, so the furthest written byte is
+	 * offset + (count - 1) * stride + write_size, matching the pointer
+	 * arithmetic in v3d_copy_query_results()/v3d_copy_performance_query().
+	 * (count - 1) * stride is a u32 * u32 product that is exact in u64,
+	 * and offset + write_size stays far below the u64 range, so a single
+	 * overflow check guards the total.
+	 */
+	last = write_size + offset;
+	if (check_add_overflow((u64)(count - 1) * stride, last, &last) ||
+	    last > bo_size) {
+		drm_dbg(dev, "CPU job copy buffer exceeds the destination BO.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Reject a query CPU job whose writes would land outside their BO. */
+static int
+v3d_cpu_job_bounds_check(struct v3d_cpu_job *job)
+{
+	struct drm_device *dev = &job->base.v3d->drm;
+	struct v3d_timestamp_query_info *tquery = &job->timestamp_query;
+	struct v3d_copy_query_results_info *copy = &job->copy;
+	u32 elem = copy->do_64bit ? sizeof(u64) : sizeof(u32);
+	struct v3d_bo *dst, *src;
+	u64 slots, write_size;
+	u32 i;
+
+	switch (job->job_type) {
+	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
+	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
+		/* Each query writes one u64 timestamp slot into bo[0]. */
+		dst = to_v3d_bo(job->base.bo[0]);
+
+		for (i = 0; i < tquery->count; i++) {
+			if ((u64)tquery->queries[i].offset + sizeof(u64) >
+			    dst->base.base.size)
+				goto err_range;
+		}
+		return 0;
+	case V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY:
+		/* Copies one u64 per query from bo[1] into bo[0]. */
+		dst = to_v3d_bo(job->base.bo[0]);
+		src = to_v3d_bo(job->base.bo[1]);
+
+		for (i = 0; i < tquery->count; i++) {
+			if ((u64)tquery->queries[i].offset + sizeof(u64) >
+			    src->base.base.size)
+				goto err_range;
+		}
+
+		write_size = (copy->availability_bit ? 2 : 1) * elem;
+		return v3d_check_copy_extent(dev, dst->base.base.size,
+					     copy->offset, copy->stride,
+					     tquery->count, write_size);
+	case V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY:
+		/*
+		 * Each query writes nperfmons * DRM_V3D_MAX_PERF_COUNTERS
+		 * counter slots into bo[0], plus an availability slot at
+		 * index ncounters. nperfmons and ncounters are user values,
+		 * so the slot count is computed overflow-safe.
+		 */
+		dst = to_v3d_bo(job->base.bo[0]);
+
+		slots = (u64)job->performance_query.nperfmons *
+			DRM_V3D_MAX_PERF_COUNTERS;
+		if (copy->availability_bit)
+			slots = max(slots,
+				    (u64)job->performance_query.ncounters + 1);
+
+		write_size = slots * elem;
+		return v3d_check_copy_extent(dev, dst->base.base.size,
+					     copy->offset, copy->stride,
+					     job->performance_query.count,
+					     write_size);
+	case V3D_CPU_JOB_TYPE_INDIRECT_CSD: {
+		struct v3d_indirect_csd_info *indirect_csd = &job->indirect_csd;
+
+		/* 3 is the three dimensions (x, y, z) of the workgroup counts. */
+		src = to_v3d_bo(job->base.bo[0]);
+		if ((u64)indirect_csd->offset + 3 * sizeof(u32) >
+		    src->base.base.size)
+			goto err_range;
+
+		dst = to_v3d_bo(indirect_csd->indirect);
+		for (i = 0; i < 3; i++) {
+			u32 uidx = indirect_csd->wg_uniform_offsets[i];
+
+			/*
+			 * 0xffffffff means "skip this rewrite", so the exec
+			 * path never writes that index and it needs no check.
+			 */
+			if (uidx != 0xffffffff &&
+			    (u64)uidx * sizeof(u32) + sizeof(u32) >
+			    dst->base.base.size)
+				goto err_range;
+		}
+		return 0;
+	}
+	default:
+		return 0;
+	}
+
+err_range:
+	drm_dbg(dev, "CPU job query offset exceeds the BO.\n");
+	return -EINVAL;
+}
+
 /**
  * v3d_submit_cpu_ioctl() - Submits a CPU job to the V3D.
  * @dev: DRM device
@@ -1364,6 +1486,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 			goto fail;
 	}
 
+	ret = v3d_cpu_job_bounds_check(cpu_job);
+	if (ret)
+		goto fail;
+
 	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
 		ret = v3d_setup_csd_jobs_and_bos(&submit, &cpu_job->indirect_csd.args,
 						 NULL);

base-commit: 1acd235bc8b8cf62da1a2b497f3e8c5cf01a2205
-- 
2.53.0

