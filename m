Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F9F43683
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9498410E9C3;
	Fri, 17 Apr 2026 09:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eze0Ki2+";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3837A10E9C3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:59:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 236C84E42A24;
 Fri, 17 Apr 2026 09:59:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EE6B660497;
 Fri, 17 Apr 2026 09:59:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DBC92104609D6; 
 Fri, 17 Apr 2026 11:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776419939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XwidxyoogX5GWOhGVcE3zNBKFfumjMOvx5cL+pFRRzU=;
 b=eze0Ki2+uGD8b4vF+XJpjTycODBeRI12PaPkotvxL8jtGN5o9+qDcT3dCBr7dc4wb1mA8s
 OrqGZGM6dSHypoaMWVyryxiJixo+9Bx1yPO9mMDZaa7N39BpTkheSeVStDsspVRdOBWPBr
 Cay5scO68lIu34F5SX9vwJ1SyLxDpgE++Egz2jzDFWyBrA/6gFydWBBuDXGo4CBvkuBpAZ
 gN4lS4hjwnW0scpkYFQaUtoWhLtfw1bmphqJuCIILQB+TyefKWkV07lLfNq5EmfzOkAyvu
 NksQdljhDjxXi0Y+5z7arERf8vkr7sUvQlleLGauSAXzK01FPGwiMhQbY/2wsw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 17 Apr 2026 11:58:07 +0200
Subject: [PATCH 19/41] rm/rockchip: cdn-dp: remove now-redundant call to
 drm_connector_attach_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-drm-bridge-connector-attach_encoder-v1-19-67b8b8fb872a@bootlin.com>
References: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
In-Reply-To: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
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

drm_connector_attach_encoder() is now called by
drm_bridge_connector_init().

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 177e30445ee8..f39450e12716 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1024,8 +1024,6 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	drm_connector_attach_encoder(connector, encoder);
-
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 

-- 
2.53.0

