Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38B7C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DAF10F333;
	Fri, 24 Jul 2026 08:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="MPU/7Yyk";
	dkim-atps=neutral
Received: from th8-b.mail-neoserv.si (th8-b.mail-neoserv.si [152.89.234.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247F810F333
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:08:38 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=bLhSBkBjUBQXXbMfW/sgpCpyLu7i9NuI1bLPbTkp31vOckzawBPQPANyjx2z+ROJo5JolXIqw5
 M4GBBYoiojIW/IH1gDrjeQYgozfQb+hpHtsxzo+grvv18QvLhJkXTrtnQ3c13uIOGOtPeGUKNQ
 kP0vrzomT3W4C+A1bRKuORe6qhSk6g/VNgSaLRkIB0tITGhVAxbtdc08Cv/ED+4T/o6a3GKyrU
 19+lDtLVnfC4gudJKMj8CcaBtN7aMsMKJXXpTG1DjotYw6WaRK4Yx/ptmtB3CvzL1OtZgTZvlM
 sK+GwNPIVWSSKGBpIR/tniV/yhNzHl1Ww9do1kozIyay6A==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=ZQ8Cmsj05infuNySaUQsheykvJcBzOdHA0m2LcyiQLU=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=NGcBpE/eOko0hyGFeEQbjGJnyfltluMVxiGQsALhk+IBx05VUeykRxRWB3MAnFVHlsAmoL+nTe
 yTonr5SBJOa4kfNWW3UgQ7G25ZxbDfLrEyfA1r7XrffkXX7PQfk8YGoYTMkNI41llc34E49RjO
 5YPzG+5MtipfpW/yCAoxGr+bfDQJ87Oj+Km+sUCaaadn7swwPHJcDQlJYuo5GCvBJD+lfvofIz
 aMG8uSe+NsRLHqGHUtYw4LY8wgMzVtlcYz1XpmFYgi/1+NEj04G9cCrqUDpsg9XR8hdmHH58Jz
 ts5BlQj+H/yveu0lteON8SCZcgccEOAQBgms3hmJ+Foh/g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cm++ZQgvrV2LU/2T+Ex0Y95vEd8ge0y3k7zWNpsu80s=; b=MPU/7YykhW3Y+5/iiCIWsBtp7M
 nPhatR1qsH3o+DE2WGHbVOYU4lzr4eWKJ17+tinjU6TzSFFsk2amxioi3efeiopIb36ACFQQfN3Da
 LcWr5D6UEJ1zxTaSB5lD00tyt2Opgzf8fLUEEazBXVfbtJhaZrIPW4aVyWRGhrL8pK0n9CURKQ3vK
 Lwlq9lPuAT8X8Sa9xmL14++Xgs2jEBy+BnoJ6jeEMtjmBMEzoNP+UHn3/8UubLz3qDoAzkqiR5GFs
 soaffNi2vTp6Uo0+DDBLGYLY6LKfWKgbhLEeu0iwtxtZ1ANfOUPtaC7YXKjtpG7JHj/pS4+zAyPf8
 H06Lkhbg==;
Received: from [193.77.36.193] (port=41890 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wnAxL-0000000AcoX-0w1h; Fri, 24 Jul 2026 10:08:31 +0200
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
Subject: [PATCH v2 4/4] arm64: dts: rockchip: rk356x: add LVDS node
Date: Fri, 24 Jul 2026 10:08:24 +0200
Message-ID: <20260724080824.115260-5-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724080824.115260-1-rok@kanardia.eu>
References: <20260724080824.115260-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wnAxL-0000000AcoX-0w1h
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

This commit adds the LVDS transmitter node for the RK356x SoC, assigning
its D-PHY, GRF handle and power domain. The block has no register block
and no clock of its own. It is left disabled by default, to be enabled
by specific board files.

Signed-off-by: Rok Markovic <rok@kanardia.eu>
Assisted-by: Claude:claude-opus-4-8
---
Changes in v2:
  - Drop the clock from the LVDS node; the block takes none.

 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b..61a932a 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -878,6 +878,29 @@
 		};
 	};
 
+	lvds: lvds {
+		compatible = "rockchip,rk3568-lvds";
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

