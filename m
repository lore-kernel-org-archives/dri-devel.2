Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096FCC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6208F10E373;
	Tue, 21 Jul 2026 17:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="frRhbVBA";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D07C10E373
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784656358;
 bh=mBRcyJ2IZ1f0GRAtYA85IIg0I8e5eYm3P2phDsUz730=;
 h=From:Subject:Date:To:Cc:From;
 b=frRhbVBAqT47DEV/ZzFdAO8JHwl2pAldSVYNZo9PqHIsQQfmvZZSV9zWd0DV9TEcm
 yOXhRPCdL7FGN8lKmv2f16nKZaMUR6sdBb4Y/DsCGzbhw+guBCGdjB9JbISn0m5t9d
 EOSWKbh1nGlIWZQ2c5ap6nzf6zVINWYgo1jH6EP36LBVXc+ej59SPVRMkKtPKbi5dT
 oTC5ffa0FI8SIK4GuHuSErtbCNm0Qvl72yubLtWeyfzof9umcRn+4A7ExaCqPEn3UU
 0KabZzg4JH5mRgakVBN/752DWBP6nUcL/Hm2JNu+AWo3xZ3gOjDxMBJ8e7Wt+FDORq
 wezEbtaX/mzgw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DF56F17E0851;
 Tue, 21 Jul 2026 19:52:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 94194480029; Tue, 21 Jul 2026 19:52:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Tue, 21 Jul 2026 19:52:30 +0200
Message-Id: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33N0QqCMBTG8VeRXbfYjrppV71HdDG3Yw7SyRYrC
 d+9KYQQ4eX/4/A7bxLQWwzklL2Jx2iDdUOK4pAR3anhhtSa1AQYCJZDScM0uDFMgZonNSO1/eh
 dxB6HR6DSKMC6Mi03hiRh9Nja16pfrqk7Gx7OT+uzyJf164pdN3LKaMl4VdRcANTsrN39rhrn1
 VG7nix2hM1Lp/seJM9IlK1olJay/eflmyc47Hv54mnBUeQllKz69eZ5/gAQvJrtagEAAA==
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
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4915;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=mBRcyJ2IZ1f0GRAtYA85IIg0I8e5eYm3P2phDsUz730=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpfseXsRyzy6CdS28+N3270IWLaVbXG7h5Na
 Lk0I7aCnffyZokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqX7HlAAoJENju1/PI
 O/qaA6AP/1WL0gv0PNhkm3D5w5edzN8CMmC8UDmz1aZpumBYnRl1jKcXF1864effACLauaFZGoR
 pQNXRN8pqOJcRF42P5qBLQWUEuSdA5pVYCtQdGEqSJ3du7JRonCPXGFJD5VRN4+6gJyczhPbi4T
 eYiYb2RunjNXoU0OJ1MMU12DcmE7U1o8MinfZPlp8MzfDA8JrqB+QI+ZNNRoCp5bo14HoX7Qa1P
 VfoBgjwn47Fb2mZkNOUJl9R18jQKgfuD8RzqlcYZiO9W6bS3xCe0Fkm2szn4Mk9TYfRnKXc6gVm
 WHMKVEp94zaha9qw0CHoDevgwAa62gQSAge0xkb/XqxKTTYSGJueYYYfDlRzKWmdh5qce+QzFei
 O3KcITCe+qHTVM4sqUWhGruapGN1mFh4oFXOF8C2asg/sFe4UiwdIQxGEeNtz5gII888jSBR2kn
 4Vk6KCLiLmcL8LaHUPo4ful12EPaRl0nfT+fp+ZzHWuTznuUQ33I1hLWMkChOBcHoKR88T65YBL
 PtAx6ir7bJwkoxI1kg7lEYAenmsbz/y9J/maaVZsmGOd3XBMpIxhj+BNat1s4kG4JUdOhq9dzHM
 7d3X5UnK+C5cZLvCXE8O217b8xbPIYJ09wZ8AJOdZgXGH/SsLpFtF3Cb2rs8QjipOijRG1dX4Do
 9gtjLl6Qs17vON7r4YIAtjA==
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

 1. follow-up bridges (PHY, USB-C connector)
    this is needed to get USB-C DP AltMode working; I've followed the
    Qualcomm driver as reference

 2. runtime PM
    the initial driver has been upstreamed without RPM; add it to
    avoid wasting power when nothing is plugged

 3. audio
    the initial driver has been upstreamed without audio support;
    this adds all missing bits for audio with single stream transport

To properly make use of the bridge code the following USBDP PHY series
is also needed:

https://lore.kernel.org/all/20260714-rockchip-usbdp-cleanup-v13-0-6cb3e769d4c5@collabora.com/

There are two parts, which possibly need some discussion:

 1. I added a dedicated bridge callback for out-of-band hotplug events,
    which is separate from the hotplug_notify. I have a feeling, that
    there might be a better solution, but haven't found it.

 2. The DT binding for audio support works perfectly fine, but is not
    really ready for MST. I don't intend to implement MST right now,
    but the binding should obviously take it into consideration to
    avoid breaking it in the future. I've put different options into
    the patch description and went with the easy one, which is easy to
    test.

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
Sebastian Reichel (10):
      drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callback
      drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED
      drm/bridge: synopsys: dw-dp: Add follow-up bridge support
      drm/bridge: Add out-of-band HPD notify handler
      drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD
      drm/rockchip: dw_dp: Implement out-of-band HPD handling
      drm/bridge: synopsys: dw-dp: Add Runtime PM support
      drm/rockchip: dw_dp: Add runtime PM support
      dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells
      drm/bridge: synopsys: dw-dp: Add audio support

 .../bindings/display/rockchip/rockchip,dw-dp.yaml  |   9 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 456 ++++++++++++++++++---
 drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 223 ++++++++--
 include/drm/bridge/dw_dp.h                         |  11 +-
 include/drm/drm_bridge.h                           |  14 +
 6 files changed, 629 insertions(+), 90 deletions(-)
---
base-commit: 7296004bd2ceb1284fb557399f0134361f8e34af
change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

