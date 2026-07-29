Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB96C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA03210EC1C;
	Wed, 29 Jul 2026 13:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SwNmoM8a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C644A10EC1C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:17:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AFB05600AB;
 Wed, 29 Jul 2026 13:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89C61F00A3A;
 Wed, 29 Jul 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785331025;
 bh=DevyNzk/0RjswZblIxZkdQSTJtX1K3UZCjo6NK2E/+s=;
 h=From:To:Subject:Date;
 b=SwNmoM8aUcgyFWR0l88ZUxsNAMlOpQPXNs3hk1Yn3Tv4T4x1Gj3ArSDRP7CT30QaC
 XSMm0asu2UAK/LWZ84oxdvweio2dvsmS3JFKYUX3Ot89uI3uXyKQg8LIYeZcJ6T45d
 c5S3uUX9qSNi6+99kOWaqkCokPj71n3yWypNcOA1gKheYuvrvuy7ew9itiErlIfhcc
 wpr/zd+1wEgEuJ6THboY7zdJbXjPSKyO7uygC69XuGsAM3qoV4mc8YONCMtuTrCxK0
 tbBSdbcW8rHKjlO6U5kfw5c429KMAj9hFuZyzvq0ZN21F+F0ZkZmbPGFPUM2ArGi9W
 +LwRoWhGBiGwg==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: David Airlie <airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Ruoyu Wang <ruoyuw560@gmail.com>, Guangshuo Li <lgs201920130244@gmail.com>,
 Johan Hovold <johan@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Myeonghun Pak <mhun512@gmail.com>
Subject: [GIT PULL] mediatek drm fixes - 20260729
Date: Wed, 29 Jul 2026 13:17:01 +0000
Message-Id: <20260729131701.4158-1-chunkuang.hu@kernel.org>
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
1. Check CRTC state before freeing
2. mtk_hdmi: Fix DDC adapter double put in v2
3. mtk_hdmi_common: take i2c adapter module reference
4. mtk_dsi: Enable HS clock only at pre-enable
5. ovl_adaptor: balance component registrations

Regards,
Chun-Kuang.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git tags/mediatek-drm-fixes-20260729

for you to fetch changes up to 533e3469a57996905cdb95f178e7efe38c21aeb2:

  drm/mediatek: ovl_adaptor: balance component registrations (2026-07-29 12:52:16 +0000)

----------------------------------------------------------------
Mediatek DRM Fixes - 20260729

1. Check CRTC state before freeing
2. mtk_hdmi: Fix DDC adapter double put in v2
3. mtk_hdmi_common: take i2c adapter module reference
4. mtk_dsi: Enable HS clock only at pre-enable
5. ovl_adaptor: balance component registrations

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dsi: Enable HS clock only at pre-enable

Guangshuo Li (1):
      drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2

Johan Hovold (1):
      drm/mediatek: mtk_hdmi_common: take i2c adapter module reference

Myeonghun Pak (1):
      drm/mediatek: ovl_adaptor: balance component registrations

Ruoyu Wang (1):
      drm/mediatek: Check CRTC state before freeing

 drivers/gpu/drm/mediatek/mtk_crtc.c             |  6 +++---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c |  7 ++++++-
 drivers/gpu/drm/mediatek/mtk_dsi.c              |  5 +++--
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c      | 11 +++++++++--
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c          |  8 --------
 5 files changed, 21 insertions(+), 16 deletions(-)
