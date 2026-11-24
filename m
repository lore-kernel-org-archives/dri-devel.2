Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD238606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=9UyQfe3C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B09A10F506;
	Tue, 24 Nov 2026 11:54:56 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D83B10F506
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=0Y95CVSolsT2eGxG3UukQw1bCthTI5uoGuBQNKMmygQ=; t=1795521284; x=1796730884; 
 b=9UyQfe3Ca70uX2e7TW+P2u7kHXTqniX3cBLN3BpAMpS1M0b4queHxGV6tcK31nwRpTm7CXqZ384
 Yorb1Pft3Hs0C++aEbRsFSyu/ypFwohHNHpyDzv7knyeZoqcEQuPF7Not2XzYMEYWUQwIT4zt989s
 ETqfgezdTUCHi4GvqmCthJ+wyXQQEfzAx13YW37L6/k+CNmsp2HbIcrGfkqYQU5kDDO7X9NB+N5+P
 E43LsKPw1+bgBHawf5JKr3x62gm9J+INr9uP7ZFnLNs3Leuqj/MkV+3TGTHa8cwBvh2rE8PrVN4WZ
 Bd9xbizcUD8W/DoIfUjwMgCYV+32fCuVqhzw==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] drm/bridge: tc358762: fix reset handling
Date: Tue, 24 Nov 2026 12:54:16 +0100
Message-Id: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOl6BWsC/yXMQQqDMBBG4avIrA10EgnqVcRFjX/b6UIlE6Ug3
 t1olx883k6KKFBqi50iNlGZpwwuCwqf5/SGkTGb7MN6ZluZFJyJUCQDX6PhIbB3NeV+iXjJ735
 1/d+6Dl+EdA3oOE4KrFXFbQAAAA==
X-Change-ID: 20261124-tc3-reset-e68e91bc1638
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@nabladev.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 kernel@dh-electronics.com, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=95cBuEgKomvG0irQdxNTBuaiupy4Qd3iS5bglnLUJhs=; 
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBrBXruLghhWGCP2n4Puk1XpXU37hzRrYl2i1OZw
 kUEEF+1+8CJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCawV67gAKCRCEYUX6QCjc
 8WRxD/9XWVI6846UBss/bGrlWSl5D3+8GAd9mXpfozjJcnq0eVwaSoDae/UUQFbDwUM0dZksnXI
 EWH2IIi+7vAWkAH/BkbyEX6uNx4Q70vuox+t+oLc5LpgBZiu90qZ4jCb6C0dtJJyqHm8/KvOxJo
 VzJm7Jh0maBv55xM1LQB7yuYYn2tuRqDPpeGQj1XL+zpZASxekjwjYW8EMunYTfiL1Oy8MeAfhu
 tgZ9k2IXoECcAikVBat1s0y20gxji1MdSybvuHJcJP8G6FpzHBeSkBwct1CvSm10R3OaIm1VOyF
 hKcRCWcjTAuKNyvRt3nJsjnzPpmLH3OGVtv1bfDeKta+lnc58nHHCT9GH+cPdR+G6bcDuKkYHs2
 ZScR8QRbDPHzMD1bnInUBt+61b30L4HfBm1UUrK+PFiZizUdrqwNYbH9LZfLad5gqsEpZComJ8h
 C0tmBRd6LSabeG62iuKXqGnbOgITA2MTTrUQRYdg+ooyHOdyVQ0IS8VrNYDMS/xsRpS/0+p5UKB
 YWIOx84WDDFMZhalwukyMQcUXzDYdW5aO1ScrzfAcK2pXgh66WlUzcClrXKUvUePGQS2TroxxDA
 QBD6NAYaGyJNQD++WTj/7jentSzQg0yxHmPkaRYm5m5dyNvztBEd+0Mzqiy1cJ30v+ZiJZ4cW1f
 WgNtWEqE9yA+RNA==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bridge driver desserts reset after disable and asserts that 
upon enbale. That requires users to workaround that by declaring
the reset gpio wrongfully active high. As an interim solution,
ignore polarity, until things have settled to fix it afterwards.
That will break setups with an additional inverter in the signal
patch but those should be uncommon, at least not seen in in-tree
devicetrees. Fix polarity in the one device tree actually declaring
a reset line. That patch has to go in after the bridge fix.

The issue came to sight during experiments with reset lines on the
Epson Moverio BT-200.

The devicetree change is only compile tested.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Andreas Kemnade (2):
      drm/bridge: tc358762: fix reset gpio handling
      ARM: dts: st: stm32mp15xx-dhsom: fix bridge reset polarity

 .../arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi | 2 +-
 drivers/gpu/drm/bridge/tc358762.c                                     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261124-tc3-reset-e68e91bc1638

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

