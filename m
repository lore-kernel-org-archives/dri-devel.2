Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E26606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULNzeU0g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873771126C9;
	Thu, 26 Nov 2026 19:57:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B77B1126C9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:57:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B63B44513;
 Thu, 26 Nov 2026 19:57:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795723036;
 b=t8mwHotVHgt31c45TQvzFwn+HjuXUev9wBCdQOI3fyIBivDoi4685b3QRc5cIwM1A3K8
 M5ulCc2T8Kr5JzfE9LRvK0bMnb1CRKbmzoVSDL4gflnTjjBSc9TGvkFNMZ6pWxOHR42mq
 JqyrLrhsKlZC5ilwusqyj/gnaxJJjMdwMNZxLIgj8z4bv5XieTKYQc07fdFa+26IfVEzE
 8TeMEJX9dJ+O/GxntUebrGySW5tw+vesafKZK8qEmOwfigp5YFCFiTL2PgyXCvr85oHgP
 i27TwExiDgxrsb1+jGlbZvHPF5IanBjALXrKub/snCPcQSKAT/hfy+S8Khfne4y7NRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795723036;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=kYIolTZOaGO02lBs++Pdnq7kusqGx5qbcMYAzzM852w=;
 b=v6izA4OcQleKNy/U+kXx8rVCO5d5PVCifYTxG43tKp6VPYalpU22OP9bg2RaUxl0DxTl
 oXKTls7ZYhCtPifhbl3MD9XoHtbPwFPeSUc5t77iTHtUUY4EAzIGGN/m4kPoLnkQ4fYt9
 6jDq8332biciNfibDFzN9yjpHORCuXZ21we/ij4ilzPjpRCzgZ45bomCAM6Wkv+MBAEd5
 LeqkJiR68aQkW2GTinC2NPrgxQnGYjmYbg5CxYFLzCxhyWRiVsXjHzZTZEWHybXCoFKEg
 JnBCW04miM35HEA4Vbe/bYKzhT+asxTPDsLVf0CjGsiQE6oJ0UEGxZcGbKYfTloRS9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 794D11F000C6;
 Thu, 26 Nov 2026 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795723036;
 bh=kYIolTZOaGO02lBs++Pdnq7kusqGx5qbcMYAzzM852w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ULNzeU0gNL35tSQSo8c5KRGOM2JpUskxjd/A8vKbmjUFei3UeJxJOODq5S22qiHWR
 NEKarydzZaChRT9E6PK1c8KXwUAIRAgFaCG8WiKHqnRh/mG5AcXKcpXtaLw4q1TtgM
 xt6sObfBVUdgarDjvGgw8v7MzNjy+i+QHBwGoYHMTFLml9QZuB+3vyEJZuchKm3IRZ
 SOhCUqrfTB9p3OydzspOUAMx4f5DULEYwzgqkNxFaz0XdDN4W/MP6LQvvi9R1g+cj7
 fQMlIPO5C5gNRIYyYjJdAlXKGQOD6VAxZDrmmhSi5DSKnsBOz6PKqdz78EVb0y7N7l
 jSWVgsvPqI6Tw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F3FE14D7DE;
 Thu, 26 Nov 2026 19:57:08 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 26 Nov 2026 20:57:06 +0100
Subject: [PATCH v2 1/2] drm/panel: visionox-rm69299: Move off/sleep DSI
 commands to disable()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-visionox-rm69299-enable-v2-1-d4aca6d50b05@ixit.cz>
References: <20261126-visionox-rm69299-enable-v2-0-d4aca6d50b05@ixit.cz>
In-Reply-To: <20261126-visionox-rm69299-enable-v2-0-d4aca6d50b05@ixit.cz>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Douglas Anderson <dianders@chromium.org>
Cc: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3368; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=ODLUdVqqZDVzp6HxRo+ng6wE6lOMHsVBXAhA1NRhFC4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrCI8TSpYwR01X4M7UPRARbFl90OooBrcO5ojTS
 zNzwvs7IkaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawiPEwAKCRBgAj/E00kg
 clXiD/9WUyZWOQQomJwX71GUODDw1La2/wOuv7wOkBBXeSpFTfQ30X25XQeYvMl3u78N7LvhCvD
 YjWnm48ejDRgdPPs+aBDg9PmVNHIkzvkcTfhMXJ32sKlu82VPcf04L3RvqrDgA/2QH9wyWiiNCT
 bDk5WSnHWrH89nhAYHCbNOTjua54ZYLoHOASHxenyUwP66YQbkWePhfeSKfOLiyC42yzQFPZH87
 qi9hIQ+yk0m/0QtypsW6fMEoTKicJxSpBlvLjnt6MPqEgwjbeTiGtnzVboCGGPpdKuTAeVWFqSr
 yw6tWzzuyu0iVa9PaP0k5/1QUns8pS72RIZbnwokBLb4sc8lk5j8G5r+VsSuTjy4n5vTGh0cu1u
 3AlnizwH1J9fL8StZGJGdqqgJQfxHrhLnST9bVKt7hMw2YLhZShzxdRf44vKVtgZERKEJ6VpTlT
 z4DolX1QFS2MeRl5XipRiFP9O3B+3/6XaJJO2y23n0cnb0rw4sG1GC6+WITTqChhP5sLtDCJgKk
 l4/0K1lC9c+0CkhJ0ef+yiZIvfuDL2lHVE7OauRXv04A86DnLUSoPfpOJEY13rBGc6X0TgnUKGL
 bmk6oawTqqK33j6NC7yisVQWaVkz6boSoeIG459gkrxYapXkb5FozpKmvM8sROleZLorIakSvm7
 soyUF5l5SngwNqA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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

From: Guido Günther <agx@sigxcpu.org>

With prepare_prev_first set, DRM calls visionox_rm69299_unprepare()
after the display controller timing engine has been stopped and before
the DSI host bridge post_disable() resets the video engine. Sending the
display-off and enter-sleep DCS commands from unprepare() therefore
causes DSI timeouts on every screen blank/unblank on the SHIFT6mq:

dmesg:
  msm_dsi ae94000.dsi: [drm:dsi_cmds2buf_tx] *ERROR* wait for video done timed out
  dsi_cmds2buf_tx: cmd dma tx failed, type=0x5, data0=0x28, len=4, ret=-110
  panel-visionox-rm69299 ae94000.dsi.0: sending DCS SET_DISPLAY_OFF failed: -110

Move the display-off and enter-sleep DCS commands into a new disable()
callback so they execute while the DSI link is still active, while
keeping the power-on and initialization commands in prepare() where the
link is in LP11 before video starts.

Fixes: 4a92ef0c57df ("drm/panel: visionox-rm69299: Make use of prepare_prev_first")
Signed-off-by: Guido Günther <agx@sigxcpu.org>
[David: keep power-on and init commands in prepare() per v1 review]
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 4309e04c35c4b..bca1004656e45 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -184,30 +184,37 @@ static int visionox_rm69299_power_on(struct visionox_rm69299 *ctx)
 static int visionox_rm69299_power_off(struct visionox_rm69299 *ctx)
 {
 	gpiod_set_value(ctx->reset_gpio, 0);
 
 	return regulator_bulk_disable(ARRAY_SIZE(visionox_rm69299_supplies),
 				      ctx->supplies);
 }
 
-static int visionox_rm69299_unprepare(struct drm_panel *panel)
+static int visionox_rm69299_disable(struct drm_panel *panel)
 {
 	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
 	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
 	/* 120ms delay required here as per DCS spec */
 	mipi_dsi_msleep(&dsi_ctx, 120);
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
+	return dsi_ctx.accum_err;
+}
+
+static int visionox_rm69299_unprepare(struct drm_panel *panel)
+{
+	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
+
 	return visionox_rm69299_power_off(ctx);
 }
 
 static int visionox_rm69299_prepare(struct drm_panel *panel)
 {
 	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 	int ret, i;
@@ -277,16 +284,17 @@ static int visionox_rm69299_get_modes(struct drm_panel *panel,
 	connector->display_info.height_mm = 131;
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 	drm_mode_probed_add(connector, mode);
 
 	return 1;
 }
 
 static const struct drm_panel_funcs visionox_rm69299_drm_funcs = {
+	.disable = visionox_rm69299_disable,
 	.unprepare = visionox_rm69299_unprepare,
 	.prepare = visionox_rm69299_prepare,
 	.get_modes = visionox_rm69299_get_modes,
 };
 
 static int visionox_rm69299_bl_get_brightness(struct backlight_device *bl)
 {
 	struct mipi_dsi_device *dsi = bl_get_data(bl);

-- 
2.55.0


