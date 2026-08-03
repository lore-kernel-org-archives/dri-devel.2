Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD855C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6BA10E741;
	Mon,  3 Aug 2026 18:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Rnnvvk+y";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C2510E644
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785780304;
 bh=+hvcTuzTih5vFZbymQZbCa4pv4dlmw/yOyTygYkYfXw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Rnnvvk+y3ZEPNKGORxSUGqsg+mNaM9ua+oPmZXjTDX25nKW4ZrgKL8Id44CQgPeHd
 dgf1MDIyR5EeSgciebeVwtJcOAYxVp1bPzQdMLnZZpf+e6dxk2rjTJzmQDVKP6fexk
 ZzX4rtp67mur4VMN8fbrVlCnyKqeHLZwH6JYxiVr7N3cggCCFyqgX827oO5smSpPzs
 5IEyqySgMeukcoOhnLsD2CsDwvqo79mkqUSKRuPNvDqatHOi7kQD54fN7YFYf8F9oF
 qrVuydhCTdkZac/DDPPeYCPgrwiWT+XOStGalRkexz7pDm0CDIHUewQOOqVkP+4WeO
 6K2XG9c9MD1qg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 26D2117E10C0;
 Mon, 03 Aug 2026 20:05:04 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 6BE5748003A; Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 03 Aug 2026 20:05:09 +0200
Subject: [PATCH v9 08/22] drm/bridge: synopsys: dw-dp: Fix support for
 short I2C reads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-synopsys-dw-dp-improvements-v9-8-2e6e46135312@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=+hvcTuzTih5vFZbymQZbCa4pv4dlmw/yOyTygYkYfXw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpw2E4HoUBLboib/7pf45ZjmJMYsf9lGaA5k
 MEBu37ptA23aYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqcNhOAAoJENju1/PI
 O/qafVIP/i0EYv84rNRDGB2pCStUpY6g7dRwEFWxpysmcS5LJT9JlNgdro7n9hnfkPfb9s6d9xq
 u578ReQLD9ALqlP3eZJ40BNhpsttHkGd5JwdrReFpagivYXj/YUqBuyLB9BHK6/cqvRgQj7hAmO
 /Mj1NnRh0OYaUNxXb6r1yB2HkCNgcRThYTJDQ/30RxxaJOk4FcuIwKUg+yu9xpxO7pRrWGai9/B
 NX8azki7+v7KaSz5I8IFx3cbGEfbTR2dN/050CvJK1Ke+F/eUTXgRoMriDQSjPhs8XyFb/LL5h2
 0AOO4ZJrqgYc2WOOfUgQAlhJfSeAvQQCktQB6paFggZ31CwslyAl+4rl+96a6ge3GFQ3HOdhqHq
 o9F67I6RhzGfmf/EQyuelWysXOw+04DOybo+riXGxjAduL9dQR19HkDlOd+iUTXFbLBWnveFavt
 PVPJ+1nuXV45uMJ2iWbOQdn1Ky9XTHLN0/ljyq+e8yIMaZIkc8B7LAyh6HenY5oFgrTG41Z/1ST
 XhooYxMaL6cqsU//gYkROd70I4AYvk6Xx/hpDtmtQQ+dtUKvpZRg4als8LJZ5EF8CR3cxv0CoC5
 JIsymxjN/uxQC0+I3dR1GgxR2TUCxyXByzAfrvXZe9WkRV5r2g1ynmQJ13n5HeFHvBX8W4WX2yP
 +OOk8YazaXyw2nqh+mHsq1g==
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

The transfer functions returns the amount of bytes read for
DP_AUX_I2C_READ. By returning -EBUSY for short reads, the caller has
less information available what is going wrong and possibly simply
resends the read request. On sinks not supporting long reads, this will
simply run into the same issue again.

Instead it makes more sense to return the data from the short read with
the length information, which allows drm_dp_i2c_do_msg() to read data in
smaller chunks and succeed in the end.

Due to lack of a sink, which only supports short reads, this change is
effectively untested.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 8b587a4c5e93..22a244de08aa 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1513,7 +1513,7 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 		if (msg->request & DP_AUX_I2C_READ) {
 			size_t count = FIELD_GET(AUX_BYTES_READ, value) - 1;
 
-			if (count != msg->size)
+			if (!count || count > msg->size)
 				return -EBUSY;
 
 			ret = dw_dp_aux_read_data(dp, msg->buffer, count);

-- 
2.53.0

