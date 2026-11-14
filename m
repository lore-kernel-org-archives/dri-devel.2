Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59535606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=havA/dBs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C47010E660;
	Sat, 14 Nov 2026 05:01:17 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F21410E7B2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632456;
 bh=s5L6s2fj0KUYXfVyQ1DqZ+JQ9NOwnY5J+JG3saptonk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=havA/dBs65Byi5UoQBP8wJtmf7zNcIySraIf79Fv8OC8/G2Lf/S6++QjOuhIuPfpl
 jne9hLLseMKfcArFLuEWAZpNf5DMpn5Sl2jD8cZg27+lHFBZw9MOXJkjMcPRKkEVlh
 xpny/G9Wh6hBu4bASFAoP+h7J8MGIRTOmY/KEMmo4Om/9SAw8et0WR+7C04N7t/hmx
 xBAUYw9O9OhxhdEUhrOh5j4OIFrzKDHqQXhSaQ/PHRrwPB0u1YWyZ5lpXmZ99uDzgg
 BhHKp0oKX65KLdpSYoD42KHUBJZJmoSbMFuxF7OAj/neqZ6FU5O0ABE9IvrBEpNKMV
 zMgxR6XOIwKKA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B06F417E3873;
 Sat, 14 Nov 2026 06:00:56 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 176FA480041; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:41 +0100
Subject: [PATCH v12 08/23] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-8-d42d3dc5bdd4@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=s5L6s2fj0KUYXfVyQ1DqZ+JQ9NOwnY5J+JG3saptonk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wdVhJcVdhP9bjxZFQ1W/2gr23BLxdb50
 iBoRxLYYN7nkIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qaNTMP/3PNDKw26kgszhl+kZVw6GXhu+cFR2amPDo/QudctDpi6POkP3xdts4iX/FAN+aM6qg
 iyK0qwwCxAVCJfOEHsHqfgf/ZJEuVxYun7fQ8dnjlOXJOc511FrNu3YbxdiWPchh889l0Uzy6zo
 HpGTCjgGX+ttaS7/BoWNAVyIgAGsgQIraXcMnVJ8VZdDcEhw4yPWwtZYKCWfpHAxAP+DSXODEIf
 Iw3lyVJEj8WPZS8dpvS+FmF2/dhOo0HmJl21hnzhs7wp1/Fy0To985rrehuUohuF+E40HIT/Fgt
 NhAfPtMMaG1FIDAdtsW3lrIqvWHBZkkNRmwxF8BsjRTPtbmr/KYa20r4bn7hEMdRZS2sTTBkCll
 UFH+GsmMF2vDeVcE+nHzRLrXrg+5521s7Z/ymoAW6uaOduNZpMOIRXqSZn3CoUIp0QxU/+Blb3u
 wPgPx0h7CIIsE0kKnq6cLnAFdFPrgSnD0OdaniYXzGNa5HzOTjiwm9N5UsQgMRbQ85BilqQ7Tqc
 qbBaMXF0PjoxvGOUd9qOJRutj8OaQXQDVGNb8k9zqvAhgQelA7uzOv7loUlpWMmK+BqgLUac7wj
 1mx4UJ6Suuc/WPKTDI3Dt52zIcOi6qx4rqAHzM46DmNO/60Dz0QIw9Lqbb0bcC31qrRJDhtpRbX
 tg8POWXath6uekmYteTEu+w==
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

If dw_dp_bandwidth_ok() returns false for all formats, *num_output_fmts
might end up becoming 0. In this case functions calling it assume that
nothing needs to be free'd, so free output_fmts within the function to
avoid leaking memory.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 4afa57f4bce2..158c727ab58b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1821,6 +1821,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 		output_fmts[j++] = fmt->bus_format;
 	}
 
+	if (j == 0) {
+		kfree(output_fmts);
+		output_fmts = NULL;
+	}
+
 	*num_output_fmts = j;
 
 	return output_fmts;

-- 
2.53.0

