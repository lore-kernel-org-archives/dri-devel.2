Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99520C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF58810E6EC;
	Mon, 31 Aug 2026 08:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FBA15nfl";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="M0sdoCPe";
	dkim-atps=neutral
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B01A10E6DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:21:17 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.phl.internal (Postfix) with ESMTP id E70371380074;
 Mon, 31 Aug 2026 04:21:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 04:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1788164476; x=
 1788171676; bh=W7m+cCkjA3WueMD/RPZpNcMr0lXTVLw93fSG4CHMuGk=; b=F
 BA15nfl4XMlldY/SWRxQZKiFoS0d8nHJg25a1URC1plCcMZuJh9GyPGFY54TZRSV
 vuATOsmXhKyNsyAATBX0iCAOphIryqSNPGavtCGc2aF8fvkqq++/u5wTsKS3L/Jg
 rMJlK3KWL4XxHJqSC/JgXI95WjMEYQxt20qEx9T/G6A3/lgGijnhf8O4hkd5o/YD
 oGqDj7PZcG433aX+sVqAdB78uy0W2ghQTQGjK5gp1fvlv/PiFkwmJspn8n0nXWZs
 EQTUmnu3kxQJgGrjCPOrfpsSclRpVk3fgDKNw28SDCTUD97mOx7bg+4dDHL/N6Hc
 qMHykoTYzjCAY0GVQ6BkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1788164476; x=1788171676; bh=W
 7m+cCkjA3WueMD/RPZpNcMr0lXTVLw93fSG4CHMuGk=; b=M0sdoCPecJefgty0L
 9yJtb1eecSqh4Fp1pVxJnFXDveH7QeOM8fMq7OiRrpvD9QFmwxqkNyoamEm+eIT/
 W7gdM7i4NaJ9IC2zhQiTwPxJG6FBuagZnZtYzYib2RgfS6Ii1SJa5w3QDSZ7pGRL
 GLGR43zFQh8s9mBlzyng+qnVkiDV81KJxUNLJh/zaY0EW7bXwyL+CiMZlmkwlU+w
 lLacYy5gbRITMPbvgb4UZlu1JgtSsxA9HRumqzhXoou2iVYpBlPgbDtFnk+8Ga+8
 9Fi4JDjcgufVP5CT9ip25+jnW3UNzm6724naaovZpb5dWJVsqP55q8+BESb157VZ
 MOdpA==
X-ME-Sender: <xms:fDmVapGn-d6ppb_ayKEXiB4Q4YqELEfhCoUsPpNxY-amFRNcTAdgDA>
 <xme:fDmVams3yd625-46ZHuGDmvWC-GdXb3HqnZoPB5f_iE2p0CqrHCq3PxGYJsACy0B2
 mK7-iAWfeiepHhy146uLSCKjmklFaC7GgxWwz923qa07OO6UHuQp_Y>
X-ME-Received: <xmr:fDmVatUS367rMwoRr4JqTZDKlFWO1lp-x_KeLXLldh6CFApUy4ACDXvWCmxSE3ncRrQLO9MyHg>
X-ME-Proxy-Cause: dmFkZTEKWQSpa8iZqUtW1ZQqP4bDvh9SK/YZ53CarhgclGKwi9pBkSeAm2pl18Ydw9NqYm
 Zr/AB6JK94O+RJj3+nPdviPN4WL0ogDKkl2CMFV9N9D6NSBN5M/LV+S4GH+TRhS9zu3x5c
 x2UqefLwNZ1g6jIgnHYbLgvH6Qcfxwr5ayCKwx4jXlH2P7ErMCLVryfACFcfAxxNF+zWzB
 vhDdjBzJlYCkkDZuwtnUqHTI+YlUUPPhU6uGHE0mVT/tu7g0EvFCbzZenGG7GfkWbRsTX/
 Fnz7vKpfqzHdp9e6NpI62zQZ3fDQSeSft9eBVteswNRFnAgakK0VawtlqkiHWFDHZGPmGy
 ES5cI/K4VKSyJ3NT8NrFVMq3e235rxbEpOwsyuw/XGIxET5zjS9kaaOq0ERZHsHWwsL3LD
 iCRjxH4INK6zOwqMV8vRJID7sEzY215dgJOz/LIPs7XbSoLgejsLkuf3A2xSpLC43BVJqT
 fa81NwWad6rIk8RtsvWSRzSln02R4zJgW1Djw5ShC01BtYrWZo2zD6HQEc8Ht+kJLrWNFI
 u8f/54JTonqlMAbDCCHB2hIYvrCNN4xWH24nUaYvQ7gc86VDxTEXdjVgPN9GPtqTic7yJG
 k72T/Zjiji9JBSgNqLaUakxB8frfuI6xr0HNDhPryC6AOqMGwObQri7qs+ug
X-ME-Proxy: <xmx:fDmVam6UoOPO5M_luWFbINeeExwdFBOrg0yYC9lUPbMnfMDtiDZ6nA>
 <xmx:fDmVahZw87M-M_vlQVEkkPsO_4Nm398T01HC7kI6aPpl1weqmiHvkg>
 <xmx:fDmVaqDcsQEVkeZ9NY47fZi6-csqJ_DhhlMF1yyZJd4K5CkzihUIHA>
 <xmx:fDmVaipaZEzdlC2m2EQlJV3WKacnzv9NSo8LXab7m8GlnV9w9OQ7qA>
 <xmx:fDmVavrSgQUC73R4wKI0m4kPMTwvErcdnBk9Foc2ZJSGnJ_9OsrieHbV>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:21:08 -0400 (EDT)
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
Subject: [PATCH v11 07/14] dt-bindings: power: rockchip: allow resets in a
 power domain node
Date: Mon, 31 Aug 2026 20:19:49 +1200
Message-ID: <20260831081956.84871-8-gahing@gahingwoo.com>
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

Some domains do not come up in a usable state on their own and need
their resets cycled once power is on. The RK3576 NPU domains are one
case: without it the first access after power-on takes an async SError.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f..83741f048 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,13 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        maxItems: 1
+        description:
+          A phandle to a reset that needs to be cycled once the power domain has
+          been switched on, for domains whose logic does not come up in a usable
+          state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
@@ -216,6 +223,7 @@ examples:
                     reg = <RK3399_PD_IEP>;
                     clocks = <&cru ACLK_IEP>,
                              <&cru HCLK_IEP>;
+                    resets = <&cru SRST_A_IEP>;
                     pm_qos = <&qos_iep>;
                     #power-domain-cells = <0>;
                 };
-- 
2.43.0

