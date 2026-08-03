Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BF2C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6F510E6C0;
	Mon,  3 Aug 2026 14:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="mCzUfzZR";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78D110E6C9
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785769001; x=1786028201;
 bh=gqaBtFR4Z/07WCeHUHqgkYtBAsl6+84WQQkcCa8NAxM=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mCzUfzZRHUtKvG8MGDy2T/LdSRzsBKMjObqByztZlE3ogB3Wx2mzq+dIVqGScY+lf
 XCc1oHQuNAdGqvhLKHfFG50BSLsg4UmXCemip/AyscEcPfD2kBVPwzcWW3cvURed7N
 aPvqL3Ssfk9/I2FKzrt+R6rJP2qeUkUDUC8/feAULgo+HZzj3OPnyZOfD1PVpNoK1Y
 bVKqSmandYv83a1xhWjM4arcG+x2Jk7yJwsB/K+/1mTxUBG1U1FoMZuCjXFGeIdApw
 V1DEBuKKUZncgHdo63ZA+Bq1iNQL63P/868nUNLmbBJ9k437j1Zpi9IseKZAIOGEz+
 fTWaTTHfUk7Qw==
X-Pm-Submission-Id: 4hDKWW2yHkz1DFF7
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 03 Aug 2026 16:56:22 +0200
Subject: [PATCH v2 4/4] drm/bridge: nwl-dsi: Add error handling of
 nwl_dsi_mode_set()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-nwl-dsi-fixes-v2-4-1809a0ac453f@geanix.com>
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
In-Reply-To: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785768991; l=804;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=On7LASVbhL6jAPGUOgbfKiflmxrZf2uOOjxZiGuazcg=;
 b=bBSFj2fIUxpX/hUBTlFhuTuzRP8ObVz6qasMPI7UNewX2FWMzYF1tOeEclgNiLPGY1JNgb5tY
 hSw0QXMeWG3CQo8JE3QZpJKYJnRP6IvoUCU07p0Hr7emeToOoC//Kb6
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

There does not seem to be any good reasons for ignoring the return value of
the nwl_dsi_mode_set() function.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 226036d22e3f..08e87d166b17 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -942,7 +942,9 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	}
 
 	/* Step 2 from DSI reset-out instructions */
-	nwl_dsi_mode_set(dsi);
+	ret = nwl_dsi_mode_set(dsi);
+	if (ret < 0)
+		goto runtime_put;
 
 	/* Step 3 from DSI reset-out instructions */
 	ret = reset_control_deassert(dsi->rst_esc);

-- 
2.55.0

