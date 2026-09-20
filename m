Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AAEC982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1774C10E0A3;
	Sun, 20 Sep 2026 22:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EnwEW9WM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193A110E0A3
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:48:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3AAB4001A;
 Sun, 20 Sep 2026 22:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D131F00893;
 Sun, 20 Sep 2026 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789944498;
 bh=upUfSmELTJPYWMCaHbN6SO7e3HRXAnxCKT/GKC3ryoY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EnwEW9WMyCxf7j8hg46gwjmXdR7hJFm8ycbWYe2bR1uWaUHbWc5sC+d7AYXiNi+j4
 bd2qwyILPHI448Iw8bt9cigrDzjOynwLwujM7ef5clOiEZFEWWLF3I1BcLmDBRjCQ3
 9jWwZ3vF5r8kbXKkAfOY48WwjTGXD38pLQnxrP7MHTuve8vqWeIYn912wU7aatzWR1
 9G7QKL/GVroLdb+ESRVW7bw0zC1hue1AE0FZLBpKYcdlgPv/g5QSlgXo4fk/JnRWci
 5ASoBphuKJ6jXjc9bwKRk/X+F6SyYlm5rEsWtr1HOpagDAFkBgvYK3UK3ze5cefOFf
 kCAYmJB44qsOw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:07 +0200
Subject: [PATCH v3 01/18] dt-bindings: power: Convert Ux500 PM domains to
 schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-1-9352be6b86b1@kernel.org>
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

Convert the legacy Ux500 power domain text binding to YAML.

Move it under bindings/power.

Reference the generic power-domain schema.

Update MAINTAINERS for the new path.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ----------------
 .../power/stericsson,ux500-pm-domains.yaml         | 49 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ux500/power_domain.txt b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
deleted file mode 100644
index 5679d1742d3e..000000000000
--- a/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* ST-Ericsson UX500 PM Domains
-
-UX500 supports multiple PM domains which are used to gate power to one or
-more peripherals on the SOC.
-
-The implementation of PM domains for UX500 are based upon the generic PM domain
-and use the corresponding DT bindings.
-
-==PM domain providers==
-
-Required properties:
- - compatible: Must be "stericsson,ux500-pm-domains".
- - #power-domain-cells : Number of cells in a power domain specifier, must be 1.
-
-Example:
-	pm_domains: pm_domains0 {
-		compatible = "stericsson,ux500-pm-domains";
-		#power-domain-cells = <1>;
-	};
-
-==PM domain consumers==
-
-Required properties:
- - power-domains: A phandle and PM domain specifier. Below are the list of
-		valid specifiers:
-
-		Index	Specifier
-		-----	---------
-		0	DOMAIN_VAPE
-
-Example:
-	sdi0_per1@80126000 {
-		compatible = "arm,pl18x", "arm,primecell";
-		power-domains = <&pm_domains DOMAIN_VAPE>
-	};
diff --git a/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml
new file mode 100644
index 000000000000..1d5b4787aada
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/stericsson,ux500-pm-domains.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Ericsson UX500 power domains
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+  - Ulf Hansson <ulfh@kernel.org>
+
+description:
+  The UX500 power domain controller gates power to one or more peripherals on
+  the SoC. Domain specifiers use one cell containing one of the DOMAIN_*
+  indexes defined in dt-bindings/arm/ux500_pm_domains.h.
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    const: stericsson,ux500-pm-domains
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/arm/ux500_pm_domains.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pm_domains: power-controller {
+        compatible = "stericsson,ux500-pm-domains";
+        #power-domain-cells = <1>;
+    };
+
+    mmc@80126000 {
+        compatible = "arm,pl18x", "arm,primecell";
+        reg = <0x80126000 0x1000>;
+        interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pm_domains DOMAIN_VAPE>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..560079711469 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3273,6 +3273,7 @@ F:	Documentation/devicetree/bindings/arm/ux500.yaml
 F:	Documentation/devicetree/bindings/arm/ux500/
 F:	Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
 F:	Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml
+F:	Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml
 F:	arch/arm/boot/dts/st/ste-*
 F:	arch/arm/mach-nomadik/
 F:	arch/arm/mach-ux500/

-- 
2.55.0

