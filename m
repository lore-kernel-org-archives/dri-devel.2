Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EB5CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9A010F386;
	Fri,  8 May 2026 07:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aB9VVS6Q";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB0810F386
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778223921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSX3kT04dBcUx7McLbktqYQMd8rf0d072yGD6WxHixk=;
 b=aB9VVS6QeKCkj9i6Rz8K8Uhb8u2q3+9+xwCp+VK4TR3lm2+/3KO3awX5n6uE8ubucBut5i
 G/UCCjCx4CTXpivjCILz7TpgKwbJNBE9gfRgMPju/BQknkeNdO7Am4CXlFm6RJQJ2OsWcL
 fwexbS5G3otc5vk8AT9PwrtShj8rpus=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-DZsgZeDNOc-5y9chhIdsbA-1; Fri,
 08 May 2026 03:05:17 -0400
X-MC-Unique: DZsgZeDNOc-5y9chhIdsbA-1
X-Mimecast-MFC-AGG-ID: DZsgZeDNOc-5y9chhIdsbA_1778223915
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82FB91956096; Fri,  8 May 2026 07:05:15 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4C0E300019F; Fri,  8 May 2026 07:05:12 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 08 May 2026 09:04:47 +0200
Subject: [PATCH v2 07/10] drm/panel/sharp-ls043t1le01: Use refcounted
 allocation in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260508-drm_panel_init_rm-v2-7-0bd4ac429971@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778223888; l=1588;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=5N9oFZ8HECJaLNtbmhn4A0O6HWE+JPp+zj5icqVBAbc=;
 b=mcvbDNGOVmsfyi/2gkIGXSeDxM7nJMC8PJR4/N/+oZWpvwIuaaTnOgQx2n70mFJyN6U6EgYQr
 Q9tVE5X499zDk5U3ZGtReynH+zPE+f4JEbYzpfYG/Vj90CoZ4BIwE9y
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: GmrOAw0yE9w0N8zQYzDgRJ_mI-OYmFAV1OK5RaLt74w_1778223915
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
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index dd1eaba23ad3c..989b030ea22de 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -199,8 +199,6 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
 		gpiod_set_value(sharp_nt->reset_gpio, 0);
 	}
 
-	drm_panel_init(&sharp_nt->base, &sharp_nt->dsi->dev,
-		       &sharp_nt_panel_funcs, DRM_MODE_CONNECTOR_DSI);
 	sharp_nt->base.prepare_prev_first = true;
 
 	ret = drm_panel_of_backlight(&sharp_nt->base);
@@ -231,9 +229,12 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 			MIPI_DSI_CLOCK_NON_CONTINUOUS |
 			MIPI_DSI_MODE_NO_EOT_PACKET;
 
-	sharp_nt = devm_kzalloc(&dsi->dev, sizeof(*sharp_nt), GFP_KERNEL);
-	if (!sharp_nt)
-		return -ENOMEM;
+	sharp_nt = devm_drm_panel_alloc(&dsi->dev, __typeof(*sharp_nt), base,
+					&sharp_nt_panel_funcs,
+					DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(sharp_nt))
+		return PTR_ERR(sharp_nt);
 
 	mipi_dsi_set_drvdata(dsi, sharp_nt);
 

-- 
2.53.0

