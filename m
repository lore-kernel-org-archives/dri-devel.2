Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAE606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=5sf9CPwg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590D010EE95;
	Tue, 10 Nov 2026 08:33:41 +0000 (UTC)
X-Greylist: delayed 29815 seconds by postgrey-1.36 at gabe;
 Mon, 09 Nov 2026 20:49:11 UTC
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9FC10E200;
 Mon,  9 Nov 2026 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1794257349; x=1794516549;
 bh=cs+bXmfUCXgKBgrn9ra6SkgURaov22hq6rM9gDfOPu0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=5sf9CPwghpXHVDv5iIBVjHr+8nCs2SH9VJF7KutadA6haNVG1HvaQPdGUrCxAZpC2
 3s+6XD+2i1wi6IO+XCrSZ/F8iLVgOcnEg3LqkUJGVTGx7YI8rw69SlPxONGUy2FU7x
 gVFnfdu0E+KJl94a+l/AO4CS4orsJwFd53BdMVhHOz1IYX5z9Xa7qHML2wO6vQVfxN
 Y+oC8VKmUarsXfRQ49YDW5UlFBHp68N0YngCG/8KL8+ZLHHEjDh9egrLI1KpXm3ADC
 JJE4um0se8xvF1a5aCpoxL4r9r3SW6hJLUKPNHIT9wKuIatfNavP0+XGqJpZO40PLP
 6SEOvmknEALyQ==
X-Pm-Submission-Id: 4jNhhx0phjz1DFF6
From: Michael McAllister <me@michaelmcallister.org>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm: avoid an unmatched fbdev IOVA pin
In-Reply-To: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
References: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
Date: Mon, 09 Nov 2026 20:47:01 +0000
Message-ID: <179425722110.3461.10554987541005946397.msm-fbdev-pin-leak-v2@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Unbinding the display on the Moto G10 produces a pin-count warning when
the console framebuffer is freed. The fbdev probe takes an IOVA pin,
but normal teardown never drops it.

Reserve the address with msm_gem_get_iova() instead. Scanout pins the
buffer while it is in use, and the CPU mapping holds its own pin.

Keep a VMA reference for fbdev so deleting the temporary GEM handle does
not release the reserved address. Drop that reference on probe failure
or when the framebuffer is destroyed. This also balances the existing
error-path VMA put, which otherwise drops the handle's reference twice.

Get the CPU mapping before publishing the framebuffer in the helper, so
a mapping failure does not leave helper->fb and helper->buffer pointing
to freed memory.

Fixes: 7ad0e8cf6317 ("drm/msm: Count how many times iova memory is pinned")
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi,

Changes in v2:
- Keep the fbdev VMA reference until teardown and balance the error paths.
- Get the CPU mapping before publishing the helper pointers.

Thanks,
Michael

 drivers/gpu/drm/msm/msm_fbdev.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index dd6d6c507d..ed599884bf 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -48,6 +48,7 @@ static void msm_fbdev_fb_destroy(struct fb_info *info)
 	drm_fb_helper_fini(helper);
 
 	msm_gem_put_vaddr(bo);
+	msm_gem_vma_put(bo);
 
 	drm_client_buffer_delete(helper->buffer);
 	drm_client_release(&helper->client);
@@ -137,15 +138,18 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 		goto err_drm_gem_handle_delete;
 	}
 
-	/*
-	 * NOTE: if we can be guaranteed to be able to map buffer
-	 * in panic (ie. lock-safe, etc) we could avoid pinning the
-	 * buffer now:
-	 */
-	ret = msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
+	/* Keep the IOVA reserved after deleting the temporary GEM handle. */
+	msm_gem_vma_get(bo);
+	ret = msm_gem_get_iova(bo, priv->kms->vm, &paddr);
 	if (ret) {
 		drm_err(dev, "failed to get buffer obj iova: %d\n", ret);
-		goto err_drm_client_buffer_delete;
+		goto err_msm_gem_vma_put;
+	}
+
+	fbi->screen_buffer = msm_gem_get_vaddr(bo);
+	if (IS_ERR(fbi->screen_buffer)) {
+		ret = PTR_ERR(fbi->screen_buffer);
+		goto err_msm_gem_vma_put;
 	}
 
 	DBG("fbi=%p, dev=%p", fbi, dev);
@@ -159,11 +163,6 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(fbi, helper, sizes);
 
-	fbi->screen_buffer = msm_gem_get_vaddr(bo);
-	if (IS_ERR(fbi->screen_buffer)) {
-		ret = PTR_ERR(fbi->screen_buffer);
-		goto err_msm_gem_unpin;
-	}
 	fbi->screen_size = bo->size;
 	fbi->fix.smem_start = paddr;
 	fbi->fix.smem_len = bo->size;
@@ -179,10 +178,8 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	return 0;
 
-err_msm_gem_unpin:
-	msm_gem_unpin_iova(bo, priv->kms->vm);
+err_msm_gem_vma_put:
 	msm_gem_vma_put(bo);
-err_drm_client_buffer_delete:
 	drm_client_buffer_delete(buffer);
 err_drm_gem_handle_delete:
 	drm_gem_handle_delete(file, handle);

base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.39.5

