Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AA5F43683
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0633710E9CC;
	Fri, 17 Apr 2026 09:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fXfBsvSe";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F23310E9CC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:59:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7370B1A3329;
 Fri, 17 Apr 2026 09:59:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 486CB60497;
 Fri, 17 Apr 2026 09:59:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4D787104609DB; 
 Fri, 17 Apr 2026 11:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776419971; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=UVZBM3qKgBxuYxQMCLXJt4FD6qsQcz8YYge/VPeKv7I=;
 b=fXfBsvSexFWNo0K5o+lqtnnsCD9LkusLBwSmgbZsgeRPr7J/8Gz8Rywyax+B5N1kLwo1jk
 JWM3TREoxtsyFf900EwxXpt05ufTf0EKu91pz9rRkAZUqr2CyA4zuQSElhuXEDWn6NAmVT
 pmtVD+nElsHKhUUHuMhY1fjDzG3SnasQUslA5L+uKNhXX/zM8U4D4ZxqevlwewdiahmI47
 vs3tnmHt5Qjqx8D84WfcobZDFdloiI64w12hPFgYKpIV4WYx6Y4IpweiqB91/yGhVVb7ks
 UBnS6QBPMD6X4DD2G16fj09RkvScb3tmvC654k4VTQDuAc3uIg6Rs+1Y1tTwGA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 17 Apr 2026 11:58:18 +0200
Subject: [PATCH 30/41] drm/rockchip: dw_hdmi_qp: remove now-redundant call
 to drm_connector_attach_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-drm-bridge-connector-attach_encoder-v1-30-67b8b8fb872a@bootlin.com>
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
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index c78db7f8ab6c..f35484715c2d 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -603,7 +603,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
-	return drm_connector_attach_encoder(connector, encoder);
+	return 0;
 }
 
 static void dw_hdmi_qp_rockchip_unbind(struct device *dev,

-- 
2.53.0

