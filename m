Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BB7C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0380610E825;
	Tue, 21 Jul 2026 09:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="QvjU3XmR";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D829710E825
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784624390; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AlU7C9LdltHDScoWwHC3X29nceXJykOp1oOepH0s87+6lXv7feVxAaEktUUhrDFRt7C5qu0RRqzCeGtqTPxCUbv3TXYmL5I5KG36hpUeOe2XIRpcvSAg6oyfYLZibKWUAd1xsPjD3CnWlSme5wqSgEgvJ5hIKurezdaYwXtA+qo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784624390;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zBRro5DpsPG3sefzb4EIOocwUtzmV8Fv8o5jqwZE2+k=; 
 b=J856QT2c4kybeeFOHMQ1OX4V56MkFHJ4m5rtBe0RiP1LkQTXFcMxsH3mHrUK16Ui80aUztUMsvo/ysnreLqJPA7iLyMHfB+Nd37tn6W0SgttUBWCtWTAQ2C22GwXva8c1W9Ygr+mMEWCnRgLmFEyWaTTK9KWpTSMFZK1xAdDcRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784624390; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=zBRro5DpsPG3sefzb4EIOocwUtzmV8Fv8o5jqwZE2+k=;
 b=QvjU3XmREttb3ymnkVCFdjT06w+BihipttIUINDEtaHrXThKIn8CXwj7kvaDH4DO
 FExngn5ztIsoCl/7e/qxNP6tNZts7ZJOvuuWW8+2Uc+nIxFAf0wbGjRjQnom2hpwaJI
 /Ww26Loy6BIbBzd+co6Fny4NNCQK54UAVevvujoA=
Received: by mx.zohomail.com with SMTPS id 1784624389622433.39379483803657;
 Tue, 21 Jul 2026 01:59:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 21 Jul 2026 10:59:01 +0200
Subject: [PATCH v7 5/5] drm/display: hdmi-state-helper: Init SCDC debugfs
 for HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-scdc-link-health-v7-5-92df1b6ad5fc@collabora.com>
References: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
In-Reply-To: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
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
 Hans Verkuil <hverkuil+cisco@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
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

Initialise the SCDC debugfs file for connectors that call the HDMI state
helper's debugfs_init helper. This makes all connectors that use the
helper expose the scdc_status file in their connector debugfs.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 8d5ee10ceb87..709524b40c26 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -13,6 +13,7 @@
 #include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
+#include <drm/display/drm_scdc_helper.h>
 
 /**
  * DOC: hdmi helpers
@@ -1116,6 +1117,7 @@ void drm_hdmi_connector_debugfs_init(struct drm_connector *connector,
 		return;
 
 	create_hdmi_infoframe_files(connector, dir);
+	drm_scdc_debugfs_init(connector, root);
 }
 EXPORT_SYMBOL(drm_hdmi_connector_debugfs_init);
 

-- 
2.55.0

