Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701BBCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D038C10E174;
	Tue, 12 May 2026 13:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SHpp2QIl";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C09210E174
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778592170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VxWGAY0yP7bAHYF8LAQ+cdD8qqoBU5/oRKqAKEcDgM=;
 b=SHpp2QIlgx5+BZSnQnB3PAKSgz8ZM5sodCoE9pkLgiyq4BN2MUUYg6JgkRMFGVeRg/CQA7
 z7KIXdgUv2dNZ57p1VWkCAWPQ7rKxrzt///MYa5MMz+gk4jxrfet0s8NVW0ehz6Q+NQqTU
 sb4gIclao/t2LEfvQOXVSuhaTIgdNrc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-OUXknXZjOYyp2j5JDFOp5Q-1; Tue, 12 May 2026 09:22:49 -0400
X-MC-Unique: OUXknXZjOYyp2j5JDFOp5Q-1
X-Mimecast-MFC-AGG-ID: OUXknXZjOYyp2j5JDFOp5Q_1778592168
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44b2b38648eso4388544f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778592168; x=1779196968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8VxWGAY0yP7bAHYF8LAQ+cdD8qqoBU5/oRKqAKEcDgM=;
 b=hWiDQreQaUHd4Gown41F7Fg0LIqqdaV3GpxMS0sMOzKN0s5LotbkbRk1kdJ2ejqNu6
 3LT74DwoX4EMJkS4wSuMWs6jvtfdbtJ+25gWdAQfxB3OF9PlACSOTgNji5nN0uywlJxn
 usZJlp6MXrSjkWeRwrN9Sbhdh4+VyoicLHM3uOgP3uaoJoBvYGxSpmGBQHUyHjr5Aj96
 aadyF9u2Q1TF7BV34y7Dlj8WZKJavnTKfmQHWY+OkJYSn5u0zRHuI6bDRDWT4zO9HV4U
 CK1SvPqSIKVNfUna+SGYPWPanWZJnLvRbx/oONzMiA5te9PsR47DBJdR362QE8iK9Ckj
 1z9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gmoCNa1ydVedOR5FIcabm3oQD5Ic/s6MRJG6AK54bJKUHLA+nPeckNeQzwxsogrdrD6HVYI0o72c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbtmittGz98eB8X9j9trgaMeucKgdjRqtgPlBLTxWxzfeXTgjE
 xBxBKOtHws8bK0F3ucR6ICYc8CGgmoHy3KtvtTXdhYYnYr6SPb8F1JTiJl+EvPZhkqW1v4UUXI2
 x/Ygr2fCnDCpmrAjWzVnglYqdNdfD0ACwVT5CQRuGGkgUGIIyzUVXM3c5kX/t3ot9GeinQQ==
X-Gm-Gg: Acq92OHLfeApbWA7UKQk2dlxaqlQC//mMNnCdx86+LtF4kH59Jn+0B8ulBJQOFJ+vhB
 NDGp5erG/p5E7Ac/CMenj8KiNe0dUTfcq1yZhjkD6hckT8CFGGRmkKWNXTWpbkVatYC+d973yX6
 ww+uwHNVaqcmAeGr7ACyPmEQ1I9ZuMqmt+dMJdYtaO3iMMnqMtY7XlIaY4LpHGCT3zvfk7ZDDvr
 OId33iNqAhwA9n5fjeRPzGy8D/d7nQ6LvFS5vuQHV1CwpLUFJk3QbYqvPA/aU5k4ybPLDwIrJOD
 6XElMz+HZmS7s44PjSRfg7sNLgyZ3NOJoEJELMUvoRbL6sXgSx7IlOWHWebFwShEVYVriqlCKbe
 LvMlgfRVXMFaVRbA1PiDgql0mQmI5fpp18RLS9VJ7Q9UcBlw=
X-Received: by 2002:a05:6000:1869:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-456a369055dmr21153518f8f.22.1778592168042; 
 Tue, 12 May 2026 06:22:48 -0700 (PDT)
X-Received: by 2002:a05:6000:1869:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-456a369055dmr21153462f8f.22.1778592167556; 
 Tue, 12 May 2026 06:22:47 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491304387sm31943745f8f.21.2026.05.12.06.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:22:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/2] drm/bridge: ite-it66121: Select HDMI or DVI mode based
 on sink type
Date: Tue, 12 May 2026 15:22:16 +0200
Message-ID: <20260512132232.333654-3-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512132232.333654-1-javierm@redhat.com>
References: <20260512132232.333654-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x_uy7uvGrUy3zzyKbT84r5LWb3OI-CvQaPOcJMlTaDw_1778592168
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The driver assumes that the sink type is always HDMI and unconditionally
configures the bridge in this mode and enables the transmission of AVI
infoframe packets.

But this cause issues with DVI monitors, that can fail to interpret the
video signal and lead to not having any display output.

Check the connector display information sink type to decide whether DVI or
HDMI mode should be set and if the AVI infoframes packets should be sent.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v3:
- Move the HDMI/DVI mode set to the .atomic_enable handler (Maxime Ripard).

Changes in v2:
- Don't store the sink type in a per-commit bridge state (Maxime Ripard).

 drivers/gpu/drm/bridge/ite-it66121.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 648ca50712df..94fd513481b5 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -182,6 +182,7 @@
 
 #define IT66121_HDMI_MODE_REG			0xC0
 #define IT66121_HDMI_MODE_HDMI			BIT(0)
+#define IT66121_HDMI_MODE_DVI			0
 
 #define IT66121_SYS_STATUS_REG			0x0E
 #define IT66121_SYS_STATUS_ACTIVE_IRQ		BIT(7)
@@ -671,15 +672,23 @@ static int it66121_set_mute(struct it66121_ctx *ctx, bool mute)
 
 static void it66121_set_tx_mode(struct it66121_ctx *ctx)
 {
+	unsigned int avi_pkt = 0;
+	unsigned int mode = IT66121_HDMI_MODE_DVI;
+	struct drm_connector *connector = ctx->connector;
+
+	if (connector->display_info.is_hdmi) {
+		mode = IT66121_HDMI_MODE_HDMI;
+		avi_pkt = IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT;
+	}
+
 	mutex_lock(&ctx->lock);
 
-	/* Enable AVI infoframe */
-	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
-			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
+	/* Enable or disable AVI infoframe */
+	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG, avi_pkt))
 		goto unlock;
 
-	/* Set TX mode to HDMI */
-	regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI);
+	/* Set TX mode to DVI or HDMI */
+	regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, mode);
 
 unlock:
 	mutex_unlock(&ctx->lock);
-- 
2.54.0

