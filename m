Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFD9CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BDA10E42A;
	Wed, 20 May 2026 13:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="g+GXuS6+";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A80710E42A
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779284144; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mjKRpx7MDQTmWeemjxalGsVQTQo5hYR/SfF0tKWxg7FoEIvQURsjziGSStSPtm0SGSMQlocOziVGEPeLFtMUxNU+BWD49DDUIEUau5rw4Rrut6va6wW5F8wyYvNOtoMjGw8+j4soaaW8Ltcsk9jI2hUOpcYqa/ZxQrUqFJM/Yrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779284144;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5WJqoKD0/rlbWLk1M3RnI2w0Q4nYAEZ0gDBgKgmKzK0=; 
 b=WR/HrRWVIlIP8PRiD6xBZMgmRPEBdpihjGHZT4+l+0wSER+LaIkCOCRr3Oes2g4qmkR3dhwQ5BAtQEJAXvxSKtdh/XbfADz/HOk4yCGlffOOi0dMfwLFRtDNj+pnHc1EBMXo/0vSkVdeYYUgMt8qdUND/c5aRovG5U88v7Khro8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779284144; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5WJqoKD0/rlbWLk1M3RnI2w0Q4nYAEZ0gDBgKgmKzK0=;
 b=g+GXuS6+/UUuof9YqgYR14RvQznSvbF05/PvANOvp5t9cuy0lXVo+0kCTrBjzI0M
 t4yqwV85SxxizRktKjdHuSR6FTo6vPIrCj/KyaH3Yaq+cDO1DKXSsNZJ3sdlGPfZB1Z
 x8HoXW/UNgGMMUWIARsIEjoBO9furHOFcQZ4gFwg=
Received: by mx.zohomail.com with SMTPS id 1779284141955445.44461628665726;
 Wed, 20 May 2026 06:35:41 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 20 May 2026 15:35:15 +0200
Subject: [PATCH v2 2/3] drm/display: bridge_connector: init scdc debugfs
 for HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-scdc-link-health-v2-2-511af18cd64b@collabora.com>
References: <20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com>
In-Reply-To: <20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

