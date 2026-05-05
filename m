Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B631FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF8A10EC20;
	Tue,  5 May 2026 22:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="NXhEH37b";
	dkim-atps=neutral
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D0010EC20
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:28:05 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2b788a98557so47704765ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020085; x=1778624885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RvTF9O3uwFA3OWdHwZuGL0USnnrisuTr7nTufwNcCJA=;
 b=CmLoFKUij+7/r78qFNb5YHc0Aa4zeUQ4XJ4AqVccFhGh3Ks6fQE1o+FJ8Tfa0dyArP
 eQrshPffAvADRj29X2/z33Y1Dcv3d2Fr0wgEwZbO14Mht1RO1xZ0Uhc8LPsW91TOdyrd
 d6JrkkTqhqaot8VVQQF21Tk5gbN98hTR3mWfHnO/tFkdJVloC3/1KgA94K9BBbOeasJr
 9ICgC65fvjaUY5i0etNfZtwrtTjSdCNFk8qczrtUfDrZURDmNk3wLbKTWPVKjvJJlHU1
 hl5iEyGV3ysl2ifduNMb3lmlWzF4jBd9DyaaaH+Dj6z/b/upTDIlu8zx2Edsm84cVesd
 rULg==
X-Gm-Message-State: AOJu0YzWK5vyDFO2i7X+R0aTRJOFn0fTDHkCTjoBrNSGnUtKmo1G9EWp
 tvupEio3PQrlVd8dQkusNZZ7OpObcPBnowVZh63pOv7ht2GAhYRfAKX27jlTRoEddqzwsMm0XKo
 wmzvQGgvflzptx4HHtStlkoyPG60JR5Nc3RW6CFQjQF4xXHkqRAQTNLZ0MmS+aZBBmCxvVkAEo+
 cNm3lchxftT84t6qu3S5mfkoWQoMb7P4wF3bsiBEHK0AhVI6CP2PR/qJAHcLf3zBYu+Cph5eTLk
 oF6wICfF6+gzHTr9Hyl
X-Gm-Gg: AeBDieu9xh970fFafKZL17DpRwt+BDnhufjwDQV5Irn8ribk5btzIdtcxvTnSg69nRi
 AgzKxHSbE7r6Gynlg+dEhJkJXr6LeGvUtSfSbUZ112+oSuRMXQftBDKpsKUYAJ2DwYbYRXIGv95
 A68KcrO+rulbmWb7ZR+WhxLAQbIiL7rc0bO6XRrvCLBGYEje4wI0QMGyAp8INrQG9KyP+2WJXCZ
 qzsWu3CdHzRGqEE8UszWDO48PTkpay/EKNCrLdgSq9CggdLh2FWg72ux3g/0HZxLy8chUCP9KLQ
 RfG5SDaSCEjeyCvAAsaiCxh2UJpqhGdoSE+2GEtzZjLBK22IPfK8BChdkm6o/T2/O4245L5aSkp
 +yNVS3jH4vCo971Byxffx02VLxLa7wEgg94oTocHmRAEKTzK8T1Vb8LoE12L8yGVqUSqfzedKSW
 7wFglpUOX4HcjK
X-Received: by 2002:a17:903:4b03:b0:2ba:6013:eeaf with SMTP id
 d9443c01a7336-2ba7a207648mr7097675ad.19.1778020085030; 
 Tue, 05 May 2026 15:28:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2ba7c9d01cbsm380345ad.34.2026.05.05.15.28.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:28:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8acafc224a8so146739016d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020083; x=1778624883;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvTF9O3uwFA3OWdHwZuGL0USnnrisuTr7nTufwNcCJA=;
 b=NXhEH37b5zej7G1gE8/ynBZivPHLx8i3CvRaVPat1WAoctJwdbDUAUSOJ+Bg6mQgLJ
 AAKpcX+VZlg/HXAvvAbZEjeT2QdD5+8TBMVbLN3pwjddF252IRgLl14BDjaUc7Fs+F5E
 qy869O/lRRu9G9Qzzw49XG9EpyKzTJQuhOvgw=
X-Received: by 2002:a05:622a:5e0f:b0:509:3cd:b22f with SMTP id
 d75a77b69052e-51461e2c37fmr14585621cf.23.1778020082908; 
 Tue, 05 May 2026 15:28:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5e0f:b0:509:3cd:b22f with SMTP id
 d75a77b69052e-51461e2c37fmr14585111cf.23.1778020082236; 
 Tue, 05 May 2026 15:28:02 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:28:00 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 12/12] drm/vmwgfx: validate external BO copy bounds for both
 stride paths
Date: Tue,  5 May 2026 18:22:33 -0400
Message-ID: <20260505222728.519626-13-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_external_bo_copy() trusts caller-supplied offsets, strides, and
heights and operates on imported dma-buf vmaps:

  - The equal-stride memcpy() bound was clamped after subtracting the
    offsets from dst_size and src_size; an offset larger than the BO
    size wraps the unsigned subtraction to a huge value and the
    resulting memcpy() runs off the end of the vmap.  dst_stride *
    height is also a u32 multiplication that can overflow.
  - The non-equal-stride row-by-row path had no bound at all.  The
    loop touches bytes through offset + (height - 1) * stride +
    width_in_bytes, with only a WARN_ON(dst_stride < width_in_bytes),
    and could likewise step past the end of either mapping.

The offsets and strides are derived from STDU/SOU plane state, so a
configured CRTC submitting a crafted atomic commit on an imported
framebuffer can reach this path.

Validate the exact row-copy endpoint against each BO's size up front
using check_mul_overflow() and check_add_overflow().  Use the bulk
memcpy() path only when width_in_bytes covers the whole stride;
otherwise copy one row at a time so partial-row updates near the bottom
of a framebuffer remain valid.  Also reject zero strides and stride <
width_in_bytes, both of which the row-by-row path cannot represent
safely.

Fixes: 50f119925091 ("drm/vmwgfx: Fix prime with external buffers")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 39 ++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 135b75a3e013..56f965ec99dc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -30,6 +30,7 @@
 
 #include "vmwgfx_bo.h"
 #include <linux/highmem.h>
+#include <linux/overflow.h>
 
 /*
  * Template that implements find_first_diff() for a generic
@@ -463,19 +464,42 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
 		container_of(dst->tbo.bdev, struct vmw_private, bdev);
 	size_t dst_size = dst->tbo.resource->size;
 	size_t src_size = src->tbo.resource->size;
+	size_t dst_end, src_end;
 	struct iosys_map dst_map = {0};
 	struct iosys_map src_map = {0};
+	bool dst_mapped = false;
+	bool src_mapped = false;
 	int ret, i;
 	int x_in_bytes;
 	u8 *vsrc;
 	u8 *vdst;
 
+	if (!height || !width_in_bytes)
+		return 0;
+
+	if (!dst_stride || !src_stride)
+		return -EINVAL;
+	if (dst_stride < width_in_bytes || src_stride < width_in_bytes)
+		return -EINVAL;
+	if (check_mul_overflow((size_t)dst_stride, (size_t)height - 1, &dst_end) ||
+	    check_add_overflow(dst_end, (size_t)width_in_bytes, &dst_end) ||
+	    check_add_overflow((size_t)dst_offset, dst_end, &dst_end) ||
+	    dst_end > dst_size ||
+	    check_mul_overflow((size_t)src_stride, (size_t)height - 1, &src_end) ||
+	    check_add_overflow(src_end, (size_t)width_in_bytes, &src_end) ||
+	    check_add_overflow((size_t)src_offset, src_end, &src_end) ||
+	    src_end > src_size) {
+		drm_dbg_driver(&vmw->drm, "Out-of-bounds external BO copy\n");
+		return -EINVAL;
+	}
+
 	vsrc = map_external(src, &src_map);
 	if (!vsrc) {
 		drm_dbg_driver(&vmw->drm, "Wasn't able to map src\n");
 		ret = -ENOMEM;
 		goto out;
 	}
+	src_mapped = true;
 
 	vdst = map_external(dst, &dst_map);
 	if (!vdst) {
@@ -483,16 +507,13 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
 		ret = -ENOMEM;
 		goto out;
 	}
+	dst_mapped = true;
 
 	vsrc += src_offset;
 	vdst += dst_offset;
-	if (src_stride == dst_stride) {
-		dst_size -= dst_offset;
-		src_size -= src_offset;
-		memcpy(vdst, vsrc,
-		       min(dst_stride * height, min(dst_size, src_size)));
+	if (src_stride == dst_stride && width_in_bytes == dst_stride) {
+		memcpy(vdst, vsrc, dst_stride * (size_t)height);
 	} else {
-		WARN_ON(dst_stride < width_in_bytes);
 		for (i = 0; i < height; ++i) {
 			memcpy(vdst, vsrc, width_in_bytes);
 			vsrc += src_stride;
@@ -508,8 +529,10 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
 
 	ret = 0;
 out:
-	unmap_external(src, &src_map);
-	unmap_external(dst, &dst_map);
+	if (src_mapped)
+		unmap_external(src, &src_map);
+	if (dst_mapped)
+		unmap_external(dst, &dst_map);
 
 	return ret;
 }
-- 
2.51.0

