Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0144606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHuJDZsp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C6811261C;
	Thu, 26 Nov 2026 17:06:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBFF112613;
 Thu, 26 Nov 2026 17:05:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D75AC60CC9;
 Thu, 26 Nov 2026 17:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BAD1F000CF;
 Thu, 26 Nov 2026 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712751;
 bh=yg65JGwcrMTp4Xs9zqZhDkeQCmvP3MpmYYEyFpYrG2k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JHuJDZsp/nrZlLIhLJ1ChA20B2YYW968lb/mW+tT69g5fQTAfE287+Qa8qHJcr/gQ
 jwKwbHIZ7TvWfaCgPL6PjmGiOd41mUL29ofABH0BvUb2HtyRzPjsAd3bt5Hyo4dsM9
 5Bt+ukKOkoIbjVfSt6rGMq6/IsJW8ice9t1GYrKtMa122yKvGogFq61KF6EFtxdRMu
 U3BFZrTSnH25rRjWekcKrhT4/E8Iau8SyaJ4W1dqcBKPHzsb0OqUuGYSOuspRcoeTh
 eBTDU0feJliNAUuK41mT05Sivpfz0nxDcyVLCCWNumUBit1p3gWaeXwCAdOLKgjzO8
 GKqohEcJLruDw==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: [PATCH 2/2] drm/msm: fbdev: Add the missing VMA reference of the
 framebuffer
Date: Thu, 26 Nov 2026 19:05:35 +0200
Message-ID: <20261126170535.361985-3-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261126170535.361985-1-vz@kernel.org>
References: <20261126170535.361985-1-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A VMA reference of the framebuffer buffer object is dropped on the probe
error path, like msm_framebuffer_cleanup() does, but the reference is
never taken, and the VMA reference count underflows on the following
deletion of the temporary GEM handle.

The missing reference also affects a successful probe: the KMS VMA is
torn down, when the VMA reference count drops to zero, which happens on
deletion of the temporary GEM handle at the end of the probe. Then
fbi->fix.smem_start points to an unmapped address, and on fbdev
destruction msm_gem_unpin_iova() finds no VMA and does not drop the pin,
unless the framebuffer is prepared for scanout at that time.

Take a VMA reference before pinning the framebuffer on probe, like
msm_framebuffer_prepare() does, and drop it after unpinning on fbdev
destruction.

Fixes: eb714953c441 ("drm/msm: fbdev: Use a DRM client buffer")
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpu/drm/msm/msm_fbdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 25e55b5c5ecc..b5ced6ede19f 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -50,6 +50,7 @@ static void msm_fbdev_fb_destroy(struct fb_info *info)
 
 	msm_gem_put_vaddr(bo);
 	msm_gem_unpin_iova(bo, priv->kms->vm);
+	msm_gem_vma_put(bo);
 
 	drm_client_buffer_delete(helper->buffer);
 	drm_client_release(&helper->client);
@@ -144,10 +145,11 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	 * in panic (ie. lock-safe, etc) we could avoid pinning the
 	 * buffer now:
 	 */
+	msm_gem_vma_get(bo);
 	ret = msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
 	if (ret) {
 		drm_err(dev, "failed to get buffer obj iova: %d\n", ret);
-		goto err_drm_client_buffer_delete;
+		goto err_msm_gem_vma_put;
 	}
 
 	DBG("fbi=%p, dev=%p", fbi, dev);
@@ -183,8 +185,8 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 err_msm_gem_unpin:
 	msm_gem_unpin_iova(bo, priv->kms->vm);
+err_msm_gem_vma_put:
 	msm_gem_vma_put(bo);
-err_drm_client_buffer_delete:
 	drm_client_buffer_delete(buffer);
 err_drm_gem_handle_delete:
 	drm_gem_handle_delete(file, handle);
-- 
2.51.0

