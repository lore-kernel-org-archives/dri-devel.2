Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323E606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fHPMgEOl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7CC10F966;
	Wed, 25 Nov 2026 02:10:03 +0000 (UTC)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFF910F966
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795572589; bh=TGjEVOz9fVueef26xErA2ggw1zdVMrWWFGbmy67BUbU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fHPMgEOlsmnQhXv6kCV+L8I6fqsVWGJ/geL6a+AZybVEfQxIadH6osf7gMCVCtn6V
 VXLRAXhQrog4JMNHN8nrZEEBGIDRTE2gaYJnisLKbGjE5KYQQTw2MTKxN1TmWMeuut
 /EKKMxySpVtxW/4F8XvlGvsW5pgzvNgJYTxW1Mqw=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 26DABE38; Wed, 25 Nov 2026 10:09:45 +0800
X-QQ-mid: xmsmtpt1795572587t47wv4hn7
Message-ID: <tencent_EE81D0ED29E97716D56BDCF1A3C5AAE35B05@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7WDllietk6AzjKROc/mp7qE+lSzxrrc65AKKEBm5KCb469sDzHh
 izgMo5uqOhpLmlLvfFjqPWrkjIV1VlwUR0b74uSvaDOPVJjyNjaMlAz+zPo+UHcQF7L5EKvSxE9x
 +oKiu1k7Gge+R9Uu8UlR8P5+g1F9goq6126Ukns9LmGu077yj61eZcozdleUKwJOX73+EyJY0cS8
 zuXnVRxz+hXZ9K9SkIqYmC+XvmTT7y8z9LD4OzmAQ7cizePdqe/QuDIaVQr46JvF9CojjKbduCUd
 z7fMeERdibhbcUkDzfKlyixZrmZlGVruOkdRRrjkvmoab3y2qx/OxWLZ/1busQUdZp5MsSpgwToX
 pDGMzCmj3Knzps2AEM6SZE98jfktW9ldsJmV7fmVt3r04z7DniLgcSwmActi8gU6io5DDUt+JLyc
 yCdwKSKjHjwaFp+EAqn8mkVZzyb758vLkMY6hPIV+2v4BofEMjctqFC3Z5bea42L4gxdxNAd3ET/
 F2dqJpzKvmeAa9bna5l+XTIPu8wvvFG1bXTAwg9k5oubMqiFxf9+8LqCIc83ubxy43pjy4vLntiz
 9KOWp21PZKILBbc625bqRplFzA1JA/rcvvJ6eUj3mUSv+2rj6tP5vBmzNb3yUPxzYEOmKfijRuzj
 dJcFP5gWUL+t+0+6k7CuxU1KmAlZNnXg9fxXClQWhxlBvN1JGrxfWpiaqrFUAIqAAlRaPItlJ8Si
 zt+6dOY25gE/CRlzUFdJzCSdmuu/JT/q/71eD68R9yFbBNSmvIjk+dXfr5JmuvOrFeQV/tdkZku9
 QKcX5UKu9P0OCR6cGUhMm5vSoh7Y9WCgDLQtnb1cPHnuuoQewoer4oVONmyr/vWsE9s2+w8RBq2x
 DiRweVVFVaxTQvPStmqpDBk8O0HK+0+l5sVY722XHxXsMRt3A+IpkOlyRDa10Qj65qZuIxivncdc
 JPqFD7eDn0EdAM/8uYo4WpPNYb0/zK41TAMvaofnk7vCORmEvz78IPn3zfcymiPUcQ7R3WI8JU3p
 J1uQvo8qUiHyWboScWAU7J+U66GjeeR0CLf0C0cytTwyp85PO3Ctbs48Y6v17e/D+NHa66tA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>, Cursor <cursoragent@cursor.com>
Subject: [PATCH v2 1/6] dt-bindings: display: add VIEWE JD9365TX panel binding
Date: Wed, 25 Nov 2026 10:09:39 +0800
X-OQ-MSGID: <20261125020944.137-2-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125020944.137-1-3066883572@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
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

Signed-off-by: Hefei <3066883572@qq.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 .../display/panel/viewe,jd9365tx.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
new file mode 100644
index 0000000..1043f93
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/viewe,jd9365tx.yaml#
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
+  reset-gpios:
+    description: Optional panel reset GPIO (omit if board uses POR only).
+    maxItems: 1
+
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
+unevaluatedProperties: false
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
-- 
2.55.0.windows.5

