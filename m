Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE6EC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC5710F223;
	Thu, 23 Jul 2026 22:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="A8b3fP96";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9B910E604
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784845042;
 bh=RUtMlEUfhaNf38YYI4WXpmbfqI0K48+4M4M46EI0KR4=;
 h=From:Subject:Date:To:Cc:From;
 b=A8b3fP969HBYgHaxQUR/eqBfC2L/F3mfkzscQ7u25W6rJ1TCyztBYt7GOFW0htY/x
 t4A+Fjyo3gvviwhZ07fKZavR79kwQdmd7S6CkmaurLOS2UpqKArkqwY0fNUDnoEmqM
 0V/SP+o43wNXlPBGUFGmwr87pJDS+5tghJN6VqdsPODUuATyk3/zOomArqcHWRjNSR
 pcwwe9IPEgl48YoxXJm+80px0wHjyoK1LPQuu3xAMb4n3iHN9gTEaZXQ3TXVhuAnTn
 21AUhccfPRXtdBL3/AbcBZ33g6NLb9NGHtKsNPvw+r2Rks6nHQt+iQ7MZvM45zddCG
 LsvMwJHQsyn4Q==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 546A017E09AA;
 Fri, 24 Jul 2026 00:17:22 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0B15B480029; Fri, 24 Jul 2026 00:17:22 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 00/15] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Fri, 24 Jul 2026 00:17:08 +0200
Message-Id: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOzYrCMBDA8VeRnDdLMs1H68n3kD3EZLIGbFMSi
 Rbpu28qLAWRevwPw2/mQTKmgJnsdw+SsIQc4lBDfu2IPZvhF2lwtQkwUKwBSfM0xDFPmbobdSM
 N/ZhiwR6Ha6baGcCudZ47R6owJvTh/tSPP7XPIV9jmp7HCl+m/67adAunjErGW9FxBdCxg42Xi
 znFZL5t7MliF1i9urrtQfWcRu3VyVit/TuvWT3FYdtrFs8qjqqRIFn7zhOrp+HDf6J6nnlhBDr
 UHF69eZ7/AC3G6YS6AQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6803;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=RUtMlEUfhaNf38YYI4WXpmbfqI0K48+4M4M46EI0KR4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpikvGkkLYeEaBbYYD0n30c6/dGFtcRSfEaP
 DXlfVNe3MuKjIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqYpLxAAoJENju1/PI
 O/qaNPMQAIK8mrQ16xzuVeQQHVRJyBGXSMgCHZhv1Ndq7O5RhhHn7vcnnTiIkjPi04RMakkpTrv
 cvEkSucPnReHtXSHRdnCvAQLdahC79H3f4SNW90TwXsv8fdHASf6238RXsXA+NeQmL8OpG8ZQaN
 sxDOZuKGut3YFjn4Zl3B1STAF26/7FVqA/JJ1Q5nI3qp8gLUQkEQNhRAqu4ycjwZB3pDPHZUBKm
 Mi/M9rEAtpktuIzPS5kPYQBM6xLsjuCSHBFzGJsHNsKPm5wBzS+ew30cz0SuwFpDVPzkr5R2oaR
 fNsy4qTPwBc5lGRH+yjOsJOHLaecrYygoX9Iwx2Ob+iPDiUXOsODkuerU/73Pl8bAqFjVPKzvWr
 yyJZkjK8PwTps76awXpnB789ZMjma1bZe/yKrGCD5kpDEVwiZb7m7u1Wqw71jOjrwHLqsBtnFGR
 ea1c5A45Q1eWWfw2GLZEqorcvRyXVgIcoRXyCfytXIjmU2JXZiJAs59H4sMy9aPKLI7RejOMI3O
 4o1UGyn7ItUW1IRWb21qqANjDnTF01Sz0142c0CWJFo/MQYW3+4asUrLMcUW6pQlqqwSW5uDOkR
 ISiMAY3D9z8j0/jBb5D8S7jrhpzRzCO7xvwnZv1aE4Aqy7HcCFMsRRZNSInL3sB5YhskfqDfWHk
 u+1x705XWtOdFp5aZfNQt2Q==
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
Sebastian Reichel (15):
      drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callback
      drm/bridge: synopsys: dw-dp: Cancel pending HPD work on unbind
      drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal
      drm/bridge: synopsys: dw-dp: Move dw_dp_bridge_atomic_get_output_bus_fmts()
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
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 659 +++++++++++++++++----
 drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 235 +++++++-
 include/drm/bridge/dw_dp.h                         |  11 +-
 include/drm/drm_bridge.h                           |  14 +
 6 files changed, 789 insertions(+), 145 deletions(-)
---
base-commit: c182a2ae13886463f7ae36e034449477306d182b
change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

