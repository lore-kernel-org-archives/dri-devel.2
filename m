Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF3606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=O/RvsIsX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C9E10F425;
	Tue, 24 Nov 2026 10:09:04 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833D610F41F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:36 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49FE11E4E;
 Tue, 24 Nov 2026 11:06:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514762;
 bh=IrRc1sBnD8wRTBcVOby8eJ8KPRLFprXIspxo6s3HE4U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=O/RvsIsX4Eo3RiK3DE9o6v4WKfnTy/iQe1Ygl2EDVvnQ9+/hFuwII0qkCGAjiinCf
 0P5atVhBOYAI4rPAa8Vekj1GKy/JH+TZdngpOnUFrovi1eLfmeIR8OadoUsp+0Gu/t
 ElU13fcY4+Xe5vYnR6W3bWwdVoqF/k0JAGUUZxZo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:07:57 +0200
Subject: [PATCH v6 06/13] drm/bridge: tc358762: Improve DPI enable handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-6-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
In-Reply-To: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=IrRc1sBnD8wRTBcVOby8eJ8KPRLFprXIspxo6s3HE4U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIYXQ6LkRuv+HvVX9gFlyIYbZOXrdexHng2z
 o/mx0abvPGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViGAAKCRD6PaqMvJYe
 9U66EACYmL7GpGxMsctlaBc93ZWCJOcDn8ZjVqlWqx5uRaUIfPAYU3HQSjdht5Hd6qqIK5o41OR
 WbdR0AkTxLNemkaBEyn3vO/vaOltNxbfMBDLG+iUWaRlISH0mPmNyp5RDrdGEwMCfalzYQ8wEll
 qpPWC3+xrXz13SF23+kwvROI7UjRfwsnFZOZC0aj2OKH7AEdS73LUcNhe0d4vJUqdmS6yxzw2sU
 8CPdg/+Byoel99UH3MbM/HbFJYDm2Cc72w+hlN3fVsXtwxEGIU+oLESMaZMJJJ7fyKZrO3NfdCB
 k4Y+NltAvozVxl+6gonHfNUfK7T6SgMcR6UvDMqPFQKtxDLFRDsGUbUQsczVX7QsrIBhK7U3gG+
 ljh5kqDZI+KCcxJmsa4w4uMYk5Ym4qs84tzImo3KplX7NcalQxChaRqbOcHlIALVRt4D1Aljl3F
 SSfBczJU7DW3fGSbn/IEA764iFrc2OqykrN8hfMEtJMVkviVfr1ZSiIqQsQwVwzV4dnm2jlhWol
 AKz+1UFeLRNg9+U4kSeoD1kzrxvKWgl5CJRVZOyaHiJ3+ebZILIxXyRB693UvaaF97X8iyYJdgT
 hpcz7iYitUvALLkSyipgLXsxvIoKpnnjPKv8Ayjk4SHy+6+Rp7XnPovs67zc/iUXysFVOVpyxjg
 KlpEZEbM/ZH0RVA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

The HW reset defaults has DPIENABLE bit as set. In the current driver we
configure and enable various things while DPIENABLE is set. This results
in a temporary DPI output with wrong timings, which may cause artifacts
on the panel.

Fix this by clearing DPIEANBLE as the first thing when we start to
enable the display. DPIENABLE is set later with the rest of the LCDCTRL
configuration, and at that time we have done all the other
configurations.

Also, for symmetry and possibly improving the DPI output at disable
time, explicitly disable DPIENABLE when disabling the bridge.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 91bc79d36a74..0933fc974a7c 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -134,6 +134,12 @@ static int tc358762_init(struct tc358762 *ctx)
 {
 	u32 lcdctrl;
 
+	/*
+	 * DPIENABLE has reset default of 1. Make sure we don't output on
+	 * DPI until we have finished the coniguration.
+	 */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	tc358762_write(ctx, SYSCTRL,
 		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
 		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
@@ -185,6 +191,13 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 
 	ctx->pre_enabled = false;
 
+	/* Turn off the DPI output */
+	tc358762_write(ctx, LCDCTRL, 0);
+
+	ret = tc358762_clear_error(ctx);
+	if (ret < 0)
+		dev_err(ctx->dev, "error disabling DPI output (%d)\n", ret);
+
 	if (ctx->reset_gpio)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 

-- 
2.43.0

