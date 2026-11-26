Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD84606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kqBeyZN1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C8E11274F;
	Thu, 26 Nov 2026 21:45:35 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A9A11273A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:51 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so3953265f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729489; x=1796334289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WSd+CxRijsj4N8ajh85kl4a69YfAGH4BSJ6W5M2ec1s=;
 b=kqBeyZN136ZgCqYKADmQZQ47vhU4NWC3XyLb8ksMnVWbwdctvTU34BTJZfpvmgVDpt
 ifpNFChS1/1+qDPeEq1ng4+hfycSStKQlzAhIN/1MafzO66VMjyu8hMZ8hgSa68qCQ7t
 NZ7JtjI0v0sFldHnmr/qsVQJmzcEw0Yz3MMbNQuLAMmTWs7rO/u2nmcLt1iiqrciluhg
 7gUrrCxMCrc8nA01fm2kHI9M0LWtDT9n+jyoYkogwS6m8aVCpmfiYbpUC7RksbcVbhY7
 ioNc2O6mrfUtVRJArdDVWpWfiJl8w3dhyoY1uZ1+eIha0qvlXKKgCt/VPjp3homO/Qjh
 OI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729489; x=1796334289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WSd+CxRijsj4N8ajh85kl4a69YfAGH4BSJ6W5M2ec1s=;
 b=zSS0+AuYia7GwyvNtYomB981CHJTPxBSw4jEzIR3N1tU7INjjp2nKQMqktr+Rnnzoe
 E0OjPUISdoHUhsp/gD7V8kIflUbowvJnVFZGH8NEXe4ru3L45I+qQ/Vo6PlJ0SKL98Jd
 ux9TPnHSb66CYiutstSU66/DO/nEJCqsaem2BNi+YiBKMiTNXCRt4WyaWDFG7X/CAWau
 4TzrVmV2mAk3GUV/jx3KMaLG8UdV6xuALvYnWCN/xn0G85/10VIRouevSHgew3MUv9qZ
 Tuf+Mncs6biX1kZxDvjMEL6uO7tenW5HXHprgCSQA7GPa8TKDE9JoEhjnL27g6qiTbE3
 2saw==
X-Forwarded-Encrypted: i=1;
 AL+hErHNMbiZK8SgyGgp70enTgC6wAgGPRA0yFVBhSRl8aXY+FuorVEINmYKTqSlsF2RYHbSpC1WahWnK88=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8qufv+JTNdwZ/L08Je/WNHOKcTNkU/PS5a47ZRAxQ6+IgpUyzO
 Kje1GnqbFSz2Rf7UtFeQhKOmYO9cPJW4BdKc1VSavPKBrSTMIU1zSpFr
X-Gm-Gg: AZFdTZfyGT/2gTKXXtWRYG9/HhV7N9jgvCj+8JGaAcYi3vS9HcK4Tgc5/3U85CQvKkz
 LF/KCXeJWCqFtZ+YVWlZkpxCv/XC6GL94WxcZZ9SfXvdKnecywXvsUrO2qxMUs53GMlEKwanvI/
 IT90Co5uN19dGSwrlTBaynNFNHfgX3VenBPAB6eDKnWZ1Rqe3fSPhI0EyFFXNoMV9U0aX5tSrlI
 1O0vfoStepgam7Z47RN4oRYLDnhTsUe04WBbbJ/so3a4xzXAIs/ZWKkmR29hqGyakT8y/s8/jlq
 DCMSmonxtyHy2+ajzXNJCtGpzyLg6sLyd2GkLBfILKRY8MdXCBgZVtwr56SXUzW89gEtb09LIX4
 ohs0/U2f//zWotb93H2RJWmCYnYTowV64j2zPqhLj55k47Gsn+xqRns2nVrxvJiUQXy1sWsqjVd
 t+eF7kXjCft2DCdTNJ/oJcnrZE18H4kJe/8bF1V0NkPtxviutL9OsUCh669wwbZalXJIO4zgy48
 TbnlVZRDzA5VjP4sPxlb+YoMFsndr385bHN+q0j8Uxc7kecV6Tn5Lxwf/zPLZ+RnmyxqXsivvXl
 kk9HRAoGr0NOylRtfGUHU12DApFPEBEutdJ6SXf2E8hJsgYrKcmUeH8WLnTKtIrXiFUDvbU8F9J
 S3BQ9444CkjVfN5teHWQ+txYR97nr9gkroHKtiBWC32xV0kEwTfYorF22OE/JT3UXIWf64Uv+7h
 a8KfWiXRw/SbFyRcNTCqY9puHvuzbEI8+EVeitmeFUa35Q8GyZUrMqpR6gtK7wte8LEAE/f39rw
 GIh2Q79gn8Wm1JixhgojxQ3KCdVpND4hDnbRdkqwDQ=
X-Received: by 2002:a05:6000:2406:b0:4af:e519:ccd1 with SMTP id
 ffacd0b85a97d-4afe519ced4mr37199366f8f.49.1795729489344; 
 Thu, 26 Nov 2026 13:44:49 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:49 -0800 (PST)
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
Subject: [PATCH 07/11] drm/sun4i: Add H616 TCON TV support
Date: Thu, 26 Nov 2026 22:44:29 +0100
Message-ID: <20261126214433.3562326-8-jernej.skrabec@gmail.com>
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

It needs additional quirk to enable HDMI pads.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 13 +++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0cbd6ae66c4e..3596537c500b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1297,6 +1297,11 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 				   tcon->id);
 	}
 
+	if (tcon->quirks->hdmi_pad)
+		regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
+				   SUN4I_TCON_GCTL_PAD_SEL,
+				   SUN4I_TCON_GCTL_PAD_SEL);
+
 	list_add_tail(&tcon->list, &drv->tcon_list);
 
 	return 0;
@@ -1585,6 +1590,13 @@ static const struct sun4i_tcon_quirks sun20i_d1_lcd_quirks = {
 	.set_mux		= sun8i_r40_tcon_tv_set_mux,
 };
 
+static const struct sun4i_tcon_quirks sun50i_h616_tv_quirks = {
+	.has_channel_1		= true,
+	.polarity_in_ch0	= true,
+	.hdmi_pad		= true,
+	.set_mux		= sun8i_r40_tcon_tv_set_mux,
+};
+
 /* sun4i_drv uses this list to check if a device node is a TCON */
 const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun4i-a10-tcon", .data = &sun4i_a10_quirks },
@@ -1605,6 +1617,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun9i-a80-tcon-tv", .data = &sun9i_a80_tcon_tv_quirks },
 	{ .compatible = "allwinner,sun20i-d1-tcon-lcd", .data = &sun20i_d1_lcd_quirks },
 	{ .compatible = "allwinner,sun20i-d1-tcon-tv", .data = &sun8i_r40_tv_quirks },
+	{ .compatible = "allwinner,sun50i-h616-tcon-tv", .data = &sun50i_h616_tv_quirks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index fa23aa23fe4a..98bee2bd96d2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -19,6 +19,7 @@
 
 #define SUN4I_TCON_GCTL_REG			0x0
 #define SUN4I_TCON_GCTL_TCON_ENABLE			BIT(31)
+#define SUN4I_TCON_GCTL_PAD_SEL				BIT(1)
 #define SUN4I_TCON_GCTL_IOMAP_MASK			BIT(0)
 #define SUN4I_TCON_GCTL_IOMAP_TCON1			(1 << 0)
 #define SUN4I_TCON_GCTL_IOMAP_TCON0			(0 << 0)
@@ -243,6 +244,7 @@ struct sun4i_tcon_quirks {
 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
 	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
 	bool	polarity_in_ch0; /* some tcon1 channels have polarity bits in tcon0 pol register */
+	bool	hdmi_pad;	/* h616 has to enable pad for HDMI */
 	u8	dclk_min_div;	/* minimum divider for TCON0 DCLK */
 
 	/* callback to handle tcon muxing options */
-- 
2.43.0

