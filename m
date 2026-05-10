Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0570ECD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 07:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB2110E038;
	Sun, 10 May 2026 07:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jze3AVKI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F054E10E038
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778396788; x=1809932788;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ma6MqiK5Y1adkgmu2dkG+5Dtp7Fm+m3/kb9sqiPxSYs=;
 b=jze3AVKIwnHwjC1mzotya3hmz7A8v/umTxNw+3itOIC7pOgB/HvPFgpJ
 zsoR7yzPIbY3+o9schDmHYPXZ/r/HHFaTFm7FrZFYOr9rdejYqYnG8W4U
 yMW8uT75FI+RQq5+JIeU/I9/o3bUenWEAgybq5jQtkvB1h6tG2oH4q9p8
 U1haB5BSonjSNEGdaswB1WWI1N0u4cnwyXKy3tJKwsWuajw2wnM81iJQu
 IHDPdOh/5wTn+qzxK5y2L3lV4n5/TeX/u9DUSqHMv6heaW3or0eLo0jyu
 shs3694W1Xi0pchR9Esriw65Xyukv4RDlk98AKalLy2qKPV+Z1LGrZG47 A==;
X-CSE-ConnectionGUID: VLOFynYxT/i9Qh91TZp60w==
X-CSE-MsgGUID: h9iOOXr7Rgm89u3HTeiXDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="66849831"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="66849831"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2026 00:06:27 -0700
X-CSE-ConnectionGUID: 8Capqt8PSbuSPm1POBBOgA==
X-CSE-MsgGUID: YpYfnVCcStKKz1ISjcj9UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="237387885"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa007.jf.intel.com with ESMTP; 10 May 2026 00:06:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id EF8BC95; Sun, 10 May 2026 09:06:23 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] drm/st7735r: simplify with spi_get_device_match_data()
Date: Sun, 10 May 2026 09:05:03 +0200
Message-ID: <20260510070620.1580324-1-andriy.shevchenko@linux.intel.com>
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
v2: used correct parameter, no tags were picked up due to that
 drivers/gpu/drm/sitronix/st7735r.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index bd763871dca0..165ebfb13006 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -248,17 +248,14 @@ static int st7735r_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
-	cfg = device_get_match_data(&spi->dev);
-	if (!cfg)
-		cfg = (void *)spi_get_device_id(spi)->driver_data;
-
 	st7735r = devm_drm_dev_alloc(dev, &st7735r_driver, struct st7735r_device, dbidev.drm);
 	if (IS_ERR(st7735r))
 		return PTR_ERR(st7735r);
 
-	dbidev = &st7735r->dbidev;
+	cfg = spi_get_device_match_data(spi);
 	st7735r->cfg = cfg;
 
+	dbidev = &st7735r->dbidev;
 	dbi = &dbidev->dbi;
 	drm = &dbidev->drm;
 
-- 
2.50.1

