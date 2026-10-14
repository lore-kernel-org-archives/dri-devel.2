Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0159FCC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EADB210EA5F;
	Wed, 14 Oct 2026 01:03:39 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF9010E32F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791939807;
 bh=WvPItw4ATdEKsSmR4uqtDUqDXPtKo9G02eA2Ak/xLBo=;
 h=From:Subject:Date:To:Cc:From;
 b=ZST+eA1L+ZoQqgOEC0PJXwQcbI2OKDm5VqEJ5SpNcS1p0X+b1P0SEQrsqjooBYEig
 5maLTiYuJp/bD0ZKpF8sWcB9k5BKmAo8sawpzA3+/KwTgvOB96YVhHmtmqaZW5b3GV
 /tG1SdSY6bCCttd4WxshxU1NyQUOMPFY2eu5bkry9t30yN+xwDrmn5Qjuj+UG3IEjb
 O1rJwkTxPavqvOWvraypOujFro2jVme/7j/Rdu3ipYkAMjA7FOL/GIzcYyeIlvxpOb
 CR3BFt87V5CupJQkuv65Ixpkp3IfqcuODDtOPNLNuONeLTSMj/4uqo47NqUYaf8u7D
 N2f+ZM4joexog==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9F73317E0099;
 Wed, 14 Oct 2026 03:03:27 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
Date: Wed, 14 Oct 2026 04:03:07 +0300
Message-Id: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBQE0KsY1mL+p7RSV97DuABKLaYtBirRN
 L27UDfGGJeTzLyZSTDemkAOm5l4E22wbkyh2G6I7uR4MdQ2KRMGrEIApFFzqt0wuJEG7eWg6L4
 WipUCWimQpN3Nm9Y+VvN0fudwV1ejpwzlRmfD5PxzPY2Ye//8iBRoiUwArwBrro7a9b1Uzstda
 pL8EdmHgsUvhSVFcmywNFigbL6VZVle9fDB8Q4BAAA=
X-Change-ID: 20261001-vc4-common-scramb-798b2580fa81
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
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

This series includes patches 42-48 from "[PATCH v11 00/74] Add HDMI 2.0
support to DW HDMI QP TX" [1], which convert the VC4 HDMI driver to the
common HDMI 2.0 scrambling infrastructure as a proof of concept for
reusing the shared code.  It adopts the shared TMDS character rate
constants, switches to drm_hdmi_mode_needs_scrambling() and force_ctx(),
fixes -EDEADLK handling, and replaces the driver-local scrambling
implementation with the common SCDC scrambling helpers.

The infrastructure patches have been merged and there are no remaining
dependencies, so the vc4 patches are now sent as a separate series,
rebased on top of the latest drm-misc-next.

Tested on a Raspberry Pi 5 Model B Rev 1.1 (BCM2712 D0).

[1] https://lore.kernel.org/all/20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v3:
- Added new patch "Clamp CEC clock divider to its register field width"
  to prevent CEC register corruption after raising the BCM2835 max
  pixel clock to 165 MHz (Sashiko)
- Moved these new patches towards the end of the series to make them
  easier to revert if necessary
- Link to v2: https://patch.msgid.link/20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com

Changes in v2:
- Added new patch "Bump BCM2835 max pixel clock to 165 MHz" (Dave)
- Simplified the last patch "Defer pixel clock validation to HDMI
  helpers" by dropping the now unneeded adjustment of
  supported_tmds_char_rate in vc4_hdmi_connector_funcs_hdmi12
- Rebased series onto latest drm-misc-next
- Link to v1: https://patch.msgid.link/20261001-vc4-common-scramb-v1-0-51280460194b@collabora.com

---
Cristian Ciocaltea (9):
      drm/vc4: hdmi: Use common TMDS char rate constants
      drm/vc4: hdmi: Switch to drm_hdmi_mode_needs_scrambling()
      drm/vc4: hdmi: Switch to .force_ctx() connector helper
      drm/vc4: hdmi: Propagate -EDEADLK to the top level
      drm/vc4: hdmi: Convert to drmm_connector_hdmi_init()
      drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure
      drm/vc4: hdmi: Clamp CEC clock divider to its register field width
      drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165 MHz
      drm/vc4: hdmi: Defer pixel clock validation to HDMI helpers

 drivers/gpu/drm/vc4/vc4_hdmi.c | 369 +++++++++++------------------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  30 +---
 2 files changed, 96 insertions(+), 303 deletions(-)
---
base-commit: 3e32932d3626d0279f9b3531bd648f8c0a16cb08
change-id: 20261001-vc4-common-scramb-798b2580fa81

