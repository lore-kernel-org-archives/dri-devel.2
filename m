Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB6BCD8CA8
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 21:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C041310E121;
	Sun, 14 Jun 2026 21:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XsE5kFoi";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CA410E121
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:17:15 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-9159f631656so331500885a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781471835; x=1782076635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XxZ+Wx6zViR4ZOtaE9BQrIto682T5tB19z5D7ua0ues=;
 b=XsE5kFoiETU4skHLDwEhjBPY7Npf1msh78RFdIRPIY4vq1TuID1qiDjhEC1MKHiGTd
 pmTC6kSVgrKpoqR/nfhaDdezSx7gqtvvLpfpa0HfHtomCxp82ZX3mKy1kA3xHw5OrzVp
 2C0YNhW6XuJXPU1T+zvQZcPIUtBIm/Q0EMmdVOblEvW+pOGFqkf2mmkXiUQ33mQad0jL
 Njrkakc2DZIxp1c6uNDGgyxyeaxGCiRQISoVgHVvsk6PiD0vO+NTavjv6qkBwaZDmo6y
 xmEyicxNM+Npk7uAWRuv1MREd28JyWMODxZ7JzJNEdJnKuqFnwwTaFZfH34mOC1XgSoN
 pZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781471835; x=1782076635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxZ+Wx6zViR4ZOtaE9BQrIto682T5tB19z5D7ua0ues=;
 b=DwW/NoHKl6Vq0cBePoS3Usn/Z0yRXf7gKvXBbf2wlAC23vuOXsZTvJbGfFsaklgkGa
 narjP5O0HA4vmQeFXYv0l+QXttafWQmVxXOXFoRpOrJ4u0b6vLJ3yOfSswUiNEwnS+bP
 j9CEv/Wr1hoT7nu9qWCTBPFE4ow8HPGU0jibLL8owmz9UMvnw2rygREoQVi1nwaEKd9k
 5CgpH4VZq9lGrgkMZxA8pQLx6dMEwA+uv5iZ7La+UKxfsYpbWskeK3BORBCM49KxShwM
 5g/Yv2+THjQm6x3MBqRsO7xK1IOxN7+LlnJ2N9KyrQLn5JwW4mb+XhDPPWnWUbq3kwOW
 2/Bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LB+qpP7VBNkzkcej0iGK/H677Xo00wFJlbzj2BBPQbD2p/ynhkETAn0XOGa2CXZU8/fyFeEiIHrU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCc6pOKfjclf3YsKqczyJlI6P/ENFef1SyjtvYwJlbBk/qjfyS
 d+9qg7+fz2hVmj5qEwoOpjpWtin/pGJDhz/CLJ1/FnQ901LmgWoGnsYP
X-Gm-Gg: Acq92OH1GMHTzmYJ6FeZxDib/XXwJcwF2HwviPmsrnbpJ7L9jtHcoXMgOpOptx/1vt0
 o+iHCNgQsrwwkum92jtNKMaOgKSQhSLk1dqNDXLN0vVsoAMQlP17+xgN0X7DQurC1DoO2BJDM4b
 KBa3cWZaAkc7RYvvMsqBvL3+mZVXX7Ck7V/e3tOcGJSgjOPUwFbAJ89wepfbQLFoad9NFc0/+hz
 bvMHDwmF35w88uR/xjY5rIwk4v8pxq2iu/uVn4yXZ/GTLSwS/YC8YaitfNSeRzO80QP+iPrz0qz
 OdYHof5kF9jchmW8E2M0l3asjO5Vg49Uu6xugG2vhRuhQeKrWgG2G+4QnsKJOKqftBs5o/eJjOu
 7Ji5rWbV1PAu0O+zXrJQI9auKFHeAJuPSIHg14iGwQ4oHkwx0TjP1KoXJwMJjb+dSYDwuF2CNNr
 Qxkofw4iK12mlPS6gYguhMGL9235O/eLf0jVgefHrW1bmggQkZbF+VUAYRPQFSi02BNCUjr+VYi
 c69PDCnVN44Isa5rNBS/Riyj60CUwhMbyKCHrhv5ro=
X-Received: by 2002:a05:620a:7107:b0:8f8:d17c:9f9 with SMTP id
 af79cd13be357-9161c03e72amr1728829085a.16.1781471834790; 
 Sun, 14 Jun 2026 14:17:14 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619f05fe7sm927730385a.12.2026.06.14.14.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 14:17:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	Maira Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/v3d: bound CPU-job query writes to their destination BO
Date: Sun, 14 Jun 2026 17:16:44 -0400
Message-ID: <20260614211644.217116-1-michael.bommarito@gmail.com>
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

The V3D_SUBMIT_CPU query CPU jobs store a user-supplied destination
offset (and, for the copy variants, a per-query stride and query count)
on the job and consume them at exec time without checking that the
writes stay inside the destination BO:

  - TIMESTAMP_QUERY and RESET_TIMESTAMP_QUERY write one u64 per query
    into bo[0] at a fully user-controlled per-query offset.
  - COPY_TIMESTAMP_QUERY copies one u64 per query into bo[0] at
    offset + i * stride, and reads each result from a user-controlled
    offset in the source bo[1].
  - COPY_PERFORMANCE_QUERY writes nperfmons * DRM_V3D_MAX_PERF_COUNTERS
    counter slots plus an availability slot into bo[0] at the same
    geometry.

None of these are bounded against the BO size, so a render-node user
(DRM_RENDER_ALLOW, no master, no capability) can make the handlers
write past the BO's vmap mapping.

Validate the full write extent against the destination BO size once the
BOs are looked up, before the job is queued, rejecting out-of-range or
overflowing geometry with -EINVAL. The copy extent
offset + (count - 1) * stride + write_size is accumulated with
check_*_overflow() so a u32 product cannot wrap the bound, and the
performance slot count is computed the same way since nperfmons and
ncounters are user values. The bare timestamp writes and the copy
source reads are a single fixed u64 slot per query and are bounded
directly.

Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
  - Extend the bound to the bare TIMESTAMP_QUERY and
    RESET_TIMESTAMP_QUERY job types, which also write one u64 per query
    into bo[0] at a user-controlled offset (Maira Canal).
  - Simplify v3d_cpu_job_bounds_check(): the timestamp source/dest u64
    slots are bounded directly without the can-never-overflow
    check_mul_overflow(); only the genuinely user-sized copy extent and
    the performance slot count keep check_*_overflow().
  - Drop the redundant local in v3d_check_copy_extent(); rename the gate
    to v3d_cpu_job_bounds_check(); reword the helper comments.
  - Drop the KUnit reproducer patch; the suite is kept out of tree.
  - Re-pin Fixes: to the earliest introducing commit (the timestamp
    query job) now that the bare timestamp writes are covered.

Reproduced under KASAN with an out-of-tree KUnit driving the real
handlers over shmem-backed BOs: with a query offset at the BO size the
stock tree reports a vmalloc-out-of-bounds write in each of
v3d_copy_query_results() (4 bytes), v3d_timestamp_query() (8 bytes) and
v3d_reset_timestamp_queries() (8 bytes); with this patch the submit-time
gate rejects the geometry and all in-bounds controls still pass. The
write is plain CPU memory and not architecture specific (x86_64,
COMPILE_TEST).

 drivers/gpu/drm/v3d/v3d_submit.c | 102 +++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee4512db294b3..fe11fd7e6e14a 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1246,6 +1246,104 @@ static const unsigned int cpu_job_bo_handle_count[] = {
 	[V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY] = 1,
 };
 
+/* Reject offset + (count - 1) * stride + write_size if it leaves the BO. */
+static int
+v3d_check_copy_extent(struct drm_device *dev, size_t bo_size,
+		      u32 offset, u32 stride, u32 count, u32 write_size)
+{
+	u32 last;
+
+	if (!count)
+		return 0;
+
+	if (check_mul_overflow(stride, count - 1, &last) ||
+	    check_add_overflow(last, write_size, &last) ||
+	    check_add_overflow(last, offset, &last) ||
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
+	u32 slots, write_size;
+	int i;
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
+		if (check_mul_overflow(job->performance_query.nperfmons,
+				       (u32)DRM_V3D_MAX_PERF_COUNTERS, &slots))
+			goto err_range;
+
+		if (copy->availability_bit) {
+			u32 avail_slots;
+
+			if (check_add_overflow(job->performance_query.ncounters,
+					       1u, &avail_slots))
+				goto err_range;
+			slots = max(slots, avail_slots);
+		}
+
+		if (check_mul_overflow(slots, elem, &write_size))
+			goto err_range;
+
+		return v3d_check_copy_extent(dev, dst->base.base.size,
+					     copy->offset, copy->stride,
+					     job->performance_query.count,
+					     write_size);
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
@@ -1317,6 +1415,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
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

