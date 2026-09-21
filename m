Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65610C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AFA10EA91;
	Mon, 21 Sep 2026 15:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="DNYT7D1L";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B9B10EA7D;
 Mon, 21 Sep 2026 15:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005991; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IPFid0e9vODgcSMCEusJ+bQftHO17olv16R8WSLSSyhN/KFvjOfYrhEknHrN4LtxKQI5Y/1AL934WFqS55OiMDDsJZ7ABmjeZDm9tzNgWcnk+eRZfX7yZ970nBr+RFPOjKsMBneDbUEuU7sj/O0UcywETkcXkRT1EqdnzXsa7Eg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005991;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OTPs0m8K1NZZqNCZ2ZoGsft+mfIizutFeldFeGSDZYA=; 
 b=mHppDmJko71JK/NbwhakTvzqCMT1YcR3SahXGhdLjuMSo6zZGSrq9DVY9G82jntXD8v/gJ8vp3e6aXdpD7tMVVPKzV64swKVQMaXOqB8KR8UX+LiUr3eDzLY96bPnDMNu8k2vHiCOwKzwOXbtclU2S1q4PK80eNQtaSchdon6Sc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005991; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=OTPs0m8K1NZZqNCZ2ZoGsft+mfIizutFeldFeGSDZYA=;
 b=DNYT7D1LE8zPm5SV05KRKU3gOwJah2VF7pX6LLN/tkiSeQDcLlew8WiSW3+V9p2Q
 z/y5l/h9zsFhoKbViarXQa3VWCr3L019j/OKjn+ef/e+D5Em636idyz9iCu6tI+6T4g
 R2jg/fVz+aOTEccx40zL7lciLVbt6pA2agj/XgpA=
Received: by smtp.zohomail.com with SMTPS id 1790005989707834.0920962164566;
 Mon, 21 Sep 2026 08:53:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:38 +0200
Subject: [PATCH RFC 12/25] drm/edid: Parse CinemaVRR flag from HDMI SCDS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-12-2fcd7d011646@collabora.com>
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

HDMI's extension to EDID contains a flag which is used by sinks to
signal that they support "CinemaVRR". When CinemaVRR is enabled, some
VRR is possible even if the minimum VRR range is set to 0.

Parse it from the SCDS and store it in the sink's drm_hdmi_info.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_edid.c  | 7 ++++++-
 include/drm/drm_connector.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a1494028e0f5..cc6f2ba8c9f4 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6314,6 +6314,11 @@ static void drm_parse_vrr_info(struct drm_display_info *info, const u8 *hf_scds)
 	struct drm_monitor_range_info *range = &info->monitor_range;
 	const int pld_len = cea_db_payload_len(hf_scds);
 
+	if (pld_len < 9)
+		return;
+
+	info->hdmi.cinema_vrr = !!(hf_scds[8] & DRM_EDID_CINEMA_VRR);
+
 	if (pld_len < 10)
 		return;
 
@@ -6392,7 +6397,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 
 	drm_parse_vrr_info(info, hf_scds);
 
-	if (info->monitor_range.min_vfreq > 0)
+	if (info->monitor_range.min_vfreq > 0 || hdmi->cinema_vrr)
 		hdmi->vrr_capable = true;
 	else
 		hdmi->vrr_capable = false;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index b18684d039d5..b147b8474f1a 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -383,6 +383,9 @@ struct drm_hdmi_info {
 
 	/** @vrr_capable: The sink supports variable refresh rate */
 	bool vrr_capable;
+
+	/** @cinema_vrr: The sink supports "CinemaVRR" */
+	bool cinema_vrr;
 };
 
 /**

-- 
2.55.0

