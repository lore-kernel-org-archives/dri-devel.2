Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446F3CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA1E10EBD1;
	Tue, 19 May 2026 09:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="qnYyWbnt";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FCD610EBD1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181764; x=1810717764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GN9Elk55Ckw9oiHQjukAbkq2ymh10RJ8TnEXN6zUYIA=;
 b=qnYyWbntEyyINWPElwGMgCaxLHZHZaHcF0JdqOAZDfbpFDqwHKO+A/Q5
 5VO1Hv8IGXTFPjrMjN04e41svl0XIiTW65C7vIej4QDs3xTkyNOKEnJ3t
 LtTzJpSGjdECqaANuADZs3Lo4pbZ5h2sOe3sYwE1G1RrEhLMpQ6Wc3FBD
 2mFjalFLCGB2yoKo8GNdTnCMsBmEqtJupmw/LF12lUY3/EFdwwQOYUxav
 tIvbRxZ9XOHJkG4n2y1/2dpjXi9tk1VT6kY6HhYr2R1w2ilH9QdUaegXl
 JpJnNb3Xh7bpNdQ3fXZ6eCZpOzwJd3IMnkYD8ZvEYNb+Q45mrOkZcfSGS Q==;
X-CSE-ConnectionGUID: cRB7afV+QCu/Kd7rCmC/lA==
X-CSE-MsgGUID: VBVl8s9QTi+FiNqzdZOfJg==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="224955560"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2026 02:02:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 19 May 2026 02:02:17 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:02:12 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 4/8] drm: atmel-hlcdc: define ATMEL_HLCDC_CLKDIV_MAX and fix
 divider fallback
Date: Tue, 19 May 2026 14:31:31 +0530
Message-ID: <20260519090135.1188405-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519090135.1188405-1-manikandan.m@microchip.com>
References: <20260519090135.1188405-1-manikandan.m@microchip.com>
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

Introduce ATMEL_HLCDC_CLKDIV_MAX to replace the raw mask.In the divider
overflow fallback, restrict the clock source switch and halved rate
retry to SoCs that support the 2x system clock path.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 9 +++++----
 include/linux/mfd/atmel-hlcdc.h                | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index f30138da1ed8..c7e77bb2941a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -117,11 +117,12 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		div = 2;
 	} else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
 		/* The divider ended up too big, try a lower base rate. */
-		cfg &= ~ATMEL_HLCDC_CLKSEL;
-		prate /= 2;
-		div = DIV_ROUND_CLOSEST(prate, mode_rate);
+		if (!crtc->dc->desc->fixed_clksrc) {
+			cfg &= ~ATMEL_HLCDC_CLKSEL;
+			div = DIV_ROUND_CLOSEST(prate >> 1, mode_rate);
+		}
 		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
-			div = ATMEL_HLCDC_CLKDIV_MASK;
+			div = ATMEL_HLCDC_CLKDIV_MAX;
 	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index 07c2081867fd..8e86219293b7 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -50,6 +50,7 @@
 #define ATMEL_HLCDC_CLKDIV_SHFT		16
 #define ATMEL_HLCDC_CLKDIV_MASK		GENMASK(23, 16)
 #define ATMEL_HLCDC_CLKDIV(div)		((div - 2) << ATMEL_HLCDC_CLKDIV_SHFT)
+#define ATMEL_HLCDC_CLKDIV_MAX		((ATMEL_HLCDC_CLKDIV_MASK >> ATMEL_HLCDC_CLKDIV_SHFT) + 2)
 
 #define ATMEL_HLCDC_PIXEL_CLK		BIT(0)
 #define ATMEL_HLCDC_SYNC		BIT(1)
-- 
2.25.1

