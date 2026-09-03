Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD13C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7EC10E09C;
	Thu,  3 Sep 2026 06:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bjMcCSfR";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CAC10E09C
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:07:03 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso449122a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 23:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788415623; x=1789020423;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hsYexK4Zcb6IZWWhLn93nyGnMkgrjoHZYmyElgh5yQc=;
 b=bjMcCSfRmYsEX2Dl+Phv5zuHHb9lwh5tU9IrxKpY4Hynh31CGvuWCDy+yX69haWdjQ
 lpoR0/vuT/uMfcayGV2qtj+f09+KEADipEf6Gmu5J6kX6uOrEyFIP7Ja8p6r8pM55576
 Ir/H9WX8ydLCA/8TtpkjE/qcpoMZmPFvViyS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788415623; x=1789020423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hsYexK4Zcb6IZWWhLn93nyGnMkgrjoHZYmyElgh5yQc=;
 b=jTQ1ir5DdJH223uiekrxvOI1TD7c8UQnk7yM3DXt8RrrF3RALSYN3dOKPMSmBBHKwG
 +RSxlTR+Kfh7HLNhgYY35OvIbBEhui0C5YQlbgbX98KauBPCvIyXRzbIBtBUAl/wi5h8
 vPk5YnZBCg0cayWQp4InSGrM2rqE/AAU7wiQHMhXL/W34puIIJYNJXPvS46xgJ2Jv0Jh
 sBHz47Acd9dCPmM5i5BXh/CUfEr4NED0gSMXSooFcnfrIR0e4OIf/XS6ccJrGSpqZ9j5
 uZ43RfAJO5SMUV3bAL9h0rX91dsHE0UAjX639fYgOGxLVy1UMDPSE30KBpAwl8+sZODe
 mF3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGxg2sdPdUTFX/2vyatlS9t6zlTEA0h9YBbJH+DUncjr/m9fM4pBckTo0YOiF96l+68xri8HzsyK8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nzZ5rhlO7rEFT4nyHiInPGUWNkIeQ2xVBcSV0ExOv3uTM0T2Qi
 mbQ+qu/lSqbDPg8o+55JRNUO+CNVu5WgQYQdUbUhJOkodd/ilia4jKYY7SCJq11g2g==
X-Gm-Gg: AYBFou0972bz47JYCOqAhSO1N9r/3IFrj112y2Wg+pvuAzOixile4HhVIf9QI8DJlYu
 vn0CmATTgOEQr8lBm1X42qwrWc5oCn65wTFeEBpJhsfT7vUVwK2NQo3kCBNubbcqdkHs/4aCb54
 HD7yCMGbCWVaWk/ek7Bv3ixliCd19YHR3S5h3Du4DdzfggCxFFo5KWfqIXrOvctbJr5q9WP3dAq
 73f/0KBNXJpI/nS1ENjco0g0J/m+5O4yMFmcYJSzqD4e09u5GnIYPciSxZd7Ss5wy6rIrX8IuRU
 6iPqWfPyerUgSbFafSHSfqg4Bd4vuJbDpmmF3PXijsvl3eHbMjl4Sz4xyugdKIluI1oThxPSv2r
 d5FFmefyu1YJMFM679rjbQMC1iPro/11CXfh2IMt2w+pzNp1QqtCCrWsM/u+UVgMTceiU3Z+We2
 bNjP40xK3Rws01BYopNlSC2X+VAyksWoedIGeZ0XMHLU7mORWXUWgmaz+uhcbJk8IpAm/bPiiom
 2iO5KV9G5AtRqDctM5gBd5A7/5SLnkcoYH7NVmXiMJ5ig==
X-Received: by 2002:a17:90b:4c0f:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-39b1325b61fmr1312168a91.9.1788415621767; 
 Wed, 02 Sep 2026 23:07:01 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:59de:d2d:e1ec:bf86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae8cfb279sm2579007a91.3.2026.09.02.23.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 23:07:00 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/sysfb: Use iosys_map_memset() to clear buffer
Date: Thu,  3 Sep 2026 14:06:49 +0800
Message-ID: <20260903060651.3724163-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
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

The atomic disable in drm/sysfb currently clears the buffer using
memset_io(). Since the mapping is provided in a |struct iosys_map|,
it is better to use the related API instead of extracting the vaddr.
This is mentioned as a TODO item.

Switch to iosys_map_memset(), which takes the mapping as well as an
offset into the mapping.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index d2de29caf89e..99b13af4e391 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -375,13 +375,11 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 {
 	struct drm_device *dev = plane->dev;
 	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
-	struct iosys_map dst = sysfb->fb_addr;
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
 	unsigned int dst_pitch = sysfb->fb_pitch;
 	const struct drm_format_info *dst_format = sysfb->fb_format;
 	struct drm_rect dst_clip;
-	unsigned long lines, linepixels, i;
+	unsigned long lines, linepixels, i, offset;
 	int idx;
 
 	drm_rect_init(&dst_clip,
@@ -395,11 +393,10 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 		return;
 
 	/* Clear buffer to black if disabled */
-	dst_vmap += drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip);
-	for (i = 0; i < lines; ++i) {
-		memset_io(dst_vmap, 0, linepixels * dst_format->cpp[0]);
-		dst_vmap += dst_pitch;
-	}
+	offset = drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip);
+	for (i = 0; i < lines; ++i)
+		iosys_map_memset(&sysfb->fb_addr, offset + dst_pitch * i, 0,
+				 linepixels * dst_format->cpp[0]);
 
 	drm_dev_exit(idx);
 }
-- 
2.55.0.970.g62bdec98f9-goog

