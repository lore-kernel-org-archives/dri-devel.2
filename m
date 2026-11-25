Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2F606A681
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=wcJtjNZb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB4710F03F;
	Wed, 25 Nov 2026 10:22:03 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7A010FAC0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795602098; bh=dg+oSNwX/7p+WyYwZc5+e2rGm/goQ4owkA+4LHREogs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wcJtjNZb0xk4Cr48Pk6IJauvMleHAtAjWLaOCwAfQsgeeJ8PUq/+ItMyUXluulDYg
 f7RF0zI/RGn6snx51BKt5Q4w3+IyenbH47MVdNdjHKWHpJiVS6cwnzOmbk7jG59qrl
 xyT1CAJK0KYaEWFOSc7VhSNGEFbxcxNDJ2B9hr2U=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602096tbloeeaqw
Message-ID: <tencent_5FFF9F0A7E8550A3C6AB3F8AADF2BEBF0809@qq.com>
X-QQ-XMAILINFO: OTR3aNS6beOJbSfoYyCM72//7Yplyq+8+11gkEOvAcqmyqeb7gv7aGw4Jx2wvn
 OqhWbWgpohuwmibYZTPTsLJVIKDuTY19QtCjzjaFEcTYpVf+8kdVhliso48MCajC9jXo+SnsLxK0
 3tm3RuWXsjMBRIpy9pNcQj7/Lo/syren3Ce9myneQYjFjx/WaEIpKpGvsi9zchGh+UEqpJ8mWu+6
 FvbCAd9W91JNUJGIlicwkZZkCjRZ0lj1ymLqzYW67VC3CDEruErzrd421/eajlG/yGxjFE9kF7Ya
 C+pWlPwsmevTpAFYnNRzG95ZK9ZHFRfG/ruRzJ0qVUloIauq6/ly+hKfv33aE7ltTJlTzg/Yd5wb
 yfCwwGETV0k+JVcR08TGhkHozNv5lA/zFHWDCirxuic3f/tK1ThoJijgnAY/6exSVbc+GaK4naZN
 8HDtcqALdlafBc7UHuzkUpUEb8A9eSWGsvTMVwbL+b+h2B7Wll5oRMe2f+E0vRboWq2GeBi2Zvz3
 Qnd/gFTZutMT2pFmNrvlZbeJnP+09i0jO7IrPXWQZBzGTeL6uLCMoHRlYCCK4EIhWdCuaJJX225b
 TwK6uNq5Wix1Ne3M4oKofdV29z8m2CWy6e7kWJGKC6FOeR18iB/Ct4jwnXUC/awakb+G0BdDGeXZ
 dh8vheM5EPvYWTt+xFmQoct2RxLAUk541bSU5nGtzEsEiSumGDIZcEjzpfFv3x4Cr98ZgpgNQmuf
 PUHm2kjwfgWdm/+gzNTHWKgPTjuD/6ykmv5FACoZAUWkf72JnBhJIw3PsTukGKvrb5Ci1N6S9rf2
 D5K0WrxdavraqVP6SusqF+HMidtU+RgY39uBgI7QWCLOMnejEEP+TWKY88boezBEnJDIYyQJSvCm
 poacN8alshbxABtzCvY4T36YVo8kZRpVlhzQ6LjSUvnuZqjWBlg+eWbHyW3rd/aSzggyRm95x+fh
 YHbhesIFyS5mYlEkOJ2MrmCwZLHzWYuDVbfycnd/4w6JZlOOG09ISbm/39ypDE48zMUUqfYsAtkx
 qUYTBIUitTKwB/a3KVI1FJsBA+fMMI69Y26a5epFr0oBANxl6JQhMb12Ta8SWc2n/05IvxKXszXM
 A71ZZ+j6lRFSvlh2jYQRbxfsrd5YfZOy6eOlc1VyVDk2vNJP3syplLxullvwWz35hse4ZhWjXDq3
 ODWR6bhkqrhNt0Cu4/Fyf0CDRR7uarfPZ8iLo=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, Hefei <3066883572@qq.com>
Subject: [PATCH v6 3/6] dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
Date: Wed, 25 Nov 2026 18:21:27 +0800
X-OQ-MSGID: <20261125102130.256-4-3066883572@qq.com>
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

Document the I2C backlight MCU on the VIEWE 7KF82 module
(address 0x45, register 0x86, brightness 0..255).

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,7kf82-backlight.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
new file mode 100644
index 000000000..e65aa4c22
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

