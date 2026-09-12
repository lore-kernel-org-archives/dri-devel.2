Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0858DC88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 06:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458BF10E5F4;
	Sat, 12 Sep 2026 06:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="aoq0qVOD";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/vijw4k";
	dkim-atps=neutral
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F9710E5F4
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 06:52:39 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id B8D951D0009D;
 Sat, 12 Sep 2026 02:52:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sat, 12 Sep 2026 02:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1789195958; x=
 1789282358; bh=EM0swreY1zyIAIB6E9vTAuQx73Txv82P4kLUWclFi0w=; b=a
 oq0qVODpppXKnPRakSL5E6z54rIYx4vH9BACdB7jMkMe9HbOxUYFUEVT8VZH6mfh
 CWmJLMQsJbMATTWzb29O63Eg1JQ9CCSrqPe4oFPJL5YWGNGbGVLraQmQjPVHLasL
 dpS0qnd/CGe8Cz+xVsHqEcXRpqIWOE3/ZolRMrChlWGGWsD8his0p5Y3PbvpYLPz
 xH/+EkHk5P3xFkK3naJUDu3MRlQLoQDul6LB31LkPlZU1UaXG6U3Ds9lrdh6ylz3
 /1LzvioFmF3thYu+BIZ/MjwZMjm9Cn9aK+IfTN2C+l3EyLkqVtht5b4dYYB0R0ic
 1eXis/56g82MPQJLsBc/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1789195958; x=1789282358; bh=E
 M0swreY1zyIAIB6E9vTAuQx73Txv82P4kLUWclFi0w=; b=H/vijw4kICc2fVZlB
 yJKypO0KFUUji0jL4rjBWUM9sjnePPp4ktyF5Toxgwh4BIgl7AYM31K4qab3De1A
 E9l7x3SQ4VomBoYrMq5UE7w4qp+ZEJOqvfCZl7J99/HnIGJAn/pgpUHh0nC881lV
 4CDWaZS70dzUv14KByoH9bigftxeHRcIfRjVOS+aizD0q8RPueg/U7NbBO6L2PNE
 INknbFY8TklEZz2R9pHzaT2nOQ9Ek1kPxuFiVDu4GewRWED7rtUMMVEOF74jFlff
 Do12qUYK0PTlnfG3BLUcnQp7spinIpzH50dWdmINK6MOeWYnm2nuSKcHgaBHEfAg
 aV3sg==
X-ME-Sender: <xms:tvakapW6psx364_M0Rvvqju1Hh0uyoQQWpWBbjafls2xbeozIQby0Q>
 <xme:tvakaghRjh_FiGyfIQbFmeQnhVSUSduUC-TLCwipqBFfqrzIjfd59CWfeBmuYEboJ
 Lbxkum3iaGw1Er_obcrMMDjcUpZ0CcjRMsJiNNYTWRzH_LFKciudQY->
X-ME-Received: <xmr:tvakar1bhnvYOu349tWDgcjc9JpU734w2jE3obtb-ue6mzN5FOdz6et4RzbNLGtUhVJTbx4bzA>
X-ME-Proxy-Cause: dmFkZTGcFzQLfCTns7TE5rL/P1eVKE8QA21beBwBFkyY9YTeXq4RsTqFTQqy8xwPCXflst
 Bzb2WN8+Z9wMsDPevozKXmCdfbpB7u35gxPBdZcE1OggzV+SpuJLXHq2biTYWRbmSZxKVK
 SGSCjqFmU7DVBX5xWAgirxAFKhQFJBsPmOT+6pwgRseCRI2yQSz8RIt35R9bMFoCkvmZR+
 9iAYcTwRUMbNeagNJ0dRavH1kOhxbKzZutjdkaXg936crjsT5yruCxuJ1iD3z1iXsOeTBA
 gQ1aPtegLyhOeojTrex/RjcmOrlktpryCA6Bl5bNjcl7LPMImDh/uFZbWCql0nAGPJnZaS
 zdKKvXa9SA/dGvws1TOyEh4ZUXZwlBjLII62HKVkwVWgeGVwaFrXrqpY9VMxugXm0tfJ3/
 a1Hu10SVG6l8yxaYgppfYRNzLZB1Zu4LV7oBec8+/THRnRnkSSUDpzp08N2EXsaGtTgH3o
 4MqKgHXLt4qQ0s7ONoZ1jieJ56CXHsqa2vkw35koiK6l+a1GFV3bwjREl0CKNQ2xNU5svW
 /5VzqqwQwZpMq6rwcTQKwc5oSwhb5stX3oyKZ8boDg1Qlr9UJznRmjCM8KFAEKj6i/sQU0
 h3v4gaK3+wYc/UUM1XeyKLDSvqnAhZtGhq/pLutoaM3/FuO3/FNT/6FIMvbw
X-ME-Proxy: <xmx:tvakaq3mTwhfmbBRv1mkb6vUa8FIGGRwi1iv02OzDQZinKS991sNLw>
 <xmx:tvakakzVhS4O7u3OLJxELVNoESPZr-Tl0u_tumlpKCpNy0Qv-mGWBw>
 <xmx:tvakaouvTNxHbbIrU9v6KCf9UpYLhXAheHycsrAOfOkqD3jc7vROLg>
 <xmx:tvakatPiU-u3fKJV7ph_oDBk5NHSOpfsge5-xPqQJNyrlkr--y_Qvw>
 <xmx:tvakau3SMq_KM1pHwxDvHXU9nfuhDVhchP4WeYiyCYFhRZgTnv7Pca10>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:52:30 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v12 08/14] dt-bindings: iommu: rockchip: describe the RK3576
 NPU MMU
Date: Sat, 12 Sep 2026 18:50:47 +1200
Message-ID: <20260912065053.1519165-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
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

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks where
every other Rockchip MMU takes two, the extra three being the compute clock
and the two convolution buffer clocks.

Give them a compatible of their own and pin both sides with an allOf, so
that an rk3568-iommu cannot carry five clocks and an NPU MMU cannot carry
two. Describing the extra clocks as belonging to one SoC without saying so
in the schema, which is what a comment on a description does, leaves both
of those spellings valid.

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

