Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DB606A321
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4vOjiFA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A736110FB06;
	Wed, 28 Oct 2026 09:52:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF11F10FB05
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:52:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A795941296;
 Wed, 28 Oct 2026 09:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4741F01829;
 Wed, 28 Oct 2026 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181144;
 bh=B1BH5139ZvntthMy+ZgfcOebTLXsDgh6bfS68kpwxzA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g4vOjiFAC+2fggUf5sO0N9tJAgJNGlNkGjmWG0g987Ov9pNUpycAQkTFSqJxUe8tw
 YnE49KHrtcOm+1xW43/hcx9bHNrcsm0+Ho5lW78o12hkBcLUhztiOUARYJnXvwvkIf
 N8INTFp8/cGc6AtsZyn3i+cyCNc9HsjNNj5tu4tRUQy/06P4uDrQD2oOfUqbemx/3q
 NdwGvvU/53Fa0krKhfRr7Uc6vLomdO36iF3m/BDshNXZhEG9sNIjbfBpe9RrdiBjFO
 CA93pRCRqU6Dc3qS4+KIDFRQDbcxZPtxzlla+a+qRnb5GdENjNQAphIWQN8QIenKNV
 qXx4C+fCZKjyw==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/8] drm/panel: novatek-nt36672e: Support the bias enable GPIO
Date: Wed, 28 Oct 2026 11:51:47 +0200
Message-ID: <20261028095151.1682096-5-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028095151.1682096-1-vz@kernel.org>
References: <20261028095151.1682096-1-vz@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some NT36672E panel modules generate their positive and negative bias
supplies on the module, and expose only a bias enable signal instead of
the AVDD and AVEE supply inputs, add support of such bias enable GPIO.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 80934c6bf250..0a2d54ee8069 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -37,6 +37,7 @@ struct nt36672e_panel {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
 	struct gpio_desc *reset_gpio;
+	struct gpio_desc *enable_gpio;
 	struct regulator_bulk_data *supplies;
 	struct regulator_bulk_data *bias_supplies;
 	const struct panel_desc *desc;
@@ -377,6 +378,8 @@ static int nt36672e_power_on(struct nt36672e_panel *ctx)
 		}
 	}
 
+	gpiod_set_value_cansleep(ctx->enable_gpio, 1);
+
 	/*
 	 * Reset sequence of nt36672e panel requires the panel to be out of reset
 	 * for 10ms, followed by being held in reset for 10ms and then out again.
@@ -397,6 +400,7 @@ static int nt36672e_power_off(struct nt36672e_panel *ctx)
 	int ret = 0;
 
 	gpiod_set_value(ctx->reset_gpio, 0);
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
 
 	if (ctx->bias_supplies) {
 		ret = regulator_bulk_disable(ARRAY_SIZE(nt36672e_bias_supplies),
@@ -577,6 +581,16 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(ctx->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "Failed to get reset-gpios\n");
 
+	ctx->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio),
+				     "Failed to get enable-gpios\n");
+
+	/* The bias is either supplied to or generated on the panel module */
+	if (ctx->enable_gpio && ctx->bias_supplies)
+		return dev_err_probe(dev, -EINVAL,
+				     "enable-gpios and bias supplies are mutually exclusive\n");
+
 	ctx->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-- 
2.51.0

