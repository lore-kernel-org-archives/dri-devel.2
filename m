Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA10BC98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB97610F449;
	Thu, 24 Sep 2026 10:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="k2HLPlEe";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9ddJAqV";
	dkim-atps=neutral
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5545D10F44C
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:23:18 +0000 (UTC)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 92E537A0050;
 Thu, 24 Sep 2026 06:23:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 06:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1790245396; x=
 1790331796; bh=0W5JnVFCLxYHk1UjZyoXr3Q03Be4HN+iUOU48SNzDLU=; b=k
 2HLPlEejb9pP8mRrnqLmiyjsERmIHvRvUOiOBxuTLdmioy/gJW+GUxjmx+KS0IL1
 wdL0IdG+kHdaxivJt19PSDaZ3RnG7YfGKLSoYhNONgYoWHg0mNSy+cVGSeMZSZNL
 RlT4IDkaNPMibk3cBfFff+bxZwZSSCSb5m6/Ly/XTNS4U6wqeQ5GKBdxUdsk9dFA
 fJQ3uWKl5QlOAMxPBufacp6/5v9wpWEOtztQccTLoXhSeQlk6vYzTOFYKgQ5vCX/
 3ZFyZpCxSQm/J2UL2A7eKFILnAAjruV5g4qLkAHepyoAT0I543BEtzNR0nWIrpFB
 /qvr1hkTvy8r7+4v65Ffw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790245396; x=1790331796; bh=0
 W5JnVFCLxYHk1UjZyoXr3Q03Be4HN+iUOU48SNzDLU=; b=A9ddJAqVJtOtV0xxr
 fQg1TTWnnP4pV3jMEJER0sM70Ic5tBGNskFdGxg6RHnxFShdHrM23UoSfQTX/0KX
 UW4HfFwwYkItIknZfMrhJEuo0/kv1ntWRdbKwfrY7Q7C5gbDMUmCzNscjh+ZONDv
 3nXoZ5B4I/LuUfkCCeU17qgTBS0gh3thj4qr45uy9rot2KBNYpS2Fay/pktZBgDJ
 F5Gz7nxBD7MwLUcJnQayRs8zXIB3NNQE8sFC0V7+8JYaMObIh/w+qqwSkGGNboYF
 57Iwh/tx1QN0lxdgplcnlsnrp1cGvAtIUSsU0TumL1UXGRFJ4Vgs9jSw7+Mml6fI
 o/6aQ==
X-ME-Sender: <xms:FPq0ailwg7NEJlE1x3fU0pta-G1N8yTVsD9iNZ33fvCVZG3LxYBETQ>
 <xme:FPq0agyZGnP2TIOY1TPEKy7L2qX0WgqFrW2WZeXqhQMJSk9wdxk8_FJWTryDfOGTj
 DcNQL5t0dxjoNVlLm1cyVAfWgnINyIp5akLSiq6cZoBcPUbDBJOpDfy>
X-ME-Received: <xmr:FPq0anGdpPI4ML1HUwcWAFAObVHVHvEDURQ-Vdu0pgTtZR-yzN6-JGZQFRGnzmDrWcRlP9QOGg>
X-ME-Proxy-Cause: dmFkZTELq7rC+LQVqiu/gcrSH3aInYY6gqrtJb1TMhDbAHvO04JQUIIHP3AFK/JZDFnirr
 /LCS7iwIa0Xn3NY3ypfX3W953vSm1XzbcZTwhAbuWyVGzgkCbGAWpfOaYhj6B16GvJSCX6
 j9yOIbo4VBTCIiPp27EHHIubtOZXziLgUan/aTl4K4IJw1TqkjRza++6PmB6uJ+DpQggDO
 HsQuFi9Uyp2gAbqQUqYHBWDuFQ3fwlHpxuZfcA/JbYFpIbiJqlD14oJ08B7l+dcCfBpRyD
 JZQhuxiPH/LTeCuOXO871QB5Yhln6qenlq1xKTn00dvKOR7LaB/1kGkjkZ8yWC1Ka1/5AO
 n1EQwr4pL2AhHCF4Pq/sLT/m3SVj5WKGAFhVqfM0coMMOBy/vvntl8ymimqgTgB5AWUs9M
 CSc2OS0tkrzCxUS9/SMT2gFU+Me8A5qZGa23Q6M09XCn2nsz3nk2WRVM0GOtrPGObdiut8
 hYQPbqyfVQGma2R+4m85+VDLN1CVuMMF2YZk+ZgyYZ23uviQUd7mUbIhdYz250WjACHGDP
 kvUCXerzRZmR8UOceNaaNq1ChOHcINfMpQjVHBq4rQSdiYbXrhkm/xdCIPHf0ibQr2tnzY
 3XhpV2C0TCLza+5wINgeiAW7w+gCMQq0i+3iBAck2+6aH05jx+eYSGPkH9eQ
X-ME-Proxy: <xmx:FPq0alGYKZlQKWSZT-lx1qkEwJ1NuPag7QVS8lRYxU4_vVe4lYOR5w>
 <xmx:FPq0aiDQ_2sBo6f3mj31XwXwJd6WJiPl8CF_stUly1KUD8uXmS4d4Q>
 <xmx:FPq0as_zBrSqgTKo42O-P9Jti0jAN9zkOU6TYpkT8avsIHHTZISopA>
 <xmx:FPq0ascLqAWwlDF4ek3bYQOmLBHu9hG1SYiHyFdLS9PgF8agC3e7Ww>
 <xmx:FPq0ahFp7_8T78yjJhbRD7cJrR5CawgTu5A2ROCZcR9ItVtZhUDQL1dq>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:23:07 -0400 (EDT)
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
Subject: [PATCH v14 07/15] dt-bindings: power: rockchip: allow resets in a
 power domain node
Date: Thu, 24 Sep 2026 22:21:27 +1200
Message-ID: <20260924102135.92217-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
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

Some domains need a reset cycled once power is on. The RK3576 NPU domains
are one: without it the first access after power-on takes an async SError.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
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

