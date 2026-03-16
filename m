Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B42F3380D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C3810E41A;
	Tue, 17 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=antgroup.com header.i=@antgroup.com header.b="ICjBAjIP";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Mon, 16 Mar 2026 03:52:11 UTC
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com
 [115.124.28.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B243210E2AF;
 Mon, 16 Mar 2026 03:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=antgroup.com; s=default;
 t=1773633129; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=OED2UqpsODjwgj7WIlX0Yih4RVuBc+4p//C/zveDf7Q=;
 b=ICjBAjIPLiafKrFIAUpeSX0lt+qdbO3l6q7yYzOMG7Y8lWIw56RTh/UiRRd+Zn0lRLUH98SOpnZpZA61gCIWEB4UQq3VAGA/rdaAzVfxPv9+V7CA8ufJxuSnfQ6vjsM1l2jGMXOJU7E04Gmpn/m3neGHMKT7Z+JhUae4i+Dp4RM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037032089;
 MF=houwenlong.hwl@antgroup.com; NM=1; PH=DS; RN=47; SR=0;
 TI=SMTPD_---.gt4DdjB_1773632822; 
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com
 fp:SMTPD_---.gt4DdjB_1773632822 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 16 Mar 2026 11:47:03 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, amd-gfx@lists.freedesktop.org,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ausef Yousof <auyousof@amd.com>,
 Bhuvanachandra Pinninti <bpinnint@amd.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Charlene Liu <charlene.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Chris Park <chris.park@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 dri-devel@lists.freedesktop.org, Gustavo Sousa <gustavo.sousa@intel.com>,
 Harold Sun <Harold.Sun@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jun Lei <jun.lei@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>,
 Leo Chen <leo.chen@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Lohita Mudimela <lohita.mudimela@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Nicholas Carbones <Nicholas.Carbones@amd.com>, Ray Wu <ray.wu@amd.com>,
 Relja Vojvodic <rvojvodi@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Ryan Seto <ryanseto@amd.com>,
 Samson Tam <Samson.Tam@amd.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Wayne Lin <wayne.lin@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Yan Li <yan.li@amd.com>,
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>
Subject: [PATCH 0/2] drm: Fix namespace clashes with 'pixel_format'
Date: Mon, 16 Mar 2026 11:46:27 +0800
Message-Id: <cover.1773629419.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

The 'pixel_format' structure is defined in include/video/pixel_format.h.
However, DRM also defines a local structure with the same name, which
leads to namespace clashes as reported in [0]. As suggested in [1],
rename the 'pixel_format' definitions in drivers/drm by adding a prefix
to avoid the conflict.

[0]: https://lore.kernel.org/lkml/aahBPzflrEJ2FPx0@sirena.org.uk
[1]: https://lore.kernel.org/lkml/20260313122808.GAabQC2Bmul9Odt-dX@fat_crate.local

Hou Wenlong (2):
  drm/i915/gvt: Rename struct 'pixel_format' to 'gvt_pixel_format'
  drm/amd/display: Rename enum 'pixel_format' to 'dc_pixel_format'

 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c           | 3 ++-
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h           | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h           | 2 +-
 drivers/gpu/drm/i915/gvt/fb_decoder.c                       | 6 +++---
 8 files changed, 14 insertions(+), 13 deletions(-)

--
2.31.1

