Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5262CC79F9F
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B8A10E790;
	Mon,  7 Sep 2026 11:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OJQAKe4w";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3499510E4AB
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:30 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7FF614A1;
 Mon,  7 Sep 2026 13:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788780414;
 bh=igMHHRbxifyA6frngcNP7cTPZU8BglT1TaSpdHFR7B8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OJQAKe4wOcAGOki7jaktG7VjUjbYKleLfwQD8VgmE9QI2tlSJ0L04ZMYC6Bh8zU5b
 ng89L1NU/mdNxQOE2CkS9JkmqheOkr4Of899TqJc12VqU/JAReZE1I2Trgz3F6bRon
 MD524c6lZQeuDAopmetEv9AI9PV/FFvM83Wapu4w=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:28:01 +0300
Subject: [PATCH v4 06/13] drm/bridge: tc358762: Improve DPI enable handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tc358762-fixes-v4-6-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
In-Reply-To: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=igMHHRbxifyA6frngcNP7cTPZU8BglT1TaSpdHFR7B8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnp/T+47orYLUJLgcYn5Z/aE59PpVZfyFa5NJY
 Rq5wCvBazSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6f0wAKCRD6PaqMvJYe
 9TnhD/9kSNcxq2OABtsyD+a7Vq2n9lqb7t+IFB2CHkPVnn19OF00wHRac2Maip9aL/Fi9b2wpLs
 m9wfjh7QqorREZtYxX1iNa+TLserTHiA8KtPK02mcEgqu+JdosNKAKHXMVH5VnaxDlUjGRvW9iZ
 26SIWdstRGxgk13RWoMY8b2JccWPo5hzbCWERH4B6q00PzxPxGahDUWRfS8JgvjMmx3MGzzZdAF
 Z9SitO28oti6k7peuECmdnyNOammWscY7zVq6wbRDVQ0rltux0rvZCRB7YM4sDlB+U6HmAL1LsY
 CkcrU3W700M5y0Q+8OOcu3ZPY4NZxsRw2GhQGVKPHSRZXfUJPsri/FlNMRuKG4a2JfZBwzifRIx
 07nWQjAmfUtVlVhvNR+l2hpQCjku13SigR7IZync946wLv/gXt/+Lgx2UCDSrUOaahMl1s0dzWg
 G688ys+Lop4m0C6PpTcHgC3sQvU0JXKiI0qUG2znDFfpcd3wPOPNULhlUyRfZ9HaeQIq9Fi2J5U
 H95PoU1gaG1ug4Ts01km2Y1Cj/MQSWK6cxZfgwianKTFIU736f+lOxLcMzxxpbNMD4njjyxTc7Q
 BKMT8UjhFBeBIFbTdksQwSeoEDlKZiqoEibrUcnw9ivaOVkDhNCfMRluhgjnRsfMCo2ROcDqw7t
 OwF3Ww3q3MTHZWA==
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
index ee72978cd8d8..7654d4039a9d 100644
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

