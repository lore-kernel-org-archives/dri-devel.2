Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A330CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B033C10F37A;
	Fri,  8 May 2026 07:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FvSGNCjy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACA910F37A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778223902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEIWSC/LzTP1Y8U/w/oIW/sTeQOqE1yb03dQC3rGJik=;
 b=FvSGNCjyCDHsFxn9yqeYGiDSiKKSYkGBUChD/ikzNS1EHVyl+NuA3vP+QvJiW49zR0SHmf
 EETHVvr2SZqkWvVIPsi/45/SDH0RgmOMbzOk6mSD12canOrX7+vge8/BFvI0KEW/C+Dorr
 BNG9zifnZ/7GUl8tsqMwPYCenwuM8Aw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-eAlVK23ENwq-XxbNR1PBSw-1; Fri,
 08 May 2026 03:04:57 -0400
X-MC-Unique: eAlVK23ENwq-XxbNR1PBSw-1
X-Mimecast-MFC-AGG-ID: eAlVK23ENwq-XxbNR1PBSw_1778223896
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC9D195605F; Fri,  8 May 2026 07:04:55 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C243002D2F; Fri,  8 May 2026 07:04:52 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 08 May 2026 09:04:41 +0200
Subject: [PATCH v2 01/10] drm/panel/visionox-g2647fb105: Use refcounted
 allocation in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260508-drm_panel_init_rm-v2-1-0bd4ac429971@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778223888; l=1809;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=J4BYgZvSPEC7KD8UFBDqPUsOJ+VWpE3A9JUo6gEYSUo=;
 b=OdB8oTTIzPIEDtPlCL7I2gDE7OHi+BTQRhoqnWq7ErdLjWmULyOtjdi/iDRsj8Z4M6wfNwUEH
 9XdJZf1rfB0A5+f1UxK3WvAq07jbv8tAwq7JCORW7tbayb6ZoTnZQZ6
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: rHB9dn5a1EnPRN4RsoT5uMeGeq26Teiy_i0sXtRUT-Q_1778223896
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
__typeof() for more type safety. Also deduplicate the prepare_prev_first
assignment that was set both before and after drm_panel_init().

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/panel/panel-visionox-g2647fb105.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c b/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
index 413849f7b4dec..d5555a1731575 100644
--- a/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
+++ b/drivers/gpu/drm/panel/panel-visionox-g2647fb105.c
@@ -207,9 +207,12 @@ static int visionox_g2647fb105_probe(struct mipi_dsi_device *dsi)
 	struct visionox_g2647fb105 *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				  &visionox_g2647fb105_panel_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ret = devm_regulator_bulk_get_const(dev,
 					    ARRAY_SIZE(visionox_g2647fb105_supplies),
@@ -233,10 +236,6 @@ static int visionox_g2647fb105_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
-	drm_panel_init(&ctx->panel, dev, &visionox_g2647fb105_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-	ctx->panel.prepare_prev_first = true;
-
 	ctx->panel.backlight = visionox_g2647fb105_create_backlight(dsi);
 	if (IS_ERR(ctx->panel.backlight))
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),

-- 
2.53.0

