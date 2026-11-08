Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD7606D80C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iouYYt4y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E16410E4CB;
	Sun,  8 Nov 2026 12:32:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A834A10E4CB
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61D014475B;
 Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794141154;
 b=ilY64JAUB82ZQLnxYdWwBURHUPrUV/K+uMQOZEp3RAk8YDDFhdOAQ4Wdx8GZxYifi91L
 8eDTLE8eBPTewv7BI3SCYJ06wuxRL+iSDkldkGagifflUaSP+4LUN1UYWmDHgLBDGczP9
 1/DfdD82kZuGZSURhbNORBeArGOSz8i+klBAZ8ChcdzvPnhoodkLKINpAk13Y3GCyLewA
 FPIViRqX8qbQUGzdBxmOdGORsM/AlwkH56myaWhLYrLtpvST0Tsl09PWR6VnJVFHlsytu
 +Xor8N4nfy0I9vVi30a3IPKDOwwzHwIOrBb2wwY9Ux1dQ3I7UBf+A7M/NZ2ydmJi1GA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794141154;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=RztI6V2PThRIEHZuh9fdxJgBPEpj1vB8r2dlVTopDJ4=;
 b=2ZvvE5CfPHiDUH9GyHzEyf5Du4U0fD3hXlzGFLWRJARmi4uICT0UGsb/AKoLPdtnFm11
 1B/qIngZvjsX/bwEsW1Y0kATmIt36RMecIanZ1aEytXjcsOBRtaqi8gkqmqxAUYc0G425
 WbPtqfAJSQoF8HuPqZ4yAiQ2maMfLfJ4LATKD3NZszeI8uZtD/PJAEQ7Sik/KuvoIN9ba
 bdsrvh3G1KuKtv9Ves9PXkOK27sTZ8SHMSdc/snCRxW0mItRL1brth2lFJnzEss2NS+DF
 yADSvVKdQ3J3THKqkbpOPzRtirkzH2G9Q13jNCgU735HyWlkxlng+yXuXxq0ZR1WJQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BFC231F008A1;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141154;
 bh=RztI6V2PThRIEHZuh9fdxJgBPEpj1vB8r2dlVTopDJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=iouYYt4y4+GTgOr2OCo5RHhDLjAT/HNBcCjSqCn0IvGL7b0RZeL3Rhmgbh6clbsBZ
 a1sONNMNEWh0pe031VNYkE7PmTb0XJ2yJ6tXI91LJm8NsnqHn52DGu6DlPa/W3Tlsp
 eVmZjq2Wzakng5WUjIaZA4Ymh8jnsEoL3RmHRlGqxyDZpc27zkf2SHwhW42QroJDUL
 TgNqUL0sLRqcOwKIV26wF9QhTievqxYxlR6/ivtBUUhIIiak/MIY+GloPk4J9M8d+k
 EErDI8V5nLZQOli9TBfCLfTAb1L21jU4z2I/PQZQEvGzJrEpPR4zhb54qTCtvgj5nG
 a/l8NZbk7fWBQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4494647F69;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 08 Nov 2026 12:32:23 +0000
Subject: [PATCH v3 02/10] dt-bindings: display: panel: samsung,s6e3ha8: Add
 AMB630QY01 panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-crosshatch-panel-v3-2-87dd4ec4f7cc@ixit.cz>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
In-Reply-To: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pZ1ZmXYMSPnJNhdcyRsXwav3/Ps9JEOeKZPs9vUMmAY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq8GveYsFn4MOgQrLFx0dCv5N497ruFnJpbSIzr
 nMBWJw1ncqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCavBr3gAKCRBgAj/E00kg
 cud3D/9NnqzWe1/59sdRxpx6q+S/WSpsUSO/543/8NwT98l019Imrlzk+fmcmGvqKBc9k9f579J
 mShb9iBeXF9QIg7oRHm+ZjEX5TRUz9CAa7HrsCcLto0a1Gy2LUJZPN54qriSbdOKah3GRU+wdLN
 vVkg/+hYMzNy/CAuOYINJeuFGElcSAmiccPkz4Q5Wr9ftACSvOq+w3nKxEmAFspBoge+AOYaIRO
 ltAEDaU9TJAlWoHvPbY/5wyN0VREzZjk7p1pQ8H7jT01UMV/VUYdIwSsc0+tucglWs95tOI/bil
 CTm0m68+O2U9cXvF4dAAxCFH4Ynst8DHxeTFe5QX6aiqdxkcp2TdBtHz/1lFlNUz9GRd11XFRYY
 axVKhBR7HD233/h17dhkYQ5zOZmFiD6eRsEUrnQiMc8PJ52ajo4o9QqdCFh2CmlOVmPRXnKJyfT
 Wubgw8YJFtwXPBdOs6tEj2kzxF8Hq8ovLdIIMLr4cStXgitL5RH9eruK5GElAxHdKMAmSNsGeQ/
 CFpTjNUwrrKvHUg1WE9TjfdM2MQSSY6dDaEhUqqWWm17unBLlmU2Zd8ZvpfabCd/CVNpVytCP3r
 ewaloyOjWglTikrYJNaEpZYis7DhZJ/WgovsDInjDQXTxKUHkcCREJrTzHq9UexsYTLV7bZOFvb
 CLw1kFNtM2Vzbbg==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

The Google Pixel 3 XL (crosshatch) uses a Samsung AMB630QY01 6.3"
1440x2960 flexible AMOLED panel.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/display/panel/samsung,s6e3ha8.yaml    | 41 ++++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
index ca250b1b91712..dcf347fe5ca83 100644
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
 
+required:
+  - compatible
+  - reset-gpios
+  - vdd3-supply
+  - vci-supply
+
 allOf:
   - $ref: panel-common.yaml#
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
 
-required:
-  - compatible
-  - reset-gpios
-  - vdd3-supply
-  - vci-supply
-  - vddr-supply
+  vddpos-supply:
+    description: positive boost supply regulator (ELVDD)
+
+  vddneg-supply:
+    description: negative boost supply regulator (ELVSS)
 
 unevaluatedProperties: false
 
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
     dsi {

-- 
2.55.0


