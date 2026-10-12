Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A1BCC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF36810F56B;
	Tue, 13 Oct 2026 07:52:59 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDEF10E4F5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:25:46 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso805870f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791789945; x=1792394745; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GLPVlC+6axKfDRySa5Z7wZIL1eMBWodDTbsl5nbJ71c=;
 b=K74EH2ncIVTw0MVDJFeF4VXfCj9xFLCz+8T+ShLVhCRmebQ3ud6j9dN3sVF4h4RTWo
 XT0iWiFoxp9u30cdIxEBRYQIKH5tBcvF82h63daiPoC1qsbNQuvN6gPJL9uUKlbVUqRc
 +gZcmbAfVW0pIzxXjODBld/Hfc0aOMO/4J6kCgL9x2bNvf91U7JzGdMJPwGCiITDZieV
 Wpa7Y75H5fGclNSN23gchgDMH7+Hi33ldmFfsmlt3vSXhju8LqCOBPgYnqTUdxB7wxef
 DPapZcEYefGFPe88Oi45Cra+cnGfzSC/wKOO/KmlkoyvoRUede1Bv7rasSguvtVDxkOP
 A81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791789945; x=1792394745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GLPVlC+6axKfDRySa5Z7wZIL1eMBWodDTbsl5nbJ71c=;
 b=FO4MTfv939MiV1WpUtrQjhlVgAZrxDSth+4IvtGYkM8kbzKq6hweHsLbDaRMqEBkGh
 Czp5ZWzZ9gbsQ9dOrNGTRf9nM5tgG04UI3CIRQ2J3+Zo+tA9+gCIdtrgRTD5MTznUuvr
 CDoBq4c7daW3gzbSdHNmYkudNkLd5tE/bePyCdxLkDVeIpLKOGtzQM+4btZpnzubzoNv
 Ulw+n0mQkx+pm1XL8/C/FpYWHfiM+2vcva3kc6dAY2cDsDMMCzMYEwYnRg4FDZ1YTcor
 GEMyU+wYpBVXFQjdzTplQ8+HFgu+7BFP7cxS/vws1jDupsOVVPHHH4kAo+Q/4XXaHFne
 3qFw==
X-Gm-Message-State: AFq9FYKX+D3u0uG+ccJYnmnHUwfeLAaYXnNNbo0qMfprxEaFRICv/N4W
 U0f3nZG0VlJTKWd4UJ8KRTwmbTZUzrYN6UD2WR3RnwapEeNfcvY2hpqa
X-Gm-Gg: AYBFou1mMUp84s4P6GKdTy5gjH81WVZOV0/xJRCmkLdNWJj9OHcGeG3CxYe67pFP9HN
 8zpJIMTHF8hbT6p76eZ9joqPpCHE5zP16GQPdHMDPusfpmLW9P69v9Wu8bP909O0ORMlAxZhQiH
 ss0FexF1p0CZ+CTUMpnvVsEF/V8obrrhNdnrMuUP2M+6W+F8HemDPllbmiMqhvIcnQA87NFgB2L
 vOx6sG7QxdCIlGi2Zm0tfvEwRDJmFx6kIQQXt1Pk7KBoaBAkCzjUEPAvmtCZ94zR/7f29Ih8ELg
 OY+SbyP+SfgeacuxBNLrFLHgjAAgEM9AvfsR6Kt/UCASNZVQ0PlskTV7EYTzpeWHVAHv9M0wubJ
 aOacXe5ytIrsEvyVHJYnRIgI/aTxarpPuKT9NQIK1JM5SSvPDtjlbITkStsZMU05pOYF+og86pO
 LVlhtyKfsw6+OreFkMwg5A8hGfc1szSvOfvU5RAkwaiIuMsk8cX9NZwxbA3SyrelYNgbOkd5tQv
 asjwlZVkkb3kgQq83gB+Wasw70VNctIhSgwO3RyKmp9qLQIbPRibsvgXXNP0lTj77CaikuvawM=
X-Received: by 2002:a05:6000:29c3:b0:48d:c15c:94a5 with SMTP id
 ffacd0b85a97d-48dc15c964amr8654279f8f.14.1791789944272; 
 Mon, 12 Oct 2026 00:25:44 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aadf9bsm17523377f8f.29.2026.10.12.00.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:25:43 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Mon, 12 Oct 2026 04:25:24 -0300
Subject: [PATCH 2/3] drm/bridge: simple-bridge: Add Toradex RGB to VGA DAC
 bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-v1-apalis-imx6-enable-vga-v1-2-8905d8746504@toradex.com>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791789940; l=1350;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=FKye5mFa3sfDemE79K6SG+Q4irfMpkj0xAlYwYUAH/8=;
 b=4gNcdbAkP/ZiHikm++CidN8Fg36WinGvfqCWvKISeLt6d0w54Kss0AyxWHJbCrRJwOu2/kOcV
 8QKluP6TaXpDlREVlJEhq5mYay7oLM2OaFtIyVnaU7BXUcqtKIeCnLJ
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
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

From: Leonardo Costa <leonardo.costa@toradex.com>

The VGA bridge on Apalis iMX6 consists of a simple resistor ladder that
converts a digital 16-bit RGB signal to VGA. The VGA output is gated by
an active-low data-enable signal.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3fba7002322e..3f88fcdfa214 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -253,6 +253,10 @@ static const struct drm_bridge_timings ti_ths8135_bridge_timings = {
 	.hold_time_ps = 500,
 };
 
+static const struct drm_bridge_timings toradex_apalis_imx6_vga_dac_timings = {
+	.input_bus_flags = DRM_BUS_FLAG_DE_LOW,
+};
+
 static const struct of_device_id simple_bridge_match[] = {
 	{
 		.compatible = "dumb-vga-dac",
@@ -312,6 +316,12 @@ static const struct of_device_id simple_bridge_match[] = {
 			.timings = &ti_ths8134_bridge_timings,
 			.connector_type = DRM_MODE_CONNECTOR_VGA,
 		},
+	}, {
+		.compatible = "toradex,apalis-imx6-vga-dac",
+		.data = &(const struct simple_bridge_info) {
+			.timings = &toradex_apalis_imx6_vga_dac_timings,
+			.connector_type = DRM_MODE_CONNECTOR_VGA,
+		},
 	},
 	{},
 };

-- 
2.43.0

