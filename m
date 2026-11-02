Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DF606A336
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lh2ga6LA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965DB10E0FE;
	Mon,  2 Nov 2026 19:58:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0351810E149
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:58:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7157A4045A;
 Mon,  2 Nov 2026 19:58:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793649531;
 b=WlVoheft3eWHdwa/J0eIp4Bg34Ov7Jyoa2wnEDukMsZmhD7jcypKmr7yAlB1jkLBhgJV
 7wjicosZIgd0L06S5VaNDIj8Pxyy/rgeq2w/ROBhw/4Q4QNEGSJCKn5xJJnlYA7dW0uMW
 C5qf5PB7SMTW6dWAjM2mXMUq2Mz0H3CsFy0QIEYizf/M/+QxTsP36ZpuRyXjb3fvdsAgU
 XrIMyjPxbXylKbS6hnb71hdoreygMP6qKarbu6aeaBRdhjBxckJQypLYa8knNDb27dTZO
 F8pmG5oM9UsGZ6+jzA3UQSBIBwJ0ibIO9V2/uOtB9U9zsMG3/IOzLxs4aAeAkF0R/Ug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793649531;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ShjKkPVgYWvT3bUlfwR8edgKYRHXPv09HgOMuB+2EzM=;
 b=tVqc7hK0iZebP1u77N8Pnlyupap5dp1Cjsy5dsrGoBdDLNUZ/a+Munf8UMDkMYUPtVvA
 8C7oz1PKPim8R7XQq0gsCIU55NvTWLYAHdN73z+JpqvIdIOlFSlDMJuTJTxvGrM9VRy3D
 CpunTcBOFpKMhvPEDguPKggsIQQIpy+ML/iZ2nIq8+mg9XSZEen15FrvFCGE1+YBo9HZR
 w4u/HaCE8p1+ajlZIN5slSQq4ElK1jq1J5abRqYxsUnoa6IMwy2upKhs4qJTrpVxLMS+H
 ve+QtbHAslyYQ1uIMH1alYMrNLf49bsuQg/vxo4TgtDF90bu8CLCTM62rhXz5by5q9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BCB841F00A18;
 Mon,  2 Nov 2026 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793649531;
 bh=ShjKkPVgYWvT3bUlfwR8edgKYRHXPv09HgOMuB+2EzM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Lh2ga6LAocAkAVy6hozxbECqr+ZCKq8V4U6oPQhxl3djOImYQmGEleLbmIzNQYEk0
 +yymEl0WITQBuoaoogB9ztD7m3jA2LmDDfHCml3ObheUCIfER+uHmdz6qSC3YA84Sg
 jVs22IWmm7PAg3CPunodrn1GJV6KfEQ6QLYII876JXnZ8b4Symx4XpMqVyT7QPk+vS
 n0PLnbuyuoX6qG9ErFPC69bCb4mBCFDRy1UChxiEoMQb1+fFAOIHErE+oFkWwJfYuf
 EG5SrVmSEFODJZ7cloJI13FNPLfVQNgi8u3ARp5sZGAGCG8ql8ZJP8orxZ/NKt0wOX
 5LIDfo5etYTdg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2BE6146625;
 Mon,  2 Nov 2026 19:58:50 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 02 Nov 2026 21:58:48 +0200
Subject: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
In-Reply-To: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649528; l=2713;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=W7KEav5RNE0IaBD4p6A6E+eItnSOsNWzD7VxYVWWyNg=;
 b=xn48T31sAqlYXbJ8B5hlz1LJUWEXZO0kFH9gw4yTlQ4Iqyo1F9rISUnAFUVP1HWPnPEhgkA0W
 7n/rHO8CUapD4zxZyrmsEcDNZMGMWMXVNBDF1vXbAi2VWpF2w4FbAST
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rva333@protonmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Roman Vivchar <rva333@protonmail.com>

Kinetic KTD3137 is an LED IC, used in various mobile devices for the
display backlight. Add devicetree bindings documentation for this chip.

Datasheet: https://www.kinet-ic.com/uploads/KTD3137-04a.pdf

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../bindings/leds/backlight/kinetic,ktd3137.yaml   | 64 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
new file mode 100644
index 000000000000..140615640a9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktd3137.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTD3137 LED Backlight
+
+maintainers:
+  - Roman Vivchar <rva333@protonmail.com>
+
+description:
+  The Kinetic Technologies KTD3137 is an I2C LED backlight driver for medium
+  to large size LCD panels.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktd3137
+
+  reg:
+    maxItems: 1
+
+  default-brightness:
+    maximum: 2047
+    default: 2047
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO connected to the HWEN pin.
+
+  led-max-microamp:
+    minimum: 5000
+    maximum: 29800
+    default: 20200
+
+  vin-supply: true
+
+required:
+  - compatible
+  - reg
+  - vin-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@36 {
+            compatible = "kinetic,ktd3137";
+            reg = <0x36>;
+            enable-gpios = <&pio 160 GPIO_ACTIVE_HIGH>;
+            led-max-microamp = <20200>;
+            default-brightness = <2047>;
+            vin-supply = <&vsys>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 15c7dc516f7c..24dd5b43f167 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14618,6 +14618,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
 F:	drivers/video/backlight/ktd2801-backlight.c
 
+KTD3137 BACKLIGHT DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
+
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	John Hawley <warthog9@eaglescrag.net>

-- 
2.56.0


