Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A51606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8kU879l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582E510FC1B;
	Wed, 25 Nov 2026 13:08:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3714F10FC13
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:08:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1934E41FE4;
 Wed, 25 Nov 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795612110;
 b=zpbniVTClbb1GvTeaXDG8tpoF0LmbNlgQsrBtUzUREmmbWhsmrxTF5YU4HLluJeahuFy
 i+iNpnYQ7UdxaKAECYydGtWUh7kw4TExxVt1z/DNrLYhFRDIj/m37eI3c6Bs4Yxcces3S
 F3/RFtJn86uXwPa6iLfT5LZt+e8jbUKCqFxVaBcPPmYOCkmL1+t5pAnunlCcGSi7zR1/T
 aGZyjUp/JYnXYMj6Z6yaGQvZ3c6woT1rzqyK1w20vkVET3OgFcNg+NM/I9k8tcGoxel1S
 u1Rva8gRm6J1PcsMEchW8c0pUMCq8i8LUOec+x2vrXg8sAxgyQKB6y/pCOhYAGtutpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795612110;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ONotlEahceqvdW/gLtVb9KiwJj5aa1h7mJqg2zchc18=;
 b=wHEO9MJ8qnRvPAAxbC6hludEV5h8QCQaGKZM6LiVCr2mkvOgxOfvL24iMuJSxZ29LElS
 kEYlu8A5Conj6e3Jp9tlXJmuRrWnFRa43UAwhm10sBAzUuJqzCz1C0ACWgkWs8WhFfjqZ
 EzvB8BDjo5QSVo+bZKWdTsZFHvbk+rW+JnOjK6IaDOgehN5M5YlxdRj766Yg9pqzpygBg
 U909CQlfy0g7xzY2MthJUcR6ACuC1szE8wVijurjXXVfA/kcZi2GYk1VXQk3toWiBhf48
 wHblDKeZ1ZkJgt64p5wnw1V78JOnTo24dAUgVJ8NLxnQgHT/5GJ4tRiLi0CqBhpf1Vw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id AAB181F000D4;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795612110;
 bh=ONotlEahceqvdW/gLtVb9KiwJj5aa1h7mJqg2zchc18=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=h8kU879lRc8nNshFokznjEsV7dpssRl+52MbjF/LDds2bZNG6U7aIZBCaSyk14Jhm
 4KAPZI2CFahn0trjVMmQNB4t8dua9T4J0u8AaToYoMg6DpuHskaqpJQAp0lnHUBayl
 K1bH6dWLKKOAT5i2q/sPl0WBwmZ9EsvtkHWMxnqRRjfyC/N4101YSH8XX7ZOhrqtja
 nQm3Yl6F69rNbaViXtwXCJ3wlJomLVKdUND/IFftEkq5PAp/JK376P8v5tW5xOr0jD
 LX24BU5wPkod/gUG4j1pd7VYbfRJIKP2XCN0ZNkb/cKMPJ+PPLuFrDAJm4EmlvIYld
 2RcVUL5Vcur1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 329984CED5;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 14:08:14 +0100
Subject: [PATCH v3 3/5] drm/panel: lg-sw43408: split enable/disable from
 prepare/unprepare
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-fix-blueline-panel-v3-3-914b4a30b73e@ixit.cz>
References: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
In-Reply-To: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4437; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=zdOJs/tIhku4VxDIOc1H243ngJpi3Zm+4lt2IgEmTVw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrBt3Bf171PFCQnMrQaSWl6YXnE+4lvjdQyX06n
 wc5wsUTR5WJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawbdwQAKCRBgAj/E00kg
 cuNXD/4ok4+agFZwcqrAuGR8XEjNPAhQyceNnZ/0Iz3hBcBqg01F8hFfjRTyH0Soh2+FxGfUzgL
 qx0tLQoYYYGaTeoCerCo/qsN7kKHYh/09HrvZ8Y/4z/zedIhJdqJ9CUr5LG4M4VwKIWbP9BEQ40
 oQTK04gykgptY28k5lAboZhvK3tIAoU/4Zsc8hR1D5Kh8D5mQxedbXjnXgznvToUPVPRmNKheG/
 thtjsMX1pwlzMRx1Dbcq/D0y6GbvkgYKPTM7ioquxTP8QTdFt1w1p5pMO8RXWw3hevC2QldreKs
 ISYO6rU6wLUyxurWZf4Cm1GIYAZApbXcBn5LUnPx2gbYtl7AkxU1+V4OXOlnG9iCcKSybsco2+x
 twcr4ChMWQoTylfS8/WDAManw9yEO/MhLMbXF423t9nfTAxCvo+FVng8SN76UAZHy+UwJKRD1j7
 VQw7F/69yRtp+zirFxaEArEvkVQaPfUVkOw3x6jFt/104WW5NRTEGfOeQflFUBoGRrDoCaD5Rsl
 yC1dIx6R+8kO8z86NoNzFrgWql7qvDpPqA5Vpt/uU64WL3OmtJeW4ouaztFPBcws0O1iK31x092
 mQ78CXza/wVbRb0OX4BtW8gIhFQl59hf4eUrc4BunDSeM7U6Gy7vLvIjRM6yluaQ7t5bfB/1Uzl
 UmOSZiuIzOECSew==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

Separate display blanking (enable/disable) from panel power sequencing
(prepare/unprepare), matching DRM panel conventions and other SDM845
AMOLED panel drivers:

- Move MIPI_DCS_SET_DISPLAY_OFF, MIPI_DCS_ENTER_SLEEP_MODE, and the
  100 ms sleep into sw43408_disable(), leaving sw43408_unprepare() to
  handle panel power-down.
- Move MIPI_DCS_SET_DISPLAY_ON and the 50 ms delay into sw43408_enable().

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 7f7d7b6b17f61..7123ad18744cf 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -38,33 +38,38 @@ struct sw43408_panel {
 	struct drm_dsc_config dsc;
 };
 
 static inline struct sw43408_panel *to_panel_info(struct drm_panel *panel)
 {
 	return container_of(panel, struct sw43408_panel, base);
 }
 
-static int sw43408_unprepare(struct drm_panel *panel)
+static int sw43408_disable(struct drm_panel *panel)
 {
 	struct sw43408_panel *sw43408 = to_panel_info(panel);
 	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
-	int ret;
 
 	mipi_dsi_dcs_set_display_off_multi(&ctx);
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
 	mipi_dsi_msleep(&ctx, 100);
 
-	gpiod_set_value(sw43408->reset_gpio, 1);
+	return ctx.accum_err;
+}
+
+static int sw43408_unprepare(struct drm_panel *panel)
+{
+	struct sw43408_panel *sw43408 = to_panel_info(panel);
 
-	ret = regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies), sw43408->supplies);
+	gpiod_set_value(sw43408->reset_gpio, 1);
 
-	return ret ? : ctx.accum_err;
+	return regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies),
+				      sw43408->supplies);
 }
 
 static int sw43408_program(struct drm_panel *panel)
 {
 	struct sw43408_panel *sw43408 = to_panel_info(panel);
 	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
 	struct drm_dsc_picture_parameter_set pps;
 
@@ -97,20 +102,16 @@ static int sw43408_program(struct drm_panel *panel)
 			       0x00, 0x00, 0x00, 0x19, 0x19, 0x19, 0x19, 0x19,
 			       0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19,
 			       0x16, 0x16);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x02, 0x02, 0x0f);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0xca);
 
-	mipi_dsi_dcs_set_display_on_multi(&ctx);
-
-	mipi_dsi_msleep(&ctx, 50);
-
 	sw43408->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	drm_dsc_pps_payload_pack(&pps, sw43408->link->dsc);
 
 	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
 
 	sw43408->link->mode_flags |= MIPI_DSI_MODE_LPM;
 
@@ -119,16 +120,27 @@ static int sw43408_program(struct drm_panel *panel)
 	 * PPS 1 if pps_identifier is 0
 	 * PPS 2 if pps_identifier is 1
 	 */
 	mipi_dsi_compression_mode_ext_multi(&ctx, true,
 					    MIPI_DSI_COMPRESSION_DSC, 1);
 	return ctx.accum_err;
 }
 
+static int sw43408_enable(struct drm_panel *panel)
+{
+	struct sw43408_panel *sw43408 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
+
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 50);
+
+	return ctx.accum_err;
+}
+
 static void sw43408_reset(struct sw43408_panel *ctx)
 {
 	gpiod_set_value(ctx->reset_gpio, 0);
 	usleep_range(9000, 10000);
 	gpiod_set_value(ctx->reset_gpio, 1);
 	usleep_range(1000, 2000);
 	gpiod_set_value(ctx->reset_gpio, 0);
 	usleep_range(9000, 10000);
@@ -217,18 +229,20 @@ static int sw43408_backlight_init(struct sw43408_panel *ctx)
 	if (IS_ERR(ctx->base.backlight))
 		return dev_err_probe(dev, PTR_ERR(ctx->base.backlight),
 				     "Failed to create backlight\n");
 
 	return 0;
 }
 
 static const struct drm_panel_funcs sw43408_funcs = {
+	.disable = sw43408_disable,
 	.unprepare = sw43408_unprepare,
 	.prepare = sw43408_prepare,
+	.enable = sw43408_enable,
 	.get_modes = sw43408_get_modes,
 };
 
 static const struct of_device_id sw43408_of_match[] = {
 	{ .compatible = "lg,sw43408", }, /* legacy */
 	{ .compatible = "lg,sw43408-lh546wf1-ed01", },
 	{ /* sentinel */ }
 };

-- 
2.55.0


