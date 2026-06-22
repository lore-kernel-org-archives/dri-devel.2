Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E024CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA53810E9C9;
	Tue, 23 Jun 2026 08:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RrCVKiOB";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B4C10E833
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 19:33:03 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso693151266b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782156782; x=1782761582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rnwp2WcGX8BgzfYchzOUAXKl4K0Z3YQrQZ1OJ8BM3g0=;
 b=RrCVKiOB1sno+FYACGC8UsuVnHxFft2Uz+Ux5OA/pmK2itqxDIe6I+/fNAH7O6V+wo
 P0FiZb++JpZLdCzCD8xCGo06FY0Pswp4SA8bHQy36/0pX1vfovLPx9yXhrKOaKetLdte
 trwl2u76uAyDFPDs4NE+qod6y05Oq+Zzs2ihQck+z4JQvV/j/0SUi6EgfDlxTyVnKWNX
 2LIQaSo/Q17mqTGoM2V07Exd0UTghm2IhWDX16DaFvQjjdmHB2phyEmACaaVrL4o91c2
 i6blTUzhfUAm0p8dpJDTL6khoi2jdO27ATy8E4I48F4giD39vHH4Aa0LaFVkD+0hkKPU
 D7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156782; x=1782761582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rnwp2WcGX8BgzfYchzOUAXKl4K0Z3YQrQZ1OJ8BM3g0=;
 b=QQHCUZcBYEMXuO2NG2ZjDrItgPX5fLUsHVq20Ab00ue6qXJz8lPmVzA5EsZdKHAC9E
 wQQ+8/xnL8mE+qqwrdfwx6Xiyr7iXl07YpswrbuTP8bBLiFK9w1TpV8LR+iOVwQkQnpC
 O8Rep0pIgQ0CmsY2SIXvsSUid4I0gDaPcu/R+u0JfMRlsNpbpgEUwJTSJh73JG5brNb1
 JxpZmM1lVujQNDRR4jMm5tu+cgWRAp8LyDOF6gzC7OBffLxLtOzjaNOTe+fk5v8RcheW
 GYK1bLI3xXxQdTRYajh5uk+RIBpoFyFQTpD5mU11VaEGqYitQUKsKUG2qtT4T4OzpNZO
 YCyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uqwsKksJtFnJWhFIZuGqlP6HyX9sfkBkpLlI2ZN5SP509laipXtNyJBZan1sqN5h3CJTkKHThfF0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTbkd7aBwcUNXZFwpqAw5tPw7+Uc1WH1u/qpbh2GhT2lj3NPF0
 rrup9jRHDv+S6YkEu9LJqaBOAN4nF6P5Zn6qKesNuq93OM/1QDXKI69A
X-Gm-Gg: AfdE7cnnmJqiaiSmarBKfA/Jjnw7gUp7PmT5IsczGIGzCwEuqst2O96iS8koOsm7hvX
 K+7Rpm4V2vHdkE2ZtHjHpQ7BWzD4EQy3rfV+wX+bh3JIAzkOCwNwQRkjwLddnDWas9ENbDL03w3
 bAFkShjfcPz0VaxFSFjGvpAxvuyMcYHfKd4/DYI6osu4ymQv/rs8HJhtgPoUPzvd/p2ypfQIWV8
 u+Mvp8tmxa526zUv1RCI480/nRp4jctuKun089oRsEz35QX6S51XZ2eyyU5Hu+R2hEJiTXa2WPf
 d7hFpQnalUwAyVTipkFs08zDQdeyUyGShZpB/TFXOVV+y1EUXQ6N922bB0ffDqwbx6rLpcF0Z7Q
 wK/J/+MIub4dMBQqg4ZuNce2BdJuQ+FeADDpk2oQdu+LrwyTgscuqrsRqSaIt+gQZ6ME0VnmVQW
 LGM3m4aapjwjRMlgTYJxUfmLtWsk9xSf/HFsHhHtbSiVyO7w==
X-Received: by 2002:a17:907:7ba1:b0:bee:959e:9ac8 with SMTP id
 a640c23a62f3a-c0b601eaa11mr746745366b.4.1782156782156; 
 Mon, 22 Jun 2026 12:33:02 -0700 (PDT)
Received: from liam.home (233-51-98-95.ftth.glasoperator.nl. [95.98.51.233])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c610e4c76sm405931966b.46.2026.06.22.12.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:33:01 -0700 (PDT)
From: Liam Zuiderhoek <zuiderhoekl@gmail.com>
To: tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Liam Zuiderhoek <zuiderhoekl@gmail.com>
Subject: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
Date: Mon, 22 Jun 2026 21:32:50 +0200
Message-ID: <20260622193250.211429-1-zuiderhoekl@gmail.com>
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

Inline the function drm_simple_encoder_init for meson,
as per the todo list on docs.kernel.org/gpu/todo.html

Signed-off-by: Liam Zuiderhoek <zuiderhoekl@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 55c0601df3c6..f4100e23dd27 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -44,9 +44,17 @@ struct meson_encoder_hdmi {
 	struct cec_notifier *cec_notifier;
 };
 
+static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 #define bridge_to_meson_encoder_hdmi(x) \
 	container_of(x, struct meson_encoder_hdmi, bridge)
 
+static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int meson_encoder_hdmi_attach(struct drm_bridge *bridge,
 				     struct drm_encoder *encoder,
 				     enum drm_bridge_attach_flags flags)
@@ -407,8 +415,9 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
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

