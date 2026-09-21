Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E919C982FA
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8B110EA6C;
	Mon, 21 Sep 2026 15:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NWS8s+//";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC9E10EA4F;
 Mon, 21 Sep 2026 15:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005973; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KwU0MvN9TIqpzV48EIVHG5F1HhDllVYkeXB3229n+SkrqogUBlq6S9Xe00OwHtVFBuXJj/uJO4J+/6r2Ag/1bwjSCFTtc6O4WjUjKoB9a9N6vOp+ytK6c2FICBGElS3vVciYhJVKSlnX3flUc0EzeOKPVl9sgnrJ+1vsGAi//m4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005973;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=A37lvk2K4kvKDIjEQaFWtxje/hLDqdNIP4aYihLpCOA=; 
 b=PbqlYUF+Zvl3FGv7ItmwO2PiaxxqZiPWWKmb4fQ7kiyIXS4/V+d+VV3ZDsX0AtICpZopEzKL+vwmKoe5LoxOGevpk+T46LG3JAjNb/Tr2x1+U8/8Mc6Xh3/vQmYSRHyxFBFyaYzTaJPkkAYqcjzH2GvYkIRnZ74Td727/a63BaI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005973; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=A37lvk2K4kvKDIjEQaFWtxje/hLDqdNIP4aYihLpCOA=;
 b=NWS8s+//mfEFTrVR4p3kwSFSobcD+KUYqBd+Ckn1TlqEtQyMPU+FzLo51YECtZTN
 /o08VKT+AmRYkEay4XR8R0tPkQdU80OZIYY1E+bazrEX42TbQFjHrAkPO2xh6Dp7MFV
 mBHjUVK5v+ruHKeIfLt9Dzm68w9K9Q43oeDk2S0k=
Received: by smtp.zohomail.com with SMTPS id 1790005971883349.0752585694669;
 Mon, 21 Sep 2026 08:52:51 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:35 +0200
Subject: [PATCH RFC 09/25] drm/connector: Add drm_display_info_is_vrr_capable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-9-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

Add a function to return whether a sink, as described by a
drm_display_info struct, is capable of receiving VRR signals.

For HDMI sinks, this can just check the HDMI specific vrr_capable field,
which is set by the EDID parsing code. For other types of displays, the
generally agreed-upon method appears to be to check whether the monitor
range's minimum frequency is above 0.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 19 +++++++++++++++++++
 include/drm/drm_connector.h     |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index d94c86bfed86..fc7d9fcf9d9f 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1378,6 +1378,25 @@ int drm_display_info_set_bus_formats(struct drm_display_info *info,
 }
 EXPORT_SYMBOL(drm_display_info_set_bus_formats);
 
+/**
+ * drm_display_info_is_vrr_capable - Check whether sink is VRR capable
+ * @info: pointer to a &struct drm_display_info representing the sink
+ *
+ * Check whether the sink supports variable refresh rate signals.
+ *
+ * Returns:
+ * - true if variable refresh rate is supported by the sink
+ * - false otherwise
+ */
+bool drm_display_info_is_vrr_capable(const struct drm_display_info *info)
+{
+	if (info->is_hdmi)
+		return info->hdmi.vrr_capable;
+
+	return info->monitor_range.min_vfreq > 0;
+}
+EXPORT_SYMBOL(drm_display_info_is_vrr_capable);
+
 /* Optional connector properties. */
 static const struct drm_prop_enum_list drm_scaling_mode_enum_list[] = {
 	{ DRM_MODE_SCALE_NONE, "None" },
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 6e431eb81705..b18684d039d5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1072,6 +1072,8 @@ int drm_display_info_set_bus_formats(struct drm_display_info *info,
 				     const u32 *formats,
 				     unsigned int num_formats);
 
+bool drm_display_info_is_vrr_capable(const struct drm_display_info *info);
+
 /**
  * struct drm_connector_tv_margins - TV connector related margins
  *

-- 
2.55.0

