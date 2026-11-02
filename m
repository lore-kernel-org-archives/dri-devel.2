Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C6606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U9Y/2RUo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39F710E00C;
	Mon,  2 Nov 2026 04:32:45 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD0F10E50D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 04:32:39 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-36a1947498bso303022eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 20:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793593959; x=1794198759; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5j1pwkggFGWmolmU2OjJfiaIzHorqtOlyZmT6W8xzo=;
 b=U9Y/2RUo2IfFJY7DZNs7EuSwiILYutrf61X7jx1YcUNNXufdtC4QwInsPHao39zmry
 J+lfkh8wnWY7zvgHPOz1lJ8+QqxVGA99dvx4BjOnAGf58OCyP8ml1VD7TIw3SQME3BxQ
 SQUDp6tw39JpCVX/MtNG1qx+K+/Qj44uAym89LImzPMG2dhvL/AA724bO8wFfRCyp8ey
 EiFAgVSZ9ILNlwbF7o2hYK8tOphoIIBlH+6mN0GCNzBVFV8mHHY6UkgVLOoamLWCMfTS
 kMMz+eiSfMI5f+BXCnwDJ+EOePOqSvK/YqRAd3tyhxZqcTAuKXi3ZLVFCG1hlT5j/P6o
 bWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793593959; x=1794198759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K5j1pwkggFGWmolmU2OjJfiaIzHorqtOlyZmT6W8xzo=;
 b=1ANS9fXLHOEc92ANDVPSNAvPNn9eIMhyOT5IpEvSr8JmMg9kyRZoDfNO/Jy0ZPkE9d
 Iqcohpj9wji+eF/3O1/a1u4JaYJNDFCZ/S/Nz3pWBCIQpSsC1vaScAVBd2voEabZOOF2
 gLlW8+UvGqrd4/u5EhpI+W09chnratn7YhTrvqXGXv20JtcU7ozvNUeUgBTRNQYIQmf4
 4LPixiEiBJ2L4lbwMGkWEuHZEFHTnWq+NzQexRr08vocGYUSsi+wcTd4mqccyuIF2Ou7
 4lccqB4eH5Fqof8J9OEMsus4jLJMZv9G3YWeTVDuFjuUYMTB0vdRMYkZTERVjYDSV7Vq
 08FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxerxklbUMP7frLEYKvls3U94KSc0J62TEtEKwWVKMnIdTgWvX8cylQZKiqGb4D/kAZfuVU/kGxyfs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9MnqDvfgLk3uDQHPciWLUSn1ZJPpjd3PUaR5aZ5QdXXXVV6xSZ
 mN/a1z/p8WRvmuvfRYENiNVw29PGRuQ83N5LVDywIypgtxuARQ3bpgpi
X-Gm-Gg: AYBFou1idTdyJ+Lz0homK8G+fLAVcSnV8ljNKe/GxopwSu/hvsO9iElYmkp+QdyJAK3
 VvaNihHAkXYbJ/n7UYyf4NJCHOYOXaOR62DJNz+qm3pEQjKtzOBrv+TlQyeBnpPtxEjsv+lzw+e
 ygyzNoqzfymKNV67gBkmHU7bl9elRwtkHjFeUgxbvceMePLSthfhG0qnlyiasb8Xr0RvcngE28j
 iVJ4BAY4q0mYuVjkpJvvL4dcKX91fibFdlcZmyzyCMywi2dp1PcWB8ECnY/7/zqr49NV1gdPOKk
 SjfICVqGXysct70YUElywO5lRZ1DoKKeDocHDHFliKuU1BgVZfdtX2D6fNx2t3G0ziWourowZGB
 dMJQCEGwP/jzAOWVuQeEQ7RvQ7nica0qxM3dPDAStt3P6rghMIvhhb9eEvvcjok7svRV1sFGEDq
 HCazvBrLogwWy8lFCBjJPQPMhasi8kljQOwOoBwtntUllHP0K3t5SyPZ512w1hIK+db4dNNI5+h
 5m63MWtp1UuaShRMo4VH0TRcGEh1UHNhM0p99nPIuYZWS/XVY+2Qj2cZa9W9O+SYCTpq7P2HE5i
 BA3vxErnxia2MWKXpldvWjPZ/UGLwhvUmEVJkuTZgYugTaR09/bkXHi+l5mO2s2KLqTUz59VDy1
 8Pe1GfW5GY6rEZgXgDXMYqogyEzbyh0UJZoR1tU6e
X-Received: by 2002:a05:693c:6382:20b0:366:f9c2:9b16 with SMTP id
 5a478bee46e88-36a423f5d7amr14181136eec.31.1793593958509; 
 Sun, 01 Nov 2026 20:32:38 -0800 (PST)
Received: from NB150512.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm38581063eec.26.2026.11.01.20.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:32:38 -0800 (PST)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH v2 5/5] drm/panel: raydium-rm68200: Use lowercase hex literals
Date: Mon,  2 Nov 2026 12:32:15 +0800
Message-ID: <20261102043215.990351-6-hungen3108@gmail.com>
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

Convert hexadecimal literals in the RM68200 register definitions and
initialization sequence to lowercase for consistency with the
preferred formatting convention.

This is a formatting-only change. Register addresses and command
data remain unchanged.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    Changes in v2:
    - Add a separate patch to convert hexadecimal literals to lowercase,
      as suggested by Doug, keeping the _multi() conversion focused on
      functional changes.
    
    Validation:
    - Compared all 65 modified source lines after normalizing only the
      hexadecimal digits in literals. No other differences were found.
    - Confirmed that no uppercase hexadecimal literals remain.
    - Built the driver before and after the change using the same
      configuration. The .text, .rodata, .rodata.str1.8 and .data sections
      were byte-for-byte identical.
    - The build completed with W=1 and no warnings or errors.
      checkpatch reported no issues.

 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 132 +++++++++---------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index 8ce89f09540c..df99b6837057 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -18,7 +18,7 @@
 #include <drm/drm_panel.h>
 
 /*** Manufacturer Command Set ***/
-#define MCS_CMD_MODE_SW		0xFE /* CMD Mode Switch */
+#define MCS_CMD_MODE_SW		0xfe /* CMD Mode Switch */
 #define MCS_CMD1_UCS		0x00 /* User Command Set (UCS = CMD1) */
 #define MCS_CMD2_P0		0x01 /* Manufacture Command Set Page0 (CMD2 P0) */
 #define MCS_CMD2_P1		0x02 /* Manufacture Command Set Page1 (CMD2 P1) */
@@ -28,44 +28,44 @@
 /* CMD2 P0 commands (Display Options and Power) */
 #define MCS_STBCTR		0x12 /* TE1 Output Setting Zig-Zag Connection */
 #define MCS_SGOPCTR		0x16 /* Source Bias Current */
-#define MCS_SDCTR		0x1A /* Source Output Delay Time */
-#define MCS_INVCTR		0x1B /* Inversion Type */
+#define MCS_SDCTR		0x1a /* Source Output Delay Time */
+#define MCS_INVCTR		0x1b /* Inversion Type */
 #define MCS_EXT_PWR_IC		0x24 /* External PWR IC Control */
 #define MCS_SETAVDD		0x27 /* PFM Control for AVDD Output */
 #define MCS_SETAVEE		0x29 /* PFM Control for AVEE Output */
-#define MCS_BT2CTR		0x2B /* DDVDL Charge Pump Control */
-#define MCS_BT3CTR		0x2F /* VGH Charge Pump Control */
+#define MCS_BT2CTR		0x2b /* DDVDL Charge Pump Control */
+#define MCS_BT3CTR		0x2f /* VGH Charge Pump Control */
 #define MCS_BT4CTR		0x34 /* VGL Charge Pump Control */
 #define MCS_VCMCTR		0x46 /* VCOM Output Level Control */
 #define MCS_SETVGN		0x52 /* VG M/S N Control */
 #define MCS_SETVGP		0x54 /* VG M/S P Control */
-#define MCS_SW_CTRL		0x5F /* Interface Control for PFM and MIPI */
+#define MCS_SW_CTRL		0x5f /* Interface Control for PFM and MIPI */
 
 /* CMD2 P2 commands (GOA Timing Control) - no description in datasheet */
 #define GOA_VSTV1		0x00
 #define GOA_VSTV2		0x07
-#define GOA_VCLK1		0x0E
+#define GOA_VCLK1		0x0e
 #define GOA_VCLK2		0x17
 #define GOA_VCLK_OPT1		0x20
-#define GOA_BICLK1		0x2A
+#define GOA_BICLK1		0x2a
 #define GOA_BICLK2		0x37
 #define GOA_BICLK3		0x44
-#define GOA_BICLK4		0x4F
-#define GOA_BICLK_OPT1		0x5B
+#define GOA_BICLK4		0x4f
+#define GOA_BICLK_OPT1		0x5b
 #define GOA_BICLK_OPT2		0x60
-#define MCS_GOA_GPO1		0x6D
+#define MCS_GOA_GPO1		0x6d
 #define MCS_GOA_GPO2		0x71
 #define MCS_GOA_EQ		0x74
-#define MCS_GOA_CLK_GALLON	0x7C
-#define MCS_GOA_FS_SEL0		0x7E
+#define MCS_GOA_CLK_GALLON	0x7c
+#define MCS_GOA_FS_SEL0		0x7e
 #define MCS_GOA_FS_SEL1		0x87
 #define MCS_GOA_FS_SEL2		0x91
-#define MCS_GOA_FS_SEL3		0x9B
-#define MCS_GOA_BS_SEL0		0xAC
-#define MCS_GOA_BS_SEL1		0xB5
-#define MCS_GOA_BS_SEL2		0xBF
-#define MCS_GOA_BS_SEL3		0xC9
-#define MCS_GOA_BS_SEL4		0xD3
+#define MCS_GOA_FS_SEL3		0x9b
+#define MCS_GOA_BS_SEL0		0xac
+#define MCS_GOA_BS_SEL1		0xb5
+#define MCS_GOA_BS_SEL2		0xbf
+#define MCS_GOA_BS_SEL3		0xc9
+#define MCS_GOA_BS_SEL4		0xd3
 
 /* CMD2 P3 commands (Gamma) */
 #define MCS_GAMMA_VP		0x60 /* Gamma VP1~VP16 */
@@ -119,41 +119,41 @@ static void rm68200_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
 	/* Enter CMD2 with page 0 */
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P0);
-	dcs_write_cmd_seq(dsi_ctx, MCS_EXT_PWR_IC, 0xC0, 0x53, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT2CTR, 0xE5);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVDD, 0x0A);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVEE, 0x0A);
+	dcs_write_cmd_seq(dsi_ctx, MCS_EXT_PWR_IC, 0xc0, 0x53, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT2CTR, 0xe5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVDD, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVEE, 0x0a);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SGOPCTR, 0x52);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT3CTR, 0x53);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT4CTR, 0x5A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT4CTR, 0x5a);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_INVCTR, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_STBCTR, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_STBCTR, 0x0a);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SDCTR, 0x06);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_VCMCTR, 0x56);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGN, 0xA0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGP, 0xA0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGN, 0xa0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGP, 0xa0, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SW_CTRL, 0x11); /* 2 data lanes, see doc */
 
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P2);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_VSTV1, 0x05);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x0B);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x0F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x7D, 0x00, 0x50);
-	dcs_write_cmd_seq(dsi_ctx, GOA_VSTV2, 0x05, 0x16, 0x0D, 0x11, 0x7D, 0x00,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x7d, 0x00, 0x50);
+	dcs_write_cmd_seq(dsi_ctx, GOA_VSTV2, 0x05, 0x16, 0x0d, 0x11, 0x7d, 0x00,
 			  0x50);
-	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK1, 0x07, 0x08, 0x01, 0x02, 0x00, 0x7D,
+	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK1, 0x07, 0x08, 0x01, 0x02, 0x00, 0x7d,
 			  0x00, 0x85, 0x08);
-	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK2, 0x03, 0x04, 0x05, 0x06, 0x00, 0x7D,
+	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK2, 0x03, 0x04, 0x05, 0x06, 0x00, 0x7d,
 			  0x00, 0x85, 0x08);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_VCLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 				     0x00, 0x00, 0x00, 0x00);
 	dcs_write_cmd_seq(dsi_ctx, GOA_BICLK1, 0x07, 0x08);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2D, 0x01);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2F, 0x02, 0x00, 0x40, 0x05, 0x08, 0x54, 0x7D,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2d, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2f, 0x02, 0x00, 0x40, 0x05, 0x08, 0x54, 0x7d,
 				     0x00);
 	dcs_write_cmd_seq(dsi_ctx, GOA_BICLK2, 0x03, 0x04, 0x05, 0x06, 0x00);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3D, 0x40);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3F, 0x05, 0x08, 0x54, 0x7D, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3f, 0x05, 0x08, 0x54, 0x7d, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 				     0x00, 0x00, 0x00, 0x00, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -167,38 +167,38 @@ static void rm68200_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_EQ, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
 				     0x00, 0x00);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_CLK_GALLON, 0x00, 0x00);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL0, 0xBF, 0x02, 0x06, 0x14, 0x10,
-			  0x16, 0x12, 0x08, 0x3F);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0C,
-			  0x0A, 0x0E, 0x3F, 0x3F, 0x00);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL2, 0x04, 0x3F, 0x3F, 0x3F, 0x3F,
-			  0x05, 0x01, 0x3F, 0x3F, 0x0F);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL3, 0x0B, 0x0D, 0x3F, 0x3F, 0x3F,
-			  0x3F);
-	dcs_write_cmd_seq(dsi_ctx, 0xA2, 0x3F, 0x09, 0x13, 0x17, 0x11, 0x15);
-	dcs_write_cmd_seq(dsi_ctx, 0xA9, 0x07, 0x03, 0x3F);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL0, 0x3F, 0x05, 0x01, 0x17, 0x13,
-			  0x15, 0x11, 0x0F, 0x3F);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0B,
-			  0x0D, 0x09, 0x3F, 0x3F, 0x07);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL2, 0x03, 0x3F, 0x3F, 0x3F, 0x3F,
-			  0x02, 0x06, 0x3F, 0x3F, 0x08);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL3, 0x0C, 0x0A, 0x3F, 0x3F, 0x3F,
-			  0x3F, 0x3F, 0x0E, 0x10, 0x14);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL4, 0x12, 0x16, 0x00, 0x04, 0x3F);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDC, 0x02);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDE, 0x12);
-
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, 0x0E); /* No documentation */
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL0, 0xbf, 0x02, 0x06, 0x14, 0x10,
+			  0x16, 0x12, 0x08, 0x3f);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL1, 0x3f, 0x3f, 0x3f, 0x3f, 0x0c,
+			  0x0a, 0x0e, 0x3f, 0x3f, 0x00);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL2, 0x04, 0x3f, 0x3f, 0x3f, 0x3f,
+			  0x05, 0x01, 0x3f, 0x3f, 0x0f);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL3, 0x0b, 0x0d, 0x3f, 0x3f, 0x3f,
+			  0x3f);
+	dcs_write_cmd_seq(dsi_ctx, 0xa2, 0x3f, 0x09, 0x13, 0x17, 0x11, 0x15);
+	dcs_write_cmd_seq(dsi_ctx, 0xa9, 0x07, 0x03, 0x3f);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL0, 0x3f, 0x05, 0x01, 0x17, 0x13,
+			  0x15, 0x11, 0x0f, 0x3f);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL1, 0x3f, 0x3f, 0x3f, 0x3f, 0x0b,
+			  0x0d, 0x09, 0x3f, 0x3f, 0x07);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL2, 0x03, 0x3f, 0x3f, 0x3f, 0x3f,
+			  0x02, 0x06, 0x3f, 0x3f, 0x08);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL3, 0x0c, 0x0a, 0x3f, 0x3f, 0x3f,
+			  0x3f, 0x3f, 0x0e, 0x10, 0x14);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL4, 0x12, 0x16, 0x00, 0x04, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdc, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x12);
+
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, 0x0e); /* No documentation */
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x75);
 
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P3);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VP, 0x00, 0x0C, 0x12, 0x0E, 0x06,
-			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
-			  0x12, 0x0C, 0x00);
-	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VN, 0x00, 0x0C, 0x12, 0x0E, 0x06,
-			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
-			  0x12, 0x0C, 0x00);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VP, 0x00, 0x0c, 0x12, 0x0e, 0x06,
+			  0x12, 0x0e, 0x0b, 0x15, 0x0b, 0x10, 0x07, 0x0f,
+			  0x12, 0x0c, 0x00);
+	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VN, 0x00, 0x0c, 0x12, 0x0e, 0x06,
+			  0x12, 0x0e, 0x0b, 0x15, 0x0b, 0x10, 0x07, 0x0f,
+			  0x12, 0x0c, 0x00);
 
 	/* Exit CMD2 */
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD1_UCS);
-- 
2.43.0

