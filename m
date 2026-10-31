Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D28606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AMnnisAt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4670710E25B;
	Sat, 31 Oct 2026 15:47:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1EF10E043;
 Sat, 31 Oct 2026 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793461632; x=1824997632;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SQCJPG9Jekz3Ldk06UUmhh7Jgou3nCmbKt/YtJzh7YE=;
 b=AMnnisAtJy0nVEh91/sEouaeRfuf8gBrLAViSMCxfOvLEXBmej9ITIrx
 eArJcx6YLaXBWREJj91O3Gd1xcuUgWSCSlddVx4HSoJlISt2EKJaCS07b
 CT2B8oWQslAcdM4ZqxaZtQRw7BvyteyjDPdIzffSIIVz4QswKVngBtgFu
 H2+3MWBAdoDRb2I7hFTypRgeFRkqio4RyNqZLylFNUooqCJAOWCVpN9qP
 GNYbZKPRA+FQMv3TnSNIZTGiU8I2Uc3C4L5MPG2Smt8p9lp+netk4YFtU
 wtVyncR09dJL3F9GY2eqkQM9F//8D+pxSPegvWdPUZn8RrVFue5cGn137 w==;
X-CSE-ConnectionGUID: PpbSJMpuSQCEN4mRh7D8ug==
X-CSE-MsgGUID: uIGz7w9KRDyPhnwGJstU0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2310831"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2310831"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 08:47:11 -0700
X-CSE-ConnectionGUID: ySCmWwLzQ5+BBskRfl/9iQ==
X-CSE-MsgGUID: lgDXeRd3SGCsgqYWpa1YjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="7519022"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa011.fm.intel.com with ESMTP; 31 Oct 2026 08:47:09 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH 0/2] drm/i915/dp_mst: Avoid the 3 s ACT timeouts after the
 upstream HPD drops
Date: Sat, 31 Oct 2026 23:44:54 +0800
Message-ID: <20261031154456.465469-1-xiaolu.xie@intel.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resending with proper threading, the first send had no In-Reply-To headers.
There are no code changes.

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

