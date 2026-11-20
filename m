Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8323606CD13
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TcSG3fWv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A78112A90;
	Fri, 20 Nov 2026 18:17:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A0310E247
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:16:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 047FC46265;
 Fri, 20 Nov 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795198607;
 b=HYtqyBU+tiqfuvUeMNZPlu72HII9yKZKSobb6oHHf9Pf+Giw6i8b9K08ckxSIayErl2A
 Ap4mhqJ0gVQVYJB+WQI2VbwC/hiqUoP9933OP8eRfG8OJ6L3mA85JE9ubRr1ZtYwVVWvS
 YwuNgXfs8kUhzPnfYJHNeV9jFoQPRN1jDhu23WIj/8LA+wBck+lGs+13LxriG0hwtvJiv
 oGpb4M8Uz8aBBeVW6C5xA5ELAW3fatay2dNBR0QIcVv4tv9t80Yg9x58669IIPEJDBArF
 /Vzu+XysUN6JFo3G3YSiUKijCeAqizm8rByB61QA4c+PjpN0ralBvRmVcByGPe2HOyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795198607;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
 b=e9UQ51e86nJmu1glB0rQjogfXgIPdPTceo5/9N4cQnu681GCjOWfsEtMREQnCSa1nVsc
 Jz/lokL91nixTSCRlb0MqNbQn49Ixm8fIQ4+DPFdPbnof6RLyX/F5oSByis41xK3QENCv
 D8XHADjf5e1k1i1ZGs3gKHh1B5nGZxbCcmFn1Ra4clQCrFA90/WyLSwURU3C2/p3zRZ5v
 v2oHpa+rZcQ1swwi7onQnYjfP+x2beZletME/Kwr4OcHJxUfwNIDl/smORv2vpBkueiCP
 eU4u7dEq996OPEbToUGMJHG/gZqMBk9LjVbOtFhsO5KAhjH3rgepcUDj3zJJjn6Fh9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 49BBB1F000D2;
 Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795198607;
 bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=TcSG3fWv9eKs5OrJ39i8eECUsaclUKlfmtyTwYCEG9tHowGxwoRnpkok38EWViCFh
 E4vX0f5tRx3edvwYZI5i6Cm8CZtzr8P4qekB5V5Q6fJCx3McfvNMrS9rSirmcKdWXK
 TWKeVh8fZgcae89QVLeuWFMVClF9S8QFVnwC67Kvf8Xsw5vbrzq+Adc3mPp6IHFcCG
 pzCUA3og4/IZN4Tez5QG4aSKg4yf4s2uhScfQOw1V/uPSdqnBBgrYOt/C3kQAR32c5
 Q1x94TqqcujIRpFeEseundFYs34v8x5l/ZEOfFY0Rn+T9kG6boQWDV+YNkvyhPhUYu
 7N0icRXi2tzrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C933D4B8F9;
 Fri, 20 Nov 2026 18:16:32 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:42 +0100
Subject: [PATCH v2 03/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Add hdmi-phy child node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-3-93d622d9bb07@aliel.fr>
References: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
In-Reply-To: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=GJIY+ibCECHLmuzGiUiB/LupTZ5nNvm+rMxqh5qXGxg=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX9r3oNMTzk6dxZ6s5nm67sLz9qaohc21Ampv2kqW+
 L4znS7cUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEzkfT8jQ1+twZaWO5onL685
 s9vT/1gWN4+uc9Uke8781A8s+hX7tjH8L2jqu9y74el9TRbN2B4Z9rWRxnoOqb7JsmnC7kUZvfm
 8AA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
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
Reply-To: linux-kernel-dev@aliel.fr
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The HDMI TX PHY found on Amlogic Meson SoCs is a child of the HHI
system controller.

Add an optional "hdmi-phy" child node referencing the
amlogic,meson-hdmi-tx-phy binding, and add it to the example.

The node is forbidden for the other system controller variants.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index 285edac4c082..97e47592aff2 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -36,6 +36,9 @@ properties:
   phy:
     type: object
 
+  hdmi-phy:
+    $ref: /schemas/phy/amlogic,meson-hdmi-tx-phy.yaml
+
 allOf:
   - if:
       properties:
@@ -50,6 +53,7 @@ allOf:
 
         pinctrl: false
         phy: false
+        hdmi-phy: false
 
   - if:
       properties:
@@ -80,6 +84,7 @@ allOf:
 
         power-controller: false
         phy: false
+        hdmi-phy: false
 
   - if:
       properties:
@@ -104,6 +109,7 @@ allOf:
           oneOf:
             - $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
             - $ref: /schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+        hdmi-phy: false
 
 required:
   - compatible
@@ -155,6 +161,11 @@ examples:
                 clocks = <&clk_vpu>, <&clk_vapb>;
                 clock-names = "vpu", "vapb";
             };
+
+            hdmi-phy {
+                compatible = "amlogic,meson-g12a-hdmi-tx-phy";
+                #phy-cells = <0>;
+            };
         };
     };
 

-- 
2.56.1


