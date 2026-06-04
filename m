Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB75ECD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0582B113FD6;
	Thu,  4 Jun 2026 12:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GA5STnK5";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9476E113FD6
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:41:41 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45ef82204c6so372736f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780576900; x=1781181700; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oX956Ovy0cEzFC2KbieHkOQE6+VfzcgweLx9ANa2s88=;
 b=GA5STnK5DVwNYZd50UKaWtno7xcPTItBZny9O5KyO+eG5QVc003btSZ5hoJUC8GY6n
 T3ZvdONQm8pb6c87NENpjJuBSQY7I4K0m5eU8ASGxE2jk3M3khZjzPuZmej0Np9HS13C
 ImC8hCCJhnaUtb0Z6sr5fjb6XQsQo4Bbx6d1qAcoyF7fZP+xVDYYrYO7hXxl1MctfK+a
 TViSgnPQHe8IW+AUccqWWac3niIBNcMj30izPswAMaWHp41ooIxzbabMUPog0yOnh3C3
 t78SGjJU65bnQOtffj3nN2rku8xpqHilrM19NhUk7SJVkiOKgXXlZRJ1cvEulIiTXob4
 akRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576900; x=1781181700;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oX956Ovy0cEzFC2KbieHkOQE6+VfzcgweLx9ANa2s88=;
 b=PVf5SYTcVh5l8rLjtENxUpJ//eKqFP4HW+FfS0EYwONmn9CH7mJ1i79oHinGvLVISt
 SshNv+55ixzSMaYfV8BZ0SgKFl3eB8xkM1hMs2GgPuY5lPsVBkQj2Mdzqo59eU8o7bia
 +nE6CChpHuoMiV5XbiTo82DTAneMbclHqq2GfZMuQ3LANbQdJ8i30+mwF/XgLdQGxqQL
 L6GNuxfblEnq/LvLb9FALG05Af7bpcuwO3a6F3s4eFw9NQ4C7kp0dwa8Nr5j2FTFMb3c
 JmfCCEA37wSFNU7fDhOfmwnKzlp7UyvrWSRi7MkFJNI091/uBSuQypIlvQnWz/qjsC0m
 Nj3g==
X-Gm-Message-State: AOJu0YzGDhDyi/WTS/xY/ai7vADjbL+X6QwjiBlkifb/X2g2ScjguSDn
 sTp4VZ5l29xE3RPh91+zL4/l2LkOtNGzZoBJ3zcYdGlX3n56tK5FvgfclFn35ORF8lw=
X-Gm-Gg: Acq92OF9zQ8qkfkYI3FO3j3bUMQxhTmfN0/DHjeSgMPx4kdq3QLIKmOjATyYZ0/+N7Q
 SNw6absAyifKyjFyCZgmQk1UbrmjusxxpHvY1XRckdpcanY3gtV8skywr7cMUDTYkuhYhprI5Zz
 2SghGtoJsK+I2vWLjlLaXeuiKs0TJmHg4+h6aI5hVBLP2psjgHnUT298vl5IDhGS+2h+NSXYEKL
 6We4HnByjsadij/v12mXjCV+CSVfqIuRI0BcmeM5mU+jtOxTooGDHIswm5CFZV9A9aAuDEii8tj
 z5q5Y6rpVM9O1N5zD9Hdez7GvOfV6M82Ct/xIeZz19DLahEmj74yXbyqze/1vAlynHp5CwwmxR5
 pXJHb88wFT16j6JYEbdNCHzoOYgOarOYvoCTK6SBdMSRQ41dAMyuEi/u+cE5SHJyyHDCT5aTx7a
 IQEgCtdNMfQCInM05HkymtXOsY4e6uy/ESa1YjJRLs4xkANVhfBh6v8g8=
X-Received: by 2002:a5d:6941:0:b0:43d:68ad:3b7f with SMTP id
 ffacd0b85a97d-46021829aefmr8958854f8f.21.1780576899978; 
 Thu, 04 Jun 2026 05:41:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm16242686f8f.25.2026.06.04.05.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:41:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 04 Jun 2026 14:41:36 +0200
Subject: [PATCH 2/2] drm/panel: visionox-vtdr6130: switch to devm panel
 calls and drop remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-topic-sm8x50-vtdr6130-dsc-v1-2-09bcd1dff1fb@linaro.org>
References: <20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org>
In-Reply-To: <20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=f5/dVqkaXjhX6dtp61tSmUjJiQd2J/ejrflXA7Mzdjg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqIXKB2tNes0WWa4Gf7ZpuO4XQ0jb6kgTgHv2NeRVG
 RiDKNyyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaiFygQAKCRB33NvayMhJ0WcDD/
 9RjlKVcIerDQizX5TaeDFEbTAp35lg7GsqLDEA6HFiFbH482Kadkjc/sTMYvECXYGjpaVhCzj/6NXt
 mrZuXBL5pxo/V8H0YHojo/V5d1vqCMBVHVypxynZIhxhc5wSTPogue1EYf/xH5gSETRFNcgOMW7gCZ
 cKuOYz1TZH1+IYJv2RaRQ3KFhZzP+B6POOW8G7RCqiPKt7TeOd064V5PGayiy+2Mkzlfpg/qjV5eJH
 rQYNrNh7HAQ8Rb9YtDDJPoG030Pi3LnPAY2sVcXPEkSz+N2olZ+XphhIHNcuTPZyzBhFTxyt8vTk9h
 ox/qnRAgdVLN1XHjgDbGHOJ2J+6w2fvpQtiq3UmsX/f6oKutcz3WIR8E/Scrh7j3IHexNyYENbDTU9
 YIjCC1Dumkf0v4C18QZ9fgtkcluKC9TK5H4jxaO/QW0mfpl867N45ADj13sjiuSyj2e8YEE9YY8tZ8
 1BiP2eIlE2ybkkr6tbtsIuCRX6G5lySXoVYPkNZauUOZAYZwkLEjc4+PmBdFb8/yIq6xGZXcraf7WR
 +tzpGG4F7iA+xi54iSSYg5yVacNsO92V5Dojb7J6wR52osA2cUlf1lpm5tpyOheewU2cGo+vBhRuty
 oLTgP7RPkc4DobjFSb8c+j+t4QTUmdrTCpduS9d9YeQeCbjytkhG7VG84izQ==
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

