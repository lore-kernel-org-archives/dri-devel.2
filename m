Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23B7C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2617710F5E5;
	Fri, 14 Aug 2026 14:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TL2S42RL";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D08110F5E5
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:06:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 315C31A163D;
 Fri, 14 Aug 2026 14:06:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 024F76046D;
 Fri, 14 Aug 2026 14:06:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E054F11C4EDA3; 
 Fri, 14 Aug 2026 16:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716393; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=zPffTQY3o0nckhG1kgJsg31X0NrLILf85FpE443vTjw=;
 b=TL2S42RL9GTyEW2CCCc+9L98eUADbRmyuyDUIjPgzgB/cIC2bohquh2rKR+j+MGDVbYylL
 6mtYmPziJqQe/mDqmDCDIA6v75gPK6RzqGQk3c/MRVbsGAKM8/PSiuuWxfvE5ZztQdCory
 JDMg7+v2cJAXXNWZ/OXUUBT9urqQ/tiqYrXXkJbf95ABWB9oj0rBxRuku4mVD5x69TNfZ2
 JcLsWVp6PKgzIsirFNUweYUB/CFp04FAmMqtE7LlzagAvQqmZMqufbhXtXFixagS73e4+4
 up2IzL4YYumCfjxjYKz+6LvCbzFlzeo82FoUsRrn4mO8/1ShIpzfB/fz9AI1wg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:50 +0200
Subject: [PATCH 02/11] drm: of: drm_of_find_panel_or_bridge: simplify error
 return paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-2-19cd5277cc8d@bootlin.com>
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

In prepataion to further modify the logic of this function, simplify the
error-returning code.

With this change, on any error there is an immediate 'return -<ERRNO>;'
statement, without having to carry on the return value until the end.

Additionally, clear both the panel and the bridge pointers at the
beginning. Even though this is redundant in some code paths, it allows to
have a simpler code in the rest of the function.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_of.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index b42a321f3052..8ec352f3df93 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -287,12 +287,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_panel **panel,
 				struct drm_bridge **bridge)
 {
-	int ret = -EPROBE_DEFER;
-
 	if (WARN_ON(!panel))
 		return -EINVAL;
 
 	*panel = NULL;
+	if (bridge)
+		*bridge = NULL;
 
 	/*
 	 * of_graph_get_remote_node() produces a noisy error message if port
@@ -310,23 +310,20 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 
 	*panel = of_drm_find_panel(remote);
 	if (!IS_ERR(*panel))
-		ret = 0;
-	else
-		*panel = NULL;
+		return 0;
+
+	*panel = NULL;
 
 	if (bridge) {
-		if (ret) {
-			/* No panel found yet, check for a bridge next. */
-			*bridge = of_drm_find_bridge(remote);
-			if (*bridge)
-				ret = 0;
-		} else {
-			*bridge = NULL;
-		}
+		/* No panel found yet, check for a bridge next. */
+		*bridge = of_drm_find_bridge(remote);
+		if (*bridge)
+			return 0;
 
+		*bridge = NULL;
 	}
 
-	return ret;
+	return -EPROBE_DEFER;
 }
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
 

-- 
2.55.0

