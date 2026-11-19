Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5F606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fPHSuZ/i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D57310FBDA;
	Thu, 19 Nov 2026 07:48:44 +0000 (UTC)
X-Greylist: delayed 67386 seconds by postgrey-1.36 at gabe;
 Thu, 19 Nov 2026 02:48:09 UTC
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com
 [162.62.57.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D016810E072
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795056486; bh=ORu0WgjqNvSeA6eIhRHMpYXThT/LB+K5eegV4icd3cQ=;
 h=From:To:Cc:Subject:Date;
 b=fPHSuZ/iboMXGBujy63MsgybwcqvGgf4GnGQ9YwiYwJCScFqgiVjQmahUZowYT52l
 5vNZl4Xvv4cIcEPZZEALMBufXIpj9hcy9YZ+sTfI/qfa6TX6nFoONMxYKRXvmMAV4n
 eqNtP6hjXR5jNjgPMFPzgcNTm6wF7Hd1QWJiIVv8=
Received: from [192.168.2.135] ([113.90.236.90])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056483t4iyzkuqr
Message-ID: <tencent_093E92ACAABFAB09F39EC07F4350A5C7BD09@qq.com>
X-QQ-XMAILINFO: MvUAcPkRmFBfYCwSOLBcyjSEkhAGI5fuwc4Yaq86G5JdHKCisGEBYB6ox+1j8s
 awf3yppDg9VQn7P5V2PCr62BFlJc5F4AHkDL3i9uddjQQo/4ttti3JHe/BKtH7QhP5TCoxANijM8
 xeprRk6Xc6x8nwMymwQD+4S7CsoJf+NFfaZL2fqQ2pFHJ45l/IxD6J3wUIx5CwlG+S9PNwjeyJte
 HqXveBGl4ezZ1mS1DwudbjTJZOs7I6sdoVg7yAGlHNECYMBV7JdAoMGxkmKg88MiADRxqXmi7CPG
 8pflKT/XNBF6J7yQAWid7B3xHmbZBcA/JiGptXiKj8tbc5KgAwSmLtoQyHdBdGWsYgmD2VLpKHQ7
 o/oyVH9OSY3HIB8OPjuu3Z4j/Pl+Lm9pfu061N6x1uTj1lgYDJ+1o/Lfyq3X2hKO7P41qfvc108v
 tjls64dIOjUwAq5U6X2AcJ+ZLHrcCagB4HurTHBHtxsWArtTwfOmnJ6jIs6tQ+SSEhgpWjQtRyBu
 bvCnvPoHP03KIy/5HhLcE0WBk8XB0m6fIBJkIKWtX+yT+hrIfSxxLxxZO6My45zvrT1qGuB4XGqh
 WThq9irq7IP7KkhtQVt4DCO4wwJ0GwrGuB71hgCycz/+N23tag6XP2wI6mcbyMeT/g3PClF2WF/B
 prAJedxUfQe939KZUwECzLUZKGRfbHWR2OBSPAMLz99ltq2PEQkx8RCCr3p1kmYn4QyQgoiEGMe0
 FoYwPS7qu1Ew+Sqd0XPFnfhfvYrE+wX0RUMWr6RuDUkpEKjL0vtQQgKRMNiuIWOl+zaTcsW9A/dt
 j6CdGWgiMAIN60IKb5r23Yxra2mJpU7PXXJftFH+Ol2JTbI9mMnQExIV8C5UMaBbGLSfk39LEE5R
 cN9uPDbk3FdNdIHf6oJiJxdBLNX3fL9EANcQb4xrqAzCJHTG8thTLr2IqETbivknM20F04fG8XU6
 SMDE2amLGkKM/GpOFlx8EUzarxHPXkIMtO9/rQcFQ3HYsDipBdaA1e+5wLJDjrjjVuqfto01JbL4
 2gJmchsp1+kMPBwGcJTRC0NWIG1b0au0uXLYulKEdt4yqioHXIMfKeu83BwrQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: backlight: add VIEWE I2C backlight binding
Date: Thu, 19 Nov 2026 10:48:05 +0800
X-OQ-MSGID: <179505648555.50956.3731361690188155189@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the binding for the VIEWE panel backlight MCU on I2C.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,i2c-backlight.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
new file mode 100644
index 0000000..ab60c2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE I2C panel backlight
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  Simple I2C backlight used on VIEWE DSI modules. Default protocol is device
+  address 0x45, register 0x86, brightness 0..255.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: viewe,i2c-backlight
+
+  reg:
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
+        backlight@45 {
+            compatible = "viewe,i2c-backlight";
+            reg = <0x45>;
+            default-brightness = <200>;
+        };
+    };
+...
-- 
2.55.0.windows.5

