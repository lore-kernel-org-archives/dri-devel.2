Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB064606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAT1Lbe6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1213210E4C5;
	Sun, 22 Nov 2026 08:19:33 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6163510E460
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:19:05 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so3648179a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335544; x=1795940344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=raX6dCAIomOIJ7ELRGbL6/J7HJwcKSM4UvEKLE/Febc=;
 b=zAT1Lbe6aEFtymwqLeb+Al3vuKU1+YeEFbmW1xYsu9ZcNxDOQ3pIa/a8mk1Q13VyWt
 XanSE8xVHRYJmawsUG55p9CKBKa4Wtxq6gOS+trMnoGeUN5i0a12uvs01SEvyuhHBsxc
 iWhSrjcvwKgarDoSxD2chmCNU/rEDexTaPZJ9MUAKDdc3tDhLKYvTJf/t4/kLgNf/YQp
 NPv0Z8Ej1aIOKN7WD6zs66VT5peRpTQuBcEjO+S1ZZOYLcOj9/0Iu2BhR1TuaLRemlo6
 qHzYY/lhi1Sy5x2tlJgzfXbo9Y99oCF0o92NeGNeOK7T3YEVwxUoyTamf1QO2ldVfbw6
 GGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335544; x=1795940344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=raX6dCAIomOIJ7ELRGbL6/J7HJwcKSM4UvEKLE/Febc=;
 b=jcVq+bKxR9Eo1AXBhmEcphf6hteua+KO0O0TxgX/P2Gx+zYSMrQBJRWCvIReYc8sQJ
 K2LTHkjlSiUJlYpPoDNQU7FrlSIhtgucG8EqccOKifuJ/TWI/Ygr+JOiPCpJ36drRphV
 NHC7SIX7ELkdVy01WK3LHryJnFEW4cxz2CJwinDAgemC2Cd35xwn2Zg28gEk1GW/TK/I
 op+kB8kqtFOREUCUVCTymyOnaG/sTkpWtOvQ4rgUNBTkhStmO3ZYD13OB9ZfFJ1HeIyT
 ogJGU0k/N3OPv+nGht7u6ZTjLWRMWYeKujtneCCVbwGlzppT9Ie4e8vJabuwAQEm9x9E
 MxPg==
X-Gm-Message-State: APuU4Z9jKeA8lA8dBPadatDmqL+pnkfP3SJh30j+kDKycmn5n1g4sCYS
 rROB8Or74OWAn9aVUbZ/9UfG2UFOv14XLKxkqE2R4+92SLnGBLoQO7jq
X-Gm-Gg: AZFdTZeC5Ro1nGpnsgklNwn2vJbnhclC+wp0ZD7LCC6zg/FIqWtkIWN79k0THRXvEmT
 bdUktUqrZ7jLKBWfVKAIrp1DMYB2T6fT6dxJvMvlOTvU6r6SomAfVwtcH5EF8lJ1Op68Px7sHjO
 UId7DjxdfKU8Wb5yqa40T4MH2zLNl4RLDnkj/jIfxLxGXvadIfjNquhpPTlusv6dhAgPSwzsziS
 dbb1ObWtk66tNO+xLnCY7JiB6n9/FjA8+9rLPchqYBEllqFgJLm/LpOKhkYv6GzP74Aaqu9PtS3
 0q8cpQaBYdUIALVESR9E6XqLFxfNR8P1EQOEKQBTS7YgAwRTRD0IacjCz5OQLNnhxIW7tBQDVpO
 P0xdgxBEobu3nOMDiLbVlRcWn4SOAU/kMfdL1b2UuzgL+3ULOCzNenl9dghn+Zj2ZjzLX+1zufl
 LR+QYO+9un+7auOkGwoyF03+I14aWs4c7SfLlA42cvaTENVVscBW4THn8Xe4RaOmIZXCG8RwgqY
 lWfpba/OtNMmrm559Dpr1wn4P8pdg66VFy5qKkG78pMbwUuSai7IDNwWhp+Gp38GERnvJXEaq8+
 f10GPVeFZtLcBYfX27dnzKVfxpqQj2dVR2giHsGA5/0YFEuRH5TcZAmxkSC+TLpthh4z93U/SQP
 j20iN9Z8kaA==
X-Received: by 2002:a05:6402:1512:b0:6ba:12e2:46f2 with SMTP id
 4fb4d7f45d1cf-6ba37d18d2emr4447226a12.8.1795335543575; 
 Sun, 22 Nov 2026 00:19:03 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:19:01 -0800 (PST)
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
Subject: [PATCH v8 08/12] drm/tegra: output: Make panel parsing configurable
Date: Sun, 22 Nov 2026 10:18:16 +0200
Message-ID: <20261122081820.53199-9-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tegra_output_probe() function performs panel parsing unconditionally,
even for devices that do not require it or that handle panel parsing on
their own (like DSI).

This causes devices with dual DSI panels to fail, because they rely on the
OF graph to find the secondary DSI controller, whereas
tegra_output_probe() treats this port as a direct connection to the panel.
An example of such a device is the Xiaomi Mi Pad. Make panel parsing
configurable.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/drm.h    |  2 +-
 drivers/gpu/drm/tegra/dsi.c    |  2 +-
 drivers/gpu/drm/tegra/hdmi.c   |  2 +-
 drivers/gpu/drm/tegra/output.c | 52 ++++++++++++++++++----------------
 drivers/gpu/drm/tegra/rgb.c    |  2 +-
 drivers/gpu/drm/tegra/sor.c    |  2 +-
 6 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index bc720ae8d95e1..e53fe68161cb8 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -156,7 +156,7 @@ static inline struct tegra_output *connector_to_output(struct drm_connector *c)
 }
 
 /* from output.c */
-int tegra_output_probe(struct tegra_output *output);
+int tegra_output_probe(struct tegra_output *output, bool get_panel);
 void tegra_output_remove(struct tegra_output *output);
 int tegra_output_init(struct drm_device *drm, struct tegra_output *output);
 void tegra_output_exit(struct tegra_output *output);
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index b5806a53e75ac..6d6adc485e51e 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1617,7 +1617,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	err = tegra_output_probe(&dsi->output);
+	err = tegra_output_probe(&dsi->output, false);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 3a94968bd983a..e8c4347f09e69 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1855,7 +1855,7 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 
 	hdmi->output.dev = &pdev->dev;
 
-	err = tegra_output_probe(&hdmi->output);
+	err = tegra_output_probe(&hdmi->output, true);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index eebf0ec0eea0a..d7d7f6ce0a8c3 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -93,7 +93,7 @@ static irqreturn_t hpd_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int tegra_output_probe(struct tegra_output *output)
+int tegra_output_probe(struct tegra_output *output, bool get_panel)
 {
 	struct device_node *ddc, *panel;
 	const void *edid;
@@ -103,31 +103,33 @@ int tegra_output_probe(struct tegra_output *output)
 	if (!output->of_node)
 		output->of_node = output->dev->of_node;
 
-	err = drm_of_find_panel_or_bridge(output->of_node, -1, -1,
-					  &output->panel, &output->bridge);
-	if (err && err != -ENODEV)
-		return err;
-
-	panel = of_parse_phandle(output->of_node, "nvidia,panel", 0);
-	if (panel) {
-		/*
-		 * Don't mix nvidia,panel phandle with the graph in a
-		 * device-tree.
-		 */
-		WARN_ON(output->panel || output->bridge);
-
-		if (output->panel) {
-			drm_panel_put(output->panel);
-			output->panel = NULL;
-		}
-
-		output->panel = of_drm_find_panel(panel);
-		of_node_put(panel);
-
-		if (IS_ERR(output->panel)) {
-			err = PTR_ERR(output->panel);
-			output->panel = NULL;
+	if (get_panel) {
+		err = drm_of_find_panel_or_bridge(output->of_node, -1, -1,
+						  &output->panel, &output->bridge);
+		if (err && err != -ENODEV)
 			return err;
+
+		panel = of_parse_phandle(output->of_node, "nvidia,panel", 0);
+		if (panel) {
+			/*
+			 * Don't mix nvidia,panel phandle with the graph in a
+			 * device-tree.
+			 */
+			WARN_ON(output->panel || output->bridge);
+
+			if (output->panel) {
+				drm_panel_put(output->panel);
+				output->panel = NULL;
+			}
+
+			output->panel = of_drm_find_panel(panel);
+			of_node_put(panel);
+
+			if (IS_ERR(output->panel)) {
+				err = PTR_ERR(output->panel);
+				output->panel = NULL;
+				return err;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 40a02cf5939aa..227a178f761bd 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -236,7 +236,7 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 	rgb->output.of_node = np;
 	rgb->dc = dc;
 
-	err = tegra_output_probe(&rgb->output);
+	err = tegra_output_probe(&rgb->output, true);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 061c5dbb738be..ebac9068b670f 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3803,7 +3803,7 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto put_aux;
 
-	err = tegra_output_probe(&sor->output);
+	err = tegra_output_probe(&sor->output, true);
 	if (err < 0) {
 		dev_err_probe(&pdev->dev, err, "failed to probe output\n");
 		goto put_aux;
-- 
2.53.0

