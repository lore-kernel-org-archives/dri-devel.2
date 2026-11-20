Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C503606A6EE
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weukMQDt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9874710E082;
	Fri, 20 Nov 2026 20:05:25 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CF910E082
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 20:05:19 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-4911df1e196so789767fac.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795205118; x=1795809918; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T9Xx4usP8rm74KCRP+cc35Zk5oNMrUUP5XG8xRlvNZA=;
 b=weukMQDtogxRdYzEo5FkyknQfjfDzPnITWXTC+N0Blw6BuhzKOTfFQkHfY8k6lSFGE
 7+whAwcS+2GOncYpGgV/L72d7k8Hb6qPKzULcZCH+1eSjKpNnaBbRXBArvblmP0qFdVe
 01EKgXSTs1S3EVzoVYcUDUNKUuyPK1GgFIzawwAxbyXarnl+sZwlSez3+RNKoveLZqr9
 PzmL5OBN1mPk9+OqUgsTa/fJ3JK18UpGWalLM4RTq0QXK5vj9xMWDnFtOe7DmDiAuQER
 Qw/8cMsWLYjdOaQpQbisJLyVAggxyKUgAUC+gk2Z95KSlLRn8SRLmN8YswT3FyvzcVbO
 JC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205118; x=1795809918;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T9Xx4usP8rm74KCRP+cc35Zk5oNMrUUP5XG8xRlvNZA=;
 b=Bl14xr4sZ4fyKv5F1WzPdE17AYhxQiaODVm2p5tmsGJvga+/4hVgLEW2oS1ELhgC8U
 jH6ztxJQ3I0MI5PGvYpGnmYWK1iB4gp+HjAEEMLBEnAsjNEqLO1IH+2v6x14ZUA+SZJV
 pj7d75cg6rGXM2KQ2BqcQlw6XlyB5mmg8Z1ofHaLssjj19Pc5SjEdFxE6Ac6G9BVy73W
 +TJBH0Mna6VOT1nKK+T9ft0q16W4loQQ2dDOKn7+CQM4hAMhoaugxZVeMiSP/wbkE4qX
 9YF2S+giI2uNC+snRaP8mBG3EpirIp1jdNEJhd8hIewH6uh9M+fLru4J/RROPfc3s54e
 WV9A==
X-Gm-Message-State: APuU4Z89ec/Lahs0NZVH63k+LAoRyfqK0O5U5QUNd/2/S0/ZsvJUS8Ry
 Niq3RlA9mwIa3m6/RqDuUu9b64XGsPT6qxTgnK9/yY3yAXehRNkdFPwk
X-Gm-Gg: AZFdTZfNl3Qgb1Rqs6yCpjKJ13YBkx2Xr7/rjMrc8j7ssMgldWjMdb9YWS8TL9tt3fN
 +BIwFIb7Ch4DcDQAbayOX8TvcRAMjfvtG3+W8XYfrpb/1k2MBknWah44chMIKFUbFGAoJ54yk6H
 VsdS1SWUkX6x3J1M1cksgDQrtSvsVEvuTMR33Tiw+KyzklujfXlT6J0DqwNFNjXaJ0QDIxTIwjX
 YHqi3ssMDZbExuKqgsnEDdHKxp1tnbTAbj2pIIUuPrFpN9u6nI6Nnqz7VD3hCAeUkeY7Bn088Oc
 D1JknVdqQoAd4S3EC8OnnN2rInKFdrrAqKdYYz/QyT4dqMqLkqVIUs6Y5ldDQVD9zhZSvW2IIDx
 s2OuLd/Rm0EDF6pY3cHTloYuPnMUnL5mpeMIv77VQBmGCexlZz6+lKIjfi184KrCBlwVkE6BR7r
 Xi7kHKtKeII/9RCIFbKiYyv8N0OdXZoUxB3HWNECZl4bywNhXoNQoDEBotWPSQtYLJodOBPpofh
 Pyt3oMgH9v7adHgqsqsbLZctMcmvjGdv0uQts/Zu975ML3eHV4fTYxmgXGRmS0UTdkmIXOjCe+U
 FrYXlRb9Yxc+YL6wr0XPz7B1n19xfpPbJfbVeP0OjrlHxr0esgTf+0Cp4VcErWG22sZbGplDLD4
 faDjNou9F26I8mSVHeOw=
X-Received: by 2002:a05:6870:4db:b0:4ad:8d9f:98a3 with SMTP id
 586e51a60fabf-4bc87de13e3mr3153094fac.35.1795205118467; 
 Fri, 20 Nov 2026 12:05:18 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5edc52aasm4122200fac.4.2026.11.20.12.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:17 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Fri, 20 Nov 2026 14:05:16 -0600
Subject: [PATCH] drm/mediatek: ovl: Report coverage blending on older SoCs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-rbrue-suez-mtk-ovl-coverage-v1-1-35040085fc37@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MUQrCMAwG4KuEPC9ghkjtVcSHtv7OoK6SuiKO3
 V3wO8C3coMbGkda2dGtWZ05kg7E5ZbmCWIXjsTjbjyoahDPvkDagq8833ep/SGldniaIHoMRTW
 nkHXPA/HLcbXPfz+dt+0HCGu2Qm0AAAA=
X-Change-ID: 20261118-rbrue-suez-mtk-ovl-coverage-198c11ba8b14
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795205116; l=4367;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=h4Tvd2gLk6BmOFdUxw3JC3W2Yz6nDyqzW/jYqV5h1bo=;
 b=jygRYnIZ6A4BG1IGZuzzTo8JDeciKHrqpHygmrw7zjCsTulx4jjcQ4bzto4hZFbM6Q7yhLwFt
 4qkyVhGaLPOCo2whLDjeAKzLnJWJLoLWJ/JFUVijZG41BSFtOvQ8ye8
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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

Since commit 860e748bddcc ("drm: ensure blend mode supported if pixel
format with alpha exposed"), every OVL plane on MT2701, MT8167, MT8173
and MT8183 warns at boot:

  [drm] [PLANE:37:plane-0] pixel format with alpha exposed but blend
  mode not setup. Please fix.

These OVLs expose ARGB formats but don't have blend_modes in their driver
data, so no "pixel blend mode" property is created. They can't blend
premultiplied pixels: mtk_ovl_fmt_convert() always selects the
non-premultiplied color formats for them, which is the DRM "Coverage"
equation. Since commit 9813e158d13d ("drm/drm_blend: allow blend mode
property without PREMULTI") a coverage-only property is allowed, so
advertise it and drop the comment saying it couldn't be created.

The plane state now defaults to Coverage instead of Pre-multiplied. Both
are non-zero, so mtk_ovl_layer_config() programs the same registers as
before.

Tested on MT8173 (Amazon Fire HD 10 2017). The warning is gone, every
plane reports a "pixel blend mode" of Coverage, and the OVL0 layer
registers are unchanged.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Since 7.3, MT8173 and the other OVLs without premultiplied alpha log
"pixel format with alpha exposed but blend mode not setup" for every
plane at boot. They blend in coverage mode, and the blend mode helper
now accepts a coverage-only property, so this patch advertises that.
No register changes; tested on MT8173 (Amazon Fire HD 10 2017).

This patch was developed with the help of an LLM.
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 5445870716f9..81a4143f294d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -412,12 +412,8 @@ static unsigned int mtk_ovl_fmt_convert(struct mtk_disp_ovl *ovl,
 	 * and supports premultiplied color formats, such as OVL_CON_CLRFMT_PARGB8888.
 	 *
 	 * Check blend_modes in the driver data to see if premultiplied mode is supported.
-	 * If not, use coverage mode instead to set it to the supported color formats.
-	 *
-	 * Current DRM assumption is that alpha is default premultiplied, so the bitmask of
-	 * blend_modes must include BIT(DRM_MODE_BLEND_PREMULTI). Otherwise, mtk_plane_init()
-	 * will get an error return from drm_plane_create_blend_mode_property() and
-	 * state->base.pixel_blend_mode should not be used.
+	 * If not, the hardware only blends in coverage mode, which is the only mode
+	 * those platforms advertise.
 	 */
 	if (ovl->data->blend_modes & BIT(DRM_MODE_BLEND_PREMULTI))
 		blend_mode = state->base.pixel_blend_mode;
@@ -667,6 +663,7 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
 	.gmc_bits = 8,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = false,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -677,6 +674,7 @@ static const struct mtk_disp_ovl_data mt8167_ovl_driver_data = {
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
 	.smi_id_en = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -686,6 +684,7 @@ static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
 	.gmc_bits = 8,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -695,6 +694,7 @@ static const struct mtk_disp_ovl_data mt8183_ovl_driver_data = {
 	.gmc_bits = 10,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -704,6 +704,7 @@ static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
 	.gmc_bits = 10,
 	.layer_nr = 2,
 	.fmt_rgb565_is_0 = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-rbrue-suez-mtk-ovl-coverage-198c11ba8b14

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

