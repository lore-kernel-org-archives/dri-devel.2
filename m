Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80164606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBe1IMRA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3408112744;
	Thu, 26 Nov 2026 21:45:29 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEE7112736
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:52 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso58416875e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729491; x=1796334291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P76Q0BIWW49mfVcn/szQiqY9bRx9gZaAhLyuvCUuy10=;
 b=jBe1IMRAvRVsaCwXTLYFHR38vrf6kTfGv0zbyoqM263Q0XM97IZTg3m+G4/U7+ix/c
 OPe/DRg9OvRsD3mleUgAVJ/In+2OtzrBPLnqnngb1VknR6BbKtVOXkhNIcx6YJyvGdzB
 Wmea6i1IvAkNNHXEIy9xOBXrGXN1cXrvXvFkED3Bv4CgkyhpjZGd+9nyHm7po8BTHr45
 y9YCQOGwaJB/CrG9otcgt7Yhe4kazcdtxgkF2xS6vRi78/VoDOnqZ+7UjUstYTrp1C04
 TaN7fhtJROayuiUSeqFGj+COEMjQ9tiRubaNHc22SuhLkTEHwkabA3J3I1wkYvFpnksI
 GCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729491; x=1796334291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P76Q0BIWW49mfVcn/szQiqY9bRx9gZaAhLyuvCUuy10=;
 b=iFqUnq4T/UhWR4FVpLA3rvwMC3Qkz7Zd+dnG+pAwd86ZLLfB42Y0nAT/Olnc+qYR+w
 GxJ5WK0s3+CWuqtijoAjsNRCOLCsbp9coqycFU21n9e/yGFL5pOeGE4XwWG9B6pbOSC+
 iXw0fegfH1RcIf7gRhcOnYbY6R5fc/RGR8vYou1iGkK0fxiayaBJYansBO5K0BDcY1Es
 1F7h1SSsikkR0Aneq0edvltBd0QzT/MarcFytbruf2hMpa/90O3U8csF3aklFi9rkC5g
 da9oGBM3+J2UZXETPAwCv1lGqt+J5vP43qNalfiPs5y6PURMr5/SPtZDnueCFXn3/o4T
 hX2g==
X-Forwarded-Encrypted: i=1;
 AL+hErHHbGNgiGU9SIe3PXUEB0Ye2XKNtzBH8R2JGehwwIKrzOCy5/RksXs9fP/2DRc/Va5wUh35Nk7XTro=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+WgIH1h4soUnByypbQ30viqzsYVWkUv5obgFyocmvip9rNtsI8
 ggXya6i5A66CDJrMqwaaG/d68OgMo1XymuveETIcqedpFUqEiNIW23ig
X-Gm-Gg: AZFdTZffnv9oZ68obrQLCxSYY7l6lWhjk4G+wYDYPZdyE24zICwgC0gdMSY7DdA9uGi
 Rhkx1PMQhmycwPkL3RGQpt4GraSYlqrwR4nWKUA2oklojyd/Ltz6DTDFyCsvY1fSYGIR1nJT8Ay
 8k8RKy7h8GayqxPg3FJpaoi8B8opro/vDca0wkemXJH7K0A60Zk1CHb+CZHuy0zIboBwNy3AasU
 B5I1t4R4Kdv8RN1l/j24iVoE276UDtNIDDhPoDqC+8hnwVK/VLVr0vcEC9cn37T2rfHKUwvRFui
 cU/W+9qWkm55dj9leleXdU4TTeMjLSVi2Lsokp7LQBiey66r/VdK1fJ9unPQV+IN5QT61Ghw6LD
 cTNqG6MSkIkAuB+QQzH2f/ndrQ3mPeJdB5OUEgd72OD2U6C4HGxx5y6mwNhLIQ2Cd26wwPowV4u
 Z7ZXbVLCZJQidot0CQai08ALrZzUdgQ+KUiqYedMCdvKmFhqyiI51YtVR4THmpSEU18SgWzZON5
 q10qP6WxKNFylsq2x4qTD7LlFnxzfWSGRfCuWGp5sfQOilCmW9cfgz7gP2ug3bGHxvTLPzheCnK
 nl5c73XKPhQi+ANuFir4A/TwFIR93lhRw1c4jHXKRxccEdYKZj2AXjXmAmRLmv3yQgkLFOgP0HD
 DPAOMtop9Ck0YP6anDW0d/fGL+M7yUGC0lnz7ZCU7yVlkq40Pu8nghRmJ0B+bZpyDL/Nw5CF2l0
 E06Tuc5KstC8aDZsYpQOKZV2P7dvl33gXnfscnhLNPTbH9UbGUFtV1l5F4Wk/vuGZ/MePuiEWGg
 6kqXkWGKK6JQ26usovm2RA6L3mwD7A0nghl6oJ4Qw==
X-Received: by 2002:a05:600c:530f:b0:4bb:68b9:f615 with SMTP id
 5b1f17b1804b1-4bb88810b22mr445462945e9.17.1795729490644; 
 Thu, 26 Nov 2026 13:44:50 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:50 -0800 (PST)
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
Subject: [PATCH 08/11] drm/sun4i: Add support for H616 HDMI PHY
Date: Thu, 26 Nov 2026 22:44:30 +0100
Message-ID: <20261126214433.3562326-9-jernej.skrabec@gmail.com>
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

H616 HDMI PHY is a standard Synopsys HDMI 2.0 TX PHY, like on H6, but it
needs its own configuration table. Values are taken from the BSP.

The BSP also sets undocumented bit 15 of MSM_CTRL at 594 MHz. 4K@60 works
fine without it, same as on H6, so it's left out.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 170 +++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 0d284804e11f..8bef4806c65b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -124,6 +124,165 @@ static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
 
+/*
+ * Values are from the BSP. Like on H6, PLL settings depend on the TMDS clock
+ * band. The BSP has its own values for CEA clocks, which also apply to
+ * their 1000/1001 variants. PLLGMPCTRL is always 3.
+ */
+static const struct dw_hdmi_mpll_config sun50i_h616_mpll_cfg[] = {
+	{
+		30666000, {
+			{ 0x00b3, 0x0003 },
+			{ 0x2153, 0x0003 },
+			{ 0x40f3, 0x0003 },
+		},
+	},
+	{
+		36800000, {
+			{ 0x00b3, 0x0003 },
+			{ 0x2153, 0x0003 },
+			{ 0x40a2, 0x0003 },
+		},
+	},
+	{
+		46000000, {
+			{ 0x00b3, 0x0003 },
+			{ 0x2142, 0x0003 },
+			{ 0x40a2, 0x0003 },
+		},
+	},
+	{
+		61333000, {
+			{ 0x0072, 0x0003 },
+			{ 0x2142, 0x0003 },
+			{ 0x40a2, 0x0003 },
+		},
+	},
+	{
+		73600000, {
+			{ 0x0072, 0x0003 },
+			{ 0x2142, 0x0003 },
+			{ 0x4061, 0x0003 },
+		},
+	},
+	{
+		92000000, {
+			{ 0x0072, 0x0003 },
+			{ 0x2145, 0x0003 },
+			{ 0x4061, 0x0003 },
+		},
+	},
+	{
+		122666000, {
+			{ 0x0051, 0x0003 },
+			{ 0x2145, 0x0003 },
+			{ 0x4061, 0x0003 },
+		},
+	},
+	{
+		147200000, {
+			{ 0x0051, 0x0003 },
+			{ 0x2145, 0x0003 },
+			{ 0x4064, 0x0003 },
+		},
+	},
+	{
+		184000000, {
+			{ 0x0051, 0x0003 },
+			{ 0x214c, 0x0003 },
+			{ 0x4064, 0x0003 },
+		},
+	},
+	{
+		226666000, {
+			{ 0x0040, 0x0003 },
+			{ 0x214c, 0x0003 },
+			{ 0x4064, 0x0003 },
+		},
+	},
+	{
+		272000000, {
+			{ 0x0040, 0x0003 },
+			{ 0x214c, 0x0003 },
+			{ 0x5a64, 0x0003 },
+		},
+	},
+	{
+		340000000, {
+			{ 0x0040, 0x0003 },
+			{ 0x3b4c, 0x0003 },
+			{ 0x5a64, 0x0003 },
+		},
+	},
+	{
+		593400000, {
+			{ 0x1a40, 0x0003 },
+			{ 0x3b4c, 0x0003 },
+			{ 0x5a64, 0x0003 },
+		},
+	},
+	{
+		594000000, {
+			{ 0x1a7c, 0x0003 },
+			{ 0x3b4c, 0x0003 },
+			{ 0x5a64, 0x0003 },
+		},
+	},
+	{
+		~0UL, {
+			{ 0x0000, 0x0000 },
+			{ 0x0000, 0x0000 },
+			{ 0x0000, 0x0000 },
+		},
+	}
+};
+
+static const struct dw_hdmi_curr_ctrl sun50i_h616_cur_ctr[] = {
+	/* pixelclk    bpp8    bpp10   bpp12 */
+	{ 26995000,  { 0x0000, 0x0000, 0x0000 }, },
+	{ 27032000,  { 0x0012, 0x0000, 0x0000 }, },
+	{ 30666000,  { 0x0000, 0x0000, 0x0000 }, },
+	{ 36800000,  { 0x0000, 0x0000, 0x0008 }, },
+	{ 46000000,  { 0x0000, 0x0008, 0x0008 }, },
+	{ 61333000,  { 0x0008, 0x0008, 0x0008 }, },
+	{ 73600000,  { 0x0008, 0x0008, 0x001b }, },
+	{ 74175000,  { 0x0008, 0x001a, 0x001b }, },
+	{ 74250000,  { 0x0013, 0x0013, 0x0013 }, },
+	{ 92000000,  { 0x0008, 0x001a, 0x001b }, },
+	{ 122666000, { 0x001b, 0x001a, 0x001b }, },
+	{ 147200000, { 0x001b, 0x001a, 0x0034 }, },
+	{ 148350000, { 0x001b, 0x0033, 0x0034 }, },
+	{ 148500000, { 0x0019, 0x0019, 0x0019 }, },
+	{ 184000000, { 0x001b, 0x0033, 0x0034 }, },
+	{ 226666000, { 0x0036, 0x0033, 0x0034 }, },
+	{ 272000000, { 0x0036, 0x0033, 0x001b }, },
+	{ 296700000, { 0x0036, 0x001b, 0x001b }, },
+	{ 297000000, { 0x0019, 0x001b, 0x0019 }, },
+	{ 340000000, { 0x0036, 0x001b, 0x001b }, },
+	{ 593400000, { 0x003f, 0x001b, 0x001b }, },
+	{ 594000000, { 0x0010, 0x001b, 0x001b }, },
+	{ ~0UL,       { 0x0000, 0x0000, 0x0000 }, }
+};
+
+static const struct dw_hdmi_phy_config sun50i_h616_phy_config[] = {
+	/*pixelclk   symbol   term   vlev*/
+	{ 26995000,  0x8009, 0x0004, 0x0232 },
+	{ 27032000,  0x8009, 0x0007, 0x02b0 },
+	{ 74175000,  0x8009, 0x0004, 0x0232 },
+	{ 74250000,  0x8019, 0x0004, 0x0290 },
+	{ 148250000, 0x8009, 0x0004, 0x0232 },
+	{ 148350000, 0x8009, 0x0004, 0x0230 },
+	{ 148500000, 0x8019, 0x0004, 0x0290 },
+	{ 218250000, 0x8009, 0x0004, 0x0230 },
+	{ 288000000, 0x8009, 0x0004, 0x0273 },
+	{ 296700000, 0x8029, 0x0004, 0x0273 },
+	{ 297000000, 0x8039, 0x0004, 0x022b },
+	{ 340000000, 0x8029, 0x0004, 0x0273 },
+	{ 593400000, 0x8039, 0x0004, 0x014a },
+	{ 594000000, 0x8029, 0x0000, 0x008a },
+	{ ~0UL,      0x0000, 0x0000, 0x0000 }
+};
+
 static void sun8i_hdmi_phy_set_polarity(struct sun8i_hdmi_phy *phy,
 					const struct drm_display_mode *mode)
 {
@@ -626,6 +785,13 @@ static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy = {
 	.phy_init = &sun50i_hdmi_phy_init_h6,
 };
 
+static const struct sun8i_hdmi_phy_variant sun50i_h616_hdmi_phy = {
+	.cur_ctr  = sun50i_h616_cur_ctr,
+	.mpll_cfg = sun50i_h616_mpll_cfg,
+	.phy_cfg  = sun50i_h616_phy_config,
+	.phy_init = &sun50i_hdmi_phy_init_h6,
+};
+
 static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-hdmi-phy",
@@ -647,6 +813,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
 		.compatible = "allwinner,sun50i-h6-hdmi-phy",
 		.data = &sun50i_h6_hdmi_phy,
 	},
+	{
+		.compatible = "allwinner,sun50i-h616-hdmi-phy",
+		.data = &sun50i_h616_hdmi_phy,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.43.0

