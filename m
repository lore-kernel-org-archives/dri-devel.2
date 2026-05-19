Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1A0CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF70610EBB9;
	Tue, 19 May 2026 09:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="HGsdq01r";
	dkim-atps=neutral
X-Greylist: delayed 425 seconds by postgrey-1.36 at gabe;
 Tue, 19 May 2026 09:09:02 UTC
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A8B10EBB9
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181742; x=1810717742;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bVqS1Abfd3XhxVTJJMr1uiuME/oE+EUAC30jYZW157c=;
 b=HGsdq01r+HJvfwKHLdT/8AtxmwF4kIEZGJE1NIs0c/h3xz0P0A6aCCnE
 NxrSGKoY/f7zofJRPMLH8APB4lQc5gSQeb69Cd6baxYc+fu4/H/mO+QOg
 B8hoGF6q9BgmPgHO86013FYROS//DHF48JrQ+QRyuTNTRGKcgBkjoka2q
 BjoFTBhYEO4rQz417LfyGezXq/C1m5dioc2OkUT032g+IPpjAveO6zvhd
 MhsYC0vKUNZVd0dVgm6XKjttRsMTYP9p+JDIjT7xLxp+D+8SDHyBvTjmz
 /bUkcNyTnc/XW8Eg6pnI1+Rxqp8VIrm5MbDNeaJF99dAkivqS0RprbYXv g==;
X-CSE-ConnectionGUID: ax/201G4TeWRIhxu7tRlag==
X-CSE-MsgGUID: Sj3WJHEnQjSuGAIDTdsJ8Q==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="289088331"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2026 02:01:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 19 May 2026 02:01:55 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:01:51 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 0/8] drm: atmel-hlcdc: fix clock handling and add LVDS support
Date: Tue, 19 May 2026 14:31:27 +0530
Message-ID: <20260519090135.1188405-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This series fixes several issues in the atmel-hlcdc CRTC clock handling
and adds LVDS display support for XLCDC-based SoCs.

The first patch fixes a pre-existing off-by-one error in the vertical
back porch register calculation. The following patches progressively
clean up the clock divider logic by introducing DIV_ROUND_CLOSEST,
defining a named maximum divider constant, and extracting clock setup
into a dedicated helper. Clock bypass support is then added for XLCDC
hardware when the computed divider is less than 2.

The final two patches introduce LVDS PLL clock support, configuring the
PLL to 7x the pixel clock rate before the timing engine is programmed,
and add an LVDS output mode handler to map LVDS bus formats to the
appropriate display output modes.

Manikandan Muralidharan (7):
  drm: atmel-hlcdc: Fix off-by-one in vertical back porch setting
  drm: atmel-hlcdc: simplify clock divider selection with
    DIV_ROUND_CLOSEST
  drm: atmel-hlcdc: define ATMEL_HLCDC_CLKDIV_MAX and fix divider
    fallback
  drm: atmel-hlcdc: extract clock setup into a dedicated helper
  drm: atmel-hlcdc: add XLCDC clock bypass support for small dividers
  drm: atmel-hlcdc: add and configure LVDS PLL clock support
  drm: atmel-hlcdc: add LVDS output mode support

Ryan Wanner (1):
  drm: atmel-hlcdc: reorder timing register writes after clock setup

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 190 +++++++++++++-----
 include/linux/mfd/atmel-hlcdc.h               |   2 +
 2 files changed, 139 insertions(+), 53 deletions(-)

-- 
2.25.1

