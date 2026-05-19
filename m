Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3551CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C0010EBD0;
	Tue, 19 May 2026 09:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="WkNGDYFI";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEDA10EBD0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181759; x=1810717759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LJEEPChwdcM1KLq1Y/q8j56wOB4WvOPShmezx9DGSgE=;
 b=WkNGDYFId7MtXTc1DF0xoPDudT9hcWfHwI8AiSbiGJju5AEhDZJYghTP
 uolsdBaSCj1VUQqYuUYZmwY6DyyPokvFxLKzL/pDAu1JnqEd9MdTaslCa
 nY8JD3PiewJUIB9/As2Ar8D1wApsENvCV+CGzg5pp5ccIBdz9JgSY9I7t
 hiTwXkRWcIR2cS3VObgqwb2XgtGVfkotW2EYNhShxank7kBkpM+afB503
 sYbjH++VBhUZY9z6wo1tAq0iJx0TFx4phwb8097k9AQOSOutRfPcCcnEb
 rh9LU0UediWgy3gmlpKWjxZYg3Or3pxrZ01pIRgtaDH/RfqWMhA8ejgTy Q==;
X-CSE-ConnectionGUID: ELPhaqqSSbm0Etnr8wDe8w==
X-CSE-MsgGUID: ckea46Z1S+epLY2sBN5gKQ==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="57719362"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 02:02:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 02:02:11 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:02:06 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 3/8] drm: atmel-hlcdc: simplify clock divider selection with
 DIV_ROUND_CLOSEST
Date: Tue, 19 May 2026 14:31:30 +0530
Message-ID: <20260519090135.1188405-4-manikandan.m@microchip.com>
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

DIV_ROUND_CLOSEST naturally selects the nearest divider, making the
manual 10x proximity check redundant. Drop it and switch from
DIV_ROUND_UP accordingly.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 9673fbce42a7..f30138da1ed8 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -112,28 +112,16 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		mask |= ATMEL_HLCDC_CLKSEL;
 	}
 
-	div = DIV_ROUND_UP(prate, mode_rate);
+	div = DIV_ROUND_CLOSEST(prate, mode_rate);
 	if (div < 2) {
 		div = 2;
 	} else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
 		/* The divider ended up too big, try a lower base rate. */
 		cfg &= ~ATMEL_HLCDC_CLKSEL;
 		prate /= 2;
-		div = DIV_ROUND_UP(prate, mode_rate);
+		div = DIV_ROUND_CLOSEST(prate, mode_rate);
 		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
 			div = ATMEL_HLCDC_CLKDIV_MASK;
-	} else {
-		int div_low = prate / mode_rate;
-
-		if (div_low >= 2 &&
-		    (10 * (prate / div_low - mode_rate) <
-		     (mode_rate - prate / div)))
-			/*
-			 * At least 10 times better when using a higher
-			 * frequency than requested, instead of a lower.
-			 * So, go with that.
-			 */
-			div = div_low;
 	}
 
 	cfg |= ATMEL_HLCDC_CLKDIV(div);
-- 
2.25.1

