Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B603C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A392410EE21;
	Wed, 22 Jul 2026 15:45:44 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AC010EE21
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:45:43 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wmZ8R-000000006a3-2gyv; Wed, 22 Jul 2026 15:45:27 +0000
Date: Wed, 22 Jul 2026 16:45:24 +0100
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
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v5 00/11] drm/bridge: it6505: DP audio support + shared-DAI
 hw_params fix
Message-ID: <cover.1784717129.git.daniel@makrotopia.org>
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

Revive HDMI/DP audio support for the it6505, originally posted by
Jiaxin Yu [1], rebased onto current -next with the review feedback
addressed: &client->dev is gone (the driver gained it6505->dev) and
"#sound-dai-cells" has since been added by commit 325af1bef5b9
("dt-bindings: display: bridge: it6505: Add #sound-dai-cells").

Patches 1-9 fix pre-existing bugs found during review of earlier
versions of this series; they carry Fixes: tags and are ordered first
so stable trees can pick them.

Patch 10 wires up the it6505 audio helpers via hdmi_codec_ops,
unblocking the mt8186-mt6366 sound card which references it6505 as
the I2S3 codec. Patch 11 makes hw_params succeed with no display
attached, needed when the I2S bus is shared with another codec as on
MT8186 "steelix" Chromebooks, where the speaker path must keep
working regardless of the it6505 link state.

Tested on a MT8186 (google,steelix) Chromebook: the sound card comes
up, speakers, microphone and headset jack work. HDMI/DP audio output
itself could not be tested for lack of a suitable adapter cable.

[1] https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek.com/
---
v5:
 * patch 1: serialise notifier registration state with extcon_lock
 * patch 2: also drop the runtime PM usage ref held for a connected
   display; retitled
 * new patches 3-7 and 9: more pre-existing fixes from v4 review
   (AUX unregister symmetry, poweroff error path, IRQ status read
   errors, two divisions by zero, of_node_put before use)
 * patch 10 (was 4): update plugged_cb/codec_dev under mode_lock
 * patches 8 and 11: no changes

v4: https://lore.kernel.org/all/cover.1784681487.git.daniel@makrotopia.org/
 * patch 1: quiesce extcon notifier and IRQ before cancelling work,
   initialise extcon_wq in probe; retitled
 * new patch 2: disable runtime PM on remove
 * patch 3 (was 2): collected Chen-Yu Tsai's Reviewed-by
 * patch 4 (was 3): start out muted; mute state and cached
   parameters updated under audio_lock; unregister codec after
   quiesce
 * patch 5 (was 4): apply audio defaults at probe time

v3: https://lore.kernel.org/all/cover.1784600387.git.daniel@makrotopia.org/
 * new patches 1 and 2, fixing a pre-existing use-after-free on
   remove() and an out-of-bounds read with channel_count == 0
 * patch 3 (was 1): serialise audio enable/disable with audio_lock;
   track mute state so the FIFO-error IRQ cannot undo a mute
 * patch 4 (was 2): no changes

v2: https://lore.kernel.org/all/cover.1784561622.git.daniel@makrotopia.org/
 * keep and unregister the hdmi-codec platform_device on remove
 * initialise delayed_audio before registering the codec device
 * cancel delayed_audio synchronously on shutdown and remove
 * disable audio immediately when muting
 * patch 2: drop the encoder check instead of returning 0 early

Daniel Golle (10):
  drm/bridge: it6505: quiesce event sources and work on remove()
  drm/bridge: it6505: balance and disable runtime PM on remove
  drm/bridge: it6505: unregister DP AUX adapter on bridge detach
  drm/bridge: it6505: complete poweroff even if disabling regulators
    fails
  drm/bridge: it6505: bail out of the IRQ handler when status reads fail
  drm/bridge: it6505: avoid division by zero in pixel clock calculation
  drm/bridge: it6505: avoid division by zero in audio FS debug print
  drm/bridge: it6505: guard against zero channel count in audio
    infoframe
  drm/bridge: it6505: hold endpoint OF node reference while parsing it
  drm/bridge: it6505: Don't reject audio hw_params without an encoder

Jiaxin Yu (1):
  drm/bridge: it6505: Add audio support

 drivers/gpu/drm/bridge/ite-it6505.c | 247 +++++++++++++++++++++-------
 1 file changed, 190 insertions(+), 57 deletions(-)


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.55.0
