Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1064606A31D
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eiRGhn1G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB6B10E03B;
	Sat, 31 Oct 2026 15:38:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A93D10E03B;
 Sat, 31 Oct 2026 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793461085; x=1824997085;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wzqtefOnoXhh2wLLCTi0x7RHDAM/QS1EgU009coU94A=;
 b=eiRGhn1G06KuVDVrOCkL5GEs6RrFA+U6W8lxRCZ/7+VLEVp2uAjoV+Hz
 Nld6ZufiELst9vgFHqmPF4yjwn4QVHh/UGJiRFD5YTED1iBqyZbrO1Etl
 n5T7RnN+NTvwZ8kXYVFovqJz2AKXuAaIn0wyjQ/4t9dA4PyKu9vSdVem/
 lMh9CeZyrUNZWLYGagG/wXGERJlX7xLmaHT6vGa9nMpJt1Uvdt+f2OlaE
 lgJD+2Hx8mtXHrpQti2LIGTatWPKEekJIowKnIOL56YhlunXG8llaEenz
 J474jx7F1KpyILviyrNCwDidd0dolXou548jQ9uZLKIkOmqHCi7PRcpdc Q==;
X-CSE-ConnectionGUID: TmTmfBHZQ1W0+lvjVruHZQ==
X-CSE-MsgGUID: w8qW0AJ9SYOtJyIapzNH4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2094952"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2094952"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 08:38:04 -0700
X-CSE-ConnectionGUID: aFhpVpJ1RROWw55UAXyxGg==
X-CSE-MsgGUID: U+uAZbTsTgmcPeFWLPVuHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="5647598"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa004.jf.intel.com with ESMTP; 31 Oct 2026 08:38:03 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH 0/2] drm/i915/dp_mst: Avoid the 3 s ACT timeouts after the
 upstream HPD drops
Date: Sat, 31 Oct 2026 23:35:48 +0800
Message-ID: <20261031153550.444676-1-xiaolu.xie@intel.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a MTL laptop with a ThinkPad Thunderbolt 4 dock (Synaptics VMM6212) and
a TV behind it, powering the TV on makes the dock drop the upstream HPD for
about 1.76 s. The MST topology is torn down and rebuilt, and the display
stays black for about 5 s. The drm.debug log of the report shows two
"Failed to get ACT after 3000 ms, last status: 04" errors, and in both
cases the driver waits for an ACT it never triggered (timestamps from that
log):

 - 24262.495: intel_dp_retrain_link() forces a modeset on the pipe still
   bound to the old, unregistered MST connector, while the topology is being
   rediscovered. drm_dp_add_payload_part1() fails with "VCPI 1 for port ...
   not in topology", but the enable goes on and waits 3 s for an ACT, with
   no write to DPCD 0x1c0-0x1c2 in between.
 - 24267.035: userspace disables the same pipe afterwards.
   drm_dp_remove_payload_part1() prints "not in topology, not sending remove",
   and the disable waits another 3 s for an ACT.

The new connector is only registered after the first wait is over.

Patch 1 makes drm_dp_remove_payload_part1() tell whether it removed the
payload from the branch device. The existing callers ignore the return value.
Patch 2 stops retraining the link for disconnected MST streams and uses the
return value to skip the ACT and its wait on the i915 disable path.

I haven't tested this on the reporter's setup yet, the analysis is based on
the log attached to the issue.

Patch 1 touches the drm core and will also be sent to dri-devel for
drm-misc-next, it is included here for patch 2 to build.

Issue: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741

Xiao Lu (2):
  drm/dp_mst: Return whether drm_dp_remove_payload_part1() removed the
    payload
  drm/i915/dp_mst: Skip link retrain and ACT for disconnected MST
    streams

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 10 ++-
 .../drm/i915/display/intel_dp_link_training.c |  3 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 68 +++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp_mst.h   |  1 +
 include/drm/display/drm_dp_mst_helper.h       |  2 +-
 5 files changed, 68 insertions(+), 16 deletions(-)

-- 
2.43.0

