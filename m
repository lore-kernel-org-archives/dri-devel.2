Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648CCC5AC80
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38C210F263;
	Thu,  6 Aug 2026 17:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WirvFm+R";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1B710F262
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786036273;
 bh=s1hZgDXLqbyiz5DUeUQwLn7ax3yO4EnYmxwrae79gCo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WirvFm+RiFTu0g9N6PYyyoEDVGBf3ahkeemyMnrf86kTn8SLbBqsdw8aGsPy7Pyi4
 KUclVAdkWwGEzZe47tjCH5aVL/ltDuUM18LNGsB86NMDgPcof1d18/2Nlw+ad2AJN/
 f7ikQIzv1LtyxJN1Ubn5nlQl2LBPLX4IpktlMUUFFYZQFUDvXtMlJYfnnoAjMr+iWb
 XpEFnm8cQC6t6wxjB8d5SY/nbRwzdlvj+rGLeoeh0rzlXXEd2rklq/iMbwrkE2mHGS
 Bb+uFXd+h1yZDuyu9nfuBkvlS2gHjTY2EyryHL4/iInoCLcqy+NcmQ3+DK1VDBDf6l
 jAVFnwQKoSdsQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 79DBC17E0110;
 Thu, 06 Aug 2026 19:11:13 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 10DB5480062; Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:23 +0200
Subject: [PATCH v11 17/21] drm/bridge: synopsys: dw-dp: Drop useless
 reservation of first slot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-17-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
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
 bh=s1hZgDXLqbyiz5DUeUQwLn7ax3yO4EnYmxwrae79gCo=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viDeDCrcqe3xFH7Ml1Fvih4SvSx6fB36l
 LeDp6SlArrrSokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qagycP+QGDG9sRV0ehMVE29lObtT8rRU+RPEVABIH1rhf7J04J8EztEjPvIkgCM+ckgFlaUVz
 ed5rmMfbmffqrBKnMMo4zHJ6Gj4Q6nEJ9bZNZvqcIPvzaMT+EsMXKIdBe2GhIejsKXMu2LlGLYI
 jSHNuFsqVnk8M+F0nj2xnijnxmjPWDMNMf2ElaeBg/xeMpON2lUOoyUQ3Hk+B1vyTZnueog+206
 hus7H2KgFyLW85TEnd8P+DRGIgWv2t5HFDmCqABhC5yQ6i9C08JqpZII0zQMHCXDaqm506eg72z
 Bdojs5fun+4S4lz6q9gRP60ffAJO3eOXeEvrFA8Ji9dCXkPmHNqs8aQsC04OjYKa6a0awXCe+Kd
 BurOV364IvW5LdWgO8Eb7nR/EsqlY6iis31FJ0xKvRrjBfHFBy/+E6pYHhIWoDRbVZipN9vyqM2
 7+6M6l45jrqqXNI8/L8JujNZZA194GJmfoINW7Iuf3gBnU9U096obX+uBsMsNRLSEvIbP8wu47o
 iRJwM1i9rcB0V71gVat8iz/BMsMvTBNb94mRpGDMAwxbm4xzgjBWAFARY0I/VyPn7C9AVH6jEMp
 bRdx8n9BkNDDOXlaTs/5JaNBUK3PF4n8rir/cTmEo+VNZtgCyrNB6bVC+rfmHo5xEmB6gUjXO2N
 iOQpII00KZDQyaPP1xfct3g==
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
index 31495a813e40..d8682ccdfec8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1713,9 +1713,6 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
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

