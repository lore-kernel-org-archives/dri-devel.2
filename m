Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB69FCDB471
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7EC10E033;
	Wed, 24 Jun 2026 12:15:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EP2/iL96";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DF210E08D
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NFSbDBYaQRiLzxAE88i5T68DnsPfuFAkWjSH6Y4PEsk=; b=EP2/iL96KvL7nj09fzhQRQTkQi
 kmcCe5AUByzzQO8+VobZuEKfz4svklk2CIdR3mQqd0dc8Oz7VK0jRbajvmoWCzWQA7ipSvjl+w/2x
 82lsWlAiZZ7qfV1OJoKedW/2IuyLvoW/3MguXXvIfa1BSAtybHg97iitxl+u5TvksIX6zKe6XXazn
 aCvQeC3WmYCbm57AmTMoEli5unYF3kBzS/nXIJ+YAzqSX2QUOfjSjKv6zVHo0sU437tXNKVtCp2sr
 3c892Xg8VfF6F4s8z2AIXJfQyH/h7ubZG2btUyPqTWZM0A6qy6JNfsF1yMPFHxbnVYuqg1I9JaFwR
 Njir2O8Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wcMVj-000Ofb-0o; Wed, 24 Jun 2026 14:15:19 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wcMVi-0003Nl-33; Wed, 24 Jun 2026 14:15:18 +0200
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
Subject: [PATCH 2/4] drm/bridge: tc358767: allow panels or bridges
 (connectors) on output
Date: Wed, 24 Jun 2026 14:15:12 +0200
Message-ID: <20260624121515.2301219-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624121515.2301219-1-alexander.stein@ew.tq-group.com>
References: <20260624121515.2301219-1-alexander.stein@ew.tq-group.com>
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

With DRM_BRIDGE_ATTACH_NO_CONNECTOR becoming more common, explicit
connectors (bridges on its own) are necessary. Allow specifying bridges
on the output endpoint.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index a1663cc6c2236..2e705bd0d6be5 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2346,11 +2346,12 @@ static int tc_probe_dpi_bridge_endpoint(struct tc_data *tc)
 static int tc_probe_edp_bridge_endpoint(struct tc_data *tc)
 {
 	struct device *dev = tc->dev;
+	struct drm_bridge *bridge;
 	struct drm_panel *panel;
 	int ret;
 
 	/* port@2 is the output port */
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, NULL);
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, &bridge);
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret,
 				     "Could not find DSI panel or bridge\n");
-- 
2.54.0

