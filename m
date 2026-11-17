Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC70606A332
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+KjjQjI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9191110F8E7;
	Tue, 17 Nov 2026 19:33:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A1610F8E8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:33:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6F6145708;
 Tue, 17 Nov 2026 19:33:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794944017;
 b=aFgMPKFMF8Mcc6VotGcSnCM0FE2+fP9xmqgvQ0gjIGQ0QcLS++krEuZV5UQlmo2vNYIG
 nZHD0phyJVb5dJDwqVeaml+gBp2WNCfnFG7Af3H9anVcU2S3qipzYuGftZD+XMhh/TIr2
 p2IbOGXkUY2NCRfkwGPWO+6t4Diu7GFCGqa6ghiKLksbJ2sY0n2NO6rSXoLTigMhN4vmz
 YZGm1WkZMnuiYl/0LpFP6pBtUoQfZFaq6ISJg+BUjTbNsVeqhBcB6sViaZrOEwBub19MS
 1p4XhtXD16Af9l1J7gaHvj/pX168ph8GKb0kXkuiD9ynY3UgRPv/BGQx/IK76GtWy1w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794944017;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=VMgSH84ZrrVptOxF94r333FgoxdgBqWsVgTsgWBrs2U=;
 b=Y2f45qDoGJdcD5meAWU6vUDy/8jM0thPj/ehijE1cwhRUP5rS/xWo64Y/8VteBon3xAl
 U0mkD+WaL4ZerWPXNaTwOpTcG9MNGNA+4NUrFOrphmpatGRyKE9i3aFhB6YETm50+nZ+J
 9oHpPU4lWTbm9zREU1vdbdEPelDZnV9s1rXL8asLSVq4v1nn3raMfPsefo2cY7tz/U94l
 48VjhhJgifQ3Oe5SR3K8LdKr9D3A7RJ8pUW5oRbA210Np9LPXzCpHzJKSIwANrW6eZ2xm
 viTtDvU2O4OsbEEye7niTfPYVHky3EtcTatXcdhj8LlZCbaxiWvJZ3gEInMppw032Jw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 18AE31F000CD;
 Tue, 17 Nov 2026 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944017;
 bh=VMgSH84ZrrVptOxF94r333FgoxdgBqWsVgTsgWBrs2U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=A+KjjQjILHj7SABlAPBJmUynPDQqpDWlFNu871jFdO+VkBIRMYB0+x7tTCbLbGuKs
 AwPoPcjuJ5hH7+2TIEddjko7rlllSKe7/jTD6ndw5XoPVp9Vy1snzfzYrhOn+zkftP
 fGbsKdlPQD8JzDStbQGsbGMcxbjQSMp6jO2VBh4XPvCX5B0/YPpNfBjAIJetqxu824
 IMtXzqFDLMRA1QQRA/tZAyHahY6pm/gc05efLkg8DNUSJZ4K4KbM1Z533MdDYVm/pn
 Fq56zT3lDDfzOuFm9iKzp+BIoaaSwchZp3ar9ZBaK7cLmFhsoVy3oRlOJrYdkaT4aY
 q0q6sXX32Jrdg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9EFD04AA96;
 Tue, 17 Nov 2026 19:33:34 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 17 Nov 2026 20:33:14 +0100
Subject: [PATCH 09/10] arm64: dts: amlogic: Add HDMI TX PHY node for GXBB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-meson-drm-create-hdmitx-phy-v1-9-9e0ac931381c@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=c/WWGT8CtU59I0+9U2adS9MjU7JCqDuzD/PZQedhJoY=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9afNZza67MOuBv5KbwRPnFV/iBXpKll6MTK+x/5xNaez
 LU0FNnfUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEyk1I6R4X+1q2bbreWVx+Oa
 v74rqnE4+v7dJgOjmw9nhlouneTyfzsjQ/fjGBvVzbsfbZwbXxXf65X9de587wzJuAUVVvem52v
 9ZAEA
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
the amlogic,meson-gxbb-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys" and "phy-names".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5c2fe9dc4f80..1dfd5f6d0f68 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -316,6 +316,8 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
+	phy-names = "hdmi";
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -330,6 +332,11 @@ clkc: clock-controller {
 		clocks = <&xtal>;
 		clock-names = "xtal";
 	};
+
+	hdmi_tx_phy: hdmi-phy {
+		compatible = "amlogic,meson-gxbb-hdmi-tx-phy";
+		#phy-cells = <0>;
+	};
 };
 
 &hwrng {

-- 
2.43.0


