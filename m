Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1CECD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76A610F070;
	Thu,  7 May 2026 11:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bOA6gGlO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A970010F070
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EA0KuE+QB/5ASorP5EN+xJCb7/3W5RAUH7flyU8bE9U=;
 b=bOA6gGlOt9lrbgFtIZ0dH1Ad6fqLM8uJ7P4GGAsRy3zhlCkSM/fd+Xgrwr7BgGsdOK6Jsf
 BrXXOJxFlAQ+bL00LcwF7XFXhcW+tJMLwmjp1zqq9cTm16/UZ85Ff/pIFLIDAKgXm21ZKh
 FKNHf2Y8hcRdFKjWNYmQvEW4BeHo6qE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-sRcaydGjMaGCAlXRpRJYEw-1; Thu,
 07 May 2026 07:53:46 -0400
X-MC-Unique: sRcaydGjMaGCAlXRpRJYEw-1
X-Mimecast-MFC-AGG-ID: sRcaydGjMaGCAlXRpRJYEw_1778154824
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7E3418002DC; Thu,  7 May 2026 11:53:44 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D30281944B08; Thu,  7 May 2026 11:53:41 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 07 May 2026 13:53:06 +0200
Subject: [PATCH 08/10] drm/panel/truly-nt35597: Use refcounted allocation
 in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260507-drm_panel_init_rm-v1-8-51f448c7c291@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=1348;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=Tt9ZWviFs6uLhSDVey/W9KZGDljayO065cRCjOaQwXs=;
 b=YvLXZGvmRMy/GsCnCjr7h3n2ExJUbpq1ZIkaei+z2gOAqrS0T5VHuWRCdB18AtbEZVzh0jW19
 EoUWAtN0lbEAW3WMikgBirTmHzbgjI9kjW28TiyUP8oNluSQTXNx9dq
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: GMwd1CvqpCHdDBcRe_fvdhWPq8k05ZT134iZTi_0Uko_1778154824
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
 drivers/gpu/drm/panel/panel-truly-nt35597.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index d447db912a61e..f740b9257c09c 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -476,8 +476,6 @@ static int truly_nt35597_panel_add(struct truly_nt35597 *ctx)
 	/* dual port */
 	gpiod_set_value(ctx->mode_gpio, 0);
 
-	drm_panel_init(&ctx->panel, dev, &truly_nt35597_drm_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	drm_panel_add(&ctx->panel);
 
 	return 0;
@@ -523,10 +521,12 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 		.node = NULL,
 	};
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				  &truly_nt35597_drm_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
 
-	if (!ctx)
-		return -ENOMEM;
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	/*
 	 * This device represents itself as one with two input ports which are

-- 
2.53.0

