Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74971C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA1D10F415;
	Thu, 10 Sep 2026 10:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="clwiiZnL";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F6910E23E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:45:09 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4ae61629fso397784a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 22:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789019109; x=1789623909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qrTsAq+tUgNIgmUZvhsJQsIdVBmbJT7W1rd7UeUsP5k=;
 b=clwiiZnLWl3pIZPVxrxUgyE56JyTSeJGvtm82EV61RaZXjkyLs2DPt9KgkktPUduNE
 3f4H18CvPsKEcjOSdXHul9PS5ZWZaEzH+WFzUm2nDMMvxECF7JivhwZ94QjnFkk19kqt
 Kj6oQHMlFijeK29CcTeq297fcEyRcAz3W+MuDi4r2Em3DgabAcvMWrZvP/H4LpxCE+vf
 HYn9Uxxacp+XIDg8F9VzhWgky9uTN4OeuqNIaxFp+HeU9/8vPwVgyPWNIERrrJ2IQ/Ik
 wzh79f5u+F9+ncPsG+dINkhw2Te0k9Kb5I0FIl8XXc5R0uaHWp8uOrss+qg6TqEyDBBw
 YqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789019109; x=1789623909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qrTsAq+tUgNIgmUZvhsJQsIdVBmbJT7W1rd7UeUsP5k=;
 b=GKmVMIZwvN8LoTkXHOH8pgYXEr2RWkRgzCfNjYt0SWnXn9VLSDQ6lAnIgDp867VCkG
 3SfD/xaZvilMxJi0lU/IK0naVUvmhMhPGmatFw397CQAsAaSQZAI8wAtNulMc3xIHWOz
 s/UtgEie5jo60RzhL3/YD+C2aY3e6iKbPdwOqrEzuxkjQs2NJSt7eejyRdlMfOwZBHDy
 3E08fpLd9Fcsa1gftIy/DcdIKzv7IqQwtsnzWFccTvL3RpUT6TEQDeC81gK/kgyKR8uw
 u/zvyYZetgLIfQ2Nm+yvn8fIzjFXYVDmxocHnaiawNnwBtHW9bRqRnvWgCzHTDEU8bMO
 337g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0jbQq3J87IgvxMHSxydIgucn/aWjroQAU18AZxjXDm8Hpx8lV4nhZqW8NUDMOkY3k37QoNPuQjaw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++loZABWKxYSkb5Giuc4A0QaQOmJ9bfTP7Z2KwnlCE8+KCwgdjvT
 X7tvj1RiDFuFxtT0uMBv7bDkFy+dR4NohMZ2uz5dDbAOFPjVCz6AVu7+
X-Gm-Gg: AYBFou0HxyIhalaRYE4I+GX6t/fHgEBV2owsnd97Dh8SWMAVNkwd5GngvKHgGDWUslS
 AJn8cZ1RFIBwBbjnkhN0u8n5BqNti6GpvOR/+eX/5XFTj8kDrgS3ZcGCluiST2uHWgMRpahJaXz
 0ddOKxBOm6jJ7K9s+2bqoBaGPR93eANQrNBwIz20Eoygn+WO0NrBJe2/KYNhYY9X8ILySTtBZVS
 FrcZArvZLmgNlPedREiyxpiyJFdap/ORrwWgR5EZudMXW0EVdVe2ZJi2AFc3ToDdMLKSGdmUczE
 rmqpzL74oZnom01/itUV5+dpROcYcXKs5HELwYr2oT8T4/p8HmUbJ6FBjQpjNsz0j+CpVidk6WR
 EM3NhhWDNlcgN2129iO0sTYSpazE12cug4DtLVhsVgjM1lsSZUC87YEJ1eO24NnT4s6tXET/786
 HHWAzIz7mFfeUVQeLQDRWaVoS1YDdbqXMDgnOtTZeXjGc9R29xGQn6xRzRYtRuRg==
X-Received: by 2002:a17:90b:384e:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39d707b291amr6953379a91.0.1789019109032; 
 Wed, 09 Sep 2026 22:45:09 -0700 (PDT)
Received: from fox.. ([43.242.224.196]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14344a86512sm22102561c88.10.2026.09.09.22.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:45:08 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: linusw@kernel.org,
	dri-devel@lists.freedesktop.org
Cc: leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, pimyn@google.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/pl111: drop alpha formats the hardware cannot scan out
Date: Thu, 10 Sep 2026 11:15:03 +0530
Message-ID: <20260910054503.4155812-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825105427.686619-1-roshaen09@gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

The PL110/PL111 controller scans out a single framebuffer and never
blends its alpha channel with anything. In the pixel-format tables every
alpha-carrying entry (ARGB/ABGR in 8888, 1555 and 4444) maps to exactly
the same register configuration as its XRGB/XBGR counterpart, so the
alpha byte was never used by the hardware.

Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
with alpha exposed") added validation that warns when a plane exposes
alpha formats without a pixel blend mode property, and PL111 does exactly
that. With panic_on_warn enabled the warning prevents the syzkaller
vexpress-a15 manager from booting.

Drivers should not report formats they do not support, so remove the
alpha formats from the PL110, PL111 and Nomadik PL110 variant tables and
the now dead case labels in the display setup, instead of advertising a
blend mode property. Behavior is unchanged for userspace that picks an
XRGB/XBGR/RGB format; alpha-picking clients fall back to the identical
X variant.

Link: https://github.com/google/syzkaller/issues/7805
Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
Changes in v2: drop the alpha formats entirely instead of advertising a
DRM_MODE_BLEND_PIXEL_NONE property, per review feedback from Thomas
Zimmermann. Leandro's Reviewed-by from v1 is not carried as the
approach changed.

---
 drivers/gpu/drm/pl111/pl111_display.c |  6 ------
 drivers/gpu/drm/pl111/pl111_drv.c     | 16 ----------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 5d10bc5fdf1f..e1b513d36c27 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -267,14 +267,12 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_ST_LCDBPP24_PACKED;
 		break;
-	case DRM_FORMAT_ABGR8888:
 	case DRM_FORMAT_XBGR8888:
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_LCDBPP24 | CNTL_BGR;
 		else
 			cntl |= CNTL_LCDBPP24;
 		break;
-	case DRM_FORMAT_ARGB8888:
 	case DRM_FORMAT_XRGB8888:
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_LCDBPP24;
@@ -297,13 +295,11 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		else
 			cntl |= CNTL_LCDBPP16_565 | CNTL_BGR;
 		break;
-	case DRM_FORMAT_ABGR1555:
 	case DRM_FORMAT_XBGR1555:
 		cntl |= CNTL_LCDBPP16;
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_ST_1XBPP_5551 | CNTL_BGR;
 		break;
-	case DRM_FORMAT_ARGB1555:
 	case DRM_FORMAT_XRGB1555:
 		cntl |= CNTL_LCDBPP16;
 		if (priv->variant->st_bitmux_control)
@@ -311,13 +307,11 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		else
 			cntl |= CNTL_BGR;
 		break;
-	case DRM_FORMAT_ABGR4444:
 	case DRM_FORMAT_XBGR4444:
 		cntl |= CNTL_LCDBPP16_444;
 		if (priv->variant->st_bitmux_control)
 			cntl |= CNTL_ST_1XBPP_444 | CNTL_BGR;
 		break;
-	case DRM_FORMAT_ARGB4444:
 	case DRM_FORMAT_XRGB4444:
 		cntl |= CNTL_LCDBPP16_444;
 		if (priv->variant->st_bitmux_control)
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ac7b1d12a0f5..2175ac953795 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -341,13 +341,9 @@ static void pl111_amba_shutdown(struct amba_device *amba_dev)
  * This early variant lacks the 565 and 444 pixel formats.
  */
 static const u32 pl110_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
 };
 
@@ -361,19 +357,13 @@ static const struct pl111_variant_data pl110_variant = {
 
 /* RealView, Versatile Express etc use this modern variant */
 static const u32 pl111_pixel_formats[] = {
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_ABGR4444,
 	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB4444,
 };
 
@@ -387,19 +377,13 @@ static const struct pl111_variant_data pl111_variant = {
 static const u32 pl110_nomadik_pixel_formats[] = {
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_BGR888,
-	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_XBGR1555,
-	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_ABGR4444,
 	DRM_FORMAT_XBGR4444,
-	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB4444,
 };
 
-- 
2.43.0

