Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E0AFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0462310E599;
	Mon, 27 Apr 2026 14:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="A+7LVzbk";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="DKeTJJT9";
	dkim-atps=neutral
X-Greylist: delayed 506 seconds by postgrey-1.36 at gabe;
 Mon, 27 Apr 2026 14:05:11 UTC
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BBF10E2AF
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1777298206; bh=FI2xHZ5s53YZXM5tCMDJAEfMZ6Vuac8IhGFN2EN+Xu8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=A+7LVzbklL6nLRtUWQGNIT17f6AiEsKnmMo7ALCU6OSSm70+0xgDLtJMsLzqiFkjo
 AT8dpHIXtWBpQJHGavsFc8DTW9E7q7dwf7gPLRD6b7HAaxKPvpB4W2EgkC5ro9X6pF
 9q4osDrAFb2haSMysoCLb4eLVTToVbWe3A7YAszN9mE6gSOucGxacFE7A+49Lq4SjD
 WIc+JhHDTCXXMDqPCpt0sKa4eoYrZyw4rPUOf8JRwnpmm8rlcctZvJto7Qce7IcuvK
 HpBLwuf5X9SYC6JV49qV5rd62xQbR1+72TUk9doo6g/AT00b6L8f5kQC2mGndQs1zx
 gN0HflLr5XznA==
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 3D40EFB03;
 Mon, 27 Apr 2026 15:56:46 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QIjiA4jjUfz; Mon, 27 Apr 2026 15:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1777298196; bh=FI2xHZ5s53YZXM5tCMDJAEfMZ6Vuac8IhGFN2EN+Xu8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DKeTJJT9GiiYgL92RupQ2k66fxgsfcH64UFr6m42BbHxE1/6EKjCnFj0uSOWPDjad
 k+sl3it72Mj8f2ceqzS6J4WTZtnzS2U2nQ4w7f2vsC8Hf63xyDXBHDxVhPNS7M2VTU
 Kn0LVJ00ou6wgTWm79pBAx6ujMMdglXQMPkChhziDddjwKl4gUOI/nhfqHOq8XSZI7
 kNkTCAmt2VCZs8ofWOfXRFmwURF8YcSHt8sd/kuJnMSu4aOtaaGB7xhFfXtZd+mSL+
 9aXetmBOHgx8dPQ4X78KDf4TfjGvcY5mpiK0p2UeRhG2t6m7ZYOuIIq4kj0gfxjrHd
 szX/tX9Uu43dA==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Mon, 27 Apr 2026 15:56:07 +0200
Subject: [PATCH 2/2] drm/panel: visionox-rm69299: Move power_on/off into
 prepare/unprepare
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-visionox-rm69299-enable-v1-2-fa7d62d26d87@sigxcpu.org>
References: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
In-Reply-To: <20260427-visionox-rm69299-enable-v1-0-fa7d62d26d87@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=FI2xHZ5s53YZXM5tCMDJAEfMZ6Vuac8IhGFN2EN+Xu8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQnA3MnNTRTB4VWpXRnVPb0EvakMwdGRsaHJIZ04yCjlFbjgzUHN2S3FFcUJzbEYr
 dHlKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYWU5ckVnQUt
 DUkFsdjRaU1N2ekI0emJiRC85TlRKcDRDU1o3enRWUVFDdFFxOTdSNmFtbGVjZlVmbDRROWFIaQ
 pBaExpQ0lWdWtCMmNSeFppSk8xcEtGbjZnS2d1L3hjNUpnWHQra2ZhcDAvOW10R1p3NXh5U2U5c
 S9SREdGSExTClM0WU1sN0FDTkhpQjdYZ2VDMzcvbU5nTWNndGxpNEtoU1YwMWs0ZkhKWDdqM2I0
 ZGYvMFpXWGg2WGcwakwwWEgKeldrSUpBQzBjVEwwSHRuM0U0Y2pVQUVOSk9ZNjJJQWlqQk5SbU1
 VM1JXOXZtTXBQcEtFd0RRL3ZJV0ZCRzVhUgppcnhHS0hVWldKREVEYytXWm42VnFWM2YzNm8yY2
 9DTGppaDM5OTRmTSt6bzd4TkpWWFVUZkdZd0FObi9nOHV0CjZhMGI4VnF0dHlVOFUvSDk5cXJLN
 FVSQ2ZSUzlUVnhlalR4NW1kZm14eWRDZTZHVGVyLzdHb3g4a0FTUENIRkQKYmhKbk5WbVNNVlp5
 MGpkSDdmdlhUSjJlZCtKQklodXhxMlpsWDdwd0xERFZzaXltZURhVjhOVTI3ck5jNCtOOApRdVR
 KcW9lTXUzWENzZjFDWlF2OVZ5NFpHNXJyUElSWUVxVFNPclZhK0xRQWFNalpnc0VGWVV4U1EyL2
 MzNlNzClBYRWM0ZXRsbUFJZVJpdHFOdjFKZmh3ejdWdE8vbTZuUFF5d0gySklzY0QxbzExeWhie
 lptb3o0M21EeVJ6TFcKU3FLYnJMM0pQOEo3WUc1dVhici90Sk9CeEVPdGo3YS9abExUS0k0YWdQ
 Ynk5a3h5U20zRjJoMEJGcEJRV3VuQgpWUmRrdnYrbkZXV250amowQjVEU0cwa0lrY0t4ejZhMnV
 wWmIvbzhrQ2tYZkUvOWxzT1pqeFR2MGVQcDFONEpWCnlmOVdnZz09Cj1na3VSCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3
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

No need to have separate functions now that prepare/unprepare only
handle powering on & off.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 36 +++++++++-----------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 3c92a6ceb8df..5c869d353368 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -198,15 +198,25 @@ static int visionox_rm69299_disable(struct drm_panel *panel)
 	return dsi_ctx.accum_err;
 }
 
-static int visionox_rm69299_power_on(struct visionox_rm69299 *ctx)
+static int visionox_rm69299_unprepare(struct drm_panel *panel)
+{
+	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+
+	return regulator_bulk_disable(ARRAY_SIZE(visionox_rm69299_supplies),
+				      ctx->supplies);
+}
+
+static int visionox_rm69299_prepare(struct drm_panel *panel)
 {
 	int ret;
+	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(visionox_rm69299_supplies),
 				    ctx->supplies);
 	if (ret < 0)
 		return ret;
-
 	/*
 	 * Reset sequence of visionox panel requires the panel to be
 	 * out of reset for 10ms, followed by being held in reset
@@ -222,28 +232,6 @@ static int visionox_rm69299_power_on(struct visionox_rm69299 *ctx)
 	return 0;
 }
 
-static int visionox_rm69299_power_off(struct visionox_rm69299 *ctx)
-{
-	gpiod_set_value(ctx->reset_gpio, 0);
-
-	return regulator_bulk_disable(ARRAY_SIZE(visionox_rm69299_supplies),
-				      ctx->supplies);
-}
-
-static int visionox_rm69299_unprepare(struct drm_panel *panel)
-{
-	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
-
-	return visionox_rm69299_power_off(ctx);
-}
-
-static int visionox_rm69299_prepare(struct drm_panel *panel)
-{
-	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
-
-	return visionox_rm69299_power_on(ctx);
-}
-
 static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
 	.name = "1080x2248",
 	.clock = 158695,

-- 
2.53.0

