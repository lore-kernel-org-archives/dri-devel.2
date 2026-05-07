Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7667FCD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD14710F068;
	Thu,  7 May 2026 11:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bYnnh8Ly";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3143510F068
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IE3BWZyYOdu5leK97onwAvhZpTyClEu6HIwPYoGCizI=;
 b=bYnnh8LymoBNd5xfrgDjy9wrMfOipQKt5G8y6SqXMnMRUwonlXtGLOcjnP1tJ6uhqXgXpI
 pItKbKKuVXnq3wHbSzi5LLdKh8BO+1Ks+HBf8+AX09BJs+l+K/cGHZAcZAmAM5gDwCyuzs
 C7niD1z7BZgmPk/0PPMkvdErTeSncmc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-M_y67Cc-Oz2uFZh3TiP7Pg-1; Thu,
 07 May 2026 07:53:40 -0400
X-MC-Unique: M_y67Cc-Oz2uFZh3TiP7Pg-1
X-Mimecast-MFC-AGG-ID: M_y67Cc-Oz2uFZh3TiP7Pg_1778154818
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46E4D1956088; Thu,  7 May 2026 11:53:38 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DD141953947; Thu,  7 May 2026 11:53:35 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 07 May 2026 13:53:04 +0200
Subject: [PATCH 06/10] drm/panel/tdo-tl070wsh30: Use refcounted allocation
 in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260507-drm_panel_init_rm-v1-6-51f448c7c291@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=1647;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=FpHpJNHkCYgy3y8j0mWQ5oIzER8Ra/+Z02wOwSAM9MI=;
 b=k79Kee0ND/sFz/hICYWHWBkmsQB8rNRNnMCTjw+kOmBpy95zFjCzANyBg4zupJbkloa/fP+Ix
 U5Mup4kgkZTDOT0e5Mqt4bEy35LrBcsh57SBnPxwuMvQcTQIeDGL0k4
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Uc5tWjxkKj4kmp_06p0K3v1lh2ctXpkJLJKlBFOn_YU_1778154818
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

