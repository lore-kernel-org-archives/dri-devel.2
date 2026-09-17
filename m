Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B830CC982D7
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2173710E720;
	Thu, 17 Sep 2026 15:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jX+xyBE4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9253510E6F8;
 Thu, 17 Sep 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789659068; x=1821195068;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=JpUGe5ukOdB9ZBNA+LfJl4n35Yn/oR8+pm4oOBdCcLw=;
 b=jX+xyBE45OKYniZ1TyiWq70vbr8Fpak+0Hxet4Fk+dvtTSCBBXYaD3lH
 G0lkJ7eU0qgBvErjXK6lojlag6jv0Kd8OTPke/PbMN25kwx3MLay5tAg3
 C3lyMK3ENWRqfne4WBONACc02gX4aXcck4MCk7ruiKzAk6eG+7QgJwLq7
 tNSfHHmPxeJqRQ7l7SqxiWdyUkIpnOPBQp9bPDH7lj+2ASf7FFZ7PxymP
 KIK7K5suizt183Ad1L/hG6Apu0EbIKJ1Uv1thtKGmiZcxcEoc2z1jOGSJ
 dpQIUmAEm0Ag2qZx7wHxGJCqImBcpsfD42OU0qTifvcxFncIDEFVWee4P w==;
X-CSE-ConnectionGUID: VJNuSfL1TxGzt2sksPt92w==
X-CSE-MsgGUID: hrW13iZwSgGZzHtpLtqAFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90225932"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90225932"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 08:31:07 -0700
X-CSE-ConnectionGUID: rTo1/vyXQhSX1QgBeMLl2g==
X-CSE-MsgGUID: bmpvS5/NS5uPVl7Q4OFv3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="267634704"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.121])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 08:31:03 -0700
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
Date: Thu, 17 Sep 2026 18:30:59 +0300
Message-ID: <3f86e0ede95fb3d52053934ac43c5271812428f5@intel.com>
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

Couple of i915 display fixes for v7.3-rc4.

drm-intel-fixes-2026-09-17:
drm/i915 fixes for 7.3-rc4:
- Revert a commit touching registers that don't necessarily exist
- Check for negative numbers before passing to BIT()

BR,
Jani.

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-09-17

for you to fetch changes up to a26204be587c57bd5c54fa513be26c4fd7bf252d:

  Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable" (2026-09-16 12:55:22 +0300)

----------------------------------------------------------------
drm/i915 fixes for 7.3-rc4:
- Revert a commit touching registers that don't necessarily exist
- Check for negative numbers before passing to BIT()

----------------------------------------------------------------
Luca Coelho (1):
      drm/i915/display: check configuration index before shifting

Nemesa Garg (1):
      Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable"

 drivers/gpu/drm/i915/display/intel_cursor.c        | 15 +++++----------
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c  |  9 ++++++++-
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 15 +++++----------
 3 files changed, 18 insertions(+), 21 deletions(-)

-- 
Jani Nikula, Intel
