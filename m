Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18F606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=B7w7G8n/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BFE10E2FA;
	Thu, 19 Nov 2026 07:48:40 +0000 (UTC)
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com
 [203.205.221.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C8010E4EF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795056483; bh=F+GznQ5ehmpoHn7y2B3eJjh+AK3O+EAWYdgljwNw4HM=;
 h=From:To:Cc:Subject:Date;
 b=B7w7G8n/jTBFUs5Y8WvO5w+F7JspS0RECAPjhqNNCjKqZpb8R4XWAXkF7sw2PSV5C
 +nL3UH3WbM3ZYv/L32UXjlAbZ7FMLb0CJmTHhA1y2cxcuVZ3jyJ9S6odPBPsaBB6rn
 ueO9NRjyp+Y3cxQlnChhuGNFl8N6GG2PP2USxziE=
Received: from [192.168.2.135] ([113.90.236.90])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056481t6yqslami
Message-ID: <tencent_BF0B9E6C7E95501FC63D3F98AD08BEF70909@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u9yaGSSvTsV+kFTq2x4uOhZlnqKky1YHpBZLwIyZYdRyE6qUjRE
 J2ePGTtcHEPE9tfQAMpjoWKU2It+X9Gpwt6Lu6yMQS1WpG8dBLfUN4oJxA4jEBZglrOUEcnRJada
 meP8LSuPqLNUxOXdxd1Xp7j5tykP2MCTbFODxFf81pD69+kkMVEPzKVdUpWI/s0H3vgvKRgIaMKQ
 5hvybxn7rtFkJlF7gk2xKcql+Kz82puJmkWF1HYmAtGET/DpRI8bO5+G7xEqbh3O9xlLDVr3gniD
 cNZ9FEK+22xv03d1tiwC0eanMjv+774MLCBXkEgbQdwYVQ3THML2yJl7zKTKTIaPyah1ReyschbN
 vQOeF+tNaYWThK3a/MjHptp1VXK1ZAkL4NaFLQe0Q1U11maM2ZcFjusHjsnN+vGF8reaXHC+pPv7
 7RamsyuNK+5+/tTXkl+ar+22OFW0PCkKfCJ/4j0nJSZXEt6cYHfRrX2pzLFMdS7ry2aPRiYzY8gg
 1eVdAikoU17JjSxUbB3z7JKwbcfBeN9Yq5LvaiNPG5IBxxkLeJcZnSPuwZpiD+cwTJUewaKCl59h
 cFwmQky2YXYx8xG6yN4k2SEdI9gR7jT6M2fIPA/uioGh6sZlsCJbKoq6dwkovjQrKMYDEIbydxW3
 f+J8Mo1/oFqyyFJ9A8B4qVqalxXlGbMHnZvlnfH5KvDcD7TVGSSJbeBkHR+Z1RKxCm1wXgVs5KFQ
 63k++AAtDtO9BMPAAxOhm+TxJnACxRBZMmx/qJGMdniRLBqumWcABR9A8ozkGYEuPGlQMnLI8NVk
 jZxgTLGwJwIivdjZeRVJDca69yYNUWjBSz1N2hFlCbBhjV7FlhfiUMTpAucHPLdDdpJaqUiltZZ6
 xYccieB9Zs1yGZKSSBR96Scj/FEY8wl2sdLViJWtRdU4EIHJVBRjZfAUDcvPdhWXSQ/RKXOqQmFw
 bXbwVgyakC2GxC0hg5V2mmo250sx5e5g7YhCOhI/IlBUenvKd0gGtY97X3enl1HsG9NR5akrvd2C
 zkQC9+9GY4sAX7jeC/n3Sqj+lesFREwagmWWh8ZLxfd6IcYiyt4df7O+tMwbU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
 binding
Date: Thu, 19 Nov 2026 10:48:03 +0800
X-OQ-MSGID: <179505648351.50956.5246326877700027656@qq.com>
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

Add the binding for the Jadard JD9365TX in-cell touchscreen used on
the VIEWE 7KF82 module.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../input/touchscreen/jadard,jd9365tx.yaml    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 0000000..23696a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
@@ -0,0 +1,53 @@
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
+  In-cell touch integrated with Jadard JD9365TX DSI panels. The module FPC
+  often exposes only I2C (no interrupt GPIO); the driver polls coordinate
+  reports.
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
+  poll-interval: true
+
+  jadard,coord-addr:
+    description: Optional fixed coordinate SRAM address override
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+            touchscreen-size-x = <720>;
+            touchscreen-size-y = <1280>;
+            poll-interval = <16>;
+        };
+    };
+...
-- 
2.55.0.windows.5

