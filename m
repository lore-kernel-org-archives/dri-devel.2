Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6B8CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8DE10E603;
	Sat, 10 Oct 2026 11:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Wi0K8QZb";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5649110E9B4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rp
 O4WDzaFdn7OJ5Ok0/pHV3CuqSEzHovW6aTlMkvFzA=; b=Wi0K8QZbyBI6brkIpf
 CF8AvNv2jmlrMp8RaXqoDtYN3UZNIzuTwnJcJJzfJZfsVPt7fOo3Nk9U0pkkvJTw
 623+UOgFf2uSy3tT/mSDhxZ0e3Xsl1JzH5LFT37nWbG46zmwTm1PbytMKDYln/IO
 1ZKF4k85iNZyewnQBGjyfJEvs=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgCH_z1ByMhqBHGWDg--.46097S2; 
 Fri, 09 Oct 2026 18:56:02 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH 0/3] dt-bindings: display: ti, tpd12s015: convert,
 and fix what the conversion exposed
Date: Fri,  9 Oct 2026 18:55:58 +0800
Message-ID: <20261009105601.301891-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgCH_z1ByMhqBHGWDg--.46097S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1rAw4UJF48tr4fCryrXrb_yoW8uF18pa
 9xWF4DCrn2kF15CrsrXw1qyFZ3Ca93WF4vgF17G3y5Aan8Cw4Fqry3Cr42vrWUG395Cw40
 vF1Yg3sFgwnYy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pERpBsUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wIPhGrIyELcQQAA3f
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

v4.  The three things Laurent pointed out on the v3 thread are addressed,
and the conversion is separated from the two devicetree fixes it turned
up.

  [1/3] converts ti,tpd12s015.txt to DT schema.  gpios is back to three
        entries: the two drivers obtain exactly three through
        devm_gpiod_get_index(), indices 0 to 2, and neither file mentions
        scl, sda or ddc.  v3 had raised maxItems to five only to keep
        dtbs_check quiet for omap5-igep0050.dts, which wrote a defect of
        the DT source into the binding.  That was backwards.

  [2/3] drops the two extra entries from omap5-igep0050.dts, which is
        where the defect belongs.  Nothing reads them: there is no
        pinctrl group for those lines and no other consumer in the tree.

  [3/3] drops the unit-address from the tpd12s015 endpoints on
        am5729-beagleboneai and am57xx-idk.  Those nodes carry a
        unit-address without a matching reg property.

Each of the two devicetree patches removes a warning that the bare
conversion leaves behind, so the three belong together:

  am5729-beagleboneai:  241 -> 237 dtbs_check warnings
  omap5-igep0050:       188 -> 186 dtbs_check warnings

with no new warnings in either file.

Assisted-by: LLM is on all three, which the v1 posting and v3 were
missing.

One thing I raised on the thread and should repeat here: Eduard Bostina
posted the same conversion on 2026-07-30,
<20260730092245.52034-1-egbostina@gmail.com>.  If his series is the one to
carry this, say so and I will drop mine.

Chaosheng Qu (3):
  dt-bindings: display: ti,tpd12s015: Convert to DT schema
  ARM: dts: ti/omap: drop the two unused gpios from the igep0050 hdmi
    encoder
  ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints

 .../bindings/display/ti/ti,tpd12s015.txt           |  44 ------
 .../bindings/display/ti/ti,tpd12s015.yaml          |  90 ++++++++++++
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts  |   4 +-
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi   |   4 +-
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts       |   4 +-
 5 files changed, 94 insertions(+), 52 deletions(-)
-- 
2.43.0

