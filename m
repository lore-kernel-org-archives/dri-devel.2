Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D67C5DF8B
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBE410EF77;
	Thu, 20 Aug 2026 08:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CiA7nDoD";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D0610E07C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 03:19:08 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4a4cb36ae00so1316936b6e.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 20:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787195948; x=1787800748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MQfNhWjHAIsYvqRXEU3FJgTiTF29iPfV7gMZoO8YVqY=;
 b=CiA7nDoDORico2ErcT6uUW3AXirC1ym2ByeS5soXScmbP/BfmdxCJlzPAdrTP2k972
 qrhvfRvX/eiJmBV5BVPLAqXMWu1BAasDf+z4iUMgM3mbt6AWwuJTkncXV5jkXA135tAk
 zdxy3Tv/O+80jrjPoatO3WKipjWHD6vAl7bs/GYNePCuEUa1ink3imUPbvXzdPZwynHH
 0mSxeZEeAksnD2wWHgNBzL3eQeBOBrhKkAcIo7+/NlL7bKWXVC7NnlrD+CJ7N1U9fwuG
 SSX/9B5XDFmD79idbk8XiPMK4phkX+T1nAwIn4pOs65Q+8RIl86n0jkr58N0n0oqvUk/
 V2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787195948; x=1787800748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQfNhWjHAIsYvqRXEU3FJgTiTF29iPfV7gMZoO8YVqY=;
 b=L5NiF+QGKiZxOw/rbicSpQkEHT0crhQLVhYVk6CSslkbACndLUKjF0nf1L+thUwnhO
 Gwfghp7WcoTLhc6Or8M1PbGzP0CzARFLKaMripeFRYlMzeZQT4WEkbE1xK2SxU50iPfd
 m1uDS8f/qsKU+4kU8n8wXZpZ9gAAs2KxPVWdRPHyRPlzLh7K5Ktt9QsqZffUn4SQvjX0
 /x8YffQ1oLEEpIIZ6DgITzQb9Zx/ZSxO6yIZ39pP1LE5O9zu6Bn3DNfDtLLld1j40HCU
 VzbwftNJ1H0thjokD+SaicCBfEiXH/MobGAcG6ZQOuxeAJ+VpieEZN+QGP6zFbNd8oks
 gFNw==
X-Gm-Message-State: AOJu0YwwY9AZv7ORVH+jgoXsr4iGKsMrXE2ZKZtlb7CZ0BRwtUwrC25s
 TdP4VpFbNL2djFH/hsUSPkFjXzrEbYKdn/7ldrEeGmxFzBdL99o3JNTV
X-Gm-Gg: AR+sD13RwbR0AmYVu8Wx2OiU9WbfPS7yB/PeYXilO+OeCUhr0BIFRvSr+HWoSRexm2k
 9Uzs18Iy4QDoaJLK+LuUlKPz6sgIqzXI+zuw6Ncp9thtwev3XiWCQxKByhexpwicTQs9XEZpBGP
 V8QaJMQPzJRrAitKLWPa8bkI6CIDc8J6OAGPA/MjwvNDsGi9zxHhluSipfrqw8WDyNVp0UzvAYV
 BF1c9AXuzZXIWr4yR+Wq8NfkIltdtCF//a+Fi2Zpde0dSqu9u1J2lzgYYeoP2Kxcvb6eO9j3XJa
 1UlwrHB2IKnA3GFmg9UdXU2WNf/HpMvvaMMXomM37FOAYq68vf5SCjOafhnDLGXSEOgpLhHyEOG
 u4h5HJG1NHMG2kFokwItKrGcL/BjX3mJl67NbC3WxcUBchbK745syewTMq5yYXes5K1Ls1yoHnL
 PBpXeWIUjzrBXfwvjk9joLJ7Q3EO3C0GEEqhYB2I/x0emidzmjl2KtMJk9caWzE/XQGi4tVyGOd
 DOnpK6/lTE1T3oyIs9UmNrIz/CN782gCeZdrYhA5dRI7fKw4reaPLa477GwH+tRMMldqiFPm7i0
 XG4mRg/pARxE5S3BrrQxcae+Og==
X-Received: by 2002:a05:6808:5385:b0:4a4:9e18:607a with SMTP id
 5614622812f47-4b2bcb6daf0mr9471555b6e.21.1787195947888; 
 Wed, 19 Aug 2026 20:19:07 -0700 (PDT)
Received: from craftbox (static-173-249-255-172.cust.tzulo.com.
 [173.249.255.172]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d68439f5sm619427b6e.5.2026.08.19.20.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:19:07 -0700 (PDT)
From: Nathan Bourgeois <iridescentrosesfall@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nathan Bourgeois <iridescentrosesfall@gmail.com>
Subject: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt on
 non-TT resources
Date: Wed, 19 Aug 2026 23:19:01 -0400
Message-ID: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

When a buffer object (BO) has a created but unpopulated ttm_tt and is
exported, the default behavior populates the ttm_tt, even if the manager
does not require a TT. This unnecessary host-side population reduces
host memory available to the user.

This occurs when a BO is created with XE_BO_FLAG_DEFER_BACKING and
migration places the BO into a resource whose manager does not use the
TT backing. The retained ttm_tt is not authoritative for storage, yet
the default ttm_bo_setup_export() treats the existence of the ttm_tt as
requiring population.

The issue was reproduced with vLLM 0.27.1 loading
0xSer0/DeepSeek-V4-Flash-180B (d3c704b) on a system with 128 GB of RAM
and six Intel Arc Pro B70 GPUs providing 192 GB of VRAM. Loading the
weights (100.61 GB) triggered host-memory exhaustion and OOM events on
the baseline kernel.

On Ubuntu 24.04 with 7.0-12-generic, the vLLM service cgroup grew by
115.84 GB on the instrumented baseline and by 15.34 GB with this change,
a reduction of 100.50 GB. Diagnostic instrumentation counting cumulative
TT pages across all six GPUs recorded 109.22 GB on baseline and 8.72 GB
with this change. The reduction is 0.11 GB less than the model weight
size.

The change creates an Xe-local export setup helper which skips
ttm_bo_populate() when the BO has a current resource manager and if that
manager has use_tt == false. If the manager does not use TT, then
population is skipped, while an absent manager conservatively calls
ttm_bo_populate(). Behavior for a manager which requires a TT backing
remains unchanged. Keep this policy local to Xe so other TTM drivers
retain their existing export behavior.

The regression test creates both the control case and the VRAM migration
case. The control case creates the deferred BO in system RAM and leaves
it there, which requires a TT and population when xe_gem_prime_export() is
called. The VRAM migration case creates the deferred BO in system RAM
and then migrates it to VRAM, which does not require a TT and thus, when
xe_gem_prime_export() is called, no population occurs.

Fixes: 91494dee1091 ("xe: populate buffers before exporting them.")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nathan Bourgeois <iridescentrosesfall@gmail.com>
---
Newer Testing:
- Built and booted b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6 plus this patch on EPYC 7352 with six Intel Arc Pro B70.
- KUnit xe_live_test: xe_dma_buf_kunit: pass:6 fail:0 skip:0 total:6 PASS
- vLLM 0.27.1 loading DeepSeek-V4-Flash-0731 (full model compared to REAP) on six Intel Arc Pro B70 GPUs: No OOM error, 17.82 GB delta.
 drivers/gpu/drm/xe/tests/xe_dma_buf.c | 105 ++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_dma_buf.c       |  28 ++++++-
 2 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
index 0be8440b3976..bff803ab7a57 100644
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
@@ -260,12 +260,117 @@ static const struct dma_buf_test_params test_params[] = {
 	{}
 };
 
+static void xe_test_dmabuf_export_deferred(struct xe_device *xe, u32 bo_flags,
+					   u32 mem_type, bool expect_populated)
+{
+	struct drm_exec *exec = XE_VALIDATION_OPT_OUT;
+	struct kunit *test = kunit_get_current_test();
+	struct ttm_resource_manager *man;
+	struct dma_buf *dmabuf;
+	struct xe_bo *bo;
+	size_t size = PAGE_SIZE;
+	int err;
+
+	/* No VRAM on device? */
+	if (!ttm_manager_type(&xe->ttm, mem_type))
+		return;
+
+	if (mem_type == XE_PL_VRAM0 &&
+	    xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
+		size = SZ_64K;
+
+	/*
+	 * DEFER_BACKING places the BO in SYSTEM and creates a ttm_tt which
+	 * is unpopulated. In the case of VRAM, migrating leaves the ttm_tt
+	 * retained and unpopulated while VRAM becomes the real backing.
+	 */
+	bo = xe_bo_create_user(xe, NULL, size, DRM_XE_GEM_CPU_CACHING_WC,
+			       bo_flags | XE_BO_FLAG_DEFER_BACKING, NULL);
+	if (IS_ERR(bo)) {
+		KUNIT_FAIL(test, "BO creation failed: %pe\n", bo);
+		return;
+	}
+
+	err = xe_bo_lock(bo, false);
+	if (err) {
+		KUNIT_FAIL(test, "BO lock failed: %d\n", err);
+		goto out_put_bo;
+	}
+
+	if (bo->ttm.resource->mem_type != mem_type)
+		err = xe_bo_migrate(bo, mem_type, NULL, exec);
+	if (err) {
+		KUNIT_FAIL(test, "BO migration to %u failed: %d\n", mem_type,
+			   err);
+		goto out_unlock;
+	}
+
+	man = ttm_manager_type(bo->ttm.bdev, bo->ttm.resource->mem_type);
+	if (!man || !bo->ttm.ttm) {
+		KUNIT_FAIL(test, "Expected a retained unpopulated TT\n");
+		goto out_unlock;
+	}
+
+	/* Precondition: ttm_tt starts unpopulated after migration */
+	KUNIT_EXPECT_EQ(test, man->use_tt, expect_populated);
+	KUNIT_EXPECT_FALSE(test, ttm_tt_is_populated(bo->ttm.ttm));
+
+	xe_bo_unlock(bo);
+
+	dmabuf = xe_gem_prime_export(&bo->ttm.base, 0);
+	if (IS_ERR(dmabuf)) {
+		KUNIT_FAIL(test, "dma-buf export failed: %pe\n", dmabuf);
+		goto out_put_bo;
+	}
+
+	err = xe_bo_lock(bo, false);
+	if (err) {
+		KUNIT_FAIL(test, "post-export BO lock failed: %d\n", err);
+		goto out_put_dmabuf;
+	}
+
+	/* Postcondition: if VRAM, ttm_tt remains unpopulated, if SYSTEM ttm_tt is populated */
+	KUNIT_EXPECT_EQ(test, bo->ttm.resource->mem_type, mem_type);
+	KUNIT_EXPECT_NOT_NULL(test, bo->ttm.ttm);
+	if (bo->ttm.ttm)
+		KUNIT_EXPECT_EQ(test, ttm_tt_is_populated(bo->ttm.ttm),
+				expect_populated);
+
+	xe_bo_unlock(bo);
+	dma_buf_put(dmabuf);
+	drm_gem_object_put(&bo->ttm.base);
+	return;
+
+out_unlock:
+	xe_bo_unlock(bo);
+	goto out_put_bo;
+out_put_dmabuf:
+	dma_buf_put(dmabuf);
+out_put_bo:
+	drm_gem_object_put(&bo->ttm.base);
+}
+
 static int dma_buf_run_device(struct xe_device *xe)
 {
 	const struct dma_buf_test_params *params;
 	struct kunit *test = kunit_get_current_test();
 
 	guard(xe_pm_runtime)(xe);
+
+	/*
+	 * A retained TT must not be populated when VRAM is the backing
+	 * resource.
+	 */
+	xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_VRAM0, XE_PL_VRAM0,
+				       false);
+
+	/*
+	 * Control case: deferred SYSTEM backing must still be populated
+	 * before export.
+	 */
+	xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_SYSTEM, XE_PL_SYSTEM,
+				       true);
+
 	for (params = test_params; params->mem_mask; ++params) {
 		struct dma_buf_test_params p = *params;
 
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index bf0728838ead..0c4e4e2e1a81 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -219,6 +219,32 @@ static const struct dma_buf_ops xe_dmabuf_ops = {
 	.vunmap = drm_gem_dmabuf_vunmap,
 };
 
+static int xe_dma_bo_setup_export(struct ttm_buffer_object *tbo,
+				  struct ttm_operation_ctx *ctx)
+{
+	struct ttm_resource_manager *man = NULL;
+	int ret;
+
+	ret = ttm_bo_reserve(tbo, false, false, NULL);
+	if (ret)
+		return ret;
+
+	if (tbo->resource)
+		man = ttm_manager_type(tbo->bdev, tbo->resource->mem_type);
+
+	/*
+	 * Do not populate BO-sized system pages when backed by a non-TT resource.
+	 * This is Xe-specific; the generic ttm_bo_setup_export() always populates.
+	 */
+	if (man && !man->use_tt)
+		ret = 0;
+	else
+		ret = ttm_bo_populate(tbo, ctx);
+
+	ttm_bo_unreserve(tbo);
+	return ret;
+}
+
 struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 {
 	struct xe_bo *bo = gem_to_xe_bo(obj);
@@ -257,7 +283,7 @@ struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 	xe_bo_willneed_get_locked(bo);
 	xe_bo_unlock(bo);
 
-	ret = ttm_bo_setup_export(&bo->ttm, &ctx);
+	ret = xe_dma_bo_setup_export(&bo->ttm, &ctx);
 	if (ret)
 		goto out_put;
 

base-commit: b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
-- 
2.55.0

