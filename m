Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2140103A9A0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AB910E9AB;
	Thu, 26 Mar 2026 07:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EHtnhb6t";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E6810E9A2;
 Thu, 26 Mar 2026 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774509459; x=1806045459;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=OYwUvhrsyofM37oU9mgQfaaKJkaUKuX6JktVCFtT0ko=;
 b=EHtnhb6taYGsfzfhPKX/+PrGuLdz6rr5Bn4HHLJtSaQ9vbsRkBFKNlMb
 fBNeJa/+s3Sr2XEhBeqxuWtLQj/+ZbBU/0G+Rehx7hy3Pm/ekVO+vpmkH
 qbcwPcmAwviNd76wQPzIznx/3JPmBreK9aAi+0R6XzmysX8xPCUc3ULmP
 /9bNCNHOyUayioRtH1orGwKEG74R9JN0I/QI98VCyRRyVBLhPP10sWLEo
 pr9G1bhxPOd9DV7a/MRe1wtqLUQaKU6aQxradJTdWlSVC5twziy9Oz3/D
 zPvPyaxMCPY8kNl+17lonmneU0P6+1nGSh4X8d25DBp166tONml6O/JJk g==;
X-CSE-ConnectionGUID: /oG3RuwWT7u2I6Xsx9yKxQ==
X-CSE-MsgGUID: iUt1c6i0Sn+muUJ8Mcyddg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86637336"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="86637336"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 00:17:39 -0700
X-CSE-ConnectionGUID: Yi2TMbo3Re6IVJHjXKxydQ==
X-CSE-MsgGUID: 0drWFrdZSIGX8slDVzPfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="220081026"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.213])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 00:17:34 -0700
Date: Thu, 26 Mar 2026 09:17:32 +0200
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
Message-ID: <acTdjAoOGkzl3dcc@jlahtine-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

Hi Dave & Sima,

Here goes this week drm-intel-fixes PR towards v7.0-rc6.

On display side DP tunnel error handling and NV12 plane clobbering fixes
for atomic state. Then GMBUS timeout fix and __wait_for() barrier fix.

Regards, Joonas

***

drm-intel-fixes-2026-03-26:

- DP tunnel error handling fix
- Spurious GMBUS timeout fix
- Unlink NV12 planes earlier
- Order OP vs. timeout correctly in __wait_for()

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-03-26

for you to fetch changes up to 77fcf58df15edcf3f5b5421f24814fb72796def9:

  drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state (2026-03-24 08:00:00 +0200)

----------------------------------------------------------------
- DP tunnel error handling fix
- Spurious GMBUS timeout fix
- Unlink NV12 planes earlier
- Order OP vs. timeout correctly in __wait_for()

----------------------------------------------------------------
Imre Deak (1):
      drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state

Samasth Norway Ananda (1):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads

Ville Syrjälä (2):
      drm/i915: Order OP vs. timeout correctly in __wait_for()
      drm/i915: Unlink NV12 planes earlier

 drivers/gpu/drm/i915/display/intel_display.c   |  8 +++++++-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c | 20 ++++++++++++++------
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h | 11 +++++++----
 drivers/gpu/drm/i915/display/intel_gmbus.c     |  4 +++-
 drivers/gpu/drm/i915/display/intel_plane.c     | 11 +++++++++--
 drivers/gpu/drm/i915/i915_wait_util.h          |  2 +-
 6 files changed, 41 insertions(+), 15 deletions(-)
