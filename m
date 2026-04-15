Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2323AF4384E
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8078B10E713;
	Wed, 15 Apr 2026 15:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="h8hcNuL3";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A64A10E13C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776268645; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mwE8iNk6gtDB4AlWGBN6Htnxg3LPmm4UzkJXhYTPGHrg06S75+JuwsM22HJ3jI2kZjCDtsa9CbWlQGmkJotjr7rZdlp5Ri8n6V9FtQHteUbBqg2ehufAez7d10gS+VG/J08yFYNiU2zLL9zmVM3u/2Fi6CnNjylWk1+p3XlPU54=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776268645;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hT6jDzcZAvBjtlDBMTEBSx7DyEPgkDHN7zKQrynwvQI=; 
 b=ADa7fF9e174tg2p/CylKdk2NMlhydxH5Qr0tkeDFHtZC96j8FmlL6300SxrP5ATcb1NmNQouc4qMPRDnNLm3l4vMUeeEVQNEdyPC/78rJCMYJnk33ZlEoDL5StVAZICjxZ6DPJuu/ileZn0RoJgaTYMX9QKU1sklHLh5mFFXBW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776268644; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=hT6jDzcZAvBjtlDBMTEBSx7DyEPgkDHN7zKQrynwvQI=;
 b=h8hcNuL3MR9IF+XnEDjfQlfXRYEv6FHhanKQ3fv8F5Ax9TIdgNO6LYs0R/qXvf53
 iPDrcXf0/CL27A3icxrJnzFhA6LutgzN0lbyHDkVWx4Y84F9uOIWlHGsbQQ2b3AjQ6z
 zaggho0UGLWcJ/ahquIl5YfydBg5f6kKR/tu4qUM=
Received: by mx.zohomail.com with SMTPS id 1776268642340129.5645777003166;
 Wed, 15 Apr 2026 08:57:22 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 15 Apr 2026 17:56:43 +0200
Subject: [PATCH 2/2] drm/display: bridge_connector: init scdc debugfs for HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-scdc-link-health-v1-2-8e731e88eaf0@collabora.com>
References: <20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com>
In-Reply-To: <20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
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

On drm_bridge_connectors that contain an HDMI bridge, initialise the
SCDC debugfs entry under the connector's debugfs root.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 39cc18f78eda..3e4e6bead321 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -25,6 +25,7 @@
 #include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
+#include <drm/display/drm_scdc_helper.h>
 
 /**
  * DOC: overview
@@ -263,6 +264,9 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 		if (bridge->funcs->debugfs_init)
 			bridge->funcs->debugfs_init(bridge, root);
 	}
+
+	if (bridge_connector->bridge_hdmi)
+		drm_scdc_debugfs_init(connector, root);
 }
 
 static void drm_bridge_connector_reset(struct drm_connector *connector)

-- 
2.53.0

