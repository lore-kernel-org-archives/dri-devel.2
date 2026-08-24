Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABD4C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA92B10E70F;
	Mon, 24 Aug 2026 11:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="M/01Q3ha";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjPn9H2f";
	dkim-atps=neutral
Received: from flow-b1-smtp.messagingengine.com
 (flow-b1-smtp.messagingengine.com [202.12.124.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD62B10E70F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:10:30 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailflow.stl.internal (Postfix) with ESMTP id C5D811300135;
 Mon, 24 Aug 2026 07:10:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 24 Aug 2026 07:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1787569829; x=
 1787573429; bh=lby+YKGYne2e+SBq5qvdcTNcFHIm7YId3vHFaeK2h7M=; b=M
 /01Q3hadjc/Ko9oTVq5YTEHErZnXCaes+DMwojRFNFyTI0i//TQLUdYAKa9FJYB6
 fpZ9gZ+RRwg6LF8gfeTHZT2eLkod28aep96fC/wqJpzuTMm60AofNl5Qez2LAIoR
 iwsOwErzINDQRE8n+BuSjbeV20JoXM7rI77Cpg5BJM4hSqhbt247xWk8QdAm+A8w
 o3x/7+NwJoRu9KzhiwSFxyoQeEiUJioMLptev1Eu4nPWDjIoPmZGsd53tvQ2Irju
 svBGosbsvfegM9wSKWE3V2KVmhaQVDXto9ppm9HAlyWLJSMCSMOTxiJV+JX6pjW6
 HtE8m/s37aiZ1lrh/82pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787569829; x=1787573429; bh=l
 by+YKGYne2e+SBq5qvdcTNcFHIm7YId3vHFaeK2h7M=; b=fjPn9H2fL27oUrXOI
 N7amHGFTI+JpjqA7i/q9GZKu9V1BK524nmtqyGZjiTstGvcVrlzrV9EAJT9XcQtm
 QPmMaEbN7ODFIyrWLjsxDOTo9WaE5Y2h+vIg3aVdYmUNOxIKgaOqVb0bSq+t6VkY
 u/TECNtvfaPBIcYEvFG5CzuXmPox4CwAwV1wQw2wcjwdlivJo0IKJU52pZiOS6ry
 JVvJzEIZTiMXLcxRjKkqTEUfYno7p/TAHqH+UCcKbaFu27tDrW9PPc5zLXOJ+1pP
 9siRAfpPrkQrW0d7JUkBLN1e+wIQ5uD00eVLxByFRFnm0MyA6yeqpwWLaFzOMfOD
 3JVtg==
X-ME-Sender: <xms:pSaMajrvySCexnTvNCs85HH-tqx4lxySpfbjBrXPh2jKICD9SdJBXw>
 <xme:pSaMapL-OI8qPC8jMXxyhKxLv9RylV4ATVNNizAPfy9n1d7tzNcKCUiQ_eumIjnks
 nwereObEaap5n9xvZfxjETuBkel34VdpoYTr6Em0on5eTp3BJCiZZKl>
X-ME-Received: <xmr:pSaMamNHRGLgCAxYuZ1qdeYCYZ71TZuey1Snerhf6ec3KAB70Ezh1ariM42k6hUcjW46xAlZhA>
X-ME-Proxy-Cause: dmFkZTFZCbpsgW1YFD8tkPvHCNfxYRvTZ4blFH/NRV/HzygHIZO36nEMOhE1d730qpXJvh
 mj3vwdyckgY6cjcLbWoO+E+Y3xnZHjj3a4qFKPUp4C1ItOyypDc5v9ubc43QMrvknpo3YV
 t254bBqkhHFILTMaiaOskey67wujVC060Hg7shRsjYN75EBvtRkSi+gTwzTAT9QI5uwF5a
 jKY8X+yRsMvgEojvqKUbS+n33ebqC8Mk85kgoigVyIrVFWYfmyd/lA/A6ULdG/inFBXWp7
 ziuYhhyF6f7lNHjxbQ4kgWN86q7p7VmrRBdAb8OqXw1LSsz5kDP4W0+4ny2SVIkbn/odQd
 OaMt+H1XzXP7l+OjzvSXZQQ3HJ08Vynx97eZaGiBWsKAzmQ0aVyWJ6HlidrMdKmPguh+kL
 +54Mbl33ZHa8+tRPWNWeoWZHSx4dD5jk+UbyNX7eFiPjeRzHN4F8A2AwJRTKNklsQYdtmq
 EsTsIZBOLs8bcmzya9zRvlpoehYFm9tNAOcnf0pS9/0j2/YyPVKvRVfFOpIq4dJTgsUffN
 dxH10DfthQ+/gJse2saSqdm0Dzeg9RAOWJ62iQD2E5Z207VYTtV1ubQgcBw8PPcmsLNxjC
 WTC297knzs2NLp+i3I+P2vx1RuexSc/az/ZqbiiHZZ/gYFYJP3rbjmgGeGMw
X-ME-Proxy: <xmx:pSaMakosAQ-XzyxpPP3hYqpiwV1Fv4ugKzNLSHBNuZUlu8DIOStgeQ>
 <xmx:pSaMaoGdXMQ-Cv9W867Ve-vd43lXFAvtcyPOHXHs8p8mohE5svOzPg>
 <xmx:pSaMapKxLQA83BaKXYHAHEgShHEv6MtonJxU1x30okgKjiN7n_QhgA>
 <xmx:pSaMathf2tmTmKPy2QKahl_5lOWPXwBcKe1wM4TFsyf6OWImeBaRgQ>
 <xmx:pSaMaig9-PYCACf0u16uP-5zvcjULfVKh1PJTB9MpPI6Tcin4JwHF4eS>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:10:22 -0400 (EDT)
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
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v9 07/13] dt-bindings: iommu: rockchip: describe the RK3576
 NPU MMU
Date: Mon, 24 Aug 2026 23:08:56 +1200
Message-ID: <34a972915214bfc4034c797df1c4a033f3b03e2a.1787568944.git.gahing@gahingwoo.com>
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

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks
where every other Rockchip MMU takes two, the extra three being the
compute clock and the two convolution buffer clocks.

Give them a compatible of their own and pin both sides with an allOf, so
that an rk3568-iommu cannot carry five clocks and an NPU MMU cannot
carry two. Describing the extra clocks as belonging to one SoC without
saying so in the schema, which is what a comment on a description does,
leaves both of those spellings valid.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
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

