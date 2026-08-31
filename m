Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308F6C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF3310E266;
	Mon, 31 Aug 2026 08:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="sX2cxHa4";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmE4+3iW";
	dkim-atps=neutral
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31AC10E266
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:21:06 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.phl.internal (Postfix) with ESMTP id 5AAA71380074;
 Mon, 31 Aug 2026 04:21:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 04:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1788164466; x=
 1788171666; bh=OySDevrrI40i+GobXOkYgg/pX4BBqshAOlV1V9u/EO4=; b=s
 X2cxHa4GS7Qpxdi5kZyWmfglGGEARi81GHBrKHhbCitq1BmDmRYySiRNJ/aHNVL/
 74ElVDNLlxh5NUiScMOolLJ0NJQI652U63X6hVj+6plmWvASM9Or3IFBsc5ORWGR
 S5bVDpPhiUY/NMlzcM6flyyb1M7RCFquZaNVNd50PATUp/dtj0C8ZiOdDpbwE6jF
 Ii8zfTe3mGFY9APS3A/YQmR5jnpGsGEByYoTbOkIUJp9voN9Ess5U8hMyvNbr959
 guA+FECtfukfGZBfyWKbxRMRQ7aogYY/uXOFFErvxTPJVC1C9LgILeCAnoysOrv8
 ASSZRrtBq+3UIrhDKxmMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1788164466; x=1788171666; bh=O
 ySDevrrI40i+GobXOkYgg/pX4BBqshAOlV1V9u/EO4=; b=VmE4+3iWGuMh39x+e
 b0d3821m0KR2AltYTUXvnVZsWz3DtXV5CLBHuti6yAj39P55sn8qcVw86/xUUjam
 QRNIcZ6cLhrWlNGc9EXiZ4kNySjZNgTFkwjgn2EJrAalcztXtjTGM5cVGK6upaEW
 8LEDqGlLyH8qvVtyIl0U2SSc6eNHPTZrHrh+1QZlNG1Fa/dEqpRNR4SltCNfwARq
 7ZidHpnMzq2khqcc2UyaLBLA1nsyCae2L0thfjLnSblk2Z4BgewWRLz0kb0j8B5P
 DSOD9vlbVgo4DgszfkVOipMJQWRhrcaQdvVR1GHvKTDy9E2DNK3hsIN264a5y5lg
 8lYaQ==
X-ME-Sender: <xms:cjmVakFevr-pSXR4p9gpjDhPm7lQiAnAutGPCdeDARVrQl4sqGfC2w>
 <xme:cjmVau_mtzJwuvehCmQC47U7H0HqvtdppOKgs74Rz3JnQngSpzSRtYHIxsL2mCVpE
 hdeTj9kDmJGMIq2ukdAi2itoLgLJ8fzLJO48JCOx_MxnSV3SYqmKqs>
X-ME-Received: <xmr:cjmVas23DZya2Luf-N82BJw-QqMfaZS2ndVBNoYfPOIraFXPuQDz3tZWyaMahqmO59udBdGJFQ>
X-ME-Proxy-Cause: dmFkZTEKWQSpa8iZqUtW1ZQqP4bDvh9SK/YZ53CarhgclGKwi9pBkSeAm2pl18Ydw9NqYm
 Zr/AB6JK94O+RJj3+nPdviPN4WL0ogDKkl2CMFV9N9D6NSBN5M/LV+S4GH+TRhS9zu3x5c
 x2UqefLwNZ1g6jIgnHYbLgvH6Qcfxwr5ayCKwx4jXlH2P7ErMCLVryfACFcfAxxNF+zWzB
 vhDdjBzJlYCkkDZuwtnUqHTI+YlUUPPhU6uGHE0mVT/tu7g0EvFCbzZenGG7GfkWbRsTX/
 Fnz7vKpfqzHdp9e6NpI62zQZ3fDQSeSft9eBVteswNRFnAgakK0VawtlqkiHWFDHZGPme9
 FK+iRODoSKjjukM6Xyrcpmvw4fUtDI/0wnkrfFECfNyhK5vH7KZBoMhqKog/ArX+0KpeXP
 Etn9iyKTthy2UGP2dk2e+rv4Z0yV8Gh/NsjJpGGuMF+uD8QsPKhwRbZgJDrCEZFMtzgh9j
 xRBKa/LyAOFhrJ2LRXf6yEDukjxeuWSt4G9wvWw0PgtjEDL1VU0xqPp9iumRgXsXJzdIYc
 8ZkzBx8oOoRySfWubwpotUODTY/sBT+Cx7gTfKjwE5Cxfpiib27eudYnDfwdm0xWZn8b0X
 8j8PkqzWlkcOGMZ6Yfz9FUPGuoEI/2FhrOIQNl9dzbdK1qzyfLUP/ZghXt/g
X-ME-Proxy: <xmx:cjmVaunH7LO8Yk7bi9mjK2DiHV0C1lz60x1Mcp4IqFvVJ2tUwvwmOA>
 <xmx:cjmVaq-K3Dlob9smX9UE2F53wAdyuliVrt_WUo_3Ofgr-OPXZgPOWA>
 <xmx:cjmVaj5QhbJSg4Gs_1EOxT6uk4JzQzz15nxpCHti9Cd55eeeGsEJLA>
 <xmx:cjmVaqK_sIOhUoQ1XwJS6XxKeKPg3YyDThyyFWoH0S9qjhcZC-17kA>
 <xmx:cjmVajVnkM_2hxEEv_Xyessb2zOguFkLxw0bTz87PnzRQ9rdnjaOf1_8>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:20:58 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v11 06/14] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Mon, 31 Aug 2026 20:19:48 +1200
Message-ID: <20260831081956.84871-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081956.84871-1-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
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

The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
already describes, but it wires them up differently: two extra CBUF
clocks, two power domains per core, and a single reset instead of two.
It also has no NPU SRAM supply.

Widen the property ranges to cover both, then pin each SoC back to its
own shape in allOf so nothing loosens for RK3588, and keep sram-supply
required for rockchip,rk3588-rknn-core only.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a490..3b611b64c 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3576-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -33,14 +34,18 @@ properties:
       - const: core # Main NPU core processing unit registers
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   clock-names:
+    minItems: 4
     items:
       - const: aclk
       - const: hclk
       - const: npu
       - const: pclk
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   interrupts:
     maxItems: 1
@@ -51,12 +56,15 @@ properties:
   npu-supply: true
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   resets:
+    minItems: 1
     maxItems: 2
 
   reset-names:
+    minItems: 1
     items:
       - const: srst_a
       - const: srst_h
@@ -75,7 +83,40 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+        power-domains:
+          maxItems: 1
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+      required:
+        - sram-supply
+    else:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+        power-domains:
+          minItems: 2
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+        sram-supply: false
 
 additionalProperties: false
 
-- 
2.43.0

