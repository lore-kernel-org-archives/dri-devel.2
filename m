Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A07CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 18:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD40A10ED83;
	Tue, 19 May 2026 18:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qpcJkucR";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB1410EE1E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779213628;
 bh=qACGt2L77YOTRGhDUDkraHcSM4Q/C/H5MRpV+Al+vzs=;
 h=From:Date:Subject:To:Cc:From;
 b=qpcJkucRZNyMNs/x3cfZ2+risurB/7Tq/Agava8LS731qESmTqoWOOrEugoT6zjuU
 dMVwFdO/gXMSghtC+uBxY5ZPoX4P9eJaeHJWSAZSwofx+MPbm1/moRhCPPcICEUT1/
 klJIw178R9mE0RM99tiDsQ89Lt5EF9pNqxZG4b5QmPVz1D8KmudNBEodrNpZn6iRzm
 mqOH7LIp0P05a8S2kAne2HIXypVaxnfYoIkYFPZuTkmwoBoCEbykK786fCSUI44rA6
 2c5q/5fPLDAqwxqdlUdJRNw+xF2pzqBsVaavOvC0umwHqIs/7jekAFov3EBcTIbmVu
 iBaHRpZDHtoZg==
Received: from [192.168.0.15] (unknown [100.64.0.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C62317E1299;
 Tue, 19 May 2026 20:00:26 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Tue, 19 May 2026 14:00:11 -0400
Subject: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBCF4auUWTswiRiIVxEXaTK2I5hKxrRCy
 d2NuvzgvX8H5SKscB52KLyKypI7zGGAOIc8MUrqBkvW0cl4vMkb5/QQDDXJglsoWfKkaI6enOV
 INHro72fhPv2VL9e/tY53jq9vDlr7AGW4M9h7AAAA
X-Change-ID: 20260519-fix-hdmi-audio-warnings-139062ec00b9
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Detlev Casanova <detlev.casanova@collabora.com>
X-Mailer: b4 0.15.2
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

-EOPNOTSUPP is not logged as an error by the ASoC subsystem, but -ENODEV
is.
It also better represents the situation: The operation is currently not
supported (because clocks are not enabled and tmds_char_rate is
unavailable), but the hardware is present.

Using -EOPNOTSUPP in the audio_prepare callback removes possible repeated
warning log lines when HDMI is not connected.

Returning -EOPNOTSUPP in the audio_enable callback is also needed as it
avoids logging 0-valued ELD errors.

When tmds_char_rate is available, the clocks are enabled and the
functions will keep returning 0 as before.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index d649a1cf07f5..270c8c47d853 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -469,8 +469,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 
-	if (hdmi->tmds_char_rate)
-		dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWDISABLE);
+	if (!hdmi->tmds_char_rate)
+		return -EOPNOTSUPP;
+
+	dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWDISABLE);
 
 	return 0;
 }
@@ -484,7 +486,7 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
 	bool ref2stream = false;
 
 	if (!hdmi->tmds_char_rate)
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
 		dev_err(hdmi->dev, "unsupported clock settings\n");

---
base-commit: 1a2ab0feaa23147e347b4d4cb79cb3fc392118eb
change-id: 20260519-fix-hdmi-audio-warnings-139062ec00b9

Best regards,
--  
Detlev Casanova <detlev.casanova@collabora.com>

