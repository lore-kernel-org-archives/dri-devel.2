Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E90CCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 945DD10EB98;
	Thu, 15 Oct 2026 09:49:44 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91F611226E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:49:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7CB051A1224;
 Thu, 15 Oct 2026 09:49:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5178160360;
 Thu, 15 Oct 2026 09:49:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3F82C10328BD2; 
 Thu, 15 Oct 2026 11:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792057772; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=QZZsjZ1RvwlA3HlqbPaiuTTXp0IybfCUheX4Ww9/Dv0=;
 b=wa2tZLObEd/IQ/4YvZ2TdkQ0TCDfN0lebMhyNiJleQ62bQRH9yxVfERpdzTrr0JWYqhKu+
 U4BslktjLRslyBpAYe/alJG0f32wLxrFLrrOSMyu4pZh1dduwTmYUmGAAW+fG5Wc+mLaCt
 rm0MXJc1qDLKaPnS6Q3RkPzh862/8ww2tweeAwi/iAZqi/PtoF1/uKhR5/0c0RMwlWN6G8
 hzlCIBYS+H59M6yYtvf6l2xEGph4IKQ8NcMTHuSO8d/dtUz6zt+X3NE96G7hNVXiM3vw1c
 +29B2ZfpSyo9ggN1xOdrxlAZt85RtxLPS/VJzEams+FXyPn+NOhbYHulna831g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 15 Oct 2026 11:48:48 +0200
Subject: [PATCH 3/3] drm/bridge: ite-it66121: make successful probe quiet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-ite-it66121-log-probe-errors-v1-3-7fd6994e0be0@bootlin.com>
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
In-Reply-To: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
To: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Julien Chauveau <chauveau.julien@gmail.com>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, Nishanth Menon <nm@ti.com>, 
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

When drivers are working properly they should be quiet. Turn the dev_info()
into a dev_dbg(). While there, also make it more informative.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 49eb8318e974..11647b1ac735 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1709,7 +1709,8 @@ static int it66121_probe(struct i2c_client *client)
 
 	drm_bridge_add(&ctx->bridge);
 
-	dev_info(ctx->dev, "IT66121 revision %d probed\n", revision_id);
+	dev_dbg(ctx->dev, "IT66121 vendor %04x device %04x revision %d probed\n",
+		vendor_id, device_id, revision_id);
 
 	return 0;
 }

-- 
2.56.0

