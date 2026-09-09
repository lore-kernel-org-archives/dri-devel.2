Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890B2C79FB9
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48CB10EFD3;
	Wed,  9 Sep 2026 08:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RgnP1cse";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A36110EF7A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:35:04 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so395237f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788939302; x=1789544102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rwJskRf230nVoXvEhVqyDUFt4l3Cq8VmWwWkkc6yiy4=;
 b=RgnP1cseMhn8n8dEQGyjKsq/lsHNi/nzuZxmJbaZsTolZt5is4Ju8LmGBl2MKLjZXc
 EJcJtMnP4A8PWNU4a6R1Ik1xfXB8cMPN3CeB3S/vWq4y+EkM6TVkhRrxnZIrUku/ExEY
 xjh7wG6F5e7kvESexhSvmnOtuXOMo4gdgya/mwB0xp5LrBVWVG0UfcDfNRQaKDjmUPtW
 LnpnwlA3Q/Tgh+Ubk98hZU7cOgSAZrhI/tnSvv3XlRyCETP2Avz/nnPOKdZIow3C9xBS
 E2mTVn8iQe5ljA7E79LLeLXxYIAWEdTI0ZFQIMi1nvN2SZxAcxky7aKaz9yxnirRTK3h
 5ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788939302; x=1789544102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rwJskRf230nVoXvEhVqyDUFt4l3Cq8VmWwWkkc6yiy4=;
 b=kJ2hmtN4DHHj/hNhuyWeO6yzjSlwUDGKv72oic3jQKo840YzQKOvXo5TSsdpdbShwI
 yntQcBAsFZvryRrX1OuI4s6tcKllcx3Pa73aN1Y4COigXLxh2YnchFynFbiLfKJ7twDV
 5NEPOELLZ7SWzk+ps0ytkCrq18cAy3P83kiB7cQDnM2AYSoHOGyGvCvVs5OPyFDpLZT0
 U+zlgk8IJiSbAwcP5AU0vbsNkmHOUbq8dcq05gC8CifIDdGSLTLFy+fJazJyuLyJ1WsE
 zphLZPMQGjiO6e/Rnf73lB80ZTgobcTWYY5F+gh6UZIYkxkL8VejrL1dQgSDjIsK+2Qg
 S94Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbsVzBSnC9Q8Emkap63ctDSdQibECsmLBC0pWBiQCXWNsuVfi+Eop+LVh1vwp4cbViE9k6p4HG4fg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltQGtmxLnCA97wh364T91Aq8mqOozAg8O5w+dvb1SFAzNzEr3h
 U/yarjY62dOb+iMXcIUOEqCgnGJhC/O+QtIb2UKjVUdrjOwQIsj5DzoG
X-Gm-Gg: AYBFou0mrTVUcTzy/rONd9aO5XrH6UWRW1EC0r+RG3V8DSumrQqDTISzmWMPl/vA011
 L0kBMxvvs4qj/AVql6+bf4BU0aWg3ow2g/xvmmHKJFmg77Ov0AcrqETlbnJJnyhMHm0B3KzfJ9Q
 1OlqKeqoqAAM0rarHt3Qx8jDRo8W0V6LRlXqSUp+SkXgaXwKNIIX37UfmFIoO5QuNE8vJGKw2Xs
 aRJYumvaFBmKub+XXPGUi8KEIHFD4dMqS5RVkokvzO+EjV4OWyEuqxjTL0e8Rt5cGHHwcnlWjex
 /DQiWTmsJaiuCzVv4yz/gbyXKFdzSvgzuBcyVenNl4LKbJ2C+UmZI7RwZXvuI4H8kIf0yj7tDT0
 YpdaV84zSdZoX7lZquwurgiN9u+0hQBXw6TyzvYLEwbdRuzRKAm2ixvWZn7tv5O2GFC3Ydf/nRL
 ZINkqQa5iSoZV8h8H/UBzDfyNUy8fevVkgIZbsLh27puRBinlQKLcw9uanuOJqfuZIPLL1Edy0B
 dKsFlESrmkOjBRB31/5ij522Lhi6B2l2JdnLLRtO0U8YxoiiJ9RFK6fBVley0g65Jd76MTqdHrM
 XUi9pDxRbVpfFDGOdTwU2pWb6/91n3k+1W8IK68=
X-Received: by 2002:a05:600c:604a:b0:49d:1012:893a with SMTP id
 5b1f17b1804b1-49d1f320b72mr55194575e9.7.1788939302009; 
 Wed, 09 Sep 2026 00:35:02 -0700 (PDT)
Received: from PC-Davide.homenet.telecomitalia.it
 (host-79-24-252-102.retail.telecomitalia.it. [79.24.252.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm588770945e9.1.2026.09.09.00.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:35:01 -0700 (PDT)
From: Davide Bonatto <bonatto.davide@gmail.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Davide Bonatto <bonatto.davide@gmail.com>
Subject: [PATCH] drm/virtio: Replace deprecated drm_simple_encoder_init()
Date: Wed,  9 Sep 2026 09:34:38 +0200
Message-ID: <20260909073440.52641-1-bonatto.davide@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 08:38:27 +0000
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

drm_simple_encoder_init() is deprecated as it introduces an unnecessary
intermediate layer between atomic modesetting and DRM drivers.

Inline the helper call in virtgpu_display by defining
virtio_gpu_encoder_funcs with the default drm_encoder_cleanup callback,
and migrate directly to drm_encoder_init()

Signed-off-by: Davide Bonatto <bonatto.davide@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index a1a875a0c706..85986578001f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -67,6 +67,10 @@ static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
 	.dirty = drm_atomic_helper_dirtyfb,
 };
 
+static const struct drm_encoder_funcs virtio_gpu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int
 virtio_gpu_framebuffer_init(struct drm_device *dev,
 			    struct virtio_gpu_framebuffer *vgfb,
@@ -306,7 +310,9 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
+		DRM_MODE_ENCODER_VIRTUAL, NULL);
+
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.43.0

