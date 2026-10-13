Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BFFCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A7810E8A2;
	Tue, 13 Oct 2026 15:24:19 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8226F10E8A2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:24:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9CE251A1203;
 Tue, 13 Oct 2026 15:24:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 607EC60362;
 Tue, 13 Oct 2026 15:24:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D96511D716D0; 
 Tue, 13 Oct 2026 17:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791905044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=II89p1/CaHa/QDRUunppqOGjp6XPh18gWZeTksDa6tA=;
 b=j4shkthP7zf9MpmOJX6+E0GedWVcq/X2FW+dXsueWm0nNWq5Zli1cifAkxfWz2e2sn8ZGZ
 RYyZIzRsbKEPxnINrFWm57/xwXeRC2geFaUzM2WjeZmGAhxyk9reXjR1N0kJMzHjxcMhuN
 NiZzkP2tA3qs9bmKoxxC1jDjfj3WseRtw/yRW46bwLI1nHwbX9RxQ9oLN26dQigV0VzwZM
 HggbbgdyvhgnJiO6xkVKF6mRPb4jzDHhXdlN5DSaY4Sl5sJmGVQgo1YaoYTGyXIZ2P4Ftd
 7XbB6QLd/KtmPyQjGnEIZPYvvOnF51iBP5TPhD1Qua8KYmaOfjJ3mgd6Rf5tow==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 0/3] drm: remove deprecated *_of_get_bridge() from
 non-OF drivers
Date: Tue, 13 Oct 2026 17:23:53 +0200
Message-Id: <20261013-drm-fix-of_get_bridge-build-regression-v3-0-0b4c0b65be82@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OQQ7CIBBFr2JYiwFqauvKexjTADPUMVoM0EbT9
 O6Crlzq8iVv3p+ZRQyEke1XMws4USQ/ZKjWK2bPeuiRE2RmSqhatKrlEG7c0YN71/WYOhMIsmR
 GugIP2AeMJcHbxinlGi3BWpZj94D56j10PH04juaCNpV6Mc4Ukw/P9yeTLN7Po5PkgltrdlgLB
 VrDwXifrjRsrL+xMjup/8Iqh2vQ20pC42QjvsPLsrwA2mddQUkBAAA=
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Replace the deprecated *_of_get_bridge() calls with
of_drm_get_bridge_by_endpoint() for all drivers which be built without
CONFIG_OF.

Some of those drivers had a build failure for configs without
CONFIG_OF. This series used have fixes for those failures plus other
patches to convert all other such drivers to
of_drm_get_bridge_by_endpoint().

All the fixes are already applied, so since v3 there are only the
improvement patches not yet applied.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
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
      drm/vc4: dpi: inline vc4_dpi_init_bridge() into vc4_dpi_bind()

 drivers/gpu/drm/vc4/vc4_dpi.c | 41 ++++++++++++++---------------------------
 drivers/gpu/drm/vc4/vc4_dsi.c | 17 ++++++++++-------
 2 files changed, 24 insertions(+), 34 deletions(-)
---
base-commit: c1e2ea83145afeb5a693cff3b32c0e52b0608649
change-id: 20260929-drm-fix-of_get_bridge-build-regression-98f22f8a1dcc

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

