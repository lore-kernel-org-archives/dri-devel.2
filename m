Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE2606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RTUgHNM9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523C010FDD8;
	Thu, 19 Nov 2026 07:49:08 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAB610E178
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795056482; bh=JVKuOHtqWaENIpZF84Cfi+faC/DMX8myONlni7okLBA=;
 h=From:To:Cc:Subject:Date;
 b=RTUgHNM9Mhp+Qpt/qiq3ug1uHuTSq7JxGTKGXe+BRcda0+paXCYnc8+HFMU5qc0Io
 5uBBylzAwuEFO/55MFfPAvgZBYqAjr9BnyTUgX1qgnWgMCiPwyd1w17wMW3L1DXpWP
 7XmF2nmKyYrYi4+MfFkKUildekIBi3uqfRqoaWeQ=
Received: from [192.168.2.135] ([113.90.236.90])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056479thkfw135q
Message-ID: <tencent_C97CF8588D7C3312CE3D51FCDEA1E68DA70A@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLDdzQ1AeBNKtFazquo18o/UyQqpehHfXjv3O2vLcw96g7x0R8NJ
 JKuzZWWxGhQhCtmjLKiP5nJPQW7Mo//2nuaHHKNiesgM08wJZoxoNwb2dFBe1ZzPF/xXuF7uQe7d
 J2QAo8aVZc1nQC5N0+0U0uA2d35PEUPfrLOsqjjqmaR0etHx9eC+Qd5GiqAi6Or5P/IKqcn1rl/k
 O4XtUjA2OwV+pY5WnXuqgjFpVCiEyetZeMwGvVQ6P/G3c77SL36s9uHswtU0lgixrt97TXFww+j8
 JMQJOKsd51WOXhmArhcg3S11PuTYLmrV/HinJbX1Y5J0md5bGIgf/gQlhXNG6ukRmP4gCjk6DnEP
 hCg2z6ePJ1zxZmZ7rxnDNOHaHWFj+DixdUDhR+lv3RALM//HCpeI1xPibczq/rPg9CpDiHUbR3iA
 zca+bCcFwDd88wMDfgeFOYBN2sCiocvrdsfuIxXL9bK+ep4/9xh5Cyzlx4cnz2fDH3x496/yprog
 erIhLHLvmQ0IdzDWV2nQkZsn6D/ojSRVadd8jcI2XjvAbAajm8i6bU/+Xi7LflLJfQH3XkHrGYFT
 iP/9y5BMQDRiQYH9xs4ZarJFzcKlYj4OP0MSoeATbL56i32pvhth7jX5/iSQxoOMWYroJ1Wn6k/d
 5i17Bw2qTI8fnphAJEnCGz7rE2Ah+fn50CI9Mv2C9ikWxGsAHMbXXOEUfv0gm0N/DI7KUeRXA2Ih
 2YBVE2S0nkKZP3yQMv2D5bXTMifwuk7fUx63bA9T2ld2yRfWb0ySFLLtn4fIGdFxJ4Do7kDfI9Zj
 UA3WKMIibGBjcRfIiI/B0zKf8HfDCtld0TzCdl/O/Iqo+PAfWS7H7Kc/U53sAa9OTH3oZbr3RvKr
 WIXOC6U+vLrsnKr5voR0Ij0o1nSaoKeVOoSHQT8oJtdTlX3rJi51UdIByUhK6v4s1483UglTxhZ9
 /8IKKdblN3f087HgXdRQIW8PdyScSspRYcwQ6P8DZ0E3fJ4URceIzgCJEv81hP4kk/3F+tb6Tnlr
 r96QRfvCnJgkTzjZNojfY3d+zOuudhIzP/VXb5FfG9XTDI0yTP
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: display: add VIEWE JD9365TX panel binding
Date: Thu, 19 Nov 2026 10:48:01 +0800
X-OQ-MSGID: <179505648148.50956.16568373722115319718@qq.com>
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

Add the device tree binding for the VIEWE 7KF82 720x1280 Jadard
JD9365TX MIPI-DSI panel.

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../display/panel/viewe,jd9365tx.yaml         | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
new file mode 100644
index 0000000..b15d6db
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
@@ -0,0 +1,76 @@
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
+  vccio-supply:
+    description: Alternate name for iovcc-supply
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
+
+anyOf:
+  - required: [iovcc-supply]
+  - required: [vccio-supply]
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
+                    data-lanes = <0 1>;
+                };
+            };
+        };
+    };
+...
-- 
2.55.0.windows.5

