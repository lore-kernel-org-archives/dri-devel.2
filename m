Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6370C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E5710F5F1;
	Fri, 14 Aug 2026 14:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EfHXba7b";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C16710F5F1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:06:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6FFF91A163E;
 Fri, 14 Aug 2026 14:06:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 44AF66046D;
 Fri, 14 Aug 2026 14:06:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4129111C4EDA1; 
 Fri, 14 Aug 2026 16:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716401; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mVDFdzNDfjFRCBlyEIO+dC4L57v118Qe8Mg42pjRsBw=;
 b=EfHXba7bObx3vA0e53jV/8LKu+0pxhXm7cUHbNlI5OwlUAIKPMAM7wCWYX7WCzT8jM6Tv2
 0pl2C9JM3QZyvOagR4mZ0noYaiER83JSqFvYPOWy9y1TKMxb0M/KTuHSulbBBEk3tVT1zY
 rvIw/rG7bAFenMiVsKJpKOE/VBU0aNiDTFvpO6QpDE91q60MUNcJ5n/n5zSqHfHDIPrzjx
 X5wbC+T8VZ4UDAJTboVC5L+wIVJu7CLURJs9+bx9cyfEF5NYvimIvERJRUkTomOoHfFuEz
 yspaawcKwC2Gx625tJQ7wbdn2h2FJUT2U9d3m27HO4+CHYDnVVmwzBGsb9PGcQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:51 +0200
Subject: [PATCH 03/11] drm: of: drm_of_find_panel_or_bridge: prioritize the
 bridge, not the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-3-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

By the documentation drm_of_find_panel_or_bridge() returns a "drm_panel or
drm_bridge", without specifying which one is returned in case both exist.

Definitely it never returns both. If both exist (and @bridge is != NULL),
the current implementation prioritizes the drm_panel pointer and returns
that. In most cases (including devm_drm_of_get_bridge() and
drmm_of_get_bridge()) this is used to implement the following logic
(simplified):

    drm_of_find_panel_or_bridge(..., &panel, &bridge);
    if (panel)
        bridge = [devm_]drm_panel_bridge_add[_typed](panel);

Work is in progress to make every drm_panel automatically create a
panel_bridge, so a panel_bridge will always be present for every
drm_panel. This means the above logic would create a panel_bridge that
already exists. Avoid it by returning the drm_bridge when both are present,
instead of the drm_panel.

For the case where @bridge == NULL, this commit does not change anything:
the 'if (bridge)' body is never executed and the drm_panel (if found) is
always returned.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_of.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 8ec352f3df93..f92f02f9b202 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -308,14 +308,7 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	if (!remote)
 		return -ENODEV;
 
-	*panel = of_drm_find_panel(remote);
-	if (!IS_ERR(*panel))
-		return 0;
-
-	*panel = NULL;
-
 	if (bridge) {
-		/* No panel found yet, check for a bridge next. */
 		*bridge = of_drm_find_bridge(remote);
 		if (*bridge)
 			return 0;
@@ -323,6 +316,13 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 		*bridge = NULL;
 	}
 
+	/* No bridge found yet, check for a panel next. */
+	*panel = of_drm_find_panel(remote);
+	if (!IS_ERR(*panel))
+		return 0;
+
+	*panel = NULL;
+
 	return -EPROBE_DEFER;
 }
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);

-- 
2.55.0

