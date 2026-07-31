Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2617AC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C2010F2C5;
	Fri, 31 Jul 2026 14:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Xlgse8Ex";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3302C10F2C4
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785509219;
 bh=291eDcvGr6NzZPipwAOdXZWL9zpP+JQBfcKpB6JNiFY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Xlgse8ExsLItHJ7/ZngrwxVXDGDYnnN3aPuE8+O/mXWQWVMyLH2wKfx1Jw+ZiUgia
 Mqfvwc5ZQZtcJJ1yzciebtTE3043Fp8cymhs11fgnpaBBIn4Br2RkSmxGTgBD7Kup/
 3L88lXRySR0gBTrl9SCLGWy4mCpTsYIOP6CAPfgFIPpYzDOg3KUtlJh0WTQTpdqihB
 Gl9FWAgdsd/g6jmWAWtS4W4TZp9RXlXvP94WI0e7YMfWFJEwid8ky5lzsbFoKAGS8E
 9Oc6wZuiQXDn77X9ymRJbkcjo3LN7GHLMs8CXiTnPKZJDewUf/T1mTkQFIO4QjmBxv
 7sjVtNqk3mbtQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 998F417E06D8;
 Fri, 31 Jul 2026 16:46:59 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 15F50480062; Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 31 Jul 2026 16:42:22 +0200
Subject: [PATCH v8 17/21] drm/bridge: synopsys: dw-dp: Drop useless
 reservation of first slot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synopsys-dw-dp-improvements-v8-17-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
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
 bh=291eDcvGr6NzZPipwAOdXZWL9zpP+JQBfcKpB6JNiFY=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpstECRcF8yghVwi11OGpqkglQ2n0saSKxyA
 xu1ypbNo+tnSIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqbLRAAAoJENju1/PI
 O/qambgQAIpyTZjW/tGa2a6VBawOydNjwDFJ/IBENWuxp8P8xPn88zVcCgX643v/eFwGxTNOlo1
 V5yAx+WBtYiVPSpKFwQyMpoSvVnbdsRuQpqgjpS9UH0QFgaRLknB9KI+ZXbmwncG8lPHjT7BQsN
 7ZyrzRZzJ34ZW6a2xStQVSAjC7j7sIyOspilwJLb3JpX7HpAJ3Pu98e4E87B64QrPa4tkeSuXNg
 z1mxADA64qtAwjfKNjJLA9pmw6XSBoHN2qn7vBY5FF2H7+/57JmoIKpBl9jExrlDgqWxNJAab8/
 ekoQ69lVydYtV4yaO+6cVN8tBvensL/qcVy9noYbDSp8pVzCwVIXtXo4J7J1uxjnYNzjaMQU3GC
 99alH824bEJlJM3t2J+A2L/OEceNG4xd1FqWMNBAlL6obbMmrrwY+Xs5/uxAON+n48oP/3mCc9M
 oh7uVpPc5XO8/DeKmMWqfTN8jw6YOjoFLdxlHb7UVfFC74thC7ma7E5ZzJTF/eS8van3fOTkAkj
 qeUFy0arZg02pD+KaxSxLlu9VJNDJo9krf54de6ieZg5MplFTppUYC4dXWNJMIEUnBRt0VQ7NRn
 z6G9J1F5XPoqFeB60kkQSCiUJNxZzlAsBpTgYwElgmqM6b8iZmzCeEbGFCR2y507E0eIshiRcWW
 mJi8rOCMG0C7hzw5VB5kubA==
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
index 4d4af6a388b1..193816126e44 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1697,9 +1697,6 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
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

