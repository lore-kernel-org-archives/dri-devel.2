Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9EB606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LEXBSZ1w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A86112A46;
	Fri, 27 Nov 2026 11:21:28 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803B010E5B8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:21:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 21C4E4E417C3;
 Fri, 27 Nov 2026 11:21:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EAB626049C;
 Fri, 27 Nov 2026 11:21:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1A1B911E6930D; Fri, 27 Nov 2026 12:21:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795778472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nOxes14wQRCie7+aKqzYUwuQPRSHdGILYH8KNpmcKRM=;
 b=LEXBSZ1w9hzu5mqA6pG1zvEQXX3/Z9ZRXXob+dTjKM5UC0O0xW8QlZACuAYzG7x0H6vXEd
 l3XkU6zla7WMYOtn427eATARnIPUGTCu/z66VsRZo00Ha/M/IcFqrfZxVyTlXQmf9NYmSC
 +10aWmi80VDWXhXnLyzE+l8vfCY+Er8cZr/V6sQpmcwp0Iv2THdumm4SFE4obBK6yROIuD
 RTj6XCA4g3hVqnnMyoexUXuPLKolzd09jmOHtD+pipHZAYv9o/FZkd5dRxHuiE8LWEO4Wk
 Tl1gy0vQxwAcio7eoixbaFcftYbBqP7gRJwsgQKlpB+7qWUijTugY4qGWFLeOw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 27 Nov 2026 12:20:38 +0100
Subject: [PATCH v2 3/4] drm/bridge: ite-it66121: log an error if the IDs do
 not match
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-ite-it66121-log-probe-errors-v2-3-dbe9b5a3c5df@bootlin.com>
References: <20261127-drm-ite-it66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com>
In-Reply-To: <20261127-drm-ite-it66121-log-probe-errors-v2-0-dbe9b5a3c5df@bootlin.com>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If the IDs read from the chip do not match any of the known models,
it66121_probe() fails silently, making troubleshooting unnecessarily
difficult. Log an error to clarify the failure reason, showing the IDs read
from the hardware.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 4642a32f1bd0..596c31f3d5a9 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1661,7 +1661,8 @@ static int it66121_probe(struct i2c_client *client)
 	}
 
 	if (i == ARRAY_SIZE(it66xx_chip_info))
-		return -ENODEV;
+		return dev_err_probe(dev, -ENODEV, "Unknown vendor %04x device %04x (rev %01x)\n",
+				     vendor_id, device_id, revision_id);
 
 	ctx->bridge.of_node = dev->of_node;
 	ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;

-- 
2.56.1

