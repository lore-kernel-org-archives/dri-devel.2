Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979F710A88F0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9653C10EBA4;
	Thu, 26 Mar 2026 17:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lUtECpZf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1272110EB75
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774546299;
 bh=BXeARZ0ujZDNhdquS/qJc3J32JsHagxLqC8adFmTGE8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lUtECpZflrzEV7Y/C3QNwh5eSfsIXVZc+NuscTKP8vrB36laJ0emXms1TQ5fa3E3Z
 mjPUlmJawKvFJVd2Sw2Gvdsq5tVl7TUn9OzHoWuHP9f/O8Dq/hHgh5cF4tW/qQfoYe
 1ip7R7lwlESpxQHzBeKc/fa1NvKR1aW2Jc+pTC43s1Avs2BjZ3hZniHmdfJ26EtEPL
 JRvvyB0fI5WKCtwIIg4vSy+/bYch2XWX7LFn+cqLC3go3WNnUkd94dYCivUOjcPoRC
 NOqE3jo/toQdOQ2pKlzGSSmWsX4t4T/Be/xNs/Eh+ZecejEdB41+//RsXmj821g4/X
 10wfYi2aegTGA==
Received: from jupiter.universe (dyndsl-091-248-208-149.ewe-ip-backbone.de
 [91.248.208.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 00AE417E6195;
 Thu, 26 Mar 2026 18:31:39 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 4B5BC480038; Thu, 26 Mar 2026 18:31:38 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Mar 2026 18:31:33 +0100
Subject: [PATCH RFC 09/10] dt-bindings: display: rockchip: dw-dp: fix sound
 DAI cells
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-synopsys-dw-dp-improvements-v1-9-501849162290@collabora.com>
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
In-Reply-To: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
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
 Conor Dooley <conor+dt@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=BXeARZ0ujZDNhdquS/qJc3J32JsHagxLqC8adFmTGE8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnFbXoF33zhgR9SvgPUXj9MDDV/sb/P2F7oO
 r4fWYbF7lcxxYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpxW16AAoJENju1/PI
 O/qa97gQAJr3OiTK64k3GSVNa+jwT1TOo9gm73/St/RMv2FZ4DBMcQbOk6zfHtVt/3J9kw5LsPO
 dRSnxtFtf7GeB4OckpulcUPw9prXcjGLmwZEPeiLCtNGjhHfn7rTJ773KOX0/8fOBPuhtsi1xLW
 TxWyYZwwdD0OJM645/XXD3W5o2WZtjSzMpRbVQcsuCwqWsr67dpS1Dknnez2lpO8LzaudEn1OCe
 LmxomtsFmVPYgmrQqbWcS3vAoTprVeo6FUEmeEOfkLeOuDiv4QHOi/JjRDJlv91NfP5djfKCd/u
 RPB1ARB56iI8p9UMPRsb72B73N4idCChnd4Lm3i5jQFIWZEFLs9mDPEP12QXRinoCYWPBS/9bw5
 Wd6HIahA2qlyc+AkRzsohDhrdjkI8nWjNokTtD/T+6D1Cof9Lqi9Ai8WGsEsO5v1fhpcDZUKWHs
 YEKAzu7T7ekzEhVpdk5JY4wM6+VXWo979rFKVOGPfvbOcXyr9fItesWGl0kDb7HAC9xr4qdt0RU
 9ekxBWlQLxdUwRFHJ2i0BQtIZGqLK66cwhhCDMQpImk/zaCj6QC/Wbw2DWsG1WS8JxPIJAxJa5o
 i20yGf/fEGiJ41sif6Qt/wWdS6bKy2M2aq4k8y/p5TvsVDdKlAGUNMgex4wlYLy+7o6Pq1VJpVB
 PcCiczkHlal1rb5eIV9wvdg==
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

