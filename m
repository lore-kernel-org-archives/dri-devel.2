Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99AD606A68F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=CH4SIria
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5067110F98D;
	Wed, 25 Nov 2026 02:11:46 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B47F10F986
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795572692; bh=a/snpFbNdr1tfobEJG2lyvIve+2mrzvf7klSCYbBiHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CH4SIria4z5WX7MuhNuc7NbhXwD/ASRIm7yb6n1e4I5pYPiHgnG5FPvy0drkBTGwS
 DcoSZp9zf7oTWgG2Oy+1w/v5XZjrNtPWpcqFEEQuxw3n+Zh44awL0Dxl7b3Gc1qsTU
 n5l7YJ9Yqxyk19L8ybiOk4v/MJ0ZKURe4IysVD2s=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 2DCBA053; Wed, 25 Nov 2026 10:11:28 +0800
X-QQ-mid: xmsmtpt1795572690tk8rnimmp
Message-ID: <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
X-QQ-XMAILINFO: NxF5De9alh3H0sRypGcR+qCy92NicxhVYIX9nl5dmS6VCj4pDgu3InqiEr1kx5
 qmAzWBM2QgUizJSnQZ6Vm68O+uXkCeeSca6O/1wNqJ0pyTaduIjJRVTUK3zwQAgvcGTO+s+YuIaP
 Oqp9BXYS1Xn05d/uxJwOV8cxCMLSMiNOikYtxg7u6r0bPGbj5JVAY+ecH469R3fWuf2hvMTn+2//
 i6whtQuSQo6NKE02yW1l+ltZWnsh2U9WCRSg8IOp2jxSJxjYOhYMD9dIT/xrJ4YYFgiuCNxa4QfE
 /bzBDiDEthyo2fcxQQl9tYt3QMj30KQv8rquiUwZo6VlEq9413pXr8umqoeTG9n/NR0FLeZw6EVp
 oh+gaR0QqmeCn0WzKcPiG3aRBELtvFxWoQZNPqzf0A07E0h/fOPGvRMoWqYHdMeVYiBukoqdPOwX
 EsBLJorSg2X1AiyHvIo//vZ5N472Gbz8qh5VuI9cVbVLfW481rOHOpovJQuGTY30koAedJk8fWwW
 gTvook/rgRQvVv22xIE3gWHdXvkotVspHHQ1Ph0kyR5Ua4dmOXaygKTPTmzuTK1dgQXiLZduVyab
 sI6+GI727+reTfGMQoHnu51oZ7F2FI0gOR8GGx07gBVhkPFmROmpM3r3lYxHc76LNJM3t+GxmzBJ
 OHei1WQ/lshPiWvTzRIfUJkR3lpnXlH+5K4jcb7UI903rp/Ai2ghP6xuaUY37rqpZKagwiMHTths
 9LkgLnBwSdl9kYNDpuUz8/UY3kqN0eQWRoI4sHpr8qsS7LovVGvaEGwrMQMFhFhYV9il4d9+AQBK
 +036M/gUeZeedx2k3ZZ1Hb42dGrUx+f7r/KQ6LLnYdRarqY+gYz54lEvFj8Fb9f22Mpybr5KNDYJ
 cAqFdTpnEgSdNwJS1XdlcSW7/m0gEqNTMzouyoIKYCfZAl+CPMRgjZaDtgO1bbttW1uxPLjHLFG8
 3wBWBLCJUwAsXyVOhf7LaIUvB5i4Gln1zcXo1t+ulbkeOTHrN0vienhqnV0k5fxHbW9r2JjKQpSL
 mtAmesopFzL6BaHITmsC4104mqLPWHgHWCpYt342x7QCbCEPkiGPWuKhvkxn8W36FQZ04sSH0JB2
 hLiUiWpBUTpnztTVv/vIyeLIyXAkIQywsBGBUAucrQ4djhSTK++s1k+LRkKL5eM/hpGu6XVKmF+n
 zgfLg=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v3 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
 binding
Date: Wed, 25 Nov 2026 10:11:23 +0800
X-OQ-MSGID: <20261125021127.1430-3-3066883572@qq.com>
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
 .../input/touchscreen/jadard,jd9365tx.yaml    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
new file mode 100644
index 0000000..aaf2a7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
@@ -0,0 +1,64 @@
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
+  reports. The touch controller is commonly powered from the same rails as
+  the panel; those supplies should still be described here when dedicated
+  regulators exist.
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
+  - vdd-supply
+  - iovcc-supply
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

