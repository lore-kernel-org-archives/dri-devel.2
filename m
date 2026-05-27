Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E30CD6E44
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5390910E577;
	Wed, 27 May 2026 14:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NpMQINqA";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726D110E577
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779890657; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=M8F1sdcbJbf/vecjv1zzss/k+/5xHAOrmTruPamgSum6WfFS49oR0CG11w6wtVvkaFyMddF38nKKGlY/TuCqisJFBWeQzrVoe/mid0PZSrRhYSq2IAw1+55/bUVCIxa8a0viSHiu+BIF9jlChrzmuI/SRPp4ySy80FxdedmkK5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779890657;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cdWc2b35HtrgVA2bHer/iyZW49LqV21zJlNgFyYKm0Q=; 
 b=Q79kX/q0JUO7jKTZ00OaKHKjCsnuiZ1FSIMJjxrIgigzmQX470LPREjKNqpnhPzZGWcFGzlNBYJ22R06zXxxgnd/ZZWeuASA9RoTS4D9VGnZYg1atpuxhL3OSARbpoGz5y4bd+BrYa//UALq4pbfYUQFJO3MNMsoKfBheB9dJ2c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779890657; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=cdWc2b35HtrgVA2bHer/iyZW49LqV21zJlNgFyYKm0Q=;
 b=NpMQINqApHj+XFn7ZrailxQhd1kzwR97bwlobiPJzvl60tHBbr75UwSsOYmLLfkB
 gjaRlYKuNkvkjmF8LPC4ILtlbJqofp4k3vKq37eZlBdOci7+Gd22zYL/FK6zt5RcOyf
 wry+uXj1d2ai5432UaXH8PYDTJ+ydAvsvAz2lWCo=
Received: by mx.zohomail.com with SMTPS id 1779890655211788.1463576857487;
 Wed, 27 May 2026 07:04:15 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 27 May 2026 16:03:44 +0200
Subject: [PATCH v4 3/4] drm/display: bridge_connector: init scdc debugfs
 for HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-scdc-link-health-v4-3-622ea40a1f59@collabora.com>
References: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
In-Reply-To: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Daniel Stone <daniels@collabora.com>
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

Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 649969fca141..8c2c890bd95d 100644
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
2.54.0

