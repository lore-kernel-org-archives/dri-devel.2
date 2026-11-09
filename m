Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CE606A9AE
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=Zcz5Pw/K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D2F10E2CA;
	Tue, 10 Nov 2026 08:33:28 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C7310F444;
 Mon,  9 Nov 2026 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1794243718; x=1794502918;
 bh=oG2TQCsxpY9LqxmAzIoNvh0i+sGuT0ezlKI+pPVi9Lk=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Zcz5Pw/K/Nb3lm/LjVL2d3V4Czp5fRaoBS8WWx4EAednhE+aadDUSA8XzrdTKH4H8
 IMUWYxKkcKrq8Pcc7uVhFZfdOK7aAUEfTNYwrIHy9alzBX8rO2N7WFHE1+cVitlIrp
 1lMlR5rKPJAbVtNsrCZw8v/qvO6tx4otFbLd4zv/NqpfWB/T5YiocbYaJqex8tnSMT
 ra9aRsyOZw7BcfIUhrIpYamHV3jtOq8SsQhjbyw06GBOa6F7ds+GYH00uk6x1Aj1mu
 Hwi4Voenn515X0j6MHHxKI0dZblI1BvrzJpty55OuNQtxvem9kdsdx3oxh/IZZ/Qdt
 q1BxQ+xZD5sMw==
X-Pm-Submission-Id: 4jNbfr2WvNz2ScWs
From: Michael McAllister <me@michaelmcallister.org>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: avoid an unmatched fbdev IOVA pin
Date: Mon, 09 Nov 2026 17:01:51 +0000
Message-ID: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
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

Use msm_gem_get_iova() to reserve the address without taking that extra
pin. Scanout already pins the buffer while it is in use, and the CPU
mapping holds its own pin. Drop the matching unpin from the error path.

Fixes: 7ad0e8cf6317 ("drm/msm: Count how many times iova memory is pinned")
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi,

I found another pin-count warning while testing display teardown on the
Moto G10. This one is in fbdev: it takes a pin when creating the console
framebuffer, but doesn't drop it when the framebuffer is freed.

I tested this alongside the other display fixes on 7.2.9, including
unbind/rebind with the compositor stopped. It is independent of the DSI
command-buffer fix I sent earlier.

Thanks,
Michael

 drivers/gpu/drm/msm/msm_fbdev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index dd6d6c507d..c3bec6719c 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -137,12 +137,8 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 		goto err_drm_gem_handle_delete;
 	}
 
-	/*
-	 * NOTE: if we can be guaranteed to be able to map buffer
-	 * in panic (ie. lock-safe, etc) we could avoid pinning the
-	 * buffer now:
-	 */
-	ret = msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
+	/* Scanout pins the buffer; only reserve its address here. */
+	ret = msm_gem_get_iova(bo, priv->kms->vm, &paddr);
 	if (ret) {
 		drm_err(dev, "failed to get buffer obj iova: %d\n", ret);
 		goto err_drm_client_buffer_delete;
@@ -162,7 +158,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	fbi->screen_buffer = msm_gem_get_vaddr(bo);
 	if (IS_ERR(fbi->screen_buffer)) {
 		ret = PTR_ERR(fbi->screen_buffer);
-		goto err_msm_gem_unpin;
+		goto err_msm_gem_vma_put;
 	}
 	fbi->screen_size = bo->size;
 	fbi->fix.smem_start = paddr;
@@ -179,8 +175,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	return 0;
 
-err_msm_gem_unpin:
-	msm_gem_unpin_iova(bo, priv->kms->vm);
+err_msm_gem_vma_put:
 	msm_gem_vma_put(bo);
 err_drm_client_buffer_delete:
 	drm_client_buffer_delete(buffer);

base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.39.5

