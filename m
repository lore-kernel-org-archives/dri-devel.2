Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4541606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UZpRUh9j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C964910E562;
	Mon,  2 Nov 2026 04:32:43 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E11EA10E00C
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 04:32:36 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-36661f953e4so4134166eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 20:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793593956; x=1794198756; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DS86y1R/e+vYAd5ZdbpE3wI/YqrQmdLU7KuNVVjn0j8=;
 b=UZpRUh9jbyprpm9GSFupaGJh4IsyoWWPJ2W28QfZU0q+gXhPAO4z9/+pI0SB9TmEJ8
 7nuoo3XjGwCSPBwJkVzukYCucVMtFTnAjAYtij684/haBhuiQbpbF/mhrubjkm5SAvS2
 1wB5mEcqanvku2lrrLizspGzTm6vEX++2eX9ReB/wA9P1wVDlLLRtIbAEBecfpsI+7FK
 aUswBzCcLon4aUW3Mf0gTeFj7wNQOtf+HB8Z9vACQNofSfhJAZNJTEcBeKE2OGFYT/gK
 L2PJla0fEoOsW4WAyaGu3gG+JforNtsF6IyWF0cj+9HMfgLwBQRbfb9GUX64aAEK5umL
 EuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793593956; x=1794198756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DS86y1R/e+vYAd5ZdbpE3wI/YqrQmdLU7KuNVVjn0j8=;
 b=QXQAulx1ROIAyap+jCXWvH8gkNc3A9Mc978lIO+JRyeAOd1YpMedmdeHze0CB01ftE
 rQQvI89KHRO1Xi4tSHx+zdSrkSVEqQu4oBj2jnIQ1Cs4t31ur554OrxcZN9ThH/D/+pp
 oiI8C14drSX0qvPSv2/EriFoTMfB6hsuw6fi6/U97quQVdKycPw/KGzLRZ58UiAO7I68
 Fptdg2TL88quatlJ0FHKQeAlbZmdsVKALQftPoNsC2yUXzePkN0552F9yWwmNQ0egqHr
 qLDtigVfpWV3OaErkjhU/YFngeRfLoTIgQ839b2KlaWUHi7L5WjrrQZxo56CyCiwcTHv
 0k6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhkSq3IyQn3SSfvwZbzk9S+hXYyiHnveKeM+0CiDsj/kiCTH9kS9m+yCXSkyiACnzYhHF7R/LZ9zM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ICZHFdzoILn2eveUwIulP/maM9ei1UsR5UiqNs0IXcFYtNFXZ
 rbcl+0wBu1dDcHCORoDCRwSBG+RQH6b5WkZ3nQBt61v1mWC4gN94pf62
X-Gm-Gg: AYBFou1oG+EQbSkDiKdg5H5zmXA7xSMwUj202vB0GwwAgWYRn6UalWX7ZkApmci7pIM
 7Rhl8S3YiM1pqSew2lJ0Epc/HGq1blwjGak9PR0Bto/xHBpEQiXHDdRRRvOwW0RCdGClporAap/
 HppEzOLreqZNHssvbawvwC9Hm8LzROZFtgst8ocAxR2NQEhQY48nq83jbIYodeasiPXvah/r1Pu
 l9J8X2UZGjONBpBoIJG54nG1xA7q53G3ZhGz9okuE+G4NviHNyx0p5nJJ52XB+yMMapi2Nxmhb7
 56oFMj3MTcibCRWvwEugSBiIFyxHQSnbpGnCqkw1q5puMqyv3wN7EmlEHmIx0VCTS36QHaeRil+
 T9CTWEshyEH9pb631Axv0XcbwwM7DysuCmKnE05o8V/islkKm8VIxG0RcuqSjdbpmWrxdmTU9YG
 H9GS5MbUQXfkv16bRpJB72LU7oLBHS7CCYwoLYxSalDfITO0KnWKhL4uSGNJy/F6c8L7EpfFb3w
 z3bKuaAdDwoAh+m5Ws+yJrgI3S/WpskI/7vRMGJX7dSzcjV88Say44VNbOq7Ao5/xyynwxc87sU
 hhKtx9MkcMrZJUF9rI5qHIgYVPa2jLAM/X+vawJ9zS2UuigobfFhE4faY4mLL3MMt5iqlDSELYk
 U255BN6TYVbjtxeq1sytqL8to6Pnx4wX3XYKWxx0=
X-Received: by 2002:a05:7301:1886:b0:35e:6eae:c01a with SMTP id
 5a478bee46e88-36a4237d9d5mr14161509eec.19.1793593955580; 
 Sun, 01 Nov 2026 20:32:35 -0800 (PST)
Received: from NB150512.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm38581063eec.26.2026.11.01.20.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:32:35 -0800 (PST)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH v2 4/5] drm/panel: raydium-rm68200: Use mipi_dsi_*_multi()
 functions
Date: Mon,  2 Nov 2026 12:32:14 +0800
Message-ID: <20261102043215.990351-5-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102043215.990351-1-hungen3108@gmail.com>
References: <20261102043215.990351-1-hungen3108@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the deprecated MIPI DSI DCS helpers and custom DCS write
wrappers with their multi-context equivalents.

Preserve individual DCS transactions for registers that do not support
auto-increment. Share the multi-context with rm68200_init_sequence()
so that initialization failures stop subsequent DCS transfers and
cause prepare() to fail instead of only being logged. Errors are
handled by the cleanup path in prepare().

Use mipi_dsi_msleep() to skip delays after a failed command. In
unprepare(), clear accum_err between commands so that ENTER_SLEEP_MODE
is still attempted if SET_DISPLAY_OFF fails.

The new helpers log failures at error level. Initialization write
errors are no longer rate-limited.

Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    Changes in v2:
    - Merge v1 patches 2/3 and 3/3, as suggested by Doug.
    - Route initialization and DCS command failures through the prepare()
      error cleanup path introduced earlier in this series.
    - Drop Doug's Reviewed-by tag from v1 3/3 because the patches were
      merged and the error handling was reworked.
    
    Validation:
    - Mechanically compared all 58 initialization calls against v1.
      Command addresses, payloads, and ordering are unchanged.
    - Verified the expansion of dcs_write_cmd_seq() in v1 using
      preprocessed output, confirming that each register address is
      written in a separate DCS transaction. The macro is unchanged
      from v1.
    
    The uppercase hexadecimal literals are retained in this patch.
    Their formatting will be addressed separately in the next patch.

 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 208 ++++++++----------
 1 file changed, 91 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index 3a59eb00274d..8ce89f09540c 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -98,149 +98,123 @@ static inline struct rm68200 *panel_to_rm68200(struct drm_panel *panel)
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
 {
 	struct rm68200 *ctx = panel_to_rm68200(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret)
-		dev_warn(panel->dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret)
-		dev_warn(panel->dev, "failed to enter sleep mode: %d\n", ret);
+	/* Attempt to enter sleep mode even if display off failed. */
+	dsi_ctx.accum_err = 0;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	msleep(120);
 
@@ -258,6 +232,7 @@ static int rm68200_prepare(struct drm_panel *panel)
 {
 	struct rm68200 *ctx = panel_to_rm68200(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	int ret;
 
 	ret = regulator_enable(ctx->supply);
@@ -273,19 +248,18 @@ static int rm68200_prepare(struct drm_panel *panel)
 		msleep(100);
 	}
 
-	rm68200_init_sequence(ctx);
+	rm68200_init_sequence(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret)
-		goto assert_reset;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-	msleep(125);
+	mipi_dsi_msleep(&dsi_ctx, 125);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret)
 		goto assert_reset;
 
-	msleep(20);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 
 	return 0;
 
-- 
2.43.0

