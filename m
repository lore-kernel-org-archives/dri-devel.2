Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5C5CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D797112B70;
	Sun, 31 May 2026 13:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oZjhI7m/";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E86B10E457
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 07:37:25 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-36da8439078so81264a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780213045; x=1780817845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7Nfdh9lJmyo73Y+RAkYTNq+7+iO9zy7FykzaU5yHn8=;
 b=oZjhI7m/E2gSflYe8doUGgdh9ymKASmByDptvkmYGaE/aROp51fwVmBMWmgVS4M75p
 tRfEoXBL/A1xXtRg/18K/7Ls9YXX2LWguWYHZ1x+vIY2dVpAcBWxw7GqVrhbt+/IGpKB
 LhgNY+4JbZWwNkTI6GpIQu5C+8DugkyDgxwF2XJTy+WmtKGdq4ui9IhSPu+vLdnWgGty
 1vX4v+aVTnGbpSRoXdVoncq4Kd1a9d103dJpMpnFsw4Wxx3SglUe5ygzlmx6gyzpitSe
 0M/6+HwajZCOZ/pP3+BVw41tdBVI6ImX0jAP5azJmG6uah603jGcTpDuk9hOsWgJwgr+
 Stzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780213045; x=1780817845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g7Nfdh9lJmyo73Y+RAkYTNq+7+iO9zy7FykzaU5yHn8=;
 b=mEogJ2AvEB47D7XWbWE4J9upjKq7T69L63XewsQLgzP9ql+tzv1U0o2Av12Bf1LP0z
 CjRZM0zR0kU0DJ16RSkWVBoHto2wy5qD3NiaEryq5JKe4XgzWF9RlGIFopUsoOfywnZQ
 38md3bgWI5ukU8RcYJlvd0Wu195VFOths+FqIjhsLoWpCAmKUhLH0hAT9S/gjUl52anK
 8XggjkT/G/PEw+iPqr6AOyoDG5bvw2bIBEDDG6T+jHqd+z5VVyPhNJxGBmXJAeM8rOT+
 Uoq0GqtvV+/hj7cH5bwKvck148O+mK36P1yM9wrgEIZLnDBpc5TxPoS2M9Rd8q7++M06
 /86A==
X-Gm-Message-State: AOJu0YxAiemcUQzkLvsaIcmpmGzUTFt9n7+8R13SuXnspQ0R9vCFFXoo
 Wj5Rre77W6GKNEHyTcbtnUl90bXvXsUolrK8ljlMAlYZvWN0z60k1oMINDzaHLD+
X-Gm-Gg: Acq92OHVHSIHJlEEd2m7U05MQq/hh3rdhDaGil5D4DROoOxQxwU0aCk7zxi4HDbmvO7
 gRON5KulnSSrqYKJsZCv7dn6LsgNerTdrqVNHnfOpKWJ4ob0ylycFLvlRhhitH/kRHcHwUfax7J
 4zrwSyB1o1Tl6VMpw7SurSW91Qrd8fEWBOtD4+6tN+o3aQQTebk6D2RTLpaWxLiCVfsnUFQJ9Zs
 m+WWfR/HOcmmSA/n+Q+Lk38p4ke4s33Zj/PIc2teLxqZQ94JhZZZO5AiYFozXPEE0Qmgg7t6xH+
 MWaVQzcJge7tkJijcs1qei7ljz1G151oQPs+SUTDy7AKwz5BuBI6WDTCQHCmN4prdpMgt14MEEO
 Ldg/K9reSDjw15mCtTtTY5FtG53poVhoCamjRpGo6vqK+aKdafGg7JcA/v/Hvy9SDHuTzuzPf4S
 3nFg3l0E1uUOagCyu1gqThm2o7zQ05hnn/hXDoYKCGnA==
X-Received: by 2002:a05:6a20:d04e:b0:39f:3ca8:a33b with SMTP id
 adf61e73a8af0-3b427fe4d91mr6837181637.17.1780213044907; 
 Sun, 31 May 2026 00:37:24 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 00:37:23 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, stefan@agner.ch, alison.wang@nxp.com,
 jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 3/6] drm/virtio: Open-code drm_simple_encoder_init()
Date: Sun, 31 May 2026 13:05:29 +0530
Message-Id: <20260531073532.8609-4-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260531073532.8609-1-namanarora029@gmail.com>
References: <20260531073532.8609-1-namanarora029@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

The helper drm_simple_encoder_init() is a thin wrapper around
drm_encoder_init() with a simple destroy-only encoder funcs struct.
Remove the dependency on drm_simple_kms_helper by open-coding the
encoder initialization directly in the driver.

Signed-off-by: Naman Arora <namanarora029@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index f1dae9569..5b99cce17 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -32,7 +32,6 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
 
@@ -271,6 +270,10 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static const struct drm_encoder_funcs virtio_gpu_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 {
 	struct drm_device *dev = vgdev->ddev;
@@ -306,7 +309,8 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	drm_encoder_init(dev, encoder, &virtio_gpu_drm_encoder_funcs,
+			 DRM_MODE_ENCODER_VIRTUAL, NULL);
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.20.1

