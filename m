Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DBC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3189F10E15E;
	Fri, 18 Sep 2026 17:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SboevVqF";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA0110E15E
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:57:47 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843796e373so594895f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789754266; x=1790359066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SeIdKvGzh7s/Zod1za/yckFgL52L7iFEeDXKnd5/Wj4=;
 b=SboevVqF/L8sjhFGXamFI84iuJSTA+4di6ncK8uZNWMm7hLf5zNtIuIvBgtHEw6LsQ
 Ti3z51yrKL2YhJir7WQVAclAStdQl+rx3vyQAR3EQYp7lZMdKLWY4vD0LcW5yE0oDwnu
 kVLFw8v/Tr+NfiF5TMfW81hQMOugojmMV4pAQOG6QeiaoQB0p2mR4qdmUywYYoDsuBti
 m9grmXqmFcmnzeZbIBph70qypRUSNn54Rd2RTxTQPOxmHiYD6fY8Xsgw6+GTbiQT+a1U
 QBMQcACEjKHnmShpWqLy9gQWrljHKkLaiySFUvCLfTJEketsvfE4/FmIlWiFcWD0waqe
 hBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754266; x=1790359066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SeIdKvGzh7s/Zod1za/yckFgL52L7iFEeDXKnd5/Wj4=;
 b=XbN8BCwZyICLS/50DSwSreXgYNvsJU2/JZq35WWQMtevXBHBdVppSk/j9PvIQARdhJ
 kxT6YW2ER8P8Y4W3ZFo4fhjhUSRiveEXlB76K8X3wffMiXIsfsA4Po8WCPzoMduQSuHi
 THOEMmrYQxW705N7zgNRouGU6V3KNunH34SoRRsGjxMSbvzUuiEK/R1RII3Ah/yNH4JX
 7K7cqBrLOqgKPOULSQsWfL0ah/TawI5HU7O5blDz6MaA7xxCt3lVUkJVSOO7MTQ0LS3H
 lANzTMU7UWRV2XQFnsasT4i5I5050WX9tl/NnUdTktKdzIE4bxSSIxaya0EZ90L8LfUz
 iohQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGMVCqQYHGHObxaKRvgaEy8n0Dd7TYml3QjAc+mcyXk5RwaDicgq72Z1c1hTso33gO+So/9sORTys=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nxWGf3uIZ1CyBz2qXVoZdyilkR5BNt8AE3/gKMFhPlCHNpi/tU
 IeOiIZiddKdK9CC4GIhhxPMZ/jjJvLmkZiUHnNIle0J92ZMA5xbazSbG
X-Gm-Gg: AYBFou3y5qikSWcRSOBw/YzOA0xva6rl64yPtOzcgi6PuULvi9iYxn0e7HN6N3g+g+o
 VC6QEt5wlKuFQUM++Vvcmj1V2HZlFS0EmVfEL03/QjxBYIdhU8mKUZ+HiRrHOvH/n9t2d3ldkCQ
 RtZY8e1qtsSUBqMqzxkogjd3MasiVgx4lJtopKhGHOfLSC7wJzfxlqzgMEiHu+UIIb3mIgfuLUO
 h3LK0YqmO+WrfEiaPomCVO8i9Se0wXQeSx01holhZdmI9JN+kOc7M93yuBS9p0pmZDYrrOyPXAa
 4vvCFZX+z+hESfxA7XRRHRJAar1E5s/EvLmoyHkImTLeioo4zgL+dq1Tiw/dNpC23W9lWDSmdU0
 yYXPQOTZtxCmjYy/HCvNzxlJoXaoFZ7A+q/7b9XZST2SR+eUxKxVQ6e4lCT0jth3B5fdp/lDGQP
 R9YREnA0ceWhjYZ88iMGI4fg24YmPAV531UPfBJdiMWsM4unUgmkwhK0fjhffrhw57mHM=
X-Received: by 2002:a05:6000:610:b0:487:1681:2218 with SMTP id
 ffacd0b85a97d-4871e36bf5amr5507663f8f.45.1789754265990; 
 Fri, 18 Sep 2026 10:57:45 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562aebsm268461f8f.14.2026.09.18.10.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:57:45 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Add support for the mt8167 display pipeline
Date: Fri, 18 Sep 2026 19:55:24 +0200
Message-ID: <20260918175736.355305-1-l.scorcia@gmail.com>
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

This series adds support for (almost) all display blocks of mt8167.
This SoC supports a DSI or DPI display and has HDMI output via a second
DPI block wired to the HDMI phy.

All the hard work was already upstreamed in the past, now all that's left
is some glue. In the first two patches we add support for the DPI output
blocks. In the third one we describe all the possible combinations of the
SoC display pipeline and in the last one we add the required nodes to the
SoC dtsi.

The final outputs of the display pipeline in the SoC dtsi are
intentionally left not connected to allow board dts to specify their
own output node.

I said almost all display blocks because HDMI output is not included in
this patch. I have it tested and working at all supported resolutions, but
since it needs some fixes in clocks and a new phy driver, I will send it
in a separate series.

The series has been tested on a Lenovo Smart Clock 2 (DSI), a Xiaomi Mi
Smart Clock 2 (DSI), and a Sony Playstation Classic Mini (HDMI via DPI).
Unfortunately I couldn't find an actual device using a DPI display, but
since DPI1-HDMI works, I feel confident saying that the clocks divisors
are correct.

Luca Leonardo Scorcia (4):
  dt-bindings: display: mediatek: dpi: Add compatible for mt8167
  drm/mediatek: Add support for mt8167 Digital Parallel Interface
  soc: mediatek: mt8167-mmsys: add routes for all display paths
  arm64: dts: mediatek: mt8167: Add DRM nodes

 .../display/mediatek/mediatek,dpi.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      | 369 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  23 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   2 +
 drivers/soc/mediatek/mt8167-mmsys.h           | 183 ++++++++-
 5 files changed, 569 insertions(+), 9 deletions(-)

-- 
2.43.0

