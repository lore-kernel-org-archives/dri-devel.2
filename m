Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DCBCA6017
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BD210E165;
	Fri,  9 Oct 2026 00:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UKuytMMR";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1ED410EA58
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 00:21:32 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so26900925e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791505291; x=1792110091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kIz/qZTA1DVdo8Wv1KvtH0Jov9NyNDxXYjGr4vU3wa4=;
 b=UKuytMMR3PIRaf/09fimy0B+qwZ/YniPEuWN9LofOALb/z2GpUiCRAg2HMcn4GdIEz
 6MX9JmUvdY3e3L5DK3qmxH+cGVkTftyxWCvWf3IvyXbtWo49U+Ctgm60BM3AZ4UyQZiA
 DLygCqnWW9XliW/yTXkEn6SfYTb8gTAYZLUiG6AKIHI+2BjYaJmC5f6pOXWEcZdtLNou
 0iP5dCoAowsTVe4xP4aVYMvIYanFsjyAVU6Bfm+QqKdt8tS9t/hs5lf/tGsTPzdNvCrv
 TjOyyP9F2KZuFKSEnpWJhEKqKZIT6Njg2ERNyCPaSqnjPkjt1EWthrpyoKFKF32M8005
 ZJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791505291; x=1792110091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kIz/qZTA1DVdo8Wv1KvtH0Jov9NyNDxXYjGr4vU3wa4=;
 b=uE32k1zhY47SNoBos8cKzrtUQ2/U/Zm67Lba2hy/DOcUdCO5G6/hUi7ZcGSm86RXmd
 yRWOgst5hf025Sdki39VMU8ECsHO3howo8fJWgy4r5++edes/32b37J1n4NfmFDUnth0
 wKzGwgUA6FZAJVtx3KZNzEIkMDkgJHYPVTUVroD08jpul/QcKhEGzNcikmWIIavOCkS+
 mpZQVflhQXurz5lJySPkcO27Zwn5k/vjqwqflYz+3h/i5NEfp2IZugsj90VSkgTiobHj
 5yFJf1XdiafQWCO4NB2Krdai2z9JMyk4CAQZBN+xlUsgtOlI30kkTmbdShaotJj+C3m0
 AlXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaw5c7sr835fBI/gTWX0tFbzyw24RC9+5ebXowx7vx0dujirpKdCNnacMJ13R/UgawXRHSrN44wqo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mBLNCvsY/r5cmZGn2Cfs0Q4Nwkapbi74GWC1tLAudBgsvZQt+G
 pZhGo4mQpOLv1M1YKaSLv7ubr6Vad2AkQpHXGpj4EUx5q7nL+RU9HCec
X-Gm-Gg: AYBFou3UFBHEZikEHD6cldMpGrqHpkwlK8gw6u29U/0rzm9hrwfBfG5SCUSRMg4MxHH
 H0z9s1mM0jHnGhGTZuxaRqbJeVlqg71mtKFwtxY6wb5GgHVKKft2s3z9sd/vNeEYKhHmciPZZ3X
 6gnMdEGYQhUGV/wG9oTIpiihS/Ql5kljyEpn1zffWLAGNGLzgaY6ufLDc2feZ+5eT74YCvL4/kn
 v4xiPo8naYLc4mHzmSkfrxd85LdDD1Ic0Lp1cZK+gJSi0dRXB1DyBWBSPz0ibBsYEsQ0fON1Z9i
 I3ZKQ3EQ9NDsLs1Wx6Ebb9zMdTo3khGSA5WutAoRJKfEBpuWDJH+L7abjY1yer1UUrj1WGkizRJ
 UZCUY9CWuDM8xvy6iERFFkVKgrQSRAhD33q5qJptulnKGpA7oMpdeXj5VEw2c+AwHOMCBRY0oEH
 FSV3wxqDf1i/Grwdp+Db20A7+la7fYj00NBV8MrZpj5WlfjeeaHMtFZAxRP+R1r1RA4TvQaLsjZ
 Za6WduacBA8xcV86VWvpUBA32rIh2aMtdGcYfbCRMYnY/6NShcYCrachIY7qtWtPeo1Rjogh+sl
 0SO2e2SFxf05/qcg9Sn8ynsucd1xuBYgZzQhWB46Kb6f1Zd0lNtvwsp8MpYB4Vxwe8O2RlFbeTB
 pP7Dh7H0=
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id
 5b1f17b1804b1-4a18e4d8bbamr2152055e9.27.1791505291199; 
 Thu, 08 Oct 2026 17:21:31 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de.
 [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e4987casm3364605e9.1.2026.10.08.17.21.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 17:21:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] drm/rockchip: Map imported buffers from DMA addresses
Date: Fri,  9 Oct 2026 02:21:14 +0200
Message-Id: <20261009002114.67851-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261009002114.67851-1-kmehltretter@gmail.com>
References: <20261009002114.67851-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

rockchip_gem_prime_import_sg_table() uses iommu_map_sgtable(), which reads
CPU-side pages and lengths. DMABUF_DEBUG clears these fields, causing
the RK3588 import failures reported by Diederik de Haas.

The attachment's DMA addresses belong to the VOP's default domain,
while scanout uses a separate DRM domain. Use iommu_map_sgtable_dma()
to copy the live mapping into that domain.

Keep native allocations unchanged. Unsupported imports still use the
old page-based path and remain unfixed under strict DMABUF_DEBUG.
This RFC retains reverse translation rather than sharing the DMA domain.

Reported-by: Diederik de Haas <diederik@cknow-tech.com>
Link: https://lore.kernel.org/r/DLR74W1U9YPC.375IK0HOYHDIG@cknow-tech.com/
Link: https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 9a1dc9f12072..501c94cb921a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -20,7 +20,8 @@
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_gem.h"
 
-static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
+static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj,
+				  struct device *dma_dev)
 {
 	struct drm_device *drm = rk_obj->base.dev;
 	struct rockchip_drm_private *private = drm->dev_private;
@@ -40,8 +41,16 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	rk_obj->dma_addr = rk_obj->mm.start;
 
-	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
-				prot);
+	if (dma_dev) {
+		ret = iommu_map_sgtable_dma(private->domain, rk_obj->dma_addr,
+					    dma_dev, rk_obj->sgt, prot);
+		if (ret == -EOPNOTSUPP)
+			ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr,
+						rk_obj->sgt, prot);
+	} else {
+		ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr,
+					rk_obj->sgt, prot);
+	}
 	if (ret < (ssize_t)rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
@@ -131,7 +140,7 @@ static int rockchip_gem_alloc_iommu(struct rockchip_gem_object *rk_obj,
 	if (ret < 0)
 		return ret;
 
-	ret = rockchip_gem_iommu_map(rk_obj);
+	ret = rockchip_gem_iommu_map(rk_obj, NULL);
 	if (ret < 0)
 		goto err_free;
 
@@ -457,7 +466,7 @@ rockchip_gem_iommu_map_sg(struct drm_device *drm,
 			  struct rockchip_gem_object *rk_obj)
 {
 	rk_obj->sgt = sg;
-	return rockchip_gem_iommu_map(rk_obj);
+	return rockchip_gem_iommu_map(rk_obj, attach->dev);
 }
 
 static int
-- 
2.53.0

