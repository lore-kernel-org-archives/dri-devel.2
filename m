Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D13CCD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACCC112B63;
	Sun, 31 May 2026 13:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EjQOoUOU";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675E310E164
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 07:46:47 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-841882f8f4bso3030871b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780213607; x=1780818407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZgZXDapD3/D+twZe7T4nhGsVyTA1P2sNWQ93wpwZx8=;
 b=EjQOoUOUY+0ICrTr1bQaaiGY72AKGdHT6S5dfqZJqRsAjoottXpzQJAzqcWwrpKfbJ
 JiErcI4FGW1F1RK7zUaAJILl5J+O+tVUYMzBCa/jYz80/VysDWk5Rg2uUDUuknSRXyII
 DcobQN5g9H1f4ZX+s8FngCa/3xGaa+uZikjkfxKVPNFxAs5alTrhCPLjSpMvrQcAgKkR
 lnjqV/rim6Sb8f8ihEGoXRas1dItgnHKawzj0oAgoA8tJQUTqSpkVXnNKjAcHG6tBzov
 DEuRf/vAlleC1xo6GDOfiqlFLF1rtPwra5dLztW7VP6MTssrWSHYAtY49TvB5ets2ArE
 T4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780213607; x=1780818407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZgZXDapD3/D+twZe7T4nhGsVyTA1P2sNWQ93wpwZx8=;
 b=A56/pMLgKPQTz9LXkM6cLqzZppLmM/35qfuJ6QaJn4zVvuHCbg0dXGcEkGlTp7L+nt
 WhkfedcQ7T/6iQ5TlGuYXEiRG2hx10hT3SXYJj4h4hyUo6KB6Jw3HWWm26QQ3Djn0r1d
 wG4ixZWt49DmA9qqQBZ8xV3+348v3qneDHmNc/Ppb4SNmy4FRC8BrGhl+cK+/goDRUPn
 HaAIGD6Rz+ihkV6/Ua7DsEKRpQXttG/HTA8eF0TQGx1BNjmUp3Av7bnJf0noQuH8dJ1m
 u0wME+OCVxqKg21uHdQxp5ysPEiumgk3XEcJgEnOU9UZloSH9VlD8VoQ2zE21fKhrmeQ
 61QA==
X-Gm-Message-State: AOJu0YwYx3i2GF+AUR7PlDqW5m2rRpbh/R0iDvdZIwVfET4US+oYD/Qt
 HXekJvjWp9L8B4I5ehZy2oohi3yRjcc7xxdC7qJdCE46i8MqX/Ywb/dlgy5Bvvok
X-Gm-Gg: Acq92OHG8xvXzN/04Dp5GWNmd8qP5FiQHVvELtFmYoFL//cuDL0Rjdf/HH6GydKuQvU
 NpKdRZmnOpuVJ3NqHLvDkY3WJSVfDGQBTOQf9ZDywTHkPfQmqTel865yuy9tf+4gzdOCbc7KQiv
 3aZSoTUZ3J+IlOprm4EZYUCY575Qf2PH0ZA+f/5Q9KMPMZfkUPtMDbj72GjwRo2Mx/VXI6MBdBs
 2Egs8jMINNhiq7P2U6lbztIecYJfQDMkNGHk5q/gvxYDqXClI+No9gF173gsTnS51LBu4m4hfrE
 DXY0ZtuEeQ9pfTeZ4+87/l6lRhPCvmdf0O3jg3ctb2imSQxEYJVxEBHPOlgrmasOVrkzBsKTN1v
 ux3vL6sDKF6btalfsSfj8VU0T+XtN68Q380WZq3RemVXNHcGM7U0C336h9DsDWSO/LZpz1WI6Cl
 yR7qZBbj877ZN8oeBpO5lM29xjsJvtvf8RrpCpMY7MIg==
X-Received: by 2002:a05:6a00:4f93:b0:842:432e:b802 with SMTP id
 d2e1a72fcca58-842432ecadfmr1408991b3a.16.1780213606915; 
 Sun, 31 May 2026 00:46:46 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84246844780sm933636b3a.30.2026.05.31.00.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 00:46:46 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org,
 khilman@baylibre.com, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 4/6] drm/meson: Open-code drm_simple_encoder_init() in
 encoder_cvbs
Date: Sun, 31 May 2026 13:16:25 +0530
Message-Id: <20260531074627.8936-1-namanarora029@gmail.com>
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
 drivers/gpu/drm/meson/meson_encoder_cvbs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
index 41071d6e0..496100ba2 100644
--- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -18,7 +18,6 @@
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "meson_registers.h"
 #include "meson_vclk.h"
@@ -218,6 +217,10 @@ static const struct drm_bridge_funcs meson_encoder_cvbs_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 };
 
+static const struct drm_encoder_funcs meson_encoder_cvbs_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int meson_encoder_cvbs_probe(struct meson_drm *priv)
 {
 	struct drm_device *drm = priv->drm;
@@ -257,8 +260,9 @@ int meson_encoder_cvbs_probe(struct meson_drm *priv)
 	meson_encoder_cvbs->priv = priv;
 
 	/* Encoder */
-	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_cvbs->encoder,
-				      DRM_MODE_ENCODER_TVDAC);
+	ret = drm_encoder_init(priv->drm, &meson_encoder_cvbs->encoder,
+			       &meson_encoder_cvbs_drm_encoder_funcs,
+			       DRM_MODE_ENCODER_TVDAC, NULL);
 	if (ret)
 		return dev_err_probe(priv->dev, ret,
 				     "Failed to init CVBS encoder\n");
-- 
2.20.1

