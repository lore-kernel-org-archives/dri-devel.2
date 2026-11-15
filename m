Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3A606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2AHXDok
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B35E10E1FA;
	Sun, 15 Nov 2026 06:11:33 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97D710E136
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:11:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so18045765e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794723082; x=1795327882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ahJXFdL35LJt7+dj7dVWYLqD2Vs+Z841K5O8NV4NEdc=;
 b=s2AHXDokDMJMRoqCWgry3kQyYtSyMDUz02n10OyV/X7gth6YJ4tMIV1bMWmgPZuIUM
 yPkeXVuwrHIoQe9dGTcbauA4002Uv1KretKELAVMxtWqV8tQ8sw9d415g1Uom9CWaDMN
 97jUOV7cg8+gbypLls4oJuqGzU0QjAmM0omS2+POOR2q0QKJ0t9tcN5H1uZiumGDuXpU
 FOXIz6g7trh8wbICXilLpDhLsSiZqbNnF3AvdBzQeVSIDelbna8odiKV/K4FCCuuUZMO
 fV7/82U7RzJfr9gMFD62wl34zPac4Y+0aiA5DsM16Cv+vpM558eRsUOaY5Q1E48DO7Ib
 ILmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723082; x=1795327882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ahJXFdL35LJt7+dj7dVWYLqD2Vs+Z841K5O8NV4NEdc=;
 b=uFJ/TLLmN74R6ugizwhgz/mNGbEwAN8hs7fajERLQsFpjucpSOz0tZ+F43Gi3XSL/M
 Wdo1/AysikRYU90ym6I9/Q0v6C+dw4EqAcmWn13QLwNxqbzCFayddkXrbYJdnvntUB9A
 AgAyOU3zQLnuUoCsRevV5bikKJOOQrFX3do7CCsfq/e97bXg2W5gJwSutkbgq3YYI8XW
 6u/cd2cLSvpvEDgrRVTy49UBkBVru6liQUVYi7WxTOqI1UL1UNBJ2CB9p4WEcN7bOgK2
 bhCTk0laqKc7cktE2nIkdpayTxp3iAMpxnY/Kb2OJNgSF6xWtNmxAvbcKIjwdAVb1++u
 cZPg==
X-Forwarded-Encrypted: i=1;
 AL+hErHBUDxSp35XimRvrE4N9SJ+vLjb5ZaPsQDSqZJvQYN8Aa2f27UylLkHcq3yU7V0p6GneGm63BwuzYc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Lc6TZdyqtjN6h3PH9+ulghGVbuWsqYfTDosQfFALlvWaeTLDw
 e2uBpoWSk+6rTpHbqN6z+Eb+KOivo9rNiVWUr+Q0mh29y7IBgR6GcGjc
X-Gm-Gg: AYBFou2DDFMpqX47hyxzIkg8Oojp2Xng+4pdmJGDqPv31AwNl7ezsZSOnt7bh3/W5x0
 TKnMu1X2srgG0Ko3i+HYNZ9pnw3QIkp+JK7U+w19V2mOE5R8olyCnW6u8/ZO0mWEPBfiUZ10xoG
 KLgqGe68c0t1xsQ+PUGGsKRPsKhMR2ZYQKHBTaZBldEc1wfaVn5Ksiq8SvG9inWCd47E8u/K4zQ
 LzowpqerM1Hm7jvwi021BzxRBqm+HP8zAUOfkFyjrVtjG9YaFaT+tveg9ugL9MHo55+MafM54q/
 cdCuFMc8rk+ZLaJV54zOB/oJAI27zDWLa9yY+7/5vZG9upCMZ/+yrEsJuDoJDwG0vTGtMfq7KEP
 QCw2I08dkK9NIs1Xe1fhN+GtIEMe5nn15aXRBy2uqNywbiqGxab7dnXKJzu5BxgDKv6fJ2Nvt6R
 C+27H+qtT34XHd+MzGC7YnAvwkQc0Jx2rTu90Y0EG/pV3ho0PMdGcnVBOQk6LZpGrHW3IJNT1Hf
 Ze6HnJBTR9BM8Z4kQpR/l4QdGz23m7biL/6wr9JT01x/5CvKUDUNpLb1t+SvVsRKErXZAZ0mVlq
 VX/yg114WChwUF6mPs8/31ILZ+19G1ANkatN0qju/XQGYBAn0IqUuyemcZumEeFMhRPI4DfcPbj
 7vbIfJmuuBPj6LBTJmHuaMZ7Br1lbzxkLwYeVqz/Lvqh1AjJ7A0nHFkl3yymDBWZayRtZyuLXMG
 S6UBDgjQzcCTGb8M1nBklPmrAKxDyBkcPQgnnBvctalGyYO9JXZWEGv/J2rSjlGe6CN6ZuTPVrk
 hqYfXL73xwnjiADQUsExgFEm6CpNwnWkUc=
X-Received: by 2002:a05:600c:4752:b0:4a3:59c9:a754 with SMTP id
 5b1f17b1804b1-4bb55ab2b89mr152010325e9.22.1794723081993; 
 Sat, 14 Nov 2026 22:11:21 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm139331075e9.14.2026.11.14.22.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:11:21 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 sboyd@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 1/8] clk: sunxi-ng: de2: Fix Display Engine 3.3 definitions
Date: Sun, 15 Nov 2026 07:10:55 +0100
Message-ID: <20261115061102.229680-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115061102.229680-1-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
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

Positions of clocks and resets changed when version 3.3 was introduced.
However, old positions still work, just by luck.

Note that DE 3.3 actually has only one bus clock, which is shared among
all cores, even though it is named BUS_MIXER0.

Fix Display Engine 3.3 resets and clocks according vendor driver.

Fixes: be0e9a372787 ("clk: sunxi-ng: ccu: add Display Engine 3.3 (DE33) support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 39 +++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index a6cd0f988859..6ec6c0dc4c26 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -36,6 +36,13 @@ static SUNXI_CCU_GATE(wb_clk,		"wb",		"wb-div",
 static SUNXI_CCU_GATE(rot_clk,		"rot",		"rot-div",
 		      0x00, BIT(3), CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE(mixer0_h616_clk,	"mixer0",	"de",
+		      0x04, BIT(0), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(mixer1_h616_clk,	"mixer1",	"de",
+		      0x04, BIT(1), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE(wb_h616_clk,	"wb",		"de",
+		      0x04, BIT(4), CLK_SET_RATE_PARENT);
+
 static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
 		   CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de", 0x0c, 4, 4,
@@ -54,6 +61,9 @@ static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
 static SUNXI_CCU_M(rot_div_a83_clk, "rot-div", "pll-de", 0x0c, 0x0c, 4,
 		   CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE(bus_mixer0_h616_clk, "bus-mixer0", "bus-de",
+		      0x08, BIT(0), 0);
+
 static struct ccu_common *sun8i_de2_ccu_clks[] = {
 	&mixer0_clk.common,
 	&mixer1_clk.common,
@@ -74,6 +84,12 @@ static struct ccu_common *sun8i_de2_ccu_clks[] = {
 	&mixer1_div_a83_clk.common,
 	&wb_div_a83_clk.common,
 	&rot_div_a83_clk.common,
+
+	&mixer0_h616_clk.common,
+	&mixer1_h616_clk.common,
+	&wb_h616_clk.common,
+
+	&bus_mixer0_h616_clk.common
 };
 
 static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks = {
@@ -147,6 +163,17 @@ static struct clk_hw_onecell_data sun50i_a64_de2_hw_clks = {
 	.num	= CLK_NUMBER_WITH_ROT,
 };
 
+static struct clk_hw_onecell_data sun50i_h616_de33_hw_clks = {
+	.hws	= {
+		[CLK_MIXER0]		= &mixer0_h616_clk.common.hw,
+		[CLK_MIXER1]		= &mixer1_h616_clk.common.hw,
+		[CLK_WB]		= &wb_h616_clk.common.hw,
+
+		[CLK_BUS_MIXER0]	= &bus_mixer0_h616_clk.common.hw,
+	},
+	.num	= CLK_NUMBER_WITHOUT_ROT,
+};
+
 static const struct ccu_reset_map sun8i_a83t_de2_resets[] = {
 	[RST_MIXER0]	= { 0x08, BIT(0) },
 	/*
@@ -180,6 +207,12 @@ static const struct ccu_reset_map sun50i_h5_de2_resets[] = {
 	[RST_WB]	= { 0x08, BIT(2) },
 };
 
+static const struct ccu_reset_map sun50i_h616_de33_resets[] = {
+	[RST_MIXER0]	= { 0x00, BIT(0) },
+	[RST_MIXER1]	= { 0x00, BIT(1) },
+	[RST_WB]	= { 0x00, BIT(4) },
+};
+
 static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
 	.ccu_clks	= sun8i_de2_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
@@ -244,10 +277,10 @@ static const struct sunxi_ccu_desc sun50i_h616_de33_clk_desc = {
 	.ccu_clks	= sun8i_de2_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
-	.hw_clks	= &sun8i_h3_de2_hw_clks,
+	.hw_clks	= &sun50i_h616_de33_hw_clks,
 
-	.resets		= sun50i_h5_de2_resets,
-	.num_resets	= ARRAY_SIZE(sun50i_h5_de2_resets),
+	.resets		= sun50i_h616_de33_resets,
+	.num_resets	= ARRAY_SIZE(sun50i_h616_de33_resets),
 };
 
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
-- 
2.43.0

