Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9607ECD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39AA10EBCF;
	Tue, 19 May 2026 09:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="LxiHiiRW";
	dkim-atps=neutral
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Tue, 19 May 2026 09:09:08 UTC
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDE510EBC8
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181748; x=1810717748;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rhtk3UHiok35VYYKD9BOmc0uxi7SU8cweGiDLJAn7QA=;
 b=LxiHiiRWr1oyzKOQuZdtuebzho8v4UWH5tFseE6ipeZaDIbe/v8Ue1WA
 mEGz7hUd/aHMfHQNcNZMS5OuqqDNWeRhYVbdwEeAgE2cLE8F8Tyv6k8y9
 Pd7urmZILopI5H6IUABudoUifatzsu6kuM9oJa+pyUAsuIgL0JGVWKx39
 cTEsXN+Fxj7wv+eVaT5LPr5uMXH6NLXjFIk73/UiD9z0m+ElaUdZm4bAp
 sSrIDWvrlr7CoiMVG+U3UZn3G3EshPt7p4J8HRzzP/nDH7uxLlY6KgxoT
 vxXgjlf3AZS4rfmBxswScMPU2OsVlwHk5Hrvs0Re7KMPUnbNMPlHKuzFK w==;
X-CSE-ConnectionGUID: b7vQNrk0SQqFRm/UpQcq5g==
X-CSE-MsgGUID: mUtGWRVxSuePW+9W86cFUQ==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="224955533"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2026 02:02:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 19 May 2026 02:02:00 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:01:56 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 1/8] drm: atmel-hlcdc: Fix off-by-one in vertical back porch
 setting
Date: Tue, 19 May 2026 14:31:28 +0530
Message-ID: <20260519090135.1188405-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519090135.1188405-1-manikandan.m@microchip.com>
References: <20260519090135.1188405-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
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

The vertical back porch field in ATMEL_HLCDC_CFG(2) was programmed
without subtracting 1, unlike the other timing parameters which follow
the controller’s (value - 1) encoding requirement.
This results in an off-by-one error in the vertical back porch timing.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 9dbac2def333..7932d666e9ec 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -115,7 +115,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		     (vm.hsync_len - 1) | ((vm.vsync_len - 1) << 16));
 
 	regmap_write(regmap, ATMEL_HLCDC_CFG(2),
-		     (vm.vfront_porch - 1) | (vm.vback_porch << 16));
+		     (vm.vfront_porch - 1) | ((vm.vback_porch - 1) << 16));
 
 	regmap_write(regmap, ATMEL_HLCDC_CFG(3),
 		     (vm.hfront_porch - 1) | ((vm.hback_porch - 1) << 16));
-- 
2.25.1

