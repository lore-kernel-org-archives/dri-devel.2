Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F2606BACB
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI5eGf0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3B2112BB0;
	Fri, 27 Nov 2026 15:29:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31D2112B97
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:28:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00A8D6125D;
 Fri, 27 Nov 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795793320;
 b=ELKoXH9kH+oLjsiizRD0l6IxDMqGBEIZ/NKGyuLMG/W/L2oRkPAgxpRIypfAeDPoUMMo
 rpiLkue6qZMTgobAcW9o6Naahv0C/ag+pPI3lWXoO0JaMoBuVOxspFedmXZNEhmB+hY8g
 YaEi8Mc7DFSVkO6TKYVJWVXPFXbvFPZMdEZpYmh4sHfMhE8IBmk1BZBXV1sWhG/EiwnW+
 XTCjRMngeqtK/c7Cn3QQVmfU0WgDv5SqkpzRtJacJlv1rV9o0uQ7fz67jTj5cmxehFEzD
 MeCJFd4aQW8Yv4OMGaszRp/vMpOWZUwHHBPI084TXjXs522s3bNZSCvxg0MHZ1eiagQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795793320;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
 b=aI45tMkZ7+DHKhg/mwiVWhMRdt89nqSFEOfgPrtH8HMv5EwnM2Fw7PHrPGgu1rOqgS5F
 D3ur1DQDLIToiRD/pmwfdQj0UKSWNzhnE6i0eekpFIyzxhUjgpmGG8+pciZNBdGXfEKjD
 fXb+WoACX0lpSlu1zZJRG6vascAudWYvFDDI3R1IQw/L2NACLJCTWEjxPPfp5uM/79Lp/
 5d5QFrMgwChSLkoHT8Q+7Og2tYxYXOJ/Ct1kyiYEj30ZdJ21c2FqIbKA5xoN4G3zupJNW
 V8zLKa2bmjWGCVwp1PF+pMFgHvf6dRfPECS8A6sYu+zILbZ8Yrbxi2vfBfs9gUPO9Yw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id AAE6E1F0092C;
 Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795793320;
 bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=mI5eGf0VIBqnqZhDgL6I1wRGnjOqZO1OmfsAUE7DXCBRh1e32DacJAf5CizSLBOgz
 FbuAwc+1RTEZKi8mj7J3JZkQDTQI7BfiAPr0nxXrRBoRatKoEI3ygdesp+ren+XYaH
 lVw0a0+LTdK7yLj/MgQgk4j5QD57W5Vs3qSh/baJAIwWcW8qxQra/SDjCBn1KBLgyA
 us+OZViVrI3VypGq4SFwPYx+OtdbFgO4969uFhr7dCoPXCnxHsqURYWY9aDbmP0ite
 DQltFl3qmR7k6WaZ7E1FLygpOrllBAo2MwuAcMFgSlm1vyGJ/gyxRuZIZ3HtJLTufh
 EgxX/RZ19KAJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 32B694DC78;
 Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:04 +0100
Subject: [PATCH v5 03/12] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Add hdmi-phy child node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-3-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwp5X5e4pl5llJnnM593mGq97Z++U0LbI3cennxA78
 mbX4pgHHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEXj9mZLjjLx/B4hd6eLFt
 3blNcbNy+6Wabtr6mO5Wyl+ieVGrewMjw3yrIqvgnp2HC75UHXCb5mny+0VgxOPvMh6rooolrzf
 v5wcA
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


