Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25C606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zSMz9xnA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7BBC10E5D4;
	Wed, 25 Nov 2026 02:56:58 +0000 (UTC)
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com
 [203.205.221.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B114F10E870
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795575404; bh=o2ZBOBSK4J6IpmVXYBOJZpEDX+16cuL5L8cVT4NeqK0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=zSMz9xnAGJlhxBLwFxKPL+emy1iLCHJFdYRLOtMGpMa94mO3mDlM1IKLI1W6v8Egw
 u57RT0gIwqDP2CZAiYAZNX4ZpN3MOxEDoldo2nZL91EFbNGTn7mmY+11GNWNGgiKuK
 O4Lo084hDwB9BMJKnntci9V3C8nPIQ/COiBEvPQs=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575402tya4smuws
Message-ID: <tencent_2485513DC7293EAEAC68BFBD08159F067E09@qq.com>
X-QQ-XMAILINFO: MKE0p0laDlulEU8jKJ9WA0tvJUiv1Z8UyaeMLqPKpR8ObWI1Gq1h7Ojm90UuOR
 2tzSitwrOpLmC/Fi26w6rXGUNX0CmmDSlbDwZFBRNIfKqIyEkGeurLViPDC2NCXK6CKeSLoWFNLE
 ykJ3Fl49AUB/8D3KYWR07X+9C9Zd4SrtRI+HqA732SGmg5b2h3kbnTu7XDAQczlANPT3qJjvHuJR
 07IRiZQQIC1EgJxY/bW5vXtLBcPZIFd6cwbreX//8tEAwG7yn0yJANcm3mUTvgcgyOGu8QyUEgWu
 UFFSLofTUJKFKUdjeUtF+rDlgYHTv88UeV7XVNQ/Kc0RGTUVVmy21MFU9BwbqOUNIqsktXGUidWV
 KXL6NRwb7T7UXbi7GgI6hNwqiGp7gKdMGTuNPrMMLzyknTsNUWCY+5RKPCc8rP6K/B4LvfnmUFYK
 ek5UnGTHcOXVa7lbjdys4Dmtwh30ch1Lni4e7hsW8IpI0/Gg+ABNyODI8U7adsBqloe35/enADNk
 YgpU8VUx+YPj0CDS0zQF+AZfQEofOP145KyPWFfxYFQ3fog4j5iNWHQPuvTn3h/iaCJMcqPkBg45
 7yiaOZG/Sky4mp+UJeW71G8bfy3aeM3yjSp9kmBpWCl4JbnBlM9RmomNNZ/pSO5O/l8I9xBhT63b
 rSRwo9Hm4YtLpfa1YJswl33N98CyoL0YwnTkEEz6mMBcLK1+DOu3SKWI77ZS+ipi9b4q0J67SGzX
 m8lBQWkJeSggpfteKx7/tgqpwTmY/RXNTskwAO5Nz33HEMAezHhTCo3BnwgO/czqN1ar2o9Q86Ni
 hq7ENTqKk46fmmLxKdJvm9ME8gCqGIFyTI7FUB73vF3u8US9oBi4DTO6r29/p0oUQN6yHKVmCXWN
 GZuKdS4dV5ZxiLs+CV8taMVMZ4z9trqfIPvkRVC68R5TuOHBjMfrEeitBFtXJCVI740nnfOGq23p
 re3YGKFxVHWfeae96yAsAkAQpTBlPMIvA66A4fvqNDz8Yf2eduWjMr1fFCUk3XK/IbQxC0mWg+QX
 0s52bTRd2IzoCs+PZnZpQQf8RZibSTtFp0ckC64+h7SyY10yTHixCCLJLIVjV0hL/9/NSW+/7NiM
 2gS/jyiDkiTFSfj/NfK8PCYnO/Q8Odl0L4eQtRR/aw92PtS9h4zC6Sfl5f8s3pJt4S8DOOIHv38d
 VlEv4+qesHS9+m3QkhDMFpDj9bQvkSQcN+NOhhErj5vkS6zg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v5 3/6] dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
Date: Wed, 25 Nov 2026 10:56:35 +0800
X-OQ-MSGID: <20261125025638.1171-4-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125025638.1171-1-3066883572@qq.com>
References: <20261125025638.1171-1-3066883572@qq.com>
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

Document the I2C backlight MCU on the VIEWE 7KF82 module
(address 0x45, register 0x86, brightness 0..255).

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,7kf82-backlight.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
new file mode 100644
index 0000000..e65aa4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/viewe,7kf82-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE 7KF82 I2C panel backlight
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  I2C backlight MCU used on the VIEWE 7KF82 DSI module. Protocol is device
+  address 0x45, register 0x86, brightness 0..255. A discrete MCU part number
+  is not exposed on the FPC silk; the binding is therefore keyed to the
+  module.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: viewe,7kf82-backlight
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
+            compatible = "viewe,7kf82-backlight";
+            reg = <0x45>;
+            default-brightness = <200>;
+        };
+    };
+...
-- 
2.55.0.windows.5

