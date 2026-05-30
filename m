Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CEACD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 19:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262DA1129B2;
	Sat, 30 May 2026 19:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V3zvkAlV";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8C61129B2
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 19:59:42 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8423f53332aso23051b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780171182; x=1780775982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xDsrez4hENrmsOP6DpqaPlhTbFkmYHTO8HsVENUs2Sc=;
 b=V3zvkAlVwA+Mjfg1orLkVBfymwbe12iapNwTXcozC2psa2jUvCvQXDySDuyPHOxVJ3
 UmYWw6Zx37Hpc8icfpYESM11a5TqFS+lM5tWKL8XXkRShJRLzVbUG+ZNgBzyIQydKGgc
 lVDM3pgtoNOzok4inoHc+LUgu0We9wh39SxqyCq8IdiZz/JTgWkuA/tzs7oV1cBktrwW
 60RaEEcOBZCcp5VjKvKhRYklytcVaPQZfNMozvJgJEQ4zkvtNIiePYoAxCBujjhPpwQI
 34kbX2/xgrfMzxgysQU973LASZU0HwtEfmSArG6EinwyNMD1ClisjmwWA9aLmdBNwQFG
 vWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780171182; x=1780775982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDsrez4hENrmsOP6DpqaPlhTbFkmYHTO8HsVENUs2Sc=;
 b=om0LuDvpQjvQU1d2bJc2xSiRJKdLppk460oY9x3csUcDukBe6dBRMS4/BtjVIr7XRs
 aUxz4iyJgsUKiga/nRtewTdGbadix8ThQ3gG2bP1O0UITazFHIZaN2cJ8GBYo0h2ngHb
 aRJD/YcFXXKCHzd7LqDXgxZocpezCDh2g7+S0TMVpSMocKVLMWGMhflh+U7d2UO1SeCA
 Bvz9dQzYxO/y80RVVISzAwZeTADbILb6EVyU37KVT2/gb0el2WEjxULgA6JIA+NGxf9N
 LJJe9ZdRa5kIbWcD1J0/qsqV6O93qSYgj9F7/1WqeN9jd3sDcgCW65Xq3nWbtQtlquzU
 rgiw==
X-Gm-Message-State: AOJu0Yw4BBO1h7OCOU4tCXysKAYULS111JJ4uuU0aau8hzs3oLu4030h
 x/Rv3gVtdEIoRGdKHWtwoqgPOWoTkOXDOESFSXAZC2ouo+ghLsblTDg64GgENUcl
X-Gm-Gg: Acq92OHUbspTWz1R951RVwjBs25Puci+LYMP0bkf8mFhpkgTjfYLIsvj4Wjj6oPnHSP
 0wuCmAHgVoB85mGOD0iEkAYPgU3X2dTCVnVH8SFwcCNoJ7Cym2X0ZSBLpqGdELtoIxOxqqcO2Ij
 +kX0YgjtawbpaQtgOVqBwTsFp3h/RG/sFk2qQuAfUEt+ttRkkXTu0pjf79tLcUNGr8AB9ndnG2o
 bvV5eMjusLS3Ykm8/TFuMq7959zzp3OcyUBFR2FzEIsmTFZBXpmnb7gbFAXZw332OmQJ/88fCSm
 wzJHRjNkmgAp1yJULSm7rNWSYHJRy2DbEcbk2kdYqFioPjP/aZKaLrs6uwedO1cnyYawFb6uxiO
 swzDP+KxpV1D3WpWlTxkZJY/kLtzNNBR8CxLqIhdkxoe1nnxjfQErOTv3IcBqD0UI+Q8jeRaI5F
 Okp+o2FJs9s5NAJn+12pOnulwR2FPK8pvbAnb9D1ZdMa5AmOFZVZUsYlKR0irQ0T5x9jdyDwUN0
 wK6j+vHlOMWgnL4RuAXaMiV6J5uox+pd2TClr5lrY7i2g==
X-Received: by 2002:a05:6a00:4296:b0:82f:5726:be23 with SMTP id
 d2e1a72fcca58-8422575fed2mr4382838b3a.49.1780171182401; 
 Sat, 30 May 2026 12:59:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8422b170f31sm2682850b3a.33.2026.05.30.12.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 12:59:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/imx/dcss: add missing kernel-doc parameters for scaler
 functions
Date: Sat, 30 May 2026 12:59:25 -0700
Message-ID: <20260530195925.5477-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

dcss_scaler_gaussian_filter() was missing @phase0_identity and
dcss_scaler_filter_design() was missing @phase0_identity and
@nn_interpolation in their kernel-doc comments.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/imx/dcss/dcss-scaler.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
index 32c3f46b21da..e48b3117efb9 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
@@ -166,6 +166,7 @@ static int exp_approx_q(int x)
  * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
  * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
  * @use_5_taps: indicates whether to use 5 taps or 7 taps
+ * @phase0_identity: use identity filter for phase 0
  * @coef: output filter coefficients
  */
 static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
@@ -262,7 +263,9 @@ static void dcss_scaler_nearest_neighbor_filter(bool use_5_taps,
  * @src_length: length of input
  * @dst_length: length of output
  * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
+ * @phase0_identity: use identity filter for phase 0
  * @coef: output coefficients
+ * @nn_interpolation: use nearest neighbor interpolation
  */
 static void dcss_scaler_filter_design(int src_length, int dst_length,
 				      bool use_5_taps, bool phase0_identity,
--
2.54.0

