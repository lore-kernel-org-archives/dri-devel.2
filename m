Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843B9C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED6D10F265;
	Thu,  2 Jul 2026 09:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zyvv2YCa";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9103010F25F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:36:15 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493c2b3dc8bso9570975e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782984974; x=1783589774; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oX956Ovy0cEzFC2KbieHkOQE6+VfzcgweLx9ANa2s88=;
 b=Zyvv2YCarVPl1P0JM6tu9A0xxY8jO+GxXGn9h04HmoSQrIIMaZcSxycm+mxswwevy1
 3q4PIVgWSQ3f5gV6JgycRNR3+pDqJgCs4Key8dG/S74+wcm7JCrF7MAfMGKtFBUZ6rdC
 LvEjyzfNlLL3/YeuqrZ3hL2ZHr9uXi5KUhKgFtjppYJYAKFgCZkIJ1BS6+a42wv8h/pk
 O3F6hbKy3+Ti33BJZNVsk3Y69HqcDKrsDj21mEZZHN5adyw+5uCLKs/2l8pJIm+oZxxm
 0tB+u3d9dErUFUwOqE/yde9Y/cHA46/K/vrDUAneL334MP3eFjGetEyaj8m3PdZfPWzm
 kbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782984974; x=1783589774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oX956Ovy0cEzFC2KbieHkOQE6+VfzcgweLx9ANa2s88=;
 b=P+iPK3F5h/LsOXQLJlwbCQoMOp312pSJra9gYSLt9dKhNmqY6g7BzrfekmCEq9J/el
 Ew0B1Ofx1B5Hjp9pDyx/Tzi8720ACB2oILmMEOYvfbWsp77AoAYDA8yfFvmYduEPTFW6
 tqlFdfBR42JQcZQ3bKN2xvo8uykQn8hfOYM3qgSNZMKzqV6ehwpRXAa/nvrf9hvsAICk
 Y/yuBlGeHwXKki+gWDeQYYEyWfOpuJK2QAn+n8gr3hHNREUbsTPjSJiQVi9iY9qZWSFq
 1DvaEMbyrnhvAIfh9Sua344abZPkBAfPoYr4WKnCnhjDtzlomPmMljsm9Aawn7WrLbq+
 c4WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9P9AMMNe14vrPJ4mkPbos9V6P2Sewyt27jDa4ccPZNARvqtO1wcrf7gejP/xErkSgsFtjp1yqA/8A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3xKG2JZzstiVImYwYRa5l89HYlSI1iXmig/QCb18Q1EbPDd6S
 JbXVU+X5WrBU0iup2HvFXPietsdIuAFMXZl3q/bj3KT8qHJY11vKEF8Eh/5EfnFmlmM=
X-Gm-Gg: AfdE7cnbGT7AOfi0UPHq1hcqhv84WHp/MV2CjXP0NUlbgPntOUhv+ckwUoy1DxEVzcz
 3ydkGAV9cLCBLVa3Ikeoue9rZz3hSiT9nu95wjczFTM+77A+6Nd4Humvula2YHcnwVhl7CHoMGW
 LIHSuACnZ79GeOGZpjl6BBrtVcnFIDq5atRV3PS8X1vRy4fPyPHMb49KbtCZ1jjDoOd20s5w1LF
 fbBX7a97Na6m6aFpHs1k587gh2GyaMGqecSefZURvecIB0+RiQqqKIJdUwSqnGepnhbkPG7y/hR
 2K/sY5jWzmfZ50nSD9X1l7SsJi7wGOc69L/vApwr3tbPADHr4Yvj5r6r6wgzqbZUFjZvrpskhlY
 IAB4a7f78RwWhNvGIASrF7EdmnCKluUV7Be25ZcpFts1Afa/FJmKrz6KdhsBWikF64prCKYYiEH
 zGAF9qG7Y23Jc8sSHYWim7en5l7i4QnL4wiQ==
X-Received: by 2002:a05:600c:3b8d:b0:490:d32b:39c3 with SMTP id
 5b1f17b1804b1-493c2b15ee4mr86442375e9.6.1782984973882; 
 Thu, 02 Jul 2026 02:36:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bf11eba5sm80524765e9.0.2026.07.02.02.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:36:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 02 Jul 2026 11:36:10 +0200
Subject: [PATCH v3 2/2] drm/panel: visionox-vtdr6130: switch to devm panel
 calls and drop remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-topic-sm8x50-vtdr6130-dsc-v3-2-db881a3fc026@linaro.org>
References: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
In-Reply-To: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=f5/dVqkaXjhX6dtp61tSmUjJiQd2J/ejrflXA7Mzdjg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqRjEK8oIWq0Oo/YkU20Lwe77u8bNp/y+X3TwXt24o
 augNc62JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCakYxCgAKCRB33NvayMhJ0VQ/EA
 DBdOBslSavV4v5JfWC4z6QH9IdPIwjq2jnSGJrLffk2sxQLd919D2nBmHjoGaP3nTisa1zZDIj8YNA
 dVeTMHy5jQt5XyVZ1A54+JIoJRiRMr3l0eL3zFPNhhPSCz0pRJqUZEgNslPZi8eMXSQ8ASTA8/bR6A
 IEn9u0LZmIhDOKrVrp4O+WujEXUPZAmK46Nu/xahmhqm6tf3wfugymz3U4AC6dIX6WDy30b0hyVWhK
 EdivzBlGEbBxXSflsFNtBo2GIxX6VmfAMJvYmpvXoHd8DcScNp3q7HigmpImfL2kAX1zU8nMdmW2yD
 yYM1Pt81eJSPsLCRpAu4bHYiGgTXt1i+Us6gwQvOBBmwJ4wyVnVLRXnDewf28cTRyOzP3NAUYaTHrT
 4OOB7dnFsVd+7/+qrn0xCUQ+kBcEQ+haHr6K5BwzN9KOf0boGpPpwS9Ut0Lh4Ra21VWeRy+x9XqO/M
 ZrgaZseJPkwdW3xRrImNZjefzY2d/ZXgb3xnK/7Pr2+qFsQkcTrCfaPzYz+aVa+VBt6bFZgK6OEV+l
 sY/qMy9A28D/6UtYHDgiJ6bo2iIA70/MWAAVFqCdJGfmC48HzN3ndW00t61OxMdcI/FnUBH5HcFsr6
 pdWEvumGxxA0dA+aC6/RNgoofjZI07ZrKrtbRsOUA3q77wV31hFCv7OdRWeQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Switch to devm_drm_panel_add() and devm_mipi_dsi_attach() and drop
the remove() callback.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index 0cdcdbbc766d..6733e0e1d061 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -298,28 +298,11 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
-
-static void visionox_vtdr6130_remove(struct mipi_dsi_device *dsi)
-{
-	struct visionox_vtdr6130 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
 
-	drm_panel_remove(&ctx->panel);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id visionox_vtdr6130_of_match[] = {
@@ -330,7 +313,6 @@ MODULE_DEVICE_TABLE(of, visionox_vtdr6130_of_match);
 
 static struct mipi_dsi_driver visionox_vtdr6130_driver = {
 	.probe = visionox_vtdr6130_probe,
-	.remove = visionox_vtdr6130_remove,
 	.driver = {
 		.name = "panel-visionox-vtdr6130",
 		.of_match_table = visionox_vtdr6130_of_match,

-- 
2.34.1

