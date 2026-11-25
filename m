Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87D606A69A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=H9w5dsB1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF16D10F97E;
	Wed, 25 Nov 2026 02:11:39 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E11210F984
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795572691; bh=rafo5xWjZms4ztNLZo9OnFsViieRHJz9Eo0soR6mdv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H9w5dsB1epE/tT/RHIivgLs/FHKmx/OjcXoVSJtJdRKPMfv5j3o/eJ2+Jgm/wd54g
 atliziec+d5ItpKx2qrl0JsFwMuY3bZZNg8lCk558laTrwHWbfySJkIZSIpgmG4GxU
 T3QjClkeVoljXhHaFZUrdDWhS+xzR3ywJKSWUjMU=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 2DCBA053; Wed, 25 Nov 2026 10:11:28 +0800
X-QQ-mid: xmsmtpt1795572690tsm562vfn
Message-ID: <tencent_A3BF23A8B6E3691F0D567ADF8B84194F4408@qq.com>
X-QQ-XMAILINFO: MQePU1RDD2O4a6xKmHerYUdNWDnm+wkbK7PXNdYKnsVS9cW4wQisMtIr5iFRX2
 9S7WBis5IfNInk/TlNo9TjVfS5qAcOYkU3yG8oZxKZ52VYMwV92igEHGqVz2vdarHwiTYH+RNNA5
 qV+fmlBRcc00bqLGO8nirWGC9M/9KTklDYDdAbVNwFODZB8F8cKIPCGBxRz58lbos+F/R/x4Z9W9
 qe/U6Mu5K/uXi/i1bTfp1Gn1SXnJ6DMlH8SbDLg7m0zDcQwc9/dCcEmqzwqPYHrLcoAT9pcHkG/q
 /qItFtxQlM03sOXXff/0W9t8Vac3w1lb3VEIlntvy0/rEPLrMHnbp1/+5aqQiUlt61d5F7tvOful
 qIyYfDjJRxAXV+ENroQmT4opfFrbnooxWl2Gd5kvUzpmGrczPBY794bHvZh59UWs/XVIkqz597ez
 LSjcM6DSA6w+h5n13sQdck36c70OU5WjSrfj/nxrnv0Dk0SnuYGc3WAmPMJsvbuWa2RxZXUcKXoI
 n+Z0H+JFuwVKHU3STbSwh9+/k57JWN417lNmTETrBHTGxb+2fP9IToamA+EGHDIcXc7/AUr1hwY+
 6NEvt0srwH5v7YiMeyedp4kvKiFIteTvkTO5m6+5lYXs1R5kWyhcCpiD9R5Go4KKrwiUbStmdVwC
 fZw0w4N9luuwlKrdqBrAQmzOawGvmeatipxaa7d+uv3uDIOM/0ByChc7JQMmVctnJkCxneh7U/BP
 0wUkYKGgZiMhQXtiv9tAYKxGshHOBz40t7qgC0RRemGlNQcP+dTCGW5QayN/CQMumC4HypN5T0nM
 pq4nMep1zBMSi05Pkf5jwSHYQ0IQgIq3P1RyHAWOcA5gtkBi6gs9SyPlFp3VIPHRo6UxuUEFRgui
 5ReOwW5Naxjc2EJeIdN7XVKhzZjZ6+nBK+GTmVr71jr7eSkeoJHQnM8jFvb+X4hPRy/zxiUEmBre
 /FN0FpLqF3GzIZVeMPQwaKgNkMvBCjWTANrcS1kR53rJ5zSfXszP8Xk7L4+KkMSRKCY+cV6KHcSK
 f1cF+Y1/5wIvIF3mToyASFphs007qQxDfIbEXT94UoMFogefLArbGbXeaBxyWF0k4Enx3jw6zUn+
 EJ6z8MdAtIAeGV7cpn0nc78MkGKio6drvFsO5GG3dtc96xs3fGzO4WPw7L8KkrOAlSoMgUkCTUnV
 q5tCk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v3 1/6] dt-bindings: display: add VIEWE JD9365TX panel binding
Date: Wed, 25 Nov 2026 10:11:22 +0800
X-OQ-MSGID: <20261125021127.1430-2-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125021127.1430-1-3066883572@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
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

