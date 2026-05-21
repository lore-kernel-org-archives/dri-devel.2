Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575C6CD5BB1
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A8B10E1C3;
	Thu, 21 May 2026 14:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AXAuN/LH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F47310E1C3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:08:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8573B601F3;
 Thu, 21 May 2026 14:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5DE1F000E9;
 Thu, 21 May 2026 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779372525;
 bh=v6pz+456eDkr2FQPvFSRR5Zm+2d3QHcIeHy/+F7/GIk=;
 h=From:To:Subject:Date;
 b=AXAuN/LHgKQXitJblTejqzfp/TW2s8DKuf1RWxOgwQZdgU5WLsXHEHBvTjXvSt7Qq
 3/3NrbEdDlcx5LhRr5yIfxQe4KMI8CV0rODZZsBgjXj6PygyavDiRPQDOGPmLBiZG3
 juuClNd5lCcoF/QAOPpTr7V20yAYFx+9J4y4+EP61KGkPhJY7GwisIiZkr1ZBBokFe
 6uEgtAOWP0lW0QlL1LKK3Oa0OF7oOAMnniTHeJbCHR+VxGAJhl2qdUbPQh3FQaSLuY
 /B50IeIdMvbLiqnco3Q1qTpXyy8iGZXOF21mdXLJwvQs8hW/VC3r4KvBvnJmZM//SR
 KvSA6XxF101ng==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: David Airlie <airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 sai madhu <suryasaimadhu369@gmail.com>, Rosen Penev <rosenp@gmail.com>,
 Shivam Kalra <shivamkalra98@zohomail.in>,
 Abhishek Rajput <abhiraj21put@gmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: [GIT PULL] mediatek drm next - 20260521
Date: Thu, 21 May 2026 14:08:41 +0000
Message-Id: <20260521140841.5103-1-chunkuang.hu@kernel.org>
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
1. hdmi: Convert DRM_ERROR() to drm_err()
2. Simplify mtk_crtc allocation
3. mtk_dpi: Open-code drm_simple_encoder_init()
4. Convert legacy DRM logging to drm_* helpers in mtk_dsi.c
5. dsi: Add compatible for mt8167-dsi

Regards,
Chun-Kuang.

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git tags/mediatek-drm-next-20260521

for you to fetch changes up to 6428eaf0c1f39815b08d57054895c1934d5782f3:

  drm/mediatek: dsi: Add compatible for mt8167-dsi (2026-05-18 13:44:33 +0000)

----------------------------------------------------------------
Mediatek DRM Next - 20260521

1. hdmi: Convert DRM_ERROR() to drm_err()
2. Simplify mtk_crtc allocation
3. mtk_dpi: Open-code drm_simple_encoder_init()
4. Convert legacy DRM logging to drm_* helpers in mtk_dsi.c
5. dsi: Add compatible for mt8167-dsi

----------------------------------------------------------------
Abhishek Rajput (1):
      drm/mediatek: Convert legacy DRM logging to drm_* helpers in mtk_dsi.c

Luca Leonardo Scorcia (1):
      drm/mediatek: dsi: Add compatible for mt8167-dsi

Rosen Penev (1):
      drm/mediatek: Simplify mtk_crtc allocation

Shivam Kalra (1):
      drm/mediatek: mtk_dpi: Open-code drm_simple_encoder_init()

sai madhu (1):
      drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()

 drivers/gpu/drm/mediatek/mtk_crtc.c | 15 ++++++---------
 drivers/gpu/drm/mediatek/mtk_dpi.c  | 10 +++++++---
 drivers/gpu/drm/mediatek/mtk_dsi.c  | 28 ++++++++++++++++++----------
 drivers/gpu/drm/mediatek/mtk_hdmi.c |  4 ++--
 4 files changed, 33 insertions(+), 24 deletions(-)
