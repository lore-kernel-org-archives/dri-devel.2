Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E73606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=DGg7eqgB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A43210E5BC;
	Sun, 22 Nov 2026 15:31:40 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C203A10E5BC
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:31:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so22267995e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361480; x=1795966280;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p3YrVF29MUANA/M7BuioyKuk5sUXgut6xOBgRR2fmm4=;
 b=DGg7eqgB9jjp8/A5EHVW6xrwymLD69QTX0j0OBhaBvmlEES7Bv3h21LcmTb6b46xPd
 4ISEzJ/5fVtgLtgxkKvcBdOQk6Ag69K4Jn9F+PdmslZVTDXQKlGz5/ODZjhDysbgEryY
 QWVU38mw2fTbfuM4tgjehr3/SXMVhUGIs3tQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361480; x=1795966280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p3YrVF29MUANA/M7BuioyKuk5sUXgut6xOBgRR2fmm4=;
 b=VoupcNldSiMk1CXFh9VBonKh4QQztpX+nLsswFkOz1wyGZ2lfN5dLf3Mr4lHvUOCq0
 nwPzDHfkeVvD2iqzXzvB0gtj13MqhMfUlz5s5PPA9MVFtje12tK0V+U4PE35THXP0RTY
 U1pBT8eVBX/AduiBSsE7xUL0T9I2RkIjqzziAT1Jzgceo9aMDd4bj9VS7ksifdLa4ms2
 HoDFxeRImBBRsxF9JFJnPNTr4l02upvvujQ53fFPt1iNeo+3H9FmMwpZADmkLmFAKKBs
 yWuy+l3lzQ2ljK7N7mdI/umS28dXyjLU+z88wQXTQ3vZgLwGB7zV3aUEXRmhogOlPEJy
 WIGw==
X-Forwarded-Encrypted: i=1;
 AL+hErGTOUV55B0OwhgcQq3HUucXWgjGOiz9N9zJqkZAu0gqfqtbL1sHN33EF98GCWqRs3SmdUcaCEIQZ3s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/oSTADWwR/TkRoHWBt4EwgzAd+7UduevKamJVxG+OrwD/xEb9P
 djyfAXJyv1VkKFnqT//7XzwYgCdsFFPqOSrnwD1/WC9Y7rjOCGSRqWjOSRVjOkeR6Ok=
X-Gm-Gg: AZFdTZeW2NWW5nlbhOnu/j3PB0xbl7sJOUOACh5CvqgXcfZM33xhzzN5PVpKaQrdDqi
 XDFsbLsb+Hhi+J2MMlQnGH0G1Vb8dVpwcSq95vHeE/XwZUUnW42XpSAkn5Witus/wojgVzkc2Zw
 OXFRjCen8YMjb+JuVdyHrXdLZ3XIHdDdUByVlt/VBfq29V6IoD9UBbAfsmJ8Up2hhj0aP0yI28k
 zZnkbV3wSkpBdgGyBA7STIrcTdxdSiQ31vvuvaa0qnJA9y0lFWVoiC+vGV+b1iy2kA6zZXywC6T
 4xnzJbaVD3Jpno1ClksyFHhtaH0s4O3Zznj+OgjCqSZ2pjHgYucJPES5sJ+7icr2H8XC7S5WjkH
 LCcTrKFM8NF6PWehJmNYCYb19o6uH/y7YbjahzHXWfIgUslSRvezCwSZQRRa5ZdfmY93FLUyk3t
 +sNI8sSw0NfePGU2yN1wl95X6RA1JZce2t4S4Nfe0LsdrwMAbnrlKnwMlVG5Rsd3e8GPHcW9QPy
 l9Ng3EF2Eq7jMr5HjzVt5Iat5wmSXXKLQJhQ6Q589z7/qVUo9P0Oj1W7E12Pak2m2TKUzsoMG/k
 RAlwyJZ8rIeG0Nzv+4+PlwJ/aWZxszhiGbG21ma9KUoKHYYXdXaD7Kch0RCdohLlLDGEUiySwhi
 hqfZ5WCz20keARJO1Bhl6do3T121V/20cWnhbxugPT5s5MAHdWpDf/fTqPPgPxgOMfACUgy8/sj
 tU9u4DtUWV/vQr/HLfopPZM9P6/w==
X-Received: by 2002:a05:600c:1d0a:b0:4bb:840c:72f2 with SMTP id
 5b1f17b1804b1-4bb889323a1mr187745175e9.25.1795361480259; 
 Sun, 22 Nov 2026 07:31:20 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:31:19 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/8] drm/panel: synaptics-r63353: Support hw state readout
Date: Sun, 22 Nov 2026 16:30:08 +0100
Message-ID: <20261122153032.2782768-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Take over a panel left enabled by the bootloader without turning it
off. The reset line is no longer asserted at probe, since that would
turn the panel off, but when the panel is powered on.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 .../gpu/drm/panel/panel-synaptics-r63353.c    | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 73447d7b15d3..e1d84eca62c8 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -72,6 +72,13 @@ static int r63353_panel_power_on(struct r63353_panel *rpanel)
 	struct device *dev = &dsi->dev;
 	int ret;
 
+	/* The bootloader may have left the panel out of reset */
+	ret = gpiod_direction_output(rpanel->reset_gpio, 0);
+	if (ret) {
+		dev_err(dev, "Failed to assert RESET GPIO (%d)\n", ret);
+		return ret;
+	}
+
 	ret = regulator_enable(rpanel->avdd);
 	if (ret) {
 		dev_err(dev, "Failed to enable avdd regulator (%d)\n", ret);
@@ -181,6 +188,28 @@ static int r63353_panel_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
+static int r63353_panel_sro_install(struct drm_panel *panel)
+{
+	struct r63353_panel *rpanel = to_r63353_panel(panel);
+	int ret;
+
+	/* A panel held in reset can't be displaying anything */
+	if (!gpiod_get_value_cansleep(rpanel->reset_gpio))
+		return -ENODEV;
+
+	ret = regulator_enable(rpanel->avdd);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(rpanel->dvdd);
+	if (ret) {
+		regulator_disable(rpanel->avdd);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct drm_display_mode sharp_ls068b3sx02_timing = {
 	.clock = 70000,
 	.hdisplay = 640,
@@ -221,6 +250,7 @@ static const struct drm_panel_funcs r63353_panel_funcs = {
 	.prepare = r63353_panel_prepare,
 	.unprepare = r63353_panel_unprepare,
 	.get_modes = r63353_panel_get_modes,
+	.sro_install = r63353_panel_sro_install,
 };
 
 static int r63353_panel_probe(struct mipi_dsi_device *dsi)
@@ -254,7 +284,8 @@ static int r63353_panel_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(panel->avdd))
 		return PTR_ERR(panel->avdd);
 
-	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	/* The line is driven when the panel is powered on */
+	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(panel->reset_gpio)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
 		return PTR_ERR(panel->reset_gpio);
-- 
2.43.0

