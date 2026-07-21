Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32A2C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A017710EBAB;
	Tue, 21 Jul 2026 22:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NHFS/c9Z";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F7810E38A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:09:32 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so855780866b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784646570; x=1785251370; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4xJKLNUCU4zcgc7mgs3axG3RNflN5GNh8lQ7+FgeIh0=;
 b=NHFS/c9ZWHKn5vQLMXPN7fWxEevD7iszF+m7xHsXjcWVWCVODcCMq9MNWq0KGlMN23
 HaPc/DJGyGTLxoh4VSNUINHhuWzGd32IDA9MS7yquP3dTn4nIrWu+zo5E9CsYDIr+N+a
 Q2radyjYBf81Sw7/FGeQj89bFeXuDniU+fq42qzSaT61DRKVHHs2PteQrEUb7mPIiynK
 SN1mb3fhY4P+T92+mq1Bjb+7f8//R/D2YuL5KaePc9Ci1WnTn35Rhu5HDmZ9r+8NuzLW
 WfxsSONo8nnm7sa+xqS3jiAfvx/+1jlO0HN7XtEm2oIXKIsKdyBRWn3zrKNvY3orlYIx
 VffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646570; x=1785251370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4xJKLNUCU4zcgc7mgs3axG3RNflN5GNh8lQ7+FgeIh0=;
 b=fs9sZng16NoaE+YqtERCoAhE4OvkAo8FRDlUyc+ILf7IRGGd6Fk58Sbcee+dUnGKxk
 bYIyIR5HmSuo7dUW08ohFpdR2nh1TUfbOHzeakWO/a6+cH82wB36zhh0ss2kwdZ6GONh
 VXrpVg2pIOnrSSFnixERIN4EGl9L2sARzOgRA2VqXZcxJJh903GEsdwga5+GaUpSO5rl
 CIKMUdKIIi5KJTaWouLulJON1g3CdYxQm7EJYOoEdV8ZaM//fEtgK9Veduht6kOAM/R3
 KU6JUZWxWGCjJapqphPLP2sjkinyGDJAAGmQgkXPTQaZr6xjLlbhnSg1t6H5PNTDvguY
 4aSA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1jMjhK3Ot+1TVjKIF+Yw1ByXMuNGpvkdSRPfV6f+GtIrxl9sIzndXfpTI8uoqqcFaR8T4qRsv9OI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH9CF0iBZIku6QLxBShX89DY4xGKO3IBwX4Z33772snhO43LpW
 MSqtXOg7Ga92rtpr0NHIkL3zt6meu+6M/luKmSt0hF9sMIFleoscxg48
X-Gm-Gg: AR+sD13aTCK+J9cu/GLwGdWWzVOaoWAtwDjf1Xhh2ryCpF7wmz/MrztuBxA3mgIP7R1
 TBRTWuA/ierGgfOI6K+PDWOGvXhWPX8CNQ67o3YVtlEdmEUj7k2ku65Rus7Lt+mudhmKUo5bj2s
 j2qSLjRed21BFBW2nmx+TkJdzmUAtKpaRWEGs/eXM9CG9KrUFyG8P1eXBDTPxkLwx5weFwjU13m
 cKosUC87S31exWfOG5LDHXHB4+0fjcw9+OsoiZtIqeNpxn6DWaedXb+a+kHwMNFIEan4D4nL3fr
 9oto+ZHuaV9pfPKKjzGPJ4sP4JxRVhLqs5MjKX2wR22s9VIemlam+cCNVjW5xbO3LpQ/39wHlLl
 XZF2c3JN2YE/yVr0MEv/W6wFxKQsVqPqHtH80wJ4W3q9pVzp88Rofi39qHKc+Fry+Vs7xx/V6A/
 dQhcqJP45ADROh/ClnDSiqUs0fPrdWO8TApx4TIo3J5tbQ5V+qx2hMU1TGbNYB1b1VzIBU/HEvF
 XE5hvqMVaXUwzsI2laKlTWJYQGPx8S444FkdF50MKU=
X-Received: by 2002:a17:907:6d11:b0:c15:dcc6:d06d with SMTP id
 a640c23a62f3a-c16b434f631mr862277666b.0.1784646570150; 
 Tue, 21 Jul 2026 08:09:30 -0700 (PDT)
Received: from tliu-ThinkPad-P15v-Gen-3.eur.gad.schneider-electric.com
 (2a02-8440-5508-b816-6d82-3352-4e38-f737.rev.sfr.net.
 [2a02:8440:5508:b816:6d82:3352:4e38:f737])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1705afebe0sm599102166b.23.2026.07.21.08.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:09:28 -0700 (PDT)
From: liutianyi2211@gmail.com
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:VIRTIO GPU DRIVER),
 virtualization@lists.linux.dev (open list:VIRTIO GPU DRIVER),
 linux-kernel@vger.kernel.org (open list)
Cc: Tianyi Liu <liutianyi2211@gmail.com>
Subject: [PATCH] drm/virtio: Remove usage of drm_simple_encoder_init()
Date: Tue, 21 Jul 2026 18:21:14 +0200
Message-ID: <20260721162114.471692-1-liutianyi2211@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

From: Tianyi Liu <liutianyi2211@gmail.com>

Remove the deprecated trivial helper drm_simple_encoder_init(). Inline
the call to drm_encoder_init and add instance of
drm_encoder_funcs.

Signed-off-by: Tianyi Liu <liutianyi2211@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..048c19543218 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -32,7 +32,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
 
@@ -67,6 +67,10 @@ static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
 	.dirty = drm_atomic_helper_dirtyfb,
 };
 
+static const struct drm_encoder_funcs virtio_gpu_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int
 virtio_gpu_framebuffer_init(struct drm_device *dev,
 			    struct virtio_gpu_framebuffer *vgfb,
@@ -306,7 +310,8 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs_cleanup,
+				DRM_MODE_ENCODER_VIRTUAL, NULL);
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.43.0

