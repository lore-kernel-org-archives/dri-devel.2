Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873F606BD97
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sk/TKsda
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6257D10F8ED;
	Tue, 17 Nov 2026 19:33:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D453810F8DB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:33:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCC3944689;
 Tue, 17 Nov 2026 19:33:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794944015;
 b=wN6rrQR6HaktyrJEmMQ6hUHAntRRo/Cb3ETIAohpwFTj0gesaKg3lpueKxQ30pw3tVpB
 5Bmyv7N0rWjHZJd//XvCGoVggo31osawVm0wCzzJU2EMUwTktW67KUqGrEcoW6rXCko7o
 B7ziw/hioXgUx7y8De6vLwI/PMU6fKEDSuTlgngje296U0lTDaZhzRv/1qsvjKFJ5WdMz
 3n88rchP4koOs2i1iYazMEDF3PI7MNhQRBvNJt/zGzJKGAMH6Do3PoYDT3UuahloWJphU
 7aHKAgos4/kFDAakMRD5u2Ie0ywgE+Y9JaURh9TzerMzaIbQalGzpij+hiyPSFgN/XA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794944015;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=wgP5+Qx5rmwplX6BT2iwRcVVB1V/mtirnLRhe/EU9Zo=;
 b=r5g8SLaEswvDQ+zQGB3XPeqEDO0Ch1+WqxmuT2YHWc1OZLWQ97eKUfoNltM44HS4o16E
 qBoI/ys7yk/1IoDFbNRxtHeQuTpyahiIljeaDCdQl0VxC03dp7J+enycmjj28FkkOTJy9
 /ieK4wGYrbQqIDeMQubA3RLOp/NNmaDNeMhvrU1KG3MvTe/VRHcIOWq7fZ/TLvsGvOCxZ
 nSXRK/7HA5SHGTt0J6bnQiopNithJ22etCmTWTvBhCiSeVAIMjxSA32Yhg7au/PBha2E5
 Kdb3sKgmnH/6BjzzJ6idKh0ootzc9eJLfHt75Egs6fj3CX6rYmAcU3nkFagyKl3H0ww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 69B391F000C6;
 Tue, 17 Nov 2026 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944015;
 bh=wgP5+Qx5rmwplX6BT2iwRcVVB1V/mtirnLRhe/EU9Zo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Sk/TKsdacaUOxsryjBPhje1pTCmTfnhb8m4m6Z9dm0m0an1ihAFWCygax/CGm8uLs
 3XMjfiuaRDFY637XeDlQW+KbyDc31mLOxo5RrkX9UsP86I6ejNF7wfmSN3XieoZ0T+
 NIn/m4/KMFaB5xHN9WGycuVowYSnZaamRtv+G0FD02lw1RZZFPenm4V6Qmc68tbDpw
 NER8yD/rq+8gLJZzdLkh7GNaBG3wjbsZvfjvX4KkO/xOZR/VXDXLk+jLTVrJ5RGPtN
 LgWBMiYAyvGRSmeYIpWQ5HIPIIhzgqpFK/EOvEs2hJp0tyYgf5DfQWeXAPPhw//+xB
 4zAzmIztqd9gw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E63D24AA7A;
 Tue, 17 Nov 2026 19:33:33 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 17 Nov 2026 20:33:07 +0100
Subject: [PATCH 02/10] dt-bindings: phy: amlogic: Add Meson HDMI TX PHY binding
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-meson-drm-create-hdmitx-phy-v1-2-9e0ac931381c@aliel.fr>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
In-Reply-To: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=FyF1q04tK6KEaOg7o7mLug+81YUfOqkErLhIZjBmTp0=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9af1f+cXr6uCDbh3DB9a4GK6ZJ9jEEGt1YvUCoJYDk/O
 V16l7VDRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjARpyqGf0qtDd+2mPywfzit
 /X6Wv5PL5ZMrevkfrBXdvkrmSKTgryOMDK+2aW3rd+ffqa98YMo1mcDKY4HMrqrrlASOMnqus7i
 VxQIA
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
2.43.0


