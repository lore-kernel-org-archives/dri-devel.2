Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39719C98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8695410E4EA;
	Thu, 24 Sep 2026 18:40:26 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7189F10F70D
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:40:19 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1x9oMU-000000007GV-1R2Y;
 Thu, 24 Sep 2026 18:40:02 +0000
Date: Thu, 24 Sep 2026 19:39:58 +0100
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
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v7 00/14] drm/bridge: it6505: DP audio support + shared-DAI
 hw_params fix
Message-ID: <cover.1790275151.git.daniel@makrotopia.org>
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

Patches 1-12 fix pre-existing bugs found during review of earlier
versions of this series; they carry Fixes: tags and are ordered first
so stable trees can pick them.

Patch 13 wires up the it6505 audio helpers via hdmi_codec_ops,
unblocking the mt8186-mt6366 sound card which references it6505 as
the I2S3 codec. Patch 14 makes hw_params succeed with no display
attached, needed when the I2S bus is shared with another codec as on
MT8186 "steelix" Chromebooks, where the speaker path must keep
working regardless of the it6505 link state.

Tested on a MT8186 (google,steelix) Chromebook: the sound card comes
up, speakers, microphone and headset jack work. HDMI/DP audio output
itself could not be tested for lack of a suitable adapter cable.

[1] https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek.com/
---
v7:
 * new patch 2: cancel link_works, hdcp_wait_ksv_list and hdcp_work
   in it6505_poweroff() so link training and HDCP authentication
   cannot run into a chip being powered off; pre-existing, found
   while assessing the Sashiko AI review of v6
 * patch 13 (was 12): it6505_poweroff() clears the powered flag
   under audio_lock, closing the race between the codec ops and a
   concurrent power-off flagged by the Sashiko AI review of v6; the
   it6505_enable_audio() wrapper is folded into the delayed work
 * the remaining v6 review findings are already fixed by later
   patches of this series (patches 3, 4, 6, 8, 11 and 12), concern
   pre-existing code outside its scope (whole-register restore in
   it6505_audio_input(), unchecked reads in it6505_aux_i2c_wait()
   and it6505_calc_video_info(), regulator disable order) or do not
   apply (AUX unregister on unbind, missing newline in dev_err())
 * rebased onto next-20260923
 * patches 1, 3-12 and 14: no changes

v6:
 * patch 1: track notifier registration in a flag instead of
   clearing notifier_call, which a chain traversal racing the
   unregistration could have called as NULL (extcon traverses its
   raw notifier chain unlocked); flagged by Sashiko AI review of v5.
   The in-flight-callback race also flagged there is an extcon core
   limitation affecting all its consumers and cannot be closed from
   a consumer driver.
 * patch 4: note that a failed regulator_disable() leaks the
   reference either way
 * new patches 10 and 11: two more pre-existing fixes from v5
   review, an uninitialised link-frequencies value and an error
   code written back to the reset register
 * patches 2, 3, 5-9, 12 and 13: no changes

v5:
 * patch 1: serialise notifier registration state with extcon_lock
 * patch 2: also drop the runtime PM usage ref held for a connected
   display; retitled
 * new patches 3-7 and 9: more pre-existing fixes from v4 review
   (AUX unregister symmetry, poweroff error path, IRQ status read
   errors, two divisions by zero, of_node_put before use)
 * patch 10 (was 4): update plugged_cb/codec_dev under mode_lock
 * patches 8 and 11: no changes

v4:
 * patch 1: quiesce extcon notifier and IRQ before cancelling work,
   initialise extcon_wq in probe; retitled
 * new patch 2: disable runtime PM on remove
 * patch 3 (was 2): collected Chen-Yu Tsai's Reviewed-by
 * patch 4 (was 3): start out muted; mute state and cached
   parameters updated under audio_lock; unregister codec after
   quiesce
 * patch 5 (was 4): apply audio defaults at probe time

v3:
 * new patches 1 and 2, fixing a pre-existing use-after-free on
   remove() and an out-of-bounds read with channel_count == 0
 * patch 3 (was 1): serialise audio enable/disable with audio_lock;
   track mute state so the FIFO-error IRQ cannot undo a mute
 * patch 4 (was 2): no changes

v2:
 * keep and unregister the hdmi-codec platform_device on remove
 * initialise delayed_audio before registering the codec device
 * cancel delayed_audio synchronously on shutdown and remove
 * disable audio immediately when muting
 * patch 2: drop the encoder check instead of returning 0 early

v1: https://lore.kernel.org/all/cover.1784393979.git.daniel@makrotopia.org/
v2: https://lore.kernel.org/all/cover.1784561622.git.daniel@makrotopia.org/
v3: https://lore.kernel.org/all/cover.1784600387.git.daniel@makrotopia.org/
v4: https://lore.kernel.org/all/cover.1784681487.git.daniel@makrotopia.org/
v5: https://lore.kernel.org/all/cover.1784717129.git.daniel@makrotopia.org/
v6: https://lore.kernel.org/all/cover.1784947240.git.daniel@makrotopia.org/

Daniel Golle (13):
  drm/bridge: it6505: quiesce event sources and work on remove()
  drm/bridge: it6505: quiesce work items before powering off
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
  drm/bridge: it6505: reject a too short link-frequencies property
  drm/bridge: it6505: don't write an error code back to the reset
    register
  drm/bridge: it6505: Don't reject audio hw_params without an encoder

Jiaxin Yu (1):
  drm/bridge: it6505: Add audio support

 drivers/gpu/drm/bridge/ite-it6505.c | 262 +++++++++++++++++++++-------
 1 file changed, 200 insertions(+), 62 deletions(-)


base-commit: 3d7783543c2646af69ad65825e810060494bea21
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.55.0
