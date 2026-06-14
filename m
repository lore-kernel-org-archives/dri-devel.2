Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728EFCD98D2
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 13:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A3710E088;
	Sun, 14 Jun 2026 13:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tJZA95US";
	dkim-atps=neutral
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E58C10E088
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 13:11:07 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-5174a3a025aso27931221cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781442666; x=1782047466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzg/YOIIjYEH15Di+UXqiKscgR5aDMncmsvi0n7iLLw=;
 b=tJZA95USo484BLQ7Ja82qu28USrxas85x09Z5r51CgiC5H9l9hL0jhUm2BCmU7YGdQ
 Gm8ewb/91M4u8gnlOFIY8l2R68kibAw2gMP7A7rN5p1mg/RNSzG9VxtiQOKJ9Vg+suTM
 YSTLwHtYgu+VRW9YnlAXFmn2IkHzkquh8Zp3EpzJsv2K3x2GYUGq/6iOcYcB8iFJ6/y8
 mq+Lxo4h3zczAPacyC6+ab84TPcvf9/PgV895pMDx74PLa32jdcpqZABzQ1pMqDzKac2
 bjXKnPARxHiU/jVat2Ayh/+elSnOG18xCts6JVIJLTe/uEdLnTADAvcB6HD47aRdi5C7
 YInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781442666; x=1782047466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzg/YOIIjYEH15Di+UXqiKscgR5aDMncmsvi0n7iLLw=;
 b=En76GXrD3Gg42412R2h5tzPn5g/Y+KY11wKBqtK1hA4uwPKQalzvEbaVS+/icz1cjz
 xQtvNKWBfODqzooqqUoCYMPc7pbArg0VPxfH5lGjofg1Qf9Pyk0K1AhLA9JvyuRdZCSd
 B1aaoeU1ws36+LilnS0KxazLlXeBRFavRkblNPnG9n07vKI06ZVINmR5vFLGB85jlmeT
 3YqBXQ1mQ/wQmSBGzIygOoU7GCXm751u9OhO2kVJ96aP7sqmPdaj3DQefgYPo1Rv+5CH
 UlzX7NSrl+XoUsb6PL3o8yv/Sfr3dA9D6wgtSyrzL3QFARVAnwlLkRrnzz7h6qo22+C0
 fAWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uszk12KfTfgNrYGINm7AxDNxiVytMwLru/QofjP+/8rjnnnY1IzRcZIk0VA1ytzwB/d99ty4EAGQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySjRcc7N4s0ORR6QZn4Us7V+erSKm/2RWYzKj0qEU2+LFeTXrz
 62lAmqecWxFnS4Wo48BgZR69Id3Iw45j9aYOy8kZXWj7Gea8rFv3bq+TfvKeq251LNg=
X-Gm-Gg: Acq92OGMDWlKgy+H2I0HMB7Bw75XVrByvC0P6cN6cHTGW/iIaigE95Yir8wO5mqWgeH
 kMRkQHoyxtilhe1e23JGvz0L3xjLqvPXdTpSkM0zRzh5LeA0I+jxirEihunioNZO7Qac5Cri4+r
 MMTPYdmC7/4zLt0MWwy+aeaNnjIPVB8EgWRKuGZ1GJ9gzwivfMWa29N4QLNxKMkZbSDSJDZ6o0h
 eQhOhqtuM+MFRuDAh7NrFdj9Z+x2L4LApzG+ySN2mmsbWfundK2PCtOge4ebUXhZsKAGA/PK3g6
 qVKrwgzk5whGP+cGH/4SB+wFX1M04SYLOpblZ7NKSwEft6GfE2cMtnKFjJA2ItiFRMZ5DglDDl/
 4Y134lift/Fze3YZ2JgV/SFn241iW4Q4vt9kpR0F1IH9Udg5DsDbpFFHvCcT2CDy5l6gPxW7+/h
 KfIDjY9wZQOeENhpeNvfquM2HGYDQM2mfqcXy5WUEvSM08aRnVS47OMxfOe7Zb6sCgWFIx8BYZ7
 srjGRip1IPA2PvjbHdkV3YmEN8Imjn7qbAh79coTRA=
X-Received: by 2002:a05:622a:1456:b0:517:5beb:9b17 with SMTP id
 d75a77b69052e-519533573cemr115073121cf.1.1781442666031; 
 Sun, 14 Jun 2026 06:11:06 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5196073d7fbsm25145811cf.30.2026.06.14.06.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 06:11:05 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	Maira Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/v3d: validate copy-query buffer bounds against
 destination BO size
Date: Sun, 14 Jun 2026 09:10:59 -0400
Message-ID: <20260614131100.2525157-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131100.2525157-1-michael.bommarito@gmail.com>
References: <20260614131100.2525157-1-michael.bommarito@gmail.com>
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

The V3D_SUBMIT_CPU COPY_TIMESTAMP_QUERY and COPY_PERFORMANCE_QUERY
extensions store a user-supplied destination offset, per-query stride and
query count on the job and consume them at exec without checking that
offset + (count - 1) * stride + per-query write size stays inside the
destination BO. The copy then writes counter values and the availability
bit past the BO's vmap mapping; the timestamp variant also reads each
result from an unchecked offset into the second BO. A render-node user
(DRM_RENDER_ALLOW, no master, no capability) controls the offset.

Validate the full write extent against the destination BO size once the
BOs are looked up, before the job is queued, rejecting overflow or
out-of-range geometry with -EINVAL; the per-query write size is computed
with check_*_overflow() so a u32 product cannot wrap the bound, and the
timestamp source offsets are bounded in the same pass. A KUnit reproducer
follows.

Fixes: 6745f3e44a20 ("drm/v3d: Create a CPU job extension to copy timestamp query to a buffer")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
Reproduced under KASAN via a KUnit (patch 2) driving the real
v3d_copy_query_results() over a shmem-backed BO; a copy offset at the BO
size writes past the one-page vmap mapping:

  BUG: KASAN: vmalloc-out-of-bounds in v3d_copy_query_results+0x807/0x900

The trigger faults on stock and is rejected at submit time on the patched
tree; two in-bounds controls pass on both. The performance-query copy
shares the bound; its write values come from perfmon counters and were
checked by source review rather than this hardware-free run.

 drivers/gpu/drm/v3d/v3d_submit.c | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee4512db294b3..23e19dacfdce2 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1246,6 +1246,88 @@ static const unsigned int cpu_job_bo_handle_count[] = {
 	[V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY] = 1,
 };
 
+/* Reject offset + (count - 1) * stride + write_size if it leaves the BO. */
+static int
+v3d_check_copy_extent(struct drm_device *dev, size_t bo_size,
+		      u32 offset, u32 stride, u32 count, u32 write_size)
+{
+	u32 span, last;
+
+	if (!count)
+		return 0;
+
+	if (check_mul_overflow(stride, count - 1, &span) ||
+	    check_add_overflow(span, write_size, &span) ||
+	    check_add_overflow(span, offset, &last) ||
+	    last > bo_size) {
+		drm_dbg(dev, "CPU job copy buffer exceeds the destination BO.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Bound the copy-query CPU-job writes; the exec-time copy does not. */
+static int
+v3d_cpu_job_check_copy_bounds(struct v3d_cpu_job *job)
+{
+	struct drm_device *dev = &job->base.v3d->drm;
+	struct v3d_copy_query_results_info *copy = &job->copy;
+	u32 elem = copy->do_64bit ? sizeof(u64) : sizeof(u32);
+	struct v3d_bo *bo, *timestamp;
+	u32 slots, write_size;
+	int i;
+
+	switch (job->job_type) {
+	case V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY:
+		bo = to_v3d_bo(job->base.bo[0]);
+		timestamp = to_v3d_bo(job->base.bo[1]);
+
+		slots = copy->availability_bit ? 2 : 1;
+		if (check_mul_overflow(slots, elem, &write_size))
+			return -EINVAL;
+
+		if (v3d_check_copy_extent(dev, bo->base.base.size, copy->offset,
+					  copy->stride, job->timestamp_query.count,
+					  write_size))
+			return -EINVAL;
+
+		for (i = 0; i < job->timestamp_query.count; i++) {
+			u32 end;
+
+			if (check_add_overflow(job->timestamp_query.queries[i].offset,
+					       (u32)sizeof(u64), &end) ||
+			    end > timestamp->base.base.size) {
+				drm_dbg(dev, "CPU job timestamp query offset exceeds the BO.\n");
+				return -EINVAL;
+			}
+		}
+		return 0;
+	case V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY:
+		bo = to_v3d_bo(job->base.bo[0]);
+
+		if (check_mul_overflow(job->performance_query.nperfmons,
+				       (u32)DRM_V3D_MAX_PERF_COUNTERS, &slots))
+			return -EINVAL;
+		if (copy->availability_bit) {
+			u32 avail_slots;
+
+			if (check_add_overflow(job->performance_query.ncounters,
+					       1u, &avail_slots))
+				return -EINVAL;
+			slots = max(slots, avail_slots);
+		}
+		if (check_mul_overflow(slots, elem, &write_size))
+			return -EINVAL;
+
+		return v3d_check_copy_extent(dev, bo->base.base.size, copy->offset,
+					     copy->stride, job->performance_query.count,
+					     write_size);
+	default:
+		return 0;
+	}
+}
+
 /**
  * v3d_submit_cpu_ioctl() - Submits a CPU job to the V3D.
  * @dev: DRM device
@@ -1317,6 +1399,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		if (ret)
 			goto fail;
 
+		ret = v3d_cpu_job_check_copy_bounds(cpu_job);
+		if (ret)
+			goto fail;
+
 		ret = v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);
 		if (ret)
 			goto fail;
-- 
2.53.0

