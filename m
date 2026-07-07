Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62579C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED3E10EE3E;
	Tue,  7 Jul 2026 15:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IdfU7cGD";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3982210EE3D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:50:14 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493c59f740cso31386635e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783439413; x=1784044213; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JmJOXk4TIuGnk+IJA07RQlg228Mfy9xUbBSKbXjT52U=;
 b=IdfU7cGD2y2zEjB0pAgrCXGUPJM1B4nxqXBT7x2hkkYa5MYwrjh61cfoMxxm4XLqMw
 PnyeNfoTk1BowY9qXsxi89pS7uU/2yTJ0UfHRPh/Z7V/pYEmuzNNl1GAniacUGTJi0nA
 TwcZJwTySc+DaUMzafixkU13I/MJUk88ZF8pZpl9p9emI85R6+DrSCHcb3MFZZn8ngm3
 g87Wa3yFwdzJTw+bL87Gd/a3T9f4L9gg5auRep+E58fjdyswphzItYtmHRmBQImWQ+On
 OrnVvrxExtoX3LRQGyZe8IRU1Rd5Gghbl2ay80Wtol9BjrhMBlURq7mghrMA1vSfHnQx
 ZH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783439413; x=1784044213;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmJOXk4TIuGnk+IJA07RQlg228Mfy9xUbBSKbXjT52U=;
 b=RoGsrGydaWHPnNCHc0u9hk5p/REzIskc+5zn49XLaj0LERKhI3n3b5gBA0spQLeoKC
 Anoq4y28KXYEGQteJmH/hMC3knnoVq1gcqQQarIHmvmuvxO7IGVJTI8NmOFZjF3UAUpk
 9Hqi9QJcS5W7nRrmpjaSdkQ9cNfic4DOzz0q68kG89LHYZeejUSsOAE/PPRayAjg/NnV
 SJJKg/x6QtIp7xpKlJso/xYutPAV8gB5mIYTurOYbNvvtPV1+1LTxZDwCZeDReSkoYmT
 PBJMQzm6JLXBB1ZTGi7SgImwfyWmV92/5zh26lxasEtu/mE14qov9DUmqSiNN0JIuI6d
 Eprw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJLDz89FgnVmC4rFebi/0IZCu3R+b5qozkkrnxqEd8EGF/iYg9yYyawyECyTxS8j28XlE2LxWMymI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfBm9N0FhF0FK+MU2/0/OR4nRqDJKVPYOERK/Ez236jNoXgSNc
 Zmu76RnI4f5YHq/stIbw7u2bQ9qZWhTw5Hacy2Bbf6z+Qn6Wxdq37YSh
X-Gm-Gg: AfdE7cmNeucSlCp0DpVi7Mcdc+i8pCQYEaj8/I3RpyDP8TGww3T09iPDaPg4agv/ZIa
 3fuYT4yToxOQ6sKzItZTB6nDVZlSZmKTneWk6iGZ36DrfhA51CAVbMIoA4cgCy5AJ3/xtULVtu/
 xlzQwEwcnfNwAcoD3w51NSspqFOxK+1LHwwu+uzoQINRm8vVgj9aTHCaqyYhHjeP0ISV7WQE4ht
 7ov6AHJvwgySQkLnV7+pUhddhQXxhUTKNUtv7FmVQXjb0mN90+qLRJFoM8BPG2I96RGCADT5Mgi
 G33lRs88MQl+zX3oku0mreeVG5E2X1GQLGK+16GYmmMlcRO79dI0kqierP9Y1Cpn0w6d9NJ3SqY
 n4ISioK+oMiVOe5Bf5cLjZmTLA4ydsht5uKiT86fVAeB8n5hJfeHDr98UaTXBmrRY2glkdRZ0lx
 +oGZItYZUNUHI3mHgV7Ism
X-Received: by 2002:a05:600c:3f16:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-493df08b92fmr66562655e9.15.1783439412445; 
 Tue, 07 Jul 2026 08:50:12 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0ec6e64sm111676995e9.0.2026.07.07.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:50:12 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 07 Jul 2026 17:49:48 +0200
Subject: [PATCH] drm/qxl: remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qxl-simple-v1-1-524f6316b5d5@gmail.com>
X-B4-Tracking: v=1; b=H4sIABsgTWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNz3cKKHN3izNyCnFTdZAPDxETDRNNkk9QkJaCGgqLUtMwKsGHRsbW
 1ABN0/x9cAAAA
X-Change-ID: 20260707-qxl-simple-c01aa1a5c4eb
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
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
This patch removes the drm_simple_encoder_init() helper usage in the
qxl display driver by open coding it and using the encoder atomic
helpers directly. This is a step to eventually get rid of this simple
KMS helper, once all drivers that use it have been converted.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index a026bd35ef485..236d027fbc9fe 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -31,12 +31,12 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
@@ -1095,6 +1095,10 @@ static const struct drm_connector_helper_funcs qxl_connector_helper_funcs = {
 	.best_encoder = qxl_best_encoder,
 };
 
+static const struct drm_connector_funcs qxl_connector_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static enum drm_connector_status qxl_conn_detect(
 			struct drm_connector *connector,
 			bool force)
@@ -1169,10 +1173,10 @@ static int qdev_output_init(struct drm_device *dev, int num_output)
 	drm_connector_init(dev, &qxl_output->base,
 			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
 
-	ret = drm_simple_encoder_init(dev, &qxl_output->enc,
-				      DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, &qxl_output->enc, &qxl_connector_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
-		drm_err(dev, "drm_simple_encoder_init() failed, error %d\n",
+		drm_err(dev, "drm_encoder_init() failed, error %d\n",
 			ret);
 		goto err_drm_connector_cleanup;
 	}

---
base-commit: ee2867b79f9bac3a6fc3221139b09598ce79099c
change-id: 20260707-qxl-simple-c01aa1a5c4eb

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

