Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758D606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHM31wcV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8D110E079;
	Sun, 15 Nov 2026 06:11:39 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E5610E1FA
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:11:26 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so1093035f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794723085; x=1795327885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TCHhOy28B+0gI7cRQUKEe32H0lL50i1G3WDk1ReHlIc=;
 b=hHM31wcVNSirMpdPDFCIuJJ0mmAu3rjRk6h1+01AJmzfyssCUnvGReodMuqMfOFPb7
 EMF4xWLrXcGfI6xwJqFd7zrztTIL3gHNJs5Eig/G1PCv33c2W+3c6+uhdzrYu6WjYQTo
 WE5NhjXrYHyze3+zB4fLrdlvC9b4YhwLVKXty9+hAzZv1X5ghovOei2oNNRcbJ735lDu
 o5JD6PVmzRs+MmObSCmj6dZrU18g4tilWqd2GXs9LjsmeENFpir4jmLpp2/oqYFBfX9o
 lYnv5wHsWDIrXax6Q47XeYCDCuhpKYueB9kM5KBE0yWtE9qic0COLbA4fwW3u3aEDcM+
 +5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723085; x=1795327885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TCHhOy28B+0gI7cRQUKEe32H0lL50i1G3WDk1ReHlIc=;
 b=Y649uGVo3Zjj5Z9adx5JoISXsYqYk6W/9EAzJn7wuyCTqUOtdDR4Q4w7iNvE95HiFq
 tgd42WBPP4Tya78OsmgSE4/F0CWHWJp4t4mJqXdzDI7+cNnCzi2Evs+1Tpkw0AVeLu4b
 FkfMCmsrcnCIYy9xjxKKcGaNN9e0Ytdll+t2+TUo4vxDgB77NBe1x7/unuFjBuaaOW/u
 uLMa+rH1mcxHOX6QTa4cHX2Bfoq7n5WCdKN7McqNkjqfm/NDYipDyU2UsiLaIl0UquG9
 7zQ31DxyUD5yXZwiYc4wm9guGjQalmJxkpBmmlFJJw/WLYBbupGhMVffv9eMKR1U6Frm
 o6IA==
X-Forwarded-Encrypted: i=1;
 AL+hErF2PN4D8xKL+D7xrx8O28FJy+tnvCyNSb3HzZ7BCOKMx6B9ab3s4s5eaGVcGYqQNX3KwOdqrE7sVwY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+fXrprg5PEfqZvQRoiMKFxDJN+GMp5G/pfPIuM/lf3pEzQOGGu
 9U+X16ezzgbmn/NY3QzjKo51yB3L3DA7fEkdeRFMDQfR0V4xdiGjTEKK
X-Gm-Gg: AYBFou33rK7B4ar+fI4ghdY0s/MIwBO1fkpHUXHOUXgyGT5M2RazAmsUV967owr44gZ
 2q/B+LtdmqoWlBH8jE5oes6cq4lfLtIDb8LFBluLkzIkBt+k7eC9tqCPXJ3dTEntj6k8gWBN5s9
 TzIIfdRyCeIvy2BmTwOGWy3ETian1Mb/B1+oR9JTxzuZ3LPDd2pOBLZRVI+AeJeDa6ntyAhzXv9
 cNYNxBms613hpVlp2Kzo0ZnpdtbawRskUF0C0fkFRY87sxnDV+Ns0Ag5CWnyuCPoFaQtSZ8o7Us
 ajeamZnDCaBpCcrEOjkpU5TpEJd/EZGrx4zJe2HPb3u1zNglLd8AT38icSW7xTdpBjt4OMxxsc0
 3yA8yK+GXKROcmspUOqk83jvIXUT9NBGbnHSthsJszKelOpycGOPaRuUASms9xtp/GkBBVy8lcZ
 kBbJ+5TIzQC0jOYNTs7e0InLd82q6BxgEaJO6pizBUQS8NFDZBLCgD34i2FaZfGZWk3QmamnOdD
 D9nQrdjL1KAuq+gsj5r8PqOY6xhRo6dpESIAocQSBwDJJfuFAVixA8NjoBEkc/8cJotI4hufKLC
 I0Km+8ZrKV/jrfxC1ADCP0bnahVDye5hfBNAOSzqTXtl3lA3bmIVZsivVrO/CWV0U5x6R1y9q0i
 vQz147UDXIHad7GMALM6Cj/2bXkif0FEw7DMcY84KfrJ+Wl2U5S0NUdRV2cyhxNMnXucdyxdN9B
 MzaxovONgmJZdd7u5cSgoubgfDk0aGuXneNjgQ1G6Iy0DVGQkg8O4q6ysgDv2V+rMlHnAMkhdVh
 86mqLUEZINLuQ==
X-Received: by 2002:a05:600c:3b98:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb55a8c128mr151718065e9.25.1794723084885; 
 Sat, 14 Nov 2026 22:11:24 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm139331075e9.14.2026.11.14.22.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:11:24 -0800 (PST)
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
Subject: [PATCH v3 3/8] drm/sun4i: Add support for DE33 CSC
Date: Sun, 15 Nov 2026 07:10:57 +0100
Message-ID: <20261115061102.229680-4-jernej.skrabec@gmail.com>
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

DE33 has channel CSC units (for each plane separately) so pipeline can
be configured to output in desired colorspace.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c | 71 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_csc.h |  5 +++
 2 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index ce81c12f511d..70fc9b017d17 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -205,6 +205,72 @@ static void sun8i_de3_ccsc_setup(struct regmap *map, int layer,
 			   mask, val);
 }
 
+/* extract constant from high word and invert sign if necessary */
+static u32 sun8i_de33_ccsc_get_constant(u32 value)
+{
+	value >>= 16;
+
+	if (value & BIT(15))
+		return 0x400 - (value & 0x3ff);
+
+	return value;
+}
+
+static void sun8i_de33_convert_table(const u32 *src, u32 *dst)
+{
+	dst[0] = sun8i_de33_ccsc_get_constant(src[3]);
+	dst[1] = sun8i_de33_ccsc_get_constant(src[7]);
+	dst[2] = sun8i_de33_ccsc_get_constant(src[11]);
+	memcpy(&dst[3], src, sizeof(u32) * 12);
+	dst[6] &= 0xffff;
+	dst[10] &= 0xffff;
+	dst[14] &= 0xffff;
+}
+
+static void sun8i_de33_ccsc_setup(struct regmap *map, int layer,
+				  enum sun8i_csc_mode mode,
+				  enum drm_color_encoding encoding,
+				  enum drm_color_range range)
+{
+	u32 addr, val, base, csc[15];
+	const u32 *table;
+	int i;
+
+	table = yuv2rgb_de3[range][encoding];
+	base = DE33_CCSC_BASE + layer * DE33_CH_SIZE;
+
+	switch (mode) {
+	case SUN8I_CSC_MODE_OFF:
+		val = 0;
+		break;
+	case SUN8I_CSC_MODE_YUV2RGB:
+		val = SUN8I_CSC_CTRL_EN;
+		sun8i_de33_convert_table(table, csc);
+		regmap_bulk_write(map, SUN50I_CSC_COEFF(base, 0), csc, 15);
+		break;
+	case SUN8I_CSC_MODE_YVU2RGB:
+		val = SUN8I_CSC_CTRL_EN;
+		sun8i_de33_convert_table(table, csc);
+		for (i = 0; i < 15; i++) {
+			addr = SUN50I_CSC_COEFF(base, i);
+			if (i > 3) {
+				if (((i - 3) & 3) == 1)
+					addr = SUN50I_CSC_COEFF(base, i + 1);
+				else if (((i - 3) & 3) == 2)
+					addr = SUN50I_CSC_COEFF(base, i - 1);
+			}
+			regmap_write(map, addr, csc[i]);
+		}
+		break;
+	default:
+		val = 0;
+		DRM_WARN("Wrong CSC mode specified.\n");
+		return;
+	}
+
+	regmap_write(map, SUN8I_CSC_CTRL(base), val);
+}
+
 static u32 sun8i_csc_get_mode(struct drm_plane_state *state)
 {
 	const struct drm_format_info *format;
@@ -238,6 +304,11 @@ void sun8i_csc_config(struct sun8i_layer *layer,
 				     mode, state->color_encoding,
 				     state->color_range);
 		return;
+	} else if (layer->cfg->de_type == SUN8I_MIXER_DE33) {
+		sun8i_de33_ccsc_setup(layer->regs, layer->channel,
+				      mode, state->color_encoding,
+				      state->color_range);
+		return;
 	}
 
 	base = ccsc_base[layer->cfg->ccsc][layer->channel];
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index 2a4b79599610..d2ba5f8611aa 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -18,9 +18,14 @@ struct sun8i_layer;
 #define CCSC10_OFFSET 0xA0000
 #define CCSC11_OFFSET 0xF0000
 
+#define DE33_CCSC_BASE 0x800
+
 #define SUN8I_CSC_CTRL(base)		((base) + 0x0)
 #define SUN8I_CSC_COEFF(base, i)	((base) + 0x10 + 4 * (i))
 
+#define SUN50I_CSC_COEFF(base, i)	((base) + 0x04 + 4 * (i))
+#define SUN50I_CSC_ALPHA(base)		((base) + 0x40)
+
 #define SUN8I_CSC_CTRL_EN		BIT(0)
 
 void sun8i_csc_config(struct sun8i_layer *layer,
-- 
2.43.0

