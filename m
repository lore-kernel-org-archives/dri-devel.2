Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AA3CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 22:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CB410E49C;
	Thu, 30 Apr 2026 22:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="H0gCZwgD";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442F510E49A
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777587638;
 bh=BXeARZ0ujZDNhdquS/qJc3J32JsHagxLqC8adFmTGE8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=H0gCZwgDc7BNMkx0aR06G9LUBLuNl8qm+mRNXR7M6gOawFmt7LrzdYlQ2YK7qvfn6
 NUuKLlzOWVdSc5ds46gk90Nn66nIx0Pz+cnhlRoIbNVXKlnfHwar4IXm9VsWUMMWWh
 6D8YAwD/F5t7vdO1Tie6Zqf+SGJ3HJXPHi31yIXSU1A7MBRW9chsG++t4J/sKxhTyk
 VPE22aCAVBtwpRgVE8ZPxn5xw5bzl4TDh4DetmgssnHc/PYmgAxpcQ4oukJwURHdbd
 sY7d16cxbNxFwXVIaiZ+sX9Zw9IEoACGA1qqYhBKGXw1HntPeuP6v7ONnMXfqSYsIt
 /GaTkeZ5TpKqQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D503617E15A6;
 Fri,  1 May 2026 00:20:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1EDF4480052; Fri, 01 May 2026 00:20:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 01 May 2026 00:20:38 +0200
Subject: [PATCH RFC v2 11/12] dt-bindings: display: rockchip: dw-dp: fix
 sound DAI cells
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-synopsys-dw-dp-improvements-v2-11-d7e7f6bac77f@collabora.com>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
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
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=BXeARZ0ujZDNhdquS/qJc3J32JsHagxLqC8adFmTGE8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnz1bSlTIAxj/dLLAa3GyMt8Ld0ba0OmTnOS
 6usSYr15oJB0IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJp89W0AAoJENju1/PI
 O/qalDwQAKKeW8xlPblJUTyKHxFyD32rxfsTFo92spcKa9FU8H1wCvyzO1+ed98Jl30kpY+gSgC
 575onA3/5uvhX4uJH9OuVXCxlHkgGfmVhXpZJHTKOI3ocSQ+UCIuYZvn12hdyRsxIhZGkxo9+tN
 c2SbOjNa2NQvJF57U3PXhwE8FxSkPaiDcT5fB3qH0yvkQPXZ+gxWgJN134LGod+8YReVTpYKqS6
 Eb4TKNGS7ISTG3XjM0arfoIdGG4ddknU4BLhYadqBnguxzjzVaOy2AK81vKUJVuYnUe/zBrgx53
 Ya4hhQQlJC5TaCr930lmWJC0th6ldMFvvzRQKVtO+kP477E+KEUzFcpu2Rq7I5vobV5YPWYI7cW
 KvK433y+oICJGuvDHi9olwbsGkzpJiC/xecdgnFHJGnYeVUEQeKrIrEeg3AVi45ztdeWAjTTnVA
 1CqShDvT7TNC2zmj6EXFCrsS76L56PXUC5Q0kSIlbyfofk+Lb/YG2fbwxNQ8g2eDrm7F4Omnis3
 /wRUhZf4y56OBS11jw2kIxwTm9OViQjSfD/tUIuINRzD/ev587kLJh4FUdxK4e1vanR13sWXEjQ
 lZlJSkzEw2MbSBGjYt6AiDMU6LSRzFWdeM0fjNjSAAd92f2zN2DcNQhPYVR2vM12AVHgnc80tai
 yjv0Rv7YpsyX8XTEoZUMmIA==
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

The RK3588 and RK3576 DesignWare DisplayPort controllers both have two
possible DAI interfaces: I2S and S/PDIF. Thus it is needed to have an
argument to select the right interface.

In case of RK3576 this is not enough though. The RK3576 has the same IP
as RK3588, but configured with Multi Stream Transport (MST) enabled for
up to 3 displays and thus has a total of 6 DAI interfaces (I2S and
S/PDIF for each possible stream. Meanwhile the RK3588 does not support
MST and thus has only 2 DAI interfaces.

The binding update right now only supports the simple single stream
transport (SST) setup. To avoid further DT ABI breakage (or complicated
bindings supporting different number of arguments), it's probably a good
idea to take MST into account now even though the upstream Linux driver
does not yet support it.

I see two options:

1. Adding yet another cell, so that we have the following:
   <&dp_ctrl [display_stream] [i2s_or_spdif]>; potentially append
   extra input ports for MST video data to existing ports node
   (e.g. port@2). I would only handle the sound DAI part in my
   patch and basically use '0' for the display stream and just
   leave the option of using '1' or '2' once MST support is added.

2. The vendor kernel creates a sub-node for each supported display
   stream and puts the ports mapping as well as the DAI reference
   into that. This bundles all information for one display stream
   together, which creates a clean look but the subnode does not
   really describe any real thing in the hardware.

As upstream MST support seems to be quite limited, I wish for some
feedback about the preferred way to handle this.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml         | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
index 2b0d9e23e943..1303d0e2145a 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
@@ -83,7 +83,8 @@ properties:
     maxItems: 1
 
   "#sound-dai-cells":
-    const: 0
+    const: 1
+    description: 0 for I2S, 1 for SPDIF
 
 required:
   - compatible
@@ -144,7 +145,7 @@ examples:
         resets = <&cru SRST_DP0>;
         phys = <&usbdp_phy0 PHY_TYPE_DP>;
         power-domains = <&power RK3588_PD_VO0>;
-        #sound-dai-cells = <0>;
+        #sound-dai-cells = <1>;
 
         ports {
           #address-cells = <1>;

-- 
2.53.0

