Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39216CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D9510FD74;
	Mon,  1 Jun 2026 22:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pa9AIksV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DF810F817
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780353915;
 bh=nrOKDTe1HmXsLH2kqmhLmoDqq6g4GvbMXtZ492I514E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pa9AIksVwxUHazLrV3OYVJTlSkSaPcg3SetCh2RRQsKs9jjbtIF6AobBvXV3iShS3
 UFYagSZfJbu9XTry7vFY2Ah7P/4GmUYkn3K8jYu3qinBL/+NYtuVknXQVPtO5/wCt2
 Phkq+mkZ9sel5Sx8E2WLlQKIMvAVd0+UTKMADf0H+thvxrDBumeC+kwCpA0dNsOxXA
 yr/gMxk2IH3l4YsgHvFSIS5sSZgpzgOKtGLpuw8Sjat+wgi5wD50JtSODmbutFs1Xo
 3FwPLBBfOvvPcnXQ3+RpzxVnoUeLA3879sw2xwbkdcJLFfvRpfY9euV/YUrjOmPJtG
 TRf+jPUyK99pg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C244517E0C54;
 Tue,  2 Jun 2026 00:45:14 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Jun 2026 01:44:06 +0300
Subject: [PATCH v7 06/30] drm/display: hdmi_state_helper: Plumb HDMI 2.0
 source scrambling capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dw-hdmi-qp-scramb-v7-6-445eb54ee1ed@collabora.com>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
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

Toggle drm_connector_hdmi_state.scrambler_needed flag when the TMDS
character rate exceeds 340 MHz and both the source and the sink advertise
SCDC scrambling capability.  Drivers no longer need to open-code this
check.

According to HDMI 2.0 spec, scrambling is only mandatory above 340 MHz;
the optional sub-340 MHz scrambling path is intentionally not requested.

Once all drivers are converted to advertise the scrambler support, the
unsupported HDMI 2.0 modes could be simply rejected.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a96d81cbf94f..7cb880dcedfe 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -588,6 +588,21 @@ hdmi_compute_clock(const struct drm_connector *connector,
 	if (status != MODE_OK)
 		return -EINVAL;
 
+	if (clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ) {
+		const struct drm_display_info *info = &connector->display_info;
+
+		/*
+		 * TODO: Reject unsupported HDMI 2.0 modes once all drivers
+		 *	 advertise their scrambler capability.
+		 */
+		conn_state->hdmi.scrambler_needed = connector->hdmi.scrambler_supported &&
+						    info->is_hdmi &&
+						    info->hdmi.scdc.supported &&
+						    info->hdmi.scdc.scrambling.supported;
+	} else {
+		conn_state->hdmi.scrambler_needed = false;
+	}
+
 	conn_state->hdmi.tmds_char_rate = clock;
 
 	return 0;

-- 
2.54.0

