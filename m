Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE669CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB0710E83D;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=embeddedlinux.blog header.i=@embeddedlinux.blog header.b="y4Lm5GqY";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6AB10E13C
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 09:05:40 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so696008a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embeddedlinux.blog; s=google; t=1790413540; x=1791018340;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=poyGQFhxfjPpwyIrTQh0fZ+JdUzuLojhwNaxF0pNYJE=;
 b=y4Lm5GqYZMLKj3kbTAmJ8/L1qddm8r3PsLr2/ml+NSp/LR3I3gqbSFFAULiZ0ZKE+U
 2l7oMAsEkAW8zpj7hd7ZU7VjlgGj854Z8t+4v++MLow4iglua9BANG9v3l8eEuH4anOt
 zLFba53rjKN8QZkyL3uUh37ASaJ1AW64Uxc5cqDWOS0/bn0IMAH3tIBjzpnaHMUAQk4O
 PgGP8u7SG9mK1Qy93QajssRfxhj8BqNriCzE9ZC2/rzIf5ljfAjoXqkqr4XU2IubOWG8
 //loNkMPd2wHe1gJInmlxVu9Aqnnh7/rouGriaXNl213q8H47ZacUV4pIacnjgx1p0AS
 xLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790413540; x=1791018340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=poyGQFhxfjPpwyIrTQh0fZ+JdUzuLojhwNaxF0pNYJE=;
 b=GDEvMb2Y8PgaYl1tLNQ681E7GNhibfdLHy6jNKpPifuelmsjUqE9v6ahEGcv/cW8Q/
 q6aEK7QkjxV4ltRUFJIstp+zeOlXQbCC35FV7VOzoLxs4DDfAheZecMyiHxekKfyO2Ev
 Kde4e6Z7o9SY8BSiAhTLu0UQN1eAVfo85OnC0VrIpstpA65TEvPzqvOuaiX0OVDNhYDd
 ns2TjhrRZflFEulOQuwN8tDkOP9cieUy+Fm1UT+eFj+JZ0Hq3Q0FYWi9wM8OEU57A8En
 QXqzF8UC0vIFhcg/NehjeW351J33TT51qWRO5Lp10Zdi+iIK0dVWL2EE1wdl7PkhROdm
 0OOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHFSrROL5NHfvuA5sl45GLLZh2f//ZZ+j7FGob6UoaVD7QZ3ULX8FgN43IzJRXvxxiFEGZwvs11Bs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLBIteWZsJioeH3V6o2ld+7wqDDrYnLuo5y66hZ3yWdKmLZ/74x
 dGSRiaKvscgbyP9JNmqeyV5w1lPde9YVMiI9Ut37pKgttzqvmMCr0Z60QTiFT+B1AqAp
X-Gm-Gg: AYBFou01oYS1AS6FeAfepmNA/GifYSBwDb65enhOHVRoEmX92R56V/E2vf17syN3WyF
 TuypiWW4WvN7rBMVQBS65ph77JiXG2gm6yOrY+Xv2IKmJXSMSRSSJt+6rsgNlAor1Z96SsMpaLV
 lj/8tShP5eh+7B8v2gK6WPERZpCLrBlXOwSFm4ZEhjHMmAcd4ZVikvnzDeMoMYckIsWlpahZYDd
 3TpwaUIOHm8ztO/jsEPG5zqlAgEArJ/bcBAwcAOYWSIOqkAgzSxMdJlrYuhOSkyRX1sn59EHgpz
 cAQXbEYTt0AVhfneec23a3p2EpsW3UcjFlDzTL8jmyqEEJTdBZATyrpa+7Exo0HSsrPmn/TUSwl
 xKJs4nuFu0pbx/DeDEeN0FyOlZFx25ebJ2o3z1+WO2CFUqpHfcyl1hAWxyo0RYyjRAV+IhdYN87
 hIh9xz8ljwN7Phe+RhTZVB6ys9LNHAbVxfXPtJu3NZiPJCe1d/8r4e11ovcd98TcT6kg==
X-Received: by 2002:a17:90b:3b90:b0:3a0:cbe2:9e00 with SMTP id
 98e67ed59e1d1-3a0cbe2a110mr2426179a91.42.1790413539584; 
 Sat, 26 Sep 2026 02:05:39 -0700 (PDT)
Received: from ltu.. ([171.245.4.151]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc787959599sm2299078a12.26.2026.09.26.02.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 02:05:39 -0700 (PDT)
From: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, tien.nguyenminh@embeddedlinux.blog
Subject: [PATCH] drm/sun4i: dsi: Get the A100 mod clock at bind time
Date: Sat, 26 Sep 2026 16:05:32 +0700
Message-Id: <20260926090532.126025-1-tien.nguyenminh@embeddedlinux.blog>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

The A100 variant gets its module clock from the TCON TOP, which only
registers its clocks when it is bound. Requesting the clock in probe
defers the DSI forever, so the display never comes up on the D1 and
T113, which use this variant:

  sun6i-mipi-dsi 5450000.dsi: Couldn't get the DSI mod clock

Request the clock at bind time instead, as the TCON driver does.

Tested on a T113-S3 with a DSI panel.

Fixes: 4b71e269f5a5 ("drm/sun4i: dsi: Add the A100 variant")
Signed-off-by: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d504ae583..69987bb5b 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1062,6 +1062,17 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 	int ret;
 
+	/*
+	 * This module clock comes from the TCON TOP, which registers it only
+	 * when it is bound, so it cannot be requested in probe.
+	 */
+	if (dsi->variant->has_mod_clk && !dsi->variant->set_mod_clk) {
+		dsi->mod_clk = devm_clk_get(dev, "mod");
+		if (IS_ERR(dsi->mod_clk))
+			return dev_err_probe(dev, PTR_ERR(dsi->mod_clk),
+					     "Couldn't get the DSI mod clock\n");
+	}
+
 	drm_encoder_helper_add(&dsi->encoder,
 			       &sun6i_dsi_enc_helper_funcs);
 	ret = drm_encoder_init(drm, &dsi->encoder, &sun6i_dsi_enc_funcs,
@@ -1160,7 +1171,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (variant->has_mod_clk) {
+	if (variant->has_mod_clk && variant->set_mod_clk) {
 		dsi->mod_clk = devm_clk_get(dev, "mod");
 		if (IS_ERR(dsi->mod_clk)) {
 			dev_err(dev, "Couldn't get the DSI mod clock\n");
-- 
2.34.1

