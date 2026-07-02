Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10B8C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B91610F156;
	Thu,  2 Jul 2026 06:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VGZQ0C+w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7317610E459;
 Thu,  2 Jul 2026 06:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782975445; x=1814511445;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Wby2xh2SHoZaRyG4RXixcOB6t/4d0RxplKwjCtFpIlg=;
 b=VGZQ0C+wsCdcAqpbhfnU4up3/L49pyNtbnZ5XsdWbV0FHwZ7g4S+U/r0
 QXH0yj4J8C1LYHAauEb7JRsu5SVhOpu83k0JpsBpRfIIIVuXtZ/RekU0w
 efzSB0AJEjXa01kvLzCpEmNpMv8mik5hK5OygvYRZuS7qs+2HRvWePj2+
 6bf/Nn9c0l4Zhq5f24e4Vcr/u0AZ8R/oqDFd9KK38JAo26wPryq5BaHAT
 zt7MPNDJGTQ15dX1N0NN9bkA5LoEDGr+hpSkYBxonPNbpI9amptESUign
 rckA6xkKXuiz54jgaPp7yajOF12hWwdVanUBe24xC2YDzcrOQEVf/auZj w==;
X-CSE-ConnectionGUID: grjFhF5QTe2eF0SyJuVjtw==
X-CSE-MsgGUID: RgrJe5MITiaFii/xWaTLWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83587982"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="83587982"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 23:57:17 -0700
X-CSE-ConnectionGUID: LFUnjvcbT2eLuPNfyIMqAw==
X-CSE-MsgGUID: 6WTj3a7CTOO/Llzf0h6IQw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.199])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 23:57:11 -0700
Date: Thu, 2 Jul 2026 09:57:08 +0300
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
Message-ID: <akYLxDea3kEyHqJA@jlahtine-mobl>
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

Here goes drm-intel-fixes PR towards v5.2-rc2.

One near-NULL deref fix for GFP_ATOMIC OOM, couple of HDCP robustness
fixes and two input validation fixes for BIOS data and EDID.

Noteworthy, all of the bugs were reported with help from AI-assisted
static analysis. And there are more on the mailing list.

Regards, Joonas

***

drm-intel-fixes-2026-07-02:

- Input validation fixes for BIOS and EDID (Jani)
- Fix HDCP code buffer overflow and seq_num_v monotonic increase check (Jani)
- Fix near-NULL deref in i915_active during GFP_ATOMIC exhaustion (Joonas)

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-07-02

for you to fetch changes up to 2084503f2d087bf956198e7f6eb25b03a7049cb2:

  drm/i915/bios: range check LFP Data Block panel_type2 (2026-07-01 09:12:33 +0300)

----------------------------------------------------------------
- Input validation fixes for BIOS and EDID (Jani)
- Fix HDCP code buffer overflow and seq_num_v monotonic increase check (Jani)
- Fix near-NULL deref in i915_active during GFP_ATOMIC exhaustion (Joonas)

----------------------------------------------------------------
Jani Nikula (4):
      drm/i915/hdcp: check streams[] bounds before overflow
      drm/i915/hdcp: require monotonically increasing seq_num_v
      drm/i915/vrr: require valid min/max vfreq for VRR
      drm/i915/bios: range check LFP Data Block panel_type2

Joonas Lahtinen (1):
      drm/i915: Return NULL on error in active_instance

 drivers/gpu/drm/i915/display/intel_bios.c | 36 ++++++++++++++++++++++++-------
 drivers/gpu/drm/i915/display/intel_hdcp.c | 12 +++++++----
 drivers/gpu/drm/i915/display/intel_vrr.c  |  4 ++++
 drivers/gpu/drm/i915/i915_active.c        |  7 +++++-
 4 files changed, 46 insertions(+), 13 deletions(-)
