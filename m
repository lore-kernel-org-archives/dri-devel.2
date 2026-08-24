Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF9AC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346C310E705;
	Mon, 24 Aug 2026 11:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="kLDJkNZh";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4X0gETv";
	dkim-atps=neutral
Received: from flow-b1-smtp.messagingengine.com
 (flow-b1-smtp.messagingengine.com [202.12.124.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C54210E705
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:10:10 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.stl.internal (Postfix) with ESMTP id 27AFF1300139;
 Mon, 24 Aug 2026 07:10:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 07:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1787569808; x=
 1787573408; bh=OySDevrrI40i+GobXOkYgg/pX4BBqshAOlV1V9u/EO4=; b=k
 LDJkNZhuBrgrtUXiRN598I9QaQJpPXa+ArVJrc1s6soWvOcelF0uvhyryS6TuKsU
 OQBcxhtZ/cnpLLkAegEYW/JnGw4t7YNO2CcQXR0H4Yt1i2sVAPB16WKCL8smV7PI
 xmaQeiCuDP8jEL9wUsHfnozWoyh7Id320wKEf3FmSiEXaSEkVjEoPhAzqTWkdUR4
 bHy+CisvMR6O3RbutLyeGnMTXMcdHGEni2aLE92Th/W5dOzequ3QEbwqy6GiKIAN
 9i/Aavcl6XBAZZvbDp/lRKBa0dTE28G8MyEMgB2N+qiuu2B3Dcak5u+vj+5SwZ7A
 eHJ+DCgO49dsnV3mVjcrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787569808; x=1787573408; bh=O
 ySDevrrI40i+GobXOkYgg/pX4BBqshAOlV1V9u/EO4=; b=c4X0gETvxpud7gAkI
 Mo+M4+6Vy0NVk5/hmcFbj/ZSfX2oX8BT8cFPJpbPy9++8UlRsUYBexGRQEuHHUjh
 l6qiToLFY3YDrSVkzUcgT6EjZkwUCTs3MAGfSVEKN+Y8Eml7vqRGNxwQEbyPQmPF
 OVF6E9ZxLuJ8ATe6X6uPzb0FWa22je6Fvlo33KvQtdnyIJUQi5aufAuUoC918zih
 VSK02VePJ35Pd8rnLvHRCNGGU6HSoW9mdLzIVPR14O7I3HYq36yWcd9eBcq8ivdC
 ltNftVfikKltlRLyOCLymBJePhHQbhQuid3LCps1FBd5guKh2IOqWIEv8qoGNDRW
 /BrLQ==
X-ME-Sender: <xms:kCaMah8PgVI26cyrow6uaAHrQtUBRhOtH9qafcACH1JApNzHsxDz9g>
 <xme:kCaMavB7e9jU7ns9TKI7qWJ3tu9Hd4ajnS6lb34jaVWFGJ-W0ovoy5epiNnV0CV7s
 upnd1w8vE1Z1S88JWJJP2_xYM5hnJDHKAzxmsr9Tifxzb63ZC35sYqW>
X-ME-Received: <xmr:kCaManDO_si51pcgcyExwxVaSDzR4s4_scezQlSQHF8dvjuiP0jqHA8kYHcCNbNjNP9FMdto3g>
X-ME-Proxy-Cause: dmFkZTF5gEktT6ey77lDLiQq6f/Ez8J2CsM/d3gBsm6ZfoPCVc/9AV7mEHI5Zbyf95LLfC
 4CQZzzSMKsGOWFY6Gt1SR6Kg796PA74a5HKg+kJTffI+dHfHM7XpLXiY581SkqQlRS1Qpb
 Wc7L/7AOy1fxPA6AupG4lWF4eQcqcj+B5Us1y3xgEinw7ECHWnH4TUGN/Wc0N0DXq0ZSfP
 9JPYy4GlPPuk3ysPhnSrwkCDIcEjzIDaM1hfK2Baaq1+/twwAHRGUHWNns+kLLhO/Id8IP
 KX24rOTlVfxpe1eJUKO7ADpaCjWUyCdmClqx1ou3BnFgw7zCxe6lZ464NK9v0PjzehFWRA
 aMitl1K9EXew2L0hWcnZpdyjgHglxBzMFJZjTGpr/KtQHho8oE8reUdvDIXf7rEl5mSe5C
 EFbjSeKgoqqLuobmWa3MusLGDQHpDuN5v8pnD0G+U3GxZhsQei25SwhJqRv8hUAfLIfg2g
 /R9CJ6v8GwISb1okOacpc6GID+KB5xawCaopqBus0RMSKjupmg2J9+xpzcnD/Cy/w8U5Ed
 iALIWWNvYf0ZyK3zyrTTPIs97CbUhqwqJtI5uTs5I1NuBjVYCQOWtTqkYDTPba84JNYrhL
 GgVuGThX3FY4vt56XjYSjY9dYTD99cx0d+TRVFHDIlEjjsLWrrt52EBOeQ0Q
X-ME-Proxy: <xmx:kCaMavLkRTUUhkOHCNJXh-L7E7-wEi7jw2HhRkn4Uf4PaFmGsLIl5A>
 <xmx:kCaMahSRfQkpVVuCnA0CyThVBds5U9BdyXSxbigzhNeEnC3n-b5gAg>
 <xmx:kCaMaiQVNqlOfKxAMJCfRyYfSXvCYK1gh1WYXB8p5XMzACDi5xFwvg>
 <xmx:kCaMas5u2eEimsgi_uIUCOfJjp3Kqe3idNqUkQzQEy3kYg8YGjPoNw>
 <xmx:kCaMaqjeGuVRO7NjLgFLdBkPNcWLZiCN70Oi0wzoks5tbh5ZokY2To0x>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:10:00 -0400 (EDT)
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
Subject: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Mon, 24 Aug 2026 23:08:54 +1200
Message-ID: <ed82f56171bbab8b150d3512412cda12e7e09a7d.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
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

