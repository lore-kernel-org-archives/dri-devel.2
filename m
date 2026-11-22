Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71F606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=LR5gPTIc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B8010E1D8;
	Sun, 22 Nov 2026 15:31:07 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069D910E52A
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:31:00 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1309300f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361458; x=1795966258;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7itunjG2J42PnC7jSB4jhKO5BUVvNkVP3J0t/6cOCWw=;
 b=LR5gPTIcbJaRwxNRN9glKtS8755hJ9Imst0av/Mp5WQ6aXK8c2/psGqBNnTgAaaQVp
 z5CspaWCWJSHUJOBRE+pKz0KAKoDtQu3xvyQ2bNYjrw6v1lFegMiFCa5D7tfqCytpMHw
 37FuT5arU/uU4egLLxWJ2bXqJBrg7QEIbt5CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361458; x=1795966258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7itunjG2J42PnC7jSB4jhKO5BUVvNkVP3J0t/6cOCWw=;
 b=bCmt5JYSeyS+P8nuzLguIclbGEeVG5TE8X+zS/xOtkK1tVRLKBcyop3q0/YA6k0eix
 FiJiTiVnVECFKyTK8qgRq5BkUhXCKMxV4alwFC1JaJLJqtF0NyC3pot0vvlwKX5NmH88
 LEjpILff4GF8Wa9GgJavrWp/yrxAk1OZNQwqXlr8l4ZO7b5oFtAFmqcsfy10x1/GWvu5
 LuY7pGrDDOyPEk47u+shB082tnFcT4e6kr3HU73xLNrqooy0vUAorDHnzg5X9G5m1Nxu
 ZITRvZZkeWmMgIbF0Ydn25ZwK02wF8wzY8ffhDh5IeTPmx7R8lVqxDGFJ7I83c/Bg7Is
 wEhw==
X-Forwarded-Encrypted: i=1;
 AL+hErEPPsobgqwxpUpkg2JapIt8+jDc3fX6q/xgFmRqziPG4JAo7L7clwGQReouLEe0CGCQbGIpiBlGrqc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9N3P8NLaVAlbAx3DFkHiM/wFt/6dT5jJtTeHgXM+AlficOKee0
 aRwoW8U6cQtH+MXilQsPDSR3igb4CRs5mxgnMIaSl3FYNgZZuIE3S2vwdu8J6p2yuIE=
X-Gm-Gg: AZFdTZckWODrxObApquNYp75h835pfHkOIP8JLYnwnnfCo07sR1q7/gNvfLvYZDBe6f
 ZUSaSAHq1IA5lczST9GxDTwQ3Ividx6pCwgZzJo//QS3E+nOiP5jxFLnF4Gs9h1rAhEyXwSfSBL
 OUAyGIT8TkbcOSv7UVMkrhhy8zmyDy0PVaXVruZf8X4ZxICnXLVe7f7a7mMJgKR6D4ktbMEZnPy
 9NPRLYdbpZgg3K0D6LeXEAZblSxKkvwnF88Inds0j/LSqzIngajcRwcwX+2E6qufyYq/hZR3yAS
 wxbGI3FXVpBOt3Gltv6JYid81D1dMk+C0Qm4lY4dLnpAUA2VDrHjEsapFaHsyDICircXtHJLrWf
 whe5o9gTSpdv9F8bcj75TVeWfVWZVcVYLhkJ78CN04Ttc6AYGi/dZBbaEqdH45Oq6RjxMvvdY9e
 ygdmQV1gAa3O5HM1HbRYoOlq2DPA8yesM/iTXJYbs6D/x+hXcrD88EImfBYNhnc0DXOc952A4lD
 x5YcHtSyABJp44oIfaeMt9QgUIcAmChzNgCcrBMnzH+0c7OIxJMLXobW3so/5A1LMITNWPhD8Pr
 7cHS+AeI2lS7Av14hRQfu0CuA0w2pyDRMd0ydAM4nrpXC4a6UcA8X018/udwv25ohT6kDfR/xxJ
 5eT5GgY1l5YbZ4sng1iDvCAMs7dQGeGx/iQM1rkzs9p6xCj+xUXqkN+MIHAwAKXsn2+CBtACzSG
 dDxvIZ4J2/OCQ+dmZn/ZLyDcCM5w==
X-Received: by 2002:a05:600c:64c8:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4bb8881de62mr177878065e9.25.1795361458330; 
 Sun, 22 Nov 2026 07:30:58 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:30:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Vasut <marex@denx.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Stefan Agner <stefan@agner.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] drm/mxsfb: Use the bridge connector
Date: Sun, 22 Nov 2026 16:30:03 +0100
Message-ID: <20261122153032.2782768-4-dario.binacchi@amarulasolutions.com>
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

The state readout of a connector is implemented by the bridge
connector helper. Use it, as the LCDIF driver already does, in place
of the connector each bridge creates on its own.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---
The bridges used with this driver have not been checked one by one
for DRM_BRIDGE_ATTACH_NO_CONNECTOR support.

 drivers/gpu/drm/mxsfb/Kconfig     |  2 ++
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
index 31db7a824a93..78e983b71ec0 100644
--- a/drivers/gpu/drm/mxsfb/Kconfig
+++ b/drivers/gpu/drm/mxsfb/Kconfig
@@ -15,6 +15,8 @@ config DRM_MXSFB
 	select DRM_GEM_DMA_HELPER
 	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
+	select DRM_DISPLAY_HELPER
+	select DRM_BRIDGE_CONNECTOR
 	help
 	  Choose this option if you have an LCDIF or eLCDIF LCD controller.
 	  Those devices are found in various i.MX SoC (including i.MX23,
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 641691fc92c8..038f5c896dcb 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -23,6 +23,7 @@
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
@@ -118,7 +119,7 @@ static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
 static int mxsfb_attach_bridge(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_device *drm = mxsfb->drm;
-	struct drm_connector_list_iter iter;
+	struct drm_connector *connector;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
@@ -139,19 +140,18 @@ static int mxsfb_attach_bridge(struct mxsfb_drm_private *mxsfb)
 	if (!bridge)
 		return -ENODEV;
 
-	ret = drm_bridge_attach(&mxsfb->encoder, bridge, NULL, 0);
+	ret = drm_bridge_attach(&mxsfb->encoder, bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret)
 		return dev_err_probe(drm->dev, ret, "Failed to attach bridge\n");
 
-	mxsfb->bridge = bridge;
+	connector = drm_bridge_connector_init(drm, &mxsfb->encoder);
+	if (IS_ERR(connector))
+		return dev_err_probe(drm->dev, PTR_ERR(connector),
+				     "Failed to init bridge connector\n");
 
-	/*
-	 * Get hold of the connector. This is a bit of a hack, until the bridge
-	 * API gives us bus flags and formats.
-	 */
-	drm_connector_list_iter_begin(drm, &iter);
-	mxsfb->connector = drm_connector_list_iter_next(&iter);
-	drm_connector_list_iter_end(&iter);
+	mxsfb->bridge = bridge;
+	mxsfb->connector = connector;
 
 	return 0;
 }
-- 
2.43.0

