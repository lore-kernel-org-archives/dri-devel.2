Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BA5C44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB9510E782;
	Mon, 20 Jul 2026 07:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="fIA0Q6bF";
	dkim-atps=neutral
Received: from th8-a.mail-neoserv.si (th8-a.mail-neoserv.si [152.89.234.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E1D10E2DC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:52:50 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=e4wr1RIKGAKwFb7CvuoGhMJksMeo2X6/du0d44Wq3M86JsufEJ01y5xkiTjZ+cmiJQgGjB4QO1
 1TbbpN3L7Tbdqym2X2awQ3EQrGWIZxh+U7wwbBTSvimGkQoC94d8eVA0DqAAuQwkHOGcVrBL1K
 cvOVaE3NHoR2kaR6CNmVirZJOTTPwbNg5l+SUhhXWkyW6jcDkmqj4hvmkTTPb8Q168+VBdnHDD
 qUfOr85z7MBLDvI1+BxnohyGqqboNAJ/q0ZT56ka3y01nF1t1xbQb+YTfVR/wKt20NhYNGk4eu
 93Bc+VOsl1zz7+CgS36w/ayT2Wxm0DdaKVHPHxpa8WO1Mg==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=7o4gkyWUm5NRKXjCtq4QFPNOZqVGYX0NqrC25z6iTAQ=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=Fzw+J56PO1j78a7aA8LdOOs2v7ZvPZR2V0ma8jd8Fbjf1F4mmLuzSMOee751na36an2fjPpJUU
 fk2RIDactnsZRThjMxmp8+ywjglcpvcpiuNNhWzzKR0lgcgyf/VwUfIvEDypMa1c3v978ZQBnv
 XCVrhObnvq+dGtiQx8kRIuAKOVZ4sKvSSv9uXbjQNRDNyS7JXVmZuomzxAAwbPpdGsRgEQCKxK
 h8wpZWA9kkM8n3W937gUXg6wXD3EuDI8hmZ3S5ZgeoZ1GhhFcHCU231b14VB7cXniltvAVT9tX
 GfA/xaXrxsxBDIxy2H+BpC+eQ1S00NkzIUVoai08+TNkQA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rhqQocmDn1ZVyttVBuCGSQaZNCEQDuZfGNQteeSIaWI=; b=fIA0Q6bFjuSYbA8c5wvLsqNuEU
 ggOi2blAwuHhpFw5QDqdoC7VaajtNA6OqXiB4DDkd6VqvIFZ82T6FeP1AmsfDCwBg+V4sCgmAaK0j
 mvKvRAb4MC0TfDp0rHyX0gT+oNHSz4wOR1JTC2X56T6Ujq0nOhbKYGcPbc8Ex7rLO2SgxCB7InYz9
 pv7Jx+WQnhQCsp/R/zBZLR5p+QMoxaO/pq/mxIXly9dkbJxdLKifLeauNPUtrCQj65oEcdoepCivc
 A+XaKBFNTpTc+OY+W5lwplzzMva2JT4/QMHQfm23NvsutXeftWWiazEqOTejZMth+aQty/7uoDHtg
 p4kD/n0Q==;
Received: from [193.77.36.193] (port=54788 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wkhHh-00000001fP1-22Ww; Fri, 17 Jul 2026 14:03:17 +0200
From: Rok Markovic <rok@kanardia.eu>
To: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alibek Omarov <a1ba.omarov@gmail.com>,
 Rok Markovic <rok@kanardia.eu>
Subject: [PATCH 4/4] arm64: dts: rockchip: rk356x: add LVDS node
Date: Fri, 17 Jul 2026 14:00:05 +0200
Message-ID: <20260717120005.2087386-5-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717120005.2087386-1-rok@kanardia.eu>
References: <20260717120005.2087386-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wkhHh-00000001fP1-22Ww
X-NEOSERV-MailScanner: Found to be clean
X-NEOSERV-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=1.31, required 7, ALL_TRUSTED -1.00, BAYES_50 0.80,
 KAM_DMARC_QUARANTINE 1.50, KAM_DMARC_STATUS 0.01)
X-NEOSERV-MailScanner-SpamScore: s
X-NEOSERV-MailScanner-From: rok@kanardia.eu
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - th8.neoserv.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kanardia.eu
X-Get-Message-Sender-Via: th8.neoserv.si: authenticated_id: rok@kanardia.eu
X-Authenticated-Sender: th8.neoserv.si: rok@kanardia.eu
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add the LVDS transmitter node. It has no register block of its own -
it is programmed through the GRF and borrows the MIPI DSI0 D-PHY - so
it carries no reg, only the DSITX_0 pclk, the phy and the VO power
domain.

Disabled by default; boards that route LVDS enable it along with
dsi_dphy0 and wire lvds_in to a VOP2 video port.

Signed-off-by: Rok Markovic <rok@kanardia.eu>
Assisted-by: Claude:claude-opus-4-8
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b..9244b55 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -878,6 +878,31 @@
 		};
 	};
 
+	lvds: lvds {
+		compatible = "rockchip,rk3568-lvds";
+		clocks = <&cru PCLK_DSITX_0>;
+		clock-names = "pclk_lvds";
+		phys = <&dsi_dphy0>;
+		phy-names = "dphy";
+		power-domains = <&power RK3568_PD_VO>;
+		rockchip,grf = <&grf>;
+		rockchip,output = "lvds";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lvds_in: port@0 {
+				reg = <0>;
+			};
+
+			lvds_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	qos_gpu: qos@fe128000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe128000 0x0 0x20>;
-- 
2.43.0

