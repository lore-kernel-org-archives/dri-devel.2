Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19133C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651FA10E0E0;
	Thu,  9 Jul 2026 21:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SN2i6SGB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA28F10E0DF;
 Thu,  9 Jul 2026 21:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783632433; x=1815168433;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=PIh1LgA76OeuLyM7Cm+K7ONHWY0KDCAc4ueIQT0kdss=;
 b=SN2i6SGBXn02cP/0JDE0Prtyn10YkNh0GZYoYnEgAkEQSU6z/uksaK+G
 CKpEMq8c6xiFA56Y7baIP1lXZQV4K/M0xAYH9+TrajY2oflyULPfyd6A8
 9CfLpzp8a12IxIfOWxqfND7qQteuzIvuuwkQmTIwiIfVRmphzQRRCh1AZ
 3DUEWDPR2E4kcY+vqYedD6SNwnjux6UfPkqCC2KKkKxmHhSwghiJpryYd
 XBQ0Lba0vvDOlWuFWExhM54ptJTnxbWNLntDS8frZkK5VWKqXfcz5Gkvf
 PgKjYpC1z2e1HYqor0fZYzikBv735sa6JeYDjxTkY+1PU5rQGRBSunt8D Q==;
X-CSE-ConnectionGUID: 5fzRlejOR0iGUKSUsn1WGA==
X-CSE-MsgGUID: 13xfqz9lT1qRn9wlj55XKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109877636"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="109877636"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 14:27:12 -0700
X-CSE-ConnectionGUID: MTN/kHydQYCDj52Dxyfv3Q==
X-CSE-MsgGUID: XyNVjPqsQWCTeekcc09HVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254217942"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.93])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 14:27:08 -0700
Date: Thu, 9 Jul 2026 23:26:57 +0200
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
Message-ID: <alASIbW318Rl-HTv@fedora>
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

The drm-xe-fixes PR towards -rc3. This time a small number of various
driver fixes only.

Thanks,
Thomas

drm-xe-fixes-2026-07-09:
Driver Changes:
- Fix PTE index in xe_vm_populate_pgtable for chunked binds (Matt Brost)
- Wait on external BO kernel fences in exec IOCTL (Matt Brost)
- Remove duplicate include (Anas Khan)
- Free madvise VMA array on L2 flush failure (Guangshuo Li)
- Stub notifier_lock helpers when DRM_GPUSVM=n (Shuicheng Lin)
The following changes since commit 959b5016e4646b55fd2fd0438932e4c4e9ce171f:

  drm/xe/oa: Fix offset alignment for MERT WHITELIST_OA_MERT_MMIO_TRG (2026-07-02 12:29:44 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-07-09

for you to fetch changes up to f5ef65adf81da3dbce4e692e48c1754c0bb95da0:

  drm/xe/userptr: Stub notifier_lock helpers when DRM_GPUSVM=n (2026-07-09 12:09:42 +0200)

----------------------------------------------------------------
Driver Changes:
- Fix PTE index in xe_vm_populate_pgtable for chunked binds (Matt Brost)
- Wait on external BO kernel fences in exec IOCTL (Matt Brost)
- Remove duplicate include (Anas Khan)
- Free madvise VMA array on L2 flush failure (Guangshuo Li)
- Stub notifier_lock helpers when DRM_GPUSVM=n (Shuicheng Lin)

----------------------------------------------------------------
Anas Khan (1):
      drm/xe: remove duplicate <kunit/test-bug.h> include

Guangshuo Li (1):
      drm/xe: free madvise VMA array on L2 flush failure

Matthew Brost (2):
      drm/xe: Fix PTE index in xe_vm_populate_pgtable() for chunked binds
      drm/xe: Wait on external BO kernel fences in exec IOCTL

Shuicheng Lin (1):
      drm/xe/userptr: Stub notifier_lock helpers when DRM_GPUSVM=n

 drivers/gpu/drm/xe/tests/xe_pci.c  |  1 -
 drivers/gpu/drm/xe/xe_exec.c       | 22 ++++++++++++++++------
 drivers/gpu/drm/xe/xe_pt.c         | 19 +++++++++++++++++--
 drivers/gpu/drm/xe/xe_vm_madvise.c |  2 +-
 4 files changed, 34 insertions(+), 10 deletions(-)
