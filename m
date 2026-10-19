Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD12606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WbiJZUPp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B88010F303;
	Tue, 20 Oct 2026 07:36:38 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D6410E987
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:20:42 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-15354aa70e8so646114c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792405242; x=1793010042; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wG/mmn2fERUKjshAXPMhmIVjTkfUkF1Vhr38NpDvKtE=;
 b=WbiJZUPp5Wu4HyySswoY4rJ698IW3GSjT7tCIDM/nfhRT+Gt65Q4S8uvufO8EqWJLA
 YZS3FsKah3fboLI1oG2tuhe8kLzf9l1iegO1aPQAQ7EuGMMhFgFfL/pt7G1epyaZYpsy
 F4XoHwfts4VPf88JUSqhj/VNvPaztUcn2Dh+Qcl4vOvWEFN8lGlTsOhtJO0sHAYRjqm0
 fXY+1zcIVZhNu+BjCnCm/AokL+8eSvUN3dfVfO3SH5chLCkYl0CwUHY7r+rOFQrgHNjT
 HJk+FOyhxL2Y2t+3Wj1v/+6dbmVv+D9tfRGqw8GB8xy9kFGJf6+p4vEaJo6+A92CD1MO
 5plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405242; x=1793010042;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wG/mmn2fERUKjshAXPMhmIVjTkfUkF1Vhr38NpDvKtE=;
 b=WTIcYr3x1rxvLcr15AefeydF/SHRKX4ELm9Zbs2QSWSYR5aU4Goo0mWu2MYRQCD/PF
 Lqij1GcV8NVlW7NLg4rKBHzOfE6ngeDS8uDZDNDMYvfB+DPu/BquIMBFttawqRMVR7JV
 D/iKStIslJyeo5YXZlAhLhlKTaYMGlB0um3MZj5UoUAA02lj5rTtxlLtDK5fhytiZqnL
 IZbIO+xc7sieN9NXFY9PBioimYrBNAR7NuA4xXkjp/WH1LWFtJZG3bH/v1Wi2pHgXQyZ
 mBXlDubXJXy2OokAbjtmws3frfMFSjAOvXLjt+hsYSeQP3r+QCSPxJ90Sz6DMYMva3dq
 qsJQ==
X-Gm-Message-State: AFq9FYJ5muZC+ywmQ/cP18TrG8VxPWIFV0TOAgO51b+ZVoKDe87ZRa31
 9SJN5HlyrjT2AwSLSfeiDzuxt11hKFY+AGhtY1VYk7f8tHYdxcCtc8M2
X-Gm-Gg: AYBFou3Q+F0w5iQgyGBQkM/fQS6sJursMM4S8EdXBQ+ZLW2awrsUZ27lUDTessSKw5u
 hWMIy4OLVRWdn5gQa1MXYnMy7+VHEoO+Gs1ZCXJlqAvCRDfD3Nkz9g4ZPOo5aBLyWYP/oRKvr2J
 MSmaVdCTsMiEj8eM5QBVlsp3oE1mCaV3f27JuadsCsf4baiZ8cLjTjt756kWBGBpHm0ZN4QnVse
 bMogfqtbIRidi+l4AGx0X6Z1u+9Buhtx1sahgopwIrIL3C5kiMA6X9mN/xgWA2QuifZd/1+/fOd
 v8IKNE0xFnqp5gwYxk0PhiTYB7QIjlCyRjEOjC90i+9cfaglWM7x6gqRIghmGRXstwbP7bZ64u1
 JVx7BqXWOPNX/onI2ZlYsieHjRcIAdW4RPfR4F/uhodN6KGYPFODlxmyi8BPcZkXfwacyfQo4uD
 ugyXNLAFJXtgo4E7u3mj6oQlNM8hVix54o6WJvcawXqxFSavSPv1CfnAgPwnqgNswJpUdalOXLl
 CwMPL5130hZ1w==
X-Received: by 2002:a05:701b:424d:10b0:13b:4ab5:41d7 with SMTP id
 a92af1059eb24-1850c9cf427mr12119481c88.3.1792405241814; 
 Mon, 19 Oct 2026 03:20:41 -0700 (PDT)
Received: from [127.0.1.1] ([67.159.246.222]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18319d3b880sm26324251c88.10.2026.10.19.03.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:20:41 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Mon, 19 Oct 2026 07:17:15 -0300
Subject: [PATCH v2 2/3] drm/bridge: simple-bridge: Support
 data-enable-active endpoint property
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-v2-apalis-imx6-enable-vga-v2-2-ef6a3a780472@toradex.com>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792405217; l=2075;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=/IjtTShiJA+F9KmNWlJJNMy2lTKWTky2io3jmPVXXVA=;
 b=wT8coFssfadnbio6KHmF1yBAZdfjcW8j5Ftd+0jWUjv7dcyReSTM5NiEs8ga+Dm7iSM19YUzq
 JsnS98IOb0zBMI8LksAaaJsn7t3ABSIdTS+heHkDqYkDHVufmMApZIH
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Leonardo Costa <leonardo.costa@toradex.com>

Some simple bridges, such as a resistor ladder DAC, may include a
data-enable input that must be driven at a specific polarity.

Read the data-enable-active property from the input endpoint and fill
the bridge's input bus flags accordingly, so the upstream encoder drives
DE with the required polarity. The property is applied only if the
bridge doesn't provide its own timings struct.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 848c2df2a276..c5301295658a 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -183,6 +183,9 @@ static int simple_bridge_probe(struct platform_device *pdev)
 {
 	struct simple_bridge *sbridge;
 	struct device_node *remote;
+	struct device_node *ep;
+	bool de_present;
+	u32 de;
 
 	sbridge = devm_drm_bridge_alloc(&pdev->dev, struct simple_bridge,
 					bridge, &simple_bridge_bridge_funcs);
@@ -220,10 +223,26 @@ static int simple_bridge_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(sbridge->enable),
 				     "Unable to retrieve enable GPIO\n");
 
-	/* Register the bridge. */
 	sbridge->bridge.of_node = pdev->dev.of_node;
 	sbridge->bridge.timings = sbridge->info->timings;
 
+	ep = of_graph_get_endpoint_by_regs(pdev->dev.of_node, 0, -1);
+	de_present = !of_property_read_u32(ep, "data-enable-active", &de);
+	of_node_put(ep);
+
+	if (de_present && !sbridge->bridge.timings) {
+		struct drm_bridge_timings *timings;
+
+		timings = devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
+		if (!timings)
+			return -ENOMEM;
+
+		timings->input_bus_flags = de ? DRM_BUS_FLAG_DE_HIGH :
+						DRM_BUS_FLAG_DE_LOW;
+		sbridge->bridge.timings = timings;
+	}
+
+	/* Register the bridge. */
 	return devm_drm_bridge_add(&pdev->dev, &sbridge->bridge);
 }
 

-- 
2.43.0

