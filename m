Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82598C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3DB10E5CC;
	Sat, 18 Jul 2026 17:29:23 +0000 (UTC)
X-Greylist: delayed 1580 seconds by postgrey-1.36 at gabe;
 Sat, 18 Jul 2026 17:29:22 UTC
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB2D10E5CC
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:29:22 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wl8R1-000000007ra-1sOB; Sat, 18 Jul 2026 17:02:43 +0000
Date: Sat, 18 Jul 2026 18:02:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hermes Wu <hermes.wu@ite.com.tw>,
 Allen Chen <allen.chen@ite.com.tw>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] drm/bridge: it6505: DP audio support + shared-DAI
 hw_params fix
Message-ID: <cover.1784393979.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

This revives Jiaxin Yu's stalled "drm/bridge: it6505: Add audio support"
v3 [1], rebased onto current mainline, plus the fix needed to make it work
on boards where the it6505 DP output shares an I2S DAI with another codec.

Patch 1 wires up the previously-unused it6505 audio helpers via
hdmi_codec_ops, which unblocks the mt8186-mt6366 sound card that
references it6505 as the I2S3 codec.

Patch 2 stops it6505_audio_setup_hw_params() from returning -ENODEV when
no DP display is attached, which would otherwise tear down the shared
backend and break playback on the co-located codec (the speaker).

Tested on a MediaTek MT8186 (google,steelix) Chromebook: speaker and
built-in mic work. Actual HDMI/DP audio output could not be tested as the
sample exposes no usable DP-audio port.

[1] https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek.com/
Daniel Golle (1):
  drm/bridge: it6505: Don't reject audio hw_params without an encoder

Jiaxin Yu (1):
  drm/bridge: it6505: Add audio support

 drivers/gpu/drm/bridge/ite-it6505.c | 94 +++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 17 deletions(-)


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.55.0
