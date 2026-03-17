Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C845FCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0E710E742;
	Wed, 18 Mar 2026 08:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FWHNXKp7";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37C510E5EB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:31:33 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2aecefc7503so28598675ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773768693; x=1774373493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z1ffVkrIYrhdQ/G3EnqYe2fK8Yxo/+BsbwKp30PVRVU=;
 b=FWHNXKp7nnZDb7WMILOCIbv5rC4809Ha5E1amnM1T6FzTy6g5gC/SZMaZSagflQFsN
 gw3rm4x9UWGiapTDckyuFfMavYcHx8tzuQqDJe5x7U3q2PI1QnBsydTFSeHy4rsoEUUx
 XyRxakCCAMevfiYrOSyvFkNGNPPBFBqF4P2mkjB9hRPloAz05mTJ5YG0peWmPwX7Acev
 XeAJqSgG/e69oyCuNbzDb3ArBz/0xVZ+W7FacVw5QZQWfENywWMSOI4p7lxMwwo4ftQD
 3wsDMQxdpQu+jj3mAPnWhKjPON2I9mUwI8JjmgoDCwKlZrID26miVYVOjH5tq70Anbcu
 lDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773768693; x=1774373493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1ffVkrIYrhdQ/G3EnqYe2fK8Yxo/+BsbwKp30PVRVU=;
 b=na+S836vkq0VgkPlP+OQWwmFGU86iv2xTvLy1byPVzCdLJFEFraLGKAj1H/5vWjWKk
 2ng9g0RGPXVgVfZRCGn9Nlm5A3JVJr0yA+nWOzIFb2lAq4JNcx0fCLT0PW+8jaSPVbLW
 Qg2ufb7jVHMFhKGhfusdSUnhTfEjFOZfEG6GkjAxSLQVyfHLfdDfl3F74/ceRJa9m+F6
 51WBUUx3gjVDwqKg/5A5w6uyVvnZzPvk63mDSJJbHVlFqBGUnyhUj18lLy5B//+DB1Ov
 a2oxKnaCqEycWqLxZ98YY3nRv23dPdnFcq3h7tCBklODuX6e+fhxjL54vkC8RIdxHtE6
 OcwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2tsD9mGsJA4E4veic9GmHvogwDVYy5av5SIYp0LwksB7E4xiOSfKmYaHA7xKTATXSjKapcKIyhFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCHPOLQm1GiEU1AG4g+Fmyx8R3VBTAQ5gk8WzCg9qlap196i/l
 fsfK36kR8T/eDpLfBkQWjfcBvbodonWcG3CuOm7ogkriLuw5LjbMCtBf
X-Gm-Gg: ATEYQzzD9mx1LyNQ3NHqxx/IMYQ9wavmCYrxu4KkUdRlIkcIXyL4vnrEcMJsjGVSYRI
 DvEp5yg468IzVnCfDbUWc5xEuRZii5Ul5GsBXDMYBeY/Zq4KSQux7yPYxKGm7l35nPGJlD0O5a7
 bfjcdmwI05q4V++5qBuCkD6gQRcaE+IZlsg5EWr7qA0xrVqjr2s6tQiHWG9rF7X7tWjcE6tUWaD
 iGey4NuX0Lv2yVjaBTqGrkhEuFaU6nx4NS7w4fu/oGH3H3r2TljN76x9eAtpqQ8yhnCk8lOD/fm
 TNCCwXwk2K0sfCJNPp83nKAPS1OfT4ii0IL+BbUe8p8u4MhZdxDkiACbOQuURIlr1uq4sfc+GeX
 b1As9KH6gbfQap6G1v+35N1I/2AeaqjiLP07xdu9Gd0aUQI5kdingkUphi6N0XdYuBJj5M09xzr
 NUVBRERR16Fjb54SPzH+HT/nUP8fwXwbMyng==
X-Received: by 2002:a17:903:41d2:b0:2b0:5968:a6d5 with SMTP id
 d9443c01a7336-2b06e364202mr3114835ad.18.1773768693200; 
 Tue, 17 Mar 2026 10:31:33 -0700 (PDT)
Received: from kalyani.. ([2401:4900:88f5:ac25:fbd0:e3bd:86f9:3d41])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e60526dsm1868795ad.62.2026.03.17.10.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:31:32 -0700 (PDT)
From: Kalyani Patra <kalyanipatra2003@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com,
 m-chawdhry@ti.com, Kalyani Patra <kalyanipatra2003@gmail.com>
Subject: [PATCH] dt-bindings: display: convert via,vt8500-fb binding to YAML
Date: Tue, 17 Mar 2026 22:59:56 +0530
Message-ID: <20260317172955.250192-2-kalyanipatra2003@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Signed-off-by: Kalyani Patra <kalyanipatra2003@gmail.com>
---
Note: this patch is part of the GSoC 2026 Device Tree bindings conversion project.
---
 .../bindings/display/via,vt8500-fb.txt        | 36 -----------
 .../bindings/display/via,vt8500-fb.yaml       | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/via,vt8500-fb.txt
 create mode 100644 Documentation/devicetree/bindings/display/via,vt8500-fb.yaml

diff --git a/Documentation/devicetree/bindings/display/via,vt8500-fb.txt b/Documentation/devicetree/bindings/display/via,vt8500-fb.txt
deleted file mode 100644
index 2871e218a0fb..000000000000
--- a/Documentation/devicetree/bindings/display/via,vt8500-fb.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-VIA VT8500 Framebuffer
------------------------------------------------------
-
-Required properties:
-- compatible : "via,vt8500-fb"
-- reg : Should contain 1 register ranges(address and length)
-- interrupts : framebuffer controller interrupt
-- bits-per-pixel : bit depth of framebuffer (16 or 32)
-
-Required subnodes:
-- display-timings: see display-timing.txt for information
-
-Example:
-
-	fb@d8050800 {
-		compatible = "via,vt8500-fb";
-		reg = <0xd800e400 0x400>;
-		interrupts = <12>;
-		bits-per-pixel = <16>;
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: 800x480 {
-				clock-frequency = <0>; /* unused but required */
-				hactive = <800>;
-				vactive = <480>;
-				hfront-porch = <40>;
-				hback-porch = <88>;
-				hsync-len = <0>;
-				vback-porch = <32>;
-				vfront-porch = <11>;
-				vsync-len = <1>;
-			};
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/display/via,vt8500-fb.yaml b/Documentation/devicetree/bindings/display/via,vt8500-fb.yaml
new file mode 100644
index 000000000000..1ebea3b82f30
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/via,vt8500-fb.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/via,vt8500-fb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA VT8500 Framebuffer Controller
+
+maintainers:
+  - Kalyani Patra <kalyanipatra2003@gmail.com>
+
+description:
+  Framebuffer controller present on VIA VT8500 SoCs.
+
+properties:
+  compatible:
+    const: via,vt8500-fb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  bits-per-pixel:
+    description: Framebuffer bit depth
+    enum: [16, 32]
+
+  display-timings:
+    $ref: /schemas/display/panel/display-timings.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - bits-per-pixel
+  - display-timings
+
+additionalProperties: false
+
+examples:
+  - |
+    fb@d8050800 {
+        compatible = "via,vt8500-fb";
+        reg = <0xd800e400 0x400>;
+        interrupts = <12>;
+        bits-per-pixel = <16>;
+
+        display-timings {
+            native-mode = <&timing0>;
+            timing0: timing0 {
+                clock-frequency = <0>;
+                hactive = <800>;
+                vactive = <480>;
+                hfront-porch = <40>;
+                hback-porch = <88>;
+                hsync-len = <0>;
+                vback-porch = <32>;
+                vfront-porch = <11>;
+                vsync-len = <1>;
+            };
+        };
+    };
-- 
2.43.0

