Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED828C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4121510E476;
	Sun, 27 Sep 2026 10:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nmz8+enm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A6810E469;
 Sun, 27 Sep 2026 10:56:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D9F440C13;
 Sun, 27 Sep 2026 10:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB57B1F000FF;
 Sun, 27 Sep 2026 10:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790506618;
 bh=gkTKHKcoXI8bgfYLSB7dIJg5NEUl5n0kJSeQ9AUuWU8=;
 h=From:To:Cc:Subject:Date;
 b=nmz8+enmdsrfhLdhPE/S7Kx2I+5/Wx0ppgIGYG918+3auH7kMVEKuQmc3bh1TFrPd
 GweOLw0sX9KpIu/S53c7zLQqbBetmHcL5R2lM2+8r4Pa+xiBLf7+hEpIQoMEFDVbrR
 888YyT7k5OKlXQgYW3N4RcMKf3L7Au5BICS2/jSrsLrgqPvWNs//3CeuVInCCdKRgb
 LInzFqoQLmHXOu6pykrUvj/Nxd35Y0ENTQWL2/ByQPrS4OBAgnUM9vXGiI3AX5aO00
 Fx3Jkvt3ZL1Ps+UlUNjx3aWVxUcnp57UaR/6bgf7fOjdfpRf7r/cKI3u+MtW0RhaiD
 w+Bk2eNuVF45g==
From: Imre Kaloz <kaloz@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/radeon: Sun XVR-300 support on sparc64
Date: Sun, 27 Sep 2026 12:55:53 +0200
Message-ID: <20260927105555.8771-1-kaloz@kernel.org>
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

Imre Kaloz (2):
  drm/radeon: Check the VBIOS signature after copying it from VRAM
  drm/radeon: add a connector table for the Sun XVR-300

 drivers/gpu/drm/radeon/radeon_bios.c    | 10 +++--
 drivers/gpu/drm/radeon/radeon_combios.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/radeon/radeon_mode.h    |  3 +-
 3 files changed, 59 insertions(+), 5 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.47.3

