Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70103606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjeLRLMx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40E4112616;
	Thu, 26 Nov 2026 17:05:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2C7890B6;
 Thu, 26 Nov 2026 17:05:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50C6E45149;
 Thu, 26 Nov 2026 17:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAD11F000C0;
 Thu, 26 Nov 2026 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795712748;
 bh=Y31QOYSjkwVXeBu0iykFUqlYudJkbfULT7s0fbEPojA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hjeLRLMxMEktFiDP0dwsbcP+t1Y3tGxZqF+LpOUuWFfEjXLNDPQ5ZJfILcMXxhRZ1
 BPvNkmWPkShynD+gUf1zq48DVn0UbUzgOCP0kKWTkdbTQkq4mt8DBy1dif+WQyt3+E
 o2Or+0/M7X4eAhGhtZz7DPtIeNthHz2aVaydwa9lRWjtmtEeWQalFucaD+aCdOZNi7
 8HgWVKXxEozd8azH9MFpm7O4vhzP5jj/B0UyAG/9Xkqyfq4D3sxJMd4JT4XJw9UKW/
 62Gr4IRlqlANunAzEyxxjkEGPXYckHgiZnzd9P2DaaQ2B7Of3NlBQP+xk8qemUOxmV
 ER3rcnEXyG01A==
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
Subject: [PATCH 1/2] drm/msm: fbdev: Unpin the framebuffer buffer object on
 destroy
Date: Thu, 26 Nov 2026 19:05:34 +0200
Message-ID: <20261126170535.361985-2-vz@kernel.org>
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

The fbdev emulation pins the framebuffer buffer object in the KMS
address space and maps it on probe, however on fbdev destruction only
the mapping is released, and the buffer object is freed while still
pinned. For instance on removal of a DSI panel driver module, which
unbinds the MSM DRM driver, the next warning message is displayed:

  msm_obj->pin_count
  WARNING: drivers/gpu/drm/msm/msm_gem.c:173 at update_lru_locked+0x90/0x98
  Call trace:
   update_lru_locked+0x90/0x98 (P)
   put_pages+0x8c/0x104
   msm_gem_free_object+0x1bc/0x244
   drm_gem_object_free+0x1c/0x30
   drm_client_buffer_delete+0xd4/0xf8
   msm_fbdev_fb_destroy+0x54/0x6c
   put_fb_info+0x48/0x84
   unregister_framebuffer+0x88/0xf8
   drm_fb_helper_unregister_info+0x14/0x20
   drm_fbdev_client_unregister+0x18/0x34
   drm_client_dev_unregister+0x80/0xfc
   drm_dev_unregister+0x24/0x98
   msm_drm_uninit.isra.0+0x8c/0xcc

Unpin the buffer object on fbdev destruction in the same way as it is
done on the error path of the fbdev probe.

Fixes: 940b869c2f2f ("drm/msm: Implement fbdev emulation as in-kernel client")
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpu/drm/msm/msm_fbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index f37cc3f97a21..25e55b5c5ecc 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -41,6 +41,7 @@ static int msm_fbdev_mmap(struct fb_info *info, struct vm_area_struct *vma)
 static void msm_fbdev_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *helper = (struct drm_fb_helper *)info->par;
+	struct msm_drm_private *priv = helper->dev->dev_private;
 	struct drm_gem_object *bo = msm_framebuffer_bo(helper->fb, 0);
 
 	DBG();
@@ -48,6 +49,7 @@ static void msm_fbdev_fb_destroy(struct fb_info *info)
 	drm_fb_helper_fini(helper);
 
 	msm_gem_put_vaddr(bo);
+	msm_gem_unpin_iova(bo, priv->kms->vm);
 
 	drm_client_buffer_delete(helper->buffer);
 	drm_client_release(&helper->client);
-- 
2.51.0

