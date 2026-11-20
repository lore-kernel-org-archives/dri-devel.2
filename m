Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5760A3820
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9fBYtaP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7FF10E13C;
	Fri, 20 Nov 2026 15:53:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044B910E160
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:53:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0CD246BCE;
 Fri, 20 Nov 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795190014;
 b=kKidHrqckwAkMy3NbqjHXmL6i9Mo7Y/Y0+m/Y7MJvrULcGUSkX/2ouaQUfTXqcfIjVZW
 ZmBSN2sKGviGVFuo0fSNE0TufX2nHVu2DQHrV68Pnioy0FzzvKouQlUEwV+/TrJfE/Q02
 OH898rnzSQ7Lfqmh1E8xZ2kF0FGDGGGRYiHaNiV7mTTYVZc1iFqcZTilY71co5uAhOoZ+
 hw30FrsJaSsXBxMHeuynk6ky0xVqgkH37gKXxFGYlhsVwJUEXG01YPqTT5+olDuWfo2XG
 wCoAyj0my6FrXV/0HcvLFLOmWhvnbzpP+BE8i/FzLCaAsBzqMhbi2gggQHlvycsZskA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795190014;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=qug1FZc3618GzaFITM7kg2zKro3GCxEUhk8Yu14ofOU=;
 b=JKO9DI/GGIRuVONIZJ3POmIATU2Bts/Jt6QBdf8riGA0qsji5rU1DWGqvsJWucjBvhpH
 lD4DzDNmpwHoWGpfNNfXRiekq0KDm55G5njtLUduJ8ARrD8JMS6p3IWWGF23bgi03jk5c
 Katd1rWs5Ob9/ZjdI0N8V2TsZUavC47qjsBLSESr4Rl79BnwCBx9m3kqoW1jwj+ThjTYa
 iWQZovAnUxEYQWSCLURMz25x9YUdmv41YOjzwa5KCRoDjSzZs38QvUz8VZoF8EstH6wth
 I23+ApLUrl53zQTbBC43AHsSduYz/obRGdUjBlrpy4B0WJegpQH3xOfUfWOuBCWiezg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 255A61F000EF;
 Fri, 20 Nov 2026 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190014;
 bh=qug1FZc3618GzaFITM7kg2zKro3GCxEUhk8Yu14ofOU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=B9fBYtaPTvxda8AGLDMXW7IJlUzT9sKC4t68QmnDg5fKFLTjym5t07JXkX0Pa4EG2
 WUO10pwZxtwwfDMZSgVMSgtN6nalceMvr+8yxqNnwhd7IbjKtoUFGdrr5jQSxmgzag
 VYWROrYih9juBftfYy32tsbH+CoqG+5gw6VxQGN+sSr/Nebcis0Ewnz/s2642RZykD
 S2DBfgS0BaoOhS4snpNXFT5qsv2VyUfPqVfHmw66QLjHAEVeNiNnLiPbLSP4RDtSdQ
 2NKnFXsKz3N7phwD4BGkskorSWVfuaCHl3k83gQzXQcBrNCm39E6Fv9ilDNUFWQMaQ
 a+ICj0MHffrVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id AE5124995A;
 Fri, 20 Nov 2026 15:53:12 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Fri, 20 Nov 2026 21:23:12 +0530
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Ilitek ILI97680A
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-vantage-panel-v3-1-00b306146240@yahoo.com>
References: <20261120-vantage-panel-v3-0-00b306146240@yahoo.com>
In-Reply-To: <20261120-vantage-panel-v3-0-00b306146240@yahoo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189991; l=3164;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=mguMRigXlL9W/ZJihG4Wv5kJ3aSmWYkhBNtshsgKhww=;
 b=5EYJgkxS7PLMOXcDN+hhF/PzH80PG2E6DwVgTZ3szzWv/BS6Nb3r+5uffv5paWI/ImMlIhASR
 2m74nGKvApIA5QmQwf+vOxPVUEgD/Zp3EetvxCVAVmdK5NuOaofz13v
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
---
 .../bindings/display/panel/ilitek,ili97680a.yaml   | 75 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
new file mode 100644
index 000000000000..c098b44fef3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
@@ -0,0 +1,75 @@
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
+  - port
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
index c4f4e48774d0..e2a8093c328a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13040,6 +13040,12 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
 S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
+ILITEK ILI97680A PANEL DRIVER
+M:	Venkat Yadlapati <venkat.yadlapati@yahoo.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
+F:	drivers/gpu/drm/panel/panel-ilitek-ili97680a.c
+
 IMAGIS TOUCHSCREEN DRIVER
 M:	Markuss Broks <markuss.broks@gmail.com>
 S:	Maintained

-- 
2.56.1


