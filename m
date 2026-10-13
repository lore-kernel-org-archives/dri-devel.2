Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5CBCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AF510E8C9;
	Tue, 13 Oct 2026 16:38:03 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1504910E823
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791909483; x=1823445483;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=+u2grcbCdhxCd975l0htRzcuvftDxE2QAvyE3v3OQ9Y=;
 b=BM7PBBQtKcZ4gLOkHrMrXy7Ivc0QeTXxXgyKUeNfeIvnMo1B1+tGzsYr
 MC3TH7JHZrIkrR5/e+uy3J0hR8V1PFVsSkgGumZDzOSB9ALINRutYNRVU
 jE1vSuV2vWkITxwszcLRE598q32rQXgoJB9QQcES1g9/n+bl4tVTbZYel
 0cP92Ms1Akjk99vokS6YNEgvMsA8e3Scw9xWOF47itXCGf4OfHQe8X1u8
 wL2s7FjnyfhCWvXT0nSF2PEqXCHj/o6dAnR+yAFOv0WAaX00c6mcp3FmL
 oZrOylo4wS6M7fJyZLNSSeNEdbUIi+J9prG7KLQueCaUbhSG3LCv4Kh13 g==;
X-CSE-ConnectionGUID: iemulpAURH6sc6gEF2PvMg==
X-CSE-MsgGUID: naGB6ideTLm0McSAMAm0nQ==
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; d="scan'208";a="232062271"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Oct 2026 09:38:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 09:37:56 -0700
Received: from ROU-LL-M19942.mpu32.int (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 09:37:52 -0700
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Date: Tue, 13 Oct 2026 18:37:25 +0200
Subject: [PATCH v11 3/5] ARM: dts: microchip: sam9x60: Add GFX2D GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261013-cpitchen-mainline_gfx2d-v11-3-7527f2efab0a@microchip.com>
References: <20261013-cpitchen-mainline_gfx2d-v11-0-7527f2efab0a@microchip.com>
In-Reply-To: <20261013-cpitchen-mainline_gfx2d-v11-0-7527f2efab0a@microchip.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Russell King <linux@armlinux.org.uk>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, Manikandan Muralidharan
 <manikandan.m@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=cyrille.pitchen@microchip.com; h=from:subject:message-id;
 bh=+u2grcbCdhxCd975l0htRzcuvftDxE2QAvyE3v3OQ9Y=;
 b=owGbwMvMwCXmf6yzKqEsVIbxtFoSQ9a5uEDTM7OtudtyTLl45myem7no7b6z0nbzJx3yL7p/9
 Fod99lvHaUsDGJcDLJiiiyH3mztzTz+6rHdK1EpmDmsTCBDGLg4BWAi2x4yMtzUr/nJcrBg3cGI
 KaIW1YqN/b/jyn3uNNooCdj9ur1UkYfhr0xRn3ZFvGhNkOP2GvGJbNbmG4U3+zd+aaoo2OibZ/u
 KEQA=
X-Developer-Key: i=cyrille.pitchen@microchip.com; a=openpgp;
 fpr=7A21115D7D6026585D0E183E0EF12AA1BFAC073D
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

Add support for the GFX2D GPU.

Reviewed-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index e708b3df4ccd..1155f4f997f8 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -351,6 +351,14 @@ AT91_XDMAC_DT_PERID(26))>,
 				status = "disabled";
 			};
 
+			gpu: gpu@f0018000 {
+				compatible = "microchip,sam9x60-gfx2d";
+				reg = <0xf0018000 0x100>;
+				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>;
+				status = "disabled";
+			};
+
 			i2s: i2s@f001c000 {
 				compatible = "microchip,sam9x60-i2smcc";
 				reg = <0xf001c000 0x100>;

-- 
2.53.0

