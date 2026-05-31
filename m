Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129B5CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED13E10E4D0;
	Sun, 31 May 2026 13:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVWI+88C";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D486D10E164
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 07:46:55 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-841513664bbso5049725b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780213615; x=1780818415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hl7/bz2Wt6XngU1VBihi/m8AgI7wZRM8055uUzVh3Uc=;
 b=dVWI+88Chw5kWPBzrwUfA4Lx9tMEONHBuWuUGxgOWncSpwB/zpAh3uC/YdmoJ8nF6K
 Wx7T6m+abDad5UPaSLsIf+V642HOoghwteO9H4S1en3YuxaBUuvYxdJPiNDpPTsbbFyF
 h5WHTSVW/RwwNttg7XiIemV+E9baMoG0UHDYb7BmDBf/UMWdg+1CkOwmGELW8ARAUZjE
 piOJxfddBGDGmT/OCAnr9bX1DZhvUW8xFIeiWz3Y1Evf0X015yCYXL6kQfh1Fl4d4gxu
 j5RLHXXyslCPhI0qK4ZjzGx/cFMJOAc0Mlsk16ha5fwgrZ8yagWn1Boq56WUGTRLGi89
 0+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780213615; x=1780818415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hl7/bz2Wt6XngU1VBihi/m8AgI7wZRM8055uUzVh3Uc=;
 b=F214I8zOQCVNNBs0OHEwrZiS+PUvUHvFc2kqxb2tGlBr+wgZK40Gf54EZfWSwKaS2O
 E3kDFW2NDhP8fk62wXEDUCtYpaf6RGca0r/xrHcaty7omIb1vlOnWgfmL1qkX3YB8wYV
 wCGjV2gCBgRa6J38lUSKvoSxqSoxFWKFH6D9H1H/nW8hkie1In4n7aTIMiRDDXwOKYON
 Sp7YiA4eyIgdk0Yr1juJb+Ss/NfBS6gPYctRosvCctrBOiWZQElVIJnKGGbXvH1B8YX0
 h9gDDA0mikONjjyArNQSaN3Y0Wx51DESkPJf5RMQd/Tag2fZxZLoprmIC7auoQq1D3wr
 XbqQ==
X-Gm-Message-State: AOJu0YymHgDtFlhmaNTAlgVyIV8XRX492AMm88T5W/T2ZiuIQ5Ovoorr
 o9MXM2cwcQZNGmZPLJ4ooJlA9cF3wKSmEK9A/PCOhQoE9Wcf0VtrFZZOzMHBn5DG
X-Gm-Gg: Acq92OHuxz4cXD4+yrMeGwuVZbbC+2FgK+A8q01NQv4Jki/b21aChM66zhx1K89wK0w
 /FNM0Jh5nCeXOXWW4t8guCztNszku0cuBwNN4AhgUSITehsinoG0wQiDyNjm1FB5dGQG6AWNzIS
 lA5YLRLORZFnokNHBftTLzrGlr20EBGx95Yumj62iHPKBFr7J6eIQscb5EUFZNv0FPStuMWs3Bv
 cIVagv4KS7k0SOOPqgNtDDL8w8Dl8xBOz1a3+d0w5gcTK5cjbA/p4VuA96XnVfqWQ0n7okWVjtj
 49dAJ6ztYb6xwSpvEbbid4yyEN5aASziO4GVyQ0S2fm/5jzVtJan3DGfWHTGC0c7ORT4V+rjHq2
 5IRm9GYSPBipY00YNMOqA6xP/sFfc4MuUIdQFbypraTWXTd4Px2y3hVA4wI0gObqInFbPyCHtKD
 8TUWM4zU26L6CTx3TCT6VFn+01TKfYXovYIXyXHU496A==
X-Received: by 2002:a05:6a00:1d06:b0:82f:684a:84ea with SMTP id
 d2e1a72fcca58-842258ccae9mr4697323b3a.13.1780213615399; 
 Sun, 31 May 2026 00:46:55 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84246844780sm933636b3a.30.2026.05.31.00.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 00:46:54 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org,
 khilman@baylibre.com, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 5/6] drm/meson: Open-code drm_simple_encoder_init() in
 encoder_hdmi
Date: Sun, 31 May 2026 13:16:26 +0530
Message-Id: <20260531074627.8936-2-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260531074627.8936-1-namanarora029@gmail.com>
References: <20260531073532.8609-1-namanarora029@gmail.com>
 <20260531074627.8936-1-namanarora029@gmail.com>
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
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 1abb0572b..0a0ec34e3 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -24,7 +24,6 @@
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include <linux/media-bus-format.h>
 #include <linux/videodev2.h>
@@ -369,6 +368,10 @@ static const struct drm_bridge_funcs meson_encoder_hdmi_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 };
 
+static const struct drm_encoder_funcs meson_encoder_hdmi_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int meson_encoder_hdmi_probe(struct meson_drm *priv)
 {
 	struct meson_encoder_hdmi *meson_encoder_hdmi;
@@ -407,8 +410,9 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 	meson_encoder_hdmi->priv = priv;
 
 	/* Encoder */
-	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
-				      DRM_MODE_ENCODER_TMDS);
+	ret = drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
+			       &meson_encoder_hdmi_drm_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret) {
 		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
 		goto err_put_node;
-- 
2.20.1

