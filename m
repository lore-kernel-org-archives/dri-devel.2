Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E9606A891
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zu+Ldpz5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FFD10F052;
	Mon, 16 Nov 2026 15:10:51 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F30810EF82
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:38 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c50a2efbe1dso565627566b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841836; x=1795446636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sCblpvWCEGWSGmqyLTXb89MP/KfXdJ6wTD0eb//JjLg=;
 b=zu+Ldpz5PuIos9deFoX5umfUSuRIuExNW2r27ae6GqfzTi/lEiWTH/MniROvMDS9sT
 VdQf9PeohjPz7q4QZwhIDaXPXsV+TuSjo8VwIpuOWwu9w03dwKLEX4xnekwwjTqzwIRh
 mszNOMIx3wgIZO9AgPoCVCIBp6Q4zmTn+aYnwebM5nB+zNzY3dVUAAO5gywLe9dMWDVE
 +UbD8krqoE+m8ZgNysGAMndzbd1qF71+02eRuLU9BMybQUaS/xkpcuUkj2WgoD0SLktw
 ROHlTPF2HQDtBcgiNxm8tgQ/R9J20mO68utAff4f8bZ0ZWbW8IhGJiyZGakBoEGy7A3r
 4kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841836; x=1795446636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sCblpvWCEGWSGmqyLTXb89MP/KfXdJ6wTD0eb//JjLg=;
 b=n7BqRZXrE3EBbK3XeSzdshXKWuMDR9C3dI2M6GJdb62nr6LT8az2lRDLogyxveWrkm
 d/bqr6eYZyoz9czIrjm0yXXKJuoeP9Io6Isn7Q7DvixyJ5LjI8BlGs7qxV+6pFzNsQxG
 0FpVUQJtp7pTVSL+kTKLQ2DTvNRMDzA1V9P+sQStAmwiKC4LxH8vVg4z3hsqt7MaP4Mn
 9WrHlgjvu6a48/+xEvBGy8JBLIehZM02ag0UDDSNc9j7+m/kLE/OdEMJLcE83xyU20qe
 uFxX5hxZNZUwWRXR9Gq91Tnvt2RKwmzQjy5/yHw1spCf7R2b/3hIcaWGFTygzh12wjJX
 x9nQ==
X-Gm-Message-State: APuU4Z+O47o9QDL1MVP1v84C6mSZdn9BsPHRrM40gCq20aGJ4+WAv4RV
 mYS1g8nrXzb/mLSIKtXT0VIlpN+foDIjI6KIn0lHGgoH/PkMkTfDtFLMEzFYFw==
X-Gm-Gg: AYBFou0pRKz+Z/vUNHAj/usrV40/wrmPTRiAvBTHmLtVoqirFXsxeAA4C+BTOqA3N/D
 ScIZuf3QWHUJsIhdBollekMboKFW016yyuTwIKf8dgDPvw56Nr0ZzViZKysgTTUDPcWl+ax+lol
 7Mr71wz/1ybAUO7tJX5qjkjsnQFRNmANKLhvbNZPvOxDx3RR+gbwtLPZSdbz8qfMo31dip6hEX0
 2hpf7ZmROQZNeOhaGjpH0k8hNThW03i3nsJ+VLFFV0Mdasn81VNePm/7InQN0HQ3WnF5DVntEi2
 7iPqZ0rnigp70QWVSIv9CRXlIvWUUFIV9Qc3+UazfcIKyKHZdr9+u2Uz6cTnCgekv6YNlmLWnt8
 QuXknSRMsmmFps8xn+8Vx+AYeHXLtqtkQjjWfcFu4CAIIrE/0TiGLyuVV55eC3GJZwpv2Glp6GL
 9NzgikWJttfr8har2uCH289VEAVjM0ADB/21Bzu1JANBZd12Np+iDz1+BrQfVUIghfO7QL2+SZB
 u/RGrPud9lL/gT2YAMUZBLGhyAh/YVoAHEN9cDrfnUihQl5i8ibZNu7mmMxoRSYIemZaP2PibMk
 bYEasPkFsm2GuwIvMnv6opDnVuTNlO+m5vDWwI+67VEjXx+FRfq6cbC2BDCs3b2d0Jj5JFE=
X-Received: by 2002:a17:907:6d15:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c5096387b7dmr889055666b.39.1794841836225; 
 Mon, 16 Nov 2026 07:10:36 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:35 -0800 (PST)
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
Subject: [PATCH v7 02/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert to
 use MIPI DBI bus
Date: Mon, 16 Nov 2026 17:10:07 +0200
Message-ID: <20261116151017.274764-3-clamor95@gmail.com>
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

