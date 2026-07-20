Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0755CC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6966510E9A3;
	Mon, 20 Jul 2026 15:43:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAF110E9A3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:43:14 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlq8r-000000004E2-2F5P; Mon, 20 Jul 2026 15:42:53 +0000
Date: Mon, 20 Jul 2026 16:42:45 +0100
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
Subject: [PATCH v2 0/2] drm/bridge: it6505: DP audio support + shared-DAI
 hw_params fix
Message-ID: <cover.1784561622.git.daniel@makrotopia.org>
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

This series revives HDMI/DP audio support for the ITE IT6505 DP
bridge, originally posted by Jiaxin Yu [1], rebased onto current
-next and with the v3 review feedback addressed: the stale
&client->dev usages reported by AngeloGioacchino Del Regno [2] are
gone (the driver meanwhile gained it6505->dev), and the
"#sound-dai-cells" binding property requested by Chen-Yu Tsai [3] has
since been added by commit 325af1bef5b9 ("dt-bindings: display:
bridge: it6505: Add #sound-dai-cells").

Patch 1 wires up the previously-unused it6505 audio helpers via
hdmi_codec_ops, which unblocks the mt8186-mt6366 sound card that
references it6505 as the I2S3 codec.

Patch 2 is a follow-up fix so that audio hw_params are accepted even
when the it6505 DP output has no display (and thus no encoder)
attached. This is needed when the it6505 shares its I2S bus with
another codec, as on the MediaTek MT8186 "steelix" Chromebooks, where
the shared I2S3 must keep working for the speaker path regardless of
the it6505 link state.

Tested on a MediaTek MT8186 (google,steelix) Chromebook.
Actual HDMI/DP audio output could not be tested lacking the USB-C
adapter cable. However, making the it6505 at least probe and fixing
the obviously missing things makes the sound card on the Chromebook
come up and internal speakers and microphone as well as the headset
mini-jack work as expected (both tested).

[1] https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek.com/
[2] https://lore.kernel.org/all/c35ef2d8-ab40-484b-9a4c-38f2f3e7d99c@collabora.com/
[3] https://lore.kernel.org/all/CAGXv+5G2tP9i8VrUc6-xs2d72_nL9XH9iSCeixzA2AM7X5fXOQ@mail.gmail.com/
---
v2:
 * it6505: store the hdmi-codec platform_device and unregister it on
   i2c remove, fixing a resource leak / use-after-free
 * it6505: initialise the delayed audio work before registering the
   codec device
 * it6505: synchronously cancel the delayed audio work on audio
   shutdown and on driver remove (cancel_delayed_work_sync)
 * it6505: rework the mute path to cancel pending work synchronously
   and disable audio immediately when muting, removing a race
 * patch 2: drop the encoder check entirely instead of returning 0
   early, so the stream parameters are always cached; rewrite the
   commit message accordingly

v1: https://lore.kernel.org/all/cover.1784393979.git.daniel@makrotopia.org/
Daniel Golle (1):
  drm/bridge: it6505: Don't reject audio hw_params without an encoder

Jiaxin Yu (1):
  drm/bridge: it6505: Add audio support

 drivers/gpu/drm/bridge/ite-it6505.c | 104 +++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 19 deletions(-)


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.55.0
