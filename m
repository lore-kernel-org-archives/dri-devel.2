Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62CFCA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E53210F110;
	Thu,  1 Oct 2026 14:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YVLemYKE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AC710EEFD;
 Thu,  1 Oct 2026 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790866155; x=1822402155;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ewa1wuVn35rcjvk+PaepGF5+VMjomWfPBtsBrSoXF1Q=;
 b=YVLemYKEhS9KOLwJC7vSa4u3f0A2AWTKlBi/oRbymVziMly7HNwTmUXL
 bNFhFRfhyuUYmqh6rgnThA88dUi/ZkRV7vjBvfAAoeNsHIO1z6uXKjTmx
 mPutuphv8EUmqVQvG/wQbS+nlu13zCMynYVwWHhxs7NPrxZGl+KTLAfXx
 2E7/8mYL2CxQHG9epKSsfHSiZJVPiGm5RVBelrLllLDQzrCEwSy4jTjIN
 561O16KT3rxvWUhXhEKCCEfRJfXUfjwGJWE1arwUwehhLNmKOc7fkumcy
 +QGw82K0VIt5K0lOB2P2nS1oKSGR6J3kVLdECbu+697G/n7JHzmQ3NaGD g==;
X-CSE-ConnectionGUID: PAqENUgoQrGf37kfCxbwQw==
X-CSE-MsgGUID: 8iqdlKpGTtW9mxJTifE/uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90759344"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="90759344"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:49:14 -0700
X-CSE-ConnectionGUID: IzSc/ACRRI6RBNLwMVV3pg==
X-CSE-MsgGUID: lJLGLy+fS4SerSuUBsP8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="272435477"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.111])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:49:10 -0700
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
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org, Uma
 Shankar <uma.shankar@intel.com>, ville.syrjala@linux.intel.com
Subject: [PULL] drm-intel-fixes
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Date: Thu, 01 Oct 2026 17:49:08 +0300
Message-ID: <5a9a11777f605b59550783923add4568e974a6ea@intel.com>
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

drm-intel-fixes-2026-10-01:
drm/i915 fixes for v7.3-rc6:
- Disable VRR DC balance by default to fix timing issues

BR,
Jani.

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-10-01

for you to fetch changes up to c034e8a46e4cb703018fe7e10fe5a3a974d6a7c3:

  drm/i915/vrr: Disable DC balance by default (2026-09-28 12:14:43 +0300)

----------------------------------------------------------------
drm/i915 fixes for v7.3-rc6:
- Disable VRR DC balance by default to fix timing issues

----------------------------------------------------------------
Mitul Golani (1):
      drm/i915/vrr: Disable DC balance by default

 drivers/gpu/drm/i915/display/intel_display_params.c | 4 ++++
 drivers/gpu/drm/i915/display/intel_display_params.h | 1 +
 drivers/gpu/drm/i915/display/intel_vrr.c            | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
Jani Nikula, Intel
