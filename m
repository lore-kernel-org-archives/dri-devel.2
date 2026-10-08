Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4A2CA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C292E10E8F5;
	Thu,  8 Oct 2026 14:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c1wumjyw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920AA10E0DF;
 Thu,  8 Oct 2026 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791471365; x=1823007365;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=sTbvRiGpG0Abdwan7uPYlROAE1Zn0w1PsaRIbBuqYRA=;
 b=c1wumjyw/50iTlQTULV433O2xbYkeu0QY7ijmXx5dfaHp59jQS3camc3
 tXhSeilnU5xOCj9IA5zYdGkHUpARXOUOzVuK29q71KE/23L2aWR+1/pgg
 EGfaTaJrX4hG+1W9F32/dn2iE9kRWEbTLYpDvZP1ptHvW3GzUMQTVqu36
 9M0pk8Ai47vOG5lsQGwiKkK1JoweSO4jSl/9HMpDAQq2GVOgVqX4p4aQS
 7BRv2Qfnbey8V5IA4z72ysPSYdQzENN7FgRbBQnxSHX4cP6qaPBTIwvhf
 gzIrT4XWiHVsyWOkE4gVTJ0gbhWjGrccGWn80uTLI/u2pvMeiQeEiSafV g==;
X-CSE-ConnectionGUID: kvafLaV9RI+k5J5N1fnrAw==
X-CSE-MsgGUID: bEhrvQMHR0+dcTdz4q0XcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="139782"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="139782"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 07:56:04 -0700
X-CSE-ConnectionGUID: auof8W2LQ26hEIdJfIKCWQ==
X-CSE-MsgGUID: 5AUY3MDeQ4u+Dzg+TlywsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="13303"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.142])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 07:56:01 -0700
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
Date: Thu, 08 Oct 2026 17:55:58 +0300
Message-ID: <49ac4a9f496e1dadbf71740eb0d1f443598b2632@intel.com>
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

Couple of fixes, both stable material.

I'll be out next week, and Joonas will cover for me.


drm-intel-fixes-2026-10-08:
drm/i915 fixes for v7.3-rc7:
- Fix a GT park race that could trigger spurious RPM wakelock warnings
- Fix execbuffer relocation cleanup to avoid out-of-bounds free

BR,
Jani.

The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-10-08

for you to fetch changes up to 5346b1cec6afa4f9b4b49a9f84e3cfef95a3f7bb:

  drm/i915/gt: Unmask interrupts only when ACTIVE is true (2026-10-06 15:47:19 +0300)

----------------------------------------------------------------
drm/i915 fixes for v7.3-rc7:
- Fix a GT park race that could trigger spurious RPM wakelock warnings
- Fix execbuffer relocation cleanup to avoid out-of-bounds free

----------------------------------------------------------------
Krzysztof Karas (2):
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 drivers/gpu/drm/i915/gt/intel_rps.c            | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
Jani Nikula, Intel
