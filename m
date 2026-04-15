Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E2CF43858
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F77410E722;
	Wed, 15 Apr 2026 16:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nq2kLLq2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567D810E71A;
 Wed, 15 Apr 2026 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776269342; x=1807805342;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nLwFGIpECw5N/7X1jKnfzsIFlSWwzdHUOHXcP6UrVKQ=;
 b=Nq2kLLq2Cn8FzYZRsR3EmInuleRRh5tO6+9yft78NtR7gLEm+gj36bSO
 ywcU52NJudOYJs1Mp7sF+eYa78raRhCmB3gh44zFu19ElWPZGND9p/nMe
 82flcrnQO2vfyFc+nelQmAICBWcHQ9no738wXxg0oNdx5Hs5ykcAwjjul
 LBgrzA7OA3fWxtgtKtEWZrDv4MEj878ylTZPT0VHvZDRLXlvaCUCETIxD
 tmtkM6xuFJ+Q9GZuU1tRbKY13SUfXWZFZL1vhR14YZwpbRoZqId78vMLY
 e6EOBSve9ivQH4o9XS7qtAk/eXyi2S0zvis7JaI6UWIRST6/6LOMHpM8I g==;
X-CSE-ConnectionGUID: 5uNBrqUBT2+XljDLZ4aKUA==
X-CSE-MsgGUID: cI4JEiwsRMmmaKoyEMl1ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="99896223"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="99896223"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 09:09:02 -0700
X-CSE-ConnectionGUID: CbELCx2hQq6n0ZIAN6Cgzw==
X-CSE-MsgGUID: JlXYWHeMQZWpawPoXYihgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="253880350"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.25])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 09:08:56 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org, Ville
 Syrjala <ville.syrjala@linux.intel.com>
Subject: [PULL] topic/pipe-reorder for drm-intel-next and possibly v7.1-rc1
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Date: Wed, 15 Apr 2026 19:08:52 +0300
Message-ID: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
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


Hi Dave & Linus -

This is a topic pull request for changing the pipe allocation order for
discrete platforms from the usual A,B,C,D to A,C,B,D. The goal is to
help pipe joiner configurations that reserve the adjacent pipe as the
secondary pipe without the user space knowing. More details in the
relevant commit message. The CRTC iteration is also changed to remain in
pipe order.

This has been a long time in the making, primarily because IGT basically
assumed CRTC index =3D=3D pipe, and it took hundreds of commits from Ville
and me over several months to untangle it, and actually get CI results.

I'm going to merge this to drm-intel-next soon, and at this point in
time it would normally target v7.2.

We're fully aware this is beyond feature deadlines for v7.1 and it
hasn't seen linux-next. But in the off-chance you might consider also
pulling this as a fix for v7.1 (and really, distros might want this to
be backported to stable) I'm sending this as a separate topic pull
request.

I'm leaving it to your discretion.

BR,
Jani.


topic/pipe-reorder-2026-04-15:
drm/i915/display: change pipe allocation order for discrete platforms


The following changes since commit 4516432284e1b2ad9e70de8067f779c9c1072189:

  ttm/pool: track allocated_pages per numa node. (2026-04-08 06:52:48 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/topic/pipe-reorde=
r-2026-04-15

for you to fetch changes up to 2c683e9b419328da3433a49f7c467da71aaf0469:

  drm/i915/display: change pipe allocation order for discrete platforms (20=
26-04-15 13:30:26 +0300)

----------------------------------------------------------------
drm/i915/display: change pipe allocation order for discrete platforms

----------------------------------------------------------------
Jani Nikula (1):
      drm/i915/display: change pipe allocation order for discrete platforms

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/joiner: Make joiner "nomodeset" state copy independent of pi=
pe order
      drm/i915: Walk crtcs in pipe order

 drivers/gpu/drm/i915/display/intel_crtc.c          | 49 +++++++++++-
 drivers/gpu/drm/i915/display/intel_display.c       | 20 ++---
 drivers/gpu/drm/i915/display/intel_display.h       | 90 +++++++++---------=
----
 drivers/gpu/drm/i915/display/intel_display_core.h  |  3 +
 .../gpu/drm/i915/display/intel_display_driver.c    |  1 +
 drivers/gpu/drm/i915/display/intel_display_types.h |  1 +
 drivers/gpu/drm/xe/display/xe_display.c            |  1 +
 7 files changed, 95 insertions(+), 70 deletions(-)

--=20
Jani Nikula, Intel
