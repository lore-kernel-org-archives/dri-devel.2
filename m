Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2786C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F8F10E99B;
	Tue, 28 Jul 2026 17:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k2+kwQrR";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B63810E547
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785260446;
 bh=Sw0eBvl1Fm8R1WcMvoZrOtiF6wxkEL0dY1GQpPPGQ6I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k2+kwQrRU4hGifXPsYIwKUdcZsj2LpAHMhSfl/Rn1aIJ0tlAv+XH4ESHFqzSFLJhK
 A/YIYpwqzy1D05EPrQT9wfosHeNONslQMTKa0ObPT9F1dXOylLSQ6gs++txe77N6Ih
 ew0S02b0gAT//NpS/19SpWPsA+bm5g+7zOEnvo3OsbuHcq6Oem0FTJXNOZsQ2gcc1h
 F4OjArPdvIxRpYJ7ULCDCwW7Y8ukDnd36ZRD5AoOIA/+eTbcqlQQKxcqOl4eddeGus
 eKl2JLg3zV8tr+JVmu6YF33wg4sArWJdGDgqj3AyKMRUHbjXzSjB2w35MthhHAiRTy
 3uCifJymdW30w==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A9A017E0726;
 Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0F787480030; Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 28 Jul 2026 19:40:40 +0200
Subject: [PATCH v7 04/18] drm/bridge: synopsys: dw-dp: Add missing
 reinit_completion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-synopsys-dw-dp-improvements-v7-4-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Sw0eBvl1Fm8R1WcMvoZrOtiF6wxkEL0dY1GQpPPGQ6I=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpo6Z0DXIdtnlpb2zQk2OemZA9q006AiFoaH
 3Atf2WcSzjuqIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqaOmdAAoJENju1/PI
 O/qaGf4P/jSrAQ3f4seld+ntVRbufACqFMWRD3d+x8Q3wJU8TXYmJ+koBu+QjtdxWSmlyCtWlR8
 LlqPfxHYwg98ZXSufGwPfatJyH4lEG9fO9ghydFGN2vQ8Zi3wNKL83OypqY4q1X+eaBdc5OhAeW
 VoU0KPey96d/9WHUMLYpGrzMBSA4qJlSomjMaZzZI6xbfc+0MnH84v2ethqUxEhnRw3blDnH+4f
 pnD6x6733MNj2ALPm1rwvkLUUw/61TI+3wvnPDy8ySk7CrjefgqUJF2bBTNHiS8LOh2uA2L5FP5
 VVtY6LARhp39zEK6JJRbb6QiIaWlkCbZDn0BffSIIn96V9c52ryZaqC4UeSdNB9PoazdIfQsFHM
 UhzJeBmZC9qLkcSa1Zwd7DNhVI5tEY1QtOQ264L+Qu+YAkypx1embMOQuMzRPWmgpXEqcza20N7
 KEvczu66Aw4KAkHZQb41rUka7XeJ9hOAfTb198mg5Yicgo55SqWOwmAcvsEByXficlG01piTvRW
 JAeuXy5017wxLM7XYyJ+hyfbV4jYErt1I2+oe+9cdhWdQPIUb0lCHikQPhg7b5ydSV9cUdAZPvv
 IzqEH2It6yf4qdvnRvjOPMWRU/xWrFYMlCMSpweqEzvn1pLmB3cWorza0dgACnX4PTSsJF6kgq1
 JyVvg8UfO48wnhxbforIs0A==
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

The DP AUX transfer method uses a completion triggered by an interrupt,
which can timeout. If the function runs into the timeout and the
interrupt fires afterwards, the following DP aux transfer completion
would trigger immediately without waiting for the interrupt. This in
turn means the next one would also be broken and so on.

Fix this potential issue by re-initializing the completion before
sending the AUX command.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index ca7ff544d243..951f1e280e47 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	reinit_completion(&dp->complete);
+
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
 	case DP_AUX_NATIVE_WRITE:
 	case DP_AUX_I2C_WRITE:

-- 
2.53.0

