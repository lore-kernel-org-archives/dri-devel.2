Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E4C54F4D
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 04:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAF410F500;
	Sat, 25 Jul 2026 04:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="knQSHNZu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700C410E101
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 04:51:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B30A34514D;
 Sat, 25 Jul 2026 04:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A0F8C2BCFC;
 Sat, 25 Jul 2026 04:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1784955084;
 bh=Rkm4yLZkUVi1jkAlFm0cNMZPkaQrtPP2msdJ53rTp0g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=knQSHNZuPe202s27pflHGQNgifQKNbHnZwraPtYZpbv5Up/ecjXqZLt/iruppJT7y
 LgHzRBAbmI4WKBxp785bFoMaCtjY+Rm97gFcfYW1EEwVse3eWGgG4ACsVn4hGG+ajn
 lvfj5XaeNnoLpx40T+N9OKTJwG44GaqxbTCPLGPiUQjA7w/zJjQVrsIaIzQy4Ot6ci
 X0FKJ9LYmJKrnSw7jnYVK5/P4+OWMwBj8vFZzp5nx73wFOP5VGahw8tK8DDrShrHd+
 +i5kJx8JpjUofuheAMdDZXoE/UCMtynRMEGEdU/H6G6oIZsQdS1C0hNU3KQovznea0
 KE1i51pdn6H2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6B8C53219;
 Sat, 25 Jul 2026 04:51:24 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Date: Sat, 25 Jul 2026 00:51:13 -0400
Subject: [PATCH RESEND 04/17] dt-bindings: soc: spacemit: allow eDP/DP PHY
 PLL pixel clocks on K3 APMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-k3-display-v1-4-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
In-Reply-To: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784955080; l=2015;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=To2Wz4JMP1yzDvV2UFHvJJLkK8aaYjCf2yPZVKorUr8=;
 b=6QpiTRJLqJK2GsKELutClre7B0hn8nkeweqRCn/Wjj3e/UhBpvTQBMwgloDKX5My4q3x3I9xa
 aORhJl5y09nDaAK1Y6fNjz9k5B9OvtAuzbi1wOuQ/XRjPa7ZKm6wGQN
X-Developer-Key: i=codykang.hk@gmail.com; a=ed25519;
 pk=Osn6/cs9Su/mHHw4P19cmVc3v2FMQfiWahjsN0vEkuk=
X-Endpoint-Received: by B4 Relay for codykang.hk@gmail.com/codykang with
 auth_id=895
X-Original-From: Cody Kang <codykang.hk@gmail.com>
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
Reply-To: codykang.hk@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Cody Kang <codykang.hk@gmail.com>

The APMU's eDP pixel-clock muxes select the DP PHY PLLs as parents, so the
K3 syscon takes two clock inputs the other variants do not have.

Gate them behind the K3 compatible instead of widening the shared clock
list, so a non-K3 syscon cannot silently accept clocks it has no mux for.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 .../bindings/soc/spacemit/spacemit,k1-syscon.yaml  | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
index d3a7c93c3c54..b8fc6632a392 100644
--- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
@@ -31,14 +31,18 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   clock-names:
+    minItems: 4
     items:
       - const: osc
       - const: vctcxo_1m
       - const: vctcxo_3m
       - const: vctcxo_24m
+      - const: edp0_pll_pxclk
+      - const: edp1_pll_pxclk
 
   "#clock-cells":
     const: 1
@@ -95,6 +99,30 @@ allOf:
         - clocks
         - clock-names
         - "#clock-cells"
+  # Only the K3 APMU exposes the two eDP/DP PHY PLL pixel clocks as extra
+  # inputs (parents of its eDP pixel-clock muxes); every other variant has
+  # the four base oscillator inputs only.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k3-syscon-apmu
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 6
+        clock-names:
+          minItems: 4
+          maxItems: 6
+    else:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          minItems: 4
+          maxItems: 4
 
 additionalProperties: false
 

-- 
2.43.0


