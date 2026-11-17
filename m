Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0B606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qBjwIaj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E60E10F859;
	Tue, 17 Nov 2026 17:33:35 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B84110F854
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:33:25 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so1837745e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794936804; x=1795541604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nPNbdnKmC1IshOZY/jqyrmwNTqB0zBU0VIUMMJN3fqs=;
 b=qBjwIaj9xx0plsdoScEdR2xeLKgMsUp+lpaVVKTf/25ATdkN7MBstNy0DKpM6OGiLa
 nGQPnyBPDIxLRay9vlOo9LRCfN7bxmizL7ANdLR9Ft7nJCRYoOxGqhehP4053dGh+mAk
 Bpf9J11FR7Q7a+SDRD/Wup/654RUZTE4Jk8x3tUr99P0EePX8U7jxC4NJafmsOjc0AuU
 rb3T39WtvY2nopi9z0Uy83+Z10wmiDiaTt+Xe+yQUvwAnxEs2xANzCasE2RqahoOqfSO
 1yDw515KEqJ8GjBsZghdeEl3hsorNHVH4LV1VlA+2COADAU4Y78AMYLDumLWNdWVm/9m
 Zrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936804; x=1795541604;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nPNbdnKmC1IshOZY/jqyrmwNTqB0zBU0VIUMMJN3fqs=;
 b=g2zDuAG1MbhPtiyIQKyaSiTD5dbhflatnT9Vj0eRKTL30hTVFmUg3qGQ6DHKrH23H6
 vAGtO1OWevUPh7nEvJp8PmB4bslM+02OqtZ1PeZMUUzcToQmbazQStflBr9UMLbQhN96
 vXeak5qudbFZke0E10fiPySR5KP6NDcWDf+nJzRGzqzePlUpD/T2oJb5OZq9P5fCjpVr
 fP1an1HO4Gmo9YCpQtoRFjVS49vIr/HbzwUhHmgQWHNjfKckta5lRn1xiIrcR6Ifo8jj
 yKUa/6VRvl8lDB1I3yaamjXn8KTgSmvH6XyaFznfZDuNkXfRf66bYmsmR5uDYu32sWKv
 gwJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGKsMs9yrtR6Po9NZ/Sink9wqrYpU0JfES5pguGWd383ISQfaY84FqlLOsgqpyTSakDG5m2F7ZFxww=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8y4MG8VmOoo8mshHw26h62pUZVNDmFYoqzh+v0vP1IJOckY5qM
 6c4pFub3masEhZmKGiranTE1Y0bcJ7TD6gs+6gKiwmeIya0aysHD70yS
X-Gm-Gg: AYBFou3PuAFm1QUK8bKcmW1aASF4Vugt/hLwKD+0gPKCyGDA0uhQ1QOwEvBcP0jEn9o
 jEJQcTfjcSqCnt3ASD/bftbyrKGWvl7xmCrQVK3dR6vuxLYDm2evr5WOEinRsCd8cgDvVRmCx6M
 domeHUteV2s1Ycle7pfBJQ5xFRfJdwcTi0+4glxi/z4LADqhhxYR3yJwopLMimgDGzGQEL3YNIJ
 2/RUjI+aJfVvUbnHlit6fJNIxGigwkNmhjMyY+12uwn9o16KgckBxB5v2zQvI2R9iuJk+ReyO7x
 lamlMjMauCa9+aUNa+ICpOFjK8TnBvsWQgr8bzpwhStNJv7dxebwKW1kcSmDXThZnBil9JAFFgk
 ymI17LtFccxpGHWJHdmWlBZVqrOecoco84PD4RV7mDF0Ph4ohNy/3jxbxVf/4hszNdM2nkwuBe9
 eAkFeOG8dYPmF8qNxO/fg93uGrR+AbSDkKXZ34qQXvcgeIk/JreKgejx3k83Uc2Dn0KRNEsEw8M
 0rlIKJQ2BeBfHM/mEovrUdoW/i2Difb4llLfaaI2d/S+kKw+LrWVVedBqit6jgvQ4c2beDu5vjh
 vOStq6BTSA==
X-Received: by 2002:a05:600c:6992:b0:4bb:68b9:f610 with SMTP id
 5b1f17b1804b1-4bb68b9f729mr199623315e9.9.1794936803812; 
 Tue, 17 Nov 2026 09:33:23 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8220sm79269585e9.5.2026.11.17.09.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:33:23 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: add Novatek NT36525
Date: Tue, 17 Nov 2026 20:33:18 +0300
Message-ID: <20261117173319.1852638-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117173319.1852638-1-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261117173319.1852638-1-tadilhusrev@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a DT binding for MIPI-DSI video-mode panels based on the Novatek
NT36525 controller, as fitted on the Samsung Galaxy XCover5 (SM-G525F,
Exynos850). The panel reset (RESX) is active-low, and the panel needs
three separate supplies (vdd/vpos/vneg) plus an optional backlight.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
v2 -> v3: no content change. Resent as a fresh, standalone patch
(previously v2 1/2 was a diff on top of v1's own patch instead of a
complete patch against mainline, which Krzysztof Kozlowski correctly
flagged as a git-management mistake on my part; see the cover letter).

v1 -> v2 (addressing Sashiko AI's review of v1,
https://sashiko.dev/#/patchset/20261116070212.314228-1-tadilhusrev@gmail.com?part=1):
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
- Fold the compatible string into a single, driver-matching value
  (novatek,nt36525-xcover5) instead of samsung,xcover5-nt36525, which
  never matched the driver's of_match_table at all.
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
