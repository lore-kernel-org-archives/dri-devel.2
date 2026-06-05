Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0372CCD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4723611A55C;
	Fri,  5 Jun 2026 07:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BCshmgIC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCAD911A55A;
 Fri,  5 Jun 2026 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780646276; x=1812182276;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=1aRfajY/mlCdD9J+IkNfAwMP9z+4dWk+xwz1iwDVNh8=;
 b=BCshmgIC1n+QAy29jyOmtQVcZ8bWI1kzlDGScLJSAcBVoPJDfURjRXHJ
 7YTPBM5LXCIfmOCCJXF2UBeW1whALvRhawKBSPMDtZ0dw0OyE9iI3+ncv
 Pnos1+iavLAmWJmblc0LZkisP2AGwq+LHujAmxzJLdB/5rnBNrFc7Ze5s
 muk4FaB5VJUaagQajDIIBNkQ4F7v7t/aThQqmS+613iwUh8Wf24cdw+Uv
 rLzUdsqhbWyhjw0qZBXix3MBE38MWDPmVjMaxV7XcEdDWtOUgVWHz9olr
 eTLR9Vgk7ZxmOak/qBXeNWxmQY4lryyYW+zecoF/rNMCt7XYvep9rGkFa Q==;
X-CSE-ConnectionGUID: 3HuXiKkwRD6FlNEtaixwMw==
X-CSE-MsgGUID: qhlBC/GaRcafH4f9ydeUxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98897434"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="98897434"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 00:57:54 -0700
X-CSE-ConnectionGUID: RH9pUXxoTcan0NI+fLf/CQ==
X-CSE-MsgGUID: 8cvysP7MQPavaeYoNwReHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="240328795"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.245.227])
 ([10.245.245.227])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 00:57:50 -0700
Message-ID: <a4a5bf50-3fc8-4faf-884b-08121687124a@linux.intel.com>
Date: Fri, 5 Jun 2026 09:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: dim-tools@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PULL] drm-misc-next-fixes
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

Hi Dave, Sima,

drm-misc-next-fixes for v7.2-rc1!

Kind regards,
~Maarten Lankhorst

drm-misc-next-fixes-2026-06-05:
drm-misc-next-fixes for v7.2-rc1:
- Revert last minute IS_ERR_OR_NULL changes in nouveau/gsp.
- Fix build warning in drm scheduler.
- Flush caches and TLB before v3d runtime suspend.
- Fix a trace and debug command in amdxdna.
- Fix heap buffer address validation when PASID is disabled in amdxdna.
The following changes since commit 61de054a772a1feda6364931ab1baf9038abf1c8:

  drm/nouveau/gsp: formally support GA100 (2026-05-28 19:30:15 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-fixes-2026-06-05

for you to fetch changes up to 62c1671f6454ceaa80e9ceff63f821aa36f35154:

  accel/amdxdna: Return errors for failed debug BO commands (2026-06-03 11:47:12 -0700)

----------------------------------------------------------------
drm-misc-next-fixes for v7.2-rc1:
- Revert last minute IS_ERR_OR_NULL changes in nouveau/gsp.
- Fix build warning in drm scheduler.
- Flush caches and TLB before v3d runtime suspend.
- Fix a trace and debug command in amdxdna.
- Fix heap buffer address validation when PASID is disabled in amdxdna.

----------------------------------------------------------------
Lizhi Hou (3):
      accel/amdxdna: Preserve user address when PASID is disabled
      accel/amdxdna: Remove drv_cmd tracing from job free callback
      accel/amdxdna: Return errors for failed debug BO commands

Lyude Paul (5):
      Revert "nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage"
      Revert "nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation"
      Revert "nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)"
      Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd"
      Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions"

Maíra Canal (2):
      drm/v3d: Flush MMU TLB and cache during runtime resume
      drm/v3d: Clean caches before runtime suspend

Tvrtko Ursulin (1):
      drm/sched: Fix clang build warning in kunit tests

 drivers/accel/amdxdna/aie2_ctx.c                   | 16 +++++------
 drivers/accel/amdxdna/amdxdna_gem.c                |  5 +++-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |  8 +++---
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c    |  4 +--
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c  |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c  | 10 +++----
 drivers/gpu/drm/scheduler/tests/tests_scheduler.c  | 12 ++-------
 drivers/gpu/drm/v3d/v3d_mmu.c                      | 31 +++++++++++++++-------
 drivers/gpu/drm/v3d/v3d_power.c                    |  2 ++
 10 files changed, 50 insertions(+), 42 deletions(-)
