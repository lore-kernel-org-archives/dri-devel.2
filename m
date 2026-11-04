Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4EC606D80B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Mb0m5gtb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AEC10FBFC;
	Wed,  4 Nov 2026 13:26:44 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7F310E245
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793798796;
 bh=tUdDEAiaFjRC4R52x7ZZpG/WNolxCCZdODmyMwbG+9Q=;
 h=From:Subject:Date:To:Cc:From;
 b=Mb0m5gtbQ8W0i1gG+Gi2VDmN5z0aJvx30GMeRXDr+Fu/8Op9WEtZw35HDirQRltmv
 KJ6AbntWfrJ19z7fRMvTpeUMz5Hqz/yulCrpB5LwH6QCF7NPW1vB7lMdawasRRMzQB
 D6Cb8bEd6DPspcA4P3+4ib2KpcCSrBg3SXEWrK5GzS+xJpRhUD8c0pww+okF965YTA
 5FJnK4lWqSDJs4mPah+lFL/E/RZ8HwenhE1hI/NWHkKrISK5AG13s9Ah6KmeoV4UZa
 w7CTpHYazZfvIqOT9kk9FTpjaAlPsTr63zuUq7aKKCcQNQ655u54DNkVvNJ3a1a+hu
 mb40MwpvtgeZA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 26DA917E0163;
 Wed, 04 Nov 2026 14:26:36 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/3] drm/display: hdmi: Fix SCDC scrambling corner cases
Date: Wed, 04 Nov 2026 15:26:19 +0200
Message-Id: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kASjYVeRbqIyagjaCXTiiDe3
 aluPjw+7+0glJkEXsUOmVYW/swK9lFAHMLcE3JSBmdcba2pcEgTo8QUdXKYWux4I8GnN77ywZW
 1KUHlJdN1qNu8b5ZfO1L8/mtwHCeHFBLYegAAAA==
X-Change-ID: 20261104-hdmi-scdc-scramb-fixes-750545a23603
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, 
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

This series fixes a few corner cases in the scrambling helpers
introduced by commit d653818324ed ("drm/display: hdmi: Add HDMI 2.0
scrambling management helpers").

Patch 1 fixes a potential NULL pointer dereference in
drm_connector_hdmi_sync_scdc() reported by Smatch.

Patch 2 makes the SCDC resync logic rely on the committed state
(scrambler_needed) rather than the source-side scrambler_enabled flag.
The flag can be stale after a boot-time disable, which may cause a
spurious CRTC reset and flicker on non-scrambled modes.

Patch 3 ensures the sink's scrambling status is reset on non-scrambled
modesets.  Without this, a sink left scrambling by the firmware may
never be cleared if the first modeset uses a mode below 340 MHz.  The
reset logic is factored into a common helper, which only writes to SCDC
when bits are actually set.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (3):
      drm/display: hdmi: Prevent NULL pointer dereference in sync_scdc()
      drm/display: hdmi: Use committed state to decide on SCDC resync
      drm/display: hdmi: Reset sink scrambling on non-scrambled modesets

 drivers/gpu/drm/display/drm_hdmi_helper.c | 65 ++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 15 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-hdmi-scdc-scramb-fixes-750545a23603

