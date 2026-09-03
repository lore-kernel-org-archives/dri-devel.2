Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A98C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE5C10F619;
	Thu,  3 Sep 2026 16:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IVg1HJxv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B2C10E1A5;
 Thu,  3 Sep 2026 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788454335; x=1819990335;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4g74dxjAb6uKZrmWQIm7hKsaV8wMzF98QTi2SJ6D90c=;
 b=IVg1HJxvXvhP1SdwQDscg6w0mz0uv0gpvTFwZkgbZ6wGRNOQEJv46+YD
 ZFjQQfRu7zNkb/J0a5XamB+ShNXPwSXPwLd06h7aLawmNWwNvD6kphIL0
 DHEQ9xL49dGnDHrYf4bfSSbc+Grkj4kTP4v2atQbfslyxESLDTc9pJadv
 34ZCIsNQEfJYXKmsC3gwVVq1FdZGQSRPDtBbF4IQgS9jVCC4PmB1kcVUt
 7QQIbcJ8iF5Dv5WfAdcKSfQazNw2bSe2aG59p5vT7ZKK+jLQ3JmxBq9BO
 VjB4uVjsgLYkGIOB9m4QlAiJ62dg8Hs4Kj//sLk5K/3fNjyMKr+0n6nVe Q==;
X-CSE-ConnectionGUID: WVKfDSxTTEC25wJ6h3waRQ==
X-CSE-MsgGUID: kdK4nBwtSAyeLufoUfjoLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87884100"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87884100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:52:14 -0700
X-CSE-ConnectionGUID: hu8K/60wTxKnAJkbiUrGsw==
X-CSE-MsgGUID: Z9xzawxASkmXEzPLNL7jQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="265449898"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.170])
 by fmviesa006-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 09:52:11 -0700
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
Date: Thu, 03 Sep 2026 19:52:06 +0300
Message-ID: <affe11af9d5eb9dc6f906441495cb843f9d4817c@intel.com>
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


Hi Dave & Sima -

drm/i915 display fixes for v7.3-rc2.

Half of these were already in Rodrigo's fixes pull request for v7.2
final [1], but that one was somehow missed. Now rebased on v7.3-rc1.

BR,
Jani.


[1] https://lore.kernel.org/r/an23lmV9ktpiHnTN@intel.com


drm-intel-fixes-2026-09-03:
drm/i915 fixes for v7.3-rc2:
- Drop an accidentally duplicated panel fitter call in DP MST
- Fix DDI clock programming for Cx0 and LT PHY
- Fix PTL CDCLK handling at probe, causing a glitch
- Fix dg2_power_well_count() return type
- Fix a NULL pointer deref at forced probe
- Fix selective fetch disable

BR,
Jani.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2=
026-09-03

for you to fetch changes up to 3785d40831ba5601296283e0197e10e089392757:

  drm/i915: Guard against NULL driver_data in i915_pci_probe() (2026-08-31 =
12:56:49 +0300)

----------------------------------------------------------------
drm/i915 fixes for v7.3-rc2:
- Drop an accidentally duplicated panel fitter call in DP MST
- Fix DDI clock programming for Cx0 and LT PHY
- Fix PTL CDCLK handling at probe, causing a glitch
- Fix dg2_power_well_count() return type
- Fix a NULL pointer deref at forced probe
- Fix selective fetch disable

----------------------------------------------------------------
Chaitanya Kumar Borah (1):
      drm/i915/dp_mst: Remove duplicate intel_pfit_compute_config() call

Deepanshu Kartikey (1):
      drm/i915: Guard against NULL driver_data in i915_pci_probe()

Nemesa Garg (1):
      drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable

Suraj Kandpal (3):
      drm/i915/ddi: add helper to compute DDI clock frequency
      drm/i915/cx0: program DDI_CLK_VALFREQ with DDI clock frequency
      drm/i915/lt_phy: program DDI_CLK_VALFREQ with DDI clock frequency

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
      drm/i915/cdclk: Fix dg2_power_well_count() return type

 drivers/gpu/drm/i915/display/intel_cdclk.c         | 10 ++++++----
 drivers/gpu/drm/i915/display/intel_cursor.c        | 15 ++++++++++-----
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |  5 +++--
 drivers/gpu/drm/i915/display/intel_ddi.c           | 11 +++++++++++
 drivers/gpu/drm/i915/display/intel_ddi.h           |  1 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  4 ----
 drivers/gpu/drm/i915/display/intel_lt_phy.c        |  6 ++++--
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 15 ++++++++++-----
 drivers/gpu/drm/i915/i915_pci.c                    |  3 +++
 9 files changed, 48 insertions(+), 22 deletions(-)

--=20
Jani Nikula, Intel
