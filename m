Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1B2C5DF69
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB63410E07E;
	Thu, 13 Aug 2026 19:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mVVTzc3L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD45910E01F;
 Thu, 13 Aug 2026 19:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786649007; x=1818185007;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=CPqhFBdFxtgHNNm5HSu60towjDd5+fAGykrOIhkDhMY=;
 b=mVVTzc3LW1S7sAR3Uz17/6jknScojZuHe5VLOT8RUeYdlanJ2zvsVZiQ
 tYD54lbFBWLg0wyTbCId4hQXo2XDfOJ0EYGJh62jijuJ+a9gppAQEzxfx
 M6wnwi5QhdH/WIBbVEG1X9eAW8a1/1r8M/VtQd6QpAB10qM06kGKIQ8X6
 Na0Ko3iMPQv6hEsy+nDQRi8WF8SilOGqCJEE9o6EDAFjntkObJ3Gpzzau
 Sf4ZzcZz4zHOGgA0irxybj1j4qjbGJOBTAAI6FkgX1fJeFajy6FhEoHcD
 l41T9Z4eYMw/oo2qMatBptYHGBgqz7Sj7kAi6FhVUbq6tmTcnAu5iIT2W w==;
X-CSE-ConnectionGUID: B3FQpcctT2ytOVGFGwBZww==
X-CSE-MsgGUID: o7LBE3uBTaKMOa40ifSEoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87306386"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87306386"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 12:23:26 -0700
X-CSE-ConnectionGUID: 2WKfQOrqRdGyOpOn7h/J4w==
X-CSE-MsgGUID: /IVNEmZ0Swqf4wvnOMEgRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="262281616"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.62])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 12:23:23 -0700
Date: Thu, 13 Aug 2026 21:23:14 +0200
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
Message-ID: <an4ZogmPqP2Xtfx3@fedora>
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

The drm-xe-fixes pull for -rc8/final. Unfortunately a larger number of fixes
than I was hoping for due to the low number the previous two weeks.
Nothing that really stands out.

Thanks,
Thomas

drm-xe-fixes-2026-08-13:
Driver Changes:
- Fix DPT Allocation paths (Maarten)
- Fixes around UM queue BO (Jia)
- Order ring writes before ring tail updates (Matthew Brost)
- Add termination on resume for PXP (Daniele)
- Document Sentinel and make CTX_TIMESTAMP read TOCTOU-safe (Gajendra)
- Fix sync entry leak on OA config emit failure (Linmao Li)
- Check managed mutex initilization errors (Linmao Li)
- Fix min frequency setting (Vinay)
- Fix xe_device_probe error path (Raag)
The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-08-13

for you to fetch changes up to ef526d122b62af5afa437f095aa6661a953676c4:

  drm/xe: Fix xe_device_probe() failure (2026-08-13 14:56:34 +0200)

----------------------------------------------------------------
Driver Changes:
- Fix DPT Allocation paths (Maarten)
- Fixes around UM queue BO (Jia)
- Order ring writes before ring tail updates (Matthew Brost)
- Add termination on resume for PXP (Daniele)
- Document Sentinel and make CTX_TIMESTAMP read TOCTOU-safe (Gajendra)
- Fix sync entry leak on OA config emit failure (Linmao Li)
- Check managed mutex initilization errors (Linmao Li)
- Fix min frequency setting (Vinay)
- Fix xe_device_probe error path (Raag)

----------------------------------------------------------------
Daniele Ceraolo Spurio (1):
      drm/xe/pxp: add termination on resume

Gajendra Uttamchand (1):
      drm/xe/lrc: document sentinel and make CTX_TIMESTAMP read TOCTOU-safe

Jia Yao (3):
      drm/xe/guc_ads: allocate UM queues in a separate BO
      drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
      drm/xe/guc_ads: use uncached mapping for UM queue BO

Linmao Li (2):
      drm/xe/oa: Fix sync entry leak on OA config emit failure
      drm/xe/oa: Check managed mutex initialization errors

Maarten Lankhorst (1):
      drm/xe: Fix DPT allocation paths.

Matthew Brost (1):
      drm/xe: Order ring writes before ring tail updates

Raag Jadav (1):
      drm/xe: Fix xe_device_probe() failure

Vinay Belgaumkar (1):
      drm/xe: Fix a bug in pc_adjust_freq_bounds()

 drivers/gpu/drm/xe/display/xe_fb_pin.c |  33 ++-----
 drivers/gpu/drm/xe/xe_bo.h             |  14 +++
 drivers/gpu/drm/xe/xe_device.c         |   6 +-
 drivers/gpu/drm/xe/xe_guc_ads.c        |  93 ++++++++++++-------
 drivers/gpu/drm/xe/xe_guc_ads_types.h  |   5 +
 drivers/gpu/drm/xe/xe_guc_pc.c         |  13 ++-
 drivers/gpu/drm/xe/xe_lrc.c            |  29 ++++--
 drivers/gpu/drm/xe/xe_lrc.h            |   7 ++
 drivers/gpu/drm/xe/xe_oa.c             |  13 ++-
 drivers/gpu/drm/xe/xe_pxp.c            | 162 ++++++++++++++++++++++++---------
 drivers/gpu/drm/xe/xe_pxp_types.h      |  27 ++++--
 11 files changed, 279 insertions(+), 123 deletions(-)
