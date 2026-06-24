Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0009CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E3710E08D;
	Wed, 24 Jun 2026 12:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iMZXbMQN";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D6D10E073
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=6a0olgK9BTHPsI9Eg8bVXJes/tJiB3EzHgIqw4LFu5g=; b=iMZXbMQN2yFI3sIOjtY87XnMh6
 6B6r/xy5of7JaUzejRQbdL2DiIP++VPpdFGvhC8KLUtBNksFoxRJOpjL5yB4tKusd5jLXuhmGYnjk
 LBfx1IKy5F0Wsu5dwBQJYdcTa/ZyTO/UcUDgnUw0K4mItR+HInm9G2FxDL8BtA48k7N3iX2e5T2bA
 4kT5BzpU8UoC/WV4OP0G9L02EmeHlQyQRXs8Wt7AHKhzVP6xwQp9xX69tcdxrDzLyxzEt2ot14wNe
 bdPJTxrjBfPgX8ayMHUmL+iz4z5mzPOgfdyy8jzvJzHZIi1v6LFyWR6RbF1yRhO5uvB1Z4YYtPpJm
 3hslpR4Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wcMVi-000Ofa-2h; Wed, 24 Jun 2026 14:15:18 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wcMVi-0003Nl-1a; Wed, 24 Jun 2026 14:15:18 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/bridge: tc358767: register DP aux bus even in
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Date: Wed, 24 Jun 2026 14:15:11 +0200
Message-ID: <20260624121515.2301219-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28041/Wed Jun 24 08:24:54 2026)
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

Even if DRM_BRIDGE_ATTACH_NO_CONNECTOR is set the DP aux bus has to be
registered. Move the flags check after registration.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7188935fdb826..a1663cc6c2236 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1833,14 +1833,14 @@ static int tc_edp_bridge_attach(struct drm_bridge *bridge,
 			return ret;
 	}
 
-	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
-		return 0;
-
 	tc->aux.drm_dev = drm;
 	ret = drm_dp_aux_register(&tc->aux);
 	if (ret < 0)
 		return ret;
 
+	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+		return 0;
+
 	/* Create DP/eDP connector */
 	drm_connector_helper_add(&tc->connector, &tc_connector_helper_funcs);
 	ret = drm_connector_init(drm, &tc->connector, &tc_connector_funcs, tc->bridge.type);
-- 
2.54.0

