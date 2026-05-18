Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C8FCD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 03:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38ECB10E2C2;
	Mon, 18 May 2026 03:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gc/AkvYg";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4AC10E2C2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:43:13 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-83f674f978fso207994b3a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779075793; x=1779680593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TUA3cPtzM9uPcBkOLN0h00OZZHnDRsQ9uXVemg5h2Eg=;
 b=Gc/AkvYgQZ/6Pyh0LzGvb11uCrbd2FgKcpafP2L6HsSFDzpSY2nI8vSH85A6iYLtyd
 fyWApJK79Py/68jA8s+1CJG5ygNuVvILoXVMMSabqqgeDYxtJLEoN5SWvjnAZObVWvOx
 0L9P71FsyDIlAooGf8Lbjv+svMFIjEnLPf4NqLYfEoXPu1DdU3ZJ1I+9OMeeN0bdk5/C
 eYf6G/kGWJXTzNUtsG1bXu9EoX5XEdws4jsq3T3eNxh1uqf0Yfn6o8UQkiNdazwp4xrH
 EirS7kKGM6mVZ6NBMfdDDvMGHo0mBcs7elVIYHkWmr/Gxjr5OdMzdFzsmw2AJZ6ZXmfI
 pyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779075793; x=1779680593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUA3cPtzM9uPcBkOLN0h00OZZHnDRsQ9uXVemg5h2Eg=;
 b=U50wLaP+dWOkfzyBzX1zAcgswX54MmpXUUcyjL2+ZTpQYuVBDsY2QxLB/geaKQhhQx
 GzakkkT5g9RI9wih+cznHDmgpts9X+L/qx/BG3u6/ciHmoRfhs/U8HncAGqljRSAE+yy
 YrsdEBUo7VN91bBMgFnq/rVoTD/oIFnuebukGIV8B6uoOb0lPUdEThR0XRRvHz/Eedls
 dFkYRFljLQMJvaNApI8ObDq8C+qTVQSQQTCVATafoPVd75+Z4KVICaqLM2Y5Zj2zbEtF
 8jxHOfvkwQquJT29EFdNPeH66l47jiVKS647hp1d+9cE6Ki0y+aorLo3unYD95FWFfHb
 Bqpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hRhc7OqqYu1yTOP/4HUgKwJScuYVPtrF+aPsc4guhdKyUmMUdai36mqxRms1TRBdxc8QTEaaPuKw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7v8j0p/O3kjYL85uxGS4IkJuJZk2MQvCQCzq+acZhgi9jFnXU
 8Gx5DHR4nrH6Q6qCk1A8b1id0AN12P1Xh8sAffb62mahnPbIAX1r178M
X-Gm-Gg: Acq92OEs9E84clUuEcpUZGMfIhXVAbcdBwkwKSqAtrZMWb31xlcDFd7qfm34+l0QDYQ
 uK1OODwPuYBwXxLVz6FEEWYKNL9TKSAo6whOBsGl+Wawbcxn0zBQuBWUJBG87LUBaV38HX9zNlt
 gocHFieiBHOEZC+TBJ7mNNnom9WWAG+Zly4VRJwsfrdPuazKVIpuW4ZIzWF/vf9bD3ACqmfMTWZ
 ncwpqM9JsFfk6ovu+FIYxKSN7HOBdjl/CAN5eEh7CrZzAdCnTy27ga5NJa2JXQ7A9RxEP1ca/Iz
 w3lm06GOCzDHfuLmYjuh8mXeFy5ixh5++FxwflSKU+nMqVnvchYVHYBMTjS/P4D29FbmZQiZ4bS
 +9IJXfzwTq8Voe/OJ5JmfnzVvWH5FZWGf0JqINbXtiZZSfAbV+8FhlkV3Mn+opk71CXfVoDi5GD
 tuK7tYSmjt9oyNV8QAhgQ1/siVq/WwXaytPzdKf3TSxKwPDyIrLPTHvJquJSSqnB1cLi4h0jNHS
 ymcuVhelU2EZUwLkv2umcHLD1fVqHC3HGAumGQyyGyQKeMc1MNfhXQc0Y/IhUj2zUofcBi1oqnz
 z5guZ/2/nldRhOOF
X-Received: by 2002:a05:6a00:1709:b0:82f:9aa:d63d with SMTP id
 d2e1a72fcca58-83f33d3337amr12698207b3a.49.1779075792455; 
 Sun, 17 May 2026 20:43:12 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net
 ([2601:1c0:5780:9200:790e:a8df:c769:91e7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196660f9sm15808366b3a.10.2026.05.17.20.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 20:43:11 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: sumit.semwal@linaro.org,
	neil.armstrong@linaro.org
Cc: dianders@chromium.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v2] drm/panel: novatek-nt36672a: Inline panel init sequences
Date: Sun, 17 May 2026 20:42:52 -0700
Message-ID: <20260518034252.16337-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Inline the panel initialization command sequences and remove the
table-based command abstraction used by the NT36672A panel driver.

Replace the nt36672a_panel_cmd tables and nt36672a_send_cmds()
helper with explicit initialization functions using
mipi_dsi_dcs_write_seq_multi() and
mipi_dsi_dcs_write_var_seq_multi() directly.

This improves readability by making the panel programming sequence
explicit in code and allows future sharing of common command
subsequences between panels. It also removes an unnecessary wrapper
around the MIPI DSI helpers.

Additionally, compress repeated register writes into small loops where
appropriate to reduce duplication in the initialization sequences.

Add:
tianma_fhd_video_on_init_1()
tianma_fhd_video_on_init_2()
tianma_fhd_video_off_init()

Update nt36672a_panel_desc to use function pointers for panel init
sequences and invoke them directly from prepare/unprepare paths.

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
Changes in v2:
- Replace command tables with explicit init functions
- Remove nt36672a_send_cmds() helper entirely
- Use mipi_dsi_dcs_write_seq_multi() directly
- Use mipi_dsi_dcs_write_var_seq_multi() loops for repeated register writes
- Convert nt36672a_panel_desc command table fields to function pointers
---
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 522 +++++++-----------
 1 file changed, 186 insertions(+), 336 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 7e8b5e059575..4c706c6e9b1c 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -28,10 +28,6 @@
 
 #include <video/mipi_display.h>
 
-struct nt36672a_panel_cmd {
-	const char data[2];
-};
-
 static const char * const nt36672a_regulator_names[] = {
 	"vddio",
 	"vddpos",
@@ -55,13 +51,9 @@ struct nt36672a_panel_desc {
 	enum mipi_dsi_pixel_format format;
 	unsigned int lanes;
 
-	unsigned int num_on_cmds_1;
-	const struct nt36672a_panel_cmd *on_cmds_1;
-	unsigned int num_on_cmds_2;
-	const struct nt36672a_panel_cmd *on_cmds_2;
-
-	unsigned int num_off_cmds;
-	const struct nt36672a_panel_cmd *off_cmds;
+	void (*on_init_1)(struct mipi_dsi_multi_context *dsi_ctx);
+	void (*on_init_2)(struct mipi_dsi_multi_context *dsi_ctx);
+	void (*off_init)(struct mipi_dsi_multi_context *dsi_ctx);
 };
 
 struct nt36672a_panel {
@@ -79,19 +71,6 @@ static inline struct nt36672a_panel *to_nt36672a_panel(struct drm_panel *panel)
 	return container_of(panel, struct nt36672a_panel, base);
 }
 
-static void nt36672a_send_cmds(struct mipi_dsi_multi_context *dsi_ctx,
-			       const struct nt36672a_panel_cmd *cmds, int num)
-{
-	unsigned int i;
-
-	for (i = 0; i < num; i++) {
-		const struct nt36672a_panel_cmd *cmd = &cmds[i];
-
-		/* cmd->data[0] is the DCS command, cmd->data[1] is the parameter */
-		mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd->data, sizeof(cmd->data));
-	}
-}
-
 static void nt36672a_panel_power_off(struct drm_panel *panel)
 {
 	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
@@ -110,8 +89,8 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->link };
 
 	/* send off cmds */
-	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->off_cmds,
-			   pinfo->desc->num_off_cmds);
+	if (pinfo->desc->off_init)
+		pinfo->desc->off_init(&dsi_ctx);
 
 	/* Reset error to continue with display off even if send_cmds failed */
 	dsi_ctx.accum_err = 0;
@@ -162,8 +141,8 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 	dsi_ctx.accum_err = nt36672a_panel_power_on(pinfo);
 
 	/* send first part of init cmds */
-	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_1,
-			   pinfo->desc->num_on_cmds_1);
+	if (pinfo->desc->on_init_1)
+		pinfo->desc->on_init_1(&dsi_ctx);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
@@ -173,8 +152,8 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
 	/* Send rest of the init cmds */
-	nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_2,
-			   pinfo->desc->num_on_cmds_2);
+	if (pinfo->desc->on_init_2)
+		pinfo->desc->on_init_2(&dsi_ctx);
 
 	mipi_dsi_msleep(&dsi_ctx, 120);
 
@@ -213,310 +192,184 @@ static const struct drm_panel_funcs panel_funcs = {
 	.get_modes = nt36672a_panel_get_modes,
 };
 
-static const struct nt36672a_panel_cmd tianma_fhd_video_on_cmds_1[] = {
+static void tianma_fhd_video_on_init_1(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	u8 reg;
+
 	/* skin enhancement mode */
-	{ .data = {0xFF, 0x22} },
-	{ .data = {0x00, 0x40} },
-	{ .data = {0x01, 0xC0} },
-	{ .data = {0x02, 0x40} },
-	{ .data = {0x03, 0x40} },
-	{ .data = {0x04, 0x40} },
-	{ .data = {0x05, 0x40} },
-	{ .data = {0x06, 0x40} },
-	{ .data = {0x07, 0x40} },
-	{ .data = {0x08, 0x40} },
-	{ .data = {0x09, 0x40} },
-	{ .data = {0x0A, 0x40} },
-	{ .data = {0x0B, 0x40} },
-	{ .data = {0x0C, 0x40} },
-	{ .data = {0x0D, 0x40} },
-	{ .data = {0x0E, 0x40} },
-	{ .data = {0x0F, 0x40} },
-	{ .data = {0x10, 0x40} },
-	{ .data = {0x11, 0x50} },
-	{ .data = {0x12, 0x60} },
-	{ .data = {0x13, 0x70} },
-	{ .data = {0x14, 0x58} },
-	{ .data = {0x15, 0x68} },
-	{ .data = {0x16, 0x78} },
-	{ .data = {0x17, 0x77} },
-	{ .data = {0x18, 0x39} },
-	{ .data = {0x19, 0x2D} },
-	{ .data = {0x1A, 0x2E} },
-	{ .data = {0x1B, 0x32} },
-	{ .data = {0x1C, 0x37} },
-	{ .data = {0x1D, 0x3A} },
-	{ .data = {0x1E, 0x40} },
-	{ .data = {0x1F, 0x40} },
-	{ .data = {0x20, 0x40} },
-	{ .data = {0x21, 0x40} },
-	{ .data = {0x22, 0x40} },
-	{ .data = {0x23, 0x40} },
-	{ .data = {0x24, 0x40} },
-	{ .data = {0x25, 0x40} },
-	{ .data = {0x26, 0x40} },
-	{ .data = {0x27, 0x40} },
-	{ .data = {0x28, 0x40} },
-	{ .data = {0x2D, 0x00} },
-	{ .data = {0x2F, 0x40} },
-	{ .data = {0x30, 0x40} },
-	{ .data = {0x31, 0x40} },
-	{ .data = {0x32, 0x40} },
-	{ .data = {0x33, 0x40} },
-	{ .data = {0x34, 0x40} },
-	{ .data = {0x35, 0x40} },
-	{ .data = {0x36, 0x40} },
-	{ .data = {0x37, 0x40} },
-	{ .data = {0x38, 0x40} },
-	{ .data = {0x39, 0x40} },
-	{ .data = {0x3A, 0x40} },
-	{ .data = {0x3B, 0x40} },
-	{ .data = {0x3D, 0x40} },
-	{ .data = {0x3F, 0x40} },
-	{ .data = {0x40, 0x40} },
-	{ .data = {0x41, 0x40} },
-	{ .data = {0x42, 0x40} },
-	{ .data = {0x43, 0x40} },
-	{ .data = {0x44, 0x40} },
-	{ .data = {0x45, 0x40} },
-	{ .data = {0x46, 0x40} },
-	{ .data = {0x47, 0x40} },
-	{ .data = {0x48, 0x40} },
-	{ .data = {0x49, 0x40} },
-	{ .data = {0x4A, 0x40} },
-	{ .data = {0x4B, 0x40} },
-	{ .data = {0x4C, 0x40} },
-	{ .data = {0x4D, 0x40} },
-	{ .data = {0x4E, 0x40} },
-	{ .data = {0x4F, 0x40} },
-	{ .data = {0x50, 0x40} },
-	{ .data = {0x51, 0x40} },
-	{ .data = {0x52, 0x40} },
-	{ .data = {0x53, 0x01} },
-	{ .data = {0x54, 0x01} },
-	{ .data = {0x55, 0xFE} },
-	{ .data = {0x56, 0x77} },
-	{ .data = {0x58, 0xCD} },
-	{ .data = {0x59, 0xD0} },
-	{ .data = {0x5A, 0xD0} },
-	{ .data = {0x5B, 0x50} },
-	{ .data = {0x5C, 0x50} },
-	{ .data = {0x5D, 0x50} },
-	{ .data = {0x5E, 0x50} },
-	{ .data = {0x5F, 0x50} },
-	{ .data = {0x60, 0x50} },
-	{ .data = {0x61, 0x50} },
-	{ .data = {0x62, 0x50} },
-	{ .data = {0x63, 0x50} },
-	{ .data = {0x64, 0x50} },
-	{ .data = {0x65, 0x50} },
-	{ .data = {0x66, 0x50} },
-	{ .data = {0x67, 0x50} },
-	{ .data = {0x68, 0x50} },
-	{ .data = {0x69, 0x50} },
-	{ .data = {0x6A, 0x50} },
-	{ .data = {0x6B, 0x50} },
-	{ .data = {0x6C, 0x50} },
-	{ .data = {0x6D, 0x50} },
-	{ .data = {0x6E, 0x50} },
-	{ .data = {0x6F, 0x50} },
-	{ .data = {0x70, 0x07} },
-	{ .data = {0x71, 0x00} },
-	{ .data = {0x72, 0x00} },
-	{ .data = {0x73, 0x00} },
-	{ .data = {0x74, 0x06} },
-	{ .data = {0x75, 0x0C} },
-	{ .data = {0x76, 0x03} },
-	{ .data = {0x77, 0x09} },
-	{ .data = {0x78, 0x0F} },
-	{ .data = {0x79, 0x68} },
-	{ .data = {0x7A, 0x88} },
-	{ .data = {0x7C, 0x80} },
-	{ .data = {0x7D, 0x80} },
-	{ .data = {0x7E, 0x80} },
-	{ .data = {0x7F, 0x00} },
-	{ .data = {0x80, 0x00} },
-	{ .data = {0x81, 0x00} },
-	{ .data = {0x83, 0x01} },
-	{ .data = {0x84, 0x00} },
-	{ .data = {0x85, 0x80} },
-	{ .data = {0x86, 0x80} },
-	{ .data = {0x87, 0x80} },
-	{ .data = {0x88, 0x40} },
-	{ .data = {0x89, 0x91} },
-	{ .data = {0x8A, 0x98} },
-	{ .data = {0x8B, 0x80} },
-	{ .data = {0x8C, 0x80} },
-	{ .data = {0x8D, 0x80} },
-	{ .data = {0x8E, 0x80} },
-	{ .data = {0x8F, 0x80} },
-	{ .data = {0x90, 0x80} },
-	{ .data = {0x91, 0x80} },
-	{ .data = {0x92, 0x80} },
-	{ .data = {0x93, 0x80} },
-	{ .data = {0x94, 0x80} },
-	{ .data = {0x95, 0x80} },
-	{ .data = {0x96, 0x80} },
-	{ .data = {0x97, 0x80} },
-	{ .data = {0x98, 0x80} },
-	{ .data = {0x99, 0x80} },
-	{ .data = {0x9A, 0x80} },
-	{ .data = {0x9B, 0x80} },
-	{ .data = {0x9C, 0x80} },
-	{ .data = {0x9D, 0x80} },
-	{ .data = {0x9E, 0x80} },
-	{ .data = {0x9F, 0x80} },
-	{ .data = {0xA0, 0x8A} },
-	{ .data = {0xA2, 0x80} },
-	{ .data = {0xA6, 0x80} },
-	{ .data = {0xA7, 0x80} },
-	{ .data = {0xA9, 0x80} },
-	{ .data = {0xAA, 0x80} },
-	{ .data = {0xAB, 0x80} },
-	{ .data = {0xAC, 0x80} },
-	{ .data = {0xAD, 0x80} },
-	{ .data = {0xAE, 0x80} },
-	{ .data = {0xAF, 0x80} },
-	{ .data = {0xB7, 0x76} },
-	{ .data = {0xB8, 0x76} },
-	{ .data = {0xB9, 0x05} },
-	{ .data = {0xBA, 0x0D} },
-	{ .data = {0xBB, 0x14} },
-	{ .data = {0xBC, 0x0F} },
-	{ .data = {0xBD, 0x18} },
-	{ .data = {0xBE, 0x1F} },
-	{ .data = {0xBF, 0x05} },
-	{ .data = {0xC0, 0x0D} },
-	{ .data = {0xC1, 0x14} },
-	{ .data = {0xC2, 0x03} },
-	{ .data = {0xC3, 0x07} },
-	{ .data = {0xC4, 0x0A} },
-	{ .data = {0xC5, 0xA0} },
-	{ .data = {0xC6, 0x55} },
-	{ .data = {0xC7, 0xFF} },
-	{ .data = {0xC8, 0x39} },
-	{ .data = {0xC9, 0x44} },
-	{ .data = {0xCA, 0x12} },
-	{ .data = {0xCD, 0x80} },
-	{ .data = {0xDB, 0x80} },
-	{ .data = {0xDC, 0x80} },
-	{ .data = {0xDD, 0x80} },
-	{ .data = {0xE0, 0x80} },
-	{ .data = {0xE1, 0x80} },
-	{ .data = {0xE2, 0x80} },
-	{ .data = {0xE3, 0x80} },
-	{ .data = {0xE4, 0x80} },
-	{ .data = {0xE5, 0x40} },
-	{ .data = {0xE6, 0x40} },
-	{ .data = {0xE7, 0x40} },
-	{ .data = {0xE8, 0x40} },
-	{ .data = {0xE9, 0x40} },
-	{ .data = {0xEA, 0x40} },
-	{ .data = {0xEB, 0x40} },
-	{ .data = {0xEC, 0x40} },
-	{ .data = {0xED, 0x40} },
-	{ .data = {0xEE, 0x40} },
-	{ .data = {0xEF, 0x40} },
-	{ .data = {0xF0, 0x40} },
-	{ .data = {0xF1, 0x40} },
-	{ .data = {0xF2, 0x40} },
-	{ .data = {0xF3, 0x40} },
-	{ .data = {0xF4, 0x40} },
-	{ .data = {0xF5, 0x40} },
-	{ .data = {0xF6, 0x40} },
-	{ .data = {0xFB, 0x1} },
-	{ .data = {0xFF, 0x23} },
-	{ .data = {0xFB, 0x01} },
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x22);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x00, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0xC0);
+	for (reg = 0x02; reg <= 0x10; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x11, 0x50);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x12, 0x60);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x13, 0x70);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x14, 0x58);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x15, 0x68);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x16, 0x78);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x17, 0x77);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x18, 0x39);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x19, 0x2D);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1A, 0x2E);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1B, 0x32);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1C, 0x37);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1D, 0x3A);
+	for (reg = 0x1E; reg <= 0x28; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2D, 0x00);
+	for (reg = 0x2F; reg <= 0x3B; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3D, 0x40);
+	for (reg = 0x3F; reg <= 0x52; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x54, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0xFE);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x56, 0x77);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x58, 0xCD);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x59, 0xD0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5A, 0xD0);
+	for (reg = 0x5B; reg <= 0x6F; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x50);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x70, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x71, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x72, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x73, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x74, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x75, 0x0C);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x76, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x77, 0x09);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x78, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x79, 0x68);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7A, 0x88);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7C, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7D, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7E, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7F, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x81, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x83, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x85, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x86, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x87, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x88, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x89, 0x91);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8A, 0x98);
+	for (reg = 0x8B; reg <= 0x9F; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA0, 0x8A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA2, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA6, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xA7, 0x80);
+	for (reg = 0xA9; reg <= 0xAF; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB7, 0x76);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB8, 0x76);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xB9, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBA, 0x0D);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBB, 0x14);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBC, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBD, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBE, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xBF, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC0, 0x0D);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC1, 0x14);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC2, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC3, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC4, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC5, 0xA0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC6, 0x55);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC7, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC8, 0x39);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC9, 0x44);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCA, 0x12);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xCD, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDB, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDC, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDD, 0x80);
+	for (reg = 0xE0; reg <= 0xE4; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x80);
+	for (reg = 0xE5; reg <= 0xF6; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFB, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x23);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFB, 0x01);
 	/* dimming enable */
-	{ .data = {0x01, 0x84} },
-	{ .data = {0x05, 0x2D} },
-	{ .data = {0x06, 0x00} },
-	 /* resolution 1080*2246 */
-	{ .data = {0x11, 0x01} },
-	{ .data = {0x12, 0x7B} },
-	{ .data = {0x15, 0x6F} },
-	{ .data = {0x16, 0x0B} },
-	 /* UI mode */
-	{ .data = {0x29, 0x0A} },
-	{ .data = {0x30, 0xFF} },
-	{ .data = {0x31, 0xFF} },
-	{ .data = {0x32, 0xFF} },
-	{ .data = {0x33, 0xFF} },
-	{ .data = {0x34, 0xFF} },
-	{ .data = {0x35, 0xFF} },
-	{ .data = {0x36, 0xFF} },
-	{ .data = {0x37, 0xFF} },
-	{ .data = {0x38, 0xFC} },
-	{ .data = {0x39, 0xF8} },
-	{ .data = {0x3A, 0xF4} },
-	{ .data = {0x3B, 0xF1} },
-	{ .data = {0x3D, 0xEE} },
-	{ .data = {0x3F, 0xEB} },
-	{ .data = {0x40, 0xE8} },
-	{ .data = {0x41, 0xE5} },
-	 /* STILL mode */
-	{ .data = {0x2A, 0x13} },
-	{ .data = {0x45, 0xFF} },
-	{ .data = {0x46, 0xFF} },
-	{ .data = {0x47, 0xFF} },
-	{ .data = {0x48, 0xFF} },
-	{ .data = {0x49, 0xFF} },
-	{ .data = {0x4A, 0xFF} },
-	{ .data = {0x4B, 0xFF} },
-	{ .data = {0x4C, 0xFF} },
-	{ .data = {0x4D, 0xED} },
-	{ .data = {0x4E, 0xD5} },
-	{ .data = {0x4F, 0xBF} },
-	{ .data = {0x50, 0xA6} },
-	{ .data = {0x51, 0x96} },
-	{ .data = {0x52, 0x86} },
-	{ .data = {0x53, 0x76} },
-	{ .data = {0x54, 0x66} },
-	 /* MOVING mode */
-	{ .data = {0x2B, 0x0E} },
-	{ .data = {0x58, 0xFF} },
-	{ .data = {0x59, 0xFF} },
-	{ .data = {0x5A, 0xFF} },
-	{ .data = {0x5B, 0xFF} },
-	{ .data = {0x5C, 0xFF} },
-	{ .data = {0x5D, 0xFF} },
-	{ .data = {0x5E, 0xFF} },
-	{ .data = {0x5F, 0xFF} },
-	{ .data = {0x60, 0xF6} },
-	{ .data = {0x61, 0xEA} },
-	{ .data = {0x62, 0xE1} },
-	{ .data = {0x63, 0xD8} },
-	{ .data = {0x64, 0xCE} },
-	{ .data = {0x65, 0xC3} },
-	{ .data = {0x66, 0xBA} },
-	{ .data = {0x67, 0xB3} },
-	{ .data = {0xFF, 0x25} },
-	{ .data = {0xFB, 0x01} },
-	{ .data = {0x05, 0x04} },
-	{ .data = {0xFF, 0x26} },
-	{ .data = {0xFB, 0x01} },
-	{ .data = {0x1C, 0xAF} },
-	{ .data = {0xFF, 0x10} },
-	{ .data = {0xFB, 0x01} },
-	{ .data = {0x51, 0xFF} },
-	{ .data = {0x53, 0x24} },
-	{ .data = {0x55, 0x00} },
-};
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x84);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x2D);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0x00);
+	/* resolution 1080*2246 */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x11, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x12, 0x7B);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x15, 0x6F);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x16, 0x0B);
+	/* UI mode */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x29, 0x0A);
+	for (reg = 0x30; reg <= 0x37; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x38, 0xFC);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x39, 0xF8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3A, 0xF4);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3B, 0xF1);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3D, 0xEE);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3F, 0xEB);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x40, 0xE8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x41, 0xE5);
+	/* STILL mode */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2A, 0x13);
+	for (reg = 0x45; reg <= 0x4C; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x4D, 0xED);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x4E, 0xD5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x4F, 0xBF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x50, 0xA6);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0x96);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x52, 0x86);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x76);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x54, 0x66);
+	/* MOVING mode */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2B, 0x0E);
+	for (reg = 0x58; reg <= 0x5F; reg++)
+		mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, reg, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x60, 0xF6);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x61, 0xEA);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x62, 0xE1);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x63, 0xD8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x64, 0xCE);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x65, 0xC3);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x66, 0xBA);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x67, 0xB3);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x25);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFB, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x26);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFB, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1C, 0xAF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFB, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x00);
+}
 
-static const struct nt36672a_panel_cmd tianma_fhd_video_on_cmds_2[] = {
-	{ .data = {0xFF, 0x24} },
-	{ .data = {0xFB, 0x01} },
-	{ .data = {0xC3, 0x01} },
-	{ .data = {0xC4, 0x54} },
-	{ .data = {0xFF, 0x10} },
-};
+static void tianma_fhd_video_on_init_2(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x24);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFB, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC3, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC4, 0x54);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x10);
+}
 
-static const struct nt36672a_panel_cmd tianma_fhd_video_off_cmds[] = {
-	{ .data = {0xFF, 0x24} },
-	{ .data = {0xFB, 0x01} },
-	{ .data = {0xC3, 0x01} },
-	{ .data = {0xFF, 0x10} },
-};
+static void tianma_fhd_video_off_init(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x24);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFB, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xC3, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xFF, 0x10);
+}
 
 static const struct drm_display_mode tianma_fhd_video_panel_default_mode = {
 	.clock		= 161331,
@@ -546,12 +399,9 @@ static const struct nt36672a_panel_desc tianma_fhd_video_panel_desc = {
 			| MIPI_DSI_MODE_VIDEO_BURST,
 	.format = MIPI_DSI_FMT_RGB888,
 	.lanes = 4,
-	.on_cmds_1 = tianma_fhd_video_on_cmds_1,
-	.num_on_cmds_1 = ARRAY_SIZE(tianma_fhd_video_on_cmds_1),
-	.on_cmds_2 = tianma_fhd_video_on_cmds_2,
-	.num_on_cmds_2 = ARRAY_SIZE(tianma_fhd_video_on_cmds_2),
-	.off_cmds = tianma_fhd_video_off_cmds,
-	.num_off_cmds = ARRAY_SIZE(tianma_fhd_video_off_cmds),
+	.on_init_1 = tianma_fhd_video_on_init_1,
+	.on_init_2 = tianma_fhd_video_on_init_2,
+	.off_init = tianma_fhd_video_off_init,
 };
 
 static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
-- 
2.43.0

