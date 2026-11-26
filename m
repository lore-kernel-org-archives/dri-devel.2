Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFA606A6B4
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Omlb5eY/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79C511273C;
	Thu, 26 Nov 2026 21:44:53 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA75112738
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:43 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so61368105e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729481; x=1796334281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vAPLB5wINg8+k5DF0d3PoxcepaPENAHu+hHbKIVA9v8=;
 b=Omlb5eY/9b9AcWbOCWDYIYYtu15AUMNNXhMAeVI4ApVaeTsLN2QGTpohynXZlQmLpp
 OO5imaIgdyNewmq2ovQfgw+L1QEbKEx7qXw6SVzKJz71rxdzFURTGPE0UNiaipPLLvcu
 9pKpSg1OjUFCqpAJArrmuxf0iLedYuJDEtCZKG43MOnNR6eE6+TFOp1BYfqWa6xQISJI
 7K7A7uZT3wXTbjxST9AacOwYxKBjsY/akDCZYUgEj3FMDcoPhr3nv+y2lMYGcit/TCoE
 TsbPIbVhpsHeL7S3bEolaF8HamhQc7i7TVdHh+MOENt0pQjTIHS8UgTPMjYxA9oRIxHF
 hniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729481; x=1796334281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vAPLB5wINg8+k5DF0d3PoxcepaPENAHu+hHbKIVA9v8=;
 b=R1r6iN5B2adP0+WArMu36/4X8ZcsusuqCsdoGPzfOrxwgFFdTKHRdu0t6BDUWvGuuf
 1HoQNKkW1oB4ayy3naz/Ab1aFBfdA1CfutL+lOJBtOkPyMFOsWQ+8qg2D2O9shQcTiQd
 MRsJiEwDFsIZPt8m/pS5GcPfPYscsezXicG5gvHvJ+bsB43RnXYJaivI41ogqS1Z+jXR
 LCOKeIVT/PWR6a58h7x6CS3w8q5qM2MiFy0z0l5qIxssnLJAqTE6l9Qa+F97oCZuTGZl
 /peweVGVStujZGqk9utkIhmfCn3VYO2sq5DWwLy2WwbtKnvOwxlkD54CJExKzS2KxzxX
 u0vg==
X-Forwarded-Encrypted: i=1;
 AL+hErEI4l+6ZqmYCpeZh6gCXaeeZZt9Kl/1x3e0O3PGnzCwk2KA2zq7J8yXguOsS4HUvJEYn7tiA7FMrx0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/O+WCkXIg4N0HCkhHSzSHUBhv7NU/0eczzFtPo2xPx7CaH3pe4
 UZphDmo8Jd1grzt3K687OmSWaNT3ZvEBPaDwkhzx2olAA10ozaHIE1+p
X-Gm-Gg: AZFdTZd5PF+u1by3dDGrGw5DuTSm+rIXD36JnbK32s6/WwsO7jc97cockC/miT+lLRL
 Uf6lQ+0wUDa99/kN05QJWydrKRFDcePEVjdgaKC+MLMkThn0u+B4RpFWnGnSlAJfaA1U6uxr4H6
 f6lJhLOPhWFTeXUYT+tZ4nN5tfI+1hBP2SKi37VPk2JVNjHbjnQ1QfuqRVROnPJHI4hcyp4y100
 FzB/+xu6C5iDsqW+QbWUqrOUFLRJBBucH+u6mmtFyVWtFCGqbLCbTLkhgAhKwDS2s8mU+NeAwTH
 wqU2HvYK7Tv56A3w29+p1SXetQ1nHXhJhjEWIZcaWEgXb11vCAjrWr/0ZUhhAM0YuCzF9KaXjmS
 q22YLwkwL06q6ynOYACYNaQXrvpRaQLkbXGzljf6+q0wZHD8lCZYoX99WW4hx9CC3glaTV/exKc
 H66bBbUr/emwRxwo2LFh3zHu9rRGA8J/3y6ap1veKu31pLyR31vqtooCPbAeFojd6vPpixaQ+LK
 GjCZF2Z1wBEl+p/dKzIH49gecNbMgetmc6+WABDQ7l6bmuLfPbrswn7Dr1rQIkHe6Aq0ZMIQZih
 7aNsqfpAPqDrtMhiKUx+kJT5KbtqA2iWlFWr026lBr9YmMYqObTiPY8Rt4j+ThFd28IlR/beIFI
 9yCUmvS7M2eNVuH8KBpOBaJbA9BwXhR1O4H4B2aoxZpBFmjbIAW537iRC1RDmtqHfJ9Nqjkx68N
 XG7MQTz4Eej+iM0AEj5wirBWrAyY0pS25IpTUPGCi/zPldHs897NxaZuj5DWbozqg8CHSeXnNIi
 Wv9+bP7h+gk/bIU2q62baeVLo19Zv05MbDt3dp0Ew==
X-Received: by 2002:a05:600c:4f53:b0:4bb:68cc:7b94 with SMTP id
 5b1f17b1804b1-4bb8616516cmr559444565e9.18.1795729481269; 
 Thu, 26 Nov 2026 13:44:41 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm40403963f8f.18.2026.11.26.13.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:40 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 jernej.skrabec@gmail.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] dt-bindings: display: Add H616 display engine
 compatibles
Date: Thu, 26 Nov 2026 22:44:24 +0100
Message-ID: <20261126214433.3562326-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
References: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allwinner H616 contains a display engine 3.3. It features two mixers and
four TCONs (2x LCD, 2x TV). Supported outputs are LCD, LVDS, HDMI and
CVBS.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../bus/allwinner,sun50i-a64-de2.yaml         | 20 ++++++++++-
 .../allwinner,sun4i-a10-display-engine.yaml   |  4 ++-
 .../display/allwinner,sun4i-a10-tcon.yaml     |  7 ++++
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml |  4 +++
 .../allwinner,sun8i-a83t-hdmi-phy.yaml        |  1 +
 .../display/allwinner,sun8i-r40-tcon-top.yaml | 33 +++++++++++++++++++
 6 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml b/Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml
index 232252e8825e..18ec57448edd 100644
--- a/Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml
+++ b/Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml
@@ -26,6 +26,9 @@ properties:
       - items:
           - const: allwinner,sun50i-h6-de3
           - const: allwinner,sun50i-a64-de2
+      - items:
+          - const: allwinner,sun50i-h616-de33
+          - const: allwinner,sun50i-a64-de2
 
   reg:
     maxItems: 1
@@ -49,11 +52,26 @@ patternProperties:
     additionalProperties: true
     properties:
       reg:
-        maxItems: 1
+        minItems: 1
+        maxItems: 2
 
     required:
       - reg
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: allwinner,sun50i-h616-de33
+    then:
+      patternProperties:
+        "@[0-9a-f]+$":
+          properties:
+            reg:
+              maxItems: 1
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml
index e6088f379f70..6e26f184ab24 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml
@@ -65,6 +65,7 @@ properties:
       - allwinner,sun20i-d1-display-engine
       - allwinner,sun50i-a64-display-engine
       - allwinner,sun50i-h6-display-engine
+      - allwinner,sun50i-h616-display-engine
 
   allwinner,pipelines:
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -74,7 +75,7 @@ properties:
       maxItems: 1
     description: |
       Available display engine frontends (DE 1.0) or mixers (DE
-      2.0/3.0) available.
+      2.0/3.0/3.3) available.
 
 required:
   - compatible
@@ -96,6 +97,7 @@ if:
           - allwinner,sun9i-a80-display-engine
           - allwinner,sun20i-d1-display-engine
           - allwinner,sun50i-a64-display-engine
+          - allwinner,sun50i-h616-display-engine
 
 then:
   properties:
diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
index 05ed4ddcff3a..eb8d1fd9d8a3 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
@@ -36,6 +36,7 @@ properties:
       - const: allwinner,sun9i-a80-tcon-tv
       - const: allwinner,sun20i-d1-tcon-lcd
       - const: allwinner,sun20i-d1-tcon-tv
+      - const: allwinner,sun50i-h616-tcon-tv
 
       - items:
           - enum:
@@ -59,6 +60,11 @@ properties:
               - allwinner,sun50i-h6-tcon-tv
           - const: allwinner,sun8i-r40-tcon-tv
 
+      - items:
+          - enum:
+              - allwinner,sun50i-h616-tcon-lcd
+          - const: allwinner,sun8i-r40-tcon-lcd
+
   reg:
     maxItems: 1
 
@@ -256,6 +262,7 @@ allOf:
               - allwinner,sun8i-r40-tcon-tv
               - allwinner,sun9i-a80-tcon-tv
               - allwinner,sun20i-d1-tcon-tv
+              - allwinner,sun50i-h616-tcon-tv
 
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-dw-hdmi.yaml
index c43b02ec884f..44cc5c2beb04 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-dw-hdmi.yaml
@@ -28,6 +28,10 @@ properties:
       - const: allwinner,sun8i-a83t-dw-hdmi
       - const: allwinner,sun50i-h6-dw-hdmi
 
+      - items:
+          - const: allwinner,sun50i-h616-dw-hdmi
+          - const: allwinner,sun50i-h6-dw-hdmi
+
       - items:
           - enum:
               - allwinner,sun8i-h3-dw-hdmi
diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-hdmi-phy.yaml b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-hdmi-phy.yaml
index 1b47f3d99a78..fc88c5e2a3f6 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-hdmi-phy.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-hdmi-phy.yaml
@@ -21,6 +21,7 @@ properties:
       - allwinner,sun8i-r40-hdmi-phy
       - allwinner,sun50i-a64-hdmi-phy
       - allwinner,sun50i-h6-hdmi-phy
+      - allwinner,sun50i-h616-hdmi-phy
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml b/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml
index 7d849c4095a3..41324e1376ee 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml
@@ -43,6 +43,7 @@ properties:
       - allwinner,sun8i-r40-tcon-top
       - allwinner,sun20i-d1-tcon-top
       - allwinner,sun50i-h6-tcon-top
+      - allwinner,sun50i-h616-tcon-top
 
   reg:
     maxItems: 1
@@ -201,6 +202,38 @@ allOf:
           items:
             - description: TCON TV0 output clock name
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h616-tcon-top
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: The TCON TOP interface clock
+            - description: The TCON TOP TV0 clock
+            - description: The TCON TOP TVE0 clock
+            - description: The TCON TOP TV1 clock
+
+        clock-names:
+          items:
+            - const: bus
+            - const: tcon-tv0
+            - const: tve0
+            - const: tcon-tv1
+
+        clock-output-names:
+          items:
+            - description: TCON TV0 output clock name
+            - description: TCON TV1 output clock name
+
+        ports:
+          required:
+            - port@2
+            - port@3
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.43.0

