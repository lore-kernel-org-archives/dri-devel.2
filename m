Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC77606A339
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxYPU4hf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BB210E494;
	Sun, 22 Nov 2026 08:19:01 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7411510E46A
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:18:43 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6b887ca9f5cso3098258a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335522; x=1795940322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sCblpvWCEGWSGmqyLTXb89MP/KfXdJ6wTD0eb//JjLg=;
 b=hxYPU4hfMpM/6KWZo49hmJpRPtM0xg5Cjzf8zw51M0LY3H1Xp7rp8t8qAh7LifrDRb
 G+gE8fj1TZU+cCA8ZIOUDzO8uauC7F2/NoViEi7xVFDDozjLWJjoZVt7hw/8bqkQ1RCC
 b+fj6cNcZKJka0tLtyUx7uMtZuZY+ZRQl3qTtjGKXRKkjCJf0gO6iVqintHikITWKoSb
 eIf1jKWwtWAHkr+4rUMLxJZkyZDVDJbwFk/3hF37t1V+CPug0ejBJKYTAeArqtc3pfMO
 1HstLz8evpDgwYHmFeFdPzohpV/twBsL/1Vnal3Majwjuwesg+R5uz5G8AO4CuuXvmkm
 jzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335522; x=1795940322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sCblpvWCEGWSGmqyLTXb89MP/KfXdJ6wTD0eb//JjLg=;
 b=azXaiZZo7dDDHpNhSyY7CXr6n9IJsMrGfRq1vw/65myEO9hF61GEWrbRvHD9NizuDQ
 Nx4zMm9f48jnJqFLoTqxYCVkAvcQ5qYbymIIYKO27/VPBywQxpAlPwKwyUiFWLO24v+W
 r3j6a4E+h+1Ckq997U6j8blG51d4vX8nMOaV3GWaFdYjOYqtSNQa7vD0jaSGXS4k3kvu
 S8plCGpm2AxRTxY2Q6F/7mlXouNJPMm2tf/FjaoX8X2P6tgc/76iE24iCM1o3w8wlUpV
 xSxjCmpAW1jLE3Nru+pJfymyl9+3U4PuYxb9ljyQFC56FRAFye/RQ1GFv6xG1R2AIFJQ
 HNkQ==
X-Gm-Message-State: APuU4Z+n821dQuyclqGF1wcdZczoZFbVHTgZhQ5hURSIoIhC21mXbAdI
 73VmNLOs6kx8d3bcPbajZ+zmI7WLIhiumCByDDRYjWZFI8RqsuZLvY09
X-Gm-Gg: AZFdTZd62qo3g8aSDtG7gOWPve9iqZhntrAJg9tTl0BOqC8tyAXdXJwvx8YpAyWFMOM
 FKvH8339LUbZwIC72m+LdLe3OVsa4yFKUHGdtxm9pvheQKENzLg8svYfxhC8B6wjcouxJ6afofh
 QYbHYignXPM+Gh2YfvJLywuXEmETGNdEcWyTA6JaeYEOsFqfoYmdAub5tp0uQ5PbQi7g4p7x6O5
 6OU0hnP3117oXeeYJqL0nQKNka7O8SJWm1bQtGF1XKg2DxX6bvSTQp6mg69S7LuV1WwjahAmtlq
 LfGr5YU7RamlG+DYfSc1nb8LkaaqLEM/sk/zNBJJWn1ktamTdd39VsXl8jA8jCfj4xCPEYkWp+S
 WZl2oV9OB1MuknISVFQEWTht9PQenCvQyaPbObjGc/btFSs7ceGg8x/HxvIpXWFCy8YuJnBTZPK
 EuY+LywHyfvGb+RepP8z3vSh359p0zFJs6Vusd7DQzzbW1ht9j1XKjAq9As9EwTpU48YewV9r8z
 NQtvO/Ock3H/zDJ3ZEnDXbDpwOGz8AzkcCKEvsRjqE9//Xpo2RmdGqaGQFm+bFlhhslDb7cT02h
 5Z/B3xt29t2KmlkiXIJXc3P4epB0vfaJCClNgoU9RsJc/4J3+YInXNVqmfLLnmjg7pO/cc2cZBE
 k6+nPFtDzUA==
X-Received: by 2002:aa7:c4d9:0:b0:6b5:9731:90fa with SMTP id
 4fb4d7f45d1cf-6ba37cc0ad9mr3980018a12.6.1795335521825; 
 Sun, 22 Nov 2026 00:18:41 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:18:40 -0800 (PST)
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
Subject: [PATCH v8 02/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert to
 use MIPI DBI bus
Date: Sun, 22 Nov 2026 10:18:10 +0200
Message-ID: <20261122081820.53199-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122081820.53199-1-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch from a generic platform driver to a dedicated MIPI DBI Type B
driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
index 83c2af1be9755..318ece68b7806 100644
--- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
+++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
@@ -14,6 +14,7 @@
 #include <video/mipi_display.h>
 
 #include <drm/drm_mipi_dbi.h>
+#include <drm/drm_mipi_dbi_bus.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_tx10d07vm0baa_supplies[] = {
 
 struct hitachi_tx10d07vm0baa {
 	struct drm_panel panel;
-	struct mipi_dbi *dbi;
+	struct mipi_dbi_device *dbidev;
 
 	struct regulator_bulk_data *supplies;
 	struct gpio_desc *reset_gpio;
@@ -40,9 +41,10 @@ static inline struct hitachi_tx10d07vm0baa *to_hitachi_tx10d07vm0baa(struct drm_
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
@@ -54,10 +56,6 @@ static int hitachi_tx10d07vm0baa_prepare(struct drm_panel *panel)
 	struct device *dev = panel->dev;
 	int ret;
 
-	priv->dbi = dev_get_drvdata(dev->parent);
-	if (!priv->dbi)
-		return -ENODEV;
-
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies), priv->supplies);
@@ -243,9 +241,9 @@ static const struct drm_panel_funcs hitachi_tx10d07vm0baa_panel_funcs = {
 	.get_modes = hitachi_tx10d07vm0baa_get_modes,
 };
 
-static int hitachi_tx10d07vm0baa_probe(struct platform_device *pdev)
+static int hitachi_tx10d07vm0baa_probe(struct mipi_dbi_device *dbidev)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &dbidev->dev;
 	struct hitachi_tx10d07vm0baa *priv;
 	int ret;
 
@@ -264,6 +262,9 @@ static int hitachi_tx10d07vm0baa_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
 				     "Failed to get reset gpio\n");
 
+	priv->dbidev = dbidev;
+	mipi_dbi_set_drvdata(dbidev, priv);
+
 	ret = drm_panel_of_backlight(&priv->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
@@ -272,9 +273,7 @@ static int hitachi_tx10d07vm0baa_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add panel\n");
 
-	platform_set_drvdata(pdev, priv);
-
-	return 0;
+	return devm_mipi_dbi_attach(dev, dbidev);
 }
 
 static const struct of_device_id hitachi_tx10d07vm0baa_of_match[] = {
@@ -283,14 +282,14 @@ static const struct of_device_id hitachi_tx10d07vm0baa_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, hitachi_tx10d07vm0baa_of_match);
 
-static struct platform_driver hitachi_tx10d07vm0baa_driver = {
+static struct mipi_dbi_driver hitachi_tx10d07vm0baa_driver = {
 	.driver = {
 		.name = "panel-hitachi-tx10d07vm0baa",
 		.of_match_table = hitachi_tx10d07vm0baa_of_match,
 	},
 	.probe = hitachi_tx10d07vm0baa_probe,
 };
-module_platform_driver(hitachi_tx10d07vm0baa_driver);
+module_mipi_dbi_driver(hitachi_tx10d07vm0baa_driver);
 
 MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
 MODULE_DESCRIPTION("HITACHI TX10D07VM0BAA MIPI DBI Type B panel driver");
-- 
2.53.0

