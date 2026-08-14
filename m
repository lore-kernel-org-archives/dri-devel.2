Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8B0C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD9510F5E0;
	Fri, 14 Aug 2026 14:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mhxK0Bz/";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750AB10F5E0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:06:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EC3591A163E;
 Fri, 14 Aug 2026 14:06:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C0CA06046D;
 Fri, 14 Aug 2026 14:06:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A92D711C4EDA1; 
 Fri, 14 Aug 2026 16:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4CNxE/FuxQGyWTMn05IYNxmHPIwqZ0RRLrWbypLR/yw=;
 b=mhxK0Bz/dgnNNbPSHw00s/A+V/Pc8/zxujm5ptozjlKdk144PY4JHJBpz1C+9MqRXs7ON1
 FMwWdTeY7mmr/dfjxOwtuyDmQTuoFJ617LYjISJZ5BceTGFzYjFc0z1RPPqUADBaO8+Lue
 FPKb6fz/O0uYEkf7QKZtN/jamYSdx6X6P6AJh/VWzS+qNBZ8rgkFYvN0WvfY3IJlfuvYP8
 4c3cW9sK2+SipAgv8MPvtnZzJIgR3K4y+vnx92MwuDJAcQiAQT/qQEVZEr308C8RSSKjAC
 G4F0+Uk0NTBDxsrOTuiKQoD4514LjG5vJq4HdjRxsjN25+pKtA+s358DMlg00Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:49 +0200
Subject: [PATCH 01/11] drm: of: drm_of_find_panel_or_bridge: simplify
 freeing the remote node pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-1-19cd5277cc8d@bootlin.com>
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

In prepataion to further modify the logic of this function, simplify
putting the struct device_node pointer by using a cleanup action.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_of.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index e495117735e1..b42a321f3052 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -288,7 +288,6 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_bridge **bridge)
 {
 	int ret = -EPROBE_DEFER;
-	struct device_node *remote;
 
 	if (WARN_ON(!panel))
 		return -EINVAL;
@@ -304,7 +303,8 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	if (!of_graph_is_present(np))
 		return -ENODEV;
 
-	remote = of_graph_get_remote_node(np, port, endpoint);
+	struct device_node *remote __free(device_node) =
+		of_graph_get_remote_node(np, port, endpoint);
 	if (!remote)
 		return -ENODEV;
 
@@ -326,7 +326,6 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 
 	}
 
-	of_node_put(remote);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);

-- 
2.55.0

