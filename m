Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F30CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 20:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4019210E90D;
	Mon, 18 May 2026 20:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emHHVSap";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC1C10E90D
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 20:08:45 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso860962a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779134925; x=1779739725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jQ2H6hzbGV+Gx71jCeVXJ0vSIO9SegN96EsFQ4KlCfc=;
 b=emHHVSappSu92+qApchiQhqdZNMXKWOeREXnn0fZWVRXlkzj4N5E8gQCMx4Okk2Ktv
 +coO/vajsFKxLfv1TxYJMhIMESpJWm6WvGNCj2d5Bkb9qMt3BR2HgddEVKS9bP/ZR31Y
 Gv2jzjmHqhufvPz0UFKHiZ5nGtfhwgc3JHuzu3WI0m3R7YZ2CX5ZJ1THN2N4tL+Y+9am
 5msswvrnq4i14omT6PGEbesMhecCOm/Oe2N05HTULyFE4GCPN6YlkRqetFbsSxSZSTOw
 zWt2URf8mBHBugnfFKdvu2S+pN8pFONYgfrwyTs02YayH208625cgbwmx91ge10CmVfr
 X8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779134925; x=1779739725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQ2H6hzbGV+Gx71jCeVXJ0vSIO9SegN96EsFQ4KlCfc=;
 b=Xu7UHGHsiSC3xD2SVAr2jzhYQU7tzk9mLDydN1z6/ZCj1usBEUTcb1g/jHqpgpCz5f
 cg0tY2u0vYm4GQEiWskXm5CO09WxdsRCaMyOTBOJ//o5J7kjwc02k7BJz7198LLCpQId
 D2wRk8odv9kRtF2s814NSOaAURpmMna2k/KBkWhOOn3oGEz7abA7Skb6c2ScsNko6Fwp
 z5B0ImWIuPU3B4PDECiTRfV2SQR+LDdYUU3hYX5zoR3D2BoLvqF2vyFVIIeLHfYL+w9R
 AOKxkcLEdJYDqpMYSjODhqqkvH3abaTEWXk+fHILesNWPTL7RJNK/VIAyn8D3OYh07tA
 ieFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9r2GAQoGeHgL6dR/1KKExL+58Eo2T2sOWDoWco6usOoqDOaMHYPINrJkzM2YHYAwnJ3oDAWYIIYcw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJZAv0y7QkGXPDl8zZP2bM9F9McUP0PlpT2v9FXjFSn6+low9z
 DKFhDCvUcVar7W3XueU+3jKP/N65Sl4CvPrQS8PYOgB8N8qlo/xAncMc
X-Gm-Gg: Acq92OELAXsZMAoY3eUD/ju8UqCiS43zoeNcT4jYQ0o8jxTKRTHQRniyF+OgoTEuKHA
 dobc01jhRHla3GCXSlSt0fqIiOTmZE+aKSiN1EMG/IivVIos/2fhiGmJ2uL//jAW27US4Zf3wtw
 plElIgfcTuDVA3cozeOT0rZ3cEVEm7oS5QdKEVtzU/TU4/D8ryDBF0CmI8E9l/wCFm7CgidUwVe
 ONEyhe3FBQCQfbIlK3rL4UP1OFni0uoqVUH/OZxNesoKNQJz7mQdShGZQe8lERFRlEZYn/7DvZ1
 a0+Ff8DjXOhwJRc8B8iDqVcUnLm7Id3zls+eIef4ju7+LN0u9gdqRXtbb6omL1vVT0uY/Mu2Fqt
 cWmObBGxuySjN0OnElWg2OvgW+KH0qQn9O527uKsfKYVlEx3EeS8+d0ajHT/TOSY5rq+S9VrZDh
 NwoVMEmZa7G3oW/dVuLQnZbmgN8EXgJs+OX2Y8vzvff+21ma99B4lQEtdhrF5E2w==
X-Received: by 2002:a05:6a00:2ea8:b0:83e:e03a:f926 with SMTP id
 d2e1a72fcca58-83f33bcae20mr16232493b3a.9.1779134924958; 
 Mon, 18 May 2026 13:08:44 -0700 (PDT)
Received: from souradipto-das-Latitude-3460..
 ([2405:201:8011:1c:1b3:ef9c:231:cc8e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19661261sm19608369b3a.3.2026.05.18.13.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 13:08:44 -0700 (PDT)
From: Souradipto Das <souradiptodas6@gmail.com>
To: stefan@agner.ch,
	alison.wang@nxp.com,
	simona@ffwll.ch
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Souradipto Das <souradiptodas6@gmail.com>
Subject: [PATCH] drm/fsl-dcu: Remove redundant unregister call in connector
 destroy
Date: Tue, 19 May 2026 01:37:55 +0530
Message-ID: <20260518200755.5389-1-souradiptodas6@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Remove the explicit call to drm_connector_unregister() inside the
fsl_dcu_drm_connector_destroy() callback.

During driver unload, the DRM core automatically unregisters all
connectors via drm_dev_unregister() -> drm_modeset_unregister_all().
Later, when the connector reference count drops to zero during
drm_mode_config_cleanup(), the core calls drm_connector_free(),
which invokes the driver's .destroy callback.

Calling drm_connector_unregister() inside the destructor is
redundant as the userspace sysfs interfaces have already been
cleaned up.

Signed-off-by: Souradipto Das <souradiptodas6@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 84eff7519e32..0d077e507a2d 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -41,7 +41,6 @@ int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 
 static void fsl_dcu_drm_connector_destroy(struct drm_connector *connector)
 {
-	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
 
-- 
2.43.0

