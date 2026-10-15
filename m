Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BACCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B305E10EB72;
	Thu, 15 Oct 2026 06:07:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122A210E9E6;
 Thu, 15 Oct 2026 06:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792044469; x=1823580469;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=lIp8Ez5vdPviw3SB6liedxOk3QRt6NrPwQKfX3GxXKI=;
 b=Q4SCcPCnN/9k2Y6W9306Bk72t3//8bC2ot9UzUoxq203RGHlEHxzTNrp
 8avNnXZ/XeN3XpAOJ8Py5XMHLeX4bmOnZZOvU/KllAKpGKEj3Z9BY4/hL
 JUzcr4XauZT3lOiDeyb6p2TDRPQ1Xm0myzqZa9vrq8/slZSojDQiS0pnJ
 CROdF4qcu+VGi0uZtxd4nAXZlA8yeGUH2I9qM537h70WmX0pdCfplMbAP
 b3ytpgrFau4mVvEkDvcz6etbdRXuggx3166oa4/URpCoXhgs9qkuHoU8a
 /nLOevp9nwGUhVnobu99YB5xVjZ+NBy+Z0DdE5PN4KQaRyTCumglRPKkY g==;
X-CSE-ConnectionGUID: VL5iFqgYTyyznRUe7WeuvA==
X-CSE-MsgGUID: Y7jiffb5RSKnxhbxHg/A1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="794096"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="794096"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 23:07:49 -0700
X-CSE-ConnectionGUID: HkAU05ZFTQSWzY1ADhyHFA==
X-CSE-MsgGUID: tnYNM8jtTkSc5hcu9Ad+Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1694045"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 23:07:44 -0700
Date: Thu, 15 Oct 2026 09:07:42 +0300
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
Message-ID: <atBtrhSxjkB7bVwm@jlahtine-mobl>
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

Hi Dave & Sima,

Here goes this week drm-intel-fixes PR towards v7.3(-rc8).

Fix for ARL-S host bridge detection and a couple DMC firmware loading
sanity check additions.

Regards, Joonas

PS. No drm-intel-next-fixes PR this week.

***

drm-intel-fixes-2026-10-15:

- Fix ARL-S host bridge detection
- Add sanity checks for malformed DMC firmware

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-10-15

for you to fetch changes up to 6a8bf59de3ef47ff51face6ea826395a1098baa0:

  drm/i915/cx0_phy: Fix ARL-S host bridge detection (2026-10-14 17:54:59 +0300)

----------------------------------------------------------------
- Fix ARL-S host bridge detection
- Add sanity checks for malformed DMC firmware

----------------------------------------------------------------
Dibin Moolakadan Subrahmanian (2):
      drm/i915/dmc: Harden DMC firmware payload parsing
      drm/i915/dmc: Add sanity check for DMC load address

Dnyaneshwar Bhadane (1):
      drm/i915/cx0_phy: Fix ARL-S host bridge detection

 drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 12 +++--
 drivers/gpu/drm/i915/display/intel_dmc.c      | 76 +++++++++++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_dmc_regs.h | 12 +++++
 3 files changed, 90 insertions(+), 10 deletions(-)
