Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BD606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YB3aT402
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D5010E011;
	Sun, 22 Nov 2026 19:08:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C77310E011
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:08:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6863F61D19;
 Sun, 22 Nov 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795374529;
 b=UrrElkwissnrn8OmYxJcDHETAYhV3SVI3VR4dM5/jDx3gEBALx0P1DQvJtzjjl1N6K5y
 voG3uhx48EzPvlmF9hqSGXQs2ZUkwQuqay9V/tAoUIuNAKCqT8/1C5Jb4wc6FTlznEDi8
 k4lyl1YxYxyk8LItx/5goMO9eYc2RCJWcDPLqWwLZzHdU3IW2at6ClpB96I6xGT7cmpop
 rXLoWo9xt5vYoEh1ly5b+r687Ge1Sj0HeIVnxbHQC7y2+5PmB6lCleocyuR4rZlCrjfYD
 O/5J1ap8+xSY0oPYITeJFP7vhwYvEW0RC7cvJW7Nt+RuC9M3bmhzteXjiOkwk81apGQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795374529;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=qzvhvI8Ue92h1GQoRtFdSPjSmlHkO8kXwzNrycwy0HM=;
 b=r+20KGDqfDGxaQjxZuHRSh3+nUj89wrFbX1Bnq76KCoB0dmRh69uXBJTufRWGRIjNa0u
 TQx61W/KawH+seeEnCUn2mzGqTM7tK0Zn1V63hAqmJ5wuBglof6+efx+LtTUvnE2wRBGR
 W1hKaZVVAlT/c5VfVyFkAhJupOjNfyKORvrTMJk8GFbvAaRcSmphLYtwYnHAevNtjjHoZ
 gedVbB9K0x3vQF6+QYh7uUt4XY1YOkiBRsljN+mLiura0Ws3esTh5jgV1FzQ/v5v9CAgv
 Af+fzfFHt1bnlWEJ+4yqrBXB9sQaoaUgIylS93MCD/IoiD58C6+WZtK5yXLL5EC3zaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F28801F000D2;
 Sun, 22 Nov 2026 19:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795374529;
 bh=qzvhvI8Ue92h1GQoRtFdSPjSmlHkO8kXwzNrycwy0HM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=YB3aT4021PI9lbzYYhQbLGG0wmg36fRwSA0s+4aP3ilwdmClCfo7OYgZvIaM5LXay
 GiR2E7MI1xBjLW4bJ4yUtxaoa8M2QI53fFrKT+KPZM74rN5XiJzMX5bENu+QL+K1ch
 2YC1C67x6QgUyA9S9ud9TITtdnrWQFLvM7fxBzVUa6clWmpxCw5NMz9/yWqJU1ak63
 7VK2QsTLlr4RtZvFg5KyCLK0zsR/lAFoCzAaSBBBlN87NMvX3weomQNXAQhMoak/Xh
 0WZZ5fmKgjpZjN37obZ8hzFI/Db2ut43lgWIqY41HsM+RBwmtis8JtWJRRvI1ueZoQ
 FRrvLk9VznPbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 865FF4C1AD;
 Sun, 22 Nov 2026 19:08:35 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 23 Nov 2026 00:38:34 +0530
Subject: [PATCH v4 1/2] dt-bindings: display: panel: Add Ilitek ILI97680A
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-vantage-panel-v4-1-e9c2f15b318d@yahoo.com>
References: <20261123-vantage-panel-v4-0-e9c2f15b318d@yahoo.com>
In-Reply-To: <20261123-vantage-panel-v4-0-e9c2f15b318d@yahoo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795374514; l=3174;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=pMd11GttDXvSG05xxXWSNSksH59o1pEDfRkDLQ9rLIE=;
 b=EtpaGS4xB1fRsjqBW5QvvtYu8/TiPR0TPQL/IXS+KxFdicTHw0L+bqryqNI9D/ION1mYOh0/k
 SU9IgTjrNGnC1AhSEVgs5i27/td2VeF5QSQxZaEzf7nGolcU5+EJDyD
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
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
Reply-To: venkat.yadlapati@yahoo.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

Document the Ilitek ILI97680A based 1264x2780 AMOLED panel by BOE, a
MIPI DSI command mode panel with DSC 1.2 compression found in the
Motorola Signature.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/panel/ilitek,ili97680a.yaml   | 74 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
new file mode 100644
index 000000000000..117b02e7e9a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili97680a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI97680A based AMOLED DSI command mode panel
+
+maintainers:
+  - Venkat Yadlapati <venkat.yadlapati@yahoo.com>
+
+description:
+  AMOLED panels driven by an Ilitek ILI97680A controller over MIPI DSI in
+  command mode with DSC 1.2 compression. The resolution, DSC settings and
+  initialization sequence depend on the panel, so each panel has its own
+  compatible with the controller as fallback.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # 1264x2780 BOE panel of the Motorola Signature (vantage)
+          - motorola,vantage-boe-ili97680a
+      - const: ilitek,ili97680a
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vci-supply: true
+  vdd-supply: true
+  vddio-supply: true
+  port: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - reg
+  - vci-supply
+  - vdd-supply
+  - vddio-supply
+  - reset-gpios
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
+            compatible = "motorola,vantage-boe-ili97680a", "ilitek,ili97680a";
+            reg = <0>;
+
+            vci-supply = <&vreg_l13b_3p1>;
+            vdd-supply = <&vreg_l11b_1p2>;
+            vddio-supply = <&vreg_l10b_1p8>;
+
+            reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mdss_dsi1_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c4f4e48774d0..e3d7b88a50e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13040,6 +13040,11 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
 S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
+ILITEK ILI97680A PANEL DRIVER
+M:	Venkat Yadlapati <venkat.yadlapati@yahoo.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
+
 IMAGIS TOUCHSCREEN DRIVER
 M:	Markuss Broks <markuss.broks@gmail.com>
 S:	Maintained

-- 
2.56.1


