Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B9606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JpnSstNM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3964510FFF4;
	Thu, 19 Nov 2026 08:05:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61EB10FFE8;
 Thu, 19 Nov 2026 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795075537; x=1826611537;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=IJ6joWbz1UgYrLRxC/e1sHS4cHsf7fO4DIgbtXHJzbk=;
 b=JpnSstNMw4nbA63kd1UcUQb8CTQWeWI6NbPRmFOr1v40S2a91Y9/NRCR
 c4jwbD1Bcw7/x+RCOLWk6qTVFJ2/6AxuGyBD9feg8vfDrSuPSkh+R/2P/
 6YbwItwqPTDXvlJpsnt4qBiM0d6vd7gt8jb2LqcB0d0t30Nv+75W1Jnta
 J9dVGoK96+2OVMRrAS6EGO1iyQP7MsqWnhqVpD9PaepUcHe/mz4n52Kld
 pi8X5It8zacWDbh18xDeX5u0GrvkC4S72SVv2+U55URJMBswTTpvgFJaM
 5WP1URFGbf9Ku3InmPnrQd1ftDEF4uA87GJ/6f45gismdBA4AgoAfmFn7 g==;
X-CSE-ConnectionGUID: sv3H0Uy4Sr6i8H0U0+i01g==
X-CSE-MsgGUID: +PMtZ450Rcmd1TLmmiHUqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3964663"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3964663"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 00:05:37 -0800
X-CSE-ConnectionGUID: D6bImurKT2eZ4VbNJMzLdw==
X-CSE-MsgGUID: vXx2w6UcTcqQeuVtZxjJGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10513346"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.76])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 00:05:32 -0800
Date: Thu, 19 Nov 2026 10:05:30 +0200
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
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
Subject: [PULL] drm-intel-fixes
Message-ID: <av6tygXTIOlGV7vc@jlahtine-mobl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave & Sima,

Here goes drm-intel-fixes PR towards v7.4-rc4.

One regression fix for CML/KBL 4K displays and one DSB programming fix.

Regards, Joonas

***

drm-intel-fixes-2026-11-19:

- Regression fix for GitLab #16595 and #17423: 4K displays corrupt/black on CML/KBL
- DSB programming fix for GOSUB

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-11-19

for you to fetch changes up to 715f145f6204363a50853eb15719dc860db0bc01:

  drm/i915/dsb: Realign GOSUB only for QW slots 6 and 7 (2026-11-16 11:12:07 +0200)

----------------------------------------------------------------
- Regression fix for GitLab #16595 and #17423: 4K displays corrupt/black on CML/KBL
- DSB programming fix for GOSUB

----------------------------------------------------------------
Hanson Wang (1):
      drm/i915/dsb: Realign GOSUB only for QW slots 6 and 7

Ville Syrjälä (1):
      drm/i915/cdclk: Ignore SWF18 in SKL CDCLK sanitization

 drivers/gpu/drm/i915/display/intel_cdclk.c | 13 +------------
 drivers/gpu/drm/i915/display/intel_dsb.c   | 16 ++++++++++------
 2 files changed, 11 insertions(+), 18 deletions(-)
