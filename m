Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237BDC44538
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A273F10EB98;
	Tue, 21 Jul 2026 22:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pCOuZHrY";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48F510E23A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:21:52 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47db714766aso2725783f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784632911; x=1785237711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ux9hmvQYpNrioGxp+5tKSBKeWP1obZYcrlrpcPAFDf0=;
 b=pCOuZHrYLGlBWccBXjF4qlWJPShsNOIw06sE2AjPBZa6h/yVl/Z1v0M6rCqPyuDlS2
 QxebRytxMI6NwXgE695fng8rrjBFgYexHICdpwuhKmmC1XSJDpytBgPnJGpQ2lbF8Fsb
 ZhlbLiZPInm6aezHNYEYBN0l4DSa2gyTEWC7/URgJAVpXtmxyvCA6/BVGdyrYpIY5T34
 rdzc9TAGprpKh+ct0bcfWYvqp5xRBWh5+Jy+UjWqUwyvNlZKN8aJQyc0pzcXAC5nvQXQ
 M5GM7CrBcc8xwSHrlVGsWCxt18Axxg3yzq2LL/d3EhUh3bTUsBXc6ghcSs0b1Xbfc4LL
 QSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632911; x=1785237711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ux9hmvQYpNrioGxp+5tKSBKeWP1obZYcrlrpcPAFDf0=;
 b=pg0cE/mQiCucih7F9DjuwhVu4DJhyDgD6zB0uDDYmmAcZafN3R2Pz/kagGvN8/7WGV
 dh/+eQImsEQZ1lUzh+UFvnTD7rbz2Y//hJnuTQ1laO9Rbt+oKM03iGW2Kty1xYyy1zWS
 T49QeTeBqRP/vAAISgKlPYYVFzG18Iz2pxTQWXWaOOdar0UJd85dHmp5elwH4IUVH2Ei
 SzXkwfFcW766e++h+SWbzKqicwTDmQvThQT7/VY+xrgEnWj4+bgZNUH5z4qxtt4wP++j
 2OK71L6Zxr71ehkaJqeBPJauiSQSQFi39TOcP34P58D4DCoQCwMqrKu4/peVj+e7+nVB
 +B/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDwsGcukBZ6q/LzkcfuZzALP0Ss5g3hEDfqKPBtX+rC5TJkpvvbYVcbz5jeNaG3hQgw28g3bSYYAU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkZLxduBJj5aVlY+LGU9FrxZMYJ3346shf1N25SEaLmGq8R3Ma
 cjnQDrJjjx+iC1cSVCyurYoQpCTmtSGUqf/WjHDJnKttUioplTuVa+Cv
X-Gm-Gg: AR+sD12weGB/2XuxO817HzxOoJiF8JJSUj1YWPXcYJXzSWzDpShzlhBQbPsa/Z4PyqL
 h+e+mmJKfM4IUnsULwTWwIcPhqU7WtuKnPSC4AOFPU9jWF7gMnPZxS4O2Iq6EV0zefN4UMCKexR
 SQb2FzKA1KJWtmNQaegeXsMMJGCUX1mK/nTqkiK/laulOD/IoIp+9NjEbLLObQkNJhw+8iHkXzC
 mqglRebcDkqq6SsGN+sQK4ld6IWrgkk/ACSHtO3r/xxel5Ic2aN9a8UrerrS8ujrqfdujKWSJVV
 mKtytWCZdeV19pimElEN+xljDUJ0vBzKoqGcOzBc6qDa4wTunU8+t7FD+x1eNlRY0L+3zWFPG+E
 A+hgeO42auwsVW77bCs6c1lVymdY91W5OtXBsr5myr+x6pVe9JdhHcpeqy9GUCc8aE5LeWAmwpY
 tCiNOl6nKCUA3yLB24jKTbmGz2vobyf0JC83K1Lx2tuKOO
X-Received: by 2002:adf:e003:0:20b0:47f:7864:1b7b with SMTP id
 ffacd0b85a97d-47f78641d6emr6602519f8f.24.1784632910754; 
 Tue, 21 Jul 2026 04:21:50 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:21:50 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-omap@vger.kernel.org,
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power button
 to DT schema
Date: Tue, 21 Jul 2026 11:21:27 +0000
Message-ID: <20260721112133.70382-4-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721112133.70382-1-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

Convert the Texas Instruments TPS65217 and TPS65218 Power Button
bindings to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/input/ti,tps65217-pwrbutton.yaml | 42 +++++++++++++++++++
 .../bindings/input/tps65218-pwrbutton.txt     | 30 -------------
 2 files changed, 42 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
new file mode 100644
index 000000000000..3526d8b045fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,tps65217-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS65217 and TPS65218 Power Button
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description:
+  This module is part of the TPS65217/TPS65218 PMIC. It provides a simple
+  power button event via an interrupt.
+
+properties:
+  compatible:
+    enum:
+      - ti,tps65217-pwrbutton
+      - ti,tps65218-pwrbutton
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-button {
+            compatible = "ti,tps65218-pwrbutton";
+            interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
deleted file mode 100644
index 8682ab6d4a50..000000000000
--- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Texas Instruments TPS65217 and TPS65218 power button
-
-This module is part of the TPS65217/TPS65218. For more details about the whole
-TPS65217 chip see Documentation/devicetree/bindings/regulator/tps65217.txt.
-
-This driver provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be "ti,tps65217-pwrbutton" or "ti,tps65218-pwrbutton"
-
-Required properties:
-- interrupts: should be one of the following
-   - <2>: For controllers compatible with tps65217
-   - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
-
-Examples:
-
-&tps {
-	tps65217-pwrbutton {
-		compatible = "ti,tps65217-pwrbutton";
-		interrupts = <2>;
-	};
-};
-
-&tps {
-	power-button {
-		compatible = "ti,tps65218-pwrbutton";
-		interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
-	};
-};
-- 
2.43.0

