Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041D60A261C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=c8niFcga
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8843A10E3B0;
	Tue, 10 Nov 2026 00:13:48 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1957A10E211
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794269620;
 bh=lApNn9ftQIRdklWbhZaGVnlnFlExJxKsLG15awwZK8I=;
 h=From:Subject:Date:To:Cc:From;
 b=c8niFcgag22NiymGYDQ6J25q6JYsdkG7TR/O+fFhhUtdMEQZTVixWuZI4bBJfsgnO
 5mjknFUyyENH5M0M5y5nhY0fn7g/OKShBit9Hgscoq6GSw+eyY8aH0fUFhmObX1Pm5
 A8/TCEAkm67P+HpAB51HZnIh8bfwWlgxcy501/AQbXl3ZCjYMAdvDiIP6iUsnXK2pX
 4xVYIbXg20DvM5ahKqBzp+iPa8VVR2y/Qj18wTUJxBFtq3x/G/gZmvzGex/N2+WGAX
 CeaW0IxLnrpqak3At7EJ8zZNLD55aXG4uCPZAzWMKjNX1ZhH/lq5C1Oxc7ShUX3tKw
 ILDsrAnH+1Zpg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2824917E0036;
 Tue, 10 Nov 2026 01:13:40 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v4 0/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
Date: Tue, 10 Nov 2026 02:13:37 +0200
Message-Id: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NSw6CMBgE4KuYrq3pX1osrryHcdEXUgPUtNhoC
 He34IYY4nKSmW9GFG1wNqLTbkTBJhed73Ng+x3SjexvFjuTM6KElkAI4KQZ1r7rfI+jDrJT+Fg
 JRbkgtRSA8u4RbO1ei3m5fnN8qrvVwwzNjcbFwYf3cppg7v3zE2CCOVBBWEmgYuqsfdtK5YM85
 CaaPxJdKVBsKTQrkoEBbqEAabaUYq2wLaXIii6F4cJUvJL0V5mm6QPI2c6PVAEAAA==
X-Change-ID: 20261001-vc4-common-scramb-798b2580fa81
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Lucas Tanure <lucas.tanure@neat.no>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v4:
- Collected R-b tags from Dave
- Rebased series onto the latest drm-misc-next and followed the approach
  recently introduced in commit 81383bd290a1 ("drm/vc4: hdmi: enable
  scrambling before the TMDS clock starts"): scrambling is now enabled
  before the PHY is started, and disabled after the PHY is stopped
- Link to v3: https://patch.msgid.link/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com

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

 drivers/gpu/drm/vc4/vc4_hdmi.c | 365 ++++++++++-------------------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  30 +---
 2 files changed, 93 insertions(+), 302 deletions(-)
---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261001-vc4-common-scramb-798b2580fa81

