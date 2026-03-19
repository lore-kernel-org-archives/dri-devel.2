Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F58109191C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BD710E125;
	Thu, 19 Mar 2026 21:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KiPbJtnu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B996B10E035;
 Thu, 19 Mar 2026 21:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773954042; x=1805490042;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=1UvG9LYfwizYjgUbcOnhgQFG/J6TEQkJvWIuzkU1lLQ=;
 b=KiPbJtnuqo5Hu1XDG72en3wEbq/rj+30tM2nOAz27GwooEbXpB++ogHJ
 en5QDDReSrIO0Naj15dstUx0J5vkB/W36rqw6gmAK5RIeTZAKVhWIJVtM
 Fun0+DbHv+/h4ncK742TFErHJDsaXDqrclQhOqGoQXsG6hiurIP5KwBI2
 uTVdUVCrotPTLWoFT98oDukEk/PGpZCKh+ZMFBFQs31hL/lyRTgTjxlrK
 TBeikRRD5cYLvGOj4y1NVV+2iT2lmQLmBce4tEvE80792UZnF02N3TGtf
 +1OKEIV0GZOmAo27N9sGWqDGBgFyTd6w5tzrSPRDdhHK07xPawIrviyKx g==;
X-CSE-ConnectionGUID: H8t30hVmSemly1lQQ5tTOw==
X-CSE-MsgGUID: C9+UDgmlQyypOCyFcRXWvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78944519"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="78944519"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 14:00:42 -0700
X-CSE-ConnectionGUID: ooUqAoVbT6SC1/VoHP/2aA==
X-CSE-MsgGUID: e1H4asMuTs6RtgP3uRoaEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="260977254"
Received: from rvuia-mobl.ger.corp.intel.com (HELO fedora) ([10.245.244.165])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 14:00:38 -0700
Date: Thu, 19 Mar 2026 22:00:19 +0100
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
Message-ID: <abxj4_dBHYBiSvDG@fedora>
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

Here's the drm-xe-fixes PR towards -rc5.

Thanks,
Thomas

drm-xe-fixes-2026-03-19:
Driver Changes:
- A number of teardown fixes (Daniele, Matt Brost, Zhanjun, Ashutosh)
- Skip over non-leaf PTE for PRL generation  (Brian)
- Fix an unitialized variable (Umesh)
- Fix a missing runtime PM reference (Sanjay)
The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-03-19

for you to fetch changes up to 65d046b2d8e0d6d855379a981869005fd6b6a41b:

  drm/xe: Fix missing runtime PM reference in ccs_mode_store (2026-03-19 18:05:04 +0100)

----------------------------------------------------------------
Driver Changes:
- A number of teardown fixes (Daniele, Matt Brost, Zhanjun, Ashutosh)
- Skip over non-leaf PTE for PRL generation  (Brian)
- Fix an unitialized variable (Umesh)
- Fix a missing runtime PM reference (Sanjay)

----------------------------------------------------------------
Ashutosh Dixit (1):
      drm/xe/oa: Allow reading after disabling OA stream

Brian Nguyen (1):
      drm/xe: Skip over non leaf pte for PRL generation

Daniele Ceraolo Spurio (1):
      drm/xe/guc: Fail immediately on GuC load error

Matthew Brost (4):
      drm/xe: Always kill exec queues in xe_guc_submit_pause_abort
      drm/xe: Forcefully tear down exec queues in GuC submit fini
      drm/xe: Trigger queue cleanup if not in wedged mode 2
      drm/xe: Open-code GGTT MMIO access protection

Sanjay Yadav (1):
      drm/xe: Fix missing runtime PM reference in ccs_mode_store

Umesh Nerlige Ramappa (1):
      drm/xe/lrc: Fix uninitialized new_ts when capturing context timestamp

Zhanjun Dong (1):
      drm/xe/guc: Ensure CT state transitions via STOP before DISABLED

 drivers/gpu/drm/xe/xe_ggtt.c        | 10 ++---
 drivers/gpu/drm/xe/xe_ggtt_types.h  |  5 ++-
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c |  2 +
 drivers/gpu/drm/xe/xe_guc.c         | 32 +++++++++++---
 drivers/gpu/drm/xe/xe_guc.h         |  1 +
 drivers/gpu/drm/xe/xe_guc_ct.c      |  1 +
 drivers/gpu/drm/xe/xe_guc_submit.c  | 86 ++++++++++++++++++++++++++-----------
 drivers/gpu/drm/xe/xe_lrc.c         |  4 +-
 drivers/gpu/drm/xe/xe_oa.c          |  7 ++-
 drivers/gpu/drm/xe/xe_pt.c          | 38 ++++++++++++----
 10 files changed, 136 insertions(+), 50 deletions(-)
