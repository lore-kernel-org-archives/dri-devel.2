Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97916C88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0391C10EDC8;
	Mon, 14 Sep 2026 11:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fseI9SDa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D35B10EDC8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:55:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12E1E41B68;
 Mon, 14 Sep 2026 11:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D681F0089B;
 Mon, 14 Sep 2026 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789386956;
 bh=os9aCqygNcG4AeDRxVkSWO2NcRTgH8nb7EZvkGU+Qgo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fseI9SDagYpSRFqB+6XzGaLm54yOU50fPRy4yKBCPuUcz3bHaprEstH7rc2qwAHCO
 YPHNS02uhsMPyZLhNsWWunH+7iH2R/rEhPIsbsvgLaLJSv7qFn1gfZLi8N2y6v9Exl
 npwtTncfMziq5Nn6uhPGOARXKu4isjh2z7/8amv287wobE7EuQwQrLBY/Kgh0IEBAx
 lqrg57fjXiMh3od9r/YhH1M9aWPHIwJZVtbebX7J68BjIR8FL+Qp0lxM6Jea62a1aA
 M1ftIPKzgYwoH3/dtyRk1eNOa22V170NW7jrWbdQjnX6yCO4IK8mYsy2B9PvZX3k6P
 f5A7RdeQDZw8Q==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:47 +0200
Subject: [PATCH v2 19/20] dt-bindings: display: ste,mcde: Deprecate EPOD supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-19-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
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

Make epod-supply optional and mark it deprecated.

The MCDE should use its power domain instead.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Documentation/devicetree/bindings/display/ste,mcde.yaml
index 05e7e4ebc882..ee34b65dd13b 100644
--- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
+++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
@@ -39,7 +39,8 @@ properties:
     maxItems: 1
 
   epod-supply:
-    description: a phandle to the EPOD regulator
+    description: a phandle to the legacy EPOD regulator
+    deprecated: true
 
   vana-supply:
     description: a phandle to the analog voltage regulator
@@ -103,7 +104,6 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - epod-supply
   - vana-supply
 
 additionalProperties: false
@@ -121,7 +121,6 @@ examples:
       reg = <0xa0350000 0x1000>;
       interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
       power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
-      epod-supply = <&db8500_b2r2_mcde_reg>;
       vana-supply = <&ab8500_ldo_ana_reg>;
       clocks = <&prcmu_clk PRCMU_MCDECLK>,
                <&prcmu_clk PRCMU_LCDCLK>,

-- 
2.55.0

