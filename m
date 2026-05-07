Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CE9CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DB710F05D;
	Thu,  7 May 2026 11:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VIRvy6Z1";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C627F10F05D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tySrcuxHNKCxHzUnJqEkD2hz1lP/Bb/SWB6xgNCtY78=;
 b=VIRvy6Z1W+zSUvYUyeb68HNbTKCKtkZO6/afPBHIF05bMiRu51VTkLlCEDM39w7GeXQY7F
 nV1k1RTwg/QC1fHUbX+q4/t5md2JcfR2mzswi21j4tANWAiqv5uXDRwnaSaPchMO2rrlPv
 BZxuuetEt8rqk1QJBIe6SSQlC3Cu3YA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-EYMNrU16PgyIhiMp9ocCLA-1; Thu,
 07 May 2026 07:53:30 -0400
X-MC-Unique: EYMNrU16PgyIhiMp9ocCLA-1
X-Mimecast-MFC-AGG-ID: EYMNrU16PgyIhiMp9ocCLA_1778154808
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 793B919560B2; Thu,  7 May 2026 11:53:28 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FA7B1944B08; Thu,  7 May 2026 11:53:25 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 07 May 2026 13:53:01 +0200
Subject: [PATCH 03/10] drm/panel/novatek-nt37700f: Use refcounted
 allocation in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260507-drm_panel_init_rm-v1-3-51f448c7c291@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=1503;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=Cmzk5b8fn7iFO8uFcvkpBYq71dcoiN/cpahXR6+rA0c=;
 b=Q4HNRzcp+adAfamJ/WZYx7KzY11jTbemvA9jlj+djkr79JXYbLcUfNtyzR2ikl5fvKAjGs0mk
 Q3ZJi6pyjZgAvgA+pLBhwoxKL74FRup5u3fynGcwkwqsGasHd8SErEg
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: waIDXiiTRP_nMABhmJZaa5yc_z-OVPVs7uWy2d_uBnk_1778154808
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
 drivers/gpu/drm/panel/panel-novatek-nt37700f.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
index 74f46a268c0f6..c221dd498fed4 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
@@ -225,9 +225,12 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
 	struct nt37700f_tianma *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				  &nt37700f_tianma_panel_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ctx->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(ctx->supply))
@@ -247,8 +250,6 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
 
-	drm_panel_init(&ctx->panel, dev, &nt37700f_tianma_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	ctx->panel.prepare_prev_first = true;
 
 	ctx->panel.backlight = nt37700f_tianma_create_backlight(dsi);

-- 
2.53.0

