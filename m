Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24272606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRmq79FJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3BA10F8E3;
	Tue, 17 Nov 2026 19:33:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1330710F8E3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:33:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEF7A43B5C;
 Tue, 17 Nov 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794944016;
 b=Ik0ZVJZIHLnV3ERSxySVsxhO1fVh1H/WdYRGfbvX8yrP1hZVKcuCYdbx0qaH9t/qsmml
 urcfHtnL7HrcmmrR+a6lFIRrm94ijxSsGFDS81GWU5p8JZA6FqxLWJqB/RDzns8WXgSyJ
 M/OFzi7lz295Q0xJsWU60e4cutPtktGki55DGFwFreafal/q+Gt6NZxsrO+n2xvw6Ra6T
 I6bXNjxFs0KMc0FUJ8qehK78sU0QUBotprrkrzYPS/ns3Q/OInbcO+NF6uUBHajWEvsg4
 xldg6boCJzXNfC+axrOVf7ZFFbn1UkQe7y5p4TzC40tBZfOg9SX2YEiaPZyU0RKGxYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794944016;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=MOO9XddMlUhs1P7+vLnGg3uK6LFJsgNZmkbrJDDfKLE=;
 b=IvF1QrWK6NCE98RR4HVAxnHi6ugEl1n8WyKj/l6jvyP23CDj6kLlYLYElwC/xcJID5+H
 urrh8FZFrOLn/60hutYOfoL3+rbtI5IVNPKmnwuuWbvQkFjYQm5LR64MfqLl+eko4czD3
 1RhJNgaEWS2QkFR5C4pZvND0QH62YVzzD0SMyYyUWeJknZBQt/QNjixFqiC9IseqZmrpG
 0PosTQIig0x8zyi47uv7WS1zAb9uWzibGj8bfzJ8ntmp8jO1aeBFpwMARAh/i8e1yRVp+
 +JYvUtwRGl0Oe1rm8zDrXhMeij/wNF1ZK/+eaLxC7wBmVzP3pXrC6NXUXi28P16sqWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9171D1F000CB;
 Tue, 17 Nov 2026 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944016;
 bh=MOO9XddMlUhs1P7+vLnGg3uK6LFJsgNZmkbrJDDfKLE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=KRmq79FJlbFBXFmEkNFjD0MZ9AfphKawLtxe3M6js8RfFNva37w5RMfENaFxE2nlR
 hNhdv5XnOIz+Ktts0E3VF152t4xQ15tfSNAwRLqBJTQumstL1HtKrCvgtYdy7vM//T
 0+IlGaQZIbS/WhZee23fOnEDP7IquJfcDT21tfWfPKxrRT/42J1s6JAg6kPQqTiXxb
 CSnH0XAiG9Qvi6Nok/EO15nlh4zfkpqHuBvTGD1gf2LsdyMXk/ZEIFFic5eELzv/Mq
 AMgVt0B+MOyQ2rHIZ03jwrokTrPriYtW1b1BMyHUUqZFdIZO+8oE8S6xRpzFfH7E33
 JTrZDDOju8S5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 862C84AA92;
 Tue, 17 Nov 2026 19:33:34 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 17 Nov 2026 20:33:13 +0100
Subject: [PATCH 08/10] arm64: dts: amlogic: Add HDMI TX PHY node for G12
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-meson-drm-create-hdmitx-phy-v1-8-9e0ac931381c@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=DN6+qVZe39LfbdxFVS/K+gjNh9NYWRH/ygbrMtxxoz4=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9afNez7XT7XR3kcn6/0MoJxnmdZsZd6wJmwGbNYn+8wP
 hV/b+qnjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiRwoYGVYfC/wVzRLbuMn2
 1lyXs60v9EpqKj5v5OR/05ZaYHd/RgbDX6lZ0lZsvHlFG1RXsP23Uj/1wdyvQ5Cp22APY4i9lHY
 QBwA=
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

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-g12a-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys" and "phy-names".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3135566df880..17d80b8139d6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -210,6 +210,8 @@ hdmi_tx: hdmi-tx@0 {
 					 <&clkc CLKID_HTX_PCLK>,
 					 <&clkc CLKID_VPU_INTR>;
 				clock-names = "isfr", "iahb", "venci";
+				phys = <&hdmi_tx_phy>;
+				phy-names = "hdmi";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#sound-dai-cells = <0>;
@@ -1683,6 +1685,11 @@ mipi_analog_dphy: phy {
 						#phy-cells = <0>;
 						status = "disabled";
 					};
+
+					hdmi_tx_phy: hdmi-phy {
+						compatible = "amlogic,meson-g12a-hdmi-tx-phy";
+						#phy-cells = <0>;
+					};
 				};
 			};
 

-- 
2.43.0


