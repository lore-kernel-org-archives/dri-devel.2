Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C971606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHTFUY/w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1882010F8E9;
	Tue, 17 Nov 2026 19:34:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C3ED10F8E6
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:33:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC95D61385;
 Tue, 17 Nov 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794944016;
 b=ddhWTt7uMdJBcBZtIe9QTwXhAxlRpbkmrPIKYyygjDhNTXtdLB2BwK2y8K1PTed+dCEj
 MJX3IZA0wQfEUxbPeUNZ+C5nM6N8xcGpXB1XBeJggI+FPGH8Fe8OgJs/QQOt9VJr2qX1x
 3425UMrxXaAk57qxgbsJhS89+iSAUYAortuI7YJkBwZSXlHH60irlIEvRMmwmFPnQ3D4E
 zuvrFgG5VAPPV12hsUCJYi8lh8/FirM6kOjE+k8ZXmAKtDRrF9TS2DdA1Yjw8UjFkFjEB
 oMzWVuE3UpYFIXVZ1QMtNz5f97DoXgt6RiyK5jsGEf0vnalQ2xEtxKSDfePPk2GKm/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794944016;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=0lmlDgvUOnBJGIVdXwJlNnPdRlqX5EThWqZ6+ixVKOo=;
 b=QjhMD92onXhcH/O4Yd3vMs7BKZUZkgYrWv1UbFSMmzY+eL44+aMTl1FZFQsTcWk1RoB+
 Cd9G8zcVIvuS1DspVMhaztfVhAfbvredu16TTvmT4GsGWfJe65S99UsLnZ9lsXVS5z2es
 SP4/XlEfdEt9+4G+c3U+/fs9ckFjllKGfCQwEbtPdF9dR5sIZ+wWTCvYO+mAKSQo+6JLQ
 f3c704rVPU1p4B2y3oF6hxaxnRX4pVZytICxNoiqhgLTqDN55cBmWwYJl5oCwYA6vsoJZ
 DSurvwAO7iPB/W82YyuEDrCe3UFplr5JqRQ7l3jFw7k8x7up2wScqHCHziQwtwATQZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 739891F000C7;
 Tue, 17 Nov 2026 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944016;
 bh=0lmlDgvUOnBJGIVdXwJlNnPdRlqX5EThWqZ6+ixVKOo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=SHTFUY/w0NENGkOQac67SEB8U8gzsgfIfMyMb+o10R3y/35lyIR8VSCnDvPylYkzC
 1yE1GMt/lskuSJi2zv/kPPy0uhmRzsvmB1k3q90MuFAXuCgK7GZjT6D7hxXNt/3Ok7
 niYOy4EY0zr/EeVpV3+QBgx7FvvvjJoo+4uY+Bs25H+13SqxU7/DaTVA+XtHjBhFg/
 pk4mqZRG78oU8Hv/3Ns2V1ujKQpeU41bkyjRahL1p0/WKlJEGR96+Rm/ZJgxXiPG7B
 OrVizuMj6Pw7tA/QvslCp9CbkC1JstigzWaFLe03zviIgTSIMdW8AFhhz/Ou9QOddF
 hRItpJrsthmHw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3BD004AA86;
 Tue, 17 Nov 2026 19:33:34 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 17 Nov 2026 20:33:10 +0100
Subject: [PATCH 05/10] dt-bindings: display: amlogic,meson-dw-hdmi: Add
 phys and phy-names
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-meson-drm-create-hdmitx-phy-v1-5-9e0ac931381c@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=jqEV7bQQEFsIXokZ99mRRwITRZWlx+h1w+wA2P0yqeI=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9afNczFJknas9cVVJs6/PSe1n0zk2F2/gT9DWfPBf9r+
 vrH8LxkRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjAR6RaG/4Wy3f8mhyW+CTpk
 +JZZ6mNR98/WjqPlMaw73ufXa+974cfIMO3t1SNneCy1I+/sO/vVPOwEu9Z1vRXO3+oulvpYWW2
 pYwIA
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

The HDMI TX PHY now has its own binding and driver. Describe the link
between the HDMI TX controller and its PHY with a "phys" property
holding a single phandle, named "hdmi" through "phy-names", and update
the example accordingly.

The properties are optional so that existing DT, which do not describe
the PHY, keep validating; the driver falls back to creating the PHY
itself in that case.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
index 416fe263ac92..5a033fec21b0 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -108,6 +108,12 @@ properties:
 
   sound-name-prefix: true
 
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: hdmi
+
 required:
   - compatible
   - reg
@@ -136,6 +142,8 @@ examples:
         power-domains = <&pd_vpu>;
         #address-cells = <1>;
         #size-cells = <0>;
+        phys = <&hdmi_tx_phy>;
+        phy-names = "hdmi";
 
         /* VPU VENC Input */
         hdmi_tx_venc_port: port@0 {

-- 
2.43.0


