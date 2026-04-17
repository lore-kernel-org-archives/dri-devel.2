Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB10CF43689
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D6D10E9D7;
	Fri, 17 Apr 2026 10:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GRtkZLVd";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF6D10E9D7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:00:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6380D1A3327;
 Fri, 17 Apr 2026 10:00:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2B31C60497;
 Fri, 17 Apr 2026 10:00:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3CA4E104609D4; 
 Fri, 17 Apr 2026 11:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776420000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=KGCHQISz4jze2O3gZozSUpCf+02kxnuwkXhAGX81w4I=;
 b=GRtkZLVd76iU1kdJ/z2LtSXXpAJl4xH0QHFI2A+gWoBvFfDM4xG9eEJl5zkImHnvoxNvTV
 pWW5tJbi7v8GP6S32ym1yPk63iJjU/XMEpsNJtwAB5EPlaQ+lVJybfqazVKD2skjvjxmBr
 3/YNbJmqgUNeK2luuISO7POq4VQyXReokWRMiz558r216aZgVEmd0uKqB3jUkV72vKJ4M8
 /xnbbAa3OKhN7B2H73jJfNKcirzQyQcbUce8j7hGWcP5e7FV9CpBpxt/CwNlZ9hMnNBOgJ
 WZZNDDDm8bD424tp6x8j3z7IlEPWaTkLCBsStXpatunqia5/Kk+N7a96Kmyn3Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 17 Apr 2026 11:58:29 +0200
Subject: [PATCH 41/41] drm: renesas: shmobile: remove now-redundant call to
 drm_connector_attach_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-drm-bridge-connector-attach_encoder-v1-41-67b8b8fb872a@bootlin.com>
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
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 5f460b38596c..866afe805e6f 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -596,20 +596,21 @@ int shmob_drm_connector_create(struct shmob_drm_device *sdev,
 	struct drm_connector *connector;
 	int ret;
 
-	if (sdev->pdata)
+	if (sdev->pdata) {
 		connector = shmob_drm_connector_init(sdev, encoder);
-	else
+
+		ret = drm_connector_attach_encoder(connector, encoder);
+		if (ret < 0)
+			goto error;
+	} else {
 		connector = drm_bridge_connector_init(&sdev->ddev, encoder);
+	}
 	if (IS_ERR(connector)) {
 		dev_err(sdev->dev, "failed to created connector: %pe\n",
 			connector);
 		return PTR_ERR(connector);
 	}
 
-	ret = drm_connector_attach_encoder(connector, encoder);
-	if (ret < 0)
-		goto error;
-
 	connector->dpms = DRM_MODE_DPMS_OFF;
 
 	sdev->connector = connector;

-- 
2.53.0

