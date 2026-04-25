Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C399FFF8864
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1878010E526;
	Sun, 26 Apr 2026 06:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="ea9svDYY";
	dkim-atps=neutral
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com
 [74.125.82.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8BD10E0A0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 03:10:22 +0000 (UTC)
Received: by mail-dy1-f226.google.com with SMTP id
 5a478bee46e88-2de831d2b20so2211774eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777086621; x=1777691421; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2siy8AgvZkarnaqQ1iRlbYdPe6np7TX5Kc2BXRw5Y4=;
 b=ea9svDYYgYZDiC6WkmxhIep91eyypmDhtePMnt2vqgI9Me4wtIPDD9651172fe9Xdg
 XNJLpm+wGxrU1sxeNdxYlvhdYHGrydWkcw459GHWv5tw/1oTvtlSbMceQn2xo1XvWjs5
 Kh3WICOT2RAyMDIVsi5LbzNj3MMpGeFDJKRuuygPFUCHuHmXTea1Gt4+oFpVcSr7ac7g
 lZQjqdRmAcFg37xyzL4FLZEzAnSmOoseFHS5zkXF8Qdy0c3kXhFfQqvFQstN3OQUdYWr
 BVoGJzaO9Hdt4KUkXkheya0MKRzGehbgu0QKlCMygIXHaMevVIZZUWuviURkW74iAVyt
 jhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777086621; x=1777691421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B2siy8AgvZkarnaqQ1iRlbYdPe6np7TX5Kc2BXRw5Y4=;
 b=Uq70rk3HrNoGspu8G4HQ3vwg36mpRuT8NDRvm0l1BooTE2el8C+F4kXAgy8djOvuiT
 chOQ9FBwjty8G2nsLyveSpSVcrFwt14AjPTLYy0fHhjqHtV+HUgeTEGIUfytG/vW0H1x
 0FnwuXgLL62baO4s1B9cfPLWiWdcSChGz9hEHlkVzyEZZ1wQ+utMVI071rvAX/6THPZO
 PlMPaaub3iV/3y+yUdfcDpfB3CofMmlnJ5PSFQf4Szw8BeFbSGK6OXEbJTNA3fIQzAZL
 fOh2e0yXBZSU73RPO3uYYUNxtHvgeAMqTUEY8uWEFFAaxSvaOOQVimw6nGcP8jeGjMjm
 vYhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CyHV8hpKU6Lz9Tao8PZslB4TanQvZAp37VNt1MuZOeIrmmhssWSlA3j2xaKwADHD0JL1wdX+ZZn8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYM7Ns7A/X6mB3rqMQU9Q6wYC2/skfEiWRI8nDMrO7W7dVmKvI
 fgMwoZRY2fmkjvnABC/WHzsYWIDcblw+zhWOU17klnn2Lq8aAvSX3p9/GyPvVq/Md0YQ8yq+CMS
 c5NYJkO/HcaGdM2iBM9PnN+EaQkjWsO4aFnG3
X-Gm-Gg: AeBDiet0Zew7lLxoCFk+mcAjI4WJSsifXRo1t1AAD2ED0qkLsI+BMq9QiqwTLT7nR4G
 zy5DecnIT0BhYK2RNCv4Dpv1Nzq+yWDGrYQCjOIBYtsWArtJpJKsC7bXn5BnGmrvlclrsH/pO5P
 4SKs84Hyoo2njBGP7hxYv4mGyNL/pxUQ/ZY8gNDUZEjiW+kh9gTDTvlp8SDdSocthS3YuUP1eDB
 bZ5OcHPPSXNVkgiBhtnlQeiz9RGatrd/i3+8t5H4jfU5YfGo6jJppoQJ4jP8LoyQEu9eVzHrUuO
 PZYw5Pa48bjFPAf0gAeILMHCiccKQOLB2KdjCToDGTDwlW1twuIMIIOvka8xwD2KT+rfoWvL8cZ
 RjGBRWU/at9n9+UJnTVN1ULI9OxegNRY55blqrzIzBFEnlzlk4IjhWTo=
X-Received: by 2002:a05:7301:1693:b0:2d2:129a:1682 with SMTP id
 5a478bee46e88-2e4786460f9mr18795386eec.16.1777086621591; 
 Fri, 24 Apr 2026 20:10:21 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2e53a3ae691sm1728646eec.11.2026.04.24.20.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 20:10:21 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v8 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
Date: Fri, 24 Apr 2026 22:10:08 -0500
Message-ID: <20260425031011.2529364-4-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425031011.2529364-1-dennis@ausil.us>
References: <20260425031011.2529364-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
to HDMI2.0 converter, designed to connect a USB Type-C source or
a DP1.4 source to an HDMI2.0 sink.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 8aa31ca3c72d..42c1f3d5ba0c 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -270,6 +270,11 @@ static const struct of_device_id simple_bridge_match[] = {
 		.data = &(const struct simple_bridge_info) {
 			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
 		},
+	}, {
+		.compatible = "lontium,lt8711uxd",
+		.data = &(const struct simple_bridge_info) {
+			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
+		},
 	}, {
 		.compatible = "parade,ps185hdm",
 		.data = &(const struct simple_bridge_info) {
-- 
2.53.0

