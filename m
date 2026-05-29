Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE387CD6E52
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAF410FD4B;
	Fri, 29 May 2026 11:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ju/6R+b1";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D295E10FD47
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:05:33 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso8022879f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780052732; x=1780657532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ufMv3n9NJ42P8gEnrfOAT7W901Jg3eKnLZ21BwY03A=;
 b=Ju/6R+b107UHr321jOc/L1gEjG58yUSOXddbnv90H/kkKtUjLDJz99gsu1ONqMjxkJ
 oi5Y+aXXUFlKwyQGVn0nxhzwiCKEZMW3Ii2485ie30SQz1n+vXlidvLeAVYza+iXVM0x
 Q/oB1aTTEyA39q2PMtgSAcPj3wIWqmGqGdRL0vmVP9n35Pz3dlUYcvKjWPTmLJzWluX5
 vGv5/t3tZSuViPVgb2hrlCW3hpHKFhPurCwfhZg4Q4IZhJIaUm3/1/neSoopJZ/yhC+i
 oPPyjIiInNXRTtjRXvMHl5RcEUiCita4aFBByKQCZ5jY8QS3D6H0j9CA40T+6uRfnwll
 zofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780052732; x=1780657532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ufMv3n9NJ42P8gEnrfOAT7W901Jg3eKnLZ21BwY03A=;
 b=GXbL6v/H/KOn5zTu4syHMTs8WNHd/3hO8sjdnT16TP237P+hrd2M9QdjASFCp/Y6O6
 ZdTuYPCCx2A2NAC8kj4pBfdt2h1vlD4OkG8qpYB0AwWHeuNSLXQVf1TVWRiqsOZi3iV/
 n9RRypJWl8bWD0+wYUAOWVpthE8eYEPb73pu2f37CW/T/QfnXe2VnUWuZ2uNQxXrEZmM
 rnG2Y/ngA0dS1nVhx4YsoWf+0OXtYHMfiWDc09U5Rlu5/MaEDjKiuqLLLL7kh3l9hqv2
 z8RlpspbGJLp0h3IXz+OkXqV4cSL7tbDFzxeYVXT9bIXL0gIWAmnpUHe8osX4LN8eaJX
 WbjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aO/Op276OX0MmSUBk2ce77urTaDppFddRABPp/GnO4zaBkBM1nO3QUNZcXa4Px0xzGUUhkwhMRck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7K0yXduUUw6T2sZgfEk3LWgInig4+bCWw0XC4sC/Wq+jXVcmb
 qEYBh8vAnDrj5SNW3k56GJZGLxmDJCNNxPkC75GnQPXSiJr4/CkIveftXrhOKQ==
X-Gm-Gg: Acq92OG48u2ZXsiMMvXWi79l9H81SiBg2vptaBYWy1fnpK+a2eI0dhCmgeYQJh5PKYr
 8Pij/1B7OxDEKC62JPMyMAOk1OtMqUtsBl3B/I4pb7cx+UaM0/JGltpsirorOpc22mZas8gorO5
 9tHedcMEvkGudIYQC8blzYxSg6S227I3xJKw3t/aMSayuTbMoQNtdpzr8PTCo5yWT+fvYcdvU1Z
 4mUwd/8lu5fBouVNYqRDpO4nP4VhT4eFwDUxu3rBhJbOTjMr2KDMPgbnAmwh9/sIyAvHOzz1KbF
 zPMLQ3Yj14Yh3RWMoYsMkYeP+JKRmoJzSUopPhUApkMgEPpD8fgqtT2Dzx6Id0WcTF3wJsHfnbA
 TA+Awho8fjtjxDIk+lQQiEjiMfuevRwGPoSpDYvskrPe1O6QwmiVXbJZrNSchcoyKGuDBDY4LIj
 mP2Oxx6fKzzPOOO2CPdTG8pFsajdcEnEkxGojO
X-Received: by 2002:adf:e00f:0:10b0:449:c1e8:7655 with SMTP id
 ffacd0b85a97d-45ef14478c4mr3252609f8f.27.1780052732278; 
 Fri, 29 May 2026 04:05:32 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:7677:753b:2cb5:7f25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c3081sm3033663f8f.15.2026.05.29.04.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:05:31 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: display: panel: Add LG LP156WF1
Date: Fri, 29 May 2026 12:05:19 +0100
Message-ID: <20260529110518.624454-5-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529110518.624454-4-ivitro@gmail.com>
References: <20260529110518.624454-4-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Vitor Soares <vitor.soares@toradex.com>

Add device tree binding for the LG LP156WF1 15.6" Full-HD (1920x1080)
dual-channel LVDS panel.

Also add lg,lp156wf1 to the panel-lvds.yaml exclusion list to prevent
false schema matches.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 .../bindings/display/panel/lg,lp156wf1.yaml   | 105 ++++++++++++++++++
 .../bindings/display/panel/panel-lvds.yaml    |   1 +
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lp156wf1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,lp156wf1.yaml b/Documentation/devicetree/bindings/display/panel/lg,lp156wf1.yaml
new file mode 100644
index 000000000000..6b91c2ea4827
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,lp156wf1.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,lp156wf1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG LP156WF1 15.6" Full-HD dual-LVDS panel
+
+maintainers:
+  - Francesco Dolcini <francesco@dolcini.it>
+
+description: |
+  The LP156WF1 from LG is a 15.6" Full-HD dual-LVDS panel.
+  A dual-LVDS interface is a dual-link connection with even pixels traveling
+  on one link, and with odd pixels traveling on the other link.
+
+allOf:
+  - $ref: /schemas/display/lvds-dual-ports.yaml#
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: lg,lp156wf1
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  width-mm:
+    const: 345
+
+  height-mm:
+    const: 194
+
+  data-mapping:
+    const: jeida-24
+
+  panel-timing: true
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        required:
+          - dual-lvds-odd-pixels
+
+      port@1:
+        required:
+          - dual-lvds-even-pixels
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - width-mm
+  - height-mm
+  - data-mapping
+  - panel-timing
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    panel-lvds {
+      compatible = "lg,lp156wf1", "panel-lvds";
+      width-mm = <345>;
+      height-mm = <194>;
+      data-mapping = "jeida-24";
+
+      panel-timing {
+        clock-frequency = <138500000>;
+        hactive = <1920>;
+        hback-porch = <40>;
+        hfront-porch = <24>;
+        hsync-len = <16>;
+        vactive = <1080>;
+        vback-porch = <23>;
+        vfront-porch = <3>;
+        vsync-len = <5>;
+      };
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          dual-lvds-odd-pixels;
+          panel_in0: endpoint {
+            remote-endpoint = <&lvds0_out>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+          dual-lvds-even-pixels;
+          panel_in1: endpoint {
+            remote-endpoint = <&lvds1_out>;
+          };
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index b89f86bc0683..fbe8c162ca59 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -28,6 +28,7 @@ select:
             - advantech,idk-1110wr
             - advantech,idk-2121wr
             - innolux,ee101ia-01d
+            - lg,lp156wf1
             - mitsubishi,aa104xd12
             - mitsubishi,aa121td01
             - sgd,gktw70sdae4se
-- 
2.54.0

