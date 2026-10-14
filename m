Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7801CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2AB10F056;
	Wed, 14 Oct 2026 13:51:01 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EA010FECA
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:50:55 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-873a4edb243so407573b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791985855; x=1792590655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yaUwVp3Ya5wdUvPU7xx88a7pYBhQ8NFTqrTmi8kBeUY=;
 b=sRXzgiT2K/L/1H1v4QyidmxgXYiwXyct9BZ9Ehn27eVvvIp4qAPMde5maNDOl01NRl
 8s37eqtu6CxscFCzcHhneSjY5JTnyxmglEzWKX6R7ydGzvtEv88JD4ZSy3dzqQoItCtW
 1v2LOY4gI2woeEFijT9/oSzCA96nOEL/Fcw3EE8Kcj8DSd6sfTkZm4MSib9ILp82joKr
 NN3Ivuce9ob7kE6CGHYsprSuzQIvyrmEp1FjqYoke1Xyt/10fqHJn/V5XTdJR+FKIVJg
 /vzZTxujxFSthaFUyqSZbDHEgS++j0yBzVBDU0CtxcWvIlx6I4wpTTSPsOFkbSYCZBV0
 UTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791985855; x=1792590655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yaUwVp3Ya5wdUvPU7xx88a7pYBhQ8NFTqrTmi8kBeUY=;
 b=Gaa8MB+m2xIjz4CLMJDXGt75GPiXC2X+0eWpLpOdhy/Y5mqkiNVHIgWrg2weMMHwfg
 FVRZD1UiNuiTj9QhwEDDWBZtCris9CkEsBffY8L2Uow83X/oZi7Rem0BEUp5YvAKmct4
 NJQnZ2uBxZx8rKLyl7+32hg/czirLChYb07F4fKtaABn+q03CKrThM2uIqcQkkwI3D0H
 mG6cDOYWLRkRN+nX0AjxQTjGCyEjEtjB2UFrLWl3F1z2UDcb32DzJ/QNQ35Pn9Yx8nNa
 96yURLjYlbsMNANOLSljo1MBv43TpQfLfK0/64LrSBGaAL2YqTbseVq2wYlNnQfgdIic
 TGng==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR6CYYnnDQTSN6H8YJAdY99Ib5EAIqFLvB3V0S5LC7/hbVYxKSbTnPqw9lRvP3R+74+WTc52dFmGI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJiKuAwZe+tOvNfLKwpbZFea3zjVcQ51vlMrbS56sDK6iBFCKU5
 vldo8kC8oEMfi5b9OO+iEKafxvrFVU49Pa/UIXemwt46rcUdeI0EXOAG
X-Gm-Gg: AYBFou31oiiWxZJwTVAzjf4/FSYVs3Gqa2Lp/OcdvZpUAO7za3GFXkawD0FGqJzlRNr
 85Nzn10LNFTaGlaQ/PaaPJI2xlWujylZfBlhhQBfnVZsW7EVr29lAyIOubWb34WRtrFc3XgD2co
 2UP59hfueFwNR4Vf+v+ESr/XwfpI/eD+4Hx1j2vtmxatVSBgKT+ETYaDYmmzZTJUPjLZKhzu1pJ
 SZgJVRlXPlniJjMjg+nC+PNd6O107J6jX6Ey38gk65kpLPrxy/EGFdvV8dJ7t8DwqLGN/r1Kjlr
 tOaJfezH1zcsiEL2ZE+pnIrVcrM3lwzKhqgllR8BZgwcKrM9nAEAsSUKm16WS9QF8ESPV7anPLH
 pFA31YcCT2ibx94E5V0R1s1wit4cgXCQJ/w+ahJpZ/SEwSnlHOyjctVVtiWeJTOZrYIzN2O5pkD
 Ip9928PMR7NFLY/vN2CR4tYvLm9cv4QNFbKig5+hCNdubtlT/DAmKMB+oohB37r0EjvBAaFnufp
 A5dzQCRw/kRY+B1NSfmG4AK8IRjAUmxEVnOkSpg0jLj9EO5ciXpfYNUddD0mOf/KQmyb29G0rkk
 gC2Ag3/rXSEKFEjvFRZEDVP8mtqk6G8Z1CNEpqOfNRqxWn4=
X-Received: by 2002:a05:6a00:13a6:b0:886:7d7d:cfb4 with SMTP id
 d2e1a72fcca58-897c86a4052mr14416514b3a.59.1791985854725; 
 Wed, 14 Oct 2026 06:50:54 -0700 (PDT)
Received: from NB150512.ADVANTECH.CORP
 (2001-b011-6c00-3d72-751d-cebe-164a-ae70.dynamic-ip6.hinet.net.
 [2001:b011:6c00:3d72:751d:cebe:164a:ae70])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d804e514bsm1168418b3a.41.2026.10.14.06.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:50:53 -0700 (PDT)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH 3/3] drm/panel: raydium-rm68200: Use multi-context helpers for
 init sequence
Date: Wed, 14 Oct 2026 21:50:28 +0800
Message-ID: <20261014135028.1438841-4-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014135028.1438841-1-hungen3108@gmail.com>
References: <20261014135028.1438841-1-hungen3108@gmail.com>
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

Replace the custom DCS write helpers with mipi_dsi_dcs_write_seq_multi()
and mipi_dsi_dcs_write_var_seq_multi(), preserving individual DCS
transactions for registers that do not support auto-increment.

Previously, initialization failures were only logged, allowing prepare()
to report success despite incomplete initialization. Share the
multi-context with prepare() so that after the first failed write,
subsequent DCS commands and delays are skipped, and the error is
propagated to prepare().

The new helpers log errors without rate limiting.

Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 184 ++++++++----------
 1 file changed, 80 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index 971d075bb060..a01b2db55c7f 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -98,134 +98,110 @@ static inline struct rm68200 *panel_to_rm68200(struct drm_panel *panel)
 	return container_of(panel, struct rm68200, panel);
 }
 
-static void rm68200_dcs_write_buf(struct rm68200 *ctx, const void *data,
-				  size_t len)
-{
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int err;
-
-	err = mipi_dsi_dcs_write_buffer(dsi, data, len);
-	if (err < 0)
-		dev_err_ratelimited(ctx->dev, "MIPI DSI DCS write buffer failed: %d\n", err);
-}
-
-static void rm68200_dcs_write_cmd(struct rm68200 *ctx, u8 cmd, u8 value)
-{
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int err;
-
-	err = mipi_dsi_dcs_write(dsi, cmd, &value, 1);
-	if (err < 0)
-		dev_err_ratelimited(ctx->dev, "MIPI DSI DCS write failed: %d\n", err);
-}
-
-#define dcs_write_seq(ctx, seq...)				\
-({								\
-	static const u8 d[] = { seq };				\
-								\
-	rm68200_dcs_write_buf(ctx, d, ARRAY_SIZE(d));		\
-})
-
 /*
  * This panel is not able to auto-increment all cmd addresses so for some of
  * them, we need to send them one by one...
+ *
+ * Use arr instead of d to avoid shadowing the local d[] declared by
+ * mipi_dsi_dcs_write_var_seq_multi().
  */
-#define dcs_write_cmd_seq(ctx, cmd, seq...)			\
-({								\
-	static const u8 d[] = { seq };				\
-	unsigned int i;						\
-								\
-	for (i = 0; i < ARRAY_SIZE(d) ; i++)			\
-		rm68200_dcs_write_cmd(ctx, cmd + i, d[i]);	\
-})
-
-static void rm68200_init_sequence(struct rm68200 *ctx)
+#define dcs_write_cmd_seq(dsi_ctx, cmd, seq...)			\
+	do {								\
+		static const u8 arr[] = { seq };			\
+		unsigned int i;						\
+									\
+		for (i = 0; i < ARRAY_SIZE(arr); i++)		\
+			mipi_dsi_dcs_write_var_seq_multi(dsi_ctx,	\
+							(cmd) + i, arr[i]); \
+	} while (0)
+
+static void rm68200_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
 	/* Enter CMD2 with page 0 */
-	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P0);
-	dcs_write_cmd_seq(ctx, MCS_EXT_PWR_IC, 0xC0, 0x53, 0x00);
-	dcs_write_seq(ctx, MCS_BT2CTR, 0xE5);
-	dcs_write_seq(ctx, MCS_SETAVDD, 0x0A);
-	dcs_write_seq(ctx, MCS_SETAVEE, 0x0A);
-	dcs_write_seq(ctx, MCS_SGOPCTR, 0x52);
-	dcs_write_seq(ctx, MCS_BT3CTR, 0x53);
-	dcs_write_seq(ctx, MCS_BT4CTR, 0x5A);
-	dcs_write_seq(ctx, MCS_INVCTR, 0x00);
-	dcs_write_seq(ctx, MCS_STBCTR, 0x0A);
-	dcs_write_seq(ctx, MCS_SDCTR, 0x06);
-	dcs_write_seq(ctx, MCS_VCMCTR, 0x56);
-	dcs_write_seq(ctx, MCS_SETVGN, 0xA0, 0x00);
-	dcs_write_seq(ctx, MCS_SETVGP, 0xA0, 0x00);
-	dcs_write_seq(ctx, MCS_SW_CTRL, 0x11); /* 2 data lanes, see doc */
-
-	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P2);
-	dcs_write_seq(ctx, GOA_VSTV1, 0x05);
-	dcs_write_seq(ctx, 0x02, 0x0B);
-	dcs_write_seq(ctx, 0x03, 0x0F);
-	dcs_write_seq(ctx, 0x04, 0x7D, 0x00, 0x50);
-	dcs_write_cmd_seq(ctx, GOA_VSTV2, 0x05, 0x16, 0x0D, 0x11, 0x7D, 0x00,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P0);
+	dcs_write_cmd_seq(dsi_ctx, MCS_EXT_PWR_IC, 0xC0, 0x53, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT2CTR, 0xE5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVDD, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVEE, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SGOPCTR, 0x52);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT3CTR, 0x53);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT4CTR, 0x5A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_INVCTR, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_STBCTR, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SDCTR, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_VCMCTR, 0x56);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGN, 0xA0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGP, 0xA0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SW_CTRL, 0x11); /* 2 data lanes, see doc */
+
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P2);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_VSTV1, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x0B);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x7D, 0x00, 0x50);
+	dcs_write_cmd_seq(dsi_ctx, GOA_VSTV2, 0x05, 0x16, 0x0D, 0x11, 0x7D, 0x00,
 			  0x50);
-	dcs_write_cmd_seq(ctx, GOA_VCLK1, 0x07, 0x08, 0x01, 0x02, 0x00, 0x7D,
+	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK1, 0x07, 0x08, 0x01, 0x02, 0x00, 0x7D,
 			  0x00, 0x85, 0x08);
-	dcs_write_cmd_seq(ctx, GOA_VCLK2, 0x03, 0x04, 0x05, 0x06, 0x00, 0x7D,
+	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK2, 0x03, 0x04, 0x05, 0x06, 0x00, 0x7D,
 			  0x00, 0x85, 0x08);
-	dcs_write_seq(ctx, GOA_VCLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-		      0x00, 0x00, 0x00, 0x00);
-	dcs_write_cmd_seq(ctx, GOA_BICLK1, 0x07, 0x08);
-	dcs_write_seq(ctx, 0x2D, 0x01);
-	dcs_write_seq(ctx, 0x2F, 0x02, 0x00, 0x40, 0x05, 0x08, 0x54, 0x7D,
-		      0x00);
-	dcs_write_cmd_seq(ctx, GOA_BICLK2, 0x03, 0x04, 0x05, 0x06, 0x00);
-	dcs_write_seq(ctx, 0x3D, 0x40);
-	dcs_write_seq(ctx, 0x3F, 0x05, 0x08, 0x54, 0x7D, 0x00);
-	dcs_write_seq(ctx, GOA_BICLK3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-		      0x00, 0x00, 0x00, 0x00, 0x00);
-	dcs_write_seq(ctx, GOA_BICLK4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-		      0x00, 0x00);
-	dcs_write_seq(ctx, 0x58, 0x00, 0x00, 0x00);
-	dcs_write_seq(ctx, GOA_BICLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dcs_write_seq(ctx, GOA_BICLK_OPT2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-		      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dcs_write_seq(ctx, MCS_GOA_GPO1, 0x00, 0x00, 0x00, 0x00);
-	dcs_write_seq(ctx, MCS_GOA_GPO2, 0x00, 0x20, 0x00);
-	dcs_write_seq(ctx, MCS_GOA_EQ, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
-		      0x00, 0x00);
-	dcs_write_seq(ctx, MCS_GOA_CLK_GALLON, 0x00, 0x00);
-	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL0, 0xBF, 0x02, 0x06, 0x14, 0x10,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_VCLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00);
+	dcs_write_cmd_seq(dsi_ctx, GOA_BICLK1, 0x07, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2D, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2F, 0x02, 0x00, 0x40, 0x05, 0x08, 0x54, 0x7D,
+				     0x00);
+	dcs_write_cmd_seq(dsi_ctx, GOA_BICLK2, 0x03, 0x04, 0x05, 0x06, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3D, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3F, 0x05, 0x08, 0x54, 0x7D, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x58, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK_OPT2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_GPO1, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_GPO2, 0x00, 0x20, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_EQ, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
+				     0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_CLK_GALLON, 0x00, 0x00);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL0, 0xBF, 0x02, 0x06, 0x14, 0x10,
 			  0x16, 0x12, 0x08, 0x3F);
-	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0C,
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0C,
 			  0x0A, 0x0E, 0x3F, 0x3F, 0x00);
-	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL2, 0x04, 0x3F, 0x3F, 0x3F, 0x3F,
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL2, 0x04, 0x3F, 0x3F, 0x3F, 0x3F,
 			  0x05, 0x01, 0x3F, 0x3F, 0x0F);
-	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL3, 0x0B, 0x0D, 0x3F, 0x3F, 0x3F,
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL3, 0x0B, 0x0D, 0x3F, 0x3F, 0x3F,
 			  0x3F);
-	dcs_write_cmd_seq(ctx, 0xA2, 0x3F, 0x09, 0x13, 0x17, 0x11, 0x15);
-	dcs_write_cmd_seq(ctx, 0xA9, 0x07, 0x03, 0x3F);
-	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL0, 0x3F, 0x05, 0x01, 0x17, 0x13,
+	dcs_write_cmd_seq(dsi_ctx, 0xA2, 0x3F, 0x09, 0x13, 0x17, 0x11, 0x15);
+	dcs_write_cmd_seq(dsi_ctx, 0xA9, 0x07, 0x03, 0x3F);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL0, 0x3F, 0x05, 0x01, 0x17, 0x13,
 			  0x15, 0x11, 0x0F, 0x3F);
-	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0B,
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0B,
 			  0x0D, 0x09, 0x3F, 0x3F, 0x07);
-	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL2, 0x03, 0x3F, 0x3F, 0x3F, 0x3F,
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL2, 0x03, 0x3F, 0x3F, 0x3F, 0x3F,
 			  0x02, 0x06, 0x3F, 0x3F, 0x08);
-	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL3, 0x0C, 0x0A, 0x3F, 0x3F, 0x3F,
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL3, 0x0C, 0x0A, 0x3F, 0x3F, 0x3F,
 			  0x3F, 0x3F, 0x0E, 0x10, 0x14);
-	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL4, 0x12, 0x16, 0x00, 0x04, 0x3F);
-	dcs_write_seq(ctx, 0xDC, 0x02);
-	dcs_write_seq(ctx, 0xDE, 0x12);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL4, 0x12, 0x16, 0x00, 0x04, 0x3F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDC, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDE, 0x12);
 
-	dcs_write_seq(ctx, MCS_CMD_MODE_SW, 0x0E); /* No documentation */
-	dcs_write_seq(ctx, 0x01, 0x75);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, 0x0E); /* No documentation */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x75);
 
-	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P3);
-	dcs_write_cmd_seq(ctx, MCS_GAMMA_VP, 0x00, 0x0C, 0x12, 0x0E, 0x06,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P3);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VP, 0x00, 0x0C, 0x12, 0x0E, 0x06,
 			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
 			  0x12, 0x0C, 0x00);
-	dcs_write_cmd_seq(ctx, MCS_GAMMA_VN, 0x00, 0x0C, 0x12, 0x0E, 0x06,
+	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VN, 0x00, 0x0C, 0x12, 0x0E, 0x06,
 			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
 			  0x12, 0x0C, 0x00);
 
 	/* Exit CMD2 */
-	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD1_UCS);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD1_UCS);
 }
 
 static int rm68200_unprepare(struct drm_panel *panel)
@@ -272,7 +248,7 @@ static int rm68200_prepare(struct drm_panel *panel)
 		msleep(100);
 	}
 
-	rm68200_init_sequence(ctx);
+	rm68200_init_sequence(&dsi_ctx);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-- 
2.43.0

