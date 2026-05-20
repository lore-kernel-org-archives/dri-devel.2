Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A50CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEE710E157;
	Wed, 20 May 2026 14:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Vjfr8aM3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CACC10E157
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yg6ugDawgWn5QsRCnVPpHRqRu0HM07HRxwmRFu7Ahbk=;
 b=Vjfr8aM3Q9AGCjhbn8aqlyRz8pKcGNZDVMxN0zNsMdZIM4wJp4tQwIcMoxF2Bo+GzP7NZX
 VWD3rIyoQCGeTCY4XMx05UUoct2W+KXuV2K7pY1e4KHCgyFZJv3NEg9xhbGWfAJn/fHVfU
 d1okfTaNFXex1pP1v8DtVVvB1pKkYWk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-6UCvJI7yOfS2eR0kJ9dOIQ-1; Wed, 20 May 2026 10:44:36 -0400
X-MC-Unique: 6UCvJI7yOfS2eR0kJ9dOIQ-1
X-Mimecast-MFC-AGG-ID: 6UCvJI7yOfS2eR0kJ9dOIQ_1779288275
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so4170537f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288275; x=1779893075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yg6ugDawgWn5QsRCnVPpHRqRu0HM07HRxwmRFu7Ahbk=;
 b=N6F9G2im0OGjO7U+2SOAL4t3bRjkGC/wNYwUNUaZBR79scys2x1cDEF0Tn5n+tYILL
 nyGKcOvEoznn8TSBuSq8LjqMUfJw+g0Tx/Lqvi8yJwUDaweb64ZLbj58vHfsttjLGRm1
 CbePZz2m+2hs846rvx4GdYBlE5M+PTxKMHJYnXukZULzrPp3uRLcDgfl1K6a0gtLlJpd
 TsDdIWFAu4pZ6rSqxz5lQiuyRE5uW+VX5p689FoXpN0+A6XA6isU8m4oEqz7jlCPwFN+
 xeTKzWLfD7Xlrs+sOE6n5EiY1qDsmclofMPPuP2Iwdj3kIXrNh1ojB3BX69/8TLhPogi
 R2aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8id/7hpPPq3E4v/IycLuNpbW3GzetB5PpbxMbDEh5x62MNTcN+OpNyWRGEHzoS3jmJeJRy9ajw9kM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNqUL0ggQgPqXn8fFaDRgL2aUG3W81iCjjgE/JDkhIbSchCf+o
 XP535e3aEJ2Bch2L3rAjUBJ6zhvM72HLTkGqr0h3q0E/nx2errlxQGj1DPCx0IBwZ2hwvpqAyXf
 ZXeZ+T1FeqQec+UZW6uFfS1XWuCK+fdRxUgYKKEbC02IYrLi11iJQyzp8kbMKkN3b8Tyuyw==
X-Gm-Gg: Acq92OHq5kmzEOMq6jtYhYqAEm07LwyIrJS2NhoZ/jG6myMTCJuRT6f4PVfJoTJJzcQ
 BU3dV9lpj5ZP1fhet3BgfG2KJCPzwD95FK/8ycpDFQBIf4HXgxAirzsEkeU1FLppl8n8Z4p71qF
 +fVRyd36vMGb9YJOkMvaX4ZSLPNSJUvONfizfKo5I+unoV7BcN1PAvAEOj21NUjaSYme58U5iLM
 vrNL8U+xwrxaWppXb6iadZN45J/t5AZMyUG9nPbQhyaxdj0QLCqpSgeqtSGyCWP/AcN04WITSjS
 D4XrgqGWIhFzBil/b1iTb4XQPZoQqFxnBC+bvOZrbz3l1vtiEQC2b0lA+PnU7uSP0K0XRf8TVXX
 A12YdROhILRAW+c4tvqeyY6I31Q4f9qmQvs2J3LZuQa09cq8=
X-Received: by 2002:a05:600c:848c:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48fe60e51c6mr377330885e9.7.1779288274871; 
 Wed, 20 May 2026 07:44:34 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48fe60e51c6mr377330385e9.7.1779288274397; 
 Wed, 20 May 2026 07:44:34 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab6aasm432985425e9.2.2026.05.20.07.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Robert Foss <rfoss@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/8] drm/bridge: dw-hdmi: Use the common TMDS char rate
 constant
Date: Wed, 20 May 2026 16:43:38 +0200
Message-ID: <20260520144424.1633354-3-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520144424.1633354-1-javierm@redhat.com>
References: <20260520144424.1633354-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BQxCUOFT7t3TF-oxwTAxiKTtjpn_YhW2lOkp7zBME1k_1779288275
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
constant defined in the <linux/hdmi.h> header.

The local define incorrectly referenced HDMI 1.4, but the 340 MHz
maximum TMDS character rate was actually introduced in HDMI 1.3.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 41b3a9cfa2f5..17d5caedb32e 100644
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
+		if (mtmdsclock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
 			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 1);
 		else
 			drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, 0);
@@ -1671,7 +1669,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi,
 	}
 
 	/* Wait for resuming transmission of TMDS clock and data */
-	if (mtmdsclock > HDMI14_MAX_TMDSCLK)
+	if (mtmdsclock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
 		msleep(100);
 
 	return dw_hdmi_phy_power_on(hdmi);
@@ -2032,7 +2030,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 	/* Set up HDMI_FC_INVIDCONF */
 	inv_val = (hdmi->hdmi_data.hdcp_enable ||
 		   (dw_hdmi_support_scdc(hdmi, display) &&
-		    (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
+		    (vmode->mtmdsclock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ ||
 		     hdmi_info->scdc.scrambling.low_rates)) ?
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
 		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
@@ -2100,7 +2098,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	/* Scrambling Control */
 	if (dw_hdmi_support_scdc(hdmi, display)) {
-		if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
+		if (vmode->mtmdsclock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ ||
 		    hdmi_info->scdc.scrambling.low_rates) {
 			/*
 			 * HDMI2.0 Specifies the following procedure:
-- 
2.54.0

