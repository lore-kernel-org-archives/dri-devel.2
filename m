Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89889606A688
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FIEOWiWo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5E210E851;
	Wed, 25 Nov 2026 02:42:39 +0000 (UTC)
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com
 [203.205.221.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD02710E6D2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795574551; bh=IzcclkVTG1KnK0341G5dFq2gzXEaIhA/6RUSjtt6e5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FIEOWiWoj5hIUz82R9dCcuO3zoHLnn3qDdDksuzw3kfh4SPtaThJrK3BnY36OFKZZ
 RFXDfhdZmOe96EWeRp4PmSSqqJKP5Jq0bWPRVoDbppEqTyk1MqkOpdMVnD+NTOleUc
 qpXeHKnY5jNCiOFHVbyl0ezOQdE2Pb+dtPUhmiYw=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574549tjxyx0iab
Message-ID: <tencent_091F19565BDF5D847E4F80BFC3A86DE36608@qq.com>
X-QQ-XMAILINFO: OaNVrcLgj+8PuYxdXA9bFLAW3kQAz/0gi/RjhTReY3xcbO97F0AOdXlx07qXuk
 rv2EYfG+8DPpO3uHtYYhLjYwa3j3/0/FtW8SYht1pjIDEfC1A3xqcZ38eWUD9TJ35g6VqMu8hTPO
 jPL6aAQ3OL0l836J6Q8+cH2sjbs4gg1yxZBO1uuXazN5b7gaP6newZBy9+ZWtiGodnw4TsY/ck9w
 IeDQnSTBr+gI2J+4+Vr6UkcLbf52I1hIlwlZIY2FmAR0l36yr6ugtmMUhbl460ncRDdmm9M00c//
 yxlYsdCCcN9zxn+wUkAQC4GVqBF6SQPsZuSn2EBN5hO+zePASnUjUjznmJIP2iBQ0Qey/Y6d/bw1
 HVlmyaWon15+0SLXbrPKqyTkoDtpE/3iVYhwb2L3e0F66TmrYfY3XYAmtVVwc8uOwA+zXi+TjpnP
 aIDkFn9G3/EzDwTF2Kyk7JHCRfkj733YwNFWRnGupjWeEFoDWAKXjxc18Pw5nAn5YZONRkm3UizP
 XgSzwRU2otpJgeRaYBbEFKKYyKMtD2hEWwD4ne034F45PhJ9kPpqSLaUuO+Pu+9Ioqq3BnJ3stQ/
 Ze6rgn0un9CxXJoYqjODK+YiJPRVz2KdBq2IhdKMu3rwlLAxN7YbLyCCAupAeaLv4wbj5ua8vPF9
 QF8WiwH1ElSXmxsoDHTKSv6YZF4b69r/5QRpSXpfSx1POd7o5YVJnSBcUt0Fhkqj/2zwTY076isN
 zOI5wfL+lZh0EccYyxA1dxgNijjrUmO2WN30KIvsLIzwgH66B4hXqp9WJKrvRL+J3Z7XPToOv4+L
 vNt/L4K5x/jxeQgpRvfX+XtVg2faAoGWbWjXHvsRtIU95XEAxdDLEKl4XcM7sBibLpG/xotM2xYV
 VoBN65DdF/cZQpIY7bM6IL9BNFTgf2SRBRDOYemysmPjJzbVD3GfJbzka2+0k8oWEeACJgqHO6Cy
 xZWQgKgKKWrE7mqxxfYd1plC/qzlN7108R2Ki6TLAo3h4KxtAapKye/WbNwDLXAMIv474zF8YYjw
 of2wN61mDuqoXOi87qe4wt1+SB5+GIjTtgI6FX04vnX21vulCTmw0DZT8sgUTs0ElbYMmQzTem8s
 EAQVHOGhcVWj70gol578x4ZqrvnPO+xZRgxpKnDajFZ/g13mlzN6MucXCGbTVr/XBOITOjPqYJbf
 RtvHCUulv0lzIGk9FEh4VJb21XVbALpQmnr+ZhxvNPzwMyYA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v4 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
Date: Wed, 25 Nov 2026 10:42:22 +0800
X-OQ-MSGID: <20261125024226.1293-3-3066883572@qq.com>
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

Document the in-cell I2C touch companion used on JD9365TX modules.
Many FPCs omit the interrupt line; boards may still wire one.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../input/touchscreen/jadard,jd9365tx.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 0000000..a49a558
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/jadard,jd9365tx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Jadard JD9365TX in-cell touchscreen
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  In-cell touch integrated with Jadard JD9365TX DSI panels. Many module FPCs
+  expose only the I2C bus; some boards also wire an interrupt GPIO. The
+  touch controller is commonly powered from the same rails as the panel.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: jadard,jd9365tx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  poll-interval: true
+
+  vdd-supply:
+    description: Analog / touch power supply
+
+  iovcc-supply:
+    description: Digital I/O power supply
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@68 {
+            compatible = "jadard,jd9365tx";
+            reg = <0x68>;
+            vdd-supply = <&reg_vdd>;
+            iovcc-supply = <&reg_iovcc>;
+            touchscreen-size-x = <720>;
+            touchscreen-size-y = <1280>;
+            poll-interval = <16>;
+        };
+    };
+...
-- 
2.55.0.windows.5

