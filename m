Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FECCD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 07:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F5C10E099;
	Sun, 10 May 2026 07:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fyJiAsGI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173AE10E099
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778397170; x=1809933170;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OlIjpCvV7ppjmdQpsbhSodKT6NyjFv5zXEfyragxDOU=;
 b=fyJiAsGIfjXJY8l828DVSBxwHdSHN/P77aJTy/pWpTufTAnuIvxWx1ge
 4RMkuL1lNaS0OYVkI81wlMB/QgbZT+zBzvtE5m26AiZciwDu3R7U/RM7d
 ao0sC6+vN6PE2y70ZCDPW6qBXVKhgZdROgk5qoiD21abChM/PYStZJcDJ
 P9T0T3icjbN99KzGWCkTmbUym2H9GFoSnPdodpS2xgWInZ5SHR0YrBY87
 A6Q/SLZ3+rn0XvMbqS1NuEvL6ZfWIwtac/wNz8bTD8tR5jkLiFX9E77Zk
 pP1Wz+iKc8KIRCEwQ0CSAmdG2jhW8/apiGpLdncV9mTXUkleD5CtFt0J6 g==;
X-CSE-ConnectionGUID: tvQSCXbTRyC4RTr+fJ53cA==
X-CSE-MsgGUID: Ux1vLUIyQhmxe44Jln4FGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="83165779"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="83165779"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2026 00:12:49 -0700
X-CSE-ConnectionGUID: cdm79irFSw6HboulVylFjg==
X-CSE-MsgGUID: CZaFe/UTR9KgNn8TzqkbPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="234501703"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa008.fm.intel.com with ESMTP; 10 May 2026 00:12:48 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 94F6C95; Sun, 10 May 2026 09:12:46 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] drm/repaper: simplify with spi_get_device_match_data()
Date: Sun, 10 May 2026 09:07:44 +0200
Message-ID: <20260510071244.1580642-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used correct parameter
 drivers/gpu/drm/tiny/repaper.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index c8270591afc7..3885a57600c0 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -941,24 +941,14 @@ MODULE_DEVICE_TABLE(spi, repaper_id);
 static int repaper_probe(struct spi_device *spi)
 {
 	const struct drm_display_mode *mode;
-	const struct spi_device_id *spi_id;
 	struct device *dev = &spi->dev;
 	enum repaper_model model;
 	const char *thermal_zone;
 	struct repaper_epd *epd;
 	size_t line_buffer_size;
 	struct drm_device *drm;
-	const void *match;
 	int ret;
 
-	match = device_get_match_data(dev);
-	if (match) {
-		model = (enum repaper_model)(uintptr_t)match;
-	} else {
-		spi_id = spi_get_device_id(spi);
-		model = (enum repaper_model)spi_id->driver_data;
-	}
-
 	/* The SPI device is used to allocate dma memory */
 	if (!dev->coherent_dma_mask) {
 		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -1023,6 +1013,7 @@ static int repaper_probe(struct spi_device *spi)
 		}
 	}
 
+	model = (enum repaper_model)(uintptr_t)spi_get_device_match_data(spi);
 	switch (model) {
 	case E1144CS021:
 		mode = &repaper_e1144cs021_mode;
-- 
2.50.1

