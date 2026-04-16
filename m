Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E4CF8E4B5
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6689110E97F;
	Fri, 17 Apr 2026 07:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ky8QV3o4";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A91810E84B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 09:32:06 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ab08e6c553so7974165ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776331926; x=1776936726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ziW1kBAvi5eeUGJnyi0Kk8txQ47lAeHn3mhssBVXCLs=;
 b=ky8QV3o4SSnr6HskUYqzYD3dkDucWNqEC14OcUfCppRMkU/OyMeOebliLuBaMhDSZD
 XUgLa4Ir+vk50uJd2zxWo3ItodC8CfED7i8lbR2XLvbHqDfZSqEOimDUH62FHK6m4eft
 0DHb/1A54I7bB62+g5JTopaJJwJhPdJJ7WxPvCvPUSEFg83EAqVz/pMprKCxfEFq/X3y
 X4d75veCAiwbbPkl1na2tkT25PQimscVM2D0mgLn4UL9RaqtgPf2TeWXweC4qK/Th76N
 pOhwjM8JlP+8YYkEFJf/Pul0rXQBxJpo503hJPgL3ZujvwaX9W+rHEUjHEqsY396qVUn
 OD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331926; x=1776936726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziW1kBAvi5eeUGJnyi0Kk8txQ47lAeHn3mhssBVXCLs=;
 b=b9iY1tmsQtL74oC5BXwlVvIBhvNpAm6EMXrO7xHdKaHjMqtt9uQcFgK0HfEHsKQra3
 6Prk7QbqeanYe2lNEyb/pE0P0RbegCzdR/x+wE6YhqIJDTqvSv9aNlR4Wm0W+4Lk14IG
 JldvcTJH2TeYrMuZoljMvTt1qG3jYq4pkQEwjGM8zGUn9P+kdxFqcMCCdP9/DbC1pHEg
 5HPXfD2EGHdxVIZIXCX0YCqIM6ztLT+HZ2L1B94NZddbUTndSav3k5D0y86rBblGaVe9
 SXXMt8y0U3D3DYh5SDHs6Xxb00kF6YTt16GLHxB3iooqXoyAAfSoti6/etHTTHPjzNik
 D9pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2Xwool7omgSE9LTKecs59dhs9KN4KaORWULMO8zWnJo58sRPa1iAd4iqRG/TLdajo0mqttC6ypIo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4QPenmnfyoUXwC98GFHG8YscTSDvQ0wV4yvpm4pau+D+r7dvM
 0mEWCsU+tZTk2JnKLQvJNT1HY6TXBc4N3g3u3Gl2wiWLk1VSDOpD+/cQ
X-Gm-Gg: AeBDiesccmoBidSB/cz0tC0Ml03FWM4xfaBgw9Bze2kiFGGUlUTRkf6BEc5Ajjx4gm4
 zeKhiJAyneCxMDoR9en759lHyMz1lEJJ4T+ZxdmmzTCsPc1HK5OvOMTlmF3b4Die6AZVaqQ5FOz
 X1XV0R24wO3/uD2jcLGdR4Ow7h4aIaPVwNXI0vn5oULYx4jt6cZL16cAded+BPAlEYttor+A1ic
 23riATR3nF25YRvg+NvYGokWQK8jgZS6PagMj/ufleZM9V35zW56SLcW4TOMQBrbYG9KdeTxZ4M
 7aOdvJ+D5obh82YmJanZFQRKem2TivLdvMqzzkEwCca6GgO3fiyon5R0fVnwUMPy2UpI/I92ssE
 eANIM8T5lhXfvSAH7IkTq/GYm/++8Pv4/7ZssSNatj9ZWnqBGaOblmcyYtmUT0GCue4BncchBbP
 xyOKX5ru6LQ7ns27RofFbO3JCvveWBBCGxlx1delE6AGM9CuGMVX7kwYxTBVnx3gn5jYqYYJXr
X-Received: by 2002:a17:903:903:b0:2b2:5857:5847 with SMTP id
 d9443c01a7336-2b5eda46fd0mr11515325ad.5.1776331925536; 
 Thu, 16 Apr 2026 02:32:05 -0700 (PDT)
Received: from fedora.izzigo.tv (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478292053sm60643655ad.56.2026.04.16.02.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:32:04 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY
 is down
Date: Thu, 16 Apr 2026 17:31:50 +0800
Message-ID: <20260416093150.13853-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

The following panic was observed during system reboot:

Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
Call trace:
 ...
 regmap_update_bits_base+0x5c/0x90
 dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
 drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
 ...
 dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
 drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
 drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
 hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
 ...
 snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
 snd_pcm_release+0x60/0xe8 [snd_pcm]
 ...

The root cause is pipewire tries to close the HDMI audio device after
atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.

In this case, dw_hdmi_qp_audio_disable() will call
clear_audio_infoframe(), accessing registers without checking
tmds_char_rate.

Add a tmds_char_rate check in dw_hdmi_qp_bridge_clear_audio_infoframe()
to skip the register write when the PHY is inactive.

Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index d649a1cf07f5..f963dff81dc6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -886,11 +886,12 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_mod(hdmi, 0,
-		       PKTSCHED_ACR_TX_EN |
-		       PKTSCHED_AUDS_TX_EN |
-		       PKTSCHED_AUDI_TX_EN,
-		       PKTSCHED_PKT_EN);
+	if (hdmi->tmds_char_rate)
+		dw_hdmi_qp_mod(hdmi, 0,
+			       PKTSCHED_ACR_TX_EN |
+			       PKTSCHED_AUDS_TX_EN |
+			       PKTSCHED_AUDI_TX_EN,
+			       PKTSCHED_PKT_EN);
 
 	return 0;
 }
-- 
2.53.0

