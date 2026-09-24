Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2965CC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B28E10F5CD;
	Thu, 24 Sep 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BPLrtG2/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0235010F5CE
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:01:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D972B43BAA;
 Thu, 24 Sep 2026 14:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD6E4C2BCF7;
 Thu, 24 Sep 2026 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790258495;
 bh=6PmAGXZV+htq2Tef1xnLisdfXtwtLDKNBf1RrXQoeO4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BPLrtG2/n056+Jb5PFyzXY9QteDff8B40LDBrAUkBfdXcffbQXtc8qyWtVeQbrQNx
 0k/6CE//vkK3psMxdCexWSYhU8iLOAT2CQCkdbljrdO9MPT7Q7u+Cqmdhq/Aw00OdU
 +C3s2TsqdDGs6v3O0mhD+LaWG94SAbB3QI4dzqOM8ySFmGAMP2n88VQxdvbGSnrzJk
 R2qWaP/tPngxtrMyLJsn6bTDm7cTRIWP59yJz3DS/MfEouwzNXv6IGbyI/EfRQUofl
 NdbuZUkwJcfMsN1eKVs8dlNS0HG1FFlgdSWx/ni9MvcrWgsKjPGX7bzm6Q3FXOHDMj
 I32/Iy3uZY5GQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 86E65C9830E;
 Thu, 24 Sep 2026 14:01:35 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 24 Sep 2026 16:01:29 +0200
Subject: [PATCH v2 01/11] dt-bindings: display: panel: s6e3ha8: Adjust to
 reflect the DDIC and panel used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-crosshatch-panel-v2-1-08d5c7bf72fc@ixit.cz>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
In-Reply-To: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=SZkNpsxVS531OAFU8Nu8uN6r2eb+ReEDrV3Xfp7rlS0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqtS08/0Ibx+l0MD7D3DFphX2S4KX3arhT8rBXB
 gZtcDJygcyJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarUtPAAKCRBgAj/E00kg
 csSUD/42gW8JST620vtaKHrsRapj7FtT6Ohl4snD6nlFzcA9pBHWzZcgeewV4KvWP3K6rbq6QO+
 Rqx2DO2lOSSSr6PTzoK7NcflkYPDy4ORZ88KDIJeHw3lVy+I14OhRP/t+mI0w1J0VzCG2YB2nh5
 mcPZS7JzT0rwe0UjV3idwMt7wIrg1TDWulKxMxMPcj6fEeug8nPMyZbghSiWydC6rsVFZrMLPYr
 zDVODBb6gejQNkgB1DP3YVQCnu8yP7GWbwRBEZ5w3sCOu/8w/43YwgX1rilR+KVYJwAgrX7WE6L
 TI4/RVArxJGf3C9c4YeADqp1g4fS9l68QxFhKf+NrfKuAQLAKKW+hu85ui2etZtOH/9ZWAWjYb/
 z4N9mDPqmwG9i82Nw8okAVNa9EC5qrS1XDHb3QP2TA3GRyyr0OtLEPd6yuC3dqeVmrCmO94s78D
 cj2YDG6hFxp3JPQ+H/vEDdMPUBQ02tl0bBYx7IKm7ytlLo+ka9gXAnDyPQLZ4HPZUhi1uVJUZTS
 CD34uWsCijPtk9phIUjbZPc86fvckdx22YteBwzAH+M7gi1h4fRQg84DrRrrO7G087cjOmUNHzX
 iNoyN3XwcJswsKAJdnpfITpUoPCabR6AFx5XCKCls3eUT+5QDX194vPYKGYDO1bsJJM549TDOcy
 6ULOreJz2AFlvmg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

S6E3HA8 is the DDIC, while the panel used on the Samsung Galaxy S9 is
the Samsung AMB577PX01. Introduce a compatible reflecting that, adjust
the example, and deprecate the DDIC-only samsung,s6e3ha8 compatible.

Update the polarity to better match newly introduced compatibles with
fixed logic.

Assisted-by: LLM
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/display/panel/samsung,s6e3ha8.yaml         | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
index 00ce5a4e1c6be..ca250b1b91712 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
@@ -1,28 +1,35 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/panel/samsung,s6e3ha8.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Samsung s6e3ha8 AMOLED DSI panel
 
-description: The s6e3ha8 is a 1440x2960 DPI display panel from Samsung Mobile
-  Displays (SMD).
+description: |
+  The s6e3ha8 is a display driver IC used in 1440x2960 AMOLED panels from
+  Samsung Mobile Displays (SMD).
+
+  Known panels:
+    - AMB577PX01, 5.77", Samsung Galaxy S9 (samsung,s6e3ha8-amb577px01)
 
 maintainers:
   - Dzmitry Sankouski <dsankouski@gmail.com>
 
 allOf:
   - $ref: panel-common.yaml#
 
 properties:
   compatible:
-    const: samsung,s6e3ha8
+    oneOf:
+      - const: samsung,s6e3ha8-amb577px01
+      - const: samsung,s6e3ha8
+        deprecated: true
 
   reg:
     maxItems: 1
 
   vdd3-supply:
     description: VDD regulator
 
   vci-supply:
@@ -44,23 +51,23 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
     dsi {
         #address-cells = <1>;
         #size-cells = <0>;
 
         panel@0 {
-            compatible = "samsung,s6e3ha8";
+            compatible = "samsung,s6e3ha8-amb577px01";
             reg = <0>;
             vci-supply = <&s2dos05_ldo4>;
             vddr-supply = <&s2dos05_buck1>;
             vdd3-supply = <&s2dos05_ldo1>;
             te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
-            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
             pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
             pinctrl-1 = <&sde_dsi_suspend &sde_te_active_sleep>;
             pinctrl-names = "default", "sleep";
 
             port {
                 panel_in: endpoint {
                     remote-endpoint = <&mdss_dsi0_out>;
                 };

-- 
2.55.0


