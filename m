Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF8606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jqclDUGi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE6211277D;
	Fri, 30 Oct 2026 12:03:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3379A112771;
 Fri, 30 Oct 2026 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361801; x=1824897801;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=weUE8gVpJF021zbJmr0WJ9Ufg0rNj5zAaTx4RI3ZapY=;
 b=jqclDUGikATc8EKW6fuucmwflPGuWBH239s5pvCkyzMHVeELtSXcVseD
 o0L/6ouKgfu0H84ZWA7WApCJ2e+XIOxoxDD9oHDA6+DBMlJTpBdV5pFlf
 +1YshzdxlfY5TEM9tM/DKWo9A/WJN30Wh2e9IpG7rBaFA6bbDjGoiNAGN
 +AEFuCwVXkP9A25nfvXrOBPeEGh4qy0Znmf55oOE8Pf7NunsSHnwYgeIM
 9QWLdrryQ7lndE1M9+3RcOF37G9JOX1QMEvo8NUfTEghlFzeCFNMhReIO
 nRTkgz33hhqru3J7IsOQ4gvy26gnrbjpEDd5GxftZ5lngoxSVL+N4yL0K Q==;
X-CSE-ConnectionGUID: SLLnYs+rQs+Ev9dD/df/jQ==
X-CSE-MsgGUID: 7ABaNZS7QumWhemxSHrq+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2149936"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2149936"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:21 -0700
X-CSE-ConnectionGUID: 6jL5ULe6SyuYlCf/dsxJXw==
X-CSE-MsgGUID: sNKWR2OiSD6Ec1urGz2AoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5435746"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:20 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 00/13] drm/dp,
 drm/i915: conversions from seq_file to drm_printer
Date: Fri, 30 Oct 2026 14:03:03 +0200
Message-ID: <cover.1793361738.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I've had this in a branch since at least April, seems useful.

Jani Nikula (13):
  drm/dp: pass struct drm_printer to drm_dp_downstream_debug()
  drm/dp: prefer drm_printf_indent() over inline \t
  drm/i915/debugfs: pass struct drm_printer to intel_plane_info()
  drm/i915/debugfs: pass struct drm_printer to crtc_updates_info()
  drm/i915/debugfs: convert crtc_updates_info() to use
    drm_printf_indent()
  drm/i915/debugfs: pass struct drm_printer to intel_scaler_info()
  drm/i915/debugfs: pass struct drm_printer to intel_encoder_info()
  drm/i915/debugfs: pass struct drm_printer to intel_crtc_info()
  drm/i915/debugfs: pass struct drm_printer to
    intel_{dp,dp_mst,hdmi}_crtc_info()
  drm/i915/debugfs: pass struct drm_printer to intel_hdcp_info()
  drm/i915/debugfs: refactor intel_seq_print_mode() into
    intel_print_mode()
  drm/i915/debugfs: pass struct drm_printer to intel_connector_info()
  drm/i915/debugfs: prefer drm_printf_indent() over inline \t

 drivers/gpu/drm/display/drm_dp_helper.c       |  39 ++-
 .../drm/i915/display/intel_display_debugfs.c  | 250 +++++++++---------
 drivers/gpu/drm/i915/display/intel_hdcp.c     |  27 +-
 drivers/gpu/drm/i915/display/intel_hdcp.h     |   4 +-
 include/drm/display/drm_dp_helper.h           |   3 +-
 5 files changed, 160 insertions(+), 163 deletions(-)


base-commit: 29f9258a2788a1066c0910c480e65c80887f4d20
-- 
2.47.3

