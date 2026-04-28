Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21EEFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A45F10EA28;
	Tue, 28 Apr 2026 07:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MjaAb7W9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857AF10EA26;
 Tue, 28 Apr 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777361509; x=1808897509;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0nO5YZfpp/CkW4P3+yc1h3ASEGri6Ld8zhG3/Yy56Ys=;
 b=MjaAb7W9mBqMdnHJ3Yz2vN/lFkc1MVcoupvEVZh9rIBKWC/+7H/X5gCj
 XrMOwjSR0ptiX5Sfxdj2V0vTyyhikquHlHDOrGNWzL1j6ZePIppn1wimF
 7246s0yeFJZ9GZctsm9KXie0LmmnvCvZAvUSTwXe+r+O641uceKyMNWhD
 w2vCa+VT/tJV9KI9PCTNmaViZwVASQhhQfHzE3lwq/3CaKFxV/h9I0ekh
 lD/6hTnM8K4ws08+uKBS4w4rhfTwAp/NgWXIb7ZjGIBfyNrRaUa5wCckd
 voRjUozTrPFWyODqwBtxiGSq+WBFHzntJScG8ItvBc+EmyNG6tKsythOZ w==;
X-CSE-ConnectionGUID: Gi40M2FFRRirfHQRoPMNxg==
X-CSE-MsgGUID: mC0RllpdR1yTgCUXmx4MGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103722046"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="103722046"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:31:48 -0700
X-CSE-ConnectionGUID: IEBGS0tDRa2Uzv/wJhDGpw==
X-CSE-MsgGUID: IqHp+U6OS1++dE6+uQauCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="230716249"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.161])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:31:43 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add reclaim to the dmem cgroup controller
Date: Tue, 28 Apr 2026 09:31:12 +0200
Message-ID: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

When writing a "max" limit lower than the current usage, the
existing code silently failed. This series aims to improve
on that by returning -EBUSY on failure and also attempt
to synchronously reclaim device memory to push the usage
under the new max limit to avoid the error.

Patch 1 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 2 implements a TTM reclaim callback.
Patch 3-4 hooks up the reclaim callback to the dmem cgroups-
      aware drivers xe and amdgpu.

v2:
- Remove the error propagation that was in a previous series (Maarten)
- A number of updates in patch 1. See its commit message for
  details (Maarten)

User-space tests are at
https://patchwork.freedesktop.org/series/163935/

Test-with: 20260428065411.4222-1-thomas.hellstrom@linux.intel.com

Thomas Hellström (4):
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 10 ++-
 drivers/gpu/drm/ttm/ttm_bo.c                 | 95 +++++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |  3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           | 36 ++++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         | 19 ++--
 include/drm/ttm/ttm_bo.h                     | 10 +++
 include/drm/ttm/ttm_resource.h               |  4 +
 include/linux/cgroup_dmem.h                  | 11 +++
 kernel/cgroup/dmem.c                         | 83 +++++++++++++++--
 10 files changed, 249 insertions(+), 24 deletions(-)

-- 
2.53.0

