Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB13F43683
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AF010E9B3;
	Fri, 17 Apr 2026 09:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KTkpVqjS";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD22110E9B1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:58:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 1C87BC5C3D8;
 Fri, 17 Apr 2026 09:58:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AFF7F60497;
 Fri, 17 Apr 2026 09:58:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DB9B104609D2; 
 Fri, 17 Apr 2026 11:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776419894; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JPQ1lTMTq7lc8ZTbKcFmQ9424xb17x4CJbO7aXHEFro=;
 b=KTkpVqjSPSh/akRuTevrdRNjcy+Z9Ij3arZp6osQ+OE5AKY0fgu+uLeXMAIeoNHnMYLYhW
 j6X31q/bgENiDWvxPcthhw66lrN3Qb3YhIrGAeGUwe7MSEFiNeFXOFwATXl2sFzqww4Zpu
 901AW01zkYhCd2Ibun82c02i1M8C6W5tnk4ietVriUq0Imk4aKwMe+9WbHpqd+tAqMEH0U
 9ih0s6a/KQZmjL5jvwjEkxxx/7eWknxgu/4NLV05aQOumqw+PZF67Y3W7bNf53BbVnaFuc
 70DfWdSOqQSXVvNJIV1DT5iL07oK4a9rRErI1I1Suq35Ta45NiA+wBZPLJ87Fg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 17 Apr 2026 11:57:53 +0200
Subject: [PATCH 05/41] drm/bridge: ti-sn65dsi86: remove now-redundant call
 to drm_connector_attach_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-drm-bridge-connector-attach_encoder-v1-5-67b8b8fb872a@bootlin.com>
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
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 98d64ad791d0..1336ffab103f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -776,8 +776,6 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
 		goto err_initted_aux;
 	}
 
-	drm_connector_attach_encoder(pdata->connector, pdata->bridge.encoder);
-
 	return 0;
 
 err_initted_aux:

-- 
2.53.0

