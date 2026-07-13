Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AF2C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4902310EB2F;
	Mon, 13 Jul 2026 22:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="YsnYua8/";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B5C10E396
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:22:18 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so26232015e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1783930936; x=1784535736;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xQcjUHDQsEmNnfkTtBFa/uOHpWpolesI3ffGjo8pqaw=;
 b=YsnYua8/rOyJBBsnOJUj5xrBipMm9NP/MSacn8B03GQEgHHlLGhKrSBTmDm/HwuNnh
 y0AjaHnFfXJI32W0PRh7X3jLfDdmHMy5sXVT8sDNpHw++5aVRcPQAsrrC5cGwtPDK5Qo
 uzBBcVcFopMQpraUAgZYhofs777vCxfjLadvktv07tHSu0rk9zeAPzdLUHZgPC6yb4Id
 5OD6PqMYsLebgFh8f0yKkAH5cnQFZgmPHTMBEK7YWxwSQqcI+F48vHwZjMYo/JWXLqrO
 IgbHWigWmix+fOzV5UpjPzuOhoHwBrjFWMIniskEy5gK5zN+/VEUACyP1yW4oasPO2Hg
 U9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783930936; x=1784535736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xQcjUHDQsEmNnfkTtBFa/uOHpWpolesI3ffGjo8pqaw=;
 b=YmMjUzSIEVLJd2axLFLZvGyNy366EqumwOkjkQgxincchCt3pVzR/DUeGVhbpZXqzX
 /Q58YNquvTLYboHuqSnLYcdjH2QI1NCI5xGyyl+EYgsR4BAh01AmOqgT7n8NhAjZ0VOu
 0Zy2v48/mWQmtOZhue61+m7JAVvAcHuzdH9dPgroW+ZX2UaZijl/4YgIqSMfe/2FvxKj
 6D93F4OPjkDQQIwA2PXYMOB9pbpZB8cTRthE1DHjEGKymQwFWzkkjjQd5H1erz5ioIrN
 PXM7zUxtlPwqEsEjIxPNSnhRsboCpwPcSTXKeNq7+MqC2/47VDfSVvR+/W8LWqUxoYzz
 VTMw==
X-Gm-Message-State: AOJu0YzUabA0BYDIZnCpYmZbMI0DYYLeiiC7YC2SxXrfPTLz9gMZTXJ1
 7jxPi0/zl2hYF4uMm3UYPwFUSj93QyEwukbAW9GGzeBCU+oLrjrl9sl07fs+XIGrhZ0GbmZPyx+
 JmSo8kVUU6w==
X-Gm-Gg: AfdE7cl1DLC4RUOCk3PyZXJXLDQBCoKQFo5mnswlOFA+NFqwzTMCL4JelowDjSt5v0Z
 K4/pHokm16bs12lArdwNcoXJXf9ob84QarHjfQF0QAj2U7dUVN9CT3UVj4s8xz5/f48wlg3MHCP
 M3Eg5DxIB5sLuWNg1PqEidA5Mnaz9vufI2ZpaCLoevW2wRMZp3B0zIs31XxsKOgV+7hSX3igPMc
 +RkDjbr0dWu686t6fydzPWes4TeH2I6FFSOVuFudLqQRA5q2O3doc2sD5eVU3TfEAlfVf2DVeb9
 S8fCmdlCUBqvaeNJ0sc/AjyFHMyvYvJxDXPYHVMEMd5ZAJUpo1ZTSrCO1Nca57l0tOyQvFMnsQr
 ArFiu5HDf0gSSrAMpTsKWk9ZjJDpZa1BUk35Lq/YOpoV5b3x5WdcTHGRX/E90RMvWUyZz958zPe
 +flcHJ7fs+f2kfWKAlRLpfCRJWz2gZQpfArtrtYw==
X-Received: by 2002:a05:600c:37cf:b0:493:c4e1:40a6 with SMTP id
 5b1f17b1804b1-493f882e97fmr71475255e9.32.1783930936201; 
 Mon, 13 Jul 2026 01:22:16 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ff432sm332879075e9.4.2026.07.13.01.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:22:15 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linusw@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, upstream+drm@sigma-star.at,
 Julian.FRIEDRICH@frequentis.com,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH] drm/panel: ilitek-ili9881c: do not fail probe if iovcc is
 absent
Date: Mon, 13 Jul 2026 10:22:13 +0200
Message-ID: <20260713082213.75759-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

Commit 4c95b2b7d49e ("drm/panel: ilitek-ili9881c: support Waveshare
7.0" DSI panel") adds an additional iovcc regulator that other
Ilitek ili9881c based panels apparently do not have or need.

The commit goes out of its way to make usage of this new regulator
optional, dutifully testing if the field in `struct ili9881c` is NULL
before touching the new regulator. However, in the probe function,
it unconditionally fails if devm_regulator_get_optional returns an
error.

devm_regulator_get_optional() returns -ENODEV if the regulator is
missing, causing probe to fail for other panels that do not have
an iovcc-supply set in the device tree.

Fixes: 4c95b2b7d49e ("drm/panel: ilitek-ili9881c: support Waveshare 7.0" DSI panel")
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 0652cdb57d11..6c8d02712566 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2562,9 +2562,12 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 				     "Couldn't get our power regulator\n");
 
 	ctx->iovcc = devm_regulator_get_optional(&dsi->dev, "iovcc");
-	if (IS_ERR(ctx->iovcc))
-		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
+	if (IS_ERR(ctx->iovcc)) {
+		if (PTR_ERR(ctx->iovcc) != -ENODEV)
+			return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
 				     "Couldn't get our iovcc regulator\n");
+		ctx->iovcc = NULL;
+	}
 
 	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset))
-- 
2.55.0

