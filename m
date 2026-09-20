Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345BCC982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A6910E193;
	Sun, 20 Sep 2026 22:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z95RNuQ+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9747E10E193
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:48:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80B3E40379;
 Sun, 20 Sep 2026 22:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0AC1F00893;
 Sun, 20 Sep 2026 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789944512;
 bh=ct+O4ixtCHinAZv5so5VQfOPnRD8CixwghDCy1rLpDY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Z95RNuQ+ZkOX7UDafjLMQn8BFXJ5CU0B3Zn8Tk6vIwFw6qQlZ/HjV6G3cKUrNwkeU
 ek5PTdW1AlcQUoRg1bz97pwI4Cyp5HQ9wLUitwkmK6N4AH5+NR5urWOl3NtVlKFWDM
 p5Vq5JbGIgFcRTcGEIQIKl1I6MH4fVzvzrpCbq02MN1Tmv8addEAhc7+v5IrZAkOPT
 UgmszfbmdlfyKGs19Y1OUWGBdH0eHYS6F0MFtzpZy5X8alSlY15pbMjjwWzb+cdxfQ
 lQ5eXaY8Taz8Fkht3UwqC7qKmTNb5X7fiYUkq29aA0RIQmaqGr2R4kO3k1TuxcPyZA
 cHN2eapn4P52w==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:10 +0200
Subject: [PATCH v3 04/18] dt-bindings: mfd: db8500-prcmu: Deprecate EPOD
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-4-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

Deprecate the db8500-prcmu-regulators node and make it optional as EPOD
control moves to generic power domains. External consumers of VAPE and
VSMPS2 now use the actual AB8500 or AB8505 buck regulators.

Stop requiring the individual regulator child nodes while retaining
their definitions for existing device trees.

Assisted-by: LLM
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
index 4edd4a3bab88..ce9060340e0c 100644
--- a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
+++ b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
@@ -58,6 +58,7 @@ properties:
     const: 2
 
   db8500-prcmu-regulators:
+    deprecated: true
     description: Node describing the DB8500 regulators. These are mainly
       power rails inside the silicon but some of those are also routed
       out to external pins.
@@ -207,26 +208,6 @@ properties:
 
     required:
       - compatible
-      - db8500_vape
-      - db8500_varm
-      - db8500_vmodem
-      - db8500_vpll
-      - db8500_vsmps1
-      - db8500_vsmps2
-      - db8500_vsmps3
-      - db8500_vrf1
-      - db8500_sva_mmdsp
-      - db8500_sva_mmdsp_ret
-      - db8500_sva_pipe
-      - db8500_sia_mmdsp
-      - db8500_sia_mmdsp_ret
-      - db8500_sia_pipe
-      - db8500_sga
-      - db8500_b2r2_mcde
-      - db8500_esram12
-      - db8500_esram12_ret
-      - db8500_esram34
-      - db8500_esram34_ret
 
     additionalProperties: false
 
@@ -294,6 +275,5 @@ required:
   - interrupts
   - interrupt-controller
   - '#interrupt-cells'
-  - db8500-prcmu-regulators
 
 additionalProperties: false

-- 
2.55.0

