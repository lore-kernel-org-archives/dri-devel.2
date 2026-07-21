Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D084C44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4BC10E3B8;
	Tue, 21 Jul 2026 17:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NqJyIAgz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5536F10E3B8
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784656358;
 bh=Szu0whIwry2XJLoGj7gD8cKhUNL8gnGbIBLAwSmIRe0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NqJyIAgztefUst+y54jAgxbzu1I2uDgagI+DYb6hDOgnWQMUhvf1kG8mqAUZaZnZb
 LbQpO/RKAV3pvDz9Nh4M720kTadhiwe0lKFYS+NCkIub2kkTXaMrhPzh+zYhYqst7H
 h0WdkWNUDgGuQS4pWT0eIVLPkndBa/7c1Tp4hTxsAAcZyI7TUja82vLfk0KtTmSuzC
 mpNATiT/QHjI2eK7lXyKovwmExdA7vz3ApvreJfEDCtV6dcUrITF3H0cnJY5TpStKp
 +3UeWH4Jr+V8J9g3kvMCvzV3Ky89urPaeWYmjvkDxyZMAr09Mhy3LHIHAtBDmT6iyf
 Cz+gyol7HTuAQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4E94217E121B;
 Tue, 21 Jul 2026 19:52:38 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id A20FB48003D; Tue, 21 Jul 2026 19:52:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 21 Jul 2026 19:52:39 +0200
Subject: [PATCH v4 09/10] dt-bindings: display: rockchip: dw-dp: Fix sound
 DAI cells
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-synopsys-dw-dp-improvements-v4-9-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Szu0whIwry2XJLoGj7gD8cKhUNL8gnGbIBLAwSmIRe0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpfseVT8gMOJz3vR303GHeE0KZMP8YapXJc2
 vxfs/1dCS6KcIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqX7HlAAoJENju1/PI
 O/qaLicQAJvSC78msD3XpfFR7f6XwjAhjFubR7DC7qMAn0Tqatma134CJr3XRnIe68yBm84JaXe
 M8julUdS5n5ro0kUu9sN+9IFa3+3jNSzgYq1v+dlkaLETNdmL+InLZf+WYkJ7FG1ds0uop+pzdI
 KP2iJxy2HlibpwSmu+NyJdqrxgUC6plMCgiqb9PK61uej3F76qSLkRRDH/Zg0yPUAKvPDkrMI3e
 3t6Ygo7i5mKj4BMT1JuUgAsdno3WySJHXsfep86pDe8i4bxqqY0SjK2LPkQxYjXaA2gBOB/sRvS
 BNm6yT0+5fabFu2L6f7yl+dmfvIKr6VecknazQoFjzRAA7Xov8LLXj6rNGxqE7u7jnJs3wrPRsA
 /RLPQCJYB1ABbNjxZ0fv9SGX4GOFCW8dsQEJEvvecN680oR2UP3k0dsJm+zQ8edsojT3W2kE4vB
 RYnyvs0IbECDHgu+Hfa8P/nHdKVlRTBAWO619spDzfNQlvJxqt7t9zi18UmhwMyos86AS0rZ1Mf
 OE3tgSzzBfEIietWm0qNmwSe14BIfRW+BzkX+FZTsjDYnqsLES/ZTpPB9ATd+SG/2UTSaFTOl22
 IJOp/CdGPSipI/JLbPb9h3EfQdjf+TCdevRjWqM7TlygjwbQUUefSNIu8HRx6uyOqV+/JigLSsh
 gVHzikkL64T9R1nhTCskuIQ==
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
possible DAI interfaces: I2S and S/PDIF. Thus an argument is needed to
to select the right interface.

In addition to that the RK3576 has the same IP as RK3588, but configured
with Multi Stream Transport (MST) enabled for up to 3 displays and thus
has a total of 6 DAI interfaces (I2S and S/PDIF for each possible
stream). Meanwhile the RK3588 does not support MST and thus has only 2
DAI interfaces.

The binding update from this patch has only been tested with the simple
single stream transport (SST) setup as the Linux driver does not yet
support MST.

For MST it is unclear what a good binding should look like. Technically
there are a couple of options:

1. Stay with the single cell, but add more numbers. I.e.
   0 = I2S on stream 0,
   1 = S/PDIF on stream 0
   2 = I2S on stream 1,
   3 = S/PDIF on stream 1
   4 = I2S on stream 2,
   5 = S/PDIF on stream 2

2. Add yet another cell, so that there is one argument for the stream ID
   and one argument to select between S/PDIF and I2S. I.e.
   0 0 = I2S on stream 0
   0 1 = S/PDIF on stream 0
   1 0 = I2S on stream 1
   1 1 = S/PDIF on stream 1
   2 0 = I2S on stream 2
   2 1 = S/PDIF on stream 2

3. Create one subnode for each stream in the DP controller with its
   own graph for the video streams. This would mean the MST binding
   is quite different from the SST one.

As it is unclear which way is the most sensible at this point in time,
just go with the most simple option for now and revisit this once MST
is added.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml     | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
index 2b0d9e23e943..c4f8959dd65d 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
@@ -25,7 +25,7 @@ description: |
   * Supports up to 8/10 bits per color component
   * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
   * Pixel clock up to 594MHz
-  * I2S, SPDIF audio interface
+  * I2S, S/PDIF audio interface
 
 properties:
   compatible:
@@ -46,7 +46,7 @@ properties:
       - description: DisplayPort AUX clock
       - description: HDCP clock
       - description: I2S interface clock
-      - description: SPDIF interfce clock
+      - description: S/PDIF interfce clock
 
   clock-names:
     minItems: 3
@@ -83,7 +83,8 @@ properties:
     maxItems: 1
 
   "#sound-dai-cells":
-    const: 0
+    const: 1
+    description: 0 for I2S, 1 for S/PDIF
 
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

