Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10785CD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D54C112B52;
	Sun, 31 May 2026 13:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5dqQv41";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348C710E450
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 07:37:11 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84230ab8857so276263b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780213031; x=1780817831; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRd0rxdsonje9jnyvzmzGfqu89ZUVs4w1wFb8uxr/rs=;
 b=X5dqQv41leGeGqgNQVwrFItzE3PLEbxJJFrjgdFdVWvtyaF7qjAz5gAgBgEAqriIYy
 0WRUGZb1/tqfXLVy6Yzp4oNf3k/1xlqODvvGfLzdzQAHyf8/49e1nimK+jDMdUNcLcVU
 LAejYNELhDPNtIiG7JtPt2UygKs2SXaAOaXJ4gOL9G0pq7G2vSeGcISKuu7EWGb6VRk7
 e9BMMFQ63pqMRCWP4mCQFnOrSBlYLuiHHZMKNLOg6Jt4krVkBXZGa9WOoX2wr59dAI41
 kPsUYF77b6dD6lg50S9UbVnpj9WDaEe+FW2V2HJO6CyNoKC5k/DYTO2XXHWhEvrqZ/1V
 LqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780213031; x=1780817831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FRd0rxdsonje9jnyvzmzGfqu89ZUVs4w1wFb8uxr/rs=;
 b=sxWZYb1/+nlFYOdYvBSj7E4B12mT9FwJiwI34pv4qw0ey6V87dEQNoSMGHGyYy1T9f
 dPAhM6agFzzT8LOfGdSwEeLrVA2kmNYJo6yzZEycT8K11NQvFVHbY6ci8pRkF4vCJ1ym
 eIIFD6DnOPm15POS842xrr4KXVqZ9XBDeRTFm5gHw+x8U9I80JhBfQ/ojnKj1mCLBnpJ
 T9wZQL6HzzWdQUpsFFYQMjwhKqlguhawUTnao3ReWNY00NG/ICHZivzxs6/ZlZeueRiO
 KVJ8ozA2l2nU3Uhlk/lruVpBrzFullOjWcWiNpjXlCo5gYj9szlHGli4I3dU/8LQx99y
 X3Dg==
X-Gm-Message-State: AOJu0Yz4CyxvqlOTKhHzAR10MBCPFtoo35ViJaD6lwMJm1OlM/xJYEx2
 N+qz1joskspCYTpMFHfpxKyEOh/778imxhjrSNa0RDCI09+zgnZf+ipoAKmHMQbO
X-Gm-Gg: Acq92OEe0zJLPfpULWt/ULBjeLIb2DX1g+BRBA0lUCr487yNs7uTfupAgi5j6YDepD8
 bTAzq9aBJeD0dFzIa3WUwtjFGoGCBGhgKH3Dgi2hf3hYhcizWh5tQ7Bmkxj3y1sjdbndlMjFgYu
 IjuPdYc1gkdbbQB6od1qAsAnRJyrky5I42ZXOeVmXyIPlMz9UbzT381It/VD5K7wQ5ntXjOo84G
 ZWNqKq/d+0f8586qe8MKArfLgkT4R1PwuFFa5BZpCRAu45bESpCS/RRm6F8pNm1C2vaYR/ivApM
 B1LzWfzvhBBn7A6rHjXlVU9jOvhEG0++km0qXhbeit60ErqesIFsBVYYXtumEFJgZ0oxXmXGmRh
 E5aw4Fh6KquE5TrasDB9Tiu489AeDSWcjnW116p10+tuQuqj5yJa0BZ0oEROCnTVqNm04ljzZQj
 9OZBiEKAvTNyXo/LMl00vHX6wVDdnpB73OHJU6zOcP/w==
X-Received: by 2002:a05:6a00:408f:b0:837:e9cc:d465 with SMTP id
 d2e1a72fcca58-842253a671fmr5468493b3a.20.1780213030642; 
 Sun, 31 May 2026 00:37:10 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 00:37:10 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, stefan@agner.ch, alison.wang@nxp.com,
 jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 2/6] drm/tidss: Open-code drm_simple_encoder_init()
Date: Sun, 31 May 2026 13:05:28 +0530
Message-Id: <20260531073532.8609-3-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260531073532.8609-1-namanarora029@gmail.com>
References: <20260531073532.8609-1-namanarora029@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

The helper drm_simple_encoder_init() is a thin wrapper around
drm_encoder_init() with a simple destroy-only encoder funcs struct.
Remove the dependency on drm_simple_kms_helper by open-coding the
encoder initialization directly in the driver.

Signed-off-by: Naman Arora <namanarora029@gmail.com>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 81a04f767..4d73a271c 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -13,7 +13,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_drv.h"
@@ -81,6 +80,10 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 };
 
+static const struct drm_encoder_funcs tidss_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,
 			 u32 encoder_type, u32 possible_crtcs)
@@ -95,8 +98,9 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	if (IS_ERR(t_enc))
 		return PTR_ERR(t_enc);
 
-	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
-				      encoder_type);
+	ret = drm_encoder_init(&tidss->ddev, &t_enc->encoder,
+			       &tidss_drm_encoder_funcs,
+			       encoder_type, NULL);
 	if (ret)
 		return ret;
 
-- 
2.20.1

