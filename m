Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC921C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED7610EB22;
	Tue, 30 Jun 2026 07:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZpKhwh8";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A5810E0C8
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 17:39:28 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so5121517a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782754767; x=1783359567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lieoZSrETeNqfqjggjcg7YjI6XZdYix99GC+0aKI1SE=;
 b=EZpKhwh8b9ZsPIndf5Ue9ITWCW6qHmjmtDcISs8+V6zGLAQHb2TDCCfO6wD7/4f+K2
 D8q1V3x5krZ3nwd0ZXQouL8BAEOgM4jcMbwt8YPNHvtikBH7sDB2diMgFGSv5Dv6Py4d
 7AlrjSOoZoyA5mhQFswGqMztJml9/Y/k4j1WINXez9YRe3NhmzmXAShZXr7TO4O/oRp3
 reZ7M0VtjyMNTusm4rc8itVibjdKyvpGEUfY7gOggn15B7+eKvaugE4GHnSpbEwGSZxe
 ek4/w7djnZNSoLgE23MbhNPMQjaGb6AKkGf63g+5ki0IIlB6C7/AZb97cXLNe9s9KHEV
 m7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782754767; x=1783359567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lieoZSrETeNqfqjggjcg7YjI6XZdYix99GC+0aKI1SE=;
 b=Rk2a8yl8jujfwSzEOuVf4hQ2E/HqvYWlvas+Sbx+WBCj+U394AWKJ2HfCjAAL14HLa
 Cpdax6pfOcpugmRcRCmKBUznnyq7ho7sBup9jarcwiNwDGTXMlE/dGMKU0GZT99asl7p
 2wRODFbBfXmG+lKoMUrjEkBK/5beZvih4e/+jphA0tk0y6C5IURbR99cNyfjcX2E+w+Z
 COhvzTqIS9AMa8Vo34y0VuglA+DfPpvlcVeGQUS6amPNOtuItrzL6MRq5ctyYoYIcyC0
 ZYk83MsXXO6OdS+SeDYX9gyAe/oIPGkgzGnQVDvDBbu40cCttFu3FuDWJRYvwO16gUzP
 5CQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RomwMRWiqJEBocf5GHmS7Qkpiy8qVjX1Tzh8xPf4GnJggfhh5kc386D1cUiEwP+V5knRIgZ3DVwQA4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzL6JeuY1jGM8Lu1z6ZqstkAuhTS1EhB/2AXiWFbem8pt80cW1o
 H8sr7m612PyH27YXpIIlYBnjn6uN0YSmmWgEhP+pvE9j3G44Eaq3dcA/pWx5mboHJr4=
X-Gm-Gg: AfdE7ckY8QWKuZfVFfBRxcSjQkg6+8q5wJMXKAmdIgK96AN/LC2CEvY1feEseDnyaGz
 XfyHnvLWXgaob2ur8HgBV6YmhEeNJfo3QXcVJhNwLQGMjoWdLaflF9ftggmKrUKeB/H2bcUoX4B
 7FKPKuzU8x1l+Vi1Xm/dxtr29AfUKLK3Yq2HiRo5tYf7ijDjhVWdw5Q9fNR1vk+sLc8n7XkqEKE
 a5UFaqmH23Ms4e1+BWnqXN/KD3vOpUZHAKuO9i9lNEEgJ1Oj4ss2o7ggwIpwb2nmOfGj4P/3KWF
 21cYo3wunql9JckW20HaBVGuQvQz3l96VyTMnuq8xsy5wYm2ZGN8ZrWgy2jvvC40YRrzS37i2FF
 ApHBrxH6p9++hT7Kg8azSBQ5XJUGjAt++tykqSXGRq1medR1GL8PwkJsnd0vLvTo7CNFR3Q26xr
 h91kOEiVkpXsVzSKyHhmE52NjsnlbDbFc5BQxuy3exV4RAzQ==
X-Received: by 2002:a05:6402:3908:b0:693:2a2:9e41 with SMTP id
 4fb4d7f45d1cf-69879e26a3amr74630a12.19.1782754766463; 
 Mon, 29 Jun 2026 10:39:26 -0700 (PDT)
Received: from liam.home (233-51-98-95.ftth.glasoperator.nl. [95.98.51.233])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69858838d6bsm2943446a12.7.2026.06.29.10.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:39:26 -0700 (PDT)
From: Liam Zuiderhoek <zuiderhoekl@gmail.com>
To: mripard@kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Liam Zuiderhoek <zuiderhoekl@gmail.com>
Subject: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
Date: Mon, 29 Jun 2026 19:39:02 +0200
Message-ID: <20260629173902.29415-1-zuiderhoekl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

This commit inlines the function drm_simple_encoder_init for the meson
driver. It replaces the simple encoder init call with drm_encoder_init
and a custom cleanup struct.

Signed-off-by: Liam Zuiderhoek <zuiderhoekl@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 55c0601df3c6..0dd3a76ad959 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -44,6 +44,10 @@ struct meson_encoder_hdmi {
 	struct cec_notifier *cec_notifier;
 };
 
+static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 #define bridge_to_meson_encoder_hdmi(x) \
 	container_of(x, struct meson_encoder_hdmi, bridge)
 
@@ -407,8 +411,9 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 	meson_encoder_hdmi->priv = priv;
 
 	/* Encoder */
-	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
-				      DRM_MODE_ENCODER_TMDS);
+	ret = drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
+			       &drm_simple_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret) {
 		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
 		goto err_put_node;
-- 
2.43.0

