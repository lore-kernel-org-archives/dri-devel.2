Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDC2CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006CE10E0A3;
	Tue, 12 May 2026 13:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="C4cP0aeU";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4428010E0A3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778592169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHVYCXjf4x686H2N50v76tG96sCBSr2lERtEog8vZYE=;
 b=C4cP0aeUfegHJZ4VeqCnAUj4wOL8Z/s6CY2zg7xN+OGzz7e277wqikr+eM2a6pUEdgEypk
 orDP74BdPPsHywEynsX45PmFgjXUv6CzHjeEr3TVwsCDrKeAanXfKrm9gXX+dWj1ihrXIi
 /9k9lP+lN0faGjAJPz8AjZqPK04GyGI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-4PK7yNsOO92XJXwr_fseJw-1; Tue, 12 May 2026 09:22:48 -0400
X-MC-Unique: 4PK7yNsOO92XJXwr_fseJw-1
X-Mimecast-MFC-AGG-ID: 4PK7yNsOO92XJXwr_fseJw_1778592167
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so622170f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778592167; x=1779196967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aHVYCXjf4x686H2N50v76tG96sCBSr2lERtEog8vZYE=;
 b=JTiDRSU+TRhenjfZOUoV9B97RfHNwKAR9gShk477Bd46mjUaIPkVvNk/1BwHw8ZV5c
 i0vXwBJproqhrbFCjCvFd5e66I2at5r2cDmYBG27K4lKPV8FPyHirWONfQfg3PCzkAok
 oKYgTHJwKF6L4Wh36x8JPyYluCHP6Lkv6JvccxcPuTB7EZw4cmw1Ujl8IoxMY52gCvtl
 e3hkFHhOOfFsvZAAWV4UoE6RdRjS2PnOwL9M//0JHD3QF0/jJhyhSAjeTAc5NJoMvulY
 R6GVq/zeT3NGHXEE4BHbR0UnDQyrwkoHSKpjmQX9sBDaBfKUKiORXs96u5BciDGYUx/y
 HQrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RfwsNdYpCZlo0F9uEUzAxe918802VNxvZpv/2cd1anruF52LeqcSbRgksNKtHsIwCVbCUGkkyIjA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzucFabzlDBLKG/vBnQ+0ikGkE5pfs148wokUeA3gIaPG5RBTLb
 Tp8SDpwLT15GjpLwkXr9Y8mJC2spRyGNPg2KBtlc7/6cdLjg5O7JoxI0+spC/D3Yc2Q4MP2NNbP
 qRwub4MkIyYRuguhKYQO3Lbk11BdfwsnswJB6+DlT1P9VLB6RLLWYB0I3+S5qZGWcVL5Ocg==
X-Gm-Gg: Acq92OEH0ENEKrvKAXW5gYKz/vynLyF6+eRlMWwRBKdas6i2NgpepdMytm5+hHw4CMB
 uoBqqodt2rJhPuq8fVXgTDYAVoMyNfpz5JV1mzM3K8C4QYZKLDnOsITPQG0JS1SJPMKcuUTWJOo
 5Rxv10eMnTjOXil016ulxeSoiVIuLNklJ4obClLQKgJNr0R7lJ7K10ixg4X8v19VPj3MErid6nL
 OjFyxEo0gL+Vrv5914KOsDPWm1PNvNHV0xmOlnT3K6jKyUuzr9FxX4l9Rmg3qITuS+ykxtJNiFP
 y9JZSl428Zl2z1m9PxZUioDrkQXLrS0l5TwmvzKHXm+jptidIGuwTHSPi98KO7kFfdRsXkotZ6b
 5A3M6TYG9OQlysjCMKchR9jZ3y9qvVzo4JWiaiSXGhd7BhxU=
X-Received: by 2002:a05:600c:8b6b:b0:48a:7f90:2231 with SMTP id
 5b1f17b1804b1-48e8fe7c959mr44713075e9.19.1778592163905; 
 Tue, 12 May 2026 06:22:43 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:48a:7f90:2231 with SMTP id
 5b1f17b1804b1-48e8fe7c959mr44711945e9.19.1778592162795; 
 Tue, 12 May 2026 06:22:42 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f442129sm17673625e9.28.2026.05.12.06.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:22:40 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drm/bridge: ite-it66121: Set TX mode in the
 .atomic_enable callback
Date: Tue, 12 May 2026 15:22:15 +0200
Message-ID: <20260512132232.333654-2-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512132232.333654-1-javierm@redhat.com>
References: <20260512132232.333654-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f8z91-jiRIe6fYTRvqD9roEH-fDGMO2nWCoyiHjyvis_1778592167
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

The HDMI transmission mode set and AVI infoframes enable are done in the
.mode_set callback, but it is more correct to do this in .atomic_enable.

Because the information about the sink type is in the struct drm_connector
display_info.is_hdmi and this might not be available when the .mode_set
callback is executed.

Currently the driver is not checking display info to determine whether the
mode has to be set to HDMI or DVI, but this is a bug that will be fixed by
a follow-up change.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ite-it66121.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 19a027d75b61..648ca50712df 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -669,6 +669,22 @@ static int it66121_set_mute(struct it66121_ctx *ctx, bool mute)
 			    IT66121_PKT_GEN_CTRL_ON | IT66121_PKT_GEN_CTRL_RPT);
 }
 
+static void it66121_set_tx_mode(struct it66121_ctx *ctx)
+{
+	mutex_lock(&ctx->lock);
+
+	/* Enable AVI infoframe */
+	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
+			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
+		goto unlock;
+
+	/* Set TX mode to HDMI */
+	regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI);
+
+unlock:
+	mutex_unlock(&ctx->lock);
+}
+
 #define MAX_OUTPUT_SEL_FORMATS	1
 
 static u32 *it66121_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
@@ -729,6 +745,8 @@ static void it66121_bridge_enable(struct drm_bridge *bridge,
 	ctx->connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 
 	it66121_set_mute(ctx, false);
+
+	it66121_set_tx_mode(ctx);
 }
 
 static void it66121_bridge_disable(struct drm_bridge *bridge,
-- 
2.54.0

