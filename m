Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A42C5DF77
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5F110E310;
	Sun, 16 Aug 2026 14:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="RAjD3M27";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FDD110E27E
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 10:57:12 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id 750D01FC51;
 Sun, 16 Aug 2026 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786877829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9BkWOqbRPbwZZ0c97zc9geVYk3/KI/cL1rJzpM75Ow=;
 b=RAjD3M27ilzzPmNQ4ciaobOEiyYwYadP4Qowga+NRPzH/mmKFAFaVHD+HiH/39f0h58g7n
 KjijL8+slRQ+EcVCta66y2vLV6lW1nqliRJQCNbVgzFkuMmIRbcEjRnc0kOjCR1XX6hGNY
 HOtMv47anmunYSymwKDYVT+AbOrkSeA=
From: Wim de With <wf@dewith.io>
Date: Sun, 16 Aug 2026 12:57:03 +0200
Subject: [PATCH v3 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
In-Reply-To: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
To: Wim de With <wf@dewith.io>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Add device tree bindings for the Orient Chip OCP8178 LED backlight
driver.

Signed-off-by: Wim de With <wf@dewith.io>
---
 .../bindings/leds/backlight/ocs,ocp8178.yaml       | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
new file mode 100644
index 0000000000000..1cd95aac0d168
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/ocs,ocp8178.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Orient Chip OCP8178 backlight
+
+maintainers:
+  - Wim de With <wf@dewith.io>
+
+description:
+  The Orient Chip OCP8178 is a white LED backlight driver controlled by a single
+  GPIO line with a vendor-specific onewire protocol.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: ocs,ocp8178
+
+  ctrl-gpios:
+    description: GPIO to use to enable/disable and dim the backlight.
+    maxItems: 1
+
+  default-brightness:
+    maximum: 31
+
+  max-brightness:
+    maximum: 31
+
+required:
+  - compatible
+  - ctrl-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    backlight {
+        compatible = "ocs,ocp8178";
+        ctrl-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+        default-brightness = <13>;
+        max-brightness = <31>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cfee5d47b214d..3ca99d9c32ef1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19678,6 +19678,11 @@ F:	drivers/mfd/ocelot*
 F:	drivers/net/dsa/ocelot/ocelot_ext.c
 F:	include/linux/mfd/ocelot.h
 
+OCP8178 BACKLIGHT DRIVER
+M:	Wim de With <wf@dewith.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
+
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
 M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
 R:	Andrew Donnellan <andrew+kernel@donnellan.id.au>

-- 
2.55.0

