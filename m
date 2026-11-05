Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314D606EE98
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPjyh9XR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B0F10E4B9;
	Thu,  5 Nov 2026 14:06:12 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CAF10E41F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:06:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so21998585e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887564; x=1794492364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/TZdy0v25LHQ/8qZj/SLbaFNwYCRnqtlTMoJLynwB7k=;
 b=YPjyh9XRUpzje2c2SUwhFlYZ8dQ/JaoBckPx1hSiMQKzIb0FuZUtd7Dp81sWDVdevE
 nH2PWwOG3nTYSokkdZaLtEQnYa/JMYE04eON364/u/A1t4U7DE9ERuajyb6/gEcmrX/t
 C/+wCsxDoBMNOK2rSWWYTd2fTuDuFpsaH49t6jnQE5VLjZDzESO0SdLeUgTmD8EUI6Vx
 CiwSJ1Hq9I2LpX0MJPwALOqjEnD3NwV7gpynrv77ohozpmR+hG47Wy6hckkR+kTiZDYt
 rudloz42EmzHqVPjAfsaH3BzmE/qNlffoA0K8EX839esDz3oR9+y5vNZS3IpiuNxzbY9
 yF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887564; x=1794492364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/TZdy0v25LHQ/8qZj/SLbaFNwYCRnqtlTMoJLynwB7k=;
 b=WxN5/TiHGXqspH0f2RDLOcygXC2y9AzZ1yqTE4xmtPHU7Lih6Lq/X3M2uvI7+RLjob
 zmcJU2Ww6tzEUYEY7Pb+XcY9ISPVRrsgXoCWXWMKrrlrx0ZU8kcdHMYr2AGYDSSfytke
 KY9tG8nWa8DOcSD66Yqv7sfEGojCi0aUNjLpm6VKOl2jky644gwCKTGaXd7qQeRYLrLM
 ywH6oHgRD71BROtP3txk8RIjVxU3MykuzViJNIo5UsSBG5eiAqu2Dd0Z4P8Gi0U7QGDZ
 gg9Eg4zu52oENsdrOgC/1PnAL8h7lFJI29Ga0U4zLxb0S7elhQ3xnnov7zqs3fUpxLnJ
 29OQ==
X-Gm-Message-State: APuU4Z+32dAAPtAlXrhvqGSwXvZkKE+OfdiPMDfY8OCmjRAN7c/s67JS
 5D1PO+JSJzVDrKhnAdv1BINEzLAj8hBM6G4YnkUSnN0V4LnyZNHZgFh8
X-Gm-Gg: AYBFou2Xt2e0uTwX8q+T1rlv9v8RtxambKXFW0NjtTd60RN5wo0OsiUB82Mzt1etV1O
 FaFI8ZysPu1KQlx8FZ227ByWYvA7Pd9NZoAMFLZcoOxnCIDkU/2tHl1RJEFPiT3pQw4p451KHzO
 j0SHwLoeVhmPy3X2U+NcPB01iwh30A3dFduYR+YGxYGs5E+LaKWG7EoVuUvtBgm3AF/frScujiy
 v57xvgGg2wBhYZd7tXBTTGN/WZc6JIRwFkg2v/HRmMEsgDpVI588Xpjrr5haGvrHmJfzZSdSRBq
 dgbyRsaQzwemFYU99/RFHzP4QIhJURihqK1pAhpwEd1ofD3LdNTQXCqZ2+H7hLl2Dl37Aeb7yn8
 yxi6Wn5lJSNTFpOuhH44iFEpy8MN16TU3x2qLPQlFy3bWFttzwZPVBd08+6do+mHvr0B+Cn//gx
 3QQkdHPpHMtbV/q6hmV0J0L1/5E9cGh9P8C0iMPG9wwkxqXDrwncq4wYe/u0oMd3VzfkalY+2C+
 Dj+m39WJtYsI8oplgoSzKO50S6Ji7/w0u3XkUymMqjdLPsiWcf5cFRgKb/yDBuxVv5LvceNnuQB
 EoQqoHtuyR4VtCB3e0Z44iZ7dAuMMX4dpvwi9qcbA/h5XNj0cQ==
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ac185bd243mr424532335e9.17.1793887564261; 
 Thu, 05 Nov 2026 06:06:04 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm11454111f8f.45.2026.11.05.06.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:06:03 -0800 (PST)
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
Subject: [PATCH v6 06/10] drm/tegra: Make panel parsing by
 tegra_output_probe() optional
Date: Thu,  5 Nov 2026 16:05:06 +0200
Message-ID: <20261105140510.165165-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105140510.165165-1-clamor95@gmail.com>
References: <20261105140510.165165-1-clamor95@gmail.com>
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

The tegra_output_probe() performs panel parsing unconditionally, even for
devices that do not require it (such as HDMI) or that handle panel parsing
on their own (like DSI). Make panel parsing configurable.

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
index 7b595310e7379..a4c0c63bbe567 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1618,7 +1618,7 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	err = tegra_output_probe(&dsi->output);
+	err = tegra_output_probe(&dsi->output, false);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0d2c0ab0a63e9..fc6eb7410045c 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1855,7 +1855,7 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 
 	hdmi->output.dev = &pdev->dev;
 
-	err = tegra_output_probe(&hdmi->output);
+	err = tegra_output_probe(&hdmi->output, true);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index d0ba3bd0aab8f..ff2e28a1e00b7 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -94,7 +94,7 @@ static irqreturn_t hpd_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int tegra_output_probe(struct tegra_output *output)
+int tegra_output_probe(struct tegra_output *output, bool get_panel)
 {
 	struct device_node *ddc, *panel;
 	const void *edid;
@@ -104,31 +104,33 @@ int tegra_output_probe(struct tegra_output *output)
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
index addcecf8592b1..01475995d9cc8 100644
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
index e384cbd0cbf72..ab81e412e05f1 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3806,7 +3806,7 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto put_aux;
 
-	err = tegra_output_probe(&sor->output);
+	err = tegra_output_probe(&sor->output, true);
 	if (err < 0) {
 		dev_err_probe(&pdev->dev, err, "failed to probe output\n");
 		goto put_aux;
-- 
2.53.0

