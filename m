Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44675606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyqWEEtX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69AB01123E1;
	Thu, 26 Nov 2026 13:46:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF3D10E332
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:45:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C432A459AB;
 Thu, 26 Nov 2026 13:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7691F000D4;
 Thu, 26 Nov 2026 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700753;
 bh=AGp5k6yvB5O4Nzjylhojf51Y4TTtW9noFGxg71y0m6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oyqWEEtX7yVgIbjSRkBKL9u8LW01wGZOsjBzrwAo4xb7z6KVrpadF+h1r7EUDZLCw
 yAhMTaulDukbM2HJ9a5lUY/2A/Nd3K+99z0p3rsXjfieILoziQvMU9fDfczB9gMXCq
 G+YLnyxmX3r8md0VkTt9mKiObZwSpolukMbMfzsQU1onzGMh/+jT1XBApyhF++3IQs
 N5iVbdZJESOAhipivYup4UJuqH3f1nTR9u6vb0eIBWuBUjflm7haakLneRXhSqUHJt
 LnrsJkyiUczliLJV0i6mucf9GtpnZhM3YVGejSwKuX7g6LjsG+a3FEYWNWb+9Nl9SC
 0Nro5BsbYIBlQ==
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
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: [PATCH v2 03/10] drm/panel: novatek-nt36672e: Fix the reset GPIO
 polarity
Date: Thu, 26 Nov 2026 15:45:01 +0200
Message-ID: <20261126134508.320700-4-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261126134508.320700-1-vz@kernel.org>
References: <20261126134508.320700-1-vz@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RESET_N pin of NT36672E panels is an active low signal, however
the driver drives the reset GPIO with inverted logical values, thus
the reset GPIO has to be described as active high in device trees,
which contradicts the panel hardware as well as the panel-common.yaml
convention.

Fix the driver to assert the reset GPIO to put the panel into reset,
and to deassert it to release the panel from reset along with adding
a gpiolib-of quirk, which enforces the active low polarity of the
NT36672E panel reset GPIO. With the quirk the reset signal levels
remain unchanged for dtbs, which describe the reset GPIO as active
high, and device trees, which describe it as active low, start to work.

To: Linus Walleij <linusw@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpio/gpiolib-of.c                      | 9 +++++++++
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 8 ++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 8bc4562608e1..2e14173196e9 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -248,6 +248,15 @@ static void of_gpio_try_fixup_polarity(const struct device_node *np,
 		 * compatible.
 		 */
 		{ "sdw10217201000",	"powerdown-gpios", false },
+#endif
+#if IS_ENABLED(CONFIG_DRM_PANEL_NOVATEK_NT36672E)
+		/*
+		 * The RESET_N pin of Novatek NT36672E panels is an active low
+		 * signal, however the panel driver and the device trees used
+		 * the inverted polarity and described the reset GPIO as
+		 * active high.
+		 */
+		{ "novatek,nt36672e",	"reset-gpios",	false },
 #endif
 	};
 	unsigned int i;
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 85902338f10d..364e0855280f 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -372,12 +372,12 @@ static int nt36672e_power_on(struct nt36672e_panel *ctx)
 	 * Reset sequence of nt36672e panel requires the panel to be out of reset
 	 * for 10ms, followed by being held in reset for 10ms and then out again.
 	 */
-	gpiod_set_value(ctx->reset_gpio, 1);
-	usleep_range(10000, 20000);
 	gpiod_set_value(ctx->reset_gpio, 0);
 	usleep_range(10000, 20000);
 	gpiod_set_value(ctx->reset_gpio, 1);
 	usleep_range(10000, 20000);
+	gpiod_set_value(ctx->reset_gpio, 0);
+	usleep_range(10000, 20000);
 
 	return 0;
 }
@@ -387,7 +387,7 @@ static int nt36672e_power_off(struct nt36672e_panel *ctx)
 	struct mipi_dsi_device *dsi = ctx->dsi;
 	int ret = 0;
 
-	gpiod_set_value(ctx->reset_gpio, 0);
+	gpiod_set_value(ctx->reset_gpio, 1);
 
 	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret)
@@ -544,7 +544,7 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "Failed to get reset-gpios\n");
 
-- 
2.51.0

