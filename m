Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2B60A2607
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ni2qR9Z8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24B510E35A;
	Wed, 25 Nov 2026 10:21:44 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B2210E35A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795602096; bh=IVcXtSmROoYy8ewp3anjYu9r3jyBrtQp7UnyRqwDipk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ni2qR9Z8Sip0W34bM418e8vcc29r0xPdTklrq3xdVKbn4rszEuZk6p0YrxfGHWoSF
 gEQLquNzZWOrvGNhsgfBVe6uOthafQnGr0H7vXtTJcxpx70hn0Rx5EUtNA9M2ntcAH
 QAreajyA/jF5m7Jp6gEbb8QJV6RbQKlltzDdpZO8=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602095tgl4d3zfb
Message-ID: <tencent_956F9CEBE3C22AF19B9450F6A9E1B71AD505@qq.com>
X-QQ-XMAILINFO: NhmQchj2HcYZWNfMfMNDtljOM1PDPBuN/QeNjxDzr/po8tY82Dj3qgcYwsyG7n
 odr0QRS2BsMQySal7tDgkfY0umpXFyAsHOPltxNNriaeQOvHItAj/7S1RrYD0JlsNQGd3gHJ6fNW
 e1eCRLjK3zkX1fLuwDWFycZZHGXh8eCKbvIxV3qQCxNnwf0NIZWxP5da7QPTHWKaVPmyRNnwDIXB
 a2FZM1HiRmgiwqiknmuNpzl8juf408nOgXyvjSC05qDAe0aPofNSBz6BjsCWhsC4B0fWbCsLnqdY
 EtiBBT/DvrSAHQuPjBq1gwLBuGYrNB+0r107AifLQfvOBv2mvo3QPmVCuHtzWJNiopdYaZV6SSN6
 qblTcQOQGgXl43tZm0omzKseVCIozGkU1/MvUOS61PEFsV3c84R8H2nKEHj90H2ovEl2MC1rHLSU
 /ywRk4PdrggQH9qSU0iVHyhe8OpToWbrlDFSlMNq2xH8TrQe2e2cTciy83e1mzjiVOm91ORRgwhs
 Of09dyE4f3bajGUYB9Yw5Il1csHOn8j16zP6jXGCkXs32VkWV4rfcu68UkNx8BgGhf6MwYV+m+nf
 hcArR8mB0Ww+yoUTHuW5iz0Ess0M2WcI1YHKqKgAs/OKx+WRvggEKnJkdRL3R4ww5I4k5u+enOus
 WG0Znx5y7t/qScnbQegy2rZJ3OLlEU1WPBLcSl1cTX/I79XMO4ZUbBb8cpg3bvAE3SZWk+aqrgYK
 vpx+O83Np25vSa5yXsbK6QixH72GT/lymtiKu5IjoZlQprr23UciciAqeGH/D3Y7XGcjtqQEEKQn
 poYy8dSlmKrq6xK6RG0L/6onKbWH1qfGpTpsemowrsKEjk/NqrgQGqAkEIUr9v0F1TBRGwu45yHC
 2dWmr5mLPgHJR/mn3zjV1bx2tz9JHkfRDsWgsW89ivN1FmDqC4byuYtu3GtgPWgN5VUd+VGccJ6z
 zer/r0sTVBiq7Z8QL4VVx7WA/x/1CCyQOtaH+CUsxa03BnDwpGx+MWwelWjdt3evnU8tz0i03tkO
 JjA/omuetRjmc4wqxkCxH9tjy3mYNTPQOeHYoJRdcPFvzrgE9XNBctoWyphdaCNDH+TrzYJ6pd9e
 R50O9+zI7YtgjS8vQ047SbGBIMawQLiKg3olT0K7s3sWC+SOWlGh1kSyXp4QImxenoGaI5wrYes7
 U+PhY=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, Hefei <3066883572@qq.com>
Subject: [PATCH v6 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
Date: Wed, 25 Nov 2026 18:21:26 +0800
X-OQ-MSGID: <20261125102130.256-3-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125102130.256-1-3066883572@qq.com>
References: <20261125102130.256-1-3066883572@qq.com>
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
index 000000000..a49a55815
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

