Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B100AC4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0415310ED30;
	Wed, 22 Jul 2026 10:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HEQH4Zpw";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56DB810ED30
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:07:38 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4956869750eso10705325e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784714856; x=1785319656; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3REs2qGjomqbxDR0NSQ8ilL5HrSoQvM8Tf4GumzfTic=;
 b=HEQH4ZpwayD2YscWP6sWkEya5F4drhOScT77sR+5/82xh/z97F7fvo7n8QSa86MxrO
 rNfCaziNiGjKwbjzI/tYyKpdF7d70q6yWc9gb7F1KSdHYKqOb5vLkfStkl1O2t83d7sh
 JihOjKxPpfCpP5N++9n/ccsZI1uguXeyx6EeL1ihWF8qJkR3Wbz467/W33af0pnj6DSf
 WD9NCA22WzSSO2hZaAUbynLD81CI23HIw3rvFKStL7pdjka6rFwdy9pRilI2GzOLwcF3
 k4QYXYVPdy8RAvnTcoZL8KVH4L+qYlfqHoNAHDvalod0/1J/OOfDxaq9LRcv613vXteX
 si6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784714856; x=1785319656;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3REs2qGjomqbxDR0NSQ8ilL5HrSoQvM8Tf4GumzfTic=;
 b=CTscu5AJCjJyln3Le4aoGGBcuyi5DtMpY7XLhILHFBf97xeQO8CBAUwzrZrSK9xgIw
 eUWOI/R/OnqZy3bgz1TWAbvJW1HTsRqZ2f+sUbMsVpbNSseP/vdPUHrKPshUcCat82vh
 tkmam7QOkuLVPGngHG1weB2IUvtjw0qqNS0aH1enJQgKZ1XhbdarUEd+vZOAa7G2MfYB
 xzXuCXVD9TiCxiPDE8dMqx110JBA104kyGgOHLZ+NtR9Bfv+V4fwunpaAv+ZvXPnemr2
 fqHUl6Ggatf8T0koWvFeDEJSQOCVg483Fg6Wj3q9gu4z06zUPzEIjoajQc/PRk6RDOi3
 EQzw==
X-Gm-Message-State: AOJu0YwYWhf9LvPxR096ciUGpX3mSpWfwyw9QSDgv/3VuKHnZwFdHe+Y
 MAPBF/EmhsdGYTmxYBklu2LvNSIfmZtKuFrws8D/d8Yquk6utQlAV2dECBZpfcgXzp4=
X-Gm-Gg: AR+sD13+4AJdr7omUp0UyQEoG2TgRWK2MKaSh2ZvPQdUrJ/m1B/9AK4IlQTy7PAZ2m2
 psmle5r+fnDkGStfuq5IJDZ5m1ruav5+b8HgGw9hQjku3QTdnncfpIc/9FMwUWRlzcW/7JynGjD
 da805xTnc5NFUGPr+gYSMZb4IKu3X4wCzM/AXPaokR6WSwiIH4ZAJ8Ecp5xtSAsnKIp+tk4RZy7
 nnooChbWXCmFlj9b9ySlUJGYEZFQ4cx4loifQfS2cW1+T3W1tpXWJJaRIvtuVSYBYAebg32IQ3N
 oSn5oxIuardzLByRKtAZUBoYNyziW8DCWMFNJqs6C95zTzS8EyH9G0izTU1O7H00Y7zoBPlo8R/
 Lmf/TvxGff/3Kl8+9YlXd39eQ2hSROgf6xt3OmU+l+qjEYBaqueZeooYAt1LjnUli4EKRRv6hnf
 K6QkYdtUak5qgzjUMkEW5MR6A=
X-Received: by 2002:a05:600c:4585:b0:495:3eb2:b763 with SMTP id
 5b1f17b1804b1-4954a50c51bmr246233625e9.21.1784714856416; 
 Wed, 22 Jul 2026 03:07:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f25b6sm56086095e9.2.2026.07.22.03.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:07:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 22 Jul 2026 12:07:30 +0200
Subject: [PATCH] drm: fix missing header include for drm_panel_put()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-panel-fix-kms-panel-put-v1-1-ebde56446ee5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGGWYGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3YLEvNQc3bTMCt3s3GIor6C0RNfYItnA3NLE0CjNwlgJqLugKBW
 oCGxydCyEX1yalJWaXAIyTqm2FgBMJKMtewAAAA==
X-Change-ID: 20260722-panel-fix-kms-panel-put-38c079412f83
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Albert Esteve <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=g7/eALbrieKWG+a53MxxDem/J0HE9S+G/F/iwhj41eQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqYJZnXQr6E0bZ+prdCer0OHkH30wy9EoEP5dhovRB
 +qgdEB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCamCWZwAKCRB33NvayMhJ0e1OEA
 CcwEihOXsJfN3H92DygMrdNgASLoPt8ng4ShFdeyVmwcjH8KAOi3alcKUuGqlI/uYLI1vQkeuFDoYx
 np3ywKiZ6jvYrYwGnysbJ52twLrF7lLrnT8yISsZckIsN60fckNkkfIaJhufdLhGnUM+pdf6pGiofI
 vKy4+ZCidkkSLe4/YgWs6gIMWC6YAiKPH6BuwjZNv3UlCKG8XOOSp4+cUN6o8fnHZ2WVJ7vN6s0XMY
 Sf0a4Tg2IBuQxUMMGiNR/5Fi84os8S8gjs5x2b+xYGOO5m3HrpdGJaC2PRTxevHKW6R9CSEEHGKG8r
 1/INHJX3YzTuFVTM04IFizTk5WA2W3lOnsQhAq1Hh3yEV04VP91kO5mVBd0LBLkzRytLhoxyQG0HiX
 6u1+iqwpf+YGMlvoljOeDydqSqTMp6ATkk6da1Hl9EYEy/CeCU2ot2/bQQGq2xo0usQwxBST89AQen
 VqoZSjf4fMZHm+X7MHc8DgbOdPqag2vg5bfWaxEjL4oq/Wuj49t88YE5ugb1oEKdSz/TMd7uztn00p
 qWIzKj1vrbKRCTwspahUEKbqt8GsJtVIRCbq9Ct5r24qvpr4RjCT+puehfixjtrKyKul26i/UrUvzL
 LvXcG3SJjZYTaoj7YDfveJ1zPlTP4kvr33BPm0gtjqCv2B1rcPV9cMGO2t7w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Some DRM drivers lacked the drm_panel.h include to use drm_panel_put()
after the commit b71a623598d3 ("drm/panel: of_drm_find_panel() return a counted reference").

Fixes: b71a623598d3 ("drm/panel: of_drm_find_panel() return a counted reference")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/imx/dcss/dcss-kms.c | 1 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c   | 1 +
 drivers/gpu/drm/stm/ltdc.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 01e0c10b6ea1..7c5a6e2bc89a 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -13,6 +13,7 @@
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 7cb19c15bf39..8b4a500347fb 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -29,6 +29,7 @@
 #include <drm/drm_mode_config.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index daf198edb42f..8818dcf98da7 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -34,6 +34,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>

---
base-commit: 0f065acf44aeb8c32691d88cc87004fd2e54e902
change-id: 20260722-panel-fix-kms-panel-put-38c079412f83

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

