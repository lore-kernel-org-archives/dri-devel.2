Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B20C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E9210E6E1;
	Mon, 20 Jul 2026 07:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="H1Ra45U+";
	dkim-atps=neutral
Received: from th8-a.mail-neoserv.si (th8-a.mail-neoserv.si [152.89.234.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BCB10E2DC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:52:53 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=RQZQFsFTuaENy+b64YWG98CGAz/AOTIn/cFAsb9lKZYOcSeGIHvDuddGXMLrTMNv6VQqCeY78R
 2zEOiatf0Neidu3hSBuvNZJu8gSHdX72/9IH/UObuD78+pXe8CTR1aVoI1yoDyNp44HylMevrs
 8wmUULwN4rSgvK7TbP5Kx9wjo5r+CUeemrJrmvK/V688ByMdlyNn1p3bXM9H+XjEWtneT/yFnf
 c4q8h74zRtKNrId+Ye7XrUw8M6s7mWLUQAivV4/XxfwbhBbzpq3a7MkQ9h0jkvvPoCi6wHva9g
 3Dw3CPTu7O5db4SsDWL4XCRdRd4b+PbKNqlcKYdmz/u93g==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=QUsbUbN2uJ14EC3NitGndSP4UKklyfCcit+hJS7Mnfs=;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:DKIM-Signature;
 b=DAWeOkWDYlaOqsJNagG/IvxSoxrwTcIObCVBB3XaIP2DPbmGSF4W38Rpq0PCgdtOkccF5wcleR
 xqcBv+7HYt+YB07sa6aYtoKsqbmXdJjHUhUIsZrqZwbUkNPbtER7Y2olsdbyg9gASBBvJXZcYG
 DOaUmIdrbsYeXcwC1gJ8jDGVaAq/dwm1oYHxv6fpyM2pfx3eLw8ehhRX0zh200x0F/pl2iyecd
 Sm9TqaAWAWNjvaIdPYoLnsWYNvUJtKEVug1ihiT9Mv5t7GsVUN4oAB68TMQFFlppchvzvtGTA8
 TB7xNZIbiNb0yzgxXaLi36r5EooXMF2WFUh+wUjoMyJN7g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RBJ3oWAx1e/a//9kxC1kTkea2ayAvAwMRn9rFZJTNNk=; b=H1Ra45U+5i5qAegxYtcNZUh6Nx
 qe0nsgRm5Wk7qQH8WM0SCGKZ0b3ToPqOBTkCMrZYuzGO0LAURMsd8r1byYybcHM9a9372c+EuVvuj
 hlHNPbpwsARu+8D/kkzYfnRlI5E+B0fwt/iZcLYbS5q96vs+hVO9Q1skmLYqu2VlVbcScd4vF6lsb
 RVNJU0M3KjXUIeMKjhYCJK1+CVGejPjIglqgiAfA2+9Ukw9n4jSNVodyH6dIfP6G8EqsOzCj/iGcY
 0pYMulpJPUPPJ3Bk2eB2liizebflwxS5X4kghO93dLoQlndgwYFc6oEO+i0jqcCnBhF9+puS5bNzz
 iqJzqM3w==;
Received: from [193.77.36.193] (port=54788 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wkhHH-00000001fP1-2qlb; Fri, 17 Jul 2026 14:02:51 +0200
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
Subject: [PATCH 2/4] dt-bindings: display: rockchip,lvds: add RK3568
Date: Fri, 17 Jul 2026 14:00:03 +0200
Message-ID: <20260717120005.2087386-3-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717120005.2087386-1-rok@kanardia.eu>
References: <20260717120005.2087386-1-rok@kanardia.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wkhHH-00000001fP1-2qlb
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

The RK3568 LVDS transmitter has no register block of its own: it is
programmed entirely through the GRF and re-uses the MIPI DSI0 D-PHY
(rockchip,rk3568-dsi-dphy) in LVDS mode. It therefore needs
phys/phy-names like px30, but unlike px30 it does take a pclk
(PCLK_DSITX_0, shared with the DSI controller the D-PHY belongs to).

It has no analog supplies of its own and no pinctrl: the lanes are
dedicated D-PHY pins, not muxable GPIOs.

Signed-off-by: Rok Markovic <rok@kanardia.eu>
Assisted-by: Claude:claude-opus-4-8
---
 .../display/rockchip/rockchip,lvds.yaml       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
index 03b002a..6280f7e 100644
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
+        avdd1v0-supply: false
+        avdd1v8-supply: false
+        avdd3v3-supply: false
+        pinctrl-names: false
+        pinctrl-0: false
+
+      required:
+        - clocks
+        - clock-names
+        - phys
+        - phy-names
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

