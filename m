Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59656CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F5010F3C4;
	Fri,  8 May 2026 08:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BLMJjOLQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1EA410F3C5
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778227218; x=1809763218;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OE8H3ijUBKEBnxLexvcPvn/EU7P4vac3U5xXZ+qDkOk=;
 b=BLMJjOLQAp8URAXNoIyGy2U7ruOB8aegVPv6Q5O9D7P5ryt79jUV/ksa
 L3mmbdn0zhOWLnD48RyI0i/O6eHwUWmF4obA+riRY0+thpMsvZ9UDI/Zl
 YgBezF64cdVwXPRbmilx81J5Re40cwDLjulYnghLtEgHr2ktyzWXHAFJi
 7d7q9teYiBFyBb4pGOM9yU7AuxxkOKNV+8G9evPsgUNAQf93euJdrtrnw
 qkEBx/zxctNwim1YtFm+jbUd+p+EnoPDTjC/92cQ52ZbT9hi2J5BguBOQ
 B2DMPO4Rczqnt7thtrPR8wZQVobS5gK1TW2VAt79H23qfdgZl9dpH/Wjq w==;
X-CSE-ConnectionGUID: yjDG5Ao0ShiQw9nYc/K1lQ==
X-CSE-MsgGUID: CKvP0GwBStilhHCufhkoCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96615447"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="96615447"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 01:00:14 -0700
X-CSE-ConnectionGUID: iToquaC3RramIE8dGNL3cw==
X-CSE-MsgGUID: Zo3AteMPTBup7a24GWGMGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241706874"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2026 01:00:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 0C31098; Fri, 08 May 2026 10:00:08 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/st7735r: simplify with spi_get_device_match_data()
Date: Fri,  8 May 2026 10:00:04 +0200
Message-ID: <20260508080004.1143774-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpu/drm/sitronix/st7735r.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index bd763871dca0..e749b1ef6e09 100644
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
+	cfg = spi_get_device_match_data(&spi->dev);
 	st7735r->cfg = cfg;
 
+	dbidev = &st7735r->dbidev;
 	dbi = &dbidev->dbi;
 	drm = &dbidev->drm;
 
-- 
2.50.1

