Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39754C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D4410F2BD;
	Fri, 31 Jul 2026 14:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CWVHyUxO";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3747310F2C3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785508929;
 bh=o4a/RmM5I1yrb5pHfvhM/3/VlIqsp3pJVA+B6oCaosY=;
 h=From:Subject:Date:To:Cc:From;
 b=CWVHyUxOeXopaDsI3iceuFVToIoLmZZOEmOSABlM1SmbzwWPY29uD0zhSKkYSj9IQ
 u+76Uf4DzOHNSxO3NAva50SQSyCZBgWJUO8JJAH1QkXDBirC8lDXurKJHHXrRYTJdg
 whBT2SxQ/UOEu7U7o3AXyRPIjsAbb38xWmIv3ewdQSIJkxoQ9hDa58IaU8S5rpoS/d
 4lQmTTNmOk9Gh+egBHC/85C599QRLs5vfJfHF4nxfnrrZk9Ie8CbEqkRxT8LPIUcYZ
 hZsdocNBBUvj+mJ9x4SYH/X7SOJjZJwGcfcWv40LN5W2kqoQEQfOGgGTfa6zaR6dPx
 3uGKluVSOgs/w==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4458B17E06D8;
 Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id F026B480029; Fri, 31 Jul 2026 16:42:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v8 00/21] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Fri, 31 Jul 2026 16:42:05 +0200
Message-Id: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XQTWrDMBAF4KsErasijUd/XfUepQtZGjWCxDJWc
 BtC7l4lUByocenyDcP3hrmwSlOmyl52FzbRnGsuQwv2acfC3g8fxHNsmYEALTpQvJ6HMtZz5fG
 Tx5Hn4ziVmY40nCo30QM5G5OMkTVhnCjlr7v+9t7yPtdTmc73slnepj+u3nRnyQVXQlp0UgM48
 RrK4eD7MvnnUI7sZs+weG1124PmRUMm6d4HY9Ka1y2elrDtdTcvaEm6U6CEXfNw8Qz8cR82L4m
 EHimSkbDmqUcPtz3VPIeoApA1iHLN0//wdPMEyuicly4grXnm0bPbnmlebzSK5G1I+Ot/1+v1G
 3GmNA6qAgAA
X-Change-ID: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13228;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=o4a/RmM5I1yrb5pHfvhM/3/VlIqsp3pJVA+B6oCaosY=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpstEAyfaP3jXGWOXvNCmA6XzuJEEz0xCz7V
 TTZgPQn5yWow4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqbLRAAAoJENju1/PI
 O/qaW5gP/A4x5Ge+k4mk3YYnGg4VA5s3EOPSLuxrbqDiFCZ0FgUGszK5JFhxHUGjg8Y1hMJ5Whc
 c2Z7bMCkusK7zA5jc7wJEpIgdDi+GZCltZvzRJipUiwIia7gg6wM3fx3EadYT1Mbu7CJ6w9RDqg
 dOlMLDFGc7JqPgmKL7TEg4W9ls9HKkbU90JkQLO8NESru5G57zoJVHcrBrDbPIg+ISgcQPLGtoe
 cnpBlObebghjFNxXDVn2vo0IZJ8waZlir4tt4Thkl5WrknPGatoxvdLX1V/MKvAIBALDgN2iZJ9
 Qre1pl1KP57sQIthlC4oP7Me3wz+bVr05wJyv6khnfEZIjV/BfxsG5arIZ/W+iHoC6DrwV0ZtHk
 GbXTc6VDaxpvpMVe5sYSWOWD1b5YR+hueihwZ5mG/h/i/gg/TY1Nj2WHA1cC0uvM6jHIiHS6It9
 S1bAW3GzshCpLS8zZwTZTgN1gSYlrAaq6X3TSCBqdgH9S4nRSoDrpuwEdNqsj2PmDlttK1r4zH8
 VeDLo0Ce7Tuj6WA6gaFlsRuUozjHHDBbbjAyfcwvalJ9HzlI2Iu6+1hcDGe9EM5G8SRPuNrWc7C
 1sDjq6sJUp2gxHxCsQJvkYw7/vy40A+cSwO0JNgE7FdM4udCHuRXMdSfTU8KUqVHkab92QsRejM
 AqZsiPLIA4jeROt3tHVUocg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

This patch series updates the Synopsys Designware DisplayPort bridge
together with the only existing user: The Rockchip RK3576/RK3588:

 1. Follow-up bridges (PHY, USB-C connector)
    This is needed to get USB-C DP AltMode working; I've followed
    the Qualcomm driver as reference

 2. Runtime PM
    The initial driver has been upstreamed without RPM; add it to
    avoid wasting power when nothing is plugged

 3. Audio
    The initial driver has been upstreamed without audio support;
    this adds all missing bits for audio with single stream transport

To properly make use of the bridge code the following USBDP PHY series
is also needed:

https://lore.kernel.org/all/20260714-rockchip-usbdp-cleanup-v13-0-6cb3e769d4c5@collabora.com/

This series can be applied without the USBDP side. In that case USB-C
support won't work as the mainline USBDP side does not register as a
DRM bridge. As upstream DT binding for USBDP does not yet support
proper ports, no such board should be upstream.

Boards using the DP controller for native DP connectors (or HDMI
bridges), currently directly link to the connector/hdmi bridge. These
are not affected by the USBDP changes and should keep working in any
case. The difference is, that this series the DRM side is aware of the
link. I don't have any of those boards, so this code path is untested.

I added a dedicated bridge callback for out-of-band hotplug events,
which is separate from the hotplug_notify. I have a feeling, that
there might be a better solution, but haven't found it. Please comment.

Changes in v8:
- Link to v7: https://patch.msgid.link/20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com
- Add new patch moving DP AUX bridge registration into
  bridge_attach/detach callbacks, which simplifies cleanup and ensures
  it is (un)registered at the right point in time (Sashiko)
- Update Fix incorrect resource lifetimes in bind callback patch to
  ensure at the end of the probe, the device is fully functional,
  also only register the bridge once all necessary bits are available
  as it is in theory reachable at this point (Sashiko)
- Update the patch cancelling HPD worker to simply use
  devm_work_autocancel() as a result of this rework
- Add a new patch describing why the reset line state is not explicitly
  changed (Sashiko)
- Merge the two patches for the AUX transfer timeout handling to avoid a
  temporary race condition and synchronize IRQs after the reset to fix
  yet another race condition (Sashiko)
- Add a new patch to properly support short I2C reads (Sashiko)
- Rework Runtime PM handling again, so that the OOB handling is done
  before the 100ms sleep. Also ensure it is enabled at the right point
  in time after the cleanup changes. (Sashiko)
- Add new patch to drop useless reservation for SDP slot 0, which
  fix a race condition (Sashiko)
- Also restore audio mute status when audio functionality is restored
  after atomic disable/enable cycle (Sashiko)
- Setup SDP audio frame channel_allocation according to information
  received from ALSA (Sashko)
- Sashiko feedback ignored by me and that may or may not appear again
  in this version as Sashiko does not seem to properly take the whole
  series into account and thus probably ignores the changelog
  * A divide-by-zero vulnerability exists in dw_dp_video_enable when
    processing a display mode with a clock value of 1; I believe this
    clock cannot drive a real mode
  * I2C-over-AUX reply status (NACK/DEFER) is silently discarded,
    causing deferred I2C transactions to falsely succeed and return
    garbage data; this is a false positive. It seems Sashiko got
    confused by the bit patterns. Nothing is discarded.
  * Potential Use-After-Free of the connector and encoder due to missing
    DRM device reference in OOB hotplug event handling; Sashiko
    missed that drm_for_each_bridge_in_chain() is now the renamed
    drm_for_each_bridge_in_chain_scoped().
  * Missing runtime PM acquisition in out-of-band HPD callbacks leads to
    SError crashes once runtime PM is enabled; Sashiko failed to
    notice that Runtime PM is only introduced in a later patch
  * Calling a sleeping function (msleep) from a runtime PM resume
    callback that is reachable from an atomic commit path; Sashiko
    failed to understand that atomic DRM functions may sleep
  * Missing system sleep callbacks prevent the device and its power
    domain from suspending during system sleep for native DP
    configurations; this needs separate investigation considering
    system sleep is broken on recent Rockchip platforms (same error
    appears a few times)
  * There is a bunch of pre-existing issues that are fixed later
    in the series

Changes in v7:
- Link to v6: https://lore.kernel.org/r/20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com
- Move drm_bridge_add() to probe and only attach it in the bind
  function, as the object is re-used and not fully cleared by
  drm_bridge_remove (Sashiko)
- Add a new patch resetting the DP AUX sub-controller on message
  timeout to have decent error recovery (Sashiko)
- Fix dp_dp_rockchip_get_vo_grf -> dw_dp_rockchip_get_vo_grf (Sashiko)
- Introduce pm_active in the PM runtime patch, to early exit
  on atomic_disable when atomic_enable failed to get runtime
  PM enabled (Sashiko)
- Introduce drm_bound in the PM runtime patch, which is (un)set
  when the driver is bound to a DRM encoder and used to enable
  IRQ enabling in the runtime PM handlers. This in turn protects
  the system of potential spurious interrupts. (Sashiko)
- In the audio patch, fix support for hotplug with a running
  audio stream. (Sashiko)
- To avoid further blowing up the series, I've decided not to
  act on these "pre-existing" issues reported by Sashiko. I
  think it makes sense to handle them separately:
    * Short HPD and Long HPD events share a single boolean state
      variable, causing critical hot plug events to be lost if
      interrupts arrive in quick succession.
    * DP AUX lifetime complains (registered too early / unregistered
      too late); reported multiple times
    * The driver fails to support DP AUX short reads, incorrectly
      rejecting them with -EBUSY instead of returning the number
      of bytes successfully transferred, which breaks I2C-over-AUX.
- Collected Reviewed-by from Krzysztof Kozlowski on the
  DT binding patch

Changes in v6:
- Link to v5: https://lore.kernel.org/r/20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com
- Fix overlong commit message in mutex patch
- Update MEDIA_BUS_FMT_FIXED patch, to use input format as output format
  when output format is MEDIA_BUS_FMT_FIXED (Sashiko)
- Drop patch moving dw_dp_bridge_atomic_get_output_bus_fmts (no longer
  needed)
- Reword the comment about platforms other than RK3576 and RK3588
  shouldn't get the VO GRF from the USBDP to make it more obvious
  that no such platform exist at the moment and thus the alternative
  path will not be implemented at this point in time (Sashiko)
- Update the runtime PM code to have much better error handling
  as well as support for platforms not using runtime PM (Sashiko)
- Update the runtime PM code to keep the device suspended when
  probed, but unbound as a nice side effect
- Fix error handling for dw_dp_audio_infoframe_send() in audio
  patch (Sashiko)
- Fix typo in sample width check in audio patch (Sashiko)
- Improve cleanup of SDP in audio patch (Sashiko)

Changes in v5:
- Link to v4: https://lore.kernel.org/r/20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com
- Add new patch to cancel pending HPD work on unbind (Sashiko)
- Add new patch to add missing mutex cleanups on module removal (Sashiko)
- Add new patch moving dw_dp_bridge_atomic_get_output_bus_fmts
- Update MEDIA_BUS_FMT_FIXED patch to avoid fixed RGB888 format
  and instead use whatever works for the negotiated bandwidth (Sashiko)
- Add more error checking for runtime PM patches (Sashiko)
- Ensure runtime PM is held in interrupt handler (Sashiko)
- Fix usbc_mode logic inversion for runtime PM in unbind (Sashiko)
- Move sleep for HPD_HOT_PLUG from hotplug handler to runtime
  resume function; no need to sleep when runtime PM is kept
  active and runtime PM resume is a slow operation anyways. (Sashiko)
- Add new patch to protect sdp_reg_bank from concurrent access (Sashiko)
- Add new patch to use regmap_set_bits in dw_dp_send_sdp()
- Update DT binding patch to be all about the selected solution and
  mention the ABI break
- Clear SDP in the audio patch on unprepare (Sashiko)
- Add a comment, that only 1,2 or 8 channels are supported (Sashiko)
- Error out on unsupported sample_width (Sashiko)
- Fix missing error check for clock enable (Sashiko)

Changes in PATCHv4:
 - Link to v3: https://lore.kernel.org/all/20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com/
 - Drop "Simplify driver data setting" (effectively reverted later on)
 - Add "Fix incorrect resource lifetimes in bind callback", which
   affects all following patches quite a bit (Sashiko)
 - Update "Add follow-up bridge support" to mention that fatal errors
   are fine (Sashiko)
 - Update "Add out-of-band HPD notify handler" to use
   drm_for_each_bridge_in_chain() instead of
   drm_for_each_bridge_in_chain_scoped() required after rebase to
   latest drm-misc-next
 - Add 100ms sleep in hpd detect functions after runtime resume in the
   "Add Runtime PM support" patch (Andy Yan)
 - Keep runtime PM enabled if DP is used without USB-C to avoid missing
   HPD signals in "Add Runtime PM support" patch (Andy Yan)
 - Update patch description of DT binding patch and drop RFC tag
 - Use pm_runtime_resume_and_get() in the audio startup function, which
   allows easy error handling (Sashiko)
 - Avoid updating audio_interface in the audio prepare function when
   an error related early exit happens (Sashiko)
 - Add error handling for clock prepare calls in audio prepare function
   (Sashiko)

Changes in PATCHv3:
- Link to v2: https://lore.kernel.org/r/20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com
- Collect Reviewed-by on "Simplify driver data setting" patch (Andy Yan)
- Use of_drm_get_bridge_by_endpoint instead of devm_drm_of_get_bridge (Luca Ceresoli)
- Use FIELD_PREP_WM16 instead of FIELD_PREP_WM16_CONST (Chaoyi Chen)
- Rebase to latest drm-misc-next (Dropped Cristian's patches)

Changes in PATCHv2:
 * Link to v1: https://lore.kernel.org/r/20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com
 * rebased to latest drm-misc-next
 * prepended the Patches from Cristian's cleanup series, as they also
   needed a rebase and should be merged first
   https://lore.kernel.org/dri-devel/20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com/
 * fix issue with the audio stream (un)prepare handling in last patch

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (21):
      drm/bridge: synopsys: dw-dp: Register DP AUX on bridge attach
      drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callback
      drm/bridge: synopsys: dw-dp: Cancel pending HPD work
      drm/bridge: synopsys: dw-dp: Document missing reset line deassert
      drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal
      drm/bridge: synopsys: dw-dp: Fix AUX transfer timeout race condition
      drm/bridge: synopsys: dw-dp: Fix support for short I2C reads
      drm/bridge: synopsys: dw-dp: Free output_fmts when none are valid
      drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED
      drm/bridge: synopsys: dw-dp: Add follow-up bridge support
      drm/bridge: Add out-of-band HPD notify handler
      drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD
      drm/rockchip: dw_dp: Implement out-of-band HPD handling
      drm/bridge: synopsys: dw-dp: Add Runtime PM support
      drm/rockchip: dw_dp: Add runtime PM support
      drm/bridge: synopsys: dw-dp: Protect sdp_reg_bank from concurrent access
      drm/bridge: synopsys: dw-dp: Drop useless reservation of first slot
      drm/bridge: synopsys: dw-dp: Clear only enabled SDPs on atomic disable
      drm/bridge: synopsys: dw-dp: Use regmap_set_bits in dw_dp_send_sdp
      dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells
      drm/bridge: synopsys: dw-dp: Add audio support

 .../bindings/display/rockchip/rockchip,dw-dp.yaml  |   9 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 782 ++++++++++++++++++---
 drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 190 ++++-
 include/drm/bridge/dw_dp.h                         |  13 +-
 include/drm/drm_bridge.h                           |  14 +
 6 files changed, 901 insertions(+), 113 deletions(-)
---
base-commit: 35b6cf07851a2b430b0eefbcb7b5a856f9030264
change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

