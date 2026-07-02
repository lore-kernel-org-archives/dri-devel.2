Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39ADC44501
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DE410F407;
	Thu,  2 Jul 2026 14:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HxfkMS7W";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2B110F40C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003597;
 bh=4PyW8Jhg7IiTzgbSHOrnUha3BzbvIJ2MbhHineOQU4M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HxfkMS7W8sBiV7T3rZB+k1FFRe/+kbErsAmzNf5jw8yypsDHIkmI9BXjg34DCh2mF
 crYZeqX8OzHL/ok/SRBwmC8Fr0cIhtX0GD9nubv0doTB3y0juDtZp683jIaUxoGhno
 tvJkvAnCZel4NhH7ITXnoiBene/Pk1FcVSfH5rIuJBBpyj2AHglUbQEcD1RvC6Rubi
 jinKib9tuZ0GQoHAp1dm8PeRNpNUEESlWaDierF7FaML++WI9BZhlWlnrXMWSPQMTS
 MZh6sHwSSfRDRwpZcIrCoMRAedVHBPosiV5w1McNVW6mPu3CevbjV1lhFKcp4kWHdZ
 cKPJAFxO6QafA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7555217E0852;
 Thu,  2 Jul 2026 16:46:37 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:21 +0300
Subject: [PATCH v8 08/39] drm/display: hdmi: Advertise SCDC source version
 when scrambling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-8-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
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

The HDMI 2.0 spec advises that compliant Source devices report their
SCDC version in the Source Version register.  Do so when enabling
scrambling by calling drm_scdc_set_source_version().

Failures are non-fatal: SCDC version negotiation is purely informational
and does not gate scrambling or any high-bitrate functionality, so a
flaky DDC bus should not block scrambling setup.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index 7c96cccf683d..b8ed2a1e47f5 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -16,6 +16,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_property.h>
 
+#define DRM_HDMI_SCDC_SOURCE_VERSION	1
 #define DRM_HDMI_SCDC_POLL_DELAY_MS	1000
 
 static inline bool is_eotf_supported(u8 output_eotf, u8 sink_eotf)
@@ -531,6 +532,12 @@ int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
 		return -EINVAL;
 	}
 
+	/*
+	 * Advertise our SCDC source version. This is purely informational and
+	 * does not gate scrambling, so failures are non-fatal.
+	 */
+	drm_scdc_set_source_version(connector, DRM_HDMI_SCDC_SOURCE_VERSION);
+
 	drm_dbg_kms(dev, "Enabling scrambling\n");
 
 	hdmi->scdc_cb = drm_scdc_monitor_scrambler;

-- 
2.54.0

