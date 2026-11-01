Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6095606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TzVl8cVo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2A710E1F2;
	Sun,  1 Nov 2026 03:38:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A76210E05F;
 Sun,  1 Nov 2026 03:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793504270; x=1825040270;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fQW4ehDKxIVr8zwN8t0mnrdTFTBMqUk8QfrnK5EX2vk=;
 b=TzVl8cVoAdDEKBdpVYfPkCzytIo7WxL6GoT71TdYDq41dV4jCxnBiS3b
 ApHk0QUuIT4tSgZvSB9+v7RQvDlcQ2mubtkssHgZtdH4TO8/Ks2YSYtrg
 fvml3UeDbWHANcG2Vb7ACXc7e2sMwUV1mNi0ex2AiUjkmAsyVUBEE1Ya6
 Ytv6MqfS3wfhQVZ4zsb3xRQedJD5Jf18FsjNCLLWfP69mDpCYozh7Jpw9
 pFJFaQj46XYGKuFJqXYXhgeXRARbxkJ+pC5aTYCkFYRTkGVcZr0uAu508
 sG3NFc1BzSr4hFz3s8hS+/9XJVY9fC0Vf6GpB4S7J9jcc9t8CrnjdpF15 w==;
X-CSE-ConnectionGUID: kpggksBVT+aJ/Gq0dIU7jw==
X-CSE-MsgGUID: xrcg7DVGQmiAHjAmLZA0RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2105633"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2105633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 20:37:49 -0700
X-CSE-ConnectionGUID: v/GLGU6MSqKJLB2j9hCVag==
X-CSE-MsgGUID: HKnTYb0cQDyRU/mrPLaYqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="5654215"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa008.jf.intel.com with ESMTP; 31 Oct 2026 20:37:47 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2 0/2] drm/i915/dp_mst: Avoid the 3 s ACT timeouts after the
 upstream HPD drops
Date: Sun,  1 Nov 2026 11:35:33 +0800
Message-ID: <20261101033535.2078860-1-xiaolu.xie@intel.com>
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
Patch 2 stops retraining the link when the MST sinks of all the active pipes
are gone, and skips the wait for the ACT at the branch if the payload wasn't
allocated or removed there.

I haven't tested this on the reporter's setup yet, the analysis is based on
the log attached to the issue.

Patch 1 touches the drm core, it is included here for patch 2 to build.

Issue: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741

v2:
 - patch 1: drm_dp_remove_payload_part1() returns true only if the payload
   was allocated to the DFP or the remote end, and not just if the port is
   in the topology (Sashiko). Kernel-doc updated accordingly.
 - patch 2 (Sashiko):
   - Skip the link retrain only if all the active pipes have a disconnected
     MST sink, otherwise the link isn't retrained when some streams stay.
   - Check that the port is in the topology too, as the connector
     unregistration is asynchronous.
   - Keep the ACT generation and the wait for it in the source, skip only
     the wait at the branch.
   - Do the same on enable, where the wait at the branch was unguarded.
 - v1 was sent twice, the first time by mistake without threading:
   https://patchwork.freedesktop.org/series/177320/

Xiao Lu (2):
  drm/dp_mst: Return whether drm_dp_remove_payload_part1() removed the
    payload
  drm/i915/dp_mst: Skip link retrain and the ACT wait for disconnected
    MST streams

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 ++++-
 .../drm/i915/display/intel_dp_link_training.c |  8 +++
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 69 +++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp_mst.h   |  1 +
 include/drm/display/drm_dp_mst_helper.h       |  2 +-
 5 files changed, 82 insertions(+), 15 deletions(-)

-- 
2.43.0

