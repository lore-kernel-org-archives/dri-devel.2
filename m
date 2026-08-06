Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED6DC5AC82
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1675410F373;
	Fri,  7 Aug 2026 06:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="c2KFB9AP";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D76110F2BA
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:26:41 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id D5BA823DB7;
 Thu,  6 Aug 2026 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786047592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5yjnroszKmN21UAW1H7HqiZrAkJFktgUtYKWcKU+Mk=;
 b=c2KFB9AP1k2+nj5OdvKz5Afoec2qDVItgKelt+fmG6k7f05ZWXHhUHiVS8GheVBCYRrQJz
 bYJ/opefN9W65NSxq+G+MunqLXjozBG58n/5LYSUS7AcY4lE6iuERrXPItwe5Keyun06uj
 s64Ze0H54wyAcQ1Q3U1ENSRmCfBspsE=
From: Wim de With <wf@dewith.io>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Wim de With <wf@dewith.io>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Date: Thu,  6 Aug 2026 22:15:40 +0200
Message-ID: <20260806201541.101304-2-wf@dewith.io>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806201541.101304-1-wf@dewith.io>
References: <20260806201541.101304-1-wf@dewith.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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
 .../bindings/leds/backlight/ocs,ocp8178.yaml  | 46 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
new file mode 100644
index 0000000000000..9a4df1ef91edd
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
@@ -0,0 +1,46 @@
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
+description: |
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
+  enable-gpios:
+    description: GPIO to use to enable/disable and dim the backlight.
+    maxItems: 1
+
+  default-brightness:
+    maximum: 31
+  max-brightness:
+    maximum: 31
+
+required:
+  - compatible
+  - enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    backlight {
+        compatible = "ocs,ocp8178";
+        enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
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

