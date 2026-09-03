Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B791BC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BB810E0CB;
	Thu,  3 Sep 2026 08:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rwa1IGOE";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784B110E0CB
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:48:34 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso725805b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788425314; x=1789030114;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wrwqC3E9eTCws50iPOcrmjIJMJUeiFoxoafRRBaubdE=;
 b=Rwa1IGOEgaUD+94p2x7D1yIR1ShoUP2F3xTu6l9w8HosMSdSy+dyrkutjjqxHs/lKQ
 H+jjZimI1pRLsDC9v0w3LRFOVthqO/l515cjineDRYixBp/VPfi9bRyZrhtFrTlpulLQ
 hWgwngO5kdCQnPQBM+xt+WZQnVQ8fJo6fQHjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788425314; x=1789030114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wrwqC3E9eTCws50iPOcrmjIJMJUeiFoxoafRRBaubdE=;
 b=JU/BAb62iB9I3dP4u6IZxOlndBwjzsiNbcVSR/TO6UM5CIS3vwvucK1EuvWgX6SYTl
 GxhTMkgjaXk14r5OrHwEZFEVcGpSnU2FVbiyw/GWpTJXoyLAeCr/gJiK1e6NqLeJSw7v
 K/0Bm6Anij9sbc5YdCEdLhohI5dgjI2HrDv0AKLon/4Sn42i7/luHVIT/MBU4i8V0pqp
 xAyRVH5pDDHTD3IRikDQEe8I4Il/XQ8tIFTKTVmDjDVEPWuRbww67pHxS2H9tayHu6k3
 Cq/ecnHIDuJXYmZbw3XiC76//pjrFeFumU5KiB0o2WNdeAK9rDqpzZyCHaCpfGgGzn9Z
 hx8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByRef9yhih+MJURntUmPwEOfQmMyqSoXbnm4hFdZ4E7DeBsbrh4NqXFcHsaMX7Obqe6OMadr2O7VMc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mc3MfdVcPvYjzFFdKP8GWk1yQrk89bBEKn1D9ipRy+YQLnawC/
 WsGh+SO01WWsjcDbQgH7yR71k8CBnkCzvEVvPfO+MB1wnUDqHfIJv/jvx0ERRv6/GA==
X-Gm-Gg: AYBFou36EFJqSEKC5nB1zGutsx1icQ/KxnK5YjyWPldzd3+L1Gbibsp5xxVQVrBPPc0
 QB78ZZLZjUpP3RGBZuRU1x+w95UZeK2Fkm3BWEGnA12XQ6yvdIpmp/0+HFFXdYd5EPYnPkJYw25
 g/FeVtZLg8J5PjBXCFIKRY6m43eBDCqvLpw+Xs+V43UUmgWI6/95x7q01NJW0mpzlu8zeWtCBlg
 HUJNmZB1NkRqCtKfhX1Q2atSGHf2klorJ6c3vAJOjiybaWy/PebNBTJhaAAQk/GxI+NGh2cwsMh
 D8tbfvkh2SNuAgq+o/zRw4WFXQEmjgdV5/k2wiU0Ht8mLKsDfH/u8RA+1Ovi/WbN93VxnDcuaoZ
 9uF9S5XT99R6XYJAZeB/Oaw86RoNUkfWY7lNGAaF0lsOpQgHOqWg0b4fvJ9qaIFhn/kKaj6xQRI
 HIlvkhRVyaZl9uH7psibbBLhwcIXR/yKG5+UKN9kFVnxb+s5nvCIWqSaTgcDy8Db0P7m1bf68dz
 xRcFycu7ZEiFahvNwRX+x1L1j9UdDSwyiPeqGZM/mXMIvLwXG5pClvytQ==
X-Received: by 2002:a05:6a00:3d55:b0:847:852f:c28a with SMTP id
 d2e1a72fcca58-860662990c6mr2199573b3a.5.1788425313880; 
 Thu, 03 Sep 2026 01:48:33 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:59de:d2d:e1ec:bf86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db24f20besm2671477b3a.7.2026.09.03.01.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 01:48:33 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/sysfb: Use iosys_map_memset() to clear buffer
Date: Thu,  3 Sep 2026 16:48:22 +0800
Message-ID: <20260903084823.4156065-1-wenst@chromium.org>
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
Changes since v1:
- Rebased onto drm-misc-next
- second patch is gone as it was already implemented
---
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index b92cc4b7d2ad..13df0925163a 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -375,8 +375,6 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 {
 	struct drm_device *dev = plane->dev;
 	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
-	struct iosys_map dst = sysfb->fb_addr;
-	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
 	unsigned int dst_pitch = sysfb->fb_pitch;
 	const struct drm_format_info *dst_format = sysfb->fb_format;
 	struct drm_rect dst_clip;
@@ -396,10 +394,8 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 		return;
 
 	/* Clear buffer to black if disabled */
-	for (i = 0; i < lines; ++i) {
-		memset_io(dst_vmap, 0, dst_size);
-		dst_vmap += dst_pitch;
-	}
+	for (i = 0; i < lines; ++i)
+		iosys_map_memset(&sysfb->fb_addr, dst_pitch * i, 0, dst_size);
 
 	drm_dev_exit(idx);
 }
-- 
2.55.0.970.g62bdec98f9-goog

