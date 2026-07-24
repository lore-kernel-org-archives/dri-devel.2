Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768E4C53219
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7175010E06A;
	Fri, 24 Jul 2026 18:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="I+sPt2HQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A0010E058
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=EcejkUrarGntcrHCIx4p1/Nx0juW0RCAA7AXjrlSExg=;
 h=From:Subject:Date:To:Cc:From;
 b=I+sPt2HQf55UYmIlatgldViFyEGDX+QNYX5J8DlvlTeXAt+yxfOsfC53ygbMA9bCW
 G7vF/RyTiQG7dSsDUzF6/0AjJTQTvqkLpNDkfSUAoJAhLb5cbF+0k2aETfxCW/V8x9
 RviqSKSGg4Ahtc/tsYysAFyw/b0vk77lvdTvJnPAMPLkIHsB3HM3FfF0Z+NBfB1WwZ
 KShRVptYZybV0UvDCj0MHP1PtP/UMTO9kq6G68V4A8UYFwnyBPhKTf68GewRk+H9CV
 V0fnVSGvN/XArfS/QueKh30A6YeVv6rknlOEIDUrFoabQOAqygfjL6da0e3TNWhKXO
 L2yq1Pg/VjgSQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3367117E022A;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id DAAC1480029; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 00/16] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Fri, 24 Jul 2026 20:03:22 +0200
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOwWrEIBCA4VdZPNeik1GTnvoepQdXx66wiUGXt
 GHJu9cslJQS0uM/DN/MnRXKkQp7Od1ZpimWmIYa+unE3MUOH8Sjr81AgBYNKF7mIY1lLtx/cj/
 y2I85TdTTcCvceAvUtT5I71kVxkwhfj30t/fal1huKc+PY5Ncpz+uPnQnyQVXQrbYSQ3QiVeXr
 ld7Ttk+u9Sz1Z5g8+rqsQfV84ZM0GfrjAl7XrN5WsKx16ye05J0o0CJds/DzTPwz39YvSACWiR
 PRsKep357eOyp6nWIygG1BlH+9ZZl+QaPAKWaCgIAAA==
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7947;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=EcejkUrarGntcrHCIx4p1/Nx0juW0RCAA7AXjrlSExg=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPB+ZeGd4TeKSIIyTHK89PEgr/PftANiy
 lavRf8u8zlFYokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qavMMP/0quMX2x3YdBz2n9pB3Kzl3prBSwfFSehKfASaWuunhXZ4DJbFRTNpniSiNw0Xbuw0b
 NfmE0b/5mDoll7gzK3vdkmSFhYpuGUj8/iGTpP977OpYc4Cabb7/do3p2/2D+PBVyOiWWhlnURX
 euK3uYtjaQI1Rd+MUOdeyFN97wrDhHxBky9+IX+Vky5YPUoiHGzB/kpwZmEBeKsXq++szDWH962
 NtAhb344mmkuJVSr/xxkpF41bqlc/kRVToBax6MwAmXkJmGz5m3r4n4u0UXCnXIrQ0CpK/ojKpl
 1Wf6H4gjvEXgFAwf04tBT/IN/Tmm563QGAyRh6FJKc9I1l7RWUZ0ZsIUMRLoJLTxaH58qT/ws3V
 uXuEEj0jI3uT1Ayw4cMGm6KDvg382cPPemqpYJnSNl/VX8/yKeJMl4uSSyxC0c/nDMbRtCo5KT4
 BSlxfajuoW0SABLyXt78/RJGRaH4TeWopUeqdHDuZ3+HvVneaiNpkXTQQqEjF+JKqphyPO5KGJs
 9/1DJGmUaCH7tnoRL1TIo0xrRxenhW8EuAUXB2zGTSZWGrah/lMrD9qo8ou5s8Jb5p2q5NLI0br
 9QzSJPaB31BFzX3RdYGBFSgfCFiUwF9UAVNp46XlzKnFujRFg1bTSHv0FSxEZ8Xd8BX987XR0xj
 tgMAeUEUkydE0gbPbZ5A6yA==
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
Sebastian Reichel (16):
      drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callback
      drm/bridge: synopsys: dw-dp: Cancel pending HPD work on unbind
      drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal
      drm/bridge: synopsys: dw-dp: Add missing reinit_completion
      drm/bridge: synopsys: dw-dp: Free output_fmts when none are valid
      drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED
      drm/bridge: synopsys: dw-dp: Add follow-up bridge support
      drm/bridge: Add out-of-band HPD notify handler
      drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD
      drm/rockchip: dw_dp: Implement out-of-band HPD handling
      drm/bridge: synopsys: dw-dp: Add Runtime PM support
      drm/rockchip: dw_dp: Add runtime PM support
      drm/bridge: synopsys: dw-dp: Protect sdp_reg_bank from concurrent access
      drm/bridge: synopsys: dw-dp: Use regmap_set_bits in dw_dp_send_sdp
      dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells
      drm/bridge: synopsys: dw-dp: Add audio support

 .../bindings/display/rockchip/rockchip,dw-dp.yaml  |   9 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 607 ++++++++++++++++++---
 drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 219 +++++++-
 include/drm/bridge/dw_dp.h                         |  11 +-
 include/drm/drm_bridge.h                           |  14 +
 6 files changed, 762 insertions(+), 104 deletions(-)
---
base-commit: c182a2ae13886463f7ae36e034449477306d182b
change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

