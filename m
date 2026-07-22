Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6874C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C19910EBC3;
	Wed, 22 Jul 2026 00:59:06 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6484B10EBC3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:59:04 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wmLIO-000000000wX-0G8R; Wed, 22 Jul 2026 00:58:48 +0000
Date: Wed, 22 Jul 2026 01:58:43 +0100
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
Subject: [PATCH v4 0/5] drm/bridge: it6505: DP audio support + shared-DAI
 hw_params fix
Message-ID: <cover.1784681487.git.daniel@makrotopia.org>
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
-next and with the feedback on that original posting addressed: the
stale &client->dev usages reported by AngeloGioacchino Del Regno [2]
are gone (the driver meanwhile gained it6505->dev), and the
"#sound-dai-cells" binding property requested by Chen-Yu Tsai [3] has
since been added by commit 325af1bef5b9 ("dt-bindings: display:
bridge: it6505: Add #sound-dai-cells").

Patch 1 fixes a pre-existing use-after-free in the driver's remove()
path: none of link_works, hdcp_wait_ksv_list or hdcp_work were ever
cancelled before devres frees the it6505 struct, unless DRM core
happened to call the bridge's .detach() first. The extcon notifier
and the threaded IRQ are quiesced before the work items are
cancelled, so they cannot requeue them. It is needed before patch 4
so that wiring up the new hdmi-audio-codec platform_device does not
add another caller into an already-broken teardown path.

Patch 2 adds the missing pm_runtime_disable() in the same teardown
path, another pre-existing bug: unbind followed by a rebind triggered
"Unbalanced pm_runtime_enable!".

Patch 3 fixes a third pre-existing bug: it6505->audio.channel_count
is zero until either DP link training or a valid ALSA hw_params call
has run, but it6505_enable_audio_infoframe() indexes an 8-entry table
with channel_count - 1 unconditionally, which is an out-of-bounds
stack read if the audio-FIFO-error IRQ fires first. It also fixes a
debug print that logged the previous channel count instead of the
rejected one. Needed before patch 4 for the same reason as patch 1:
that patch starts exercising the audio-FIFO-error IRQ path in a
configuration (shared I2S bus) where it is actually likely to fire
before any display has ever been hotplugged.

Patch 4 wires up the previously-unused it6505 audio helpers via
hdmi_codec_ops, which unblocks the mt8186-mt6366 sound card that
references it6505 as the I2S3 codec.

Patch 5 is a follow-up fix so that audio hw_params are accepted even
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
v4:
 * patch 1: quiesce the scheduling sources before cancelling work:
   unregister the extcon notifier (made idempotent for that) and
   disable the IRQ first, and only cancel the work items once the
   DRM-facing interfaces are removed; initialise extcon_wq at probe
   time to avoid a WARN_ON(!work->func) splat when unbinding a
   never-attached bridge; retitled. Both flagged by Sashiko AI
   review, the WARN_ON also confirmed by Chen-Yu Tsai.
 * new patch 2: disable runtime PM on remove, a pre-existing issue
   flagged by Sashiko AI review
 * patch 3 (formerly 2): no changes, collected Chen-Yu Tsai's
   Reviewed-by
 * patch 4 (formerly 3): start out muted until ALSA unmutes the
   stream; update the mute state and the cached stream parameters
   under audio_lock; probe the audio input and enable audio under
   audio_lock in the audio-FIFO-error IRQ handler, re-checking the
   mute state under the lock; unregister the audio codec device only
   after event sources and work items are quiesced. All flagged by
   Sashiko AI review.
 * patch 5 (formerly 4): move the audio parameter defaults from
   it6505_variable_config() to probe time so a display hotplug no
   longer clobbers the parameters cached from hw_params, flagged by
   Sashiko AI review

v3: https://lore.kernel.org/all/cover.1784600387.git.daniel@makrotopia.org/
 * new patch 1: cancel link_works, hdcp_wait_ksv_list and hdcp_work in
   it6505_i2c_remove(), fixing a pre-existing use-after-free flagged
   by automated review of v2
 * new patch 2: guard it6505_enable_audio_infoframe() against
   channel_count == 0 and fix a debug log printing the wrong channel
   count, both pre-existing bugs flagged by automated review of v2
 * patch 3 (formerly patch 1): serialise it6505_enable_audio() /
   it6505_disable_audio() with a new audio_lock mutex, resolving the
   "input welcome on whether a lock is warranted" note in the commit
   message; track explicit mute state so the audio-FIFO-error IRQ
   no longer re-enables audio out from under an ALSA-requested mute,
   both issues flagged by automated review of v2
 * patch 4 (formerly patch 2): no changes

v2: https://lore.kernel.org/all/cover.1784561622.git.daniel@makrotopia.org/
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

Daniel Golle (4):
  drm/bridge: it6505: quiesce event sources and work on remove()
  drm/bridge: it6505: disable runtime PM on remove
  drm/bridge: it6505: guard against zero channel count in audio
    infoframe
  drm/bridge: it6505: Don't reject audio hw_params without an encoder

Jiaxin Yu (1):
  drm/bridge: it6505: Add audio support

 drivers/gpu/drm/bridge/ite-it6505.c | 213 +++++++++++++++++++++-------
 1 file changed, 163 insertions(+), 50 deletions(-)


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.55.0
