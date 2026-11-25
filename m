Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611E606A331
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POZ/j5hl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8298310E8E2;
	Wed, 25 Nov 2026 13:08:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CB310E8E2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:08:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A71861294;
 Wed, 25 Nov 2026 13:08:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795612105;
 b=SGvkDDEDRtU4Fuq/2fThCHqHJwVWqm3PO4CvvyW1PmjXuZ3GVGvXDhlj2pff34AHF/Oy
 lAiI6dB+z/rGOaX1VmjC7oGDVNxU8c5msQ2jkCkbA5CLuOjh+/DCYOhAq3zanWkbJrJIA
 /zxNDh4oLHgPrfQYCBlK0MIZbOh4AWvjWzzDMagkaLC2waAVBKzbNq8gDcnjCPeo+Vmmy
 /rSPtgEW0KVxdKCzofbDNW0NXwc2sUF+kXfcb9INPYnZbfcskjAm+gRhKa5Hy2Bnv4BkX
 CkJa1X9CSiqPfEvvP/wNaNEu+JW64ZOuEDj5rId7day5WiZtXiVLHBraGu4cVBkI5xg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795612105;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=f/FCqPMcelLJtnBc1Fj6P9Vb+dxo5SMFYG34OAlZLHo=;
 b=Pag9lHJkrC3QHBGQC6CxMKfuas6zbT2qxHIcC5YNzafFuKEAmTrJ22DzlbIxE4w4loul
 x6m9tP9FVvDcAOzPsl8ztXf34hKJ6kr7IhmFpuKP4PB+TC5hMd6Q519hE21+6Q2l6+E6a
 XelvL90gEOr4Pzb6x5HwsV852N6AKh7q3xSedIVsefvlW5oXJFzCU0E3XGk0R5LiIZPF/
 0iRTQfFAN73QPSfx+x6sEsP1VlBgx4DPfLxTADUGOeMXuMnRUUjvlxp8HQ9o5ojhvY58Y
 cojHi/A0IJIVpxnzT2nWtna1APLjWRRaCntOZu16Ll2hLMwVrXU40PbnBHOPM25aGfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8CB3E1F000D2;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795612105;
 bh=f/FCqPMcelLJtnBc1Fj6P9Vb+dxo5SMFYG34OAlZLHo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=POZ/j5hlAS5+Rq3H6o+PIOxHo6MPrORbfR5seEwA4KF5Vym8dLFLQ69/rZ0CVGwft
 EkIDzsoSQw0d3lDoYPYA5hnvBNne5wW0nfu8ZnJD/EfnPKm2+UZ47/QiEpkPPnrcKw
 2pkO6qndc+3DA+oOZbXe4kY1zJBBX+b/kU20MUgsE/QQCVqemap6Q0si54IktXu9Y2
 jup6b1PIo8WiLxhrW728icqVWJnpoR4CsVP2y9lmZECtXTyA0pQWuI03ZPGRnNkw1T
 L9N3SxIFORJFYoOrh23IJQUJVc0mXUokT3uJoosXi554iy2W9JeYwralrA4gatHCRL
 +s4DxfKIgFnvw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1513D4CED1;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 14:08:13 +0100
Subject: [PATCH v3 2/5] drm/panel: lg-sw43408: skip backlight updates when
 unprepared
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-fix-blueline-panel-v3-2-914b4a30b73e@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=eVtvNYF6Jw8G9i6E3BdhxsPEl/EphHJG2zF/4pJIRNY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrBt3BU/zs+0xLgw8sbeQMDWdbnEnjAHYDFIFcU
 a4B+64hqpeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawbdwQAKCRBgAj/E00kg
 crz7D/9B3BrWRhTlBxnU+3RW/MIdg6N0RlHDN9rWz2Szg9W0wGtGJ564NXWE5cemGMm6gqq6j1O
 oZQ45evMbnxKADAaBgshhOnaUdCFnHLQJEEPKPguHH0z1V7I/22q23Zap8QmaDY2+rR6jI1GMD2
 K9qvib52tQXT/UlPDtNC+KqyK0SoU+XdMSYSLaAhswWndbA7dcVpuJx5MyCb1PXOHdIjW/u4qFE
 MYrN+mosXGWVejeOu/M44ig39sQev97rKlUytd5X17Lm0nu/V5chi5QjnZHHAFxSbaAR3VjYudJ
 AQQ11Ia7+QbGNd2IBlB/cTIa6K6HysGOPfNVd/qOl5fDOhkFGHJzXLHco5IoANKWLHkUrp4wdpc
 kWAKomEwqm//8CirPVO0IE0hFRl5s6rbjfY+V18A9Ik0OCWT28x3k0HW3jp+RzyQw/OlVfjWXoZ
 o7c/I4WEGfF1nGP/1Y44XKNOkuVA3pEoUM8OKkP6/P/O5DNeEim9hLPP6qQm5PnYo2Ps8OJ4diY
 QduR3Dsxukuf7A8zoY45WvJxp41dJMB/N0WxCvwCmA8/f3Mwamvt9SwPC2QgCkPe1UPhw/3VfgH
 Q018ShRjmK/Ei3mwTqy+UJ2drkk9BM25uQuQQMxImX3U8PsNfH+KZ/NFQBHtmFC5cbNeIOhmXpg
 bqcOgQJisRC1+xg==
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

sw43408_backlight_update_status() unconditionally sends a MIPI DSI DCS
brightness command even when the panel is unprepared and the DSI host is
powered down, causing sysfs brightness writes while blanked to fail with
-EIO.

Pass struct sw43408_panel as the backlight device private data and return
early when !ctx->base.prepared, matching other mainline MIPI DSI panel
drivers.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 92cab6478ea61..7f7d7b6b17f61 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -181,20 +181,23 @@ static const struct drm_display_mode lh546wf1_ed01_mode = {
 static int sw43408_get_modes(struct drm_panel *panel,
 			     struct drm_connector *connector)
 {
 	return drm_connector_helper_get_modes_fixed(connector, &lh546wf1_ed01_mode);
 }
 
 static int sw43408_backlight_update_status(struct backlight_device *bl)
 {
-	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	struct sw43408_panel *ctx = bl_get_data(bl);
 	u16 brightness = backlight_get_brightness(bl);
 
-	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+	if (!ctx->base.prepared)
+		return 0;
+
+	return mipi_dsi_dcs_set_display_brightness_large(ctx->link, brightness);
 }
 
 static const struct backlight_ops sw43408_backlight_ops = {
 	.update_status = sw43408_backlight_update_status,
 };
 
 static int sw43408_backlight_init(struct sw43408_panel *ctx)
 {
@@ -202,17 +205,17 @@ static int sw43408_backlight_init(struct sw43408_panel *ctx)
 	const struct backlight_properties props = {
 		.type = BACKLIGHT_PLATFORM,
 		.brightness = 255,
 		/* HBM can go up to 1023, stay safe for now */
 		.max_brightness = 900,
 	};
 
 	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
-							     ctx->link,
+							     ctx,
 							     &sw43408_backlight_ops,
 							     &props);
 
 	if (IS_ERR(ctx->base.backlight))
 		return dev_err_probe(dev, PTR_ERR(ctx->base.backlight),
 				     "Failed to create backlight\n");
 
 	return 0;

-- 
2.55.0


