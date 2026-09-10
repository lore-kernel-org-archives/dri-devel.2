Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69456C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87C410E2F6;
	Thu, 10 Sep 2026 19:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OU1j3taR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE8910E2DE;
 Thu, 10 Sep 2026 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789069825; x=1820605825;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=XOZ8sKIHPaBL/NaJLxyHz4XZWgXh44x98hGuEMH/wRE=;
 b=OU1j3taRznWVvRiuvEcAHKiUhmfEkjPHI8EfSPd8g5UXqWRoXEVMbRLO
 y13zgFgWL/Ly6LqMQDnY8AHJ4alS/ebgwZVAkgaor0l4OZFd0wWhKi/ZU
 e5pD9vBvfHRv2/UGuKHEMf8Gru7qE+00rdKuSEaTs/akdL100D4Lp7e8r
 JvbnkdHUqT2Y57wXGANT/WIwmyUely/JEP1M019HFxrhPCYGIadnKuAAf
 FqRRWY6G5hBqcqkBrJjQfQgZcoTAEsGbVrtHnDAp/wul+vQXJzAyDWd6I
 wBSEfqIna5Ii5LsuI+xOQG800+NRzQKM6epHHe/WU5aDftjDghBA2bwa/ A==;
X-CSE-ConnectionGUID: oA0X+P85SCSexeK/hePmzw==
X-CSE-MsgGUID: BOt7S6k+QN2Kutn0lZ3s6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88474094"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="88474094"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 12:50:25 -0700
X-CSE-ConnectionGUID: fuk839qKQYyFaUk3nOMtrQ==
X-CSE-MsgGUID: DocQcdtYQgyxpZigyaAsLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="275253521"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.208])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 12:50:20 -0700
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
Date: Thu, 10 Sep 2026 22:50:17 +0300
Message-ID: <27458ccc4d6be77a0d440f32279586711f3294f0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Couple of fixes for rc3.

drm-intel-fixes-2026-09-10:
drm/i915 fixes for v7.3-rc3:
- Fix a memleak on perf config query error path
- Fix UHBR SST SDP splitting when sink doesn't support it

BR,
Jani.

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-09-10

for you to fetch changes up to cbd3dafc2003db679ccd2f6c6a2551db79657049:

  drm/i915: Fix memory leak in query_perf_config_list() (2026-09-10 11:05:14 +0300)

----------------------------------------------------------------
drm/i915 fixes for v7.3-rc3:
- Fix a memleak on perf config query error path
- Fix UHBR SST SDP splitting when sink doesn't support it

----------------------------------------------------------------
Mitul Golani (1):
      drm/i915/dp: Gate UHBR SST SDP splitting on sink capability

Thorsten Blum (1):
      drm/i915: Fix memory leak in query_perf_config_list()

 drivers/gpu/drm/i915/display/intel_display_types.h |  2 +
 drivers/gpu/drm/i915/display/intel_dp.c            | 44 +++++++++++++++++++---
 drivers/gpu/drm/i915/i915_query.c                  |  4 +-
 3 files changed, 43 insertions(+), 7 deletions(-)

-- 
Jani Nikula, Intel
