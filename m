Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F14606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QuTLt7eV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBDA10E4D9;
	Sun, 22 Nov 2026 08:19:34 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22F610E460
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:19:11 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c516a1623d0so53148966b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335550; x=1795940350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3z6P0aYlufuvnlooWGHkbmG4E1HPBYeLov8HTyHzM/I=;
 b=QuTLt7eV2RJBze0FLrU4t7R9URpmCfXmQmW7cYFpz+iodl5FYnUVj32FewLFV5pRd8
 ufXziea1TtKgQsqjzUMBZrVMJUZYYyO1X3AQoz9Z4LT9vxgGYdr7vR6cuEsUJdqDKdh9
 JWbmK34lwFxxHNvfWAJaUVPTEj52QdhsCJSRn5xHtrdH8dMPHItGaRBegc5qPjkcypKF
 NpcNUfuNLk2zjjgsTO6xEiEvEsgAMvGM+zapySIAl/JlDduCSJF7UhUPNgrMx9w7NbDj
 KTvjdcGTklscQpC0zM65S+Yk0cGtQ0cLaFcB+JEhTtNDS49XjyiqUO+sSJG50GDLFXnz
 WZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335550; x=1795940350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3z6P0aYlufuvnlooWGHkbmG4E1HPBYeLov8HTyHzM/I=;
 b=G90PzannXeCmkHmbCkGDfnJ/ZiBDFwUwL6/nfAyA2vrSyeFxtsa7jl1SNnmL7v8p7y
 SfVn6niiWvoyHC1TDBaBcsmDURyejF0v6CtJ22LL7Ha2UwmIMqeVkxHA5Q4TTiSGBKDN
 Fst7bPqw6T1OyTQt+Dhqyo8lhzKW8nJJNR8o05tea1FzSPJm44FIFoEBc3IfDjmkFi1r
 CRI5d0PSfL2Q3aXWuJ/FJD1DAGcgxDPrJxqtug9bJwQIHfcXXT+gmitx+H/PYxzBVqSu
 iAG6EcI9/uY7DyO3akzZPujxouZltbi7T7fGvuamA8apTIA9+CgdwNaAH86hkZgphEot
 8QoQ==
X-Gm-Message-State: APuU4Z8nwsMDGOBmuvneC3YVB+KpPmc7kfQgjbt75c7Vh/IpZzs1hPfh
 5YagVXJC/MkPhBYm4hNzGHs3G/RjPvz5Z7ACCkWZsSfJDoxSnW+HQwTf
X-Gm-Gg: AZFdTZeH3RLcgKAaIg9SNZ6Y/GHnhPpqCrFKEhmdnmsKudzXadP9EEye3fds5qJhzCT
 6ypLZayHnycMBkAOgJ9CWt9fk6UII5nWPZNkTbGajFWRuHH6QvPasMnjjrYn7tTh3M1BJrFwbKu
 PJX2N1E/V0CtOcXEsvQf1PXyHQOnkvyj5LkFwhigpitYV7aEoKzu3K5xlPeyuhcKC/abfeGkq+G
 Fq9bmE22Z8RJguFH/ILxC2cM8Mgbc46h2Rr9IBkkAcHqk7Znc371YTAL6UOWaO3Iyiu70rBUKgF
 6QXZmMV6CMxbutg5pvd4uOihNRVVip+A+n4BVMxIQKQtrMb1xFvC5NCa4VOMd94a5Av+L6m9+IE
 WOUnnLnOa1xDlmvw4n8hZEg7/J6I+9yYb1uf6KS/7lL1Wiz4snnDdpa2R+l/VYlUhKw1RovNHGW
 EMDmRZDHlcxIZEcmuRXMXEv1xEhZ7Y0lud8+LNLdKwWU60E4XSxlHpvTkXMY7TI5uZEUULFpZFn
 Z1uyvjwbALBJuuusrLSJpdE0nM5BwGYe48IoSokkMhR4Z9It5tEik70lwoZb9+7/zcqaKWhbuaW
 rEuR9V7/Lj/LPtaC2bBNCmWXHZujcq9zhKNHG/VHnoa6sApDqfWcTNIBt9SUA6modFaWjwvRLp/
 DU52RhbgzIA==
X-Received: by 2002:a05:6402:274d:b0:6ba:92c3:fef7 with SMTP id
 4fb4d7f45d1cf-6ba92c4088cmr876330a12.19.1795335550008; 
 Sun, 22 Nov 2026 00:19:10 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:19:08 -0800 (PST)
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
Subject: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Sun, 22 Nov 2026 10:18:18 +0200
Message-ID: <20261122081820.53199-11-clamor95@gmail.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
index d48d498068ac8..faecd6f94359f 100644
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
 		value &= ~LVS_OUTPUT_POLARITY_LOW;
 
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

