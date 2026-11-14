Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D81606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=F/utlyaL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D3910EA9B;
	Sat, 14 Nov 2026 05:02:53 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CF310ECEF
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632562;
 bh=BdVId3R9uDagFwOXAz9RaIcqGg/6v8baZJ5M9pnhoeE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=F/utlyaLUIgiT7UncxK5pEQ0f3k+ttXeGP5v6ZB5FFGI4DobjMTsUlJ0hMA8POn1d
 hOSTjmF0AlEONL7mrDvTmLjPjFg10bdvl6YUS5sAJIo/qDvEny/qpXHGkBVbFv6Dn0
 ZglnA1BHn+LpuLDQrePd4hf0oIFsPR12upyW7s6frSaRfR5nKpRzAf2Nzd9Q7wQKJb
 7uwFsWdgnHLLR8rFi1kdtJT6BVDeSb40dFdPv1WNDdl5TORWfVUsUB7EUcn/SrHL0B
 zr0iZ7XKVvxlHpRCkV/fjFO/dwm6A4IWH9khfNpsnaXK66QiCYHpORezLEtz35e17A
 R1DQgxM9O4Qmg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A06817E0FA5;
 Sat, 14 Nov 2026 06:02:42 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 2EEE848006A; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:56 +0100
Subject: [PATCH v12 23/23] drm/bridge: synopsys: dw-dp: Retrain on hotplug
 with pre-enabled link
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-23-d42d3dc5bdd4@collabora.com>
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
 Yury Smirnov <yurymonzon@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=/a1Sx0xnxtIAy/rO9CtYIv6V8j3eVU/OvzbAEr8LJwU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wdgwOCJLXRq1L9gbTDMJjwS8TSKnF03X
 n2jVyTsbtiH3okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qaml4P/R7wJImy2muDFD6H1V6vdsdRK4+QzwE/p+noQFBeApnsTkUwcoGXYOKbdbl2QKH//cd
 WBeCdJhT8/1Zv49VejB/VuQ/UD9zTEOzoq1lZffar49mqxdpjyEwYhYzh6HUAmHYWugmcbk3uPR
 UGkQFpd+qBZKsXgcHLzDwtZdP0UHdauPknnUuz3dG1WY5Eet4/81xVcMUAwZOFC0VFjCwPyLNXn
 THAFXLw1i3kBW0NTUZFmWz0vMiB27bPGBRLDgeVVrfkrpvPU7WCJM1COIzf9dES5QKN/9IQIcCi
 baakxV1pTEoKOawblWTyb5QiihOA6VPiE8YLrDHIOK6lu4pa+IHKQ2qAIJsiXkTWHIrrbQUDczg
 DEkzg9Q+mLUnyv1sAzbplH5mSXgCHY0xeNaUb+k9vjaCt1Q6l0rx0tSIpPxrTM3GP+tNvSejA3U
 ug3PG+ZG9Yks7JFcVfSN9LdYKLUypCYSTvBHkGDO2zKkZZivVAt1/LwWN+KINJ1Kf5cGRat0Xjh
 cfwp1YtFJlJF5Z3SmYHTHkEAD457P7hpVW7azg8J1xZ1fMwpJJiW69cEziE46TRx8DnBckdepKJ
 6cAr8fODGSn0103Hopmq+JZpy9Z60omov7EycRbPd6ZghYl5JAI/7X0DIaDOPeVxZmbFtNYwJL/
 M5jX8+gemWUzoJ+u+PV0xfg==
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

From: Yury Smirnov <yurymonzon@gmail.com>

A long HPD pulse only sends a hotplug event. When the sink is replugged
while the output stays enabled with an unchanged mode, the compositor
might not do any modeset and the link is never trained again, so the
sink shows no signal.

On a long pulse with the link enabled and the sink present, retrain
the link if its status shows it lost.

Signed-off-by: Yury Smirnov <yurymonzon@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index bf3a53463394..b245d6200913 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2394,6 +2394,12 @@ static void dw_dp_hpd_work(struct work_struct *work)
 				dev_warn(dp->dev, "Retrain link failed\n");
 		}
 	} else {
+		if (dp->link.enabled && dw_dp_hpd_detect(dp)) {
+			ret = dw_dp_link_retrain(dp);
+			if (ret)
+				dev_warn(dp->dev, "Retrain link failed\n");
+		}
+
 		drm_helper_hpd_irq_event(dp->bridge.dev);
 	}
 }

-- 
2.53.0

