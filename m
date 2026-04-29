Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89F2CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464A610EE53;
	Wed, 29 Apr 2026 04:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="Kj4zpG3A";
	dkim-atps=neutral
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com
 [209.85.161.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA2410EE3E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:15:38 +0000 (UTC)
Received: by mail-oo1-f98.google.com with SMTP id
 006d021491bc7-67c250805ccso4567100eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777436137; x=1778040937; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhsANxfjmjB7vk5bKYmWUGk+7KV8pJM6GvanWdmMMRI=;
 b=Kj4zpG3AQ0mnhCKEC+Rst6tugNNU18O0+oOEZBBlf7SIfaqkp5bKYJY+fxZ8knuS72
 wPEE+d56Yb1dyMahM8mHubc8XrnXt1w/PDoXD9lEHwrzhJWj7LWUSnNPFS5sVcZLg7Kf
 cjRG6uu9uzaiPy0dTTc98VAYUfk4GK210XeokcHbZduRYm73p/i/xp1mrdqT3GkOuhCg
 dHfRZMlBoqGdkS5gxUBwlCBIbZygU/ILgRoNNnQWxj8ss36zgup/qJXrTjY/aBPL/nsj
 JhXJki/fry+x9e/+8Nq8aBkM4Gs4JTdI462IX57AdWGZIhIaujBJZUBhAqSHxCNfs/cx
 Z06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777436137; x=1778040937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MhsANxfjmjB7vk5bKYmWUGk+7KV8pJM6GvanWdmMMRI=;
 b=d7yzdnXqxfYDZkz80ReKHsQmT9K5YyZEJS0Gruujz0nNB2Q705OOYYylbhwJoMKS7L
 /JQDiscYJyefDv4KTv/r67h8gXdsKx64yhSpDcEV7MBxd1zpUaEGw6qNxCtFeLq4khq8
 1NT4Gjuw50ljAOD6xvsQqlss8J3XxCktbIP2Q1ied+5PLTrDfRQBZXl4yvUukhub064X
 H8X5jNP7r/GW4VCfMqlL1dsVSxaun13HskowbSh38I4GLIJvIcjURK9DZUiuZPCIVJvD
 lUcZV+xBMwVlf2Mkg95ktsLAhoEcyC4ZSEoP3Pczc3a3zX+02dwibdrugsq7TIQXVq/o
 ehkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/O+o/DxPwjGUquobR5gdgJS7MS7FJ0pFI4sz0ctAOyfKY/n9bd8j02tQTipS6OdVzlApZ05zuKjmg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZa1PPzBJmqEDwAxLAZ/OQ7n8dYr/jsRjBvg/REWtswY4+Rx+6
 rRfHejCUlQBLIS4JmWRTtLQcyWydicHlzMUss89OdONL1bQzOCRaveWTHRZ49zsFPOGbVOD7ky9
 Byk9M5t8JdeI+Yv+A/6zWCXgdwWaZTNzNDQZ1
X-Gm-Gg: AeBDiesA7ODXY75+wkBk1G5GIq/mtCXvLlYFKDKKH+9hVeN1ibK9rYTUS1SbgKHXaNF
 HLQIVWHdSl71jAcYX3ShU/ezTk4k9hp3hbUljuPEfIfE/+a53k1TAUL9nVXEedYrtEWhppuwgoo
 P7s4r86Rn8755lDJJ3IcEGvSPMwNIS6ZX/vVe3MfdHvjwLuwT8qcebga4NEV08pQMIXTKJM+NbG
 2hPIYAH8MbKSiF/aCoank0Q7kPOFmqCP621ljbaw+vECXYz4sk2TELGvwK2gWYcQxOK/i47oyYr
 lCQpGYGC9d7Ekyg8VMOWb7nU4xV22cQ4PjN7XFJ0OnwYNzJvf4xxC+50ehWeB91kCduAhwR8mI5
 CDFtgM6iQyMb7dJ2JDvECX23KxzSFloDy7teBhskbN07iRGiap3yf3/E=
X-Received: by 2002:a05:6820:4b13:b0:696:1bda:5dbe with SMTP id
 006d021491bc7-6965cbce522mr2941455eaf.56.1777436137366; 
 Tue, 28 Apr 2026 21:15:37 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6966baf952asm41557eaf.9.2026.04.28.21.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:15:37 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Dennis Gilmore <dennis@ausil.us>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 2/3] drm/bridge: simple: Add the Lontium LT8711UXD DP-to-HDMI
 bridge
Date: Tue, 28 Apr 2026 23:15:27 -0500
Message-ID: <20260429041528.558254-3-dennis@ausil.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429041528.558254-1-dennis@ausil.us>
References: <20260429041528.558254-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4 to
HDMI2.0 converter, designed to connect a USB Type-C source or a DP1.4
source to an HDMI2.0 sink. The device can be run uncontrolled or it can
be attached over I2C, this supports the uncontrolled mode.

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
2.54.0

