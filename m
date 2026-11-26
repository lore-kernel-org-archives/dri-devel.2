Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A5606A6B3
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aowT0JbG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DBE11273B;
	Thu, 26 Nov 2026 21:44:53 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAAA11273A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:45 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so4677416f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729483; x=1796334283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rthem334wkm2a7wmTCRGlWmB/Wf3+iH9fn3pLKOROFg=;
 b=aowT0JbGhviwgc++K/E9BLQZW/V9U8M88ViDf1DfDxQNLg/4T35viZL8piAM3Pwk8B
 OlXT6sSSclLGE8/WPRI2ramNaLyIgSau+D9/+wfIFJgVIUpWzVtl9PjKWlVmJe6/GmDv
 3NPHQAYFmWONkxXjYi80dsACUa8cVhd7qxWdEtYG2VVTXsm3bFDBlJdghCoQ/7Pn5l6G
 uBjEnoOCaX5S+qqf+oUaVbuRrswl7Q50q7ya/9NqOoF1m1DQ74TI5OSGejXlNuQMSODW
 l67XVqd6crVPxXE3I+MZHB9v7ENX25zvQ8FF2dv8T7JISfkPjGpQko4XzO+Q4buHsDbG
 jscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729483; x=1796334283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rthem334wkm2a7wmTCRGlWmB/Wf3+iH9fn3pLKOROFg=;
 b=z6aTo12KizACWVUb1mXVOdydYaESJeVimaRoeEbyIXsLykHZ9iYX8PV7qOXGFmnY23
 yGO8uAE1LtXtux/506LOEKuqG6vhiSHZdwgJgNNGW8Wygckflz5l6TbubIIM0QYsW3kl
 cRt9oLeDotonA6Ji1zcgL8md4IwcgsDTlJ7Ej+i1rtHWXMtjpgvjOBbvG3FsT1mvELeL
 Cw8rPfI3MyL9x1lirIckulQFR/4J8XNOod5C6RPJXX2v8XyWkWD36Y9ZhWOKUfS/+TYV
 cSwa4bw45YoWiVx04QbG6jXd4XuzPC2p7H680Vz0jXPcBymzclWrx7MnZTu354JUTKK2
 oAIg==
X-Forwarded-Encrypted: i=1;
 AL+hErH7bWaLkrcuBfdu0PmR/YGhByBCsfs/iudUYGn3Lo6Iou7X4lhqoGZEf93PnTndKHQVTei8pvdRB3M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ONgD0Fw5/aCoy7DKBv1RXqH0/PP9EYVqX6g+Sf77t402EM/xi
 DHvch1/4UqePVW98bnx+usqP/DEbROliuMQxjnvR9tVpDQ5piMvaFFwt
X-Gm-Gg: AZFdTZdsdVBoRjxJYprX+C0oYV11nKGy8JbPzmJrR67pNtzTloNtCh6NqPtbGDj8YRv
 f6Qq2go8bWr9yTXwEMm/EhKEH2VzF3dKPxAKyije8T7R95EdgBc4TnJK/c3i+jiQDfGDDOWuXXc
 Nkou4moItBGg0gWTkH0ryPVHv0paRJbLezaZBUlYVlvpg16jLLavGZFi259GJKyfu73bWQPf+LX
 3JEV5B/ThGuyJz5Ldvsi2xKHNS5LL37SrpzfdbBMbqF+eeM+Z0unR8YNJOS+CXouaRgPSgUNdDi
 DI72FM2WMK2FZp7Lf9dFLgjuC44W+fRqhiViekjrsuSZ8OiSVQrfJ7B0JeFvz1eRm3zsAYzyc5C
 qHziRG264igvbV39UUdANyPi0t2jalpsLDDT1k5QMnnivY+uDyFjcR19rVMHEnknTeZ8AG8CeQr
 3aZEdKGB8CMZU0ZLslPWS9RE1keusQZSKpNMLK1bYjBb9AkExnXC4hW86/uiGNm2UEE8ZMn4qny
 sfjhmWiZoPpDMOtl6Tvkc9uoqLobsnhMOEh6aDD9aZR3dY90/stzd2p0xhlFvcTH+z0nxC48vv8
 qiZlMfP4+DffPIvQxl0R/FeyY62CE5Hsx34msOsW3MyIyRgfdXXKXJvwyzgpNnCt7mxzI/pdZV3
 PrHI0cYQ+hwrJBq4Wvb8GYBN3mGA+6hpS/SsEaPZJ3McgQOXhykb3/a2igOsbJAoqMZ/HdUDHQk
 Dn/EoJr5IkTKJCSNClpGLWHyuwUF+1/vbXwuJl2N26GJ9rH7zEV6qo8d9bPJ+T3zWGshr3DzRK7
 91Bf8AazvCDhlmpLX8Ta6f8bxn/7dvhx8AWYZaZBg==
X-Received: by 2002:a05:600c:5303:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4bb88785d24mr434400835e9.0.1795729483289; 
 Thu, 26 Nov 2026 13:44:43 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:42 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 jernej.skrabec@gmail.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] drm/sun4i: Add support for H616 TCON TOP
Date: Thu, 26 Nov 2026 22:44:25 +0100
Message-ID: <20261126214433.3562326-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
References: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TCON TOP in H616 is similar to R40, with the exception of missing DSI
and a different position of the TCON TV1 clock gate, which sits right
after the TCON TV0 gate (bit 21 instead of bit 24).

Make the TCON TV1 gate position a quirk and add support for H616.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 13 ++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 86e1e8fed03a..5ea55a2844a7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -18,6 +18,7 @@
 struct sun8i_tcon_top_quirks {
 	bool has_tcon_tv1;
 	bool has_dsi;
+	u8 tcon_tv1_gate;
 };
 
 static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
@@ -246,7 +247,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		clk_data->hws[CLK_TCON_TOP_TV1] =
 			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
 						     &tcon_top->reg_lock,
-						     TCON_TOP_TCON_TV1_GATE, i++);
+						     quirks->tcon_tv1_gate, i++);
 
 	if (quirks->has_dsi)
 		clk_data->hws[CLK_TCON_TOP_DSI] =
@@ -314,6 +315,7 @@ static void sun8i_tcon_top_remove(struct platform_device *pdev)
 static const struct sun8i_tcon_top_quirks sun8i_r40_tcon_top_quirks = {
 	.has_tcon_tv1	= true,
 	.has_dsi	= true,
+	.tcon_tv1_gate	= TCON_TOP_R40_TCON_TV1_GATE,
 };
 
 static const struct sun8i_tcon_top_quirks sun20i_d1_tcon_top_quirks = {
@@ -324,6 +326,11 @@ static const struct sun8i_tcon_top_quirks sun50i_h6_tcon_top_quirks = {
 	/* Nothing special */
 };
 
+static const struct sun8i_tcon_top_quirks sun50i_h616_tcon_top_quirks = {
+	.has_tcon_tv1	= true,
+	.tcon_tv1_gate	= TCON_TOP_H616_TCON_TV1_GATE,
+};
+
 /* sun4i_drv uses this list to check if a device node is a TCON TOP */
 const struct of_device_id sun8i_tcon_top_of_table[] = {
 	{
@@ -338,6 +345,10 @@ const struct of_device_id sun8i_tcon_top_of_table[] = {
 		.compatible = "allwinner,sun50i-h6-tcon-top",
 		.data = &sun50i_h6_tcon_top_quirks
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-tcon-top",
+		.data = &sun50i_h616_tcon_top_quirks
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
index 2b887470a49f..e775737e69ae 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
@@ -21,7 +21,8 @@
 
 #define TCON_TOP_GATE_SRC_REG		0x20
 #define TCON_TOP_HDMI_SRC_MSK			GENMASK(29, 28)
-#define TCON_TOP_TCON_TV1_GATE			24
+#define TCON_TOP_R40_TCON_TV1_GATE		24
+#define TCON_TOP_H616_TCON_TV1_GATE		21
 #define TCON_TOP_TCON_TV0_GATE			20
 #define TCON_TOP_TCON_DSI_GATE			16
 
-- 
2.43.0

