Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD9606A329
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cxLlS0df
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9FD10E732;
	Thu, 26 Nov 2026 08:26:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4677310E3CF;
 Thu, 26 Nov 2026 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795681603; x=1827217603;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=noWaeRPBk/jpND9wI6fXQyukJYBKsRM97REihujLrxk=;
 b=cxLlS0df4IOMVxR5JDkcsfzLifgukO/OrPzHA5ApyLdXgVknmnBtUOJ4
 68kuR9mB9FwINebCiF/An/UX3t0Qb0jLXadj+rHHx7z8r1jJkbZpqZlKX
 gVShF5ctE3W4dO0L3WTUAoaZZUKl4T8zh4MgMP3CGaMTLVCoEXp6Y+JN4
 QnX3Q2qknTH19XGYPVBw2vhERSf2hbmGMBSvGiLjYSSLkwtBKkWL8Sc9T
 QNuJKS4ttpYOfbvx87Q0+mPjeuWP47i3B/30sgl8znNpM/i1hqsFH/cc1
 jtxH2P0uD3iSURS5Vh6QO8ZFhXDomCZkIbSXWD8pEn1bW/HePuoEnG+Io w==;
X-CSE-ConnectionGUID: L/x10WuHRWi5lOqBtTjO4w==
X-CSE-MsgGUID: /2QUqjXnQs6N93G85mtHSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4596526"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4596526"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:26:41 -0800
X-CSE-ConnectionGUID: 8kcoUOECS6qHAYBpi0jRdw==
X-CSE-MsgGUID: jJcJKyclSsyTNw31RtrycA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12401819"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.171])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:26:36 -0800
Date: Thu, 26 Nov 2026 10:26:33 +0200
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
Message-ID: <awftOYyDHW4kmxb8@jlahtine-mobl>
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

Here goes drm-intel-fixes PR towards v7.4-rc5.

Just display fixes; tackling 3 user reported screen corruption
issues and one regression for 240Hz mode loss on SCAR 18
handheld. So good stuff for the holiday gaming.

Regards, Joonas

***

drm-intel-fixes-2026-11-26:

- Fix GitLab #9575: Xiaomi Book Pro 14 2026 screen corruption
- Fix GitLab #9746: Screen corruption when enabling HDR
- Fix GitLab #9247: MSI Claw 8 AI+ screen corruption
- Fix GitLab #16854: Regression ASUS ROG Strix SCAR 18 lost mode 3840x2400@240
- Fixes for ALPM

The following changes since commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f:

  Linux 7.4-rc4 (2026-11-22 14:57:40 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-11-26

for you to fetch changes up to 202103f76df364623ef3f64303f4ed070d41476b:

  drm/i915/bios: Add quirk to allow eDP joiner on ASUS ROG Strix SCAR 18 (2026-11-24 16:12:40 +0200)

----------------------------------------------------------------
- Fix GitLab #9575: Xiaomi Book Pro 14 2026 screen corruption
- Fix GitLab #9746: Screen corruption when enabling HDR
- Fix GitLab #9247: MSI Claw 8 AI+ screen corruption
- Fix GitLab #16854: Regression ASUS ROG Strix SCAR 18 lost mode 3840x2400@240
- Fixes for ALPM

----------------------------------------------------------------
Ankit Nautiyal (3):
      drm/i915/dsc: Fix QP table index calculation for bpp selection
      drm/i915/dsc: Fix the helper range_bpg_offset()
      drm/i915/bios: Add quirk to allow eDP joiner on ASUS ROG Strix SCAR 18

Chaitanya Kumar Borah (1):
      drm/i915/dip: Write the DIP header last

Jouni Högander (2):
      drm/i915/psr: Adjust Xiaomi Book Pro 14 2026 psr2 disable quirk
      drm/i915/alpm: Track the configured transcoder lifetime

 drivers/gpu/drm/i915/display/intel_alpm.c   | 11 +++++++++--
 drivers/gpu/drm/i915/display/intel_bios.c   |  5 +++++
 drivers/gpu/drm/i915/display/intel_hdmi.c   | 17 +++++++++++++----
 drivers/gpu/drm/i915/display/intel_quirks.c | 14 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
 drivers/gpu/drm/i915/display/intel_vdsc.c   | 10 +++++-----
 6 files changed, 47 insertions(+), 11 deletions(-)
