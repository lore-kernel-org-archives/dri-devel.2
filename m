Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E2EC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 22:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571CA10F9B3;
	Fri,  3 Jul 2026 22:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ItEbTnXH";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C1A10F9B3
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 22:41:47 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD5FB212;
 Sat,  4 Jul 2026 00:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783118458;
 bh=MXgioVjhaDB5LL8Y1AOcJ4tCIFGDl1eIOQUDrRz4jus=;
 h=From:To:Cc:Subject:Date:From;
 b=ItEbTnXH0ghdTdwz0DLxMsNE4bcDV6QsvBMu8rnhBCAc063p4EL5E5gp+a/2cx1x8
 g0jJNtYupXLLiHz9WMfN1+PIxpG8ViMzz3+Z+yNMuadOcmYsPHaMoxQhQ7s676eghU
 V/zenuTPeVYAjJOra0+MZ3clJe3X3y1psEPjFNgU=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/bridge: Replace outdated forward declaration
Date: Sat,  4 Jul 2026 01:41:43 +0300
Message-ID: <20260703224143.3886069-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The drm_bridge.h header forward-declares struct edid, whose last usage
in the file was removed in commit 27b8f91c08d9 ("drm/bridge: remove
->get_edid callback"). Commit 11f6c4b1b259 ("drm/bridge: Add
connector-related bridge operations and data") then introduced usage of
struct drm_edid, without a corresponding forward declaration. Fix those
two issues by replacing the struct edid forward declaration with struct
drm_edid.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/drm/drm_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 18f3db367dc1..5c9741df02b5 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -40,9 +40,9 @@ struct drm_bridge;
 struct drm_bridge_timings;
 struct drm_connector;
 struct drm_display_info;
+struct drm_edid;
 struct drm_minor;
 struct drm_panel;
-struct edid;
 struct hdmi_codec_daifmt;
 struct hdmi_codec_params;
 struct i2c_adapter;

base-commit: 44d19b8a7548aa25cbc6ebd5f27e958f7142c36b
-- 
Regards,

Laurent Pinchart

