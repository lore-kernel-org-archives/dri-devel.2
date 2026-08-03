Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C72C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8979210E70A;
	Mon,  3 Aug 2026 16:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ox2ZmVzP";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968DE10E70A
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:22 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so20194135e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773481; x=1786378281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=65tLrBmDcrjX0P/kWTBoZe536eu486JrEmAUPZ6dfSY=;
 b=Ox2ZmVzPR3EpD75JYoF5O7/K/rW9iGyQsjjVD9Hxcu5JkiTGj4mOYeJBpcVZ5idBl6
 7M7SCUlPy8nheNz5V+ycPjxj5cNSRlVLZfpoWODs7pCawEILdMvqJNNesR4Lwy4uwr7/
 6RLNTB7d3gfDNhuEseR3FR2sLppZHUfnhdjF9KyiNpYtA4zbp2kIPRGzyADfmCL5frne
 edFqVGE2MlR0F8yYTqHuBUE6Z+403d4vmEvX8I1Ikzb0zrl38sFUNH6p9L/hdtonmAvB
 u2Eyq7glCne+MzC6q/idC0B+ZHdNpyCBnDBQnZoCZSwwrrNNeJ/Wk6KMsX6QE4BuXLv+
 f3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773481; x=1786378281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=65tLrBmDcrjX0P/kWTBoZe536eu486JrEmAUPZ6dfSY=;
 b=Ap7AWpzyBcGdUVxi3a7Zo2hmFLInllCgUec7U9JszAFrj9wgASmYdvy+ehT+f7gCWw
 imq4jgUJQYFWlEcNpqiIPUVyIPoGfsEtMpqOWa3QTTsXHdndygroQZPOyjkfsSGa6AA2
 hHAzUf2pu0PoijM9A58vexhbO4vrmiSMrxbVm9fcD5fra6RNzMVmEi9MFPE90q2BGtzx
 DzIJjnQLZKjA5AbFtQ0tDidetrTgmAnJabKvwH92dD3BK1UbptcKZiKfpUGdi5HjWjzP
 10UiAgD48de/FiT4wByWBL5yb2Qt8NbHukmA4qYLsfWNB1j9eY09M2iRJ/PVx3+tXYdt
 iCzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYysqG5Rr1F1/9BOjGEOC3Y9wwFMyLmXl8yNhMEiu23O9hMup+al71UDPI+vfu2Ia9thkkiI65aow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiA6cYFpu1hB1QEdj+aZpQGueFoD8P3038kWZf6qgrNAsHqXnN
 k+esMKPiQB6ghzMfX/W0AcWWUyTpE+TOMIjX/3NO22AB0YDlfTewlTcX
X-Gm-Gg: AR+sD10v2xi6NKhU6n1Ou33PNfTeM1iK+JYpRn+kxlJgMTabShJB97AKCKJoZsdqdoi
 DCT9gvXgr4Sxe18cmnh1lBTthawqTT4phLvGCu+MuDCcregSO1/HSIl/jjBd4tjia3V8ggEXw9G
 b8w0JOi6Jjwon3WB8shkBOtuac/DdEXO3U+89CVNh2RQbrWqpEHr99yluh2R0EeJBmD+jEiqwQM
 hipCK8x7v5aJiDgcFgaIhZ8rn2l1LzYCKaxqz0LewLuNAFe2z3DVKAeUngJYQBz5KK5uhBinl03
 H50wBfrFy72y4PPbgowzCt+00mGNQlY8nLtu0k0PGr/DPUEUi6rE3l5hCNkKAt8UEjVuNvdf6O1
 Hdw1UXzF+k9CEZoG4yod1P4KtVp4HU7mp8FokhkRv21i9aqqjzp14QpzMWy9sp8fH4u0Od0QCYY
 deywh8Xf3Bp31maD3EmhxUPYanSwgWT7EkcSyugDUs6ebzTZi4KpMgquc9J4ap0sBmkpFppycBv
 Hg5tYaNX32dhkJbEmanM4EkEub6mwsOA/ZcLOIdkIuoawv5GnwadgndNuuJQONMUTRkHQ7QQvY0
 ZfBZ9fLMJL74yEl1nekfm/99yNJoxFc30WkU3po52g5rcvvRrtYQIUUqpbOEexNJXi2fFr0v/4m
 9hE0/tzqYhmhhpygdeyDWRLPDYqXItkC/acGHRX7mKH3SoeJKTX2OnnpWc1HBMd8m8zZjYggaYz
 9+Xw==
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id
 5b1f17b1804b1-4980c66b572mr227085475e9.8.1785773480944; 
 Mon, 03 Aug 2026 09:11:20 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:20 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 04/13] drm/sun4i: tcon-top: Keep mixer routes distinct
Date: Mon,  3 Aug 2026 18:10:42 +0200
Message-ID: <52eb247169b268054302afa71e598add0b04748d.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Both mixer selectors reset to TCON 0. Selecting the same TCON for both
mixers causes black or corrupted output.

When a route would collide, park the other mixer on another described
TCON, or an unused selector if none exists.

Since the TCON index is now used as a shift, also reject negative
values.

Tested on Orange Pi 3 with TCON_LCD0 and TCON_TV0.

Link: https://lore.kernel.org/linux-sunxi/Zn8GVkpwXwhaUFno@titan/
Link: https://lore.kernel.org/linux-sunxi/20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org/
Fixes: 05db311a792d ("drm/sun4i: tcon-top: Add helpers for mux switching")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 71 +++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h |  6 +++
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 8adda578c51b..9cbd655518b2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -25,6 +25,49 @@ static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
 	return !!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
+static unsigned int sun8i_tcon_top_get_tcon_map(struct device_node *node)
+{
+	static const u32 out_ports[] = {
+		TCON_TOP_MIXER0_OUT_PORT,
+		TCON_TOP_MIXER1_OUT_PORT,
+	};
+	unsigned int i, map = 0;
+
+	for (i = 0; i < ARRAY_SIZE(out_ports); i++) {
+		struct device_node *port;
+
+		port = of_graph_get_port_by_id(node, out_ports[i]);
+		if (!port)
+			continue;
+
+		for_each_of_graph_port_endpoint(port, ep) {
+			struct of_endpoint endpoint;
+
+			if (of_graph_parse_endpoint(ep, &endpoint))
+				continue;
+
+			if (endpoint.id < TCON_TOP_PORT_TCON_NUM)
+				map |= BIT(endpoint.id);
+		}
+
+		of_node_put(port);
+	}
+
+	return map;
+}
+
+static unsigned int sun8i_tcon_top_park_index(struct sun8i_tcon_top *tcon_top,
+					      int tcon)
+{
+	unsigned int candidates;
+
+	candidates = tcon_top->tcon_map & ~BIT(tcon);
+	if (!candidates)
+		candidates = GENMASK(TCON_TOP_PORT_TCON_NUM - 1, 0) & ~BIT(tcon);
+
+	return ffs(candidates) - 1;
+}
+
 int sun8i_tcon_top_set_hdmi_src(struct device *dev, int tcon)
 {
 	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
@@ -57,6 +100,7 @@ EXPORT_SYMBOL(sun8i_tcon_top_set_hdmi_src);
 int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon)
 {
 	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	u32 mixer_msk, other_msk;
 	unsigned long flags;
 	u32 reg;
 
@@ -70,21 +114,27 @@ int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon)
 		return -EINVAL;
 	}
 
-	if (tcon > 3) {
-		dev_err(dev, "TCON index is too high!\n");
+	if (tcon < 0 || tcon >= TCON_TOP_PORT_TCON_NUM) {
+		dev_err(dev, "TCON index is invalid!\n");
 		return -EINVAL;
 	}
 
+	mixer_msk = mixer ? TCON_TOP_PORT_DE1_MSK : TCON_TOP_PORT_DE0_MSK;
+	other_msk = mixer ? TCON_TOP_PORT_DE0_MSK : TCON_TOP_PORT_DE1_MSK;
+
 	spin_lock_irqsave(&tcon_top->reg_lock, flags);
 
 	reg = readl(tcon_top->regs + TCON_TOP_PORT_SEL_REG);
-	if (mixer == 0) {
-		reg &= ~TCON_TOP_PORT_DE0_MSK;
-		reg |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, tcon);
-	} else {
-		reg &= ~TCON_TOP_PORT_DE1_MSK;
-		reg |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, tcon);
+
+	reg &= ~mixer_msk;
+	reg |= field_prep(mixer_msk, tcon);
+
+	if (field_get(other_msk, reg) == tcon) {
+		reg &= ~other_msk;
+		reg |= field_prep(other_msk,
+				  sun8i_tcon_top_park_index(tcon_top, tcon));
 	}
+
 	writel(reg, tcon_top->regs + TCON_TOP_PORT_SEL_REG);
 
 	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
@@ -143,6 +193,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 	clk_data->num = CLK_NUM;
 	tcon_top->clk_data = clk_data;
+	tcon_top->tcon_map = sun8i_tcon_top_get_tcon_map(dev->of_node);
 
 	spin_lock_init(&tcon_top->reg_lock);
 
@@ -175,10 +226,6 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		goto err_assert_reset;
 	}
 
-	/*
-	 * At least on H6, some registers have some bits set by default
-	 * which may cause issues. Clear them here.
-	 */
 	writel(0, regs + TCON_TOP_PORT_SEL_REG);
 	writel(0, regs + TCON_TOP_GATE_SRC_REG);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
index 0390584a330e..2b887470a49f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
@@ -14,6 +14,10 @@
 #define TCON_TOP_PORT_SEL_REG		0x1C
 #define TCON_TOP_PORT_DE0_MSK			GENMASK(1, 0)
 #define TCON_TOP_PORT_DE1_MSK			GENMASK(5, 4)
+#define TCON_TOP_PORT_TCON_NUM			4
+
+#define TCON_TOP_MIXER0_OUT_PORT		1
+#define TCON_TOP_MIXER1_OUT_PORT		3
 
 #define TCON_TOP_GATE_SRC_REG		0x20
 #define TCON_TOP_HDMI_SRC_MSK			GENMASK(29, 28)
@@ -29,6 +33,8 @@ struct sun8i_tcon_top {
 	void __iomem			*regs;
 	struct reset_control		*rst;
 
+	unsigned int			tcon_map;
+
 	/*
 	 * spinlock is used to synchronize access to same
 	 * register where multiple clock gates can be set.
-- 
2.43.0

