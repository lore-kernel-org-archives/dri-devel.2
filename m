Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE1DCD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C0410EBA8;
	Tue, 19 May 2026 09:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="y65uNQVM";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A3710EBA8
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181774; x=1810717774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jMsgCKlmkEe87bVAn7RqMCuhljgwv9IJFsxQpoWrUvM=;
 b=y65uNQVMZxArUuWNyGXh9duD5nwqlSlY8aW5o4nuMxhhrRT1z0EY80DQ
 4gzyChrvpCJdbXnjBDHEX3er1eZWIZXjP+1/tDOBc/EBHbe2C8T5NmtCx
 INc1tH+DRyNFv+UggP5+vQSKJBPZVvcjvk8a0Vgf+yJkaemXwOkPBF/kb
 GLSU7Ky1Ek8KwfVCi2fzrvVYuGDM/Oo3lo+167LDj6i9skIM5w5baZs6P
 0aLY3XcYWWiH7Tcf/CO+5BI/rUlGQIbxjzk03ezkuFCt+9sHwltRTQd2U
 +jaLZwBnkZHBcn5W/OdS4yf8tfyEe88eEtVRhJMDqjpnKgG7FTINH3ad/ Q==;
X-CSE-ConnectionGUID: UhwUzNcxQYenxhztrBU4xA==
X-CSE-MsgGUID: sBXINErWS3GRAFZWhBEO9Q==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="289088359"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2026 02:02:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 19 May 2026 02:02:28 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:02:23 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 6/8] drm: atmel-hlcdc: add XLCDC clock bypass support for
 small dividers
Date: Tue, 19 May 2026 14:31:33 +0530
Message-ID: <20260519090135.1188405-7-manikandan.m@microchip.com>
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

Define ATMEL_XLCDC_CLKBYP and set the clock bypass bit on XLCDC
hardware when the computed divider is less than 2, avoiding an
invalid divider value. Non-XLCDC hardware retains the existing
minimum divider clamp of 2.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 7 +++++++
 include/linux/mfd/atmel-hlcdc.h                | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 6da428361c19..f837684654ea 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -87,6 +87,13 @@ static int atmel_hlcdc_crtc_setup_clock(struct atmel_hlcdc_crtc *crtc,
 
 	div = DIV_ROUND_CLOSEST(prate, mode_rate);
 	if (div < 2) {
+		/* XLCDC: bypass divider when div < 2 */
+		if (crtc->dc->desc->is_xlcdc) {
+			*cfg  |= ATMEL_XLCDC_CLKBYP;
+			*mask |= ATMEL_XLCDC_CLKBYP;
+			return 0;
+		}
+		/* Enforce minimum divider for non-XLCDC */
 		div = 2;
 	} else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
 		/* The divider ended up too big, try a lower base rate. */
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index 8e86219293b7..1463c7db0e64 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -44,6 +44,7 @@
 #define ATMEL_XLCDC_HEO_UPDATE		BIT(3)
 
 #define ATMEL_HLCDC_CLKPOL		BIT(0)
+#define ATMEL_XLCDC_CLKBYP		BIT(1)
 #define ATMEL_HLCDC_CLKSEL		BIT(2)
 #define ATMEL_HLCDC_CLKPWMSEL		BIT(3)
 #define ATMEL_HLCDC_CGDIS(i)		BIT(8 + (i))
-- 
2.25.1

