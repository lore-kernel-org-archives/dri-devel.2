Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1634CD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152F410E233;
	Sun, 24 May 2026 16:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ix8e8VzC";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF29E10E233
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:07:04 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-369002b26f4so5006181a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779638824; x=1780243624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=18MxIR0tdVmzmTTCjfqveL+dgh6nwJgg/2YQDWJQQr8=;
 b=ix8e8VzC8N+WrRk0AwGG7doxxePEy6w8nTANRtKEmTBDeYmtRw/7zvUB278xjWOUi0
 djwVKYk+UWRIcKytL+RU/GvHScaFQhe108JSVp2GZreiTzbE6WL4u4oCLAIZ7pAhPRo3
 HmQbG2wQkbF4RXtfaL+7bXC+8el66n/kUC/MDfG7Ucv/Uq3ZGmpsHzxHYzqgY14a6rmo
 9FaaRnxT27f9E58rivY90D4MOltCqV4zBqJUB2erthkBEIDP9i6rRVRAsifGt2jnSsni
 g/ckFMKrrgnNA3yNAlnvZ+F0cZ1i8g3PH37t6O3O3nGJR43RI+5yKTg5YFNX+a4pLHND
 iScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779638824; x=1780243624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18MxIR0tdVmzmTTCjfqveL+dgh6nwJgg/2YQDWJQQr8=;
 b=MHo56mY6Xc3Tq8nd7z8odpyPdOcrIeUsMvaYufQSYYf6w7MxvXU4joVWvyphGLE0bW
 sv/ya6gwlForoKf0MEMJCNsBy4pii9ajNVIa9ZbXa2WjogiAGDxyKVxwkXeTi+2jsqFa
 TcZ4vvwwoSXNsf8n7MI+NRxSv0rXUje/nZPTY1Lrv9NL9M9IVxe1zet6nrRgaOvyeBYg
 dT+ZFWxGZ/lK5wxZiGduioqyH4F9jcK/U1+rNO86cm5ne2YZGcx7sokHudtOiAv3YChQ
 2DrYjOaAPTnrVrfhZdlOhu2T8eVtf3+ednVE5/avJk4m80116UiGhx0Ii5Bm//Lmzl8q
 uzAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bTctAQ71U6u5jyctrbaJshjilcuqxmJWhAz3s81m/9RiGgixvlGsqhwe+s4kYeq213TwIX/BpQTI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8wXLZ6/a2cF8JJwbGql2j3R0H/+3i3Giqm91e92zG3FkZK8GK
 5Et3YUp10kta/vTYEDVt8e28rcGRr/brPWNfpOJngbQF3k3b4RkXfT0=
X-Gm-Gg: Acq92OGxqdHY27gHfjhPy2Sc47XB3NIM9UVvWSqQd9t53IYnYm6eWUO4sn0Ow02UF8A
 /ios/uXxmztbkZHi1rkSBrGCa82zIbCPYEd7r4X+x4aTMTahheO7DdiifCjUVi/BDxAsHlR7FqN
 VjFoQCHoS1zQphsp6iJK7gm6mzlUouLjDxNctVdLKXahNk/z8zpj3R9yBoVgWLKfBcuLVegF4A6
 JRp91sGOEI+i5AJwATcYEmhxJXhzJ9pT5CCHxsgNavQ4WT7JSMFgfdbdXsVBQfBUNRJHZ8Hcg1Q
 kagDkFoJvVCDsE1J41TTeSAIDs480kbTKQGC77RF97hdTEl78K2Yn9LClno99DaHAiMS5xOD650
 +YboZtj6pYgEYyHl2/Vg8zvEsDSse0pSadMqbHaylms9M5b0JjuaPg0P64pXzcsCURh2621qdgt
 gEh8cv6MzLpLB4qwt/2DEuO6EyG/kmJYSWSpI9Sr/Vz/zpJwJZtxKa81+fzVCuFAr5rz1jtao=
X-Received: by 2002:a17:90b:2585:b0:366:3ac:f730 with SMTP id
 98e67ed59e1d1-36a6788e0abmr10212406a91.25.1779638824285; 
 Sun, 24 May 2026 09:07:04 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36aa73da32dsm2082541a91.4.2026.05.24.09.07.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 24 May 2026 09:07:03 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/meson: clean up KMS polling on register failure
Date: Mon, 25 May 2026 01:01:39 +0900
Message-ID: <20260524160657.17802-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

meson_drv_bind_master() starts the KMS polling helper before registering
the DRM device. If drm_dev_register() fails, probe unwinds the IRQ and
DRM device without stopping the polling helper.

Call drm_kms_helper_poll_fini() on that failure path before freeing the
IRQ.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 49ff9f1f16..e49de5df73 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -352,12 +352,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		goto uninstall_irq;
+		goto uninstall_poll;
 
 	drm_client_setup(drm, NULL);
 
 	return 0;
 
+uninstall_poll:
+	drm_kms_helper_poll_fini(drm);
 uninstall_irq:
 	free_irq(priv->vsync_irq, drm);
 exit_afbcd:
-- 
2.47.1

