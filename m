Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7644C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1B810E510;
	Sun, 27 Sep 2026 14:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HJWlY62k";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5679810E4E5;
 Sun, 27 Sep 2026 14:56:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 080FB42A5F;
 Sun, 27 Sep 2026 14:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2031F00893;
 Sun, 27 Sep 2026 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790520968;
 bh=iU5SiVe9iB5i+kPG90oa4hLYEVkiZAW5YzZdAQv2iEI=;
 h=From:To:Cc:Subject:Date;
 b=HJWlY62kgaKtabBg26a0ZeZ3VETWppdf2HHOz0t7z0UZ+TCZMUDG6vafOHrErhXDk
 SB4xh3w3mgcZx83FwItDL60y6trkhbAK2nZdw8URXz5tpWbMzAlAILaAXlHyg/GYa6
 Tmw29e8XfaXVKTEdP75fs34a65pUn5cpjfRog6ghIgT9aZN5ndIKBYPvvcJsJ4Q41s
 Y0/3Aqi6Mb/orjhgmrbl4ut3sRew6gWugis5Fl06ajs0BbjGxD6oHkvI8hgHqEbpNJ
 07216lHUg4MWog3Gmjr/SvpjvRzskLKFKePL+jWDijVxwV2UvKG0A0Tr6GzpcJt/vd
 +z4gRznVRyf7Q==
From: Imre Kaloz <kaloz@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/radeon: Sun XVR-300 support on sparc64
Date: Sun, 27 Sep 2026 16:55:03 +0200
Message-ID: <20260927145505.16883-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
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

These two patches get radeon KMS working on the Sun XVR-300, a
FireMV 2200 PCIe (RV370) board, in sparc64 hosts.

Patch 1 fixes an Oops that any posted radeon card on sparc64 hits in
igp_read_bios_from_vram(), which dereferences an ioremap() cookie to
check the VBIOS signature. It is tagged for stable.

Patch 2 adds a legacy connector table for the XVR-300, which has no
COMBIOS for the driver to parse, so both DVI-I outputs are found.
The XVR-300 needs both.

Tested on a Sun Ultra 45 with an XVR-300.

Changes in v2:
- Read the signature with readb() before the allocation instead of
  checking the RAM copy, as radeon_read_bios() does (patch 1).

Imre Kaloz (2):
  drm/radeon: Read the VRAM VBIOS signature with readb()
  drm/radeon: add a connector table for the Sun XVR-300

 drivers/gpu/drm/radeon/radeon_bios.c    |  6 ++-
 drivers/gpu/drm/radeon/radeon_combios.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/radeon/radeon_mode.h    |  3 +-
 3 files changed, 58 insertions(+), 2 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.47.3

