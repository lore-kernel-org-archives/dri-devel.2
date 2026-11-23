Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455060A2614
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+rd1ThK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B52710EC9C;
	Mon, 23 Nov 2026 19:38:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58D810F191
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:38:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 490E96247C;
 Mon, 23 Nov 2026 19:38:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795462702;
 b=h0a2NrpOuE7oQkBNdNDmYWtldGcSPGNw5qK2AIwQ6r3Q/cFOMFtpUeQ5fkmncHl9TviZ
 uuAEMHlkvr3g98Bs6J6znvT4jKGbC302rlnEqhH6AG+2uVgi/UeRWiCnYdhSVovinGMBV
 cekVcti5vGcXlYeuurVBruqk4vh6+8m9APzDFnn2pgCM5T6sbhjRaJctPUcSQ864v1epc
 /gy1eHkRxkIDSZ23Lzp9uLO4Od2gn64Zyg3c50FVD1epJu/MWeiy48mlA1yEaaOWpDV5F
 jvPiFfCU3I58LDOSVKV7vGAfUi9m26npZX+VretJgOeFVvb4YrjddVKdkKFfBgViHbg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795462702;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
 b=ivDE/YGd1TFz4hSg0/U9dlonbrg+MPir8PxruhAQlf9bypdQLZQpI2EtVdw1/A1XLM4R
 Qo0ffP8UHUrvuwREghAKXqGAnE4sJYEU98WOnyLcrEkC3ifXk1HxNGJIpacdo64uNw+pp
 EhZDWda6/EMIfjX45FIO4OBn5XLs4P7dtd8op5uTrsY4bfCIdzk5Il0bjPpZmybvy26yJ
 1kw07nLOX4Gh/GY64CXU3u4oYrEmrn8yASgj5b7+1KiXpPfBy+cXnN20e4Wk74HA89NJY
 VDDO4peT2ywFrssykQAKiabp0HuApUBOVz8sgM4yGcLHVCzNc3Ue7kxHYVKTkLaoiwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D2D7E1F01567;
 Mon, 23 Nov 2026 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795462702;
 bh=3ySlJUTZg8+yNINn5sfi2SIyHBWA5zVWlGALJ4M1cgM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=b+rd1ThKgoubiqbjN2AE0h/qmGr/RCOybwbPeDCX65Eia0XqmsedjdwGmRUzas1vT
 eJYgQe3jgx4o+Rjbfs/LtXL49smq2yCbT2fBQ1vOK9DbAyElUbIU4WW966H+QTl3x1
 tAfmiuVc6fZtmwcWhZlJq+yIUPDwF1CVsh1+mxijDYtaCGjShSZKPpy6NgW33zvgu3
 K0mNAe46NlfgJ3YsEK5gyOJeEkzcFKXacHndBLsboTeQSCPn8b8fmEaPU+jp7dmieP
 GEDr2kG0uQpBk+OPlD25wFBoMdy8t/SkoIYHJ9Dhq8qJ6w1IbcVCeVihRTO1graf3a
 RBDJSP/QFOQvA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DEC534C6B5;
 Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:43 +0100
Subject: [PATCH v4 11/11] arm64: dts: amlogic: Add HDMI TX PHY node for GXL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-11-3fb94f5534ca@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=JP7lAwalWZ4HUjkBJydQfX0hMiglUBnijIXqwFKtcOI=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNLFph2LDl/9l8+XbE7wszkmsSG6amugpG7Htm77/s
 bBeYF/aUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAExkzhmG/2Wtkr9SuPazzffh
 fODmu9nMneeJEdMlY8n4htwXsuJrNRkZltnc1djpVuwbr/XEXmOT4/7FLlnfQg1Kg3cXfN69UF2
 GGQA=
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
the amlogic,meson-gxl-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index f257fe3860f7..d205eec1cff7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -328,6 +328,7 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -342,6 +343,11 @@ clkc: clock-controller {
 		clocks = <&xtal>;
 		clock-names = "xtal";
 	};
+
+	hdmi_tx_phy: hdmi-phy {
+		compatible = "amlogic,meson-gxl-hdmi-tx-phy";
+		#phy-cells = <0>;
+	};
 };
 
 &hwrng {

-- 
2.56.1


