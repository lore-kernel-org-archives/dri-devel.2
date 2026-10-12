Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94086CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C113E10F57A;
	Tue, 13 Oct 2026 07:53:00 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2539210E449
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=no
 1Td3tdmEW7G6ld8W+IQiOPMrAFQrOX8CNuntiDDkw=; b=eiDJn36JJDAYeoFxFn
 j/hsQH7XjgfeL7Qyfq4GLL0xlbpa4JyvYnIwtDAix7MQG/lA1pneHtqnLqL/m3N4
 pk9QB61SLqLoJap86xqsmk+b+Me3Qp/q4NCaBLfVEFSws9v7QZgYQ+EAiBcnyLa0
 w64bcV0GhH1OCthYKktBP2WaU=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3Nz_mzcxqHGNeDw--.1037S4; 
 Mon, 12 Oct 2026 20:09:14 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH v6 2/3] ARM: dts: ti/omap: drop the two unused gpios from the
 igep0050 hdmi encoder
Date: Mon, 12 Oct 2026 20:09:09 +0800
Message-ID: <20261012120910.506444-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012120910.506444-1-quchaosheng000406@163.com>
References: <20261012120910.506444-1-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3Nz_mzcxqHGNeDw--.1037S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7WryUWrWUKrWDCw18KF45Jrb_yoWktwcEqa
 s7Kw4Iqan3tr9Ik3Z5X3s8W34xu3Z8uws3Gr1kKr47K3ZxZF4kGFZ7tF93Gw45WrZrKrZ3
 GryrtF1qyw4avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRHMKJUUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wp78GrMzep3pwAA3z
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
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

From: Chaosheng Qu <quchaosheng000406@163.com>

omap5-igep0050.dts gives the tpd12s015 node five gpios. The binding, the
DRM driver and the fbdev driver all describe three: CT CP HPD, LS OE and
HPD. Nothing in the file references the extra two, there is no pinctrl
group for them and no other consumer in the tree.

Drop them so the node matches what the hardware and the drivers actually
use.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
index 0368e32f67e7..8e8325936cda 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
@@ -102,9 +102,7 @@ OMAP5_IOPAD(0x086, PIN_INPUT | MUX_MODE6)	/* gpio4_118 */
 &tpd12s015 {
 	gpios = <&tca6416 11 0>,	/* TCA6416 P01, CT_CP_HDP */
 		<&tca6416 12 0>,	/* TCA6416 P00, LS_OE*/
-		<&gpio7 1 0>,		/* 193, HPD */
-		<&gpio7 2 0>,		/* 194, SCL */
-		<&gpio7 3 0>;		/* 195, SDA */
+		<&gpio7 1 0>;		/* 193, HPD */
 };
 
 &twl6040 {
-- 
2.43.0

