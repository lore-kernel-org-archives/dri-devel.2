Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81988C54F5B
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6830A10E98B;
	Tue, 28 Jul 2026 17:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="G+fvByOA";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF2510E98C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785260447;
 bh=rAX8Gkdd0l2SvPThxGwSATdesygL1W5j4bmXRGpe4TM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=G+fvByOASJgoMAIldqBYVIXiu137feeqTaiJF2WEySZ3/v1e14a93d2UzxJ/+Vqu8
 uHlx4VdJxm7mJOzNSUZlKK4q4YMWpFBzLPxzCnFN0F2iztDmY0aMqlCT1nNPt5ymSH
 INs4jo0w7MMohMoExl+JRygKg/hnPa7HSU3U1k4+YFQo0INrcn3zR2PAAKnpwJnsXf
 /fXb7FKBJ/6IEBZQyGJx4HOwRZxKynjGv7jjiHC/23wVDMEV7kz2NjMfOfe/M2tQL1
 UGF/p8lmEkEQKaefmWxh/ur9/g7Xy34RMp25O8dvzuDPty1l1GDi7M9av91j6rEsMi
 yMeY+VRR9jHtw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B72D917E0756;
 Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 16C8648003D; Tue, 28 Jul 2026 19:40:46 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 28 Jul 2026 19:40:45 +0200
Subject: [PATCH v7 09/18] drm/bridge: Add out-of-band HPD notify handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-synopsys-dw-dp-improvements-v7-9-b7640fa8cf48@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=rAX8Gkdd0l2SvPThxGwSATdesygL1W5j4bmXRGpe4TM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpo6Z0o8v0iYcY6Iu4WxMuyaNbBCyc3P/vGN
 0PGLYtHiBdJOYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqaOmdAAoJENju1/PI
 O/qasZIP/1cdbGjsaPiKlFubB/cv1qUi6WyaR3BEXm6bZsdMWxvwqv5+TDVS12u9Wit6x3W3vML
 2AAnWOe8tLyRjRJRwu21y1TcsCBtc2SoEiamr1OkAYMiq76NmfGr7+A81l609vOtgyTv5VfaVzp
 /1iAkQ8Q5tsM5Hej0+0j4zQUzY6WQwjYtAg7GKAfEgTai4OcbGnucUBV/3w7pwmhZWnLbErIbdu
 AVAPFLRsMdCXxmBCVaO5Eyhs9Cagj14zPN76YXgGgihK3JvjAuOT6dxbhBiJYxE9GIkT/8N/de1
 j1+nDZYia5Bwl1q9HU8fxtSZulRXHhi4LPt4TEx0MxvLuDAoDWz0pYGpB289gfOMwzxBIRQpLGG
 yDNvVdXvbqNOjQX4Op6K7+bVCdcXwVLDfXc+U/Nzf54fzh69fMoLCNOaZmJJP+IvKd6N2WHNz4U
 MXw7qOvOuw9KKkm/73WQ5saqtSkGH9aTYp1gCx1Wf8HiYCnebLu6yOzIT6vz9O4c9EDZQ1BVxAa
 UCllBE/Ng02HkdCe3o4uyjUDwiiJWr1sMj5CJNMLWHcqpqkz2iJsmJKwhX9cCzKEtWblY3oT23i
 6a8/6NK1xSqYll/6WBE4namyLlNaGLPcJ+3X62m+C3nyhPBZU7P2mtyra8A475wbhbdKRINUkAK
 BU8ti+siDe+iFwl/tsZ81GA==
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

For DP bridges, that can be used for DP AltMode, it might be necessary
to enforce HPD status. There is an existing ->oob_hotplug_event() on
the DRM connector, but it currently just calls into hpd_notify().

As DP bridge drivers usually also implement .detect and that also
generates calls into hpd_notify, this is a bad place to force the
HPD status as the follow-up detect call might force it off again
resulting in all follow-up calls to the detection routine also
failing.

Avoid this by having a dedicated function for OOB events.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c |  6 ++++++
 include/drm/drm_bridge.h                       | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8b54069fa53a..632cc3ae3b54 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -180,6 +180,12 @@ static void drm_bridge_connector_oob_hotplug_event(struct drm_connector *connect
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 
+	/* Notify all bridges in the pipeline of hotplug events. */
+	drm_for_each_bridge_in_chain(bridge_connector->encoder, bridge) {
+		if (bridge->funcs->oob_notify)
+			bridge->funcs->oob_notify(bridge, connector, status);
+	}
+
 	drm_bridge_connector_handle_hpd(bridge_connector, status);
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 58fff047f43b..713652fca033 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -540,6 +540,20 @@ struct drm_bridge_funcs {
 	 */
 	void (*hpd_disable)(struct drm_bridge *bridge);
 
+	/**
+	 * @oob_notify:
+	 *
+	 * Notify the bridge of out of band hot plug detection.
+	 *
+	 * This callback is optional, it may be implemented by bridges that
+	 * need to be notified of display connection or disconnection for
+	 * internal reasons. One use case is to force the DP controllers HPD
+	 * signal for USB-C DP AltMode.
+	 */
+	void (*oob_notify)(struct drm_bridge *bridge,
+			   struct drm_connector *connector,
+			   enum drm_connector_status status);
+
 	/**
 	 * @hdmi_tmds_char_rate_valid:
 	 *

-- 
2.53.0

