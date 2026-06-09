Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F029CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A392610E397;
	Tue,  9 Jun 2026 12:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="krV3myC6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5573A10E34D;
 Tue,  9 Jun 2026 12:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781009105; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JTE/TIbKwPgKVJ+LlfMUo2jlQAEj2yud6a/bJfipZq14OwVDSSa9q2zJdHnBhPuQ48Cjjtw5NDzmQMkERSPwFPNNxID6zHCLez7N8ZwfCseXcwta+udgmcu9mloC0sOD8BNcE+Jvvv+tvwrz/cBG/aHoPE7pLK6ZPumujS+pXR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781009105;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xT8eNiV+R92IoR+xDb7ijRo4xGRp/ja8R6JYAyMBFaE=; 
 b=h/EOs0iJziebb4/OQfydbOiU58rUgOUU1cvxB2MTuoAQIAv8qFrJF5b5/c2Eyc4rk73uAzLp0IuOzncVe4QzEWrU4ptYu7LL7Px7M/Vu1gtKUbHKLcI/uhB1u2XfohnjN1NF6+eYOYodwsZj1ZyTN5ySjlTAC2RbeUIml0u+lD0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781009105; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=xT8eNiV+R92IoR+xDb7ijRo4xGRp/ja8R6JYAyMBFaE=;
 b=krV3myC6CZebjq5eEJL2S1cKsfV+MkRflnXeebQz2nR7RQ79qWaA6Tq6ys/3V1t5
 gy43R7mJC0QWUw29/JS09QXLMIo40EA44QvBTveM11qkDkAWrq8mDWG58NA3wY7WrXw
 JPr8Xjr53bJgx2eDU7h7/Q8vHDRveYn84MoHwYCs=
Received: by mx.zohomail.com with SMTPS id 1781009103666380.38912731714424;
 Tue, 9 Jun 2026 05:45:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 09 Jun 2026 14:43:52 +0200
Subject: [PATCH v17 05/28] drm/display: bridge_connector: Use HDMI color
 format for HDMI conns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-color-format-v17-5-35739b5782cc@collabora.com>
References: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
In-Reply-To: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

For bridge connectors which contain an HDMI bridge at some stage, the
HDMI state helpers' format selection logic should be involved.

Add an implementation for the drm_bridge_funcs color_format function,
which translates from the HDMI state's output format to a connector
format for bridge connectors involving an HDMI bridge, but return the
connector state's color_format member unchanged otherwise.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Daniel Stone <daniel@fooishbar.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index cafa498c3848..92f8a2d7aab4 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -283,6 +283,29 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
 	return conn_state;
 }
 
+static enum drm_connector_color_format
+drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(conn_state->connector);
+
+	if (bridge_connector->bridge_hdmi) {
+		switch (conn_state->hdmi.output_format) {
+		default:
+		case DRM_OUTPUT_COLOR_FORMAT_RGB444:
+			return DRM_CONNECTOR_COLOR_FORMAT_RGB444;
+		case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+			return DRM_CONNECTOR_COLOR_FORMAT_YCBCR444;
+		case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+			return DRM_CONNECTOR_COLOR_FORMAT_YCBCR422;
+		case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+			return DRM_CONNECTOR_COLOR_FORMAT_YCBCR420;
+		}
+	}
+
+	return conn_state->color_format;
+}
+
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.detect = drm_bridge_connector_detect,
 	.force = drm_bridge_connector_force,
@@ -292,6 +315,7 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.debugfs_init = drm_bridge_connector_debugfs_init,
 	.oob_hotplug_event = drm_bridge_connector_oob_hotplug_event,
+	.color_format = drm_bridge_connector_color_format,
 };
 
 /* -----------------------------------------------------------------------------

-- 
2.54.0

