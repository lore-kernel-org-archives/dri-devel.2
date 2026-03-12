Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB9F106ACEE
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82BC10EABA;
	Thu, 12 Mar 2026 21:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gLmawbAp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AC410EABB
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oqd8HZi+HxaOGflrTeM1m3G5zTaoxIj1mUEYV1MWONo=; b=gLmawbApk198YsomGmtRS2eegN
 1yvUTsBhRFUFXwmXuFJ84kleptxFbHTGZPE65jLpCO73tkvlsYoVa9OyiERFga8LhHR6Rs6A7wAxN
 9D5ZSx/arcpcEccIseFS1OEVeM59nkLpBKaf8PKD6qoMK/GjavtmeyLjfjLhA7h0a76wueTyNvke9
 zuzSvhDyIYSAR3i8FrL3AsqM19aw20mQ74yKF3bp3VAAkz1mwPrT4sYcCkzWjVTFEE6FvzTARy4/X
 sti0BCCkew+T+jo8+FW+E+TUQhrPv97iV4t4+z/yvNDUMLqnFAXF1QEgU6wo0ojKidl/819NFUk2l
 3+3vFCUA==;
Received: from [189.7.87.203] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0ngN-00ElyQ-J8; Thu, 12 Mar 2026 22:35:03 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 12 Mar 2026 18:34:25 -0300
Subject: [PATCH v7 3/5] drm/v3d: Use
 devm_reset_control_get_optional_exclusive()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260312-v3d-power-management-v7-3-9f006a1d4c55@igalia.com>
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
In-Reply-To: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Chema Casanova <jmcasanova@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=QYf1172liej2XL7isBXvEMxF0U/ApewKMBtjMqI+t5c=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpszFrXxuz/KAdsgCKDjMmNPTiUXkkcIwBb1sPz
 /40yrDKDbqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCabMxawAKCRA/8w6Kdoj6
 qu8lB/wJD/H82jpm00SZA2LZnwkPJ0N3aci08jeC7+nJy9BKCICdLlOJ3XnPQrfb2b9R+j6TlC2
 3ii+cFuL9ea19at2Or2WivC48m16XySXqoZ1+XdcWqzX/8mwd41s9i1fjpJjOPutDgebcBHtpVr
 8MnN3t8juosXXJE/J60YM3oAfBV3Xb5u1TXRP226nMp2D/4J9D1JVs/D70COiws2ADaQXqEzbnT
 CqqaSUOcTh6ZLXym9kKemhGpQ0cX5PqNXml6Bhg+9WaW/XBpwlhLPwsE+lAOzvt39y6JGUbTnYa
 37xBmqs3U2b3BmKOv/YXRf5clmbGUFdIXccIpfDgC1Io1y0V
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Simplify optional reset handling by using the function
devm_reset_control_get_optional_exclusive().

Reviewed-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index dd60acdf52c2b2e44c6150f11678b291ab1f6df4..153eb1c6f535de8bda83b58fad8acb2dc612f677 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -398,18 +398,17 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 
 	v3d_perfmon_init(v3d);
 
-	v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
+	v3d->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(v3d->reset)) {
-		ret = PTR_ERR(v3d->reset);
+		ret = dev_err_probe(dev, PTR_ERR(v3d->reset),
+				    "Failed to get reset control\n");
+		goto clk_disable;
+	}
 
-		if (ret == -EPROBE_DEFER)
-			goto clk_disable;
-
-		v3d->reset = NULL;
+	if (!v3d->reset) {
 		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
 		if (ret) {
-			dev_err(dev,
-				"Failed to get reset control or bridge regs\n");
+			dev_err(dev, "Failed to get bridge registers\n");
 			goto clk_disable;
 		}
 	}

-- 
2.53.0

