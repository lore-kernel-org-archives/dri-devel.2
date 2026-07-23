Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E9EC531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D5C10E5FB;
	Thu, 23 Jul 2026 20:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zv9QgL0h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11D010E0FA;
 Thu, 23 Jul 2026 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784838665; x=1816374665;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=vfYVt2LV4GmnmBTQcQ7sdeG9vaCNcLUGuuwQkZz6EQo=;
 b=Zv9QgL0hjyPBHJgHOTMrbUCKzxd8lYPbirkGE4ZWLB0ftycyQ1V60U+7
 TxzHwsr2lS/mG/la06I/9mOdEPa0xebi2tx798zL/1/eAXJdJOg7Qrspv
 MEs/cbuX7cFhZkwm6GcN9hvE1lga9inHb+6BhaiUuJt990wSEBStDWayw
 wEMCtG0gFMhjmW99cBa+6UWBQ5u2BzPIcRA2h84dFB1GIFrmUH3weiYWp
 Kwak8pbNNRpRq3wuSS2BipB1lOclygraPV9K6MljFqYvUAVxNp7EtlNSB
 1AR0SlydTzX050/rnvbzLXO7bOxRG8kKzbWzFCmvaOIwNxqtfebvu8pFI Q==;
X-CSE-ConnectionGUID: 3xu1dtbiQEOiwWVOJujCzg==
X-CSE-MsgGUID: 5c+1+vNPRLSEY6xayxf/Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85356661"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="85356661"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 13:31:04 -0700
X-CSE-ConnectionGUID: gT6gQqwcTfqLbneYVB8RFg==
X-CSE-MsgGUID: +95Xy65jQZCK8UuFIu+zbQ==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO fedora)
 ([10.245.244.122])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 13:31:00 -0700
Date: Thu, 23 Jul 2026 22:30:49 +0200
From: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-xe-fixes
Message-ID: <amJ5-WUA_OS_RBAp@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Dave, Simona

The drm-xe-fixes PR towards -rc5. Down to 4 patches this week.

Thanks,
Thomas

drm-xe-fixes-2026-07-23:
Driver Changes:
- Skip invalidation for purgeable state updates (Arvind)
- Add drm_dev guards when detaching CCS read / write buffers (Satyanarayana)
- Alloc per domain unique i2c id (Raag)
- Fix SVM leak on resv obj alloc failure in xe_vm_create (Shuicheng)

The following changes since commit 130910bac905a42225f93841e338bbea4a431b1a:

  drm/xe/pf: Disable display in admin only PF mode (2026-07-16 16:53:38 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-07-23

for you to fetch changes up to d2c6800ad1802bed72a6de1416536737f114f1d6:

  drm/xe/vm: Fix SVM leak on resv obj alloc failure in xe_vm_create() (2026-07-23 09:19:08 +0200)

----------------------------------------------------------------
Driver Changes:
- Skip invalidation for purgeable state updates (Arvind)
- Add drm_dev guards when detaching CCS read / write buffers (Satyanarayana)
- Alloc per domain unique i2c id (Raag)
- Fix SVM leak on resv obj alloc failure in xe_vm_create (Shuicheng)

----------------------------------------------------------------
Arvind Yadav (1):
      drm/xe/madvise: Skip invalidation for purgeable state updates

Raag Jadav (1):
      drm/xe/i2c: Allow per domain unique id

Satyanarayana K V P (1):
      drm/xe/vf: Add drm_dev guards when detaching CCS read/write buffers

Shuicheng Lin (1):
      drm/xe/vm: Fix SVM leak on resv obj alloc failure in xe_vm_create()

 drivers/gpu/drm/xe/xe_i2c.c          |  5 ++++-
 drivers/gpu/drm/xe/xe_migrate.c      | 16 ++++++++++------
 drivers/gpu/drm/xe/xe_migrate.h      |  3 ++-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c | 14 ++++++++++++--
 drivers/gpu/drm/xe/xe_vm.c           |  8 ++++----
 drivers/gpu/drm/xe/xe_vm_madvise.c   | 19 +++++++++++++++++--
 6 files changed, 49 insertions(+), 16 deletions(-)
