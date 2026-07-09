Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33379C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3B110F7BB;
	Fri, 10 Jul 2026 07:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0gvmLC4";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C887210E0D4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 20:56:04 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15f47e6297so37288166b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 13:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783630563; x=1784235363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lieoZSrETeNqfqjggjcg7YjI6XZdYix99GC+0aKI1SE=;
 b=a0gvmLC4KzgbbIv5Cne7+CsitdQ7jfkFhqRRAXhG8r+0Y5vMmg75goxMj31zb/LDc/
 2xaOA4ndYP+m0ooICZad1AxZlgL04m5RURS5WdgzXnBwdCn3j+baFNWbM2o9ywupasCg
 pM1aX9Pr12E4xLTAagNs1J44zGi5WcaSr27mKSJH6BIouEHc9KkAw1yykWGDCmIDYma/
 zzP6/IltjaajtGxO4F0WOkNGDsOrSrrS4ArD0dqYCkBRSjL3BbK+hw82Et8VnnTl2ERV
 M4W6BtPsYOJIzXdmpNgP7sHlyr9Do69vjy345vSDLck0wrnhDpnwlAlz5H7Yn9CFeDfs
 UUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783630563; x=1784235363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lieoZSrETeNqfqjggjcg7YjI6XZdYix99GC+0aKI1SE=;
 b=Fsd6i+NEmcoEwxSGNKsDeH0BNEwTkzqYsZID35ClbKEbkGkTtJDBR++ANP0ADZiIls
 I6KXH59NwmAPujC8nTlTOWQVCqoY9mtaHzVh004tdyePkndXgoiC9nC3x3zyckAsoR5+
 uyKcgIAP5EKc4ooJfC2S0zqUxVXunknVQpxmTnNz/K5nqkUnCQfSqWrf7hF5smz1EN2H
 I4b7J/DEGOJ4mJD8IqlDEVgqrWYnPtlHwXZCFti0NmlrUpdXJnlqGMk4YpCZGreBO3Cw
 +0JOrh7epqFaIqPIE77LeT9lnSzcTKwQg7Co3lmgQfKgKh9kegZNZpcPh7u7JcjwCu8k
 I40A==
X-Gm-Message-State: AOJu0YxBRTRM6HZfIFcVnwXy9zg6CXnSDSWS4YlJP4BV41o6chEhtGhX
 q3r8r/MfIx7P/ueMwCZRj1VdH7LSVga82QrOKbXaBTROwgochRH5TwptHmn4vSd8nFg=
X-Gm-Gg: AfdE7cnfEtNg1k+s44sZVM2Jp/1F2JV9shHzpV/bRp8KFAhypSzBbo31OMEailX99W+
 YM5TOgIRDUdOI0iFo+DIiGclM5JzMcrtwoAvmx8+KwuVyNt8bLLdUDxATHVOc7HiAh6rDR3cV8G
 j06YKVrAe10I2W5kOTcPzAd6cX7Q4OgMZWs3fJNTtXk8R1pDFfKtqLRdjVywLPvtSCx0pyRWuem
 AkL876cpAXF6rfvMgYRwsycG15R+vyCrQuFeIRUCWE1rUxnXoCiDqL5fEwo3ofCWaBOr29BZAfJ
 VfZiPK1LZidnKTdnxNcwS/EhajH3OovC7t6g9AvfybzOG/1DzxymkIgjGdjPZyyDdQfNTjeJ9uU
 56AKLLbyXZeXUuWK0BNCUziLhSwpNDJptv0OVKoB7aEx8CvuEd/8fczs3wN5KN/RfPAU3Uh+BEY
 EKTtE6A5kpq4UiWmgEg0HGgxymInRAhPm2n7CecAuyYU/iEw==
X-Received: by 2002:a17:907:3e11:b0:c15:f26a:342f with SMTP id
 a640c23a62f3a-c15f26a5b0bmr128439166b.23.1783630562908; 
 Thu, 09 Jul 2026 13:56:02 -0700 (PDT)
Received: from liam.home (233-51-98-95.ftth.glasoperator.nl. [95.98.51.233])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15c63c04fbsm369352866b.23.2026.07.09.13.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 13:56:02 -0700 (PDT)
From: Liam Zuiderhoek <zuiderhoekl@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Liam Zuiderhoek <zuiderhoekl@gmail.com>
Subject: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
Date: Thu,  9 Jul 2026 22:55:38 +0200
Message-ID: <20260709205538.73157-1-zuiderhoekl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:06:09 +0000
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

