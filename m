Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3265ECD5BAB
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D0C10ED4D;
	Tue, 19 May 2026 14:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="U6XnHnrV";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0557610ED53
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xsSoTwiRNz90vOYxeUhQK/ys9WcE9kZjrgtjE9tN3g=;
 b=U6XnHnrVmXA5bNBE7UuYu096tUZIP+68PSJY/3KaGjK0HBagQiNmRCWdFyibzZgCsIPWNe
 NPmm/xymrNGB+Qxua8jg/OaUcalPFt8f0lw+UpgjWFPnbB2osA8rqWZKGIvQDdjKegRKoL
 Jf6PkRS6bjHB3bfCHPU+k4Yzs+Xt3j4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-HZOcAXd6OXe_X8eZ8-UkJw-1; Tue, 19 May 2026 10:47:31 -0400
X-MC-Unique: HZOcAXd6OXe_X8eZ8-UkJw-1
X-Mimecast-MFC-AGG-ID: HZOcAXd6OXe_X8eZ8-UkJw_1779202050
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-449b2a183d3so2436509f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202050; x=1779806850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6xsSoTwiRNz90vOYxeUhQK/ys9WcE9kZjrgtjE9tN3g=;
 b=iWNawY0AyHlFZpxa1brS8PUgD7R9yksTgMRdcTry8y08IjSU9kVAHt0Q9vV+QrenH+
 WkFSp4hbw0XQw0/uM3MTQw1urzdIAZWyRwb2LTiyXslNBbyAcI9nGOnLsmG/rG51IVtJ
 TrNaQ1y9HEw3sZ9eZ/5B4OWGu75iHCPoOwdCEbCqoweBv1VvX2+c2rih6CdLER/joX+8
 JbVKwBGm2qojZmo6VSc888xbdCL2c+KIXSIUTyexVrtIFGjT1ElVOIOvPz+II/7G3N1A
 Enh3IuXBvwn6y6cbEDPCFMTsP4w4u9Ykt5TUC9vO1YbBzaL8dJ7zM8ajBScTKgsQ5vU8
 4ATw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CUKJc9KZv1QU2M1tyru5d1g3CER0TGL4YKU0sffhK+DzCOxVLdW0ajfrf1VC7oGIHN88VWcsC3Y0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEzCSzQNl/5Wt/4gLAmvCvz7ztVB8xHBN3uWckJDVwDmSUixJE
 9+onEBLy+Nb2r6aT02YbAYKrJBlzmholrICojIw2HRlzY3qXqwn5G1yIimNgv8dVUwRr9Qouk0U
 wZN9CesAWmXTzhlYt4n/umi6SGMZXFh7B5uaYBwSJq+a9MqepYAu6pXmC7JVakDWsDPDOyg==
X-Gm-Gg: Acq92OHC+x4VC/kTraJsguLHpim6b/ckpN+ucqrZWgukvvEvwOkP48bBmGKDSPi/hrv
 EqUM6mT+/L8MzczltRRzDXsIljqfUbSwkH3HwVz2FUkfWYPMzREF/30V1iTfGhzP5JED5XxUoxJ
 Jv83THwL6oEfeCI9DMwMI0O4/ouQvsfTQssLXIQbdFF8kAlkXoGdqPTtszFgHO+PaR/n32GvduV
 UTCc2ND7ApZjZT8iYDuYshSJYSWNQ+4q0AWoirszaDUsmM0EZjQIg4TopCVrl5WcGZFFfjDwglD
 3avumg+THlJwBYiMZ1XvX0Z04M6kt/Vh4w10ky3B3WF+neON8wTcIbJafT05j9QHaYho3+UNm0Q
 JJgVneG77hs6KYdzw4BFju1SaLurwXa0DXguKWjKujEEIEPs=
X-Received: by 2002:a05:6000:160f:b0:45e:8a9c:608c with SMTP id
 ffacd0b85a97d-45e8a9c6144mr3198437f8f.2.1779202050013; 
 Tue, 19 May 2026 07:47:30 -0700 (PDT)
X-Received: by 2002:a05:6000:160f:b0:45e:8a9c:608c with SMTP id
 ffacd0b85a97d-45e8a9c6144mr3198381f8f.2.1779202049410; 
 Tue, 19 May 2026 07:47:29 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm46647759f8f.8.2026.05.19.07.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chris Morgan <macromorgan@hotmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniels@collabora.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 3/8] drm/bridge: dw-hdmi-qp: Use the common TMDS char rate
 constant
Date: Tue, 19 May 2026 16:46:59 +0200
Message-ID: <20260519144712.1418302-4-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -3ZW7p_-w4MWCDHg_QkjpjxcXxx_XW_R1MLhA2gIod8_1779202050
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

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 0dbb12743609..37d8292b6f7f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -38,8 +38,6 @@
 #define DDC_CI_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
-#define HDMI14_MAX_TMDSCLK	340000000
-
 #define SCRAMB_POLL_DELAY_MS	3000
 
 /*
@@ -835,9 +833,9 @@ dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
 	/*
 	 * TODO: when hdmi->no_hpd is 1 we must not support modes that
 	 * require scrambling, including every mode with a clock above
-	 * HDMI14_MAX_TMDSCLK.
+	 * DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3.
 	 */
-	if (rate > HDMI14_MAX_TMDSCLK) {
+	if (rate > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3) {
 		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
 		return MODE_CLOCK_HIGH;
 	}
-- 
2.54.0

