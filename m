Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2338DCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537AE10F384;
	Fri,  8 May 2026 07:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Y4UM19mg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A544410F387
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778223905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/eStwIMpD08Sr4D7cAHGOU+XdQrOvVtuLJ5JFB1WqE=;
 b=Y4UM19mgnJXL6uAEjSNJiQc6MATaVjDo5aTmVO1Gm1FEnZ1sU/lbEK53pV0KTspKoQKIu4
 16CL73pdEwXscu0PyFF/cTQSOdVX+Ibe2kPqte1A7PcMMAO9o/zFudQQjbURjLqhnA+C8c
 n5cekoEJB9P8lGW1HFF7LmUjuH3h8hU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-k2z99pc4OX2TkdVMySYzVQ-1; Fri,
 08 May 2026 03:05:01 -0400
X-MC-Unique: k2z99pc4OX2TkdVMySYzVQ-1
X-Mimecast-MFC-AGG-ID: k2z99pc4OX2TkdVMySYzVQ_1778223899
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E58418005B5; Fri,  8 May 2026 07:04:59 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D655300019F; Fri,  8 May 2026 07:04:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 08 May 2026 09:04:42 +0200
Subject: [PATCH v2 02/10] drm/panel/samsung-s6e63m0: Use refcounted
 allocation in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260508-drm_panel_init_rm-v2-2-0bd4ac429971@redhat.com>
References: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
In-Reply-To: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778223888; l=1556;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=JUEHCY3nWem2O1Tnc61gI2aykO76LQssUEuDz2yZWsI=;
 b=naTwUv6X5YF7pv7e68QjrGn4pu+55fhXf7r5Axvv0895cLLnBW0DNaVGVRqTtm/kQzbcwJm/a
 g90AjcfZ1IgAshdpBYJtOZMhIW+eV2JEH++A5SLwcNrkYWxxr+gabiW
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: YG_ceNVFSjfCJtJlIHTdBW08dDj66SmCASsrkyx25N8_1778223899
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
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

