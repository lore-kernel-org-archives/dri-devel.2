Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B552DCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CD710F381;
	Fri,  8 May 2026 07:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eZ1TcvkX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C76C10F381
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778223915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stC3h3MHcmK2P0dezLV1nWsyclpObqsD2Ho0cm6fPRk=;
 b=eZ1TcvkXQH7dor87p2ZfmpWBhLDIvW32sNtVAw07TrI3hMKcSRUA7HctEhcPqDc5u4h/IE
 AayHUKZveTFmKxNn/HT7kvTiafFwrY9JAlzPauNSeGLRLw2SmQqY3QNLBQDNHBVYqTYa7o
 5XdP7HDQVvDrU8vB/j933vORSf4o/nU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-PtdU6G-pPYycJEEqXBKVJg-1; Fri,
 08 May 2026 03:05:08 -0400
X-MC-Unique: PtdU6G-pPYycJEEqXBKVJg-1
X-Mimecast-MFC-AGG-ID: PtdU6G-pPYycJEEqXBKVJg_1778223906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4014319560B2; Fri,  8 May 2026 07:05:06 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C7C300019F; Fri,  8 May 2026 07:05:02 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 08 May 2026 09:04:44 +0200
Subject: [PATCH v2 04/10] drm/panel/lxd-m9189a: Use refcounted allocation
 in place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260508-drm_panel_init_rm-v2-4-0bd4ac429971@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778223888; l=1555;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=yG+RtBwhDZoj2AxhrujtWwgsytaELI8TN8cNu99TMXM=;
 b=PZ1IDLxB2ziRNNEoivKc/9wBwaE30ijFlju2I5tz3k/s5vwR/AZT9EerQDuH/S+dg+he++lKz
 +UM8mDrKgvyB81UYbjX6+mqHZvo9BBmcIXcrdumsp6sLjSc2BFYXqwP
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: nFNQX2H6rFifRQ5NQ9MQdprpwBI6QtnDQ9kBBT90yV8_1778223906
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
 drivers/gpu/drm/panel/panel-lxd-m9189a.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lxd-m9189a.c b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
index 68019e1e43a96..baaf170779e03 100644
--- a/drivers/gpu/drm/panel/panel-lxd-m9189a.c
+++ b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
@@ -165,9 +165,12 @@ static int lxd_m9189_probe(struct mipi_dsi_device *dsi)
 	struct m9189_panel *m9189;
 	int ret;
 
-	m9189 = devm_kzalloc(dev, sizeof(*m9189), GFP_KERNEL);
-	if (!m9189)
-		return -ENOMEM;
+	m9189 = devm_drm_panel_alloc(dev, __typeof(*m9189), panel,
+				    &m9189_panel_funcs,
+				    DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(m9189))
+		return PTR_ERR(m9189);
 
 	m9189->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(m9189->supply))
@@ -191,8 +194,6 @@ static int lxd_m9189_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
 
-	drm_panel_init(&m9189->panel, dev, &m9189_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	m9189->panel.prepare_prev_first = true;
 
 	ret = drm_panel_of_backlight(&m9189->panel);

-- 
2.53.0

