Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340FEC56203
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0457C10F066;
	Thu,  6 Aug 2026 00:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nR3fWOYP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4482310F066
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785977188;
 bh=evmVzWSmkMNe11q/nd1T6eZIDF68HR1dZx3DTB4BQwA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=nR3fWOYP8JmhzPqpY2p9KAi/8cCBBskSykgUGM21zrqtoRShqsXVhy9dbxgmb0Lo+
 UCeH7nG/PK6Am5p/Qtf/GxwbryBVLE+5ZXjyS0TF2ZXNwOepDq3rerl1GMN6ok1EEq
 LhHDlhYtoUuyRq2vCU0tNbGRJEtYMrJLhJaqEEEKhlbNNfGqPfLAao8otTCMPzUWNs
 cUwJG634yCW/6+0ANNYvlZig0rDDcWRlacd/R5cjtd3rK/8I1ycT9a+KpFxwebjhVn
 IBw8xoK/6HCHSKfAN/3BC0xK43Qf6ua8I+m9zCPAAKrORGpLAMt986e7Z5F90Tc6Ml
 5up9DwwjNSYCg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BE3D17E075D;
 Thu, 06 Aug 2026 02:46:28 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id A1005480064; Thu, 06 Aug 2026 02:39:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 02:39:24 +0200
Subject: [PATCH v10 18/21] drm/bridge: synopsys: dw-dp: Clear only enabled
 SDPs on atomic disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v10-18-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=evmVzWSmkMNe11q/nd1T6eZIDF68HR1dZx3DTB4BQwA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpz1651f5GFzi7tbG0ij9UawtlVcYuwUkTjU
 jPRQjqO83tCU4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqc9euAAoJENju1/PI
 O/qaY5IP/A3Aqr8ezypgIi8N3zCYHRywRMuOuZjrF8xT4BHuktmrAkkj1/90sqlaUxzK8mc33rF
 SXksu2aBXDg7lAPDGmWJ+q51mve7IEXagbc+ceD/6H7iCmn2FG0xf6OWvjM08KLYvWf1Dn7zb/g
 //eswcUI5VvbotKlDprYNrQhDS0Ewxk6JnprMaXUEV+heZvSeSbUm2kOw1wfxUzj+49g/N81etV
 jcl2WaCUqX0DiU+Am7Dmd599icEw7nPNDKkK7lCt8V7cqNzB/DCUTzfjba50bnI30ZcR+KeEiUK
 a1mnD7ESH5q7VaSMuaLSFWfVIiN6EfaSr3JvGHcYyXTj3jpZMvEdVUmFwwshXLi8p6dNn6qYF4d
 +L49GA3fexLzPNr508a+A0uU2fOWAzK8m4c4KzJRZOzkwX8ZGSTMZsK4mmR47WAJMmXKwy0+4rB
 Y82yQ7aVraRbNUIkcnH17/3IKEOist//j3J9Dk4ahb9LBXhRHGyhiTipb9NBPNKIFqDN6vHVEYy
 2nS6TfAVSYP7foyZH7GJKs+0apWR5kfyQ3M7p6flmZ87BCdueMu5i6qGnkTcHqNH86PD6aZnDp2
 GaJr0BdaMUKIiZx0aGcxg12aH6bkuxLPtQwG5ReS/BXWEtkSDfLwQydUQWxce7GcUSFsLeBAvuz
 09u52Ix8/J0pkUO1wm3orvw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

dw_dp_bridge_atomic_disable() bulk-cleared the whole SDP register bank
allocation bitmap via bitmap_zero() resulting in the loss of all
tracking information. This results in a slot potentially being handed
out again by dw_dp_send_sdp(), which is still considered to be held
by the previous owner. Then the previous owner might free up the wrong
SDP later on.

Instead of bulk clearing the tracking information, the new
implementation only clears the SDPs actually configured during
dw_dp_bridge_atomic_enable() instead of the entire bank. The
introduced functionality for that will also be used by the to-be-added
audio infrastructure.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 425bfcd3a37d..2883922af969 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -337,6 +337,7 @@ struct dw_dp {
 
 	struct drm_bridge *next_bridge;
 
+	int vsc_sdp_nr;
 	DECLARE_BITMAP(sdp_reg_bank, SDP_REG_BANK_SIZE);
 };
 
@@ -1078,7 +1079,19 @@ static int dw_dp_send_sdp(struct dw_dp *dp, struct dw_dp_sdp *sdp)
 				   EN_HORIZONTAL_SDP << nr,
 				   EN_HORIZONTAL_SDP << nr);
 
-	return 0;
+	return nr;
+}
+
+static void dw_dp_clear_sdp(struct dw_dp *dp, int nr)
+{
+	regmap_clear_bits(dp->regmap, DW_DP_SDP_VERTICAL_CTRL,
+			  EN_VERTICAL_SDP << nr);
+
+	regmap_clear_bits(dp->regmap, DW_DP_SDP_HORIZONTAL_CTRL,
+			  EN_HORIZONTAL_SDP << nr);
+
+	scoped_guard(mutex, &dp->sdp_lock)
+		clear_bit(nr, dp->sdp_reg_bank);
 }
 
 static int dw_dp_send_vsc_sdp(struct dw_dp *dp)
@@ -1396,7 +1409,7 @@ static int dw_dp_video_enable(struct dw_dp *dp)
 			   FIELD_PREP(VIDEO_STREAM_ENABLE, 1));
 
 	if (dw_dp_video_need_vsc_sdp(dp))
-		dw_dp_send_vsc_sdp(dp);
+		dp->vsc_sdp_nr = dw_dp_send_vsc_sdp(dp);
 
 	return 0;
 }
@@ -1754,8 +1767,12 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 
 	dw_dp_video_disable(dp);
 	dw_dp_link_disable(dp);
-	scoped_guard(mutex, &dp->sdp_lock)
-		bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
+
+	if (dp->vsc_sdp_nr >= 0) {
+		dw_dp_clear_sdp(dp, dp->vsc_sdp_nr);
+		dp->vsc_sdp_nr = -1;
+	}
+
 	dw_dp_reset(dp);
 	pm_runtime_put_autosuspend(dp->dev);
 }
@@ -2341,6 +2358,8 @@ int dw_dp_probe(struct dw_dp *dp)
 	if (ret)
 		return ret;
 
+	dp->vsc_sdp_nr = -1;
+
 	bridge = &dp->bridge;
 	bridge->of_node = dev->of_node;
 	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;

-- 
2.53.0

