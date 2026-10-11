Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A21CA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 08:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E173F10E051;
	Sun, 11 Oct 2026 08:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUV4CT/H";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA2710E051
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 08:20:59 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso4186305e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791706858; x=1792311658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dr49tUUlFxPFnEicxFg6BKjDZLTyIOa8zv4bTCe4eu4=;
 b=gUV4CT/HfLlTKydVDBqgF29eVoN3dvChWYzMiI1ak4Ss8Hn2Z2zDHTzpoulHbWxlXN
 nXo51DrwONgRJbHPVOoU4bg2KagBea29vwAlXcD0ZD1mCG9+PoJuafB1/nODiba72eyR
 kR7uIJ8lVwJSxmaDzCVrnKI0ylZix2WR8YvF3vG5Gyiw56Cn+HzFT8IrCxucEPDfajzf
 LfnkIuEoMBb8Ply4XLo5lz2UdY3N2QIOV5Jxyu9tpH/DKLSHY6EU+F2GV/ig35JKGnzl
 6kbBg5JMYFkt0sFrl8lOlQu9NeXM1U5C8qK1kXpzf59GwUXjIxpxrwD3voD/3W/habh2
 baYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791706858; x=1792311658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dr49tUUlFxPFnEicxFg6BKjDZLTyIOa8zv4bTCe4eu4=;
 b=MxXfuyAopWdP5De56UlCQu7zVyej0riog5feQTDXeyZ2Xyn3kVn/CFO442pC5OYbgO
 bB1P8VnOqO8BPmzW2NKQBwsnQQ1VMcI1MMtSKIepQq37qAA4fLzkDTNuO0T8xjbJclJM
 bK14aT8JkkIHMz8YCFAo6gw3FKnHhHzjqKI0AEVS58nE2PI3LmXU+qMcsJ+J84TPWdhS
 y63Fp1QU+kB4Jo/uR4h+U/J/HbzlhMg8YTuEYx0TXHqdBOEjbF4K8Kb6b5waUQiVawuq
 BGVd0QFxzN5WqJuK0cvT5KczHCID18sK3oV9LCCd4Krc45DOw4ZZ7cG/cCzQb7sLrnRf
 sdow==
X-Forwarded-Encrypted: i=1;
 AKwUvBya4kRJepGXqcvnwIFG2fOHWrse/SUsy8twkGpT+z3Y+cF5TgSBh53xi7YaUouSj+UF0xaFD6LZkB4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI4459zqoPZLODrBlByqr+F69OyNlSoq6pOqC5k2OQ6pbYhmNkL
 B2g25XD0DVw8HFD0yr1Pdx4UGJKn2GRXgCHtQ3dHan+qqYDnhvEpaxNo
X-Gm-Gg: AYBFou2SKYFs0tY4R/OoxxXFKBTTBvHlvxkytLqAaXDcFDstm7CgEmU4Dx4b/icRAxb
 z5dqfKbg2/3IeKEvGi0kLgswAPsMkvMUoOf6Hz4SND1Tng0zX137fiqqbuVvOCGZmoP+SjHBL2O
 K86Mxue8IerDrp6zM5m2oe//RJ2LUpgisyy2GVjpYlBgy48bQUvS3sNe5rKqMW+9EzsYuFz6VYh
 7N0Ykklo84bcZo/+w3/+YATAogEqRgZFx0/o1V/bX7youm7Vcq7IlEQcSpW0dU73NwTDGmdRjgT
 J87qffGmWndkBH46Qlxm1uCiuHGNU0OR4Va9dpqk1kp6436LS9TKrD5yfDiou/A80i60U3wWG7U
 VT5b4FUIxafovHEVTUCL2ZGIeKi0SfU93D/rMKe/yoMFH0lVIuHdGwWZDAQj9u8s8ok1gz79rtz
 AhzeKZb2z8pj9I9p4SnKMOTRDY4p43E9OlfQn4Saw+3S2g7W7eoAiQRt8lzqiMPw8Q8Ps=
X-Received: by 2002:a05:600c:4708:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-4a18e47a8a5mr126204925e9.10.1791706857720; 
 Sun, 11 Oct 2026 01:20:57 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a195002123sm152063175e9.1.2026.10.11.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 01:20:57 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] phy: mediatek: phy-mtk-hdmi: Use regmap to manipulate
 hdmi registers
Date: Sun, 11 Oct 2026 10:20:30 +0200
Message-ID: <20261011082042.348422-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While working on MediaTek mt8167 HDMI support I noticed that on some SoCs
like mt8167 and mt8173 the registers used by HDMI PHY are actually inside
the memory space mapped by the apmixedsys driver. On mt8173 this driver
maps its memory using of_iomap, while on mt8167 it currently uses
devm_platform_ioremap_resource. The current phy_hdmi_mtk uses
devm_platform_ioremap_resource too, which causes a conflict between the
two at probe:

hdmi-phy: error -EBUSY: can't request region for resource
[mem 0x10018300-0x1001831f]

In patch [1] I initially proposed to use the same approach of mt8173
in mt8167 too. While working Sashiko correctly pointed out that it never
unmaps its memory during remove [2], even on mt8173. It is of course
possible to add code for that, but it would mean creating a dedicated
drvdata structure, and it seems a little invasive. Using the devm_*
functions is certainly cleaner.

This patch goes in the opposite direction - it converts all register
access for mtk hdmi phy to the regmap_* functions and obtains the regmap
using device_node_to_regmap, which internally uses iomap and does not
trigger the conflict. This way memory can still be managed by the
apmixedsys driver using the devm_* and the HDMI phy only gets a regmap.

This patch has been tested on mt8167 only. Unfortunately I have no devices
with the other SoCs that are touched by this refactoring, so I am sending
it as a RFC to gather feedback from more experienced kernel devs.

[1] https://lore.kernel.org/linux-mediatek/20261010115539.9237-4-l.scorcia@gmail.com/T/#u
[2] https://sashiko.dev/#/patchset/20261010115539.9237-1-l.scorcia%40gmail.com

Luca Leonardo Scorcia (1):
  phy: mediatek: phy-mtk-hdmi: Use regmap to manipulate hdmi registers

 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c | 145 ++++++++--------
 drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c | 133 +++++++--------
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 185 ++++++++++-----------
 drivers/phy/mediatek/phy-mtk-hdmi.c        |   2 +-
 drivers/phy/mediatek/phy-mtk-hdmi.h        |   3 +-
 5 files changed, 235 insertions(+), 233 deletions(-)

-- 
2.43.0

