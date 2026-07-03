Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A46BC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FAD10F898;
	Fri,  3 Jul 2026 19:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ValvrC/Y";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E08C10E243
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:57:06 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-845e363246aso747373b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783097826; x=1783702626; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BH/48gdcp2MtkVAkmPaRKPv21BDGKaIsbJsH8YRAsJU=;
 b=ValvrC/YLFiYpFO1Qp+I4R+IfaZuQezFdNmwi5IRLzB9g98wtWppOrVa1e7ujvMGax
 jkzHxZSdNHDbp6BoP/rE1yn/FJjVCH6wviclnK4FM8pySclq6er2fRMej9W5B5muCADI
 NscGpoom6VGPdYDo/yoj+AToO5y3Gv8NrKl73IxR1ZNI+IsxYLIN6NSt/pwwDERSBya+
 JNPB6nty+SX0JhXrmxFzx76Zslq4bnhvBtU7So42C2iIK5keTN7nSxUsPmVN7QH7UPrW
 axj/s1MXrZvliI15NiDEZL1qQYvEqkvNGW4sIll7f/Brkok+0sQKCvSHRYtLQ+2LPhwW
 mO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783097826; x=1783702626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH/48gdcp2MtkVAkmPaRKPv21BDGKaIsbJsH8YRAsJU=;
 b=IUk15vbx303Qu8TFHv64JT9vmBoARlYjMW0I5lX5bCN1dIWbPJgCFDpPPGs0/w9OO3
 3+A8wdW1fVb26exoKHyXzVh0wuiQ9VkYNB/lG+Q4ZXZRNqZPy4Z+5ndUemN2Yh/ml4gg
 nIWwFh+EnXinztin3Ok+Vxuq9YbjZv/dCwjp8QamM5Pvku8ObZ3sX6ChHRHBPhM5fZws
 W35V01HeA0vF0/IyInlMKcat0bWyPNnKS2hnNHxU3dIYGlFLN2DMzTYkcle6lqeQn744
 2WL/zC72WbgSCrtwnubxZW2RCYv7Ph3TJxcpPOa496YvkxgHlwuFppXnLkVram9RW8kp
 QU1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1oKWEYlSMEp5jgo2wU1UXbu0xn4fQ8/oDUpDvfUT4EgaxokC77I7eCWqAfkcJjDkjbPl9fhJyuPw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhA6Fs6wHdv2athkx/i+UaBOOMHTjzKZAIXEONjZXXYsUU5+nw
 5T6tRnaFlXy0FtvY5dampJls6YAd3ibAlNbjY6i6EyKjAHFsdpZMUEKp
X-Gm-Gg: AfdE7cmFT3wx1flWF4IhIamboC5wS2OwpvqGjJaOs33oNIcGN9zVQFTqV9ISixCFahy
 TnffzDlPWJAGcuQFGmT1uScSwqqCTAjd93hUBePeqw+QLs6i7iwQTrJqspSIXcd9jD4mFbCarpe
 RZgNiZMPvEfEJDvmGIv+cNDBEIr/GobizJG9CM1JKbTh6XSTgKc/AcUGomUMRdaPdCNZjDVpY86
 Vp+vOg5F0uOkskGqXpmOFLfITcFeq7QIhYwLAfBxL/nJ1cdsLoHQlB8FpF9mndYexEpktxtSaiO
 6x/tpaeLlVWBhToiLQiTAATuy/NzCdclJqh9joT4uVpnmTOShZje6Gv8fB8f0b23P8F7x4Or4+q
 Cg+ygAT4R81nvea5O7kHcbRnBWekAYnHEsm+cvjQ2yChd4R8ua29pv3mx3+Oczc6aePHR4KsScv
 ZJxQBPpcZPLfSO6edMuDw0cFK1G98PRQh9uB45bf/MOvcyU5z+lVD/nNaEMmlwrX2OhWjxocc=
X-Received: by 2002:a05:6a21:a44:b0:3bf:97e8:a04d with SMTP id
 adf61e73a8af0-3c03e50474cmr203966637.43.1783097825747; 
 Fri, 03 Jul 2026 09:57:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:1a77:5159:e60:7cc8:17c9])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b41c364d5sm17459436c88.14.2026.07.03.09.57.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:57:05 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Subject: [PATCH v2] drm/panel: samsung-s6d16d0: Power off on prepare failure
Date: Fri,  3 Jul 2026 22:41:32 +0545
Message-ID: <20260703165632.27027-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 19:05:53 +0000
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

If enabling tearing mode or exiting sleep mode fails after the
regulator is enabled, s6d16d0_prepare() returns without asserting
reset or disabling the supply. Since the DRM panel core leaves the
panel unprepared, a later unprepare call skips the driver callback
and the supply remains enabled.

Assert reset and disable the supply before returning the DSI command error.

Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
Assisted-by: Codex:gpt-5
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
Changes in v2:
- Resend as plain text with git-send-email.
- Correct author, sign-off, and recipient formatting.
- No code changes.

 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index ba1a02000..04e19b5f2 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -89,16 +89,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret) {
 		dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
-		return ret;
+		goto err_power_off;
 	}
 	/* Exit sleep mode and power on */
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret) {
 		dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
-		return ret;
+		goto err_power_off;
 	}
 
 	return 0;
+
+err_power_off:
+	gpiod_set_value_cansleep(s6->reset_gpio, 1);
+	regulator_disable(s6->supply);
+
+	return ret;
 }
 
 static int s6d16d0_enable(struct drm_panel *panel)
-- 
2.51.2
