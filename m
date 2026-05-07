Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B70CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A563110F059;
	Thu,  7 May 2026 11:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Z9oyr8IT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E4F10F059
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aL8b2eqRuN5AkolwnhE/0kxkp+dMT6ZMyaM56y6Sov8=;
 b=Z9oyr8IT27sAeLhyIfZ9ltYkAfZA6BJ+axuMpGdHaWZJKRQ4KTArTt2A2NhiHLpg8pdRzz
 3RcaWRxWN4wARZNpix+Yyh2JalC7/OnodvNQKiuw3/mvBMxeMIO+ydKXVak5NlMzjaTzqW
 xSsTOt3m51KDrGh0+djtQ1giGP4bEEk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-7dFsKPWJNk-N8eLes8mK3Q-1; Thu,
 07 May 2026 07:53:27 -0400
X-MC-Unique: 7dFsKPWJNk-N8eLes8mK3Q-1
X-Mimecast-MFC-AGG-ID: 7dFsKPWJNk-N8eLes8mK3Q_1778154805
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5A6519560A1; Thu,  7 May 2026 11:53:24 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 870C01953947; Thu,  7 May 2026 11:53:21 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 07 May 2026 13:53:00 +0200
Subject: [PATCH 02/10] drm/panel/samsung-s6e63m0: Use refcounted allocation
 in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260507-drm_panel_init_rm-v1-2-51f448c7c291@redhat.com>
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
In-Reply-To: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michael Tretter <m.tretter@pengutronix.de>, 
 Michael Walle <mwalle@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=1450;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=8seNNF5wmZlO2lSkwjfLccs1a8t3KBai4sgzDIvFS5o=;
 b=WOOMcyQ5k/wALs3jxb+iPt0SzJc9CKbNtOugRO9vF+tLbsLd0fIKzC46/zVuM3OAKyU7y1FFg
 /wFmzhsMKnfBbWoFWhCRDwZUgY9f3dPLKY7jl1m4qPJsXciZfJdeaNn
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: bgg50G6UL_p_SgBE66R_Sk0RXJ-Ec2WrcGznE1yFM4I_1778154805
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index ea241c89593b6..997115b1e541d 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -677,9 +677,13 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 	u32 max_brightness;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				  &s6e63m0_drm_funcs,
+				  dsi_mode ? DRM_MODE_CONNECTOR_DSI :
+				  DRM_MODE_CONNECTOR_DPI);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ctx->transport_data = trsp;
 	ctx->dsi_mode = dsi_mode;
@@ -712,10 +716,6 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
-	drm_panel_init(&ctx->panel, dev, &s6e63m0_drm_funcs,
-		       dsi_mode ? DRM_MODE_CONNECTOR_DSI :
-		       DRM_MODE_CONNECTOR_DPI);
-
 	ret = s6e63m0_backlight_register(ctx, max_brightness);
 	if (ret < 0)
 		return ret;

-- 
2.53.0

