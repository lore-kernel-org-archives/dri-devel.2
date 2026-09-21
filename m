Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700FBC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B15A10E05C;
	Mon, 21 Sep 2026 15:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gU8WwUFL";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C17010E05C;
 Mon, 21 Sep 2026 15:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005929; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ml3smdYUlqSH1mc6vbEi4yTO3jB8SQVOP3F5f7I0Sm7/CgNHUOqB6wbBfHlFhYXrh0DEPWTR1gWA9Yf5Mdvbc4mHAY2uPYwHSc5GaZNA8p09CWciJ53xvIr8ssVE8z+O7IDCoVNnP/H+480BENWeAaLtxrmmtGzg9YGzHl9P89A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005929;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ytG9EVMPqKl2Mw9Xbxf4dujO3AFiJ9cigwIohDH1vlA=; 
 b=n2Ey+GF00mNbV9T77/DBajAOOcuV6t+CHyWyqkBNaL3MBXGttwujwgM/kM3Z5EVzL7P2Kk7RSA/a/idHnLOMdqCcufg6eXolwQf6+o1WPRbMfSQtHxz0/0aJ6SKCJBlYtFLGkVBdMBDtT2F/6sqpFepvXTCTNy/FKfaC/A7ndbM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005929; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=ytG9EVMPqKl2Mw9Xbxf4dujO3AFiJ9cigwIohDH1vlA=;
 b=gU8WwUFLpF1njrpENtAeLn9Je+89Y8DPu3LgczqOAd13iQ0DKPP/lMLfYOhGfLxD
 GjPUDSVLgBHWOgY9eGj15EgzocYYk2LfctCYNU13ft1oC7MzTYxBeOJFbOC+RdiVzCx
 J5MeO74szXzSbK08Cpgl+psIsvYdxXxIQlNKBTUs=
Received: by smtp.zohomail.com with SMTPS id 1790005926723132.8117967235828;
 Mon, 21 Sep 2026 08:52:06 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:27 +0200
Subject: [PATCH RFC 01/25] drm/edid: Add a query for vrr range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-1-2fcd7d011646@collabora.com>
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

From: Derek Foreman <derek.foreman@collabora.com>

Query the minimum and maximum VRR vertical rates from EDID.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_edid.c  | 26 ++++++++++++++++++++++++++
 include/drm/drm_connector.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3148038747b6..a1494028e0f5 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6309,6 +6309,25 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 		hdmi_dsc->total_chunk_kbytes = hf_scds[13] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
 }
 
+static void drm_parse_vrr_info(struct drm_display_info *info, const u8 *hf_scds)
+{
+	struct drm_monitor_range_info *range = &info->monitor_range;
+	const int pld_len = cea_db_payload_len(hf_scds);
+
+	if (pld_len < 10)
+		return;
+
+	if (!range->min_vfreq)
+		range->min_vfreq = FIELD_GET(DRM_EDID_VRR_MIN_MASK, hf_scds[9]);
+
+	if (pld_len < 11)
+		return;
+
+	if (!range->max_vfreq)
+		range->max_vfreq = (FIELD_GET(DRM_EDID_VRR_MAX_UPPER_MASK, hf_scds[9]) << 8) |
+				    hf_scds[10];
+}
+
 /* Sink Capability Data Structure */
 static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 				      const u8 *hf_scds)
@@ -6371,6 +6390,13 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 		dsc_support = true;
 	}
 
+	drm_parse_vrr_info(info, hf_scds);
+
+	if (info->monitor_range.min_vfreq > 0)
+		hdmi->vrr_capable = true;
+	else
+		hdmi->vrr_capable = false;
+
 	drm_dbg_kms(connector->dev,
 		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 support: %s, DSC 1.2 support: %s\n",
 		    connector->base.id, connector->name,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..593fbeaffa16 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -380,6 +380,9 @@ struct drm_hdmi_info {
 
 	/** @dsc_cap: DSC capabilities of the sink */
 	struct drm_hdmi_dsc_cap dsc_cap;
+
+	/** @vrr_capable: The sink supports variable refresh rate */
+	bool vrr_capable;
 };
 
 /**

-- 
2.55.0

