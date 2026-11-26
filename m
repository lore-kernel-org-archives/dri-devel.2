Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ABE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igIfrBDx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF0710E306;
	Thu, 26 Nov 2026 13:45:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6FFE10E992
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:45:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46ECC6342E;
 Thu, 26 Nov 2026 13:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDEE1F000D0;
 Thu, 26 Nov 2026 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700748;
 bh=OmdsYsPFM6ffXZsc8MJ2vr1mOgPKajCl2Rdgv1f2VDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=igIfrBDxicSyMfFKWAQapEBL/i5nq9kBKJEy70Iz1bizHvJBgH9fzPivOyUE/xABS
 fMHM2yyJiqHzs6J/SuDixJmTffZSAHz/higaExYzWfq7lmHM/Da1jrWjk00z5rmiqq
 MXdiqJujJ5vUyi+DXwgMcCle854Rsp4AkTy0zjFf70qGlnuzM20xzVc5hF7sNBrOsL
 TwBNBnw24pz37ckEWIx/gIG9fmCixziW4YAQdobG4CTcIvg4EzwVdjb64AMDAhZmhi
 ofteAw31kBGKV00uD1/h0z6dclE3p0V4Wv5xlxt6C/cfrZ/N14BX8nsz7GCJQT1xcV
 nWe/B0Gb6tuLA==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 02/10] dt-bindings: display: panel: novatek,
 nt36672e: Add bias enable GPIO
Date: Thu, 26 Nov 2026 15:45:00 +0200
Message-ID: <20261126134508.320700-3-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261126134508.320700-1-vz@kernel.org>
References: <20261126134508.320700-1-vz@kernel.org>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pair of positive and negative bias supplies of an NT36672E panel,
AVDD and AVEE, also known as VSP and VSN, are either provided by the host,
or generated on the panel module itself. In the latter case the module
exposes only a bias enable signal with no need to describe the supplies.

Make the AVDD and AVEE supplies optional, but require them to be
described together as the indivisible pair, and add an optional enable
GPIO for the bias enable signal of the panel module, which excludes
the bias supplies, if present in the actual device tree node.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 .../display/panel/novatek,nt36672e.yaml       | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
index dabee16bee22..c4ebc7df3344 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
@@ -9,9 +9,6 @@ title: Novatek NT36672E LCD DSI Panel
 maintainers:
   - Ritesh Kumar <quic_riteshk@quicinc.com>
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
   compatible:
     const: novatek,nt36672e
@@ -21,8 +18,20 @@ properties:
     description: DSI virtual channel
 
   vddi-supply: true
-  avdd-supply: true
-  avee-supply: true
+
+  avdd-supply:
+    description: Positive bias supply of the panel
+
+  avee-supply:
+    description: Negative bias supply of the panel
+
+  enable-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the bias enable signal of the panel module, which
+      switches on the positive and negative bias supplies generated on the
+      module. The signal is active high.
+
   port: true
   reset-gpios: true
   backlight: true
@@ -31,10 +40,22 @@ required:
   - compatible
   - reg
   - vddi-supply
-  - avdd-supply
-  - avee-supply
   - reset-gpios
 
+dependentRequired:
+  avdd-supply: [avee-supply]
+  avee-supply: [avdd-supply]
+
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      required:
+        - enable-gpios
+    then:
+      properties:
+        avdd-supply: false
+        avee-supply: false
+
 additionalProperties: false
 
 examples:
@@ -47,11 +68,10 @@ examples:
             compatible = "novatek,nt36672e";
             reg = <0>;
 
+            enable-gpios = <&pmic_gpios 8 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&tlmm 44 GPIO_ACTIVE_LOW>;
 
             vddi-supply = <&vreg_l8c_1p8>;
-            avdd-supply = <&disp_avdd>;
-            avee-supply = <&disp_avee>;
 
             backlight = <&pwm_backlight>;
 
-- 
2.51.0

