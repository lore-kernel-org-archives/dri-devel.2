Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FB606A332
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Z2WRjd4F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EE110ED30;
	Sat, 14 Nov 2026 05:01:25 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB2910E7A8
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632456;
 bh=LgZG1JUuYKTJ7lvvqoNlqpaH94dmMLvKwmDihxkOtrI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Z2WRjd4FqD26jRv78qCtaqN10OFVotbLW81EQbwK5Ys1jU54ljfv/FvJYldkdMAp/
 31dR36WTF2KKOIKMzZRDoI880aSuVbSBfXvmePllfEVqOK9xXRTefhUnVTNWg2zWol
 j2e6OkHEWJqO5vBo2JUAjNnStEFUkwThYV5vefvDWp9zyL6k/FquPIKihk27zujLap
 4VkMfPPNGIwyUiSsoExtCfraJXiV6h3avc/DjyxwNtEvPVP+v9ee011EasyGPMDLzb
 a0ZBJotkrYh96cjS2ppCB+tEF2bsBK/D//NlNCNzYiTN5/aXVX+5PErnCP5fT8cZPo
 rZasB3Cw0nihQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A676517E14D8;
 Sat, 14 Nov 2026 06:00:56 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 12705480038; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:38 +0100
Subject: [PATCH v12 05/23] drm/bridge: synopsys: dw-dp: Add missing mutex
 cleanups on module removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-5-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
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
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>, 
 Andy Yan <andyshrk@163.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=LgZG1JUuYKTJ7lvvqoNlqpaH94dmMLvKwmDihxkOtrI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wf6xPbbDb/0onY8OomJxwqVzi/gYB6AH
 5geI7567E4MgIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qaZ+cP/AlXUbdThvBVezoKDjxeiWxwYCjj0UQuTw922XA/LzmrZAfj6RqP463CMzaj09buxir
 QxqBaZRJBbowOdtWyTZ47a67AmqkXrowMXHnAWBUDQsbKmaTcCnadG+Rktk/RcKuNz88Oo0NUWX
 WXvdxsyobkFD+y2PL/SSHMdeAPYHUUufLFtGWYV4EpW5l6HVOXMchZcYlUmQ/6fOgVh2s0TWi/2
 ovmOlZ5dbzXjHFkzE1Vq/E+jmsoZ7hpozeAZYqYwPHwS5145I4Kx9hsrd+FM0isvqZ+iz5JSZl7
 6PJjyFRVeHLXwQgCKOokxUqzrvllfyYif9WEadL3VL7zXL/XNSSRPolMH+qIv8ocKZn1dFQt2zo
 DTMdOTwV4sfWS+T4TXRK1/9kRHXJvJg/N8XHTG/GS2g1d3AWsrvtJ4vSvH99OleIhTioNijVg4o
 D2ePeejsdyE+YWIN5gSHrACyBFDSdCY62/X2hRNuwE9QHtGQMeRdxmuHOMh0BeUv/SB3kv0jCxs
 FCvqx0fmvvtQC84Ly2PcwCuDo2E4jxqyLkqvAs+AlnMmVfD0lGMHFGjCw+P1sZGU8ak7IMeF1i3
 i/VXevaNQi5E5DXPD6cQgLLpTOqib0bp7aLLy+PkZRC852pBLM9uUmcB2o5hrSkyJVuuahbPOt+
 935skL03+/jFIJPGYzDEsug==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The driver is currently missing to fully clean up after itself. Ensure
that the mutex is cleaned up.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 9677f789c986..7351b70bdac9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2041,10 +2041,13 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->pixel_mode = plat_data->pixel_mode;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 
-	mutex_init(&dp->irq_lock);
 	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
 	init_completion(&dp->complete);
 
+	ret = devm_mutex_init(dev, &dp->irq_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
 	res = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(res))
 		return ERR_CAST(res);

-- 
2.53.0

