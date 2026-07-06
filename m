Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F30C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C87710F3F8;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Tr2dHVal";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5930A10E4C4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:54:38 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260706134550euoutp017e139651f5b0bd0617056583ba35c5f2~-t1Rf1oap0918609186euoutp01E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:45:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260706134550euoutp017e139651f5b0bd0617056583ba35c5f2~-t1Rf1oap0918609186euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1783345550;
 bh=Xd+wZaWKt4WLBoWcIW7HFB2FqoJzshvSx4JYa94r+As=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Tr2dHValAT8V0QSKNTHD4PdEGzQ0vgODBeTDMgjkX27DC7Qy4IHfXiCXeDiCXGIhr
 bzGH7YU68UNHjSYjr+D1XZPjog1A7SqiD47KlhhOCkq7DZQH5N5chUjidcn3e0WHN+
 OoqmDY0BiL3YJQMgtQVGqQty2s6QPOJ7kCnLJuI0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260706134549eucas1p20eedf2d3287d95687eaaa8a201679083~-t1RBY5dK3010230102eucas1p2q;
 Mon,  6 Jul 2026 13:45:49 +0000 (GMT)
Received: from AMDC4670.local (unknown [106.120.77.38]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260706134549eusmtip1d8172d0993045b0df836465e6282e8ba~-t1QgKiRU0865008650eusmtip1a;
 Mon,  6 Jul 2026 13:45:49 +0000 (GMT)
From: Jan Niedziolka <j.niedziolka@samsung.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 k.tegowski@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.fijalko@samsung.com, bartlomiej.k@samsung.com, Jan Niedziolka
 <j.niedziolka@samsung.com>
Subject: [PATCH 0/3] drm: Remove unused *drm parameter
Date: Mon,  6 Jul 2026 15:34:38 +0200
Message-ID: <20260706134515.3369960-1-j.niedziolka@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260706134549eucas1p20eedf2d3287d95687eaaa8a201679083
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260706134549eucas1p20eedf2d3287d95687eaaa8a201679083
X-EPHeader: CA
X-CMS-RootMailID: 20260706134549eucas1p20eedf2d3287d95687eaaa8a201679083
References: <CGME20260706134549eucas1p20eedf2d3287d95687eaaa8a201679083@eucas1p2.samsung.com>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Commit 0e691bc73026 ("drm: Remove use of drm_mode_object") introduced changes
which caused *dev parameter to be unused in function body yet left over in
function's (drm_mode_create and drm_mode_destroy) signature.
This patchset revolves around removing this parameter, cleaning those functions
references and also providing minimal logging (as it's best to not introduce
breaking changes in functions that old, only drm_notice() logging is done instead
of proper error handling or at least error code returning).

Jan Niedziolka (3):
  gpu/drm: Remove unused *dev parameter from drm_mode_destroy function
  gpu/drm: Remove unused 'drm device *dev' parameter from
    drm_mode_create()
  gpu/drm: Add drm_notice logging when drm_mode_create fails

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   |  2 +-
 drivers/gpu/drm/drm_client_modeset.c          |  8 ++--
 drivers/gpu/drm/drm_connector.c               |  2 +-
 drivers/gpu/drm/drm_crtc.c                    |  4 +-
 drivers/gpu/drm/drm_crtc_helper.c             |  2 +-
 drivers/gpu/drm/drm_edid.c                    | 12 ++---
 drivers/gpu/drm/drm_modes.c                   | 34 ++++++++------
 drivers/gpu/drm/exynos/exynos_dp.c            | 47 +++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_dpi.c       |  2 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c       |  3 +-
 drivers/gpu/drm/gud/gud_connector.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c    |  4 +-
 drivers/gpu/drm/i915/display/intel_tv.c       |  2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  2 +-
 drivers/gpu/drm/panel/panel-edp.c             |  2 +-
 .../drm/panel/panel-olimex-lcd-olinuxino.c    |  2 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c  |  2 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c |  2 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c   |  2 +-
 drivers/gpu/drm/panel/panel-simple.c          |  2 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c |  2 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c     |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c         |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c      |  2 +-
 include/drm/drm_modes.h                       |  4 +-
 28 files changed, 104 insertions(+), 54 deletions(-)

-- 
2.43.0

