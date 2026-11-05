Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CE606A332
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=J/m2smPl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BBA112320;
	Thu,  5 Nov 2026 10:32:24 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B0C10E263
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:32:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 25630C69156;
 Thu,  5 Nov 2026 10:32:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0FEB35FF85;
 Thu,  5 Nov 2026 10:32:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8CF7210328CE3; Thu,  5 Nov 2026 11:32:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793874735; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=hmdT52eLuIwW3ZDOzynxjAizzSCIRQqrpN8NCgGuytM=;
 b=J/m2smPlJiKaugGv+GfibVInNQZ9DrvHFURqVX6v2ZLf3y9dtOiipzvy/tKCit6O+r7EpC
 yB/VfoGnbwzheqgEMPyTbCE3WFsHsT6PflpLXqwpyjO+6unhBvuRMzSDQQwwu7wdt/kfpF
 SnFt0GigR5/rpCcXHHCBvp2ye7sN678bKBDLSO9E8ElhrlqExLwZwKv9k9OIEK8uxA7v/A
 2rLWu58aDHoYhh0deTdD9UifHE1VZqQexW4S/58T/Ya2t7Kx+jsHCxLoGaEDlYkS7i4TCu
 ob1whYbrFw9gNbDI9aNdGrT5m8SuazLLNGzHEJdxn3/NF+bXVG/F9PRR+XbQNQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v4 0/3] drm: remove deprecated *_of_get_bridge() from
 non-OF drivers
Date: Thu, 05 Nov 2026 11:32:04 +0100
Message-Id: <20261105-drm-fix-of_get_bridge-build-regression-v4-0-906ca343ac1b@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/53OQWrDMBAF0KsErasgjR1X7ir3CCVImpEzJbGK5
 JiW4LtXSiBQukm6/PDn/bmITIkpi7fVRSSaOXMcS2hfVsIf7DiQZCxZgIJO9dBLTCcZ+EvGsB9
 o2rvEWEruzEeUiYZEuRKyNwEgGKvRe1Gwz0Tl6jq0e7/lfHYf5Keq18aB8xTT9/WTWdfe06Ozl
 kp6716pU4DW4tbFOB15XPt4EnV2hv/BUOAObdtoNEEb9Rdu7rBWunkYbgqsXOuV6zaODPyGl2X
 5Aadc6pyiAQAA
X-Change-ID: 20260929-drm-fix-of_get_bridge-build-regression-98f22f8a1dcc
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Paul Cercueil <paul.cercueil@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Replace the deprecated *_of_get_bridge() calls with
of_drm_get_bridge_by_endpoint() for all drivers which can be built without
CONFIG_OF.

Some of those drivers had a build failure for configs without
CONFIG_OF. This series used have fixes for those failures plus other
patches to convert all other such drivers to
of_drm_get_bridge_by_endpoint().

All the fixes are already applied, so since v3 there are only the
improvement patches not yet applied.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v4:
- Fix bridge leak on rebind
- Add patch to simplify vc4_dsi_bridge_attach()
- Remove patch to inline vc4_dpi_init_bridge()
- Remove outdated comment
- Link to v3: https://patch.msgid.link/20261013-drm-fix-of_get_bridge-build-regression-v3-0-0b4c0b65be82@bootlin.com

Changes in v3:
- Patch 1: re-add comment, updated
- Patch 2: fix bridge reference leak in error path
- Patch 3: new patch suggested during v2 review
- Link to v2: https://patch.msgid.link/20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com

Changes in v2:
- Fix bugs in patches 2,3,4
- Fix removed function name in patches 5,6
- Mention lkp reports in patches 2,3
- Add review tags on patches not modified since v1
- Link to v1: https://patch.msgid.link/20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com

---
Luca Ceresoli (3):
      drm/vc4: dpi: stop using deprecated drmm_of_get_bridge()
      drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()
      drm/vc4: dsi: remove unnecessary intermediate pointer computation

 drivers/gpu/drm/vc4/vc4_dpi.c | 10 +++-------
 drivers/gpu/drm/vc4/vc4_dsi.c | 29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 18 deletions(-)
---
base-commit: f8d77e2376e2cb931111576b15827ee8a9c59e4f
change-id: 20260929-drm-fix-of_get_bridge-build-regression-98f22f8a1dcc

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

