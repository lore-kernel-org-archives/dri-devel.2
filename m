Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F62CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66B210E772;
	Thu, 11 Jun 2026 12:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="CVTEFQq6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D5610E772
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781182716; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CW6FMa2rvRcxaam8+V8C6uwnZhO/hbEiK2ZFq3P7FVctzt/PsnhuBkGj/tKQj/SyYvSBWeaylxGo2Px48VGNk0YfziYwRwkstOF1PWz+vUrT4I/46xbGBUkzakR0yVzuWwuibH9s+CSsFdgfvFGtoa1VndLi+fN41RrASnUaTZ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781182716;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=G6p3bR3EbKYaAGni7SnlEEMnAMIZEyJiafCNQAgRzpU=; 
 b=HO1/iPSngmIfltD6GPqR3dYlL8mP7nTc64rZm5+D4R5KNhyNZsyCw5gwbwRu0cuSZs2/5FKOmXtVXM2e93C3Zt52Ljo2KGCc+1G3wahWi171HuDqvcWoL96LBt+tLijykY+AiMQCmTNuhxJc3/pkXtY3ca1FLuuC/f7vk6p+5ws=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781182716; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=G6p3bR3EbKYaAGni7SnlEEMnAMIZEyJiafCNQAgRzpU=;
 b=CVTEFQq6E/G1KZEfYMUE37wBzgGv9r39js5E+edBiR9NRZNlmKLBYQEtZPFpSVD+
 tROp64Zxoz8CJTDQkl/YEGVqPPqy7PtjiGXsFKXWNqEw1zQ5Lt/aHU/E4bIAJ5hvJwI
 nxg1oujRpuUdYMeV5vzDsMIOqyR4sO1JyLFYxYQo=
Received: by mx.zohomail.com with SMTPS id 1781182715566534.2719904444058;
 Thu, 11 Jun 2026 05:58:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 11 Jun 2026 14:57:59 +0200
Subject: [PATCH v6 3/4] drm/display: bridge_connector: init scdc debugfs
 for HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-scdc-link-health-v6-3-6307875a6b5e@collabora.com>
References: <20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com>
In-Reply-To: <20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
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
index 92f8a2d7aab4..c081a4880317 100644
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
 
 static struct drm_connector_state *

-- 
2.54.0

