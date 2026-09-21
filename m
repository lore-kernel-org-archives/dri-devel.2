Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32446C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BE810E031;
	Mon, 21 Sep 2026 11:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AhavPE5s";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D73510E031
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:39:27 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso13563655e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789990765; x=1790595565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bJjHs4K3u+gvdjbfOs0Xg8GRiY9vzGbZiOJ805s9gPE=;
 b=AhavPE5s/s9Do2dRNN62rmFmLxvsXV7NDF9tluS0IP53KkX044RU6cLy0ELcZ3oJmR
 Q/fa+xtNTHQil2WUzfMwHuprCV/eowgLArV+/gWejVesUD0U2WMlC32XRHcQ3fmulMSI
 8dOzFQS4OQE8I3agB2jWNd7bhqC15lLLFsoIgSTr1ybnAER9kmYWfYtIgF2X+0aqgfSH
 VP84rzOmmf5cgEdkGH9KkHT3hPCyo34BiUbiFhlrRYLzeDvfXau6bAEuhxiEkKxGl+gr
 l7AGxxJSHqzhih4iRMZwx0FmwmjMAXxg+1UG6sa0nYWNFaYXmv/F5Ga91zk/eaAGlZd6
 WNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990765; x=1790595565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bJjHs4K3u+gvdjbfOs0Xg8GRiY9vzGbZiOJ805s9gPE=;
 b=yfFClQqS+W3PHAAQQdPcR3kCdZiVXymL2jcKbmwfI+q8rL/wVbagMXR79XCd/FLUyu
 R0M5ouON5O8OXLJxKwX8mgqZlRVUKpW3fUNxKmYRW4a36VUkJL/f8O82UeHyMpqHNAo3
 wksc1dBuShdtTHJo/JuUwHUHbEciXCKF2q1Fb5EMQcANWuKNHTr95p/rTeVBAjjduKfd
 Vqw1DiyYnHVbIT7wsw3a7OCuf/meFjKR6Os6zOT+SHWNsZoI7OJOpffudqDbTRcMEsvU
 gI63rbFnCn3oIJQ+qzLD3S04I2I4JRLmD7IQZaSsjttQKroE1vQZJLIA3ivrNlXbVxtE
 wkMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0CMdQBSAkHk+ROi4RJByyecyvdF/4wuZ3W1mOBfszkrD+rZ0xtJVC+Lj0y6skTWILY+qv0P/Ci/8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mimJXY7fl0zrsceahNmyBo91KFpEaFSW8H05InHw5AMoI/5ZIb
 qFBBT2U50ePDf4sQKandJ8rj+ytxK+azfbNV/aWrsJgBTf24Z3J3wYE1
X-Gm-Gg: AYBFou3EFy1f2NrsSJRdJw4U9ZKBpXNXiuV9kfND/QXcx9STwZl9x/dTylHzBFz6ElA
 MJX5Zqm62Q+NkJUGrHEorTCs+xNiJLgmgoi7uEr+0TAPqg2NivFK7ifsk9XDKO9HO7pRAz1hkZJ
 L1vZYpKsG1CwIbfxgsy/aIwCur7+b2oSnR7gLKf0hl1uYKyWEi0ebiJCDW0Cx79mTs7NovaRQuf
 ChZH1j3lfG6fTmrubII/wmJv8uV7oYK3Kyv41PbNsip4Za/4jAvXWvgRDsyxyX+nMtYBv6i2pwE
 U086wr1URQOWPnMTkV94COzfbr1qVhD5T6cJ1s7mNJT+8qIBsMsYlQeLY1Qq2j+4tDZiahoTZZQ
 EB4sLlDLvwF+b7AXTPuFYzt26okCJ86RcTCSnBGFsBcx23M1tYwjsX87qdvGy41Lfsx4NHj0qAK
 Pg7hukxgSGoPkVHFZmBE/3GPoLNoCjFSRaTqFEK29q5mipVBm0MSz7apYDbNV/Do2cv+k26YqSW
 YQvtA==
X-Received: by 2002:a05:600c:3b8e:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-49fc57144aamr185348875e9.8.1789990765124; 
 Mon, 21 Sep 2026 04:39:25 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm244273865e9.3.2026.09.21.04.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:39:24 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] Add support for the mt8167 display pipeline
Date: Mon, 21 Sep 2026 13:38:54 +0200
Message-ID: <20260921113914.779393-1-l.scorcia@gmail.com>
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

Changes in v2:
- Fixed some copy-and-paste error in MMSYS routes spotted by Sashiko [2].

Initial version: [1]

[1] https://lore.kernel.org/linux-mediatek/20260918175736.355305-1-l.scorcia@gmail.com/
[2] https://sashiko.dev/#/message/20260918180358.81A1D1F000FF%40smtp.kernel.org

Luca Leonardo Scorcia (4):
  dt-bindings: display: mediatek: dpi: Add compatible for mt8167
  drm/mediatek: Add support for mt8167 Digital Parallel Interface
  soc: mediatek: mt8167-mmsys: add routes for all display paths
  arm64: dts: mediatek: mt8167: Add DRM nodes

 .../display/mediatek/mediatek,dpi.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      | 369 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  23 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   2 +
 drivers/soc/mediatek/mt8167-mmsys.h           | 193 ++++++++-
 5 files changed, 579 insertions(+), 9 deletions(-)

-- 
2.43.0

