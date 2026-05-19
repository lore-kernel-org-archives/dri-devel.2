Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9926ECD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5E010ED52;
	Tue, 19 May 2026 14:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TQZ6uC9B";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E1610ED52
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmO8Wr7tsXS06zFtg7IPRTUeza9gF/FNLRuBRJpr0Ck=;
 b=TQZ6uC9BYwMLHD+2NANFpc2k/nvvHvXB9JD7BlQ6AbP60+Y5lbnc0aOf4b5NlvtupNpJMC
 Zl+kMqqPgRjyKLq794mSJpOkMBMehwDhs3xnHNn9Q0zoWniOPqWXFKJ986rV4iJ3xMjUmP
 On8X/TzqLVeaiwuttEkH8j5hsi00hVA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-krh-RINjOd6qwfEd1hivEw-1; Tue, 19 May 2026 10:47:29 -0400
X-MC-Unique: krh-RINjOd6qwfEd1hivEw-1
X-Mimecast-MFC-AGG-ID: krh-RINjOd6qwfEd1hivEw_1779202048
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e7c7289c3so2137263f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202048; x=1779806848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wmO8Wr7tsXS06zFtg7IPRTUeza9gF/FNLRuBRJpr0Ck=;
 b=JLnKzVHhUnpkABgjnEmrcgpriHvJpxWSn2KJiqLUVoXwih0IKk/xsdP1F3iJpeGUij
 szUCXHVNHha7ym4dL7QB4+pJV3cJwapTrqqlK58SVAjeXy1PTTl/cLw24EYULmltN5UW
 B2tFgTjGVEUuUyvJxnsoFghj/9bb0Q54sqx8UeftXEITRoKSjMLrbiKdVyaWFhyFOkUg
 2ktaijc6Rm+DL4BnQP5vS16WBZOpcjTVx6wBqLj1//Vyim5rH5lQ1xlfHo/nYMvtk7hb
 yj7w1ZuvGGiWsy8XzSPklssqq4DZlVGYcwt+/0q/Ym3+AbUQ5Pw3dyyqzPFS13SFb/JY
 Grxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6wnegY09TIL9GB9jGPF+BUEWIrYioYT4nSyXKAbLxPfGiPpseQu9FysnQhFRFmidOPwhXu+/SOs0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yycmr4xNV/DOo3HSoihCZD5DPnaTT3qcReJYYKwrLEnb0XeOXh0
 zo4wCR5H3Tu7Ty5O9eFJrvcBOqC99ylur20amOCPj867DbFsf4UyBJYKKpBREgjj+n2mLvZ/K8n
 AIEAHeubC7YbPGCBb+Iotmv0AyHe1u0Y1lheRR6pCky1F4YUtQNgniiRs1AZxSvZfjL43YA==
X-Gm-Gg: Acq92OFUMfjvIn7BglxWco9TzHB9EeRUK6C29v/Ph2bQ4rprYiFoppQ6lKotHp6E4o5
 sF3zKgts9k3QwIPHBtVksvjvFrJ/H7R8hOqFGxxsB+LRgdBvk6DIBnDrU5DpoxfuYdqWDe8WWCm
 AI+wvGfYM1k0gkjqVzk8nZZOI3N5GYLxeE43LHQeTHMTqVxTtzYglRiay4bPPxOLhukwPeaImpg
 z4F5SeiM53Nmqrg3PxGVf3DGdrYzrMFnwz5Ymdt0RchglHCeOLxZfQ645IzkdTgme1KGaVoEVdm
 ZiSescEr2iXlDtA5AK1Q42JxBEcJmpqI/iGW9Rzei5IjMThsD8jV5C/nSL5x0fZeRp9BoGhGlOD
 1a9tRbpNBS3ibJ6I1zMjY6yLiXBwgSt/BZcdBe1VLHG6rLGtf/MINrvLvJg==
X-Received: by 2002:a05:6000:40cf:b0:441:29cd:a18e with SMTP id
 ffacd0b85a97d-45d941b19admr38673179f8f.23.1779202047868; 
 Tue, 19 May 2026 07:47:27 -0700 (PDT)
X-Received: by 2002:a05:6000:40cf:b0:441:29cd:a18e with SMTP id
 ffacd0b85a97d-45d941b19admr38673113f8f.23.1779202047191; 
 Tue, 19 May 2026 07:47:27 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768acesm49336351f8f.7.2026.05.19.07.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/8] drm/bridge: dw-hdmi: Use the common TMDS char rate
 constant
Date: Tue, 19 May 2026 16:46:58 +0200
Message-ID: <20260519144712.1418302-3-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uxNbXhrGMUvCsaJt242dlCnOQU5-xXfegh88DLSbwRY_1779202048
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

Replace the driver local HDMI14_MAX_TMDSCLK define with the shared
constant defined in the <drm/display/drm_hdmi_helper.h> header.

The local define incorrectly referenced HDMI 1.4, but the 340 MHz
maximum TMDS character rate was actually introduced in HDMI 1.3.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 41b3a9cfa2f5..d7c0a599aa42 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -51,8 +51,6 @@
 /* DW-HDMI Controller >= 0x200a are at least compliant with SCDC version 1 */
 #define SCDC_MIN_SOURCE_VERSION	0x1
 
-#define HDMI14_MAX_TMDSCLK	340000000
-
 static const u16 csc_coeff_default[3][4] = {
 	{ 0x2000, 0x0000, 0x0000, 0x0000 },
 	{ 0x0000, 0x2000, 0x0000, 0x0000 },
@@ -1426,7 +1424,7 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi,
 
 	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
 	if (dw_hdmi_support_scdc(hdmi, display)) {
-		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
+		if (mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3)
 			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 1);
 		else
 			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 0);
@@ -1671,7 +1669,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi,
 	}
 
 	/* Wait for resuming transmission of TMDS clock and data */
-	if (mtmdsclock > HDMI14_MAX_TMDSCLK)
+	if (mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3)
 		msleep(100);
 
 	return dw_hdmi_phy_power_on(hdmi);
@@ -2032,7 +2030,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	/* Set up HDMI_FC_INVIDCONF */
 	inv_val = (hdmi->hdmi_data.hdcp_enable ||
 		   (dw_hdmi_support_scdc(hdmi, display) &&
-		    (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
+		    (vmode->mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3 ||
 		     hdmi_info->scdc.scrambling.low_rates)) ?
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
@@ -2100,7 +2098,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	/* Scrambling Control */
 	if (dw_hdmi_support_scdc(hdmi, display)) {
-		if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
+		if (vmode->mtmdsclock > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3 ||
 		    hdmi_info->scdc.scrambling.low_rates) {
 			/*
 			 * HDMI2.0 Specifies the following procedure:
-- 
2.54.0

