Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645A5C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9971910EDF9;
	Tue,  7 Jul 2026 15:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R1LBE8Zm";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EFE10EDF9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:33:43 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493ba701891so34641615e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783438422; x=1784043222; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fABNw2w97X9GRxh8PzbMHvVe6Mugz+Bwu+oLmBySnb4=;
 b=R1LBE8ZmINpRKXvY+RwQtYxnuhMH1W6XNuE7YB8nzk6UCiWOLG7uU4V09EVaBnn9nM
 /ech3zi7ePImvsL36baYbKoHDD6KZiqMlhEPuO15LWyH4nN3Agu9TPSHjLm4bW0I7CXB
 Mw+7970AFAWxq9936uHByXURoJzVbL4f9CJo1UKzG217pWVnMi9dWGOGYT446pLrqzBf
 cBALhD4AvAEDqpgkG4gqtGkESwXbkq3Tpk4cu0bDpFj+rn1GiQnoyLA1mA4cd9iZbONJ
 PyoLyafRUPZXq3TPR6rlWJektU0P/uhEtVPQ7CvwW5P6I00a7o0sABt/vGy1VGS5ZW1h
 y54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438422; x=1784043222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fABNw2w97X9GRxh8PzbMHvVe6Mugz+Bwu+oLmBySnb4=;
 b=ab+1xvs3ejGZ6nyR0PkHP8jWLe2APpP7oYJguKws40d7/7nWdyxD3DKxuZ0wzrzNmC
 QsH/80xxGC2rRf3fXEb44OaM6jF66xNdTzw9y6rdOk6EHkmzdQcTskOLJTMuhz4/1n2b
 LExyrjdRtwCOnO76SrPPn/UGq06AGoVpnXqm23wjMyyICmq/bSBRTAKb13OdSuyuBS8P
 r1cqNG0Dym0UEHaTYEwYR45w6Y6ypHGfEiSuZQWy5pzzXeXjZl6iWuCov+smijXbQo9X
 OD4doTVVTJv9W+U5tcy3qHFEPwgHBUB4kQoreA+V1y9kTmByM4wHaZsqFmbl+ZPwo6w7
 wmxg==
X-Gm-Message-State: AOJu0YwVv/+l0GydcOkAMyAMutLPyCTJtoJPIms1A23HHvzPXQylOHjB
 Sj/Hk1MkiR0ndC7Oa8InjYMvroZ03+f3fP0bM/8N7lAOojcCas73eNMv
X-Gm-Gg: AfdE7clTK74xojFvDFkE01/WFBKP5nOJe3HsoKttqljNJ0HhDZP2XVdlNHzn9lXy9Az
 JqJxvKzvtybVicmjMRImRAu1qHSdsjklsLrEc5osifu7WomJ8iBzwOs8rJ97lLyfu1pdCp14oMS
 AurcLSXgyqFU0sNTgdbveHeJwp6CJ3NPggWV+4EKxstlHjW/OhoXULMVETZwdoB0EgNMRoCOMx2
 uVtWzlgeA0hjSyE5RvbGMf0J1/PfPXcC857yfm5gXFNH/j2z5snKk8NGjlK8JFyJJ9kZKx1AeKx
 pbt44lwYiScwZs6QxzN2Wrsk4G+cywYK9utU+kSDNnSDXG3dQA4++q0vVA+AOrxgnQa42n+Hh6v
 AXcmL3PETfARC4tmcpwoqtetAxa3We00xFZxVN/zA+2QAsT58mxeRzhbjhlSGMM1WaNkIslYXPf
 P9ecA4nwsk+KBF57SbOqWevIFPPttQGwk=
X-Received: by 2002:a05:600c:154e:b0:493:d216:ed96 with SMTP id
 5b1f17b1804b1-493df0b6a8emr63241635e9.9.1783438421411; 
 Tue, 07 Jul 2026 08:33:41 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5b811sm100622385e9.13.2026.07.07.08.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:33:40 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 07 Jul 2026 17:33:26 +0200
Subject: [PATCH 1/2] drm/xlnx/zynqmp_dpsub: remove dependency on DRM simple
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-xlnx-simple-v1-1-df50c6665b02@gmail.com>
References: <20260707-xlnx-simple-v1-0-df50c6665b02@gmail.com>
In-Reply-To: <20260707-xlnx-simple-v1-0-df50c6665b02@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
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

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the drm_simple_encoder_init() helper usage in the
xlnx zynqmp_dpsub driver by open coding it and using the encoder atomic
helpers directly. This is a step to eventually get rid of this simple
KMS helper, once all drivers that use it have been converted.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index d5f9224505655..698ac692abce9 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -30,7 +30,6 @@
 #include <drm/drm_mode_config.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include <linux/clk.h>
@@ -417,6 +416,10 @@ static const struct drm_driver zynqmp_dpsub_drm_driver = {
 	.minor				= 0,
 };
 
+static const struct drm_encoder_funcs zynqmp_dpsub_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int zynqmp_dpsub_kms_init(struct zynqmp_dpsub *dpsub)
 {
 	struct drm_encoder *encoder = &dpsub->drm->encoder;
@@ -436,7 +439,8 @@ static int zynqmp_dpsub_kms_init(struct zynqmp_dpsub *dpsub)
 
 	/* Create the encoder and attach the bridge. */
 	encoder->possible_crtcs |= drm_crtc_mask(&dpsub->drm->crtc);
-	drm_simple_encoder_init(&dpsub->drm->dev, encoder, DRM_MODE_ENCODER_NONE);
+	drm_encoder_init(&dpsub->drm->dev, encoder, &zynqmp_dpsub_encoder_funcs,
+			 DRM_MODE_ENCODER_NONE, NULL);
 
 	ret = drm_bridge_attach(encoder, dpsub->bridge, NULL,
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);

-- 
2.51.2

