Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5384EC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BC910ED0D;
	Wed, 16 Sep 2026 18:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="esEjm0lY";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8211410ED0D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:01:28 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b1a806664so171736a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789581688; x=1790186488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ruVPTz3hTy5PAMDzs0VSzntCrCNW8xKkYo6sPASahL0=;
 b=esEjm0lYX20+38nShLmIlnMslpHCU2P0B38nNGAiEjXQyXtLWQ/aAt+Fh5Tey8AFPA
 upd3Bon6AjQN7PJ7KJmhjB5zCfuYMiowFzCgmZf9og/f5zr7sCgE2k+GOMKScQIJG8Z8
 kXUKhz9qwuV4uClmQPL3qBww1uWrItEsYFfkF+PDFW/pyxKhMsemS+8FUY96TChaATEv
 eyZyEACN/+Id6chz1EZ1kvLRQtC3aJTGfZTd8OkuMUBss8Y1zhL7PpS56A6CIDqdjA4+
 Z4+THf7tyXWfaR/aeYPlidfwjxgjRSbUXvTulSZ0er9EkcnXhtlrm9UX8G7iv/tBaAVO
 1HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789581688; x=1790186488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ruVPTz3hTy5PAMDzs0VSzntCrCNW8xKkYo6sPASahL0=;
 b=gu6GglP4p6VYI9+9BdP8nuFaSna9pGeb2DG5lfd8dOQTi+6cAz1HP0pVDwoZpy0fUm
 1KgJb1HGtYY7gjjJz3vCkFXo5S68WMdvFdQAeoGFbpPxcwZhddxXAifYSUGLYv0+1Neb
 +QTjgD8zVShKqs6itmfS79YOxMZe2DS4MtwIiO2TTKkX+TMXc+aEeeHGI4yJSl2ZAeG9
 Op+9LkUUsArjZu+pPMkWRlQD7G6EPYRu7HAlkLq+z4+CMJqwhJMzTneKFL8mwewXC4us
 qg3G1y91P0HVf6mYJe/Z5SoNMt0IKUQDjTYwq+zzZmORfIDhY9V8qWOBvQwQBdq1OhYd
 BYJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZYlOBg+bZ/TgCjquVySCR5/sHXphjDcvjREo4TCmTusoFc6aFzMlP7Tt7UK5l+ufacgqnRVeBgI0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mgvftv1WxS7wuY03ssiOV4fc39ZhHWp7302KpLqK9h2LHv3y/L
 pjlrszcwhav0ANgh6XXu1CKBzTNde9bnyQD5thNqBA1hBAyVCMUykJTJ
X-Gm-Gg: AYBFou1Hi8+CoxP7ldnYQYN6KgX6TYMCrwU/7rIJgwDhhheyxjhkq7Ppq4UDpSL7nPw
 PC19ZIBoqkPyVuBLUdGCz6bOC17qZB3fHg5MMY1ZMz8Ps/eLLU5vVe7Ozx+7E2gGQRLYrJqM8ef
 sKxVR/F3KNTiwixHb0QnPAdkBOHIbDbDY42X+Bxwd5R0UdR3vXrzznxPwkkPXCody4SpKAD6KhK
 vNwxKM81RL5yktmg8YMe3iEns2wl9k4CCs8wxKog2nH1jfCbtwASjSGN36sIpGfLxv7jxQVv5xp
 EU7ZT645IPF07luFHCoCwvayjyQhRNAvfg4ybnGLxRE0lLf/JAztn+/V0M87SBV62IgOkv2xtWQ
 xaZD5gtpAhoAKPiwkC9MLTCZSOwrLOk+glczaRWpwhq9/RZkI2aD57Fkvh/cRFSA06OdcPjYHN8
 FBHmEm7N30Jpm5I1QF62FoZ4b5dldKZfKj5BIVgZPntn8nhnXhX+tHwtmEpvo1tOWRmn3TQBUvS
 r+8Iwf/qw==
X-Received: by 2002:a17:90b:2250:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e1e5285d8mr5311132a91.5.1789581687601; 
 Wed, 16 Sep 2026 11:01:27 -0700 (PDT)
Received: from marchy ([2402:1980:e96:7839:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35df479fsm569972a91.6.2026.09.16.11.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:01:25 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Azuddin <azuddinadam@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add RAiO RA8875 display
 controller
Date: Thu, 17 Sep 2026 01:59:41 +0800
Message-ID: <20260916175942.3186804-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175942.3186804-1-azuddinadam@gmail.com>
References: <20260916175942.3186804-1-azuddinadam@gmail.com>
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

The RA8875 is an SPI-connected TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Add YAML binding schema for the RA8875 controller, along with
the raio vendor prefix for RAiO Technology Inc.

Assisted-by: LLM
Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 66 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..f6f4867495dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raio,ra8875.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RAiO RA8875 Display Controller
+
+maintainers:
+  - Adam Azuddin <azuddinadam@gmail.com>
+
+description: |
+  This binding is for display panels using an RAiO RA8875 controller
+  connected via SPI.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: raio,ra8875
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  display-timings:
+    $ref: /schemas/display/panel/display-timings.yaml#
+
+required:
+  - compatible
+  - reg
+  - display-timings
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ra8875: ra8875@0 {
+            compatible = "raio,ra8875";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+
+            display-timings {
+                native-mode = <&timing0>;
+                timing0: timing0 {
+                    clock-frequency = <25000000>;
+                    hactive = <800>;
+                    vactive = <480>;
+                    hfront-porch = <40>;
+                    hsync-len = <40>;
+                    hback-porch = <40>;
+                    vfront-porch = <10>;
+                    vsync-len = <10>;
+                    vback-porch = <20>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..99d5113fb035 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1395,6 +1395,8 @@ patternProperties:
     description: Radxa
   "^raidsonic,.*":
     description: RaidSonic Technology GmbH
+  "^raio,.*":
+    description: RAiO Technology Inc.
   "^ralink,.*":
     description: Mediatek/Ralink Technology Corp.
   "^ramtron,.*":
-- 
2.55.0

