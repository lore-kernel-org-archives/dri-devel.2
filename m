Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2B9C982F1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE6110E383;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1k0JeJG";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A802710E1B6
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 21:28:59 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso2003176a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789853339; x=1790458139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jfuK4sNLwi6LLkfdWONjv/BG3p1tIa4X/0S+wLmRAsY=;
 b=V1k0JeJGO3J94ywOM8E0KobkX9g2HluQt7/26mX0ydnemEEjWk0S1/C0HY4ZPBxuRr
 VbbX9EN4YGhVjqQJQkHNKruXLablk42E8fhfj0jrpjFU7Jwu50vV1OuGQCj9SO8rwYaj
 OLyZ75M5VvX1DLx/uahn6+UYbpj8tvYImaWIaxn8eoI/qH3tdye8H6mcaxZSLppbn3zH
 WPVzOGNPgVrhsDyOSEm6KFTdUGn7883d/7XXH0yk4PE6B68nHaNZi1kaacOVcNUcfYSX
 ABG0Sas+PANfkw7cGMSEHq7PCaFLI22XU6IYZzvbEDEb0/6ZVrp69eLMAw0xgKt2AJLN
 xZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853339; x=1790458139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jfuK4sNLwi6LLkfdWONjv/BG3p1tIa4X/0S+wLmRAsY=;
 b=hLxd/Zj3DeNs6/I6Pg2WA4pe834RAW45JDTHJ8avvkCmdmWxhCAx8uiF+LjK26DCuG
 ppOvjT9S4h+omKEmu3x3aZS5xw+Ky9POnYb1bGMaM74vOzoMv9bbAwZRuLE3m9etFXVL
 4lSNRrdeBbrWDIByvMCer+haUPkSeMya7P4Jl7q5ailU7p7w0/aOkEY3RT+AHhTp8ZNd
 BS+zpWCIyUJ97IFufnUHFJVXXw+xc1wDYCyXCL83I1OWpKe+09PKO4qX2psjis/HBJWY
 ZkmPqTQ3Uvxb32P9Ez3axcqICNIVcYyvQhtEWzMcgZ6CtA17uPZnxhqkN1Fmsnb5ZyUd
 4nGg==
X-Gm-Message-State: AFuF++nkroDURRA7JDzHmOGm9B3PmkPZw7ifxG0TqzzRA5VUk7D3DtUG
 DUZvsnBLFkjaBgX0UtM8wh5qM2K9CwqoGS4WnFl3AxzZKZOUhBAPxH7oYbwTUgm2
X-Gm-Gg: AYBFou0N+oN6+TtgXas5VjO8BBqOPieYI6gXczhq2PgOSWZ7kUGCgmWueRpmhX7X0Ow
 nkNnF3zSQSSFs8cX5xcez5zg/Dyrl7s/nwcSSIGjXbutdNER12cox2ap7LvWUV4pIq1Ph/YiuCP
 ZKKrGP/cTjXqCEFVPSK94myUGhu5IrOueZ+1SEclU4/cL1xOtX2/1xztLMpsaLY4OxnC2G8OxOI
 M2RfrDVRL/004N65JaayKJG+pT3wtNll6wZ0UBSW7VaqGlWkiW50fC5+uuzu+Hrgx+SW9VmFvVa
 Kx4SozPPeINjenN5lVIOrwfqKHz6X12jwJickrB2Tt3ZZxH/hi/yTfMuQw34VijhygJ1ZENlduR
 LMNiBm6N+tEOCqCHu2Z+CifNjoYxbOE4LGj/L6zBDDzukJs57EzpTfqNEpmpodktOlB2S8kBHUq
 iI+sSsmOtJNUQSrExvYvfOIZZf8gTJJesr3p5yPDktKYfneFOjMtB5RkKNLScpjuRoeTi5Yna2B
 h/zH2gzM4wYajK1fu4m/gYB4HLs9KmV0/FktNWi4YWSeGbfjdr7lA523ij0C7bHB+WT2lgD/MFe
 Z32O6bsUIA==
X-Received: by 2002:a17:90b:544e:b0:39e:6a82:afd0 with SMTP id
 98e67ed59e1d1-39e6a82bbabmr5629083a91.34.1789853339125; 
 Sat, 19 Sep 2026 14:28:59 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a031d63ca9sm1487914a91.14.2026.09.19.14.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 14:28:58 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vgem: fix IDR slot and xa_node memory leak in
 vgem_fence_signal_ioctl()
Date: Sat, 19 Sep 2026 21:28:58 +0000
Message-ID: <20260919212858.3241545-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

In `vgem_fence_signal_ioctl()`, `idr_replace(&vfile->fence_idr, NULL,
arg->fence)` is called instead of `idr_remove(&vfile->fence_idr,
arg->fence)`.

Because `idr_replace()` replaces the slot's pointer with `NULL` in the
underlying XArray without freeing the IDR slot (`xa_erase()`), the ID
remains allocated until the vgem file descriptor is closed. Repeated
`DRM_IOCTL_VGEM_FENCE_ATTACH` + `DRM_IOCTL_VGEM_FENCE_SIGNAL` cycles on
a long-lived vgem fd permanently accumulate `xa_node` slab allocations
in the kernel and exhaust the per-fd IDR space.

Replace `idr_replace(&vfile->fence_idr, NULL, arg->fence)` with
`idr_remove(&vfile->fence_idr, arg->fence)`.

Fixes: 407779848445 ("drm/vgem: Attach sw fences to exported vGEM dma-buf (ioctl)")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 drivers/gpu/drm/vgem/vgem_fence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index 0e53ba7db629..5793be469b3c 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -200,12 +200,10 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
 		return -EINVAL;
 
 	mutex_lock(&vfile->fence_mutex);
-	fence = idr_replace(&vfile->fence_idr, NULL, arg->fence);
+	fence = idr_remove(&vfile->fence_idr, arg->fence);
 	mutex_unlock(&vfile->fence_mutex);
 	if (!fence)
 		return -ENOENT;
-	if (IS_ERR(fence))
-		return PTR_ERR(fence);
 
 	if (dma_fence_is_signaled(fence))
 		ret = -ETIMEDOUT;
-- 
2.55.0.1082.g2b9226bbc0-goog

