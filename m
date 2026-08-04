Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125B6C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7EBA10E034;
	Tue,  4 Aug 2026 20:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fxiFahnF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B82B10E034
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875719;
 bh=uU3+iRkaPyUYF5gaVFlEHBvB7HR+TBFtzOa7Ivlw1Hk=;
 h=From:To:Cc:Subject:Date:From;
 b=fxiFahnFTFU0u0S+aDFkIqlZwpI1Uo6cXLNC7srnqZp/8SGymTqifAPEgSS+0wDfK
 fu8vHJiOU66Eb4qk7jEKk3Fs4TWzW1EEb6DqKJjqQwpjFA03hdgHeWm0jYqAf6TLoB
 6gL3nNNpbIPaz/SyKt5lxpYFq1tKEp6JFReiJoT+gPQFDCwLAm0ro+amp3nWLiiGpR
 nCncGcSFIdmign57tY2lKK5DisX8WprThbo/drt6WPdvCbGcxXABgVAlzOX1iunv5q
 PWZvGoVeZABF4IS1NUDAN0DmOHG6REgPaNkrEPcfSLvPJPNHcJ7ts7wCNn6dtwQzPY
 Myja8nRuF9hQA==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AE74917E0892;
 Tue, 04 Aug 2026 22:35:14 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] drm/vkms: improve color curve LUTs precision
Date: Tue,  4 Aug 2026 17:33:40 -0300
Message-ID: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently VKMS only supports uniform LUTs. Besides the userspace
provided LUTs, it also represents color curves with LUTs, as it can't
simply implement the continuous curve formulas (floating-point would be
required).

This adds support to represent color curves with non-uniform LUTs,
improving the precision significantly. It also provides a script
that was used to create these LUTs.

The optimized LUTs use more samples in regions where the interpolation
and quantization errors are higher (usually in regions with a steeper
slope). The LUT generator script compares different strategies and uses
greedy subdivision, which outperformed the other methods, to generate
the optimized LUTs for VKMS.

Leandro Ribeiro (11):
  drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE
  drm/vkms: allow color curve LUTs to have different sizes
  drm/vkms: remove TEST_LUT_SIZE
  drm/vkms: remove linear_eotf
  drm/vkms: improve the way in which we access LUT member
  drm/vkms: rename struct vkms_color_lut::base to y
  drm/vkms: rename get_lut_index() to get_uniform_lut_index()
  drm/vkms: add support to non-uniform LUT for internal color curves
  drm/vkms: test sRGB and inverse sRGB LUTs using more samples
  drm/vkms: add script to create optimized LUTs for color curves
  drm/vkms: replace uniform sRGB LUT and its inverse with optimal ones

 .../gpu/drm/vkms/scripts/color-curve-lut.py   |  561 +++++++
 drivers/gpu/drm/vkms/tests/vkms_color_test.c  |   46 +-
 drivers/gpu/drm/vkms/vkms_composer.c          |  127 +-
 drivers/gpu/drm/vkms/vkms_composer.h          |    2 +-
 drivers/gpu/drm/vkms/vkms_crtc.c              |    4 +-
 drivers/gpu/drm/vkms/vkms_drv.c               |    2 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |   13 +-
 drivers/gpu/drm/vkms/vkms_luts.c              | 1469 ++++++++---------
 drivers/gpu/drm/vkms/vkms_luts.h              |    3 -
 9 files changed, 1383 insertions(+), 844 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/scripts/color-curve-lut.py

-- 
2.55.0

