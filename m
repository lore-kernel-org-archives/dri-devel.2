Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D937CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F160510E9CA;
	Tue, 23 Jun 2026 08:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOtf9UEP";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD0C10E2E5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 19:46:59 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c0c5d170ad4so308216066b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782157618; x=1782762418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lieoZSrETeNqfqjggjcg7YjI6XZdYix99GC+0aKI1SE=;
 b=HOtf9UEPQUGCXLx4jlske3sf37hz9uI61GnYG6N8iVcYM56xtYem87c9+02KkyQLHw
 AXR94DQkoGnrrD0wRCzaPgEmHhS5wFYl/1rT77CghPm4dWpWY3IcSdWP7X3enzGOlyCB
 myIU7TXWpZ56BJPp9lWC96I5Zvko4fiOoHxkSW8GektlmuaKylvCMj8BuWzlFUYB/Lnj
 Kz/tNrWGmsAPmdlPTPcOq+JgW50DodJyatDyAM50yZ8Ls+EMamda9eBO8KFTd8tMHmQt
 LtK1PByPQckAOPJYtEI632EU5RUQsOlhe3HoMemvhVD9JAeIF3Gci4oIh5q6ssoT1H7g
 Fn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782157618; x=1782762418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lieoZSrETeNqfqjggjcg7YjI6XZdYix99GC+0aKI1SE=;
 b=PhxXSQYj3aqEwC38omYRQ/m+VQ4zg2nsjuX/FR4q3wCiMAN3Q/zeb214jRL1sagAKo
 D+BufB2laUSquvNr8mRz2sfxeyY++zkglBEaSGldXMP4LB1yfIm6fSPZalH/gqWaoGuP
 EY8aZfwOoDqScqUad7lV713zsnRvN7EvA59zY4zsP88iXB1XZSw+criBp4Y1w6pxwe9N
 XhzGtOFrhBrYp3/GWnMhlgzGZTzTtmfYAien57D89pkgz+3Yt48KYNvB7e/vyW1edMs4
 fu64A8FczhdVW6a8EnqaaphKhej6rIxsAeQ69V6aJPOqemgu/lTZsWyybjD9o23xK7Qv
 9fnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FPowwjfo1Udh3LP+HaCcjZJoI1+nDRmrca1rVXVovMLqhd2VqjZ3Z4zH4faXE+aZ3NcEaOq15D4w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4ezaci2KuMpKsUPceZXIOh05oa57vYikUYkdcNKf7rKlQsoZv
 Gdw865AGgA86mn+ugA2Rl9O525gnVQp1w4wQfVec7P/Ykx5Pknf/122H
X-Gm-Gg: AfdE7cm1ZfQe6C644fy34LBjl1LhwzXlhSuum6A5Jnh2PpOVoKDF+UgOCLQW2dN8WRi
 2Q/DNJiwdlXYtUxl2kMAiZVv29cnHxIcHP1xE3SQfZVS2sU04nSP8a7UIfxgwUdLSaug7DaMEvL
 spD1WnFdGV9rW5QffPYJ/y0IdnvsSTnWGTxnZBre1eANCFruT1XacGP1ft3/lb59KGq1ygx4Wpj
 xsix3AJdKzXmo9jNtUozDHnOgoqQK+pPHKFxd5TtDssg2TTkX6VU8zAjtaAA+gBMzg7vXR9f1qr
 ppHIJLw4Sk4/lc3rlp9dpwuDN49qywcbdCEuKRKOGrpqMlqBHaWeBuMq8W4PY7jAY3xKRGy1IP1
 FpBiEijXNLMRkGXXCj0J8Aet1/RCAm6osbij9dIlNmjDBBL3KLn1YIX9yZycMJNlscNclEukksb
 cc5F3S6vgPs0epin13QCng/awupUrp2cISSomFI/GQE8ug1Q==
X-Received: by 2002:a17:906:4fd1:b0:bea:4a9b:27e3 with SMTP id
 a640c23a62f3a-c097adb77eemr849187866b.2.1782157617559; 
 Mon, 22 Jun 2026 12:46:57 -0700 (PDT)
Received: from liam.home (233-51-98-95.ftth.glasoperator.nl. [95.98.51.233])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69796c10dbasm2565856a12.8.2026.06.22.12.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:46:57 -0700 (PDT)
From: Liam Zuiderhoek <zuiderhoekl@gmail.com>
To: tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Liam Zuiderhoek <zuiderhoekl@gmail.com>
Subject: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
Date: Mon, 22 Jun 2026 21:46:49 +0200
Message-ID: <20260622194649.218419-1-zuiderhoekl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

