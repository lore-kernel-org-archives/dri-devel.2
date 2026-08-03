Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9FAC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604EB10E079;
	Mon,  3 Aug 2026 18:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gDjEx4Dy";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739C910E712
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785780304;
 bh=UZcqrNKsjBQlMpMlDsv9U742mbV7pUWdVK538ZAWK+8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gDjEx4Dyc0RMF/uA/v+WjryvAbuRCnACbo9/jc9k7co2bWI8FHtXL4Fx96/vRAjK1
 +6a1Wtx0cvox5Z/2qUZP3hJGXFtO0pLWpIB4OxxfqJNDZWbrZVNLuBlf+j0cDko6Qy
 G8n9bjdqKXPOLX2gO4vlUq/Yeeo2Aim4EinT1Ok3w8VtNy0qZwPgRHQwKBikhynM7r
 S9b05vlWjMgDJRFQ27HVoibCidWdiIA0Nr5TslkjZCK9vTmvSMPKnOVBq7TSfaWiCW
 CQW/ssnqz/0703how41LYtVRsBUQpfFV+NhNy6EDUZ5uQlNJhT93zJAQbPIDw29mF2
 znZP3vYgA6a5g==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 82C0817E1249;
 Mon, 03 Aug 2026 20:05:04 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 7AF34480064; Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 03 Aug 2026 20:05:19 +0200
Subject: [PATCH v9 18/22] drm/bridge: synopsys: dw-dp: Drop useless
 reservation of first slot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-synopsys-dw-dp-improvements-v9-18-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
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
 bh=UZcqrNKsjBQlMpMlDsv9U742mbV7pUWdVK538ZAWK+8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpw2E8dd5JkKutzGxCcJHMtoE48rpgglTY14
 V8gZBr8n5mGkokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqcNhPAAoJENju1/PI
 O/qaNQUP/3zZ6GwcxV/wZqkxZuqU826U5aORfooZroHqJzPY9U6nkpXZgLN5XPYpKh0c5wdIqWE
 JzhRpPSAs3hlg2JfhuvUG5N9PThC4sp9I+4BsxvjH9vnR3vij9E5ItfqqVLY0kfn5EWrEle5t0e
 k/yeS29l8Cim/Pk8iDvl4feisZ1aN3nfb02blb05sI7pcwydLNPJDzviVVd/nKTSXkT4U+t19zi
 FRMJg699V3QTIy15Xp+kDIfiap/P3WBBd5A5flE5ZdPpYucfgFKoNekkbZtSB9JlJBo3wbZ4faL
 MxHUT7+XEqYdTa2CM0o81Tel0ZB1XKpcjljr5Y/o8YuPLty1Mnd5LtVzkz1jE0mawXkpo05vGYU
 Lc+fZl3uJlZ1ooRSe7/K0jHu5K8yFNUad8XefLsIjDNKc8EN1lWWxU94a8+MsKAWTJA/8+leG44
 bP8oM0OFp92fJ2iNYFadamrho9E3MLi3Z/20o7NbEK3PIiiv7Hz0Bu0R27JvO00UiBcAxHfCGRr
 6dXdV+z4DEn4xKB18V0mEYnBoA0ebTZqo4jK4FQNoLfcn3C628iueDnNbrOi7YmYq4Ud2T+1oqO
 H1cX5j+0aQYSKOTofql9znCnsufZOzpR3SFNx0dlbhONmPraPsQBj5T0CWRuysaSV6S7lvMS73S
 C6sinmmQKN0H15WBohSs5+A==
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
index 19b6c11f672f..05d3485a4d8d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1706,9 +1706,6 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
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

