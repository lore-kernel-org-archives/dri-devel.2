Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B62CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E7989F4F;
	Wed, 17 Jun 2026 12:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nq4cN4/k";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AD789F4F
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 12:58:28 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-5176fc0cc72so61434791cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781701107; x=1782305907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RZEWPoY1b4FvL8A262zCb2v2koOP2ZSA8cLqlzis5zQ=;
 b=Nq4cN4/kS1RRWE90Q58aQ2DU41ASaaQV7IgScqhpfbEpLP+rOMnl7y2QiE3Xrng+J4
 szFKCzugIahHsilyQL+l1sRiRNKpjceejJKWf2xjr99nKx3dZ6k9jv4I1gJjmbefPHxu
 /B6H/NWSAkbat9uuIkxDPxUG7m2eE8gQ00UQzxNfRFwj8foSdhGQ8ocKVGDgHhAuYZAd
 aaSc3e5yF3BbV/UblOUTnGAv31jnXnimRoF/rxR5sINei7YGQ+7DXoEiksul0BY90TOp
 /czoojUl49DcblMmEFYDJ2SnYyupp8q/Hg2HYggP1O+0LJb3/q9Ap6mu6+zgdQRWZjZE
 TTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781701107; x=1782305907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZEWPoY1b4FvL8A262zCb2v2koOP2ZSA8cLqlzis5zQ=;
 b=LmGBMcC6V2VnhCfl7W1OpJXmlA+szgAau8Cc4QsD8PF4ulEwG1JcrQffj+YVZKFsuj
 CyaZRIrO3a7hIz2Y0m4pMmyhoicUgrFPvScQbv4XdOkZlWQ5oRcu7gpUDuWfYKY6tmyC
 DaJhUBQ2gcLEhe3n+D0qyyH8xKFw98UHIJimD8yHbO4cm+RDqZj+Q/ZMf2xO0vqsATK2
 PcTqT3pwVgOOblllRrHGuJlD47xG2y0+g9v48+p8QgNwonjYlmqFmK0o2YoOtgmFhpNv
 bxp6kqrJHWuEKzyvP690+XRxFJ6XIl3FFbHcc6hNgB6V6El1Ph8OUV7f2wsHV0hjA4Hx
 QDww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I2Jz6rkRjlBMPfnRyU21ptEUbTKdMnsqk70vW9+DaMt+NrBexV7n+ISNPBitl+CzTv+uwWIxIlZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd2oTNHw92lbtG6DZ+WBOHZ/MV40cASGPh1b2xLeGb8+Ypz3WT
 M8w0Pg64rV97BUAulhCW3gYOMbfJ55D2lRe2fqZZORkzs+8FIj+3iPmp
X-Gm-Gg: Acq92OGzyg+X6ry6WA8tMaYYDg2n3xa61M7v+Jo5pyafv1eFFebU5W+uB5F6YNHI2fd
 +aJD5Fd7FBOp4NVAHQ40XSXpveG1pBeSNhG9JFUXNTS4oM1DpQWRtBw0bGef2mOSpAc7ZAXwdF4
 aMXZEZk2opjfjkhTFk8JUM+Q+kgtTVOFKtvaqwDwNLqbVXVZSp6R5i+tmlj+l1amhufLYD/Yc9N
 dcluQgd+wcLE710z5aQB+dRBZRkDyXstx7VmoamonATJvlan4JeVo5PmORDhRXHOAFkE/XTJmsq
 8WSlDKQAB/9INvpDsELfEbd89dseXr3eTtiWwTNf6GTyEegibejJ2c2WCTLaEPFgxHTe032dyPo
 S9xX/sdCxU8kIRJoyHf+dkrowgzAbWeBMtVdBPOeQnBS5Pn8qT1x2QRrAO9ROJQ0tqZQhZBDJUu
 NkltiiUOC5fvsPR0qeBC1RMntBEl3ogcnvD6RYXxU4qZeHb+1chvxTeGOMU/Do7IjTGRJjYXlTQ
 gyWpjglAn7qs34RyOQGpiGU1VDiWyYH
X-Received: by 2002:a05:622a:8350:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-519a8ddd546mr49035561cf.13.1781701107277; 
 Wed, 17 Jun 2026 05:58:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb79c5absm163373461cf.18.2026.06.17.05.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 05:58:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	Maira Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/v3d: bound CPU-job query writes to their destination BO
Date: Wed, 17 Jun 2026 08:58:11 -0400
Message-ID: <20260617125811.3692951-1-michael.bommarito@gmail.com>
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
    It also dereferences the indirect BO without checking that the
    user-supplied handle lookup succeeded.

A render-node user (DRM_RENDER_ALLOW, no master, no capability) can make
the handlers read or write past a BO's vmap mapping, or dereference a
NULL indirect BO.

Validate the full access extent against the BO size once the BOs are
looked up, before the job is queued, rejecting out-of-range geometry
with -EINVAL and a missing indirect BO with -ENOENT. The copy extent
offset + (count - 1) * stride + write_size is computed in u64, mirroring
the u8 * pointer arithmetic in the executors: (count - 1) * stride is a
u32 * u32 product that is exact in u64, so one overflow check on the
total guards the bound. The performance slot count and the bare
timestamp, copy-source and indirect offsets are computed in u64 the same
way, so a user value cannot wrap the comparison.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Fixes: 34a101e64296 ("drm/v3d: Create a CPU job extension for the reset timestamp job")
Fixes: 6745f3e44a20 ("drm/v3d: Create a CPU job extension to copy timestamp query to a buffer")
Fixes: 209e8d2695ee ("drm/v3d: Create a CPU job extension for the copy performance query job")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3:
 - Bound the INDIRECT_CSD job as well (Maira Canal). The exec reads three
   u32 work-group counts from bo[0] at the user offset and writes each back
   into the indirect BO at a user-supplied u32 index (wg_uniform_offsets[]),
   and dereferences the indirect BO; reject an out-of-range offset or index
   and a NULL indirect BO from a failed handle lookup (-ENOENT).
 - Compute the copy extent and the performance slot count in u64 rather than
   u32 + check_*_overflow() (Maira Canal). (count - 1) * stride is a u32 * u32
   product that is exact in u64, so a single overflow check guards the total,
   matching the u8 * pointer arithmetic in v3d_copy_query_results() and
   v3d_copy_performance_query(). Drop the now-redundant check_mul_overflow()
   in the performance branch and note the (u64) cast on the per-query offset
   checks.
 - Add Fixes: 34a101e64296 for the RESET_TIMESTAMP_QUERY path: the bare
   timestamp case bounds it too (v3d_reset_timestamp_queries() writes a u64
   zero at a user offset), and that handler was introduced separately from
   the timestamp-query job. All five Fixes commits are part of the v6.8 CPU
   job extension series.
 - The INDIRECT_CSD NULL-handle reject overlaps "drm/v3d: Reject invalid
   indirect BO handle in indirect CSD setup" from your Miscellaneous fixes
   series. I kept it here so this patch stands alone on the current base; if
   that lands first this check is redundant and I will drop it, or rebase on
   top of your series -- whichever you prefer.
v2 (https://lore.kernel.org/all/20260614211644.217116-1-michael.bommarito@gmail.com/):
 - Also bound the bare TIMESTAMP_QUERY and RESET_TIMESTAMP_QUERY job types
   (Maira Canal); drop the unused span variable and the can-never-overflow
   check on the fixed-size timestamp slots; drop the KUnit reproducer, which
   was a no-go for upstreaming (Maira Canal); one Fixes tag per introducing
   CPU-job extension.
v1: https://lore.kernel.org/all/20260614131058.2525157-1-michael.bommarito@gmail.com/

 drivers/gpu/drm/v3d/v3d_submit.c | 136 +++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee4512db294b3..9265f7bcd2766 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2023 Raspberry Pi
  */
 
+#include <linux/overflow.h>
+
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
 
@@ -1246,6 +1248,136 @@ static const unsigned int cpu_job_bo_handle_count[] = {
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
+	int i;
+
+	switch (job->job_type) {
+	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
+	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
+		/*
+		 * Each query writes one u64 timestamp slot into bo[0]. The
+		 * offset is cast to u64 so a 0xffffffff query offset cannot wrap
+		 * the addition past the BO size.
+		 */
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
+		 * counter slots into bo[0], plus an availability slot at index
+		 * ncounters. nperfmons and ncounters are user values; the slot
+		 * count and write size are computed in u64 (u32 * small
+		 * constant) so they cannot wrap.
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
+		struct v3d_indirect_csd_info *icsd = &job->indirect_csd;
+
+		/*
+		 * The exec-time work-group rewrite reads three u32 counts from
+		 * bo[0] at the user-supplied offset, then writes each count back
+		 * into the indirect BO at a user-supplied u32 index. Reject a
+		 * missing indirect BO (drm_gem_object_lookup() returned NULL for
+		 * a bad handle, which the exec path would otherwise dereference)
+		 * and bound both accesses.
+		 */
+		if (!icsd->indirect)
+			return -ENOENT;
+
+		dst = to_v3d_bo(job->base.bo[0]);
+		if ((u64)icsd->offset + 3 * sizeof(u32) > dst->base.base.size)
+			goto err_range;
+
+		src = to_v3d_bo(icsd->indirect);
+		for (i = 0; i < 3; i++) {
+			u32 uidx = icsd->wg_uniform_offsets[i];
+
+			if (uidx != 0xffffffff &&
+			    (u64)uidx * sizeof(u32) + sizeof(u32) >
+			    src->base.base.size)
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
@@ -1317,6 +1449,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		if (ret)
 			goto fail;
 
+		ret = v3d_cpu_job_bounds_check(cpu_job);
+		if (ret)
+			goto fail;
+
 		ret = v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);
 		if (ret)
 			goto fail;
-- 
2.53.0

