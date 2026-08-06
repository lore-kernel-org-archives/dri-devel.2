Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195C3C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203E610E34C;
	Thu,  6 Aug 2026 17:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Uo244yPx";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E08710E353
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035745;
 bh=OKBQXxWBoztrhVdPd0Io+zSfgbjrwwSHMA+7HlW2e2o=;
 h=From:Subject:Date:To:Cc:From;
 b=Uo244yPxllys+6wY2mBx7N5wVH5bWr9LjYPRImAH+PxS0l8g5SwzUE+wZOEFf6KYG
 gdlh9geKc1HhsHFOsdee+peZ9JKLS4NJCupUhwsPRCI9NLzsiWeeYmalU2ilcvjCC5
 5pKSBDQbjVPUxYuqxsGAunlyAjRkyVwL2JUzzLyIki9+B88P5yvsMUawyfhUqNwVSb
 RawDB3/Q0tQtNK5NQ+/kbeQ6K1cBW7M5kQKx/KMyNwL8avGdbSWsNEtDTZqmukQSP2
 vUTrAR4u3+DepF5zGHJsLp5mG+Bxt56Iyu37gWZcc0VOnds5kiqbRR5h3+1yenOND4
 cSPStksJ6l6WA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4526A17E0A5C;
 Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id ECA4E480029; Thu, 06 Aug 2026 19:02:24 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v11 00/21] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Thu, 06 Aug 2026 19:02:06 +0200
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XSzWrDMAwH8FcpOc/DluWvnvYeYwfXltdAm4S4Z
 Cul7z6nMBKGSdlRwvxk9NetyTS2lJv97taMNLW57btSCPGya8LRd5/E2lgaDXDQXIJi+dr1Q75
 mFr9YHFh7HsZ+ojN1l8xM9EDOxiRibIowjJTa7wf//lHqY5sv/Xh9TJvE3P119aY7CcaZ4sKiE
 xrA8bfQn07+0I/+NfTnZrYnWLzydNuD4kVDJumDD8akmicXTwvY9uTsBS1ISwWK25qHi2fgyf+
 weIkn9EiRjICap9YebnuqeA5RBSBrEEXN0//wdPE4iuicFy4g1Tyz9uy2Z4p3MBp58jYkrO7Pr
 jz5ZH+2eD6UOLxRxkI1X7d4lsttzxUPSBNqIZWs5yH4Gnx20Hy+GIsedJBcRv1XvN/vP/EPrLu
 dAwAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15761;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=OKBQXxWBoztrhVdPd0Io+zSfgbjrwwSHMA+7HlW2e2o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viD472uDQUewrvOxgS96C5Ndx69R/g0Hb
 32gNJOGM7O0i4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qaGMAP/2Dxvih6KWQ/EkD8QnQGsw9UDp6SxZGLLeG+sAqBpJp6pZOi+OHs2nzk70RrL5F96Ns
 TpffDBS/FGkxGBV0nz9JjQ4Hcw0t5zrkaJTy5EnNuU0JeXyhPpClxF8Uq76W6qEt3jlOiZSdp+m
 PUMTfnBx+ckYBKizeczqpdKQfCuteof3QU7xYvbXOeuD5y/DKfMaJzf1/vUvOOS/oMtze+rUS+z
 Bfg1CsNyxisZxUkm0RvG6IjBQP21mZVkkYeYiJpp8JbRt2zlg52cIcHATRJtwggz0Zk5UjqWhxd
 SApurVSt5XUXeH/+M9xMIzsjPGh3jJOH2p2dP8TajvgCiIhV5APa7r7PddY3vf97XIKR8BpgpBd
 s9+kZkjtwXoIKB/5bdzKp1D8pFRSIDrGsdBXTSgziT6phakLmm7Ww1QhH2HgJbxMFnWc4zJIEOe
 3x4jIufj3sSXzYITyrcJKGJrn2yu13zp2sbNweieWiXo2g/kOnnKXW9jDuqV+VmQeOgjjAF0rRO
 GfUZJK81HTOfGSmHIZ3HwtMOq9ODp5nM49ZbPo4kpSHq0g5sDBRXDB7UzLNs+f6SA0PUibZFH2P
 bPIYfEBavG7ePAybOoN9zcodfI0CocXvt6SCBkf5Wos5sTc9zWNWmeFtarXtE0ZZlUPs53OKiNh
 7wMcH0ZjBOnoF53h8pQ0lmg==
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

Changes in v11:
- Link to v10: https://patch.msgid.link/20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com
- Move IRQ enablement slighty from before AUX bridge registration to directly
  afterwards in case there is a DP AUX related spurious interrupt
  (Sashiko)
- Cleanup SDP registers if there is an error in __dw_dp_audio_enable()
  (Sashiko)
- Clear XMIT_ENABLE in error handling of dw_dp_link_enable() (Sashiko)
- Move code to get next bridge to probe function, as it involves
  -EPROBE_DEFER; my previous change accidently broke modular build (Sashiko)

Changes in v10:
- Link to v9: https://patch.msgid.link/20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com
- Rework IRQ handling, so that the IRQ is enabled on bridge attach,
  dropping the patch introducing devm_work_autocancel() as that
  happens manually now during bridge detach (Sashiko)
- Update Fix error handling in dw_dp_link_enable(), so that it also
  ensures incorrect cleanup in dw_dp_link_disable(). While this kind
  of does two things now, it is one logical change and thus kept in
  one patch (Sashiko)
- Simplify IRQ handling in runtime PM patch and fix bisectability
  issue with runtime PM patch for generic bridge code applied, but
  runtime PM patch for Rockchip not yet applied
- Use 64 bit variables for matching the controller addresses, which
  is cleaner and future proof (Sashiko)
- Move all of the code previous patch versions added to dw_dp_bind
  and dw_dp_unbind to the bridge_attach/detach callbacks instead,
  which keeps dw_dp_bind nice and clean. It means that everything
  is properly initialized once the bridge has been attached.
- v9 got a Tested-by from Igor Paunovic <royalnet026@gmail.com>
  for RK3588 based Orange Pi 5 Plus (USB-C DP AltMode). I'm not
  carrying this over as quite a few patches changed due to the
  latest Sashiko feedback, even though I don't expect any
  regressions.

Changes in v9:
- Link to v8: https://patch.msgid.link/20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com
- Add yet another patch, which fixes missing resorce cleanups when
  dw_dp_link_enable() runs into errors (Sashiko)
- Acquire audio_lock guard in dw_dp_audio_mute_stream (Sashiko)
- Ensure dp->bridge.dev is set in dw_dp_hpd_work (Sashiko)
- Error out if hardware returns more bytes then requested by
  DP AUX transfer (Sashiko)
- The other Sashiko problems reported on v8 are false positives
  as far as I can tell

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
      drm/bridge: synopsys: dw-dp: Fix error handling for DP link enablement
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
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 792 +++++++++++++++++++--
 drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 190 ++++-
 include/drm/bridge/dw_dp.h                         |  13 +-
 include/drm/drm_bridge.h                           |  14 +
 6 files changed, 915 insertions(+), 109 deletions(-)
---
base-commit: 559b757a7122a2ead2e200cc735b008dfc074266
change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

