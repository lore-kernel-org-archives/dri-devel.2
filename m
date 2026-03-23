Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA7AF4613B
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E2910E17C;
	Mon, 23 Mar 2026 16:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nydTAJC4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B41F10E42D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:01:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C852542AC8;
 Mon, 23 Mar 2026 16:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC68C2BC9E;
 Mon, 23 Mar 2026 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774281698;
 bh=RFQsXbP247wVx26DFBXtP1Ex3otSybRZaG6QqYnjRrg=;
 h=From:To:Subject:Date:From;
 b=nydTAJC4ZplaqEyA+orC2kGx+dGT8b+CkLN1/MEuyGZT8HGVb7gtLLJfV3QO1r8ED
 wBdfNgwfq3uYzZJ8LyHpwPEADTXjVc67wxi1m4Gk1cG/APyXGd3NtmKTP8ru3xj1cH
 T0k5ABv3Yb6aBGuytwYmh6ppydWcG2Z532fg60jJPfHbMhHsiOGRD6tg7Kd2O9roEy
 cM7051vBbrwpnTnhFxm2Fwb5q7qSrCmSTsfNZ30bPsuyAjRxowPJRxGtAYvvL8c6dk
 thyEM9z7+yLtshXFR9DlEucak53jMY+mxzKylOpdAjXO2oEfSNKtSkZwAjh9S7simj
 PXiq35gt7W9Ug==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: David Airlie <airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: [GIT PULL] mediatek drm fixes - 20260323
Date: Mon, 23 Mar 2026 16:01:35 +0000
Message-Id: <20260323160135.39609-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hi, Dave & Sima:

This includes:
1. dsi: Store driver data before invoking mipi_dsi_host_register

Regards,
Chun-Kuang.

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git tags/mediatek-drm-fixes-20260323

for you to fetch changes up to 4cfdfeb6ac06079f92fccd977fa742d6c5b8dd3a:

  drm/mediatek: dsi: Store driver data before invoking mipi_dsi_host_register (2026-03-22 14:15:44 +0000)

----------------------------------------------------------------
Mediatek DRM Fixes - 20260323

1. dsi: Store driver data before invoking mipi_dsi_host_register

----------------------------------------------------------------
Luca Leonardo Scorcia (1):
      drm/mediatek: dsi: Store driver data before invoking mipi_dsi_host_register

 drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
