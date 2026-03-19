Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5734B107526E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE77B10E8BC;
	Thu, 19 Mar 2026 07:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RI+AxQc2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682B810E8C4;
 Thu, 19 Mar 2026 07:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773904663; x=1805440663;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=gpPuIYGN29l1jhxOViW6OhhisuOVrkgdliiw0h0oEtk=;
 b=RI+AxQc26UYtEHBlVWcu5Jv+yChr9fWrMNAC7tRQ3bYkGYg5AhED0C5s
 gRFf+6nJp9qTTyO7+KEk9YuJB7/jpE07JFnYWHMrTBiX7MS5ktyeDA1Kf
 OPZ5xVdX/Go42hel4mv0sYQ+zMTNWa3fm9Y7UTmlFhjrqHeHE5YPWjgm1
 ErnjwKKEB++9q/NwVxUGURJR42XFMoGtft0z8+OXLsEhcxxIRdRQuZlww
 oWT4NFuoivFN9Qqg44N9Z1ISIWJsA69hD56iSM4tpxWBa8FaZT09v3XB7
 8TQdwRRWGGMts11sMISRI76RDtcVEcgGcJbi8hTdO7uhL+5zcbKqz/X25 g==;
X-CSE-ConnectionGUID: ubtmS65cQtS9HIuFi5wB0Q==
X-CSE-MsgGUID: ytCURbXPSCKhHkZLhi7cuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73985261"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="73985261"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 00:17:42 -0700
X-CSE-ConnectionGUID: gkHZeAzdQViCtCfTfDbJbg==
X-CSE-MsgGUID: AH3z/0cKRrKlxCnMhgLwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="218370413"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.124])
 by fmviesa006-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:17:24 -0700
Date: Thu, 19 Mar 2026 09:17:22 +0200
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
Message-ID: <abujAnD-lRDCVSKg@jlahtine-mobl>
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

Here goes drm-intel-fixes PR towards 7.0-rc5.

Fix for #15771: Screen corruption and stuttering on P14s w/ 3K display and another PSR fix.
Two NULL pointer fixes for corner cases.

Regards, Joonas

***

drm-intel-fixes-2026-03-19:

- Fix #15771: Screen corruption and stuttering on P14s w/ 3K display
- Fix for PSR entry setup frames count on rejected commit
- Fix OOPS if firmware is not loaded and suspend is attempted
- Fix unlikely NULL deref due to DC6 on probe

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-03-19

for you to fetch changes up to 0162ab3220bac870e43e229e6e3024d1a21c3f26:

  drm/i915/gt: Check set_default_submission() before deferencing (2026-03-18 11:53:20 +0200)

----------------------------------------------------------------
- Fix #15771: Screen corruption and stuttering on P14s w/ 3K display
- Fix for PSR entry setup frames count on rejected commit
- Fix OOPS if firmware is not loaded and suspend is attempted
- Fix unlikely NULL deref due to DC6 on probe

----------------------------------------------------------------
Imre Deak (1):
      drm/i915/dmc: Fix an unlikely NULL pointer deference at probe

Jouni Högander (2):
      drm/i915/psr: Disable PSR on update_m_n and update_lrr
      drm/i915/psr: Compute PSR entry_setup_frames into intel_crtc_state

Rahul Bukte (1):
      drm/i915/gt: Check set_default_submission() before deferencing

 drivers/gpu/drm/i915/display/intel_display_power_well.c | 2 +-
 drivers/gpu/drm/i915/display/intel_display_types.h      | 1 +
 drivers/gpu/drm/i915/display/intel_dmc.c                | 3 +--
 drivers/gpu/drm/i915/display/intel_psr.c                | 7 +++++--
 drivers/gpu/drm/i915/gt/intel_engine_cs.c               | 3 ++-
 5 files changed, 10 insertions(+), 6 deletions(-)
