Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556F9CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 19:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9704E10E2B1;
	Fri, 22 May 2026 19:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="anBlbOXl";
	dkim-atps=neutral
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4BB10E2B1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 19:53:12 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so5085024a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779479592; x=1780084392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cglwdqxuZqGHEdfvk0BVheUOTQS1ea6XHoK7dbAWtPg=;
 b=eZd+NSTAptWaJveZHBTwzWadhQZYENAxVLJ5ZrHJHRRuMzVUubA09jADYwroIp/f75
 AruqwSpRsOMJkA9oIWMyRuJdsZCw6cJuruvrpzlYmH3YVCdR4l2xSdngq4Sm5ofVtrGe
 vNkHnQ5bHnSmHpC5oBUlO0x+gBYJv0pyBABETwFXpJ60xohrB/Q4xjoyvfllpPSZ5bI4
 zKJ+LWONfPmPPyLh0XZkEZX4nU+vzX6bOzsc1gWgFxLrhknUzKexyJUNPYUd0srskWKK
 Z9ve9y13ui/v1ElHNFTT5CCGV7LnYrN9h9DKw0ha1YrloTKu/eZQAKusLF3ChDRc72At
 lU2w==
X-Gm-Message-State: AOJu0YylQuRmQRuP/SruhXpp7lDHDMMdRMry+3SPp+96OtLXlCPmdfG/
 E07XK+qMcQPxx9GDr7l0miJS2vRwxDqYrkdra8Zpqea7Kksb0YUWXN9M+fUV+FpBdgOhLXD8F1C
 GXcZl6yuftasKtG6sSbLFsfiebKwboOwRYkjsAcY3qHUUcjeUN214TTBayhdOw5ovjkA6lqSNLT
 MAS40oQhbiXJr1At8OKT8gmjg/Je3pPC1edIev6BVD37IhutJDhkNWji45GRNCBZQX9WZy5/i4q
 nSKTzs6laaFpoVWQyCW
X-Gm-Gg: Acq92OEEMGe/lv3jvihundrzOL3DTKCSn3p7RYoc3EI1ucZ7ihxfd4a2B8/hGAtjTtY
 e+oX0p8nTY4TwMCOjC7LRfpWkwex43wSSwgKNMLoMGCBNMbmZLzRlZIT6JU5Es71e79QW8nv3I/
 VghdPfMXfcwOVYHOTG6hUivWSxxe23qp2mjHpI/a3/3EItSj45qyN33WvN8J1a7Ug2D3YKmvfMl
 AnnMllGpxcTg1OozmQsGZSqLPgZE3GonTe+16XCGlPweyPjnALRI+S52UaOkDbqwkR8ZTpvXT+h
 Dpw4MTHRIqludhhScO1PREkqtInGMMy5hmCy2GLe8wPOSqTYzl+G3Y8lFFCn8fOug22icgZwjBY
 94Ky1yn/QKRv6komBR8YrXU+ZXk3htOhGl62Ir/VwUwtdzC4A3lRtmNaaS1PTP3dXdffJiDNeKo
 tfnjZAmFdz25EG++uLTa61R46hND4RgKGu69J9YcQ7CpmplKZQJbzAwZ8tds60eGPGxrQ=
X-Received: by 2002:a17:90b:3906:b0:368:3d3e:efa6 with SMTP id
 98e67ed59e1d1-36a67835aa8mr4861241a91.20.1779479591850; 
 Fri, 22 May 2026 12:53:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c85202a2d60sm106177a12.3.2026.05.22.12.53.10
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 May 2026 12:53:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so4283940eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779479589; x=1780084389;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cglwdqxuZqGHEdfvk0BVheUOTQS1ea6XHoK7dbAWtPg=;
 b=anBlbOXlHqg8Iyb3c+8hr17YgaZd1e54uvc26CLoJvl45GLeeLf4CaNlCx6Stn5dvc
 K72ZpJhNaRE/uoVIIuJDXH0LcyZ1oHIBU6sIM4kke2zLCbfTSH48HWW09xZ/BDzPeTKo
 ZWbkTQy8ZyHoWPQjTBVJhb0Fjp7wu1VuUwWRQ=
X-Received: by 2002:a05:7301:4181:b0:2f4:3a9c:8193 with SMTP id
 5a478bee46e88-3044913e776mr2751314eec.16.1779479588958; 
 Fri, 22 May 2026 12:53:08 -0700 (PDT)
X-Received: by 2002:a05:7301:4181:b0:2f4:3a9c:8193 with SMTP id
 5a478bee46e88-3044913e776mr2751294eec.16.1779479588209; 
 Fri, 22 May 2026 12:53:08 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245fbeesm1737127eec.30.2026.05.22.12.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:53:07 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Check whether CRTC is active when updating planes
Date: Fri, 22 May 2026 14:53:03 -0500
Message-ID: <20260522195303.797091-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.54.0
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

The IGT test kms_universal_plane triggers the error condition in this
branch because the screen target is not defined.

Also access the STDU via the plane since it's guaranteed to be non-null.

Fixes: e05162c017e2 ("drm: Store new plane state in a variable for atomic_update and disable")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 5ad7e942ceb8..9deeee9b92da 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -44,6 +44,8 @@
 	container_of(x, struct vmw_screen_target_display_unit, base.encoder)
 #define vmw_connector_to_stdu(x) \
 	container_of(x, struct vmw_screen_target_display_unit, base.connector)
+#define vmw_primary_to_stdu(x) \
+	container_of(x, struct vmw_screen_target_display_unit, base.primary)
 
 /*
  * Some renderers such as llvmpipe will align the width and height of their
@@ -1418,7 +1420,8 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 	int ret;
 
 	/* If case of device error, maintain consistent atomic state */
-	if (crtc && new_state->fb) {
+	if (crtc && new_state->fb &&
+	    drm_atomic_get_new_crtc_state(state, crtc)->active) {
 		struct vmw_framebuffer *vfb =
 			vmw_framebuffer_to_vfb(new_state->fb);
 		stdu = vmw_crtc_to_stdu(crtc);
@@ -1442,9 +1445,8 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
 		if (ret)
 			DRM_ERROR("Failed to update STDU.\n");
 	} else {
-		crtc = old_state->crtc;
-		stdu = vmw_crtc_to_stdu(crtc);
-		dev_priv = vmw_priv(crtc->dev);
+		stdu = vmw_primary_to_stdu(plane);
+		dev_priv = vmw_priv(plane->dev);
 
 		/* Blank STDU when fb and crtc are NULL */
 		if (!stdu->defined)
-- 
2.54.0

