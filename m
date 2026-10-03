Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9511ECA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 12:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A757910E0B5;
	Sat,  3 Oct 2026 12:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZyPDR5Um";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82DF10E0B5
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 12:25:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89A0743A97;
 Sat,  3 Oct 2026 12:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6891F1F0089B;
 Sat,  3 Oct 2026 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791030327;
 bh=0ZbbJm+lfh2Wh0Z0ij1lckp1wazeBCFcbooFUg1LvwM=;
 h=From:To:Subject:Date;
 b=ZyPDR5UmXxIZmEE9B2Te6W09Lcua4g6UAbX1SQ/0zCY1WC2yaNq4IgWwQw0VKJtVz
 h+dM2ruxa1YSD14zBhtC3WJ8zrICShY4O0aJOZ5InfUiOEt74kgucHvUnRbsJ9YpLq
 ETldFs8KfXEuZJJZzwesycdyS8XBrGvzT/+vZh3rWI20R+4d4DXfvaWA6OTzaa0ZIq
 BDbHcZfiA9ZZIaMkjUIqflTQWAeez05Tvea8nj3D8sItA6VrKqtfRprUqma0506hCD
 BLoB80zGlV07OX7wNs13JkDOddMV+ueGQ2EWKR+GAxGK6E9TolCNz1E7Li+ateb50U
 OX3Bd8PUVs2Hw==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: David Airlie <airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: [GIT PULL] mediatek drm next - 20261003
Date: Sat,  3 Oct 2026 12:25:24 +0000
Message-ID: <20261003122524.12578-1-chunkuang.hu@kernel.org>
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
1. Add support for the mt8167 display pipeline

Regards,
Chun-Kuang.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git tags/mediatek-drm-next-20261003

for you to fetch changes up to 265b9bea1a2f4c3361da82e922f9f08982d43978:

  drm/mediatek: Add support for mt8167 Digital Parallel Interface (2026-10-03 12:08:26 +0000)

----------------------------------------------------------------
Mediatek DRM Next - 20261003

1. Add support for the mt8167 display pipeline

----------------------------------------------------------------
Luca Leonardo Scorcia (2):
      dt-bindings: display: mediatek: dpi: Add compatible for mt8167
      drm/mediatek: Add support for mt8167 Digital Parallel Interface

 .../bindings/display/mediatek/mediatek,dpi.yaml    |  1 +
 drivers/gpu/drm/mediatek/mtk_dpi.c                 | 23 ++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  2 ++
 3 files changed, 26 insertions(+)
