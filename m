Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8CA606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XYM4iCes
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DF610E409;
	Mon, 16 Nov 2026 15:10:51 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CAAD10EA65
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:43 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c50ac25cdd4so336996466b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841841; x=1795446641; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p3WSfUrzAFZ6C8avlWVorHXjO1aUqVAyT5MLm+GUqW8=;
 b=XYM4iCesDzObDyhRGb3wKU32f76ZEQlVOKKL8bWrmnQSs7cJkjFeTJSnOBsMABRc5G
 O+KATLyFanlX4no4xzrC7gVFzn0YtqBQdx/5bIkWkry0QDhFqSBL53vIK0W28jWAqOb0
 qAKCBFsOyDk07apP9djT7q2hbB/aLXgrtbKwApsua20YJfcT0ZenzgqLusxzKFXlyErl
 a3g88Q4eVxsm/CAse14knlXfamtpsvv3BJzViT4AqqcSLieqZI7DQaAjdsUw7pKKRA58
 KbBifSXAWn8SIMppCSKQCmyF9NRWW+BbiP2edfVa4DMjf//gTFCEzqrKkMwXPrgu1Vk0
 NgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841841; x=1795446641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p3WSfUrzAFZ6C8avlWVorHXjO1aUqVAyT5MLm+GUqW8=;
 b=CN9e4dsECA3LmQgmTyn0lwWAzyvijcGq+fF22vaO8TqMniBeiYMihO5QJiLVlsGAdp
 e8Xit1XxtHTzdsXNDpvjGw3ydf7pj5+NzNMoAYEO+pbVqb8tFgXNa0FGbpHaHDytOgG1
 gqPWrAtg1Jeg63QHMNcnvddbx5+4b+NcW6N6P2kiXdWdhswCqbzqfe8DyQYJr9Jkx8rX
 3LcXRX6zTg+MYLgzwX+mrpsXRpCH+wGlb+BTh2rKZS/Gndis6BFN4N4KE13XWId0CM20
 89CuBti5DaANBdxsS8E8PXPF/Erp/EU7dUlO6WCIQ7dZ69esfk9BhcU51YAa66ppmQSq
 8vQg==
X-Gm-Message-State: APuU4Z+/JR8ZUKAGFOp/OIl/fK6nqHPm/IEvrAnrDmW2sArh4vUWhgOi
 4SuMxy3HVVKUzjEiFVyojpOXIbIFCLTp8Xsg2KOoOd604WZcSFJZys2d
X-Gm-Gg: AYBFou2jMU5Gga+/dCHXGRsQpgDBDdl8xdJWe61PbfQ5Rd/LEUav2svg4p27onOM0JM
 lUOVLpUTfuAkBrl/WfK0JEwoUt3fX4L1s2l0RAb/y5gZa+oHgm0V0ysDrpNrlWC+eBC89NQCA/I
 z/vkAXYTTRTju6AFbSte3en8u6FcjKMqN6OavZx5atdfxGdI7Xv7zwOMdOczfuvnVaW2sVAeQ5/
 7zXMxNRmm6TxW62Xc+ztcYS0iIEPk62H2x43xdTYlNx0Hy7ZoCNTSSs7JyfFkYdUONYbsWEno3W
 6IADw2TcmZD9SISUFaGrFQPipVQy9hcNUUSiC8w3Y+4rBknLfyzDLQLjEaQFn+Iof6qm4ANWEzI
 0FdQH7YrsKKwzwcfHCuRLsCWFVC1zfn44BvAuhIiuvyidgxvjnsYc87r2HjzobFxiOjY077+nlN
 O1aiXQqZka1vRoriCLOh2LQaoUbTvll13PLLCwUbe/iZ/NPH0Ka/GG4VCVlufoxQPeLqYB2ZDnF
 JAwTk8ciGLUmkZuRBLSZ/IfQsNpptjNk+rWld3BilGRk7ndQPrFUDaFL108wcpdW5ADkfEdJGdO
 f8puHcaE4wHpFY/0WhvsjZ+Zk81gp3pP/uAQ8vdLKdBl2SIG04z2kRXBUw8bYF3s/ICQOtqstSs
 NnhFJSuvQPAM=
X-Received: by 2002:a17:906:9c93:b0:c50:5186:a428 with SMTP id
 a640c23a62f3a-c50963b3380mr940379266b.27.1794841840334; 
 Mon, 16 Nov 2026 07:10:40 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:39 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/12] drm/panel: panel-lg-lh400wv3: Convert to use MIPI
 DBI bus
Date: Mon, 16 Nov 2026 17:10:09 +0200
Message-ID: <20261116151017.274764-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116151017.274764-1-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch from a generic platform driver to a dedicated MIPI DBI Type B
driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 27 +++++++++++------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
index 557bcb6f2ca70..63efeb434be13 100644
--- a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
+++ b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
@@ -14,6 +14,7 @@
 #include <video/mipi_display.h>
 
 #include <drm/drm_mipi_dbi.h>
+#include <drm/drm_mipi_dbi_bus.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -25,7 +26,7 @@ static const struct regulator_bulk_data lg_lh400wv3_supplies[] = {
 
 struct lg_lh400wv3 {
 	struct drm_panel panel;
-	struct mipi_dbi *dbi;
+	struct mipi_dbi_device *dbidev;
 
 	struct regulator_bulk_data *supplies;
 	struct gpio_desc *reset_gpio;
@@ -40,9 +41,10 @@ static inline struct lg_lh400wv3 *to_lg_lh400wv3(struct drm_panel *panel)
 ({ \
 	const u8 d[] = { seq }; \
 	struct drm_panel *panel = &(priv)->panel; \
+	struct mipi_dbi_device *dbidev = (priv)->dbidev; \
 	struct device *dev = panel->dev; \
 	int ret; \
-	ret = mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); \
+	ret = mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d)); \
 	if (ret) \
 		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
 	ret; \
@@ -54,10 +56,6 @@ static int lg_lh400wv3_prepare(struct drm_panel *panel)
 	struct device *dev = panel->dev;
 	int ret;
 
-	priv->dbi = dev_get_drvdata(dev->parent);
-	if (!priv->dbi)
-		return -ENODEV;
-
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(lg_lh400wv3_supplies), priv->supplies);
@@ -129,7 +127,7 @@ static int lg_lh400wv3_disable(struct drm_panel *panel)
 	usleep_range(10000, 11000);
 
 	return 0;
-};
+}
 
 static int lg_lh400wv3_unprepare(struct drm_panel *panel)
 {
@@ -182,9 +180,9 @@ static const struct drm_panel_funcs lg_lh400wv3_panel_funcs = {
 	.get_modes = lg_lh400wv3_get_modes,
 };
 
-static int lg_lh400wv3_probe(struct platform_device *pdev)
+static int lg_lh400wv3_probe(struct mipi_dbi_device *dbidev)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &dbidev->dev;
 	struct lg_lh400wv3 *priv;
 	int ret;
 
@@ -203,6 +201,9 @@ static int lg_lh400wv3_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
 				     "Failed to get reset gpio\n");
 
+	priv->dbidev = dbidev;
+	mipi_dbi_set_drvdata(dbidev, priv);
+
 	ret = drm_panel_of_backlight(&priv->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
@@ -211,9 +212,7 @@ static int lg_lh400wv3_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add panel\n");
 
-	platform_set_drvdata(pdev, priv);
-
-	return 0;
+	return devm_mipi_dbi_attach(dev, dbidev);
 }
 
 static const struct of_device_id lg_lh400wv3_of_match[] = {
@@ -222,14 +221,14 @@ static const struct of_device_id lg_lh400wv3_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, lg_lh400wv3_of_match);
 
-static struct platform_driver lg_lh400wv3_driver = {
+static struct mipi_dbi_driver lg_lh400wv3_driver = {
 	.driver = {
 		.name = "panel-lg-lh400wv3",
 		.of_match_table = lg_lh400wv3_of_match,
 	},
 	.probe = lg_lh400wv3_probe,
 };
-module_platform_driver(lg_lh400wv3_driver);
+module_mipi_dbi_driver(lg_lh400wv3_driver);
 
 MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
 MODULE_DESCRIPTION("LG LH400WV3-SD04 MIPI DBI Type B panel driver");
-- 
2.53.0

