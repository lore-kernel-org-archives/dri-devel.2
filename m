Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3836CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620C510F061;
	Thu,  7 May 2026 11:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XM0Yw3EI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3116110F061
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRfKp+svIbC/1Z6WC5kfdf6Q8yUsYq0CxMzwjfbjmB0=;
 b=XM0Yw3EIIQZ3HiWVoc3O605SbYSf+8BWuE9bZdf3NfbrH5Tw6rfgioZ6HyKhlERBoigc2/
 pnnoWkXNWGDgJhbLDP31xotqdS8YSi3n53ntywrUPJsnxsz6z07VPuti8/UxtIgoP08Trf
 B1VSXAoqC6QhJzW4/0sPNjWAATpEyAA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-V401mtd_MCeNriVL3gurWw-1; Thu,
 07 May 2026 07:53:37 -0400
X-MC-Unique: V401mtd_MCeNriVL3gurWw-1
X-Mimecast-MFC-AGG-ID: V401mtd_MCeNriVL3gurWw_1778154815
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05F761955F3D; Thu,  7 May 2026 11:53:35 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16FB71953947; Thu,  7 May 2026 11:53:31 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 07 May 2026 13:53:03 +0200
Subject: [PATCH 05/10] drm/panel/ilitek-ili9806e: Use refcounted allocation
 in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260507-drm_panel_init_rm-v1-5-51f448c7c291@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=1437;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=IaFUJ7+3s2xTJ69WdANK0mreSE3YchmxzKWGbkL/Z5I=;
 b=Oj05dVEcXgVB9i+IavuMuqR812x8MKQnlX1VV7xi97LUrPiaLB6naeT05XhGc0wcXEX6nRXCY
 Y63c0kfSrpnBq8XJ/yVpBypxPC29oMX56r/ImJq64jyrFU2wRX7SDsu
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: WjJY0QBfPxOdyyCnmoJqLwBlj4KNb_91kobIqxXXcGY_1778154815
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
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
index be2cf14401553..53e25d1086db8 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
@@ -78,9 +78,11 @@ int ili9806e_probe(struct device *dev, void *transport,
 	bool set_prepare_prev_first = false;
 	int ret;
 
-	ctx = devm_kzalloc(dev, sizeof(struct ili9806e), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				  funcs, connector_type);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	dev_set_drvdata(dev, ctx);
 	ctx->transport = transport;
@@ -103,8 +105,6 @@ int ili9806e_probe(struct device *dev, void *transport,
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
 
-	drm_panel_init(&ctx->panel, dev, funcs, connector_type);
-
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");

-- 
2.53.0

