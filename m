Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089160A2611
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PjNzkbEF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF0410E6D2;
	Wed, 25 Nov 2026 02:42:38 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285CB10E3CC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795574550; bh=Zley+tZa5UBCEuXBe2RxpLK6JVeG8RJlYwhvm31EGek=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PjNzkbEFfNbZW/gb0km07ggchSJWfMI5Cag+ZRIjJKybUWEshc7TjVc6WjVppN5zd
 USPoQcTpBAPRUpG8kU9ffVUbOgX3pB9V3GX8eF2XfH1eRNRZdnjdTamZ6OdOyDQLtF
 PTim8vWj0njQFPRYoUM0mggcPb6+NIdpQT1+ujHY=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574548td0mvfelj
Message-ID: <tencent_7B5CDF8F84744FFBBFCFA89FE3651F675608@qq.com>
X-QQ-XMAILINFO: Nmh4/X5oQWzAbzI4i6Nu6Jkn8vWiOLtxmN4EoCBsQtDez56ZTnB/e9aveeDdAB
 2eUUrqW6Gv6GaDkki5415CQnHIueLDUXA2JPI5/2+fbGu1Fv/Ly9S/BucaaulMY6yPCwFjtIN5o7
 b7kptzI/iyhUWNsghjVTS8OsHGD+8sBSkpdiEtpowR7s+RlCsjjcRK46nqnoQhyCdNgC3pSiN9iN
 TC4VzpA2s2o8CKBf8P/VY8NkxBqHmHIhrXZPhW/qyCDjMitOFr2ddUiTvAQqrjUB69akIluy+tBu
 H/LpEZjlPCn3fKM7co3BAJ0sBRBEv49ajnSVQ1Yr6HS2PrM/BLDq38vHnLCGgqa9gG4OxcIpMGx2
 pr+Uf5y+2/vOI7Svtu/DR+vICwy7LPpJtTqbgXACPNRyTZbaBQadGjaTv4MiXjGmyy92M44C/k1x
 uHD9N86mGox8RUUAm0swNZ3cJdCyE7U6JvJvJvj+rrFUF5b0y0+mRO+qtqmzos19WOc7HI0GjH8P
 J+GweOm5zNXMLEV27kWYznSCpz+Dp1m5dDLFgCpsSCYow0ZH7un9wTHRSh3gJ/V21LbaN4OWroBP
 w0Nn+14Y2lclLFPnNFqYRF8VXnJ4CzhlzXRQz1AUvoCJ/oe0JUsiG3925Iap+Te8n/88dLBPteDh
 hRceAFsn6F6ScBIDr7alg8YfEzzJn0zPS1FWF0qB1l28fxspzx/Hn8XdID1ITMfroGwruPeqCcv8
 gWMUoVrPIQbCGgl2yH6Mctq4avOfaojXB2YHY3ZZY/v8KXtRCV666KBG2g8C+R5WZhbtN5sE6JRf
 K8KEaUSNv9vnmMVof3tnOj/vYMuF/Y9MiuEpYSXYiGpR1uBTtW3FFHIJqpvA4Nh2fSY6kGDLr5pY
 FtL3Po8eB1AGiEP4CNyG7R4X6v/ZIHbe7NuLZy9pSy7ESWl13b6uOxmuZHmPKwUPBN9u0a5LYB+G
 /h/zfvOG66ustLjdd9MG6D+UXAIManrWaJZRCgdojv4aYNVeW/Z9qdXRgTQdhhVt3eott0UdV0tZ
 2njKO31rTKNnOHkoM1LNbINkqKlkqYM+JICerUW+rHTEsA7sBuHEkei2YWs/c6J/SqeeiiNjLm66
 QaZGCMxEczWZ4+mdKrCtCZ/0X3PZzyCVlNmGYIdVnFyDCoZIU7IukFpusfKA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v4 1/6] dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
Date: Wed, 25 Nov 2026 10:42:21 +0800
X-OQ-MSGID: <20261125024226.1293-2-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125024226.1293-1-3066883572@qq.com>
References: <20261125024226.1293-1-3066883572@qq.com>
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

Add the device tree binding for the VIEWE 7KF82 720x1280 Jadard
JD9365TX MIPI-DSI panel, and register the viewe vendor prefix.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../bindings/display/panel/viewe,7kf82.yaml   | 67 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml b/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
new file mode 100644
index 0000000..1ece390
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/viewe,7kf82.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE 7.0" 720x1280 Jadard JD9365TX MIPI-DSI in-cell panel
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  The VIEWE 7KF82 module is a 720x1280 RGB888 video-mode MIPI-DSI panel
+  based on Jadard JD9365TX. It uses two DSI data lanes and exposes in-cell
+  touch over I2C on the same FPC.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: viewe,7kf82
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Panel VDD supply, usually 3.3V
+
+  iovcc-supply:
+    description: Panel IO voltage supply, usually 3.3V
+
+  reset-gpios: true
+  backlight: true
+  rotation: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - iovcc-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "viewe,7kf82";
+            reg = <0>;
+            vdd-supply = <&reg_vdd>;
+            iovcc-supply = <&reg_iovcc>;
+            backlight = <&viewe_bl>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ac7e0b..9135da6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1739,6 +1739,8 @@ patternProperties:
     description: Vicor Corporation
   "^videostrong,.*":
     description: Videostrong Technology Co., Ltd.
+  "^viewe,.*":
+    description: VIEWE Technology Co., Ltd.
   "^virtio,.*":
     description: Virtual I/O Device Specification, developed by the OASIS consortium
   "^virtual,.*":
-- 
2.55.0.windows.5

