Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA1606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=startmail.com header.i=@startmail.com header.a=rsa-sha256 header.s=2020-07 header.b=EriZjacy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E6210EC84;
	Mon, 26 Oct 2026 08:37:24 +0000 (UTC)
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67D010E1CA
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2020-07; t=1792935517;
 bh=RMftgAUp5cONeZ2SOkSnUtb3aJRq1ym02GWaJFoUPeM=;
 h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
 Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
 Content-Type:Content-Transfer-Encoding:Content-Disposition:
 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
 b=EriZjacynyZoQOitbldrxZwmdVVNaB9896vzSOG+Gu3b564D7AW9cuDN1mLeDNI4y
 ziUFHAFrvGGSKv25o9oMiNpVNCpshw5TxxY7evHQZ0EXWKQcegC360HxxFqL3/c+97
 GfkKcDSnrhV0Oe6avSL2dAZDVbJdpo54hsgBKib8APw+G6xQdGiV+ETFHXwCmtsl9R
 lTofqMNTvGjFCeiEES/NHWjNsceqSOWFwXwfZd+riupu73F3mpeFbv21bsrxFdmvUX
 guKryvEzr8OXNWAkad2TVnvMJfKT+r2TXWpznTemE4l8bM4RbLrrKx7sHzSRrM6rED
 rllBvbuJ++DJA==
From: Jacob Pyke <jacob@pyk.ee>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, teguh@sobir.in,
 Andrew.liu@moorechip.net, Jacob Pyke <jacob@pyk.ee>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Retroid Pocket IL97680A
 panels
Date: Sun, 25 Oct 2026 23:37:40 +1000
Message-ID: <20261025133741.100490-2-jacob@pyk.ee>
In-Reply-To: <20261025133741.100490-1-jacob@pyk.ee>
References: <20261025133741.100490-1-jacob@pyk.ee>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Teguh Sobirin <teguh@sobir.in>

Document the Ilitek IL97680A panels in the Retroid Pocket Nova and the
bottom display of the Retroid Pocket Duo. Both are 1280x960 MIPI DSI
command-mode panels, with different supply configurations.

Link: https://github.com/RetroidPocket/linux/commit/9bfe85be2179d03338d09b8900f3b1916999ef15
Signed-off-by: Teguh Sobirin <teguh@sobir.in>
Assisted-by: LLM
Signed-off-by: Jacob Pyke <jacob@pyk.ee>
---
 .../display/panel/ilitek,il97680a.yaml        | 121 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..70a1bdccef75ea3ee6335304ede771ff711991de
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,il97680a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek IL97680A based DSI panels
+
+maintainers:
+  - Teguh Sobirin <teguh@sobir.in>
+  - Jacob Pyke <jacob@pyk.ee>
+
+description:
+  The Ilitek IL97680A is a DSI display driver IC driving the 1280x960
+  command mode panels of the RetroidPocket handhelds.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      properties:
+        compatible:
+          const: retroidpocket,rpnova-panel
+    then:
+      required:
+        - vdd18-supply
+        - vdd28-supply
+    else:
+      properties:
+        vdd18-supply: false
+        vdd28-supply: false
+
+properties:
+  compatible:
+    enum:
+      - retroidpocket,rpduo-panel-bottom
+      - retroidpocket,rpnova-panel
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Core voltage supply
+
+  vddio-supply:
+    description: I/O voltage supply
+
+  vci-supply:
+    description: Analog voltage supply
+
+  vdd18-supply:
+    description: 1.8V supply of the panel module
+
+  vdd28-supply:
+    description: 2.8V supply of the panel module
+
+  reset-gpios: true
+  rotation: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+  - vci-supply
+  - reset-gpios
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
+            compatible = "retroidpocket,rpnova-panel";
+            reg = <0>;
+
+            vdd-supply = <&vreg_l11b_1p2>;
+            vddio-supply = <&vreg_l12b_1p8>;
+            vci-supply = <&vreg_l13b_3p0>;
+            vdd18-supply = <&vdd_disp_1v8>;
+            vdd28-supply = <&vdd_disp_2v8>;
+
+            reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "retroidpocket,rpduo-panel-bottom";
+            reg = <0>;
+
+            vdd-supply = <&vreg_l1g>;
+            vddio-supply = <&vdd_disp_s_1v8>;
+            vci-supply = <&vdd_disp_s_3v0>;
+            reset-gpios = <&tlmm 73 GPIO_ACTIVE_LOW>;
+
+            port {
+                duo_panel_in: endpoint {
+                    remote-endpoint = <&dsi1_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index b9424b630ac34ae6b1774416ef4cb3ef1a8ebe63..d1be1cf2b93c4fa57ffcb6a17aaf2e14dad0deed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8235,6 +8235,12 @@ S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/hyperv
 
+DRM DRIVER FOR ILITEK IL97680A PANELS
+M:	Jacob Pyke <jacob@pyk.ee>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml
+
 DRM DRIVER FOR ILITEK ILI9225 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
