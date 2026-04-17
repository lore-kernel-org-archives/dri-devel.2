Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB95BF43683
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27810E9D0;
	Fri, 17 Apr 2026 09:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="k7y4ybcR";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E1810E9CD
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:59:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B6214C5C3DB;
 Fri, 17 Apr 2026 10:00:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5437460497;
 Fri, 17 Apr 2026 09:59:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD5AC104609D4; 
 Fri, 17 Apr 2026 11:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776419979; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GIM+dcxS8lu18rSAReKvcdwXLUTzXndT5z9nh1cB178=;
 b=k7y4ybcRSiUl2SAlSLIhoqqXbE70Ha/scjb//ocenvB8kubD1kxacFWYlgX7LzDYmgq3zh
 zrw9gAk6Q8GzLuBHz/LKUMQCjb7cro+yJWu0EQPVl19Bw0lcmYnmER14gvoANpeTOJvqwH
 lrhikmkWPCgPVY7sc1GenCWlCCrvmcGfnad2DoWTm5/Cxyfgbr0WEGDoroWW52PTcmnGmA
 QMxVqdbiSs+E3HgJjrxvJBUN9f78/MQlz7K36v1Y3kIVa/QYdN+uuigDZHwgX5ZPdAZH2h
 BD9bGdm/5aFOi/LnQarSCUKvenp9k/OJCcVuBqzA3YS9WbEtCASWEgZVKpe9jg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 17 Apr 2026 11:58:21 +0200
Subject: [PATCH 33/41] drm/msm/dsi: remove now-redundant call to
 drm_connector_attach_encoder()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-drm-bridge-connector-attach_encoder-v1-33-67b8b8fb872a@bootlin.com>
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
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index ca400924d4ee..46faeaae9d94 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -485,10 +485,6 @@ int msm_dsi_manager_connector_init(struct msm_dsi *msm_dsi,
 		return PTR_ERR(connector);
 	}
 
-	ret = drm_connector_attach_encoder(connector, encoder);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 

-- 
2.53.0

