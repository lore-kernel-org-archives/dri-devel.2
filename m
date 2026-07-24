Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC22EC531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E3710F33D;
	Fri, 24 Jul 2026 08:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="SnKMy2ib";
	dkim-atps=neutral
Received: from th8-b.mail-neoserv.si (th8-b.mail-neoserv.si [152.89.234.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9E710F33D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:09:13 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=YB6j0snKIN0Znxlax5DPYQOIxsKuk8Xzp7tvHMwB9itBzIUfU1Zo8OhpvpLC59lg5Q8mm0ti0b
 TYTKWI21vMzeNzWXZkTW5cp7IYw6yYRUsHKvqmoh5f+Vp/eORT2ORMbCuAwKBDjcfIvjpeJNfM
 LKQnnz3yCPeU9/GaCs6Tdg1SHpGji0bKRRnVMqKHH4oQtUdrGDM/riiBs62+/wTI521EMU+ZN/
 1STd+cc2eR1oJTwU27+0QtkvHyWHFP9lEzwzIiXCqox7FO0xtgX0/51ylte212oamAxkjzEobR
 UCCaX8l+nqBYiGA9IDbpUGZ1/Z6AjMqkgcrVlqWpIOyvbg==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=YViIMMCDqrZR+B++lpLWn4IqghxXSPd+UlBUeJAUxLw=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=c+RShuUBQyz3vczTJo+iox7YPG7+hIa70pKVkrvSOqsT+eVt3AISTJU4gJo2/hEENQLzohtfQC
 nZNviMX9NVVObLo/xTs3mTODcS2D7YkWll60uQIkDR+CoB8m28hvMTJwuM0H9FAVHIGmcl10tV
 eCz+WVM+GyU6VBxwLa62M+xuru3QdG4wOy85/rIsyspb5WCHfjLIjayzlF4WwNecfkVRMSrq7d
 exafaKun3EYBLZIRJE0g2DzlMyipbqcFXNGW+32lHgHcAcOeaDRuECf+Xf6mySB4VuqIADbGnF
 m6zX96Q6MAUr1MqAOq/QsP2fCPLltw1+RyrysjZ7DJiYKA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9F0pYwBwyjT9tAdHfnwHDTfb190EtNTp1LqEMp8sNyo=; b=SnKMy2ibdUQIH0P7BBZfjvP4kq
 G3qPuSX6dwRecWHfHHEFdJX6zilyfoD2fqrMoeqkpQ540hm7Ol9sw4vIOEPQvjB2j5JxBQCEAZw++
 MnUs4EK7ZILbXWXApApphwhVu/S+wACLpHJR76627JRp3WBmNdCCBUgHGorg59HwP60Jsk+SzAhCV
 AEILe9bJKqIiCJwRuKCmswU8pPEDuJsQOzlT7RpkKK1iDnzF6BOTbuPL5GX8P3/l6Cb2DjHGQozhP
 wBngcfMIeZnX94II1+WjAQ54z/ZC5IpQkOhC3sjRp0Vw8/YBAwTuoQalBT7xXw23Via43jMm+0BAt
 TnEBz6nA==;
Received: from [193.77.36.193] (port=41890 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wnAxL-0000000AcoX-0PoU; Fri, 24 Jul 2026 10:08:31 +0200
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
Subject: [PATCH v2 2/4] dt-bindings: display: rockchip,lvds: add RK3568
Date: Fri, 24 Jul 2026 10:08:22 +0200
Message-ID: <20260724080824.115260-3-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724080824.115260-1-rok@kanardia.eu>
References: <20260724080824.115260-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wnAxL-0000000AcoX-0PoU
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

The RK3568 LVDS transmitter has no register block of its own: it is
programmed entirely through the GRF and re-uses the MIPI DSI0 D-PHY
(rockchip,rk3568-dsi-dphy) in LVDS mode. It therefore takes the same
shape as px30: phys/phy-names, no reg, and no clock of its own.

Since the block exposes no MMIO, nothing in the LVDS path is clocked
from the DSI controller's APB clock; that gate is held off while LVDS
scans out. It has no analog supplies of its own and no pinctrl either:
the lanes are dedicated D-PHY pins, not muxable GPIOs.

Signed-off-by: Rok Markovic <rok@kanardia.eu>
Assisted-by: Claude:claude-opus-4-8
---
Changes in v2:
  - RK3568 now takes no clock (clocks/clock-names disabled, as for
    px30): the block has no register space, so nothing consumes the
    DSI controller's APB clock.

 .../display/rockchip/rockchip,lvds.yaml       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
index 03b002a..b77d4fa 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - rockchip,px30-lvds
       - rockchip,rk3288-lvds
+      - rockchip,rk3568-lvds
 
   reg:
     maxItems: 1
@@ -121,6 +122,27 @@ allOf:
         - avdd1v8-supply
         - avdd3v3-supply
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-lvds
+
+    then:
+      properties:
+        reg: false
+        clocks: false
+        clock-names: false
+        avdd1v0-supply: false
+        avdd1v8-supply: false
+        avdd3v3-supply: false
+        pinctrl-names: false
+        pinctrl-0: false
+
+      required:
+        - phys
+        - phy-names
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

