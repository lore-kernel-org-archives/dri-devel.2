Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709B2CD98D9
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9E910EAF3;
	Fri, 12 Jun 2026 18:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HgIBIhPv";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DDB10EAF9
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781287253;
 bh=BXeARZ0ujZDNhdquS/qJc3J32JsHagxLqC8adFmTGE8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HgIBIhPvknd1Q2ddj2XeDUcvA1Oic44+kMbKstN6zOtQY1pPo94fisndk5qVE37iP
 0JyrxmG1pRZLCLSdLUXTMeE6/jrKbL7mTy+Cq0CO0J6mZqq9ZSguDtc3MqZWFalvQh
 fRIO5LGjLj7PGZTpWRP+YgUowsh3puQ2VUMWZrv8zhkvfwtWlPLevXzoUF6aB/YZZh
 9+/k1AjfbagPokcwk2i1KFQNqqHT7HonyMZFnhMwaobrd55S8FtxqQ+EChVXcJpSlI
 Cu56CRvFThelAw/15BsOVOxsEei2k/EtA2eBrEswq3bVNephE/H9r/AUgsXR+s5juX
 AgZHyQWnEBh9w==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F05817E0FD0;
 Fri, 12 Jun 2026 20:00:53 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 8530548003A; Fri, 12 Jun 2026 20:00:52 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 12 Jun 2026 20:00:55 +0200
Subject: [PATCH RFC v3 09/10] dt-bindings: display: rockchip: dw-dp: fix
 sound DAI cells
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-synopsys-dw-dp-improvements-v3-9-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
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
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGosSVQEh5sbWtkeYdrxD50JXY18L37a17k8i
 beMkIXjL4spU4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqLElUAAoJENju1/PI
 O/qaE1oP/2MuS9HVQpUsHqvwtYb1JPn63Ve2KXPsy1UNEzcvcT6mX0O6uR5IJq2J1jFcHws8pMe
 gZxd8DxzxeDnwh0PdmtvM4Lh+E97IOikzqdMAC5CHvoHrtWqKVIqHnBLO62DZSveFvPCmPm3Sei
 bcwXx8Py7KHzMLVd8ABHDEudhXh2b5v93bskRJ0HEz5q4au5reAnJe8VXIs7Ff/oGYgtlN/NzuT
 n34m9PeCzwAeZ53MmKjlZcd65E9CzeMEkRLy9jWEcmgV8xwm5MvRoo0oHR9ZT/jkEXl3wz4VNlC
 Xo7cWuUaELX+NQ3az6V3kJRMJ8xCjm/w74v1mZjg+uTvhrEstyIgOFHlDdi9b33Kw6g70Cdww10
 pCNQYtKrl3qMtRILX/L1r5PtXedhRs2UWh7uvtqbJgOA88HoYFfwaF45RkhPNN6VDVUJCueFYEB
 xEk179zQoWB57GrDPTOoVBppmhhTKiEBeT6vuiq4+z8yyziQQCZcZsGOQnJ3jPGP4emExR7aASo
 eBGeNJAxh8XoyTXc11zeHGvXAReYFFCXmdxus7811yGXUT/nUVY77XHvX09ur8W+oqDoN7THLqv
 /bW15G0oM7ULw5nmasvLj9CJI2Y0pJvJUkBNpRNujICox787KpfXjJXR6eZ7SJz3aKKczWyGstY
 mIy34KEA7E4F0f516JCE1IA==
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

