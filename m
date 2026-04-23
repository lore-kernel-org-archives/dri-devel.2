Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BEAF99368
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E87D10E314;
	Thu, 23 Apr 2026 10:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cpc60Y16";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4811310E314
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 824FF60052;
 Thu, 23 Apr 2026 10:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0C5C2BCAF;
 Thu, 23 Apr 2026 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938838;
 bh=QXWXZQEXsf4MFpPvgRFfqvij9UUVaI2oohuViiAF3Gk=;
 h=From:Subject:Date:To:Cc:From;
 b=Cpc60Y16f3BR+lnWvhrPEdQqdmMBR57UY1rZ/YxrffX/mDsUV+4h5wNX7Q9LYskqP
 YRjOoLKYX9WYFq6P6x9UDNHyL1YLwFPDIFgc+ZWzx1o7P5yZZWDoV4FeKp/U2rAh5h
 qaLlqKjacAA6U18Ma8ZkGIkiJjgXRor2Eg5+1sSje/JiwZIXfLnRxbyy8NghPU7/KM
 lrFaWaxIZR0akefRnwcY2gUnw6dU+wOPabfnWNLZY9jYk4PqSF9kKZWyaPqWWwdOUK
 zurjRwPisx6XN5qDFnbdiQLISWC3Uu9UXTWp7fI+CQYbEqAcwdgkptdhMoWU8u31XN
 Hi19mXqxrFCEA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/28] drm: Implement state readout support
Date: Thu, 23 Apr 2026 12:06:38 +0200
Message-Id: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PwW7DIBBEf8Xi3K0WME3iU/+jyoHA2lm1hhSIl
 SryvxfjQy89rWY180bzFJkSUxZD9xSJFs4cQxXqpRPuasNEwL5qoVAZPGgEn2bIxRaCRNbHewG
 JxxGPJyedRlFzt0QjPxrz47zrRN/3ii77849ci1C9oZY7d46ewMUw8gQcuKJJjkZdDr3xOCxqo
 19s3jzzzGXoWoizg0CPAhsLsK9XbL1XziWmnzZtka24rTih+mfFIgFB9tYbLY23enz/pBTo6zW
 mSZzXdf0FtpnJ6CsBAAA=
X-Change-ID: 20250730-drm-state-readout-108f089c1c30
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8295; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QXWXZQEXsf4MFpPvgRFfqvij9UUVaI2oohuViiAF3Gk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv39vNCmeIcTPqPb5z8qyZswITTk99Ufju/LW2i4+WP
 smdeTjzRsdUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYiMFqxoaLczQZbx5yOJ/K
 /iY6Ycn+SBn37/MlTrzL5Z0588qfkHTPnv0HZykL3CqoDnP8rpGsP4Ox4er9/88FJkSe0ha57zl
 t5bk7BkWHYxfcuyarLtY86exez9mzWZyuX/Tyvsv04t7cC0EnQwE=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Hi,

Here's a series that implement what i915 calls "fastboot", ie,
initializing the initial KMS state from the hardware state at boot, to
skip the first modeset if the firmware already set up the display.

This series creates the infrastructure in KMS to create that state by
relying on driver specific hooks. It also implements some infrastructure
to check during non-blocking commits that the readout helpers work
properly by reading out the state that was just committed and comparing
it to what was supposed to be commited.

This relies on another set of driver hooks to compare the entities
states, with helpers providing the default implementation.

It then implements the readout support in the TIDSS driver, and was
tested with the SK-AM62 board. This board in particular is pretty
interesting, since it relies on an DPI to HDMI bridge, and uses the
drm_bridge_connector infrastructure.

So the readout works with the current state of the art on embedded-ish

It's now in a much better state than the v1 was, but there's still some
notable things broken: 

  - Bridges do not read their input and output bus formats and flags

  - The tidss_crtc_state fields are not read properly at the moment
    either.

  - It looks like, when left unattended, we get some atomic_flush
    WARN eventually, maybe because of something broken around
    hotplugging and the monitor shutting itself down?

  - If readout is disabled for any reason, the hardware isn't reset
    anymore.

The main thing works though: the state is picked up properly, doesn't
trigger a modeset if what was programmed is the one the first modeset
tries to pick as well, will switch properly if it isn't, etc.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Get rid of patches already applied
- Rebase on top of the current atomic_create_state work
- Use the SRO prefix everywhere
- Create our own states container structure instead of trying to plumb
  it into a drm_atomic_state
- Make a lot more use of helpers
- Add a hook to enable the hardware resources when the readout state
  becomes active
- Move all the tidss readout code into tidss_dispc.c
- Write documentation
- Add drm_private_obj and drm_bridge name for easier debugging
- Add drm_private_obj_is_bridge()
- Link to v1: https://lore.kernel.org/r/20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org

---
Maxime Ripard (28):
      drm/atomic: Fix unused but set warning in state iterator macros
      drm/atomic_helper: Skip over NULL private_obj pointers
      drm/atomic_state_helper: Remove memset in __drm_atomic_helper_bridge_reset()
      drm/atomic: Convert drm_priv_to_bridge_state to container_of_const
      drm/atomic: Add drm_private_obj name
      drm/bridge: Add drm_private_obj_is_bridge()
      drm/bridge: Implement atomic_print_state
      drm/atomic: Export drm_atomic_*_print_state
      drm/atomic: Only call atomic_destroy_state on a !NULL pointer
      drm/atomic_sro: Create drm_atomic_sro_state container
      drm/atomic_sro: Create kernel parameter to force or disable readout
      drm/atomic_sro: Add atomic state readout infrastructure
      drm/atomic_sro: Add function to install state into drm objects
      drm/atomic_sro: Create documentation
      drm/bridge: Handle bridges with hardware state readout
      drm/mode_config: Read out hardware state in drm_mode_config_create_state
      drm/atomic_sro: Provide helpers to implement hardware state readout
      drm/atomic_helper: Pass nonblock to commit_tail
      drm/atomic_helper: Compare actual and readout states once the commit is done
      drm/atomic_state_helper: Provide comparison macros
      drm/atomic_state_helper: Provide atomic_compare_state helpers
      drm/encoder: Create atomic_sro_get_current_crtc hook
      drm/bridge: display-connector: Implement readout support
      drm/bridge_connector: Implement hw readout for connector
      drm/tidss: dispc: Improve mode checking logs
      drm/tidss: Implement readout support
      drm/tidss: encoder: Implement atomic_sro_get_current_crtc
      drm/bridge: sii902x: Implement hw state readout

 drivers/gpu/drm/Makefile                           |   2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   1 +
 .../drm/arm/display/komeda/komeda_private_obj.c    |   8 +
 drivers/gpu/drm/bridge/display-connector.c         |  15 +
 drivers/gpu/drm/bridge/sii902x.c                   |  56 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |  31 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |   1 +
 drivers/gpu/drm/drm_atomic.c                       |  46 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  46 +-
 drivers/gpu/drm/drm_atomic_sro.c                   | 854 +++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_sro_helper.c            | 677 ++++++++++++++++
 drivers/gpu/drm/drm_atomic_state_helper.c          |   3 +-
 drivers/gpu/drm/drm_bridge.c                       | 133 +++-
 drivers/gpu/drm/drm_internal.h                     |  12 +
 drivers/gpu/drm/drm_mode_config.c                  |   5 +
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   1 +
 drivers/gpu/drm/tegra/hub.c                        |   1 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  93 +++
 drivers/gpu/drm/tidss/tidss_dispc.c                | 332 ++++++--
 drivers/gpu/drm/tidss/tidss_dispc.h                |  14 +
 drivers/gpu/drm/tidss/tidss_encoder.c              |  37 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |   6 +-
 drivers/gpu/drm/tidss/tidss_plane.c                | 154 ++++
 drivers/gpu/drm/vc4/vc4_kms.c                      |   3 +
 include/drm/drm_atomic.h                           | 144 +++-
 include/drm/drm_atomic_sro.h                       |  59 ++
 include/drm/drm_atomic_sro_helper.h                | 275 +++++++
 include/drm/drm_bridge.h                           |  87 +++
 include/drm/drm_connector.h                        |  69 ++
 include/drm/drm_crtc.h                             |  69 ++
 include/drm/drm_encoder.h                          |  18 +
 include/drm/drm_mode_config.h                      |  18 +
 include/drm/drm_modeset_helper_vtables.h           |  23 +
 include/drm/drm_plane.h                            |  69 ++
 39 files changed, 3255 insertions(+), 113 deletions(-)
---
base-commit: ea61048876a7137897da26dac49ee234fb38a35a
change-id: 20250730-drm-state-readout-108f089c1c30
prerequisite-change-id: 20260310-drm-mode-config-init-1e1f52b745d0:v2
prerequisite-patch-id: 8831e320ca55e930e6dd8db8abfd2a79179fc1a0
prerequisite-patch-id: 5d2ae478dfb0a8b1eed30431b52a63141f1a3edb
prerequisite-patch-id: be3ef2f85cc3bba3ce65cbe4c1bf73b26c59b46c
prerequisite-patch-id: ad4de3b4f7bf5861d8e74d15042fb1d17cf6f071
prerequisite-patch-id: 6af92ef1aef1541ba0c504c3618612a89f5433a4
prerequisite-patch-id: d7b9200d7155e7ae2a76121adb50ce974aa78ddc
prerequisite-patch-id: 811a936fa6b38549807256e718b4c1faf49e90dd
prerequisite-patch-id: 3816a4bdc28e3353dba2811cc82d6680cf9ada11
prerequisite-patch-id: e156096dae812cab909877d7d614f56374652c6a
prerequisite-patch-id: fa0187e85c3587e7b28e411f2198b7c070793fbb
prerequisite-patch-id: f97b4088a1357121e4b35c4822839e45d952cba9
prerequisite-patch-id: 2e942d5540fc208b0c94f9f9215f85cc59dd6c1c
prerequisite-patch-id: 45ce20ef439a538b6c71c7aedb251bd62c882a11
prerequisite-patch-id: 86674e487ba650461e29c284308ff9ba321a48e4
prerequisite-patch-id: 1d7744840555f74f310c1d48642bfc755ac645c9
prerequisite-patch-id: b01716030f5f9b3cedb4a6096b2d4769f625741a
prerequisite-patch-id: 0372103622aa6006a3fe645b4c2eb2387d7d3b5a
prerequisite-patch-id: 24a0b772f6fc53c41892a37b52cba95bbd261ca2
prerequisite-patch-id: 80ec7eea600ad3be7b94a182e274695b7c5cf17f
prerequisite-patch-id: 273773ea001ab348b4e85b47b20b45f48d4c1cbc

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

