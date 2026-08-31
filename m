Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA79AC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0559010E74D;
	Mon, 31 Aug 2026 08:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ibDflDyj";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CN5zPA41";
	dkim-atps=neutral
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C07210E74D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:21:27 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id B631E1380045;
 Mon, 31 Aug 2026 04:21:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 04:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1788164486; x=
 1788171686; bh=Bm7huY5WQXjxwqWxfiTvH04R09OwCZF8hQZPpxtRqLo=; b=i
 bDflDyjBgQ0J+IIy4xlOXSay/81GUr8smw5IDwtIoHehw9BVCj6u44zGqvj2umV8
 NBT98cLunQVdT5dk7z/2T8FXrfTU6k1FEkOS6GWFyD8p2tUdhtQYTd58EPUkGfOL
 IdcYlwwAFsw7aTnZKxQZsGMBRHlBZboEFBbR6MVB+MJHoMs/+cn6OmiX9ln9AriD
 21yZQss5nPmT/my/KwxZZrMbKbNK3Vy1xOyyHp0EVfR5ptCnimTm2Aa4v+wkfjUo
 eRLu4EkFlq2dLblJt7+To5Pi2ynAx4QhMCKIBFrAMvmDKy/QWPMZw30KySDi8Q3A
 nP8JnyAuJQOE7cWrm5meA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1788164486; x=1788171686; bh=B
 m7huY5WQXjxwqWxfiTvH04R09OwCZF8hQZPpxtRqLo=; b=CN5zPA41V+cL4kDhz
 cNMRI6ph8Op0KW4QcbIQLaiDSzMTPwkz1dr1+uwtm+hRqliYfWFeW50Ir6Ff4qKL
 XSiKMkEgxTgtoz+27EQrusul5f7ZTjLOzaDCUdQPY6sJhGsFeESjsonbxgIRhENV
 BzkeOOI0+wcp9jUQ2F7bkItncxFefJw/wN/aATCIbV7hTA2gHcRS56XNdCa7wbl+
 qvnXLxbVUlE+ojGB7ogfjRMeicbhCmrgumWY6k7h4zW+bzeQZ9HYcbzSZfxf6C8v
 Qb9LU0Aap1atfNNiuGXvknBklyt3LdZhz0D1fyjMn4jwKSCwaj+4W0Lq43UOpE4M
 zdgPg==
X-ME-Sender: <xms:hjmVajjcN_O7xuMh6oEGobVB7bSXiE_TlYgIZUFfr8-EAH32IMCCvg>
 <xme:hjmVaoash7ycS1JuYPPW3YpxJmCS8T0yPQeOHLENXe1Vx2PLcef4OUA1KMiLwehtS
 eHrZSfc4hfIoPuCOJCXA3ngn_x0oL5NrXN7MowQOndoE8iMjgoFccM8>
X-ME-Received: <xmr:hjmValQxEZUMo_rZqj06LqNCj8Ix43KJRAiKJH4znKfA_1747Eha3YEqg9rNrxYchT1HmhwKtQ>
X-ME-Proxy-Cause: dmFkZTGdGJxeVuW+Fmrt/Ef5qeMDFHGjonl8OVkqV4Q9pjx4ZDlXIa4Z3pOc6nqsAGbFM5
 cWlbiX1SVX30CexdPBxYt3awlQb1f1VabgQ1+kwGrf/tqGBQR6d2lw5RrnEV6FL0zCLBXY
 ybqqMjW04LTdiKVaoW/ueoWC57BUXXhq/gLbRORJuDA51/iSsme3r5tmV2YwHq2SFTmV8f
 qmkLVMySqF/+M0VTPAV1bEl/RNXhLViTLJtdkIjM0/0F1iGTOIQFc8XdpRTpYODYq5KIVJ
 rrfOCVoYg5oCW3a07vpVJtmuFrLRw/b3yMPQFvd+9PcwM7BPjK/SyOTGn8jtYhGarwxLdb
 xXbl3j/fcqsE7TsqdsIqt3W5yY8+Dbkb1p0BNv6PM+egLTskWXj+912F8OUU/DaLhEfQ4X
 lq4oRCA/JrphBVR8E/44M+b9AwF1BD6npJme38cKZEcTqrfUrgx5j/K+Dx912pDCFTwcay
 /gErKAsoa4jXfcojxfpMMFTnsoxGNWZ6fOQf1Pn+jhMX0A9E4BdYmzPsoP2tSiYKapwCfQ
 71iu8EIi0sZFvZ6OLtxe86qwLP1f5lLaKPo28LyU4bM1Ka+Yp44jRq6a3SNKCbw8xbczuP
 ZP6YPztvg1WhRkz3vw8ueCsXH0ZOACh3cvdv3GU8v6DPKNZ1YlTRyNXVp48w
X-ME-Proxy: <xmx:hjmVaoGqcS0uMWK62EKdPtjEk_aKmkJ1282vKznIMJhWd1axM8xhtA>
 <xmx:hjmVai3oUs_J8PwbWb33k-XC9vNEAh3MYxj6XZwMLuNn-jPWz2fXPw>
 <xmx:hjmVamuocBZGMlg9LGdBuZJLPd42CwggHTCEWxHkYluFfoeJaL0Z3Q>
 <xmx:hjmVapmB3XVsGE8dgJMSrE-dZe95yUGPrJ8mTB2sWd2WjyGDqY-IPw>
 <xmx:hjmVauWkD_Y38sJRc6gHrikHweBX0dehBvV0yPHC3NLQvf3EQbFVWPFV>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:21:19 -0400 (EDT)
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
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v11 08/14] dt-bindings: iommu: rockchip: describe the RK3576
 NPU MMU
Date: Mon, 31 Aug 2026 20:19:50 +1200
Message-ID: <20260831081956.84871-9-gahing@gahingwoo.com>
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

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks
where every other Rockchip MMU takes two, the extra three being the
compute clock and the two convolution buffer clocks.

Give them a compatible of their own and pin both sides with an allOf, so
that an rk3568-iommu cannot carry five clocks and an NPU MMU cannot
carry two. Describing the extra clocks as belonging to one SoC without
saying so in the schema, which is what a comment on a description does,
leaves both of those spellings valid.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iommu/rockchip,iommu.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11f..83d7e7c8e 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3576-iommu
+              - rockchip,rk3576-npu-iommu
               - rockchip,rk3588-iommu
           - const: rockchip,rk3568-iommu
 
@@ -42,14 +43,22 @@ properties:
     minItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Core clock
       - description: Interface clock
+      - description: Compute clock
+      - description: Convolution buffer core clock
+      - description: Convolution buffer interface clock
 
   clock-names:
+    minItems: 2
     items:
       - const: aclk
       - const: iface
+      - const: npu
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   "#iommu-cells":
     const: 0
@@ -72,6 +81,25 @@ required:
   - clock-names
   - "#iommu-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-npu-iommu
+    then:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          minItems: 5
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

