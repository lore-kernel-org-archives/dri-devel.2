Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAF7C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912C210F375;
	Thu, 24 Sep 2026 07:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="INXTaRRw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDFF10F359;
 Thu, 24 Sep 2026 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790235513; x=1821771513;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=spmsYkrqjCRmUwSNTWJuRSUIkthceSnt8+ZLWsLLOMw=;
 b=INXTaRRw0Q5Jo3crpJqE8LY6hqU7uTQxLQzfLtt9t5MYktQ/CnmQFFk2
 vfo1rZOoUpxAnOI2ttx8MEYMNxW+nXbq6BaByOay3AU+mQvcRRLZawCVQ
 2GYfLTJ4JJyeoVKGRAOksRqHIANk0zHsR6nKLYIqRQredO+WborolXCTZ
 vp5E+i4Cxnho1k5iWkL5a0dIOcq9s5b7y8AFnw6pv3uK3da7ZC/dmlqUx
 DqE1zD5OxNEG5+zjOAsMSsUM+8gEKsstZwPxxXZA96oLO8tVd8Oe6jAU2
 HdKOS8F3jwm5tErFJPEyLdoTDHizD6bsceF5tH2DOpTwceU6NOx1I4OPl g==;
X-CSE-ConnectionGUID: pTBDZNF2TTm0CexH20uIHw==
X-CSE-MsgGUID: RsvTKQlZTcejp5dEDR+Thw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93495577"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93495577"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 00:38:33 -0700
X-CSE-ConnectionGUID: p96sOAq+RY+NnjaPY5XZVw==
X-CSE-MsgGUID: EjNBxe0fQwWsLmtnV5Ozwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="301891508"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.130])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 00:38:29 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-fixes
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Date: Thu, 24 Sep 2026 10:38:26 +0300
Message-ID: <9b8ff50ad5c3ff9ca120207b1e7aa95d5a16423f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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


Hi Dave & Sima -

drm-intel-fixes-2026-09-24:
drm/i915 fixes for v7.3-rc5:
- Fix incorrect RCU teardown order leading to endless loop
- Fix DP MST TU and FEC handling for disconnected streams
- Fix selective fetch disable, again
- Fix export namespace for kunit helpers
- Workaround eDP flicker on a specific laptop model

BR,
Jani.

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2=
026-09-24

for you to fetch changes up to d2da6696e0c4e60414706e607029d0bb0330c67e:

  drm/i915: fix incorrect RCU teardown order (2026-09-22 12:18:20 +0300)

----------------------------------------------------------------
drm/i915 fixes for v7.3-rc5:
- Fix incorrect RCU teardown order leading to endless loop
- Fix DP MST TU and FEC handling for disconnected streams
- Fix selective fetch disable, again
- Fix export namespace for kunit helpers
- Workaround eDP flicker on a specific laptop model

----------------------------------------------------------------
Ankit Nautiyal (1):
      drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1

Christian K=C3=B6nig (1):
      drm/i915: fix incorrect RCU teardown order

Imre Deak (2):
      drm/i915/dp_mst: Fix configuring FEC for a disconnected stream
      drm/i915/dp_mst: Fix configuring TUs for a disconnected stream

Jani Nikula (1):
      drm/i915/dp: use EXPORT_SYMBOL_IF_KUNIT() for kunit helpers

Nemesa Garg (1):
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

 drivers/gpu/drm/i915/display/intel_cursor.c        |  7 +++++--
 drivers/gpu/drm/i915/display/intel_display_types.h |  2 ++
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c  |  6 ++++--
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  4 ++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c        | 24 ++++++++++++++++++=
+++-
 drivers/gpu/drm/i915/display/intel_dp_mst.h        |  2 ++
 drivers/gpu/drm/i915/display/intel_link_bw.c       |  3 ++-
 drivers/gpu/drm/i915/display/intel_psr.c           | 15 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.c        |  3 +++
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  9 ++++----
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  2 +-
 11 files changed, 63 insertions(+), 14 deletions(-)

--=20
Jani Nikula, Intel
