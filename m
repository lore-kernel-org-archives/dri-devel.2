Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51E606A332
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FeWZf3a7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0BA10E6FE;
	Mon, 16 Nov 2026 01:25:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF9710E239;
 Mon, 16 Nov 2026 01:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794792345; x=1826328345;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BLOuta+tVwr5HFfQ5nmDPeLu7zE+xwUDwOnQV0+6c6U=;
 b=FeWZf3a7wVLAtWnDYE4x4KhRCKoQmv4nxukW7QWoGt9kRe9pxI2cE1VE
 SusNTCqucVMUAJSB/JI1QIv7UtwwBDbiFBPTWIuQzrKVEbLVBPGnSEclV
 DcEzAB5MvNKJS/WRX77a178pAHO9AM+RcZGwbRBAD3kBvzxf3yRZU7GDC
 dbeJzLg/RLvmvjYWz5iSWYMEq1bYTTiwRC86Z4seGLdsg59q5kQVC1s23
 Iw/tm496a0T+7CI3nJhNxvuJyDIbdG4K0fPDo1bY+6QUbCHhtcGv0KTjR
 MqOrwL8yy6oxaErto+kwSc3H1VUzxKeWA06/vGqOTRS8fekW9V2wjJYF4 w==;
X-CSE-ConnectionGUID: UWFRdaqHTZ6baRHO4/hddA==
X-CSE-MsgGUID: n2IbwDEBSvm2fRv7qrYJDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3398623"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3398623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:25:44 -0800
X-CSE-ConnectionGUID: H6GJtnegRDydh1J/QZzQjw==
X-CSE-MsgGUID: GpNbJmHNQc+LMTtZ3T+KfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9295467"
Received: from emr-371.sh.intel.com ([10.112.106.129])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:25:42 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 matthew.auld@intel.com, airlied@gmail.com, simona@ffwll.ch,
 andriy.shevchenko@linux.intel.com,
 Baoli Zhang <baoli.zhang@linux.intel.com>
Subject: [PATCH 0/3] drm/xe/display: Free the KMS objects on DRM device
 release, not on unbind
Date: Mon, 16 Nov 2026 09:15:01 +0800
Message-ID: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Unbinding xe while a display server still has the DRM fd open gives
these warnings, and drm_fb_release() later walks the freed framebuffers
when the fd is closed:

  WARNING: drivers/gpu/drm/drm_mode_config.c:571 at drm_mode_config_cleanup+0x2e7/0x300
  xe 0000:00:02.0: [drm] drm_WARN_ON(!list_empty(&fb->filp_head))
  WARNING: drivers/gpu/drm/drm_framebuffer.c:833 at drm_framebuffer_free+0x87/0xa0

Since 5b6937b65e45 ("drm/xe/display: move display fini stuff to devm")
xe frees the KMS objects on unbind, but they should only be freed with
the last reference to the DRM device. drm_mode_config_init() already
registers drm_mode_config_cleanup() as a drmm action, so xe can simply
stop calling it. The first two patches prepare the shared display code
for that, with no change for i915:

1: move the hardware teardown out of the encoder ->destroy() callbacks
   into a new ->remove() hook, which still runs on unbind
2: move drm_mode_config_cleanup() out of
   intel_display_driver_remove_noirq() into the drivers
3: the actual fix, xe stops calling it

i915 keeps freeing the KMS objects on unbind for now. It frees the
display structure from its ->release() callback, before the drmm
actions run, so it can't rely on drmm without further changes.

We hit this with the LTP-DDT test TELEMETRY_XS_FUNC_TELEM_DRIVER, which
unbinds xe, on PTL with RHEL 10.3 and a v6.18.60 kernel (the trace above
is from there). It doesn't reproduce on Ubuntu, and only reproduces on
the first run after boot. My guess is that GDM holds the device on RHEL
and doesn't get it back after the first unbind/rebind.

Yanx tested the series backported to v6.18.60, the warnings are gone.
On mainline it is build-tested only.

Baoli Zhang (3):
  drm/i915/display: Tear down encoder hardware state in a separate hook
  drm/i915/display: Let the drivers free the KMS objects
  drm/xe/display: Free the KMS objects on DRM device release

 drivers/gpu/drm/i915/display/g4x_dp.c            |  8 ++++++--
 drivers/gpu/drm/i915/display/intel_ddi.c         | 16 +++++++++++-----
 .../gpu/drm/i915/display/intel_display_driver.c  | 15 ++++++++++++++-
 .../gpu/drm/i915/display/intel_display_driver.h  |  1 +
 .../gpu/drm/i915/display/intel_display_types.h   |  7 +++++++
 drivers/gpu/drm/i915/display/intel_encoder.c     |  9 +++++++++
 drivers/gpu/drm/i915/display/intel_encoder.h     |  1 +
 drivers/gpu/drm/i915/display/intel_sdvo.c        | 11 +++++++++--
 drivers/gpu/drm/i915/i915_driver.c               |  2 ++
 drivers/gpu/drm/xe/display/xe_display.c          |  4 ++++
 10 files changed, 64 insertions(+), 10 deletions(-)

-- 
2.43.0

