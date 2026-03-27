Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B6210ED656
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5DD10ED26;
	Fri, 27 Mar 2026 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W2KiFWQo";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3C410E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:30 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2E23621D0;
 Fri, 27 Mar 2026 11:21:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606869;
 bh=nEYzezcIAjmSLC9VcRjnoTGH7YY5s81VvSuJLMxj3K4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=W2KiFWQo8SgA6uMpZLLn+CBLQbgeCMzKoqU3xzm+4rRlWo06MhM2IWZ/sECThr1ui
 0f6VuOF0iqULc7yJTb7FJs05KoXiZ6zbkpZ8rHSzAR+bVgWku2Fve97B9Zdh4B0E7X
 o1lQ2LL4jzY53ITLOXKHGACsnREJAfZJuNmrursc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:54 +0200
Subject: [PATCH v2 06/12] drm/bridge: tc358762: Improve DPI enable handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-6-3589d3c45f4a@ideasonboard.com>
References: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
In-Reply-To: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=nEYzezcIAjmSLC9VcRjnoTGH7YY5s81VvSuJLMxj3K4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpbPTZ/qbUjZzg3ReA+PLXEiSMaCwNzi0rLN
 PdsTFBgqK+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaWwAKCRD6PaqMvJYe
 9TwLEACrxjCvccccwPlZDFpPVrWcRSF6BwiwxvZ12NBoq2eeoreb79IHe5CZcNqT3ImxPcN1zI8
 t5OCj1YXG5ymoyWIH8sNjTQV4l3D8gX09olIxAYK37BJfUzZwA8oKHkRSOlR5RjcnRqQ8KrTZMD
 VTwnmddA+K9TQ3Juk/mUepyfJpKf6NRVxThgYazAI9Cay4+Fvcu8YUzMMhYiVDfkC0WjM49okRr
 JFdJYmNWMBd4UGWJV1KPehyCWxwiNh+cZKuEohW5n7iagJaf/rxzNoZzxVgYPf0PoLRotNTW8hB
 UWOYWNlXh0YmFkqaUS6VUyHk2208I172tPbSlQvcr1BH2MklCw+mUL8wbVq+WEguNApnZ3yChVK
 uLjotbVRFJObLOoQSr1f3xwlmkUrrZ2PCkoV5syDXVSTwubcoYEPNJ76KjRwYDrSwHnNEOTOe5K
 rhpeCB0AGkqPabbLtYpUR4lnO33ESF+M6sM0qiPcyzAdv3IKpvGfROPCT1QzY6b2KorXIDTs/yJ
 Eyo3HPN4u1DNE6hr82jQW6GDqRx/+C4rsZXas2uXBz1LLcLF1rDNtigdzxjwZ8O02/aMP0DAhUz
 9JHHoRnJ70uE9dxEvqREDVTzKzYZ+i7KZiLjZ/woLAOohN+/0IPjuWjH/nqX00mA3+2K4n4npS2
 yCaw3vF04NvhT1Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

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
 drivers/gpu/drm/bridge/tc358762.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 52e2f3a73721..cc1c5ff42cbd 100644
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
@@ -185,6 +191,9 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 
 	ctx->pre_enabled = false;
 
+	/* Turn off the DPI output */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	if (ctx->reset_gpio)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 

-- 
2.43.0

