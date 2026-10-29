Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577E606A329
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dm/aCh2V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311A21123DC;
	Thu, 29 Oct 2026 15:30:05 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521931123D3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:48 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so4283854a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287787; x=1793892587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wWQWFAQ/YeW0U3f8X8JNgjR9sIicTFidkftaJdNSKFk=;
 b=dm/aCh2VJinv6ZVB8l2wsGkbhM12as4OrlBXnB/P0iOA8t4SmcGj7ZqZcVJQEuBUMj
 2jeR+hhlS84CSe8S+z1T/vcP7pxgTmff/eUd3O1NIY0nfkbn2CAFSlLBqSUNpwBWq4QE
 xXYd27n8XODF3V/j7o7fTq4jYeO5VBzwdnpBQLrMgEUDzF9BvEhh9Pial62K+/dq3iEi
 oQGiC4nUyHW2llcM/sBOOEDdB2KU0x4jBHqSiCwlpBEXOq7wBnKkWSuAdsGJZrvnWpeA
 H63dN16W6kDntE5NH+rVZYFXKE37yzrFYe2ouZk+bLm+KEk5BUR7x8P5xzJAHdkxJ/Pj
 WBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287787; x=1793892587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wWQWFAQ/YeW0U3f8X8JNgjR9sIicTFidkftaJdNSKFk=;
 b=zGzZWlT7tCyl2WZxN9mIzd125+gBzrYPO8PnGc3MXhWJcBTPSBLKOcT9SfN25Je7FY
 V9sUWEN7cxFpEXK74g/AiEiFIkWdGtIqixREoZYFiIedbJKnR+yiUK7ZUtwngMmDsVlo
 MG6pQjKJCJTE40vwwPXDWqeBDVKwwpnX9tYa0nnXOuy0Tbsv0giHR9DpqP/BHRaPZQHO
 dD2Zcd0zW+cLqOsmVRrv7QaS0fXw5L5dzkLpV3oHVkUmsYGyak8iT5appvriwlAwfndD
 hShhQnm4Y4vxzbsvRQbUrvIAS1gRkNxzYmehSSn+NXeCN9HRn8TTxr61dZB+AzrVRAuH
 inhw==
X-Gm-Message-State: AFq9FYJkf6h3wBHjqaG0ybyxfzbQsFctbFHyGsRXMFQMCeC1ftHF7EJB
 jouJ1ZnUeD5F6mKKt6h5sg5ywqugNkrRc/Qm1FiF3Tj1lYgAVxUriYvO
X-Gm-Gg: AYBFou2sh8RYOYnuBVOeTzGUWJW+T0XYg0RStHfbZ5O5Tid2pwnkXRabcIq8kedIpyD
 vk2KelD5qyqYUKzL8/Y8el7zhKBwcdD8oVjLxW8oPKD0ITf681qJo+bLVUMOqe5U00FyvWDau34
 RtVeMtXQx7ZHnXaAO+sw3p1g34ak5e213NysV4WKJJufcCCocdQhPUGa0Hj1LSHq5VAhqUa2HYV
 AxcOTAFfl0WwDFF3rl6A2FAzI2V7RhAdNHLp2ymZAtGrH0Pz/qpk+DSV/Bj6qKBR1oUeB+kNnnN
 BW3iHXKnUZizUx6sUrCtAqKkr6FmNnRPPZ7bcjxH1oSZhW9pzkU8CguUGumk0CAmQU0S/7fUsJ9
 RfHQWYehlkiT+eqaCNxTcHQ6vShZ3g4GAvJzAzs241H474Cq0MyNhsCpH0QRAb7ej+yE2cFD/s4
 WN6k3aGcBd1rTmy+S4FYRIerVvjdzN/oGWRKYaI4abO9gJgcKsvhEAEYRN2Wf3yFDWmA3fAyCi2
 x0MqfJqlZloLEejuoLg6O9ChAHztC9XDjBmNZNagpuIlGuwt8MCRfYw7EqS9N+UawP+qJe00xhD
 Zmc/iIXKNjJlPgBJnDZUwKYTPjfJgmKLT7R6I7qMlRFE+tqH7A==
X-Received: by 2002:a17:907:7250:b0:c2a:b1cc:158d with SMTP id
 a640c23a62f3a-c49bdf67b9emr532113866b.32.1793287786503; 
 Thu, 29 Oct 2026 08:29:46 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 09/11] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Thu, 29 Oct 2026 17:29:07 +0200
Message-ID: <20261029152909.234584-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029152909.234584-1-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Parameterize configuration based on bus flags passed from the bridge or
panel. The list of supported flags includes now pixel clock polarity,
display enable (DE) polarity, and data alignment.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 7dea0cac61233..d8f41d1ca350e 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/media-bus-format.h>
 #include <linux/of.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
 	struct tegra_output *output = encoder_to_output(encoder);
 	struct tegra_rgb *rgb = to_rgb(output);
 	struct drm_connector_state *conn_state;
+	struct drm_bridge_state *bridge_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *connector;
 	struct drm_display_mode *mode;
@@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
 	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
 	mode = &crtc_state->adjusted_mode;
 
+	/* Get but flags from the bridge state. */
+	bridge_state = drm_atomic_get_new_bridge_state(state, output->bridge);
+	if (bridge_state)
+		bus_flags = bridge_state->input_bus_cfg.flags;
+	else
+		bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+			    DRM_BUS_FLAG_DE_HIGH |
+			    DRM_BUS_FLAG_DATA_MSB_TO_LSB;
+
 	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
 
 	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
 
-	/* configure H- and V-sync signal polarities */
+	/* configure H- and V-sync and pixel clock signal polarities */
 	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
@@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
 	else
 		value &= ~BIT(PIN_LVS);
 
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
+		value &= ~BIT(PIN_LSC0);
+	else
+		value |= BIT(PIN_LSC0);
+
 	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
 
-	/* XXX: parameterize? */
-	value = DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
-		DISP_ORDER_RED_BLUE;
+	/* configure DE signal polarities */
+	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(3));
+
+	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
+		value |= BIT(PIN_LSPI);
+	else
+		value &= ~BIT(PIN_LSPI);
+
+	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
+
+	/* configure DATA order and alignment */
+	value = DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
+
+	if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
+		value |= DISP_ALIGNMENT_LSB;
+	else
+		value &= ~DISP_ALIGNMENT_LSB;
+
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTROL);
 
 	tegra_dc_commit(rgb->dc);
-- 
2.53.0

