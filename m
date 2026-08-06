Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD99C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981C610F05B;
	Thu,  6 Aug 2026 00:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MSxKjM+Z";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1705410F05B
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785977188;
 bh=PLIm9h3gU4IggjgGaEHpfMBzz245EqybIu7YjjboNDo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MSxKjM+Zj8f6fX5Mn4ekbP5WyFd7LifwnVoOy1wZLoqkXrCWJopTinNIVXhFReSLQ
 PJVUZWx4tXinacyU7NYN0L7I1Pc4MPh2t0UiSZw2rPrPRlW7j42l8XCgkq4TUnRy88
 6c9G5DnRt8a4XW42gE5SpRgrRBUXk0t5vwx6MpGBAzjZ5kgevTcp+Us92wIRSPceC5
 LtERCjv+pcIMjCU1KAipuyRTPmaUXtbgH3yixBFT0sZ9RTs9GcuzkIJiOEtOZyMJzg
 PX4trX7oJzBYGgZKSgHrtIeoUqLDFb3HSRJ0VugZfbV0obGhOKDGU3r1i89q5C2sFa
 p5VMbB3a8W6ag==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 69FF217E0739;
 Thu, 06 Aug 2026 02:46:28 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9F889480062; Thu, 06 Aug 2026 02:39:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 02:39:23 +0200
Subject: [PATCH v10 17/21] drm/bridge: synopsys: dw-dp: Drop useless
 reservation of first slot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v10-17-d84a26c303d6@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=PLIm9h3gU4IggjgGaEHpfMBzz245EqybIu7YjjboNDo=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpz165fHEm38M1E4PGMvPdA5LMMZG45yzMr4
 UNc8Lgzt2ywr4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqc9euAAoJENju1/PI
 O/qaEsUP/jNVsxtUZOdin7EbfNqYp6bck6y7Hii2pXq9dghhqfUiFIiWzb+nHX/Es/sK6pvxou5
 f/u9yDjbCb+OdcdQhr8OGT1vq0VSOPGc9k6sHE8/vnUbbH+pHJaUy8JZvKuIGh0+dNTtE5d9AAN
 o/iVzwZhJdBQOqNGSCQoX3wCd7Fe7dNoavQ706FrIG4g5qQ2yB725377aokFU8u+ChGau4BJ010
 O1nMLY8Deer2W7ykFp8LNGVbxCmR1RSfjaULqWvIDO7iPvPujAco3pbrD+q+a2NH31WZkyp57n+
 x7YLOU47zu2D3dT7UuG78rvDV9iI60HywtjkYRBwU5bAHKRtkkAI07Nc0YRm48OQ2kkpZ5o2rp+
 NDVS4y97/Ad3AVrX0K6qWuABLSKn3oJ0jdSdZHdNYMTEDEcMnUpyjtKityQwuK2MUeL2XpV52qX
 zloMziO5r6InSXFfWY+da5e/UAG3k8khtWBiM/eYIw7IbFihr322tknqS2sLiUolagCUrOxO7j3
 7+Rdm2NZImiwXDiJYVNp0J1dM1aZbMgaDaZHYuJj3DKTvmmW+xNwZFMV2tO2Ul2HY07xqjx2CX/
 +93hSi/LTLftp1uUe2Tft/8OeWufniUqqbdm3FlT01HxYWeGtp9Vf5i0p8cDIsd5wkSsLqAdVim
 LbPM9tjJ/o3udjHN8cUg7Qg==
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

The origin of this reservation is unclear, but it is a problem in the
atomic_enable code since it potentially races with the audio SDP
reservation once that feature is added. I suppose it was either meant to
be bitmap_zero(), but that is obviously not needed (and would also be a
problem for audio support) or some left-over development code before the
VSC SDP slot was allocated automatically.

From my tests SDP slot 0 works fine and can be used. If SDP slot 0
really needs to be reserved for some reason, the bit should be set in
the probe function to ensure there are no race conditions.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index a63fe1fc0969..425bfcd3a37d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1712,9 +1712,6 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 	}
 
-	scoped_guard(mutex, &dp->sdp_lock)
-		set_bit(0, dp->sdp_reg_bank);
-
 	ret = dw_dp_link_enable(dp);
 	if (ret < 0) {
 		dev_err(dp->dev, "failed to enable link: %d\n", ret);

-- 
2.53.0

