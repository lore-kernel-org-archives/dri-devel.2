Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38799CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8547010E509;
	Thu,  8 Oct 2026 06:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="bJrPcDPG";
	dkim-atps=neutral
X-Greylist: delayed 1267 seconds by postgrey-1.36 at gabe;
 Thu, 08 Oct 2026 06:00:03 UTC
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D859010E509
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qf8C91/YkTRnGhfkIBW7/sOYo/dvYKzyIqnJrU16xfU=; b=bJrPcDPGtxII2XFGW41gZ5lOe8
 yZA26pWprcJK+VMw0cBpu6Q/l2aaMNCDC+52aUpai61oOtMzjt7Fp//bIK/iMICXWgxmqeMs93F//
 mroakPTElf8Fx/agfVzIJYXC4yqZQieES2CaAZcprBzjQLZupdXv4qUCEm9yizpnXdXksJKN5PgHf
 iHoCFD74lcYXiuH9bSWm2amrG7mgDidJbKK+my5a6Wmn4LB6ONr1Q1jyKfZW6sEfp+XF+5/p//uKA
 YdAwy167asC6KhZpWrN8AU2DRmqXT+zMTDpiw+1IE4vrhLXBfPuzQmXRK4u/It4rOWZwezAsR5Gyl
 SjZHLS0w==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46684
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <primoz.fiser@norik.com>)
 id 1xEgqG-0000000AIc8-3Y18; Thu, 08 Oct 2026 07:38:54 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: [PATCH 2/2] ARM: dts: imx6qdl-phytec-mira: Switch LVDS panel to
 18-bit data mapping
Date: Thu,  8 Oct 2026 07:38:50 +0200
Message-Id: <20261008053850.2941955-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008053850.2941955-1-primoz.fiser@norik.com>
References: <20261008053850.2941955-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

The phyBOARD-Mira drives its LVDS panel at 18 bits per pixel. This was
previously done by always overriding fsl,data-width on the LDB bridge
alone and leaving the panel node's compatible, "auo,g104sn02", resulting
in LDB and the panel disagreeing on the format actually in use.

Now, declare the override on the panel side too, via the data-mapping
property and use "jeida-18" which resolves to RGB666_1X7X3_SPWG, exactly
matching what fsl,data-mapping = "spwg" + fsl,data-width = <18> produces
on the LDB side. Both ends of the link are now consistent instead of
silently disagreeing.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
index 8b2b4ed76328..50e5bb22b9f5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi
@@ -121,6 +121,7 @@ panel {
 		power-supply = <&reg_panel>;
 		enable-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 		backlight = <&backlight>;
+		data-mapping = "jeida-18";
 
 		port {
 			panel_in: endpoint {
@@ -204,7 +205,7 @@ &ldb {
 
 	lvds-channel@0 {
 		fsl,data-mapping = "spwg";
-		fsl,data-width = <24>;
+		fsl,data-width = <18>;
 		status = "disabled";
 
 		port@4 {
-- 
2.34.1

