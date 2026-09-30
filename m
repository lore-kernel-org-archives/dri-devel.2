Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512B5CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55E410F376;
	Wed, 30 Sep 2026 12:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="VmFlGgfp";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3CF10E23A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Message-Id:Date; bh=PL4Ft7v/JyB4yYo
 qsmQzVyzNnO5ByprM+v3I7ZTprvE=; b=VmFlGgfp8gE8FB0JR0Z3rfh9AZPDsNK
 EkJ6eBaZx/EPOC6SDdwF0Kkw0erHDF2IDq23HES6YCcZYa1FvcnbKpFTrzWh4MIF
 rmSAVglnORX2ecAoF5+5IWSAEgXegKYKVGZzuY4agdii9Oo6siMOAweqsjR/yT7d
 +qK1ExZ0hJHY=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Eduard Bostina <egbostina@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti,
 tpd12s015: Convert to DT schema
In-Reply-To: <20260930052925.GA931211@killaraus.ideasonboard.com>
References: <20260916015833.112753-1-quchaosheng000406@163.com>
 <20260916123210.107841-1-quchaosheng000406@163.com>
 <179028680032.1886779.12172352669683602550.robh@kernel.org>
 <20260930052925.GA931211@killaraus.ideasonboard.com>
X-CM-TRANSID: _____wD33_7YvLxqrVnvBg--.1786S2
Message-Id: <6ABCBCD9.079C08.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfWFyktF4kGF4DAFW7XFb_yoWkZwb_u3
 WDGrZ7Jw18Crn7Ja17GrsIva13ta18urs5XF1vqFWI9ryrZFs8W34xZrn3WF1kGw4rtrs8
 G3s5JF1ku34akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRErb1DUUUUU==
Date: Wed, 30 Sep 2026 15:40:10 +0800 (CST)
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BkvpGq8vNmTeQAA3v
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

Hi Laurent,

You are right, and the two extra entries should not be in the binding.

Both drivers take exactly three GPIOs:

  drivers/gpu/drm/bridge/ti-tpd12s015.c:150,157,164
  drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c:237,246,255

They ask for indices 0, 1 and 2 -- CT_CP_HPD, LS_OE and HPD.  Nothing reads
index 3 or 4, and neither file mentions scl, sda or ddc.

The text binding I replaced said the same thing:

  - gpios: CT CP HPD, LS OE and HPD gpios

omap5-igep0050.dts passes two more, and there is no pinctrl group for them
and nothing in-tree consumes them.  v3 raised maxItems to five only so that
dtbs_check would keep passing for that board.  That was the wrong direction:
it wrote a defect of the DT source into the binding instead of holding the
binding to what the hardware and the driver use.

So it splits the way you pointed at earlier:

  - the conversion keeps gpios at three entries, which is what the driver
    requires, and
  - a separate patch drops the two extra entries from omap5-igep0050.dts.

My earlier question still stands: would you rather have that as a v4 from
me, or should I leave it to Eduard's series?

Thanks,
Chaosheng Qu

