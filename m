Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A8CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FB810F382;
	Fri,  8 May 2026 07:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BTU9P6kO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EB310F382
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778223917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=boV6EPQtUfzTmTg+5yfj+I+/wEttTpMW77VvDFs9D8k=;
 b=BTU9P6kOzsbhNuS72qBpaJmwAMZZZb+OS1g8Ja2OFI1s95Gdks7SKhcObNjgqwU3FZCC3w
 rXGUsBLKJZSO8kdK/Uy7XtdloRONBjgHk5gc1otNSIFIxMQDFIPd75tae4c9F55D6a5J+B
 JoGrRNxOIK1PCr7mSFYxYwhEzEETLFI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-dxLPL3QCNTCEbBnWqh8FNQ-1; Fri,
 08 May 2026 03:05:14 -0400
X-MC-Unique: dxLPL3QCNTCEbBnWqh8FNQ-1
X-Mimecast-MFC-AGG-ID: dxLPL3QCNTCEbBnWqh8FNQ_1778223912
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 817EC195608F; Fri,  8 May 2026 07:05:12 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE84E300019F; Fri,  8 May 2026 07:05:09 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 08 May 2026 09:04:46 +0200
Subject: [PATCH v2 06/10] drm/panel/tdo-tl070wsh30: Use refcounted
 allocation in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260508-drm_panel_init_rm-v2-6-0bd4ac429971@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778223888; l=1753;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=7kTj1OHxzG5jFzOAGeWNfUFLlc9UET6DJf46M5QiT1A=;
 b=XPhC+ZOSnNwfKV1RBSPp7cP9ZrJkEr1Q2wQ6wijfIO9DQBmJxmZDsBvMONqVLGTA1nAK2VN+S
 h2mtloqrhuMDdAgih8ExpMM0JE7HVl6+zNWTUtfCEOKr6hlaPehlEoC
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: DE81zkaH1Aoois_5-b-lhgj1V-r-i_GlguErohhFATg_1778223912
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
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 227f97f9b136f..13cfe252a838d 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -162,9 +162,6 @@ static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
 		return err;
 	}
 
-	drm_panel_init(&tdo_tl070wsh30->base, &tdo_tl070wsh30->link->dev,
-		       &tdo_tl070wsh30_panel_funcs, DRM_MODE_CONNECTOR_DSI);
-
 	err = drm_panel_of_backlight(&tdo_tl070wsh30->base);
 	if (err)
 		return err;
@@ -183,10 +180,13 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
 
-	tdo_tl070wsh30 = devm_kzalloc(&dsi->dev, sizeof(*tdo_tl070wsh30),
-				    GFP_KERNEL);
-	if (!tdo_tl070wsh30)
-		return -ENOMEM;
+	tdo_tl070wsh30 = devm_drm_panel_alloc(&dsi->dev,
+					      __typeof(*tdo_tl070wsh30), base,
+					      &tdo_tl070wsh30_panel_funcs,
+					      DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(tdo_tl070wsh30))
+		return PTR_ERR(tdo_tl070wsh30);
 
 	mipi_dsi_set_drvdata(dsi, tdo_tl070wsh30);
 	tdo_tl070wsh30->link = dsi;

-- 
2.53.0

