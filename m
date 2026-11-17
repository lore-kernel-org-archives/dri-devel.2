Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AED606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nuiUPZHx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D5410F61B;
	Tue, 17 Nov 2026 10:44:04 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030F210F5EF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:43:58 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so46800555e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 02:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794912236; x=1795517036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8L7gbXkN1dILpBc2x0pUa9G4ccOQmCQZ8EESDwGPDFw=;
 b=nuiUPZHxPfh6U2xxFgueCPMUjM/HAYENyVF2TKIHQnznrdbaCU+6c16DEUwXYUjiH0
 pGqhtLWdSZ+z1nmPGQlGmlRmZqgqxeyFztpYBagIKXEqIYd1wXyFBjUEvY/noZO674TA
 l69CiivcSkkkEn03cOW7pcB1/Y8jq0gOdfyGROsCRYdMsj5HH2SwW764VdztdSBpKbE+
 Z2ISeXeG71K+BJ9UpUUFVvVcWMTfb3A0O2YyjRGXFA8ofAs8WLrALBNo1Q2BIX6+2LbX
 Ysl5DZA/ZvLNWnTPNoMBkOz2fMSBj2Nit3FajamYV9x5BTXJG3uKGQnrtHFH+OpArxtm
 vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794912236; x=1795517036;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8L7gbXkN1dILpBc2x0pUa9G4ccOQmCQZ8EESDwGPDFw=;
 b=pj3ERXxXqnzLCeN7HrqmE/7SlfzirJ6gSsE0msLpSe38c/zm24Zs9lpO8PrN0Yuhsw
 3pryNpQtOPJT0+vW6RBRl7FH3VWM+NME/JLVBiYyOrIhFeAxxiuxwzm+qJvfeTEWZmTx
 D6rBq7cxJVraFkBHdWSlAw614X5ovrp55IEuVZqAEprVsLU/PSg/DY4lA1JxIqX/0T1I
 6AlfI5EvdCi6o6iSt3d5Ymorv7mMARM4cu8mlSDubpGWiaEs1B/KU0wzU2jkAOUKXOk5
 pdGvwN27H894Id5/jp2u67lqETb/0y8nsa4OmtrG/ZNpSkG3V00phgnZbT6WofePiLln
 N/1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEwvYxmNkcah+MNqvhYEW1EscaXZBiT2FFCY3YtBGcX/LB+Ahr3VzESkAIpwiPVxxIdhttxxyJRy84=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8at/641szRTt5FqSozm6hEhCphQwd80Bp7jHhfvZTYmIQkRgFD
 lHArI9lIzQxWOY+dzQcBvP3Jd/syNec+Il01Bwdf4dPDsK/FDI1issCp
X-Gm-Gg: AYBFou0sE3zDmoteq7JbU/Bs7C0OcUOBL77M8BPjvqup2ad7+klaRxSlC64aMK7Ozhz
 0w7A3doqYzq4QBlgcoCnWQLWpf3JK//PNArjmZbMIT7aJwYBQ7S5a/RlRZsbHjR0gA+28QptDPd
 Yf0+H94+jY79tEjyW0IPUk+sq5zPA58SaY+ChaDEx37IyYfKi3/rKBmxqGlp9sTlWuHzyZagw3D
 siIl8GRR92o68okxITi/nsbdVDcsLYOVPnm+MdEJ8FHYPObH8fbFOlLAEo5SwEcJMlHK7Q8mqnz
 6iMzyZz3oqj8B12j9/91q+d4gEJyYYTfqQBjwv374MSk5m/pG/ndsieGb7Ch/1zmYMT1/Zx3Pab
 WyTCS3iEoeuoynEVWs7Kxh0IA1JyUpgHSGdUwy6piPDMHLoRYZbvThvMdd45EpW5PhtsJO4lkMZ
 4sTJvtY0QmfWjPL6YZEHszoS2BYt1rf88uJdBZ0ATaz6GI/2H6edggCBiYkpheMkHU70rVK2hSf
 fDLWHnjmgDFYC5AmBxmUOz+IeLjBvKPR6mc4aFaFiZtfEFOZlKp0Wj1Fml9B8Z5K4/ap1QCUd26
 OVhPWtiQDVQ=
X-Received: by 2002:a05:600c:630f:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4bb55aa5795mr277386855e9.33.1794912236093; 
 Tue, 17 Nov 2026 02:43:56 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f7eecsm104578445e9.3.2026.11.17.02.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:43:55 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: novatek,
 nt36525: fix v1 review issues
Date: Tue, 17 Nov 2026 13:43:52 +0300
Message-ID: <20261117104353.1180634-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116070212.314228-1-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Addresses the issues Sashiko AI flagged on v1
(https://sashiko.dev/#/patchset/20261116070212.314228-1-tadilhusrev@gmail.com?part=1):

- reset-gpios is the physical RESX pin, which is active-low (asserted
  low, released high); describe it as such (GPIO_ACTIVE_LOW in the
  example) instead of GPIO_ACTIVE_HIGH. The matching driver fix is in
  "drm/panel: add Novatek NT36525 panel driver".
- Add vpos-supply and vneg-supply: the driver requests three separate
  regulators ("vdd", "vpos", "vneg"), but the binding only declared
  "vdd-supply".
- Add backlight: true so dtbs_check accepts the backlight property the
  driver already parses via drm_panel_of_backlight(), instead of
  switching additionalProperties to unevaluatedProperties (which would
  also pull in every other panel-common.yaml property, not just this
  one).

Also fold the compatible string into a single, driver-matching value
(novatek,nt36525-xcover5) instead of samsung,xcover5-nt36525, which
never matched the driver's of_match_table at all.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 .../display/panel/novatek,nt36525.yaml        | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
new file mode 100644
index 000000000..9158125c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36525.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36525 MIPI-DSI panel
+
+maintainers:
+  - Adil Hüsrev Tepe <tadilhusrev@gmail.com>
+
+description:
+  A MIPI-DSI video-mode panel driven by a Novatek NT36525 controller,
+  720x1480. The first compatible string names the specific panel as fitted
+  in a device; the second is the NT36525 controller it is based on. The
+  panel reset (RESX) is active low.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - novatek,nt36525-xcover5
+      - const: novatek,nt36525
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply:
+    description: panel logic power supply (vdd_ldo28, 1.8V)
+
+  vpos-supply:
+    description: LCD positive bias supply
+
+  vneg-supply:
+    description: LCD negative bias supply
+
+  backlight: true
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - vpos-supply
+  - vneg-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "novatek,nt36525-xcover5", "novatek,nt36525";
+            reg = <0>;
+            reset-gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&panel_vdd>;
+            vpos-supply = <&panel_vpos>;
+            vneg-supply = <&panel_vneg>;
+            backlight = <&panel_backlight>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.53.0

