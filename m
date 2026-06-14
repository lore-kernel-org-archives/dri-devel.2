Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F7CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 13:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D4E10E089;
	Sun, 14 Jun 2026 13:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dAxEJzCN";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA20310E088
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 13:11:09 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8ccef25789fso18652466d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781442668; x=1782047468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBor/vCL6YmtjmbcB0YXRqAJQFpdC1PJkqz6hn7PPv8=;
 b=dAxEJzCNNfKfoDPV04GXDkuAYcDfSVZDNuZkyuwltWBhH7mYN0GgOtNa97a6gzK8Dj
 o5yrHAmtGTKaCfLIHYQYMrSBOqkaa5rlrP+J1OFtb6uJKmjoY7p2gLvGEzT+2a9ZfMtu
 lIUtM+yClaiZc3zmEXNIDmeE9jwbBj1UBsF42z5jL60BDaMt7Z5OllhqGrlFBd2bYsg1
 c5tTRU9VoiXkmPNu+UpfBe+dVby+K/qPDZ7SjGjstaDHJQ1cR37SuHwLC20L0J/a3v3v
 8e1suPMa9lkDmFF01J/mFlglizvqXh45fz4LZEFAcrhpgvvcOumDEmD+jCWbR/i3sPn2
 5SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781442668; x=1782047468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OBor/vCL6YmtjmbcB0YXRqAJQFpdC1PJkqz6hn7PPv8=;
 b=KCq9Llh7k/nhYiTkCjpqDQTXo5bQrzIfKtbtUZe2w+u/DCDLU1HzQdzRdBpFXkPphH
 zOcKcNFlPop9dGnhpKFAyoVxjZYAjbERdNVKf3IhkK/woSOFXR8gLwDtQ5W5MC1mhL5i
 wRd6aoKPbg6m0oAQuOY0sheqYtRNJ2RIOP7YFbt9k7VINpgI27u9eYKo1M2A3EHyE9yl
 VwU+9iYF5SCrUwIAVVSlnZ5Z1J9NxM2FqPNCV8qqFAFiXNgrQ7slP7d/UyK18Xle56nS
 4ekx5rs5At2S4G9ekB/VnLU3k+OfCKmk2GZO02yOkY+MllFKbGsDfr4BWlpXQdslaGZF
 lFLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mqsbjISMJ4HHfsn5xY5IK6akC2E4sgBG99j7V49+bAG/1Ls3Yd/s8s+/xSPJbEuzuQ8R8YIugw8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyB+q1MHVk3QDNv9afDnjojzgSzwU72my3jlNezAg0LHfASOD+T
 +BlX8nTTPkMVJq17lrh9yMRwuPNJurV9rtiuFPMKfDEJsYPM/gV0tphs
X-Gm-Gg: Acq92OE3GbnSxHBCrqwcY7tCUzcZEoi9JuWgX6Dcv5ysdOfClaRSSn7Z2G08LYM9SIS
 hyt941ECoW82TAqtrxRufUQW9zQACqJHUHMXpzF+KC0yh0JDoElNkC04OeWYvQcVSiylDPvR5za
 V2W6C1xTxlYpGDLK/gW8OZAc5EK0YeHVOERm0vn10WtkJqasi/y0Y5rnYr3hjGTYNqFnVCHRs7e
 IBzlWLm/CId6KM9c1T+ARk20gUuH0TTzjsBU54aOcFsQMc1R+wzcG2npq0jwzabZhFlv8dX4q55
 vMveL1K3f4KBNSGBpbXC6erxYqnToKv+1NPtStgyDw0DtpjTsSrun7h0AGAZTVBG2mYI085eMHf
 KMXGYyM45EOvN9iv0hYiY/vlrNCy2qXWGxuKdJmZiPqGMdmNKtM21K1Y7xjyu/3ApxtdnpvT9vH
 UEx6UxBankLRGGrxzgLPFnvfC5I+cSALeOrkoLLAh9lUL8Ok73uY9qqF5P/YWrZ2ollxvp3mCWb
 8F4wnAO9m3JYXK0miQxdDKqwmP8CwcHyFQUx1egU8s=
X-Received: by 2002:a05:622a:5918:b0:517:9157:ecf3 with SMTP id
 d75a77b69052e-517fe5c95bdmr162885541cf.36.1781442668224; 
 Sun, 14 Jun 2026 06:11:08 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5196073d7fbsm25145811cf.30.2026.06.14.06.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 06:11:06 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	Maira Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/v3d: add KUnit reproducer for the copy-query
 out-of-bounds write
Date: Sun, 14 Jun 2026 09:11:00 -0400
Message-ID: <20260614131100.2525157-3-michael.bommarito@gmail.com>
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

Add a KUnit suite (CONFIG_DRM_V3D_COPY_QUERY_KUNIT_TEST, builds under
COMPILE_TEST) that drives the real v3d_copy_query_results() CPU-job
handler over a shmem-backed BO and exercises the destination-buffer
bounds the previous patch adds. Under KASAN the trigger case reproduces
the vmalloc-out-of-bounds write on the stock tree and passes once the
bounds patch is applied; two in-bounds controls pass on both trees.

Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
The COPY_TIMESTAMP_QUERY path is hardware-free: with an unsignalled query
the result read is skipped and only the availability bit is written, so the
copy runs on CPU memory alone. The trigger uses a copy offset at the BO
size, so the write lands past the one-page vmap mapping and KASAN
(CONFIG_KASAN_VMALLOC) reports a vmalloc-out-of-bounds write; the two
in-bounds controls prove the synthesised setup is not itself the cause.
With patch 1 applied the trigger is rejected by the submit-time gate
(exposed for the test) and the copy never runs. x86_64, COMPILE_TEST; the
write is plain CPU memory and not architecture specific.

 drivers/gpu/drm/v3d/Kconfig                |  10 ++
 drivers/gpu/drm/v3d/v3d_copy_query_kunit.c | 172 +++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_drv.h              |   3 +
 drivers/gpu/drm/v3d/v3d_sched.c            |   4 +
 drivers/gpu/drm/v3d/v3d_submit.c           |   2 +-
 5 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/v3d/v3d_copy_query_kunit.c

diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
index ce62c5908e1db..f293eb95a73c8 100644
--- a/drivers/gpu/drm/v3d/Kconfig
+++ b/drivers/gpu/drm/v3d/Kconfig
@@ -11,3 +11,13 @@ config DRM_V3D
 	  Choose this option if you have a system that has a Broadcom
 	  V3D 3.x or newer GPUs. SoCs supported include the BCM2711,
 	  BCM7268 and BCM7278.
+
+config DRM_V3D_COPY_QUERY_KUNIT_TEST
+	bool "KUnit test for V3D CPU-job copy-query bounds"
+	depends on DRM_V3D && KUNIT=y
+	select DRM_KUNIT_TEST_HELPERS
+	help
+	  Builds a KUnit suite that drives the V3D CPU-job copy-timestamp-query
+	  handler over a real shmem-backed BO to exercise the destination-buffer
+	  bounds. Used to reproduce the copy-query out-of-bounds write under
+	  KASAN. If in doubt, say N.
diff --git a/drivers/gpu/drm/v3d/v3d_copy_query_kunit.c b/drivers/gpu/drm/v3d/v3d_copy_query_kunit.c
new file mode 100644
index 0000000000000..4296449de7230
--- /dev/null
+++ b/drivers/gpu/drm/v3d/v3d_copy_query_kunit.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * KUnit coverage for the V3D CPU-job copy-query OOB write. Drives the real
+ * v3d_copy_query_results() (COPY_TIMESTAMP_QUERY) over a shmem-backed v3d_bo:
+ * a copy->offset at the BO size makes the availability write land past the
+ * one-page vmap, which KASAN reports. A NULL fence skips the result read, so
+ * no V3D engine is needed (Level 2). Two in-bounds controls pass on both.
+ * Included from v3d_sched.c.
+ */
+#include <linux/sizes.h>
+
+#include <kunit/test.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_syncobj.h>
+
+/* One page per BO; the OOB write lands just past this vmap mapping. */
+#define V3D_COPY_TEST_BO_SIZE	PAGE_SIZE
+
+struct v3d_copy_test_ctx {
+	struct drm_device *drm;
+	struct v3d_bo *dst;			/* to_v3d_bo(job->base.bo[0]) */
+	struct v3d_bo *ts;			/* to_v3d_bo(job->base.bo[1]) */
+	struct drm_gem_object *bo_array[2];
+	struct drm_syncobj syncobj[4];		/* fence == NULL -> unavailable */
+	struct v3d_timestamp_query queries[4];
+	struct v3d_cpu_job job;
+};
+
+/* Standard shmem teardown; we have no v3d_dev for v3d_free_object(). */
+static void v3d_copy_test_free_bo(void *p)
+{
+	struct v3d_bo *bo = p;
+
+	if (bo->vaddr)
+		v3d_put_bo_vaddr(bo);
+	if (refcount_read(&bo->base.pages_pin_count))
+		drm_gem_shmem_unpin(&bo->base);
+	drm_gem_shmem_free(&bo->base);
+}
+
+static struct v3d_bo *
+v3d_copy_test_make_bo(struct kunit *test, struct drm_device *drm)
+{
+	struct drm_gem_shmem_object *shmem;
+	struct drm_gem_object *obj;
+	struct v3d_bo *bo;
+	int ret;
+
+	/* v3d_create_object sizes the alloc for struct v3d_bo (bo->vaddr). */
+	shmem = drm_gem_shmem_create(drm, V3D_COPY_TEST_BO_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+
+	obj = &shmem->base;
+	bo = to_v3d_bo(obj);
+
+	/* Real page backing for v3d_get_bo_vaddr()'s vmap(). */
+	ret = drm_gem_shmem_pin(shmem);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_add_action_or_reset(test, v3d_copy_test_free_bo, bo);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return bo;
+}
+
+/* Build a COPY_TIMESTAMP_QUERY job and run the real copy handler. */
+static void v3d_copy_test_run(struct kunit *test, u32 offset, u32 stride,
+			      u32 count)
+{
+	struct v3d_copy_test_ctx *c;
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						  sizeof(*drm), 0,
+						  DRIVER_GEM);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	/* Route BO creation through the driver hook (devm drm_driver is writable). */
+	((struct drm_driver *)drm->driver)->gem_create_object = v3d_create_object;
+
+	c = kunit_kzalloc(test, sizeof(*c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c);
+	c->drm = drm;
+
+	c->dst = v3d_copy_test_make_bo(test, drm);
+	c->ts = v3d_copy_test_make_bo(test, drm);
+
+	c->bo_array[0] = &c->dst->base.base;
+	c->bo_array[1] = &c->ts->base.base;
+
+	/* fence == NULL: result read skipped; only the availability bit is written. */
+	KUNIT_ASSERT_LE(test, count, (u32)ARRAY_SIZE(c->queries));
+	for (u32 i = 0; i < count; i++) {
+		c->syncobj[i].fence = NULL;
+		c->queries[i].offset = 0;	/* in bounds for the source BO */
+		c->queries[i].syncobj = &c->syncobj[i];
+	}
+
+	c->job.job_type = V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY;
+	c->job.base.bo = c->bo_array;
+	c->job.base.bo_count = 2;
+	c->job.timestamp_query.queries = c->queries;
+	c->job.timestamp_query.count = count;
+
+	/* drm_device is the first member of v3d_dev; the cast resolves &v3d->drm back. */
+	c->job.base.v3d = (struct v3d_dev *)c->drm;
+
+	c->job.copy.do_64bit = false;		/* 4-byte writes */
+	c->job.copy.do_partial = false;
+	c->job.copy.availability_bit = true;	/* drives the index-1 write */
+	c->job.copy.offset = offset;
+	c->job.copy.stride = stride;
+
+#if defined(V3D_CPU_JOB_COPY_BOUNDS_CHECKED)
+	/* Patched tree: run the same submit-time gate; out-of-range is rejected before the copy. */
+	if (v3d_cpu_job_check_copy_bounds(&c->job)) {
+		KUNIT_EXPECT_GT_MSG(test, c->job.copy.offset + count * stride,
+				    (u32)V3D_COPY_TEST_BO_SIZE,
+				    "bounds gate rejected an in-bounds geometry");
+		return;
+	}
+#endif
+
+	v3d_copy_query_results(&c->job);
+}
+
+/* Control: one query at offset 0; availability bit at byte 4, in bounds. */
+static void v3d_copy_query_control_inbounds(struct kunit *test)
+{
+	v3d_copy_test_run(test, 0, 8, 1);
+}
+
+/* Control: two queries, stride 8; second availability bit at byte 12, in bounds. */
+static void v3d_copy_query_control_inbounds_multi(struct kunit *test)
+{
+	v3d_copy_test_run(test, 0, 8, 2);
+}
+
+/* Trigger: copy->offset == BO size; write past the vmap mapping (stock OOB, patched rejected). */
+static void v3d_copy_query_trigger_oob(struct kunit *test)
+{
+	v3d_copy_test_run(test, V3D_COPY_TEST_BO_SIZE, 8, 1);
+}
+
+static struct kunit_case v3d_copy_query_cases[] = {
+	KUNIT_CASE(v3d_copy_query_control_inbounds),
+	KUNIT_CASE(v3d_copy_query_control_inbounds_multi),
+	KUNIT_CASE(v3d_copy_query_trigger_oob),
+	{}
+};
+
+static struct kunit_suite v3d_copy_query_suite = {
+	.name = "v3d_copy_query",
+	.test_cases = v3d_copy_query_cases,
+};
+
+kunit_test_suite(v3d_copy_query_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 6a3cad9334398..a4b772385070f 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -583,6 +583,9 @@ int v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_priv);
 int v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 			 struct drm_file *file_priv);
+/* Exposed for the copy-query KUnit; its presence marks the bounds patch applied. */
+#define V3D_CPU_JOB_COPY_BOUNDS_CHECKED 1
+int v3d_cpu_job_check_copy_bounds(struct v3d_cpu_job *job);
 
 /* v3d_irq.c */
 int v3d_irq_init(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 1855ef5b3b5fe..7884863376702 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -901,3 +901,7 @@ v3d_sched_fini(struct v3d_dev *v3d)
 			drm_sched_fini(&v3d->queue[q].sched);
 	}
 }
+
+#if IS_ENABLED(CONFIG_DRM_V3D_COPY_QUERY_KUNIT_TEST)
+#include "v3d_copy_query_kunit.c"
+#endif
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 23e19dacfdce2..ec0b94ada73ff 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1268,7 +1268,7 @@ v3d_check_copy_extent(struct drm_device *dev, size_t bo_size,
 }
 
 /* Bound the copy-query CPU-job writes; the exec-time copy does not. */
-static int
+int
 v3d_cpu_job_check_copy_bounds(struct v3d_cpu_job *job)
 {
 	struct drm_device *dev = &job->base.v3d->drm;
-- 
2.53.0

