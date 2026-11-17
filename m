Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729B606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IP591cyF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE9210F8D8;
	Tue, 17 Nov 2026 19:33:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41AD10F8D8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:33:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3858B4127A;
 Tue, 17 Nov 2026 19:33:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794944018;
 b=1DMj3gD7H+EyeI0gIQiBYTvj9sE+9WVwfBaFa36Z0OJriT9691m05hbXF08NCUedbyVl
 wlZOqqzhyIlXUWcJck9ARX+A8p/mkS4nQwWaWrbkSGW5bmpc4D4Lzz9QvGcnk0N0HXkOB
 xx795CS/4aw93wQjPslEmTGFO/uiLrv62g51dQgErI2mNG3K3kQyiHgEs4nJpgjQTnOaO
 ArxVxH98dO7FQfPh/635IBGs6JjTYJBAtYgkpTn6zZudI5KxV3wVEfVkprZvm1hF1aRbA
 9aTs0X+OhicAtIIc9khh+5xD8TPI4pUSwJ9sDT4soAV45iDeAkV1R4EfPGI4z8/ssdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794944018;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9E6Qh+eh9ez8UJ6KwETDodX7jVSD9hs5GmnEiLKTVaE=;
 b=Jkyfn/5u+fspK9B+Ue3zptJx9bnD9Jqt0wd7V0kUqLV9e68DJITA9T6wOWOTJ4p+5EC0
 FhPHMrsTcTRqwjU1jP14/W5V2Hyru0WWDGjifsKsN/wXHAuQUpQTnHIOrAQ5SMkRZ7zQ9
 DJA5hbbRrmmk1As0ckC3la2akh5BYmCtkqXSPYdj+8DRd+1rJPyeNdCYwWe2Ib5XItAww
 o75dWt2nPTbAKMQlt3jdLRVNs0TlBfgxwXxOIeFD2Q3yKEVyJyc/w+nWnFwHMEaugdz7S
 T9A6pUbg+FAYSj23N2+i0+z1wWSo/GQ77tWtL7o/vy8sjNBvxFNn2/P2z0s/3e9m/pg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1C06F1F000D3;
 Tue, 17 Nov 2026 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944018;
 bh=9E6Qh+eh9ez8UJ6KwETDodX7jVSD9hs5GmnEiLKTVaE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=IP591cyFUOQWwe+8F5rnEZ2lQ3/iJiiChSD5UGrKzMujkgoIr3IASqMIUNZZI7Uab
 Ub32gSq8nhnsPE99JkSp9e4xvyGtzvm2i3/xSdwW1yrGmeTIbD9AMtOkuOcX7t7bhz
 dxP7gnORozSiwrX7nqSqgbQWB5lTq6ZuDvZ62WrxJBRKkzcOde9T2BcMClcwW44Fqd
 mnqgajpmnhbN5L7STgh3/ehiFOSR+m4dDAYN4Q3Grl+d1u34Xz4bhBoal9VtN3OBq/
 fyF2qmnBDsekXiojrXhJ6EbTg5b5EE4iusiw8JXcmGCtCXZ+AE9I3u4DFM1LqPprsk
 sWoDvsxmJn8bA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B7A574AA9A;
 Tue, 17 Nov 2026 19:33:34 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 17 Nov 2026 20:33:15 +0100
Subject: [PATCH 10/10] arm64: dts: amlogic: Add HDMI TX PHY node for GXL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-meson-drm-create-hdmitx-phy-v1-10-9e0ac931381c@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=9hTxeugOjhcX9M0v6UHrUWRPvC2sPx1GRYk5SnrhvPE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9afNVxMTVGy8uvFMiu3blw+ZQvr6YK0yecT9v839H3z7
 NquBzesO0pZGMS4GGTFFFn651qeeHf56Jmve9RTYOawMoEMYeDiFICJBPszMjz6Vh5u2WH1piNs
 lrqOSkf6xGtBHJ4VGzbyM1b8Kw3fcJ+RYdsHZtHggOyjWbIG5vsna3ma1R+Z3R7y9Z/bqT/BWVL
 tLAA=
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
it from the HDMI TX node through "phys" and "phy-names".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index f257fe3860f7..77d4e6b5b850 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -328,6 +328,8 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
+	phy-names = "hdmi";
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -342,6 +344,11 @@ clkc: clock-controller {
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
2.43.0


