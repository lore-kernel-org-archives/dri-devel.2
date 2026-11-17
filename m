Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCF606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5gkaqT8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B1710F872;
	Tue, 17 Nov 2026 17:41:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAE410F871
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:41:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C48554148A;
 Tue, 17 Nov 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794937269;
 b=ApNr+YRjWjs6/aAtd6211n1+7XACOp5k9JfCazDT4LQGRMVLLZOMmAbxqbePsZGdSWNA
 Q2akWXTCUgwMZw249DbE9fzht56cXmTTq11A3apvnz8c5A2tnSmJxIJ/j4yuXL3HW7nVr
 S6EBZRoP7Md6ZdzEHs/cG2MKVf2Smnl2EmdgjFymboA7Ch4eHn6mzCXDMrNKKF1Gr+/LG
 T0YPfUwt7fu/hpf5iUq1DnoHg4SXq08Fl36niiEfSZ1SftrWqrqYZOCA55DzhToOkiJVh
 7gNwdieyWU4PwkPPYVkRnAUYyQwgCyxM0bOUe49cEMQ5BppODmMVaQxSH13mcBGF0Nw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794937269;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ppyqVBFv/K6NEphnd837iinHXAyuUDMGYOowkO+mkO4=;
 b=udbe1mVRyqZcp7KhDYe+7Xhk1noMK6HQVkb/No02DbhgRc/ZvwtUQp9u2d9I1BdcF59C
 I11UATFhg84AKFN6Suj5YsAGzfRBvp24fKfksKHH4zfQe9fxDpGazV6QT27FRllpnx1XY
 BLm+CoNZ8QN3rZtpfTztATcIY4oaMHu3RD1MBXCIkkvHwcTid5ZAfM/xhzMjYD8/HBMHM
 yBDqZogErWmWQYnLgNykESCr1L6gRARA0UlT6gjdY99NT++eiFnXPzgwog0rdX0pITUpS
 3eYQs/GqJC+ZMWwttOJ3dCICs8om+/cyan4QbDBkgF8Fru3cpR1I/B4cJ1cHrYtZ1Dg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1066E1F000C8;
 Tue, 17 Nov 2026 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794937269;
 bh=ppyqVBFv/K6NEphnd837iinHXAyuUDMGYOowkO+mkO4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=h5gkaqT8Q+QiuPOdpMYrtg2a9IvjJU+QlsBxvDtw+8ttXRttXgkhbOGaLeA4J5CGS
 YjUE582RakokHY1xbOcjPnqxzauokhPpxeP4KNVKwdWdM4eJVtSa0CfZt/0FUY/E4I
 ebq5Hj8RuJgshGGVMiQk0auXehCc2uW9B63OSUh0b6lphWyYIUiG1CkOreuMAb6z0K
 j2gAid2TfAAkhnZNcBIfZSvbN72LiO37hyg5afgENrpe8ZqBc/CASKpAY5JockMcxc
 RKwPU/ajIe4NBqG4EhpG3YbabSzKY3ptI7ICdHDDc9v3WnRWb20aYGqjvoNha16OyM
 V7wd3Tyv6JQBg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9030D4A9E0;
 Tue, 17 Nov 2026 17:41:08 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 19:40:58 +0200
Subject: [PATCH v3 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-6768-ktd3137-v3-1-b4fd957e3b00@protonmail.com>
References: <20261117-6768-ktd3137-v3-0-b4fd957e3b00@protonmail.com>
In-Reply-To: <20261117-6768-ktd3137-v3-0-b4fd957e3b00@protonmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794937267; l=2713;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=pDM+rGPXIE2Yxr4m0AujuxyA6pI+AXeeqaEO+1/IX5I=;
 b=lRk4ur1Kybvlb1eJxV5XXPq1Kirw6HYBmLH+xQfuFyhR32msgoWa0/A+8xK1OPkhVI1rE+b0r
 ho4Z47d519VCYH/YsbySzDEt0r+ly1a3t95IeJDh1+5k0om+eExvoge
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
index 000000000000..987f73b2c2cf
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
+            default-brightness = <2047>;
+            led-max-microamp = <20200>;
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
2.56.1


