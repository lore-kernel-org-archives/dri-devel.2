Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED0BCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878C210E7EB;
	Tue, 13 Oct 2026 12:55:08 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 13 Oct 2026 12:55:01 UTC
Received: from mail-m158125.netease.com (mail-m158125.netease.com
 [47.251.158.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3F610E7EB
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:55:01 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 50e2b940d;
 Tue, 13 Oct 2026 20:49:53 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dave Jones <s.dave.jones@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 1/6] dt-bindings: display: rockchip: analogix-dp: Add
 support for RK3568
Date: Tue, 13 Oct 2026 20:49:41 +0800
Message-Id: <20261013124946.1807886-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013124946.1807886-1-damon.ding@rock-chips.com>
References: <20261013124946.1807886-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1354ff06a03a8kunm2e7c128b3006
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEpNVkgZHkxNTENJGUgfT1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=esBq9R/0QwuJDYEtUDg/KknoEf7ksaQ6gizTruRkyCR2u10Wc22GMR33bSvqXmlMkjNtueJ7cE8cwrjHlLY2rslWcSTFtVpKvEdcaZcIXtZEaxocYkP0xempWqC3vjvhud7ANeDNZ0SFpMljUV3zVZ4fM5VKFGRE5yhXiW6CMBs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=aqA05e3tEQzex5IV+W6xDQvoZ2RGk3y5IlP3Z09UWS0=;
 h=date:mime-version:subject:message-id:from;
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

Document the "rockchip,rk3568-edp" compatible.  Like RK3576/RK3588,
the RK3568 eDP controller has the dp/pclk/hclk clocks and dp/apb
resets, but unlike them it does not use GRF registers, so make the
"rockchip,grf" property conditional on the SoC.

Also document the optional avdd-0v9 and avdd-1v8 supplies, which are
needed by the RK3568 eDP controller.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../rockchip/rockchip,analogix-dp.yaml        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
index 39dafe75a680..f8670a4e0430 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - rockchip,rk3288-dp
       - rockchip,rk3399-edp
+      - rockchip,rk3568-edp
       - rockchip,rk3576-edp
       - rockchip,rk3588-edp
 
@@ -47,6 +48,16 @@ properties:
       - const: dp
       - const: apb
 
+  avdd-0v9-supply:
+    description:
+      A 0.9V supply that powers up the SoC internal circuitry. The actual
+      supply source varies between different boards.
+
+  avdd-1v8-supply:
+    description:
+      A 1.8V supply that powers up the SoC internal circuitry. The actual
+      supply source varies between different boards.
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,11 +72,22 @@ required:
   - clock-names
   - resets
   - reset-names
-  - rockchip,grf
 
 allOf:
   - $ref: /schemas/display/bridge/analogix,dp.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-edp
+    then:
+      properties:
+        rockchip,grf: false
+    else:
+      required:
+        - rockchip,grf
+
   - if:
       properties:
         compatible:
@@ -100,6 +122,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3568-edp
               - rockchip,rk3576-edp
               - rockchip,rk3588-edp
     then:
-- 
2.34.1

