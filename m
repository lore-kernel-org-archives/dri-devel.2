Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A154606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB44dvrL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF8C10FEC6;
	Wed, 25 Nov 2026 18:13:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6159610FE3A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:13:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47AD5464E1;
 Wed, 25 Nov 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795630380;
 b=HYdia2bkcGDCIpUd6lMHkMfZSWah3IwQwSrKiNmTXe0OTEfYQG1Zb+ibXaivlJmUyEpM
 nZf43MNQm8ieYUmsN+Lx8lIPaJKoBx85XnELajkAjjMvW0NQyIZzkutJIPNN7kKY3gPfH
 RunNLqLOONC48mcL/B3gyLnnJLjq+/xTS2qAwllZW/BKIIrC2phdt4jIYiiq2XGXzsVny
 xa3U2QcjAqPoqBMKroO2tvGk6PTUS8S7WV75p3+IXx5BIFzCFAdFRbA1LoOtvfIBBxizo
 KZFG69JGFgnQKk0rFKw6v7wZXvUbN/+VsrcciTrrONWUbzmcKytjbCJ7uFoauxnxuNg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795630380;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=2n4HxTFhz6E70+u5ysOSpoSE+PSdb6jJpPyn3zqvxOU=;
 b=RsnC37enXJxDoCGPgtaRitRMFjASnwayA4fDMDUoYy9jAig2OQAQNqutjT+7tIgHR876
 1dFDQeMErvH0PBQicR/pnKeTYsqZ0yXEuLwe5w8ZJ7m1CggM9hZ1xcAaU+2Tevg2DBR1E
 lWpDEo0vfoseVQ3XZptnbW/MGn+shc7wGsdekezyh3NlkRA3nOhofl0ZYBPY07jMMmK16
 y9L4hqZT8KT6nvsm49DY4OsP2Unwda5u7sfxIijKno5nKTam0+lUUSzAbq7WC9KkuKnxq
 Z/0gKxDkoLiQbGHy+zwCKN3GAbl5BFU2HrpyiNxzn9m3mqx3pa3RbmCT4mclube1Ihg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 10BC91F000CF;
 Wed, 25 Nov 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630380;
 bh=2n4HxTFhz6E70+u5ysOSpoSE+PSdb6jJpPyn3zqvxOU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=VB44dvrLQP9ViIPAo2azv2InYNyfmBSE8ct8/u0dpZiZTidkO5oFlythts1RQZbyf
 urr7yS8rJ90C2V9yzDjnVU6VzgL3ulOK/ryz/rmH/jHmES+nOnDzNH0LJL8sJhJdPT
 IwK0jgI4iTVCgmO9dxthwaK/V1GA8VzUIqjotmvlxV6AZ6gMCepLCC5QbchrBQ1DQF
 gTV69mkibioqatPa5keWBuy+IeVYq2GEuNhjnMDw9acV/Yiaqmici8PErKKocMgaQ0
 VrRV4auqcby5G0JI+Ip/ND4ikvSv/0bdP9iB58GRvSGtT+DN3ASCEWID8Dl2G3Jemj
 x+xkoY2cA898w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 91C2A4CFA4;
 Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 19:12:46 +0100
Subject: [PATCH v4 2/9] dt-bindings: display: panel: s6e3ha8: Add
 AMB630QY01 panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-crosshatch-panel-v4-2-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
In-Reply-To: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=mC8AWb9/wpYUNjQLE+eLink1Uhfk70DQlwnA9VEtlKc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrByUejL8AtgBYzPVdIcvPj5T6tFrZfzE7x+RoM
 sRRyksk90GJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawclHgAKCRBgAj/E00kg
 ctfQD/90e/k3ENh7szg3P0M33+nPf8hHTEHVPf2DbroDtR9HdOAjEabP3MvL68Jlv7hXMRJkr9A
 NE5pizhQnTXo94A/G6jcegBVYIgsPrnnxNcNUDR7q/fdzh0qBeCMYa0lvoOJglbJIsKFXY5sBu/
 fDnD+EUAn/EXYi50bmnldcvZPGzhiByY6ck36pXfNkN4cWG0nezzDMMfLCnToaJGltQNHt53m+u
 8sRUD1W02vn+j1+j+et9QcWNcY0ixP3fpnr23RNSGH4QW7TGoMztEA3PU5IiOzJ+JsQ5CTnlcEd
 Ystd990v/3mp8wDiO6W4HnfD+Q1i9RmXe4mn0ZuuUTCzojrpjkJ6oZ3+NEuUxOUS1t4dOUoUTSU
 mWdQZpARBjK0icMvPziukP3J4Tjewu53rgT3K0KgZGD42TNppbnoqfzYNOFosVMDPrnoWxvX2Hn
 hSOtMT/T27ZHpyDGGEo6rciv5n7fiDBuqW7nHyK51ALHppKhLR44QMZLdOiUT4fePV5YSwvoFE1
 k3fU8qQNGA0DPuetbtRKE8o0PrMmr6X7Ge0rRnG7O72vb4nr93vqaRh+CFDgjWCwnWe6FX/56D4
 hNr7+8IwDFiGbK4LJO6WXHG7Mo3AlmGNx/OUsEEPZSf6pe+M7zBYU39WbvUhEfKokK2RcjTmOlB
 liVQYombNOJfVqw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

The Google Pixel 3 XL uses a Samsung AMB630QY01 6.3" 1440x2960 flexible
AMOLED panel with direct ELVDD/ELVSS supplies.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/display/panel/samsung,s6e3ha8.yaml    | 37 +++++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
index ca250b1b91712..db7ebda59c13c 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
@@ -7,48 +7,75 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung s6e3ha8 AMOLED DSI panel
 
 description: |
   The s6e3ha8 is a display driver IC used in 1440x2960 AMOLED panels from
   Samsung Mobile Displays (SMD).
 
   Known panels:
     - AMB577PX01, 5.77", Samsung Galaxy S9 (samsung,s6e3ha8-amb577px01)
+    - AMB630QY01, 6.3", Google Pixel 3 XL (samsung,s6e3ha8-amb630qy01)
 
 maintainers:
   - Dzmitry Sankouski <dsankouski@gmail.com>
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
   compatible:
     oneOf:
-      - const: samsung,s6e3ha8-amb577px01
+      - enum:
+          - samsung,s6e3ha8-amb577px01
+          - samsung,s6e3ha8-amb630qy01
       - const: samsung,s6e3ha8
         deprecated: true
 
   reg:
     maxItems: 1
 
   vdd3-supply:
     description: VDD regulator
 
   vci-supply:
     description: VCI regulator
 
   vddr-supply:
     description: VDDR regulator
 
+  vddpos-supply:
+    description: positive boost supply regulator (ELVDD)
+
+  vddneg-supply:
+    description: negative boost supply regulator (ELVSS)
+
 required:
   - compatible
   - reset-gpios
   - vdd3-supply
   - vci-supply
-  - vddr-supply
+
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s6e3ha8
+              - samsung,s6e3ha8-amb577px01
+    then:
+      required:
+        - vddr-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s6e3ha8-amb630qy01
+    then:
+      required:
+        - vddpos-supply
+        - vddneg-supply
 
 unevaluatedProperties: false
 
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
     dsi {

-- 
2.55.0


