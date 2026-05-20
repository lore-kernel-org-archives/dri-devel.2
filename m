Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E76DCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB0E10EFDA;
	Wed, 20 May 2026 10:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CNGiTfrP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A0F10EFE4;
 Wed, 20 May 2026 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779272232; x=1810808232;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/O86NQw2ZHZgg2HOuAwUHd+oF9GAM2q8ee/hWvsbGIE=;
 b=CNGiTfrPEU3vdCDvKHninnYCJef//2y8TUoPGh0Dh/LeNsdIMPRxVEYk
 uRGZcCKJVvt5hLrjtfpVqvI1fOiMO3OhKW+jGYApg7NJ0eXVBfG+/GJvt
 Gb04HnwnYZ5CovCv5IqCXjaAMqd2xBoS69PFMrjmtt6JN4fL6jsVc6ZOs
 D2odL+8sN8ZJzOLNrDoPN9UNaKDN6ZOj+eg/zj4ihzbI9oakBHBA3Txps
 5aWCdri8BcdEpQ+589bTg52UJixTp4TZKCU7fIdpJoViuaSJ6ONGIWpWD
 TaopKAvjAa4cTbVQJNe7DpF/Efp/fV420eAPOEreog78HRmjTr8UWi2Wd A==;
X-CSE-ConnectionGUID: LuWcnDCwRx6iK5B1xT8n9w==
X-CSE-MsgGUID: UKOzXC3YQ+GSzWZI4IhrSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="102843256"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="102843256"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:11 -0700
X-CSE-ConnectionGUID: Jvc1x63XQrim4Co5xHcQ2w==
X-CSE-MsgGUID: Pfxkdy+FTvShU3znPKlqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244114040"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.175])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:06 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: [PATCH v2 0/4] drm/exec: drm_exec polishing
Date: Wed, 20 May 2026 12:16:12 +0200
Message-ID: <20260520101616.41284-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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

During the work towards enabling exhaustive eviction using full
ww locking in TTM, Christian indicated that the path for the
drm_exec moving forward was to be a full drm_exec helper with
things like userptr validation rather than a WW transaction
abstraction. The idea was then briefly discussed to craft a
WW transaction helper and then subclass that with drm_exec
with the idea that the WW transaction helper could be used in
TTM for eviction and for other uses that didn't mandate a full
exec sequence.

Regardless whether that actually happens or not, this series
aims to clean up abuses of drm_exec internals in drivers
so that future development of drm_exec isn't blocked by
such driver usage.

Except for patch 2 which is a small cleanup only.

v2:
- An drm/msm patch was already merged.
- Use a unique id for the loop variable (patch 1) (Christian)
- Move assignment to declaration (patch 2) (Christian)
- Declare the retry pointer as void *const. (patch 2)
- Only allow if the drm_exec context is newly initialized. (patch 3)
  (Christian)
- Fix amdgpu compile error (patch 4) (Intel CI)
- Update the commit message (patch 4)

Thomas Hellström (4):
  drm/exec: Remove the index parameter from
    drm_exec_for_each_locked_obj[_reverse]
  drm/exec: Make the drm_exec_until_all_locked() macro more readable
  drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer
  drm/exec, drm/xe, drm/amdgpu: Add an accessor for struct
    drm_exec::ticket

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 15 ++--
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  3 +-
 drivers/gpu/drm/drm_exec.c                    |  9 +--
 drivers/gpu/drm/drm_gpuvm.c                   |  3 +-
 drivers/gpu/drm/xe/xe_validation.c            |  4 +-
 drivers/gpu/drm/xe/xe_validation.h            |  2 +-
 drivers/gpu/drm/xe/xe_vm.c                    |  3 +-
 include/drm/drm_exec.h                        | 71 ++++++++++++++-----
 9 files changed, 70 insertions(+), 44 deletions(-)

-- 
2.54.0

