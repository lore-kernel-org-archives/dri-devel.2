Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1D606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=7gjaPv5K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089D510E3F2;
	Wed, 25 Nov 2026 11:38:31 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2C710FBAB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=a+FoSJK19GndXtAvkhoYAiWjPx5q6h27H22yvjuinKo=; t=1795606704; x=1796816304; 
 b=7gjaPv5KTX3/OO+NS7AJ+Hur+kBpcsH1g8ATU2/gacbvP/p/ADrCZG+8ELe2IF1Rkg6LKzAkjL6
 jYrRM5OduBpPgzwN/AWufvlt6FfvafA4iASR3gdtjTkkDBRdm/KWUZQmOXaAfhj/XAxbstpY7jOFr
 zTiMihx/mzggx9GBYXQlZdfSa6nFBz7hguOa3j07eaiTBJKqftMAQoIPYsFyKwe76L7rwfaJsE5Um
 zmER3HtTZmc+Bg/Kk28GsX1DfXHf59WWS6dBintZByqio61vuJSYlL9dMt/JzTjAyiCHJEwqYzeyQ
 /Wg7cCe9iIpgQJsC7u4si+ZD3ZLgZAijqZsg==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/2] drm/bridge: tc358762: fix reset handling
Date: Wed, 25 Nov 2026 12:37:19 +0100
Message-Id: <20261125-tc3-reset-v2-0-32eefcaf1460@kemnade.info>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHIBmsC/22NTQ6CMBQGr0Le2hpafkRX3sOwgParPI2taSvRE
 O4u4NblJJOZiSICI9Ipmyhg5MjeLaB2Gemhc1cINguTylUtpSpF0oUIiEgCdYOj7LWsi4YW/xl
 g+b21Lu2P46u/Qac1sBoDx+TDZ5uNcvX+dUcpctFVRh0syr4yON/xcJ3Bnp311M7z/AVszK1Pt
 wAAAA==
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 kernel@dh-electronics.com, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=T/U8AWB5sWFUy24znwFaGmRRqn6YQ5i1SBCRspg3Uwg=; 
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBrBsh2xt0uJ0Nbol28KORb220eRtAVNw95ZKHXG
 lTs9SAfjG2JAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCawbIdgAKCRCEYUX6QCjc
 8cgmD/9XjTW7cSXqGjxjebT+/XtC176aOB54MXB4lacfSigdFRHzVANP8xRO/+GLlWnkTR94vmp
 FyLDm1AYkXvNhl6UMyMBwBxzYGY8A5C3jwJO0TCgZnooQo09Owoig8euWqSsGJxgvM+yqJRJL0F
 EF7jJq6rxfygBjuUSg3EOAzAEHj+TnPSn+1UpyeP8+vjDSjBeoyig6YEcOlBVaredU7MIKAl7bn
 nTEhA5FhnczNLIojnRetORVAdxR14YNEq3cyAZFYZfmpccxOG/XVoBZ+A7Fo5gXviWdFNL9e3fg
 CwxmUnkr60rpS5rQs4uO3DoiU/cnOXj+TiXyJ9/IPcpn8Xj9koFxygJHIdtQvY8ntzi2cLjhyDI
 hI/NCOBl6LAkM2MMtaWCsGZDsLr64cQ6yP7to79VGLIaLnZvXrk75caUpp1KrgNrC9Sc4f5l25Y
 2QPewneq6RW2a8yIWgOIefjTFzyb/WsNvTUIOhMNYF0QBh8VaI0Ghs7eVctFd5VSl+qB0wkp/Ww
 lrTxDLcAqCgbDk+6/fqM+yqMyJdhyiAcPMFlGGYXLfD6RmwhNCxCLdZr6qApPYUrHi9fDfycwOH
 n67/Nv/yvIN1dR2kXAahbQLRGQsUzTbP68W0ac96w8WRQbdfiQuSFb4wrYor+iwgw27r3t7NTwa
 7s3zRCKSJ8egXlQ==
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bridge driver desserts reset after disable and asserts that 
upon enbale. That requires users to workaround that by declaring
the reset gpio wrongfully active high.

Fix polarity in the one device tree actually declaring
a reset line. That patch has to go in after the bridge fix.

The issue came to sight during experiments with reset lines on the
Epson Moverio BT-200. There are two of these chips with a shared reset
line, so also prepare for future conversion to use a reset controller.

To avoid having GPIO maintainers spammed with a bunch of patches for
BT200 support, do that fix separately and now, so it can go in more
fast-track way.

The devicetree change is only compile tested and is more
a cleanup, not an urgent fix.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- do not use raw gpios but use the quirk framework fixing also initial
  state
- Link to v1: https://patch.msgid.link/20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info

---
Andreas Kemnade (2):
      gpio: tc358762: fix reset gpio handling
      ARM: dts: st: stm32mp15xx-dhsom: fix bridge reset polarity

 .../boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi  | 2 +-
 drivers/gpio/gpiolib-of.c                                          | 7 +++++++
 drivers/gpu/drm/bridge/tc358762.c                                  | 6 +++---
 3 files changed, 11 insertions(+), 4 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261124-tc3-reset-e68e91bc1638

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

