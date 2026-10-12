Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9D9CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294DF10F599;
	Tue, 13 Oct 2026 07:53:12 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE1710EE39
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EG
 jWHdD+0WJXirqwSDGo2+u4NUBE3eJztml/JqsySN0=; b=U28QwxE81Qk0EQjnOI
 T0yvJ4DU2sgIxBOlyZ2Ggo1Q9Z7nt6c7r6fj/CKuR0L1clWR0APzbg/uNnhnIhZV
 kGU8bWUDWbjbjZGlh9vHDCdcjkiX8rJntKzG0pZaK1FFxASQ03B+gJR6vFu31TLP
 ZmLuzOsAGsrjCguc/B7TSoF0g=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3Nz_mzcxqHGNeDw--.1037S2; 
 Mon, 12 Oct 2026 20:09:12 +0800 (CST)
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
Subject: [PATCH v6 0/3] dt-bindings: display: ti, tpd12s015: convert,
 and fix what the conversion exposed
Date: Mon, 12 Oct 2026 20:09:07 +0800
Message-ID: <20261012120910.506444-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3Nz_mzcxqHGNeDw--.1037S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyrJF13JF13WFW5JFWxCrg_yoW5Gr15pa
 9xGF4kCw1kGF13KwsrXw1jk395CaykJF4vkF17trW5Jan0kr10qryfK3WavryUG3yfCayj
 vFnYg3srKwnFy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pizuWJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAAh78GrMzejbpwAA38
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

v6 of the tpd12s015 conversion.

  [1/3] converts ti,tpd12s015.txt to DT schema.

  [2/3] drops two gpio entries from omap5-igep0050.dts that nothing reads:
        the binding and both drivers describe three gpios, and the extra
        two have no pinctrl group and no other consumer in the tree.

  [3/3] drops the unit-address from the tpd12s015 endpoints on
        am5729-beagleboneai and am57xx-idk, which carry one without a
        matching reg property.

Patches 2 and 3 remove warnings that the bare conversion leaves behind:

  am5729-beagleboneai:  241 -> 237 dtbs_check warnings
  omap5-igep0050:       188 -> 186 dtbs_check warnings

with no new warnings in either file.

Changes in v6:
 - Carry Conor's Acked-by on 1/3, which v5 dropped by accident.  The only
   change 1/3 saw between his ack and v5 is the ports $ref Rob asked for,
   and that does not change which device trees the binding accepts.
 - Send 2/3 and 3/3 to the OMAP device tree maintainers.  They touch
   arch/arm/boot/dts/ti/omap; v5 reached that tree through linux-omap only.
 - Patch content is otherwise unchanged from v5.

Changes in v5:
 - ports: use "$ref: /schemas/graph.yaml#/properties/port" and drop the
   unevaluatedProperties lines.  Neither port carries anything beyond the
   graph properties.  Reported by Rob.
 - description: drop the "|" block scalar.
 - no other change from v4.

The sashiko finding that gpios lacks "minItems: 3" is not valid.  Rob
explained that dt-schema makes the two bounds equal when only one of them
is given, so "maxItems: 3" already means exactly three.

Eduard Bostina posted the same conversion on 2026-07-30,
<20260730092245.52034-1-egbostina@gmail.com>.  If his series is the one to
carry this, say so and I will drop mine.

Chaosheng Qu (3):
  dt-bindings: display: ti,tpd12s015: Convert to DT schema
  ARM: dts: ti/omap: drop the two unused gpios from the igep0050 hdmi
    encoder
  ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints

 .../bindings/display/ti/ti,tpd12s015.txt      | 44 ----------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 88 +++++++++++++++++++
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |  4 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  4 +-
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts  |  4 +-
 5 files changed, 93 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

-- 
2.43.0

