Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB14CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BA610E4E9;
	Thu, 21 May 2026 13:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RKNoJ0KV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EBE10E4E5
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:56:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C45D43463;
 Thu, 21 May 2026 13:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD11F000E9;
 Thu, 21 May 2026 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779371813;
 bh=fgDyaoAaBVlG/7hkYJNhJI1L8SvN21kpP91Qx0GqPWQ=;
 h=From:To:Subject:Date;
 b=RKNoJ0KVGU9UO7B23Xm8sIkN5/Y5fiZz+DIOdurPZvERBCck8y+ak3+9fuH+HS0PU
 +C9s22ZtUliEhxbhausQ4Rem//CFD3PpoqKDQdo6zc/i+vacxfQMo0F2K0CBN6+xIy
 PEF4kKJQPeXPchfXBOu7P+I4Vx0YGcAvUyg1nqBYgHOgM/W56v8dbs5zdvtZuqjzmT
 jyVpypcx3+BAOemK/4ISQVZSx5NAlA8ATBDcwaBbLbRnJGbny6Pov2Y8hV/sfxT4Ru
 pNMa+EKLdJtLxEknHQqexh8EOZszUjsxyGYenqKzOpvEeVUMFnJXhhmkfAR85PEkQ0
 9jxWSHjTvM2tA==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: David Airlie <airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [GIT PULL] mediatek drm fixes - 20260521
Date: Thu, 21 May 2026 13:56:49 +0000
Message-Id: <20260521135649.4681-1-chunkuang.hu@kernel.org>
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
1. fix sparse warnings

Regards,
Chun-Kuang.

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git tags/mediatek-drm-fixes-20260521

for you to fetch changes up to 87ed4e845d5a90bba1a56c0a5c580a13982e8648:

  drm/mediatek: mtk_hdmi_ddc: Fix non-static global variable (2026-05-18 14:21:39 +0000)

----------------------------------------------------------------
Mediatek DRM Fixes - 20260521

1. fix sparse warnings

----------------------------------------------------------------
Louis-Alexis Eyraud (4):
      drm/mediatek: mtk_hdmi_ddc_v2: Fix non-static global variable
      drm/mediatek: mtk_hdmi_v2: Fix non-static global variable
      drm/mediatek: mtk_cec: Fix non-static global variable
      drm/mediatek: mtk_hdmi_ddc: Fix non-static global variable

 drivers/gpu/drm/mediatek/mtk_cec.c         | 2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c    | 2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c | 2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
