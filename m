Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB78CDE002
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E2D10EDD4;
	Wed, 24 Jun 2026 07:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CHHAnC94";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E979610ECB4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:51:58 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4633193af19so251093f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782247917; x=1782852717; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9SC1AtVhjOjxzS1y9gPK3P2jYP/byS52mid5bQ4SEQA=;
 b=CHHAnC94hxuLK1FKgbAyCgUwm40qNlIcqeODFbVTB5f08RIjxYhqyxEAR04DM6wvHs
 QHzD3HGBDb4d422+ItuCvNbMdnzzDIFPZDrTCaEn5TOBYvXaf36ltinjcySw2ClLLplH
 XRLygueW6Gq8qsZTqPPN1MIfea0YmDDC/x5Lj+Yy57ZPlmo6M5bJUmvJXH6zdEpcoYiv
 HVQ5lotylqBsfxBKdzEiR0/kgKWBrnzxsfUUTFXlptOvbHAqUqORSdJ5Gs7BjOeS+vOD
 r87eMC/rOxQMNtT/b7/df7g+uw/gT7o9P3X+IN+ojqiLhJYRVA8xiX72Cxrhx0pqx8xn
 9W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782247917; x=1782852717;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SC1AtVhjOjxzS1y9gPK3P2jYP/byS52mid5bQ4SEQA=;
 b=MkT1H/DOt4XiwG2Yho3nVfD1KkDaZmxQqsSx5lNg3V1ffn1xVwUoa4EHqBObTbNzee
 cr3UNGVkefuQhmoRIsnsOTSdik/GQ3t6pg8wco87/1ncxKmcO/3m4cssgTOZeIdbW9mu
 ygAgVt9vpcwPp+E1oCfYTjjyHuxA5DaQ3DaANGBhGxZrUynYHXgVcHL1gX8QxXV9aq7F
 N9l8yNm8AId9HF1r3gWC5KKq5LyuA7EEtIuZ8zs3hhHFKHCGaH8gNniJ6UXAPLbqBjsa
 wW8Y1pTt1dc10B42ycTZUQzPRgoXJjPgVm+ICd0j0spb+bLNdouOqj86fVzk/zKUwBjK
 2RIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9ldrN0PhbfiLdb7oi488XZct4Re55SnUc15A4Xbx1dl237gSLhivkLC6N2+sNY2R/ifB0njXhs9U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCOHPFr2DAvsT8c5T7lraKsVN8Ar7gz+K5eNXOXH0tbNimc1Pk
 X7HwkXL6WgPgpG0BFc0VVaqkQ7BvhT5hugIUEdxscUFMmEyGAAwQiHW4hJ1kXU+6
X-Gm-Gg: AfdE7cn74Zt1DPXYl2wEvettGlhQqOA2Y/AsH72U2v7IXyNVV7EG2tdqwZiSZHvpdgL
 B1g2ndC22HFZdMHlcPL5Hp+iG8mFyD9E8S9y9AxbgpV4YWIuFX6lflY8v7iC5JEji06t/hc4gCJ
 d2ZWyNC1xKWnSK2No5DMdAn2su2g2rnJijc7brgSXmDU7INWo/7+W4wBEWR3Tup9nk5eTdtPhU9
 KOH9HHwfg5h0FaFbVSuaS2fn0Gz86PzZgSWPhFz665GFq03xAsXBbyhdcxV40XsQsDnP6QtpeUo
 OlfadhbWExTlt8n3YcSAiy1sc7vr5wUo+BD3cdrG1pGyYll2LhW5yVngDRJ8ReCguik5XjiOPkO
 C7GU/LPONPKSbQEWAoqfbVuYgDU4RAAs77FTSSpU97A++19ICWyEnd43Q7L2x2uXKgylFDngwb0
 qQLYfdz1e36C9sxNO7uxX0
X-Received: by 2002:a05:600c:500d:b0:492:37b7:6080 with SMTP id
 5b1f17b1804b1-49249083ccamr249984305e9.7.1782247917299; 
 Tue, 23 Jun 2026 13:51:57 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494497ffsm332579255e9.11.2026.06.23.13.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 13:51:56 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 23 Jun 2026 22:51:44 +0200
Subject: [PATCH] drm/amdgpu_vkms: vkms: Remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-amd_simple-v1-1-874f9df6bcf1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN/xOmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNj3cTclPjizNyCnFRdQ7NEQ3PLNFPDNBNjJaCGgqLUtMwKsGHRsbW
 1ADuLw4JcAAAA
X-Change-ID: 20260623-amd_simple-16a179f51f43
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the dependency on drm simple helpers from the
amdgpu_vkms DRM driver.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 170adaf7e76a..14382d218747 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
@@ -316,6 +316,10 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 	return plane;
 }
 
+static const struct drm_encoder_funcs amdgpu_vkms_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 				   amdgpu_vkms_output *output, int index)
 {
@@ -342,7 +346,8 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 
 	drm_connector_helper_add(connector, &amdgpu_vkms_conn_helper_funcs);
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, encoder, &amdgpu_vkms_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
 		goto err_encoder;

---
base-commit: e2a6e04d045a56c6dc61e1eb9e2a6d7cf86512cd
change-id: 20260623-amd_simple-16a179f51f43

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

