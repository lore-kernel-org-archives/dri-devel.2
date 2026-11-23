Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C830606A33F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvOF7v5K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C911210EC78;
	Mon, 23 Nov 2026 19:38:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D991510EC70
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:38:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D22C41143;
 Mon, 23 Nov 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795462685;
 b=pibZ8y0oohBd1zCUOTTNwmdWyOVIaoimFh0swhKFmr5i/gpMI+dlO7DwGb68ylkbAwvS
 ckPFZLBQPK4rrfzTk3XxaFDhW109koA3bDq0mapGFCEEYw0L09C0ENsDHWcz8DBeAxCcr
 +lGeg3m4OzvkWrNBl8br/5S7hCe+5kaEStEv1+PPxvapgRpshq92webPaFCl3UaC0gU6v
 u+qzGL4yXAtwf3hLpqUo8IMmCaPso4lIoCrA+TyFqnCRlylpfAtoMHLoY2sHuCrbSd7/Y
 yJ1/lCr81E14AT+vKWrd1n8QB0ohFEFNH3dHmmgML25DRdMUR9D4dqWMpYRDaDF+7zQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795462685;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
 b=drNHsZDMYMKb8eGuPVh+b73Bwhrh9TUE2WHj1fhj0Ht3uazGilSZDodRjVPxXjUDKAbB
 c7qdskHAlotSkxC/OiJMHIcHg/bGFeoadwMyeNFYpuRX54RVYd2WS8vpwsX1ivOzHmhHz
 pFPiTUsYWfurCmGkK5/fX0Of0jHf4su4qTi6Z0RiLXpNykzb4pgzDQC/XsIDypNXOBNPv
 lRI/KNpGt+u4mGaT/CdSL++hPZXgVVDt3XXdjur0h4QCN22mmQP1AOP5RgNZfqTGm6gyr
 pu71H/2Kloj0KmEnHTkogas2w3xxZane7B7BMCUbMz1ebUOAp+u5B2iO98nnpdaWSKg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F3211F000E0;
 Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795462685;
 bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=nvOF7v5K28Nk6gDFlP1vOrDKmKUNi+/tPywjRqPht8gol+7sOAguD1ARWZYRaEfLc
 eHO4Zd6FzA/yl1dBIxpD0NRoMSDVKWtMt7IQjrVr1AbfSovmYcVHswzd+nHwLRk4rN
 6sXChLPmN8SYBeGBQVc52Aksf2aiHW8eg7Nlx3wMgjlEnen69Ekgy5Wu0BJiK/d0S/
 z743k7HZfdsHdHKK0nC9em0pt5xMIap6apjDHns2kpyFetbRq9wUNSOrFP6AcfRaWh
 SEAeB0yec/ZtHR84oknA8ElWGN/y6Qe1e4RMXLe/7zn+ZIB5XKcoQQf+0QZLN5/LVF
 j68znT2FC8bUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D60E14C691;
 Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:34 +0100
Subject: [PATCH v4 02/11] dt-bindings: phy: amlogic: document the Amlogic
 Meson HDMI TX PHY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-2-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=OW3BQ47jww+fAV5FJlCwW3Kume/yYrBTmUUehPnw4ZU=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNI7KCe1XNXqWXzV+0yNy7H7pgpC6/xOcpuYckKia2
 DC9teRPRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjAR4eeMDAsPqXUnewa+V5ZT
 lD/UfrH0Yd3Jp7sCzi1ibzn095Djch9Ghvlt+eG7ZXy03Kyl+llYlOvObfKZueWdSswc1Rb9t/M
 bGQE=
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

Add a YAML binding for the HDMI TX PHY found on Amlogic Meson SoCs.
It covers the GXBB, GXL and G12A variants, which are described by
their own compatible strings:

  - amlogic,meson-gxbb-hdmi-tx-phy
  - amlogic,meson-gxl-hdmi-tx-phy
  - amlogic,meson-g12a-hdmi-tx-phy

The PHY is a child of the HHI system controller.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/phy/amlogic,meson-hdmi-tx-phy.yaml    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-hdmi-tx-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-hdmi-tx-phy.yaml
new file mode 100644
index 000000000000..c5dd1036c375
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-hdmi-tx-phy.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/amlogic,meson-hdmi-tx-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic HDMI TX PHY
+
+maintainers:
+  - Ronald Claveau <linux-kernel-dev@aliel.fr>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-gxbb-hdmi-tx-phy
+      - amlogic,meson-gxl-hdmi-tx-phy
+      - amlogic,meson-g12a-hdmi-tx-phy
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi-phy {
+        compatible = "amlogic,meson-gxbb-hdmi-tx-phy";
+        #phy-cells = <0>;
+    };

-- 
2.56.1


