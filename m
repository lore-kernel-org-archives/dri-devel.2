Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213A4CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6308D10E0B6;
	Thu,  1 Oct 2026 23:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GlzJtnmQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE9910E0B6
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 23:49:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 376984024E;
 Thu,  1 Oct 2026 23:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1F81F000FF;
 Thu,  1 Oct 2026 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790898550;
 bh=HmpiWThhIwQxhjXwwmgGltuba7q8kNXWCmTWDNtMOxI=;
 h=From:To:Subject:Date;
 b=GlzJtnmQCPQKJT5LlLhS+GieQec5gTu8QqSjEvA+VWUnrcaLjoWm+sDudHgpOt1yE
 Nh3c3BrffdiYg3JFx0kg056W1Z5AA2p9+6jdmylakBX9f+k4+4CMjb0YTfrE4MS6xk
 sGTpwoQMZal3CSKFZnvZtAP5cCOTbePi0hcDBJSo/a7sIZI9rpX843/ryVjj+mzDnQ
 BeXonRsM4ReE9J4WIbkCOh0XNiejf+NC2OZcAV2WoNRQAJUDHPEFmnauTD0Qb9PC3E
 FF/4STexwd8qpRxgGB6ZhQv4DNtQW4TK43I7tWI9B4mMOw7ZWVGDtxepteUHWxmcoZ
 54w1NVvU0Wtlg==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: David Airlie <airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Haojie Li <lihaojie@kylinos.cn>, Julien Stephan <jstephan@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Guangshuo Li <lgs201920130244@gmail.com>
Subject: [GIT PULL] mediatek drm fixes - 20261002
Date: Thu,  1 Oct 2026 23:49:06 +0000
Message-ID: <20261001234906.14940-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.53.0
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
1. Add missing IS_ERR check for ovl_adaptor platform device
2. Fix VID_DOWNSAMPLE_CONFIG register offset
3. Fix pdev reference leak in mtk_drm_bind()
4. Fix runtime PM leak in mtk_hdmi_ddc_v2_probe()
5. Fix ovl adaptor platform device leak

Regards,
Chun-Kuang.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git tags/mediatek-drm-fixes-20261002

for you to fetch changes up to 048739be3e9cacae5301b68245668002fe6f0ce5:

  drm/mediatek: Fix ovl adaptor platform device leak (2026-10-01 23:06:43 +0000)

----------------------------------------------------------------
Mediatek DRM Fixes - 20261002

1. Add missing IS_ERR check for ovl_adaptor platform device
2. Fix VID_DOWNSAMPLE_CONFIG register offset
3. Fix pdev reference leak in mtk_drm_bind()
4. Fix runtime PM leak in mtk_hdmi_ddc_v2_probe()
5. Fix ovl adaptor platform device leak

----------------------------------------------------------------
Guangshuo Li (1):
      drm/mediatek: Fix ovl adaptor platform device leak

Haojie Li (1):
      drm/mediatek: Add missing IS_ERR check for ovl_adaptor platform device

Julien Stephan (1):
      drm/mediatek: mtk_hdmi_v2: fix VID_DOWNSAMPLE_CONFIG register offset

Wentao Liang (2):
      drm/mediatek: Fix pdev reference leak in mtk_drm_bind()
      drm/mediatek: Fix runtime PM leak in mtk_hdmi_ddc_v2_probe()

 drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 17 +++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c  |  4 +++-
 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)
