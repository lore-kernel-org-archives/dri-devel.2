Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9B8CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E7010F4A1;
	Fri, 15 May 2026 09:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RKcHsL9X";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDF410F4A1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778835813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkeuA98/IigyQUpPmD/BRx3zRBO+IRiFlemTbP/J4Yc=;
 b=RKcHsL9X/9ynol7BvcJDX7TJz/9LgfR5tXN4nd6X/4hU7noDX9qdg5PFg2na2ekI/UPi2f
 GOeKiNmyYU9jbErWws+fh+ev2TCgzaFi/9jv8AMTaIWtUyZAJRZLWPVhkRbeQd+flb0Swv
 j/zo8qTJsvyC+UYCdiGErxWPGsKOiYM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-nacn1vEWNeCO8JCeRgc2kg-1; Fri, 15 May 2026 05:03:30 -0400
X-MC-Unique: nacn1vEWNeCO8JCeRgc2kg-1
X-Mimecast-MFC-AGG-ID: nacn1vEWNeCO8JCeRgc2kg_1778835809
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44d83e45febso463066f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778835809; x=1779440609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WkeuA98/IigyQUpPmD/BRx3zRBO+IRiFlemTbP/J4Yc=;
 b=FPrxeBb1bRld4cddUBOVZFOWkW9/xU0ylrb0kz1JHMF23ffC0bx6sl0n17Rzn3/9oE
 QrgZJgxnFDmGhcwl/k0kGydg0szyy0ULuh4dwOZKPNdPeM/J0k+A7AC2ZmOqOqf9EMLl
 lcnAVMxjA96QGh8Q6FlUroS6ZSk/cjRXtfVUXOS8pDObz/vVm8TnQgoUYk7TK8pSr5gm
 2KpO5AVMNPobgQZ81nWYlq9Nm8Ixj62/hKh5gXL8fUSch2lFBWkocOEMJyCttJJ+bZlU
 iVsOncb6GtfP+fJC8ZLushC/lZ65VtEipPWt3OS2VJRAlZq7OaruY30yZ/wVh/LXBlP5
 688w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Vo9/AYmXsEnSuU+nbIC/4n8dge3NXkrcHGtL5eAD1eJl8hENuA3/uLEczPN+btGJNNFtiwJ9QV34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHr+Y/9Ftgn9oAzlm9kJ5fpM9JBsUXAEt3b71wn30xthLY28Fx
 /VJjk7hrJoQOM8h4EK09/h8LzXYsTD2jgXy7yFa4NA0117YWLSHy5Vj1G4Po9ckYf9dXDndvjS+
 UCorIp4IBNeJtNXAyAiKFV5SD7YJ9VSyhEIZRjdx2ljWKUeS1tFZGPgAmPtjB7OWf/8aQxg==
X-Gm-Gg: Acq92OG3k3R5SEm1Vkq89sCHRnXKhqecr7Q7Yhobg3SCIwElfb0kOoJ+apjWdHCkVyF
 VWHtE9PUXl6bUpLjAT/kksjvQVKAWutAu/DOIpn5jtnwB4Mqe0nxXO976AZ56ke5IjHWkpNQnt0
 4GaNwzrCVHkwme/qnPgE10lKzfqS9iT/E0LJ+eV13qxm5lzct/g+wkKqnnbDDR/pBWEAXeBGmSB
 982PHMHbdbUGz7TsUlvwHkRlP2hg9aSnzbDYe80Hlxz+yEnOeUj6hSBxiWSX7k7EtZEFMUdA4n1
 hoB0RPhSOGyCPyhRWt+T4A5ysF0iMgEZ1z5ikcO17/uN1tYjtqsEgrimCfum69oUZ7jAULvVnUY
 Dos4i7ISzGc/RvG19W4hHYYNt5banRbAyi4CZJK2FFIQJD4s=
X-Received: by 2002:a5d:5f90:0:b0:441:2397:f40f with SMTP id
 ffacd0b85a97d-45d900ec71fmr11224015f8f.4.1778835808876; 
 Fri, 15 May 2026 02:03:28 -0700 (PDT)
X-Received: by 2002:a5d:5f90:0:b0:441:2397:f40f with SMTP id
 ffacd0b85a97d-45d900ec71fmr11223956f8f.4.1778835808317; 
 Fri, 15 May 2026 02:03:28 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm14053566f8f.29.2026.05.15.02.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:03:26 -0700 (PDT)
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
Subject: [PATCH v4 3/3] drm/bridge: ite-it66121: Select HDMI or DVI mode based
 on sink type
Date: Fri, 15 May 2026 11:02:11 +0200
Message-ID: <20260515090220.809830-4-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515090220.809830-1-javierm@redhat.com>
References: <20260515090220.809830-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tra3unIOEROZg-EUgnrIdrMYBkw03kpb6NuiYi06dEo_1778835809
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

The driver unconditionally sets the transmission mode to HDMI, which leads
to display output not working with DVI monitors. Check connector's display
information sink type to identify the correct mode to configure the bridge.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v4:
- Convert the driver to use the HDMI helpers (Maxime Ripard).
- Move .mode_set logic to .atomic_enable (Maxime Ripard).

Changes in v3:
- Move the HDMI/DVI mode set to the .atomic_enable handler (Maxime Ripard).

Changes in v2:
- Don't store the sink type in a per-commit bridge state (Maxime Ripard).

 drivers/gpu/drm/bridge/ite-it66121.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index c8795247cfa8..95ee98a4a8df 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -184,6 +184,7 @@
 
 #define IT66121_HDMI_MODE_REG			0xC0
 #define IT66121_HDMI_MODE_HDMI			BIT(0)
+#define IT66121_HDMI_MODE_DVI			0
 
 #define IT66121_SYS_STATUS_REG			0x0E
 #define IT66121_SYS_STATUS_ACTIVE_IRQ		BIT(7)
@@ -658,6 +659,7 @@ static void it66121_set_mode(struct it66121_ctx *ctx,
 			     struct drm_atomic_commit *state)
 {
 	struct drm_connector *connector = ctx->connector;
+	unsigned int tx_mode = IT66121_HDMI_MODE_HDMI;
 	const struct drm_crtc_state *crtc_state;
 	const struct drm_display_mode *mode;
 	struct drm_crtc *crtc;
@@ -666,10 +668,13 @@ static void it66121_set_mode(struct it66121_ctx *ctx,
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	mode = &crtc_state->adjusted_mode;
 
+	if (!connector->display_info.is_hdmi)
+		tx_mode = IT66121_HDMI_MODE_DVI;
+
 	mutex_lock(&ctx->lock);
 
-	/* Set TX mode to HDMI */
-	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
+	/* Set TX mode to HDMI or DVI */
+	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, tx_mode))
 		goto unlock;
 
 	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&
-- 
2.54.0

