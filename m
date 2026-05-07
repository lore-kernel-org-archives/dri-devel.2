Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D7BCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8BA10F05F;
	Thu,  7 May 2026 11:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ztg0AE8K";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AF610F05F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZF/mON8kP1kMtu1A4HwYOmzCkw8/+Js6fL/I70vtMU=;
 b=Ztg0AE8Kg6nfvnBx4UxR+gURSkzw9iIi9ck7JdmtlZuWAGLmLpYcMBPNsBPQw8Qzcld4+E
 kBkRYkuUgDN520vWi4f6lD0TPOuLWLPmB4ssDZhsWzgcY2ryo1ZoNeNgwznaPuV2LP0LG+
 TH/vFmXgturCLBZWcJVHQYhKCSWqtSc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-FRtBiKSNPyS0FnIGyvKGUg-1; Thu,
 07 May 2026 07:53:33 -0400
X-MC-Unique: FRtBiKSNPyS0FnIGyvKGUg-1
X-Mimecast-MFC-AGG-ID: FRtBiKSNPyS0FnIGyvKGUg_1778154812
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5CAA19560A6; Thu,  7 May 2026 11:53:31 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D41D71953947; Thu,  7 May 2026 11:53:28 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 07 May 2026 13:53:02 +0200
Subject: [PATCH 04/10] drm/panel/lxd-m9189a: Use refcounted allocation in
 place of devm_kzalloc()
MIME-Version: 1.0
Message-Id: <20260507-drm_panel_init_rm-v1-4-51f448c7c291@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=1449;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=9tufjyYUKdnTm46sdQqwurSTxCDuKd4OYLCAWRs7Jos=;
 b=tN2XFGQ3bahFvpxu+iiImreUmiA3QU4z6Fj0sTBWVejx2ooS3EBE4m5LnUihY3LoQ3aMkL3U2
 RQnUUnH0M9tCID1yurD3lutEXaP4hksOZ7UMEZdUaUxLUIp7C/pmSQs
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Aj-p5F_Wcems1sQfJFO1WvsQFckB1p15RNk5fBvdlMQ_1778154812
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

