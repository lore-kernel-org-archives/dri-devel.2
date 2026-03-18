Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C39FCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B429410E694;
	Wed, 18 Mar 2026 07:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gd5Sj0VI";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4F810E441
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:34:02 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-485345e1013so4319735e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1773819241; x=1774424041;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omdjRU/gEJw2gRA8WansNujkZayGVofa0KZ631RBZQs=;
 b=Gd5Sj0VI2QchWfiOGegFeuJbIaGnX9XLgoULT9iMv+y0yFQBrYBdxQYEkr6n1NUkHT
 2R7bzTDfDitCQ4IzCe8KbTZ75w/bkrAte+h59e9P6SkaWhdS0Z+ss+uMfGeAyRKjBMoD
 uxcQkRRPxAcINK1ZC0GNTugqTj4XUizmZhCMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773819241; x=1774424041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=omdjRU/gEJw2gRA8WansNujkZayGVofa0KZ631RBZQs=;
 b=Ywk/cPAxQ0syjeXfDuTwjXP9qJ2+U60q/L2l8/mVCuKjPEt8usM6Z4MLL3iCmpkvfi
 dZbWaQ0h9PVpd7+o1f8Pk3+FfaNip9NQ4l/MrFQ4vocb/xIguABqDKraZdbSt1iydwRm
 lS/E0PaBkrBnC2p8/qxRvmUEvx8AC4nClqJDDxJzCiILkh9FVrsSo+JxEjOfVWeObR+6
 K/d+UaVANZE/d8ycCIK38S65j91dI87JdVaDeXdO2nPOwZ4oOfdOiGYu6vrIFgM4quu5
 6sBeUw79++JdBbYoTMRkWKzF7xhkH/ED3FL5snJQ6okdHU6I1BkECCUQUS/anbapyRic
 oOQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG1z6VWGJJcsn2IirIbwlWFPHxxgwXUHmkfD+Kc4NZpcbHiU4pagsbPdPFYmnuW8TY7tsAZwR1KMQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQv5sXez6fsXEtr5ChuQyFjEnS17xi2DjFnpvEcIfkGiEWOPMI
 WpfPPriUX06WEljlDN/lbriAbkcTmC3uoUqiqM9Jja2jtoZbvamkmQoiqK9mEVLqxos=
X-Gm-Gg: ATEYQzz92WhRdGvYm25PtcFUvqBSIAXEOLejwYnBvVDWdNEVNEISX3qqNneygdhHfbF
 L3WAkWvSU+itpqaiD7daoq4qmo0a7wCA82taeshgh9gaXpNBS6aQyXdVElCNlVlQl1fYVFixHCd
 IrQbvkQ/L8dGguyf70/heug1TeBhU5rkeo4niUOVltf88AvSKwFMCjTvofy4fHMvrWvhvsbinfz
 iJH3wd7x14mZ0dzUGB3GZVrnNuTTut/Uuxhjg1e6KaWmm37JyyC+wZNxbObRzeatjSzszSKcfTj
 9UK+SsQ8UYG55KBGb4qCplPRcdjzxBHzkD+lhIykXnNtovOcmfBAQAswugIegPcl1snX7KtAG+2
 s9Q9ibCm3ZX+9h+eYXnwp3Cwcnz+3EMQyLHmGsT1jQCYPaLUP7xqhRctm7aw7SBQCZ4YmEbBgio
 RIqJUTvONLNwanlCEolY5rROgbx09QVis3dJeAd61josQ4ryj8u5OrXYtEBW4Nat1JqOZGYQluC
 Lvxbi0+Ml4Y8Tz3heNRRmrp8BFy43zrw5JMM3w0lIECYOZLxkllrq2pJq6SgdlW03MmCBx6YtZ7
 j6LmuAxnENeVaqzoi6jXxg==
X-Received: by 2002:a05:600c:a0d:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-486f40c1975mr38877825e9.9.1773819240838; 
 Wed, 18 Mar 2026 00:34:00 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-97-160.retail.telecomitalia.it. [87.9.97.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f45f7e96sm25615765e9.0.2026.03.18.00.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 00:34:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 1/4] drm/panel: ilitek-ili9806e: rename to specific DSI
 driver
Date: Wed, 18 Mar 2026 08:32:50 +0100
Message-ID: <20260318073346.18041-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
References: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
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

The Ilitek ILI9806E controller can support different transport buses,
such as MIPI-DSI and SPI. The current implementation is specific to
the MIPI-DSI interface.

In preparation for adding SPI support, rename the current Kconfig
symbol and files to be DSI-specific, clarifying the current scope
of the code.

Since DRM_PANEL_ILITEK_ILI9806E is not used in any in-tree defconfig,
the symbol is renamed directly to DRM_PANEL_ILITEK_ILI9806E_DSI without
providing a legacy compatibility alias.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

---

Changes in v5:
- Add Reviewed-by tag of Neil Armstrong

 MAINTAINERS                                                 | 2 +-
 drivers/gpu/drm/panel/Kconfig                               | 6 +++---
 drivers/gpu/drm/panel/Makefile                              | 2 +-
 ...{panel-ilitek-ili9806e.c => panel-ilitek-ili9806e-dsi.c} | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/gpu/drm/panel/{panel-ilitek-ili9806e.c => panel-ilitek-ili9806e-dsi.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7241695df96..0ac6e344ea01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8028,7 +8028,7 @@ F:	drivers/gpu/drm/panel/panel-ilitek-ili9805.c
 DRM DRIVER FOR ILITEK ILI9806E PANELS
 M:	Michael Walle <mwalle@kernel.org>
 S:	Maintained
-F:	drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
+F:	drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
 
 DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
 M:	Jagan Teki <jagan@edgeble.ai>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 307152ad7759..142f32a1d256 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -257,14 +257,14 @@ config DRM_PANEL_ILITEK_ILI9805
 	  Say Y if you want to enable support for panels based on the
 	  Ilitek ILI9805 controller.
 
-config DRM_PANEL_ILITEK_ILI9806E
-	tristate "Ilitek ILI9806E-based panels"
+config DRM_PANEL_ILITEK_ILI9806E_DSI
+	tristate "Ilitek ILI9806E-based DSI panels"
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y if you want to enable support for panels based on the
-	  Ilitek ILI9806E controller.
+	  Ilitek ILI9806E controller using DSI.
 
 config DRM_PANEL_ILITEK_ILI9881C
 	tristate "Ilitek ILI9881C-based panels"
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index aeffaa95666d..2ceeec7e2110 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
-obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E) += panel-ilitek-ili9806e.o
+obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E_DSI) += panel-ilitek-ili9806e-dsi.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) += panel-ilitek-ili9882t.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) += panel-innolux-ej030na.o
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
similarity index 99%
rename from drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
rename to drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
index 18aa6222b0c5..c337c4f1a1c7 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -561,5 +561,5 @@ module_mipi_dsi_driver(ili9806e_dsi_driver);
 
 MODULE_AUTHOR("Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>");
 MODULE_AUTHOR("Michael Walle <mwalle@kernel.org>");
-MODULE_DESCRIPTION("Ilitek ILI9806E Controller Driver");
+MODULE_DESCRIPTION("Ilitek ILI9806E Controller DSI Driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

