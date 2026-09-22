Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168D2C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6192710E679;
	Tue, 22 Sep 2026 09:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Blg7rAsF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3958510E678;
 Tue, 22 Sep 2026 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790069353; x=1821605353;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HtrgWIIQZix5LMrfOtXVjbMi27LrI+B/Qp1miUFhUNU=;
 b=Blg7rAsFidQSVk0YBBgwB/07mt86lgxRXNTziXAfN5/v1MwHtNaLqxQO
 y0YQng4Vnc/OUwncm206KncMWMOzexoldN6vpz2dOqwbGVeMGzUrHcgJN
 RHxzmEOwRytuF7hVPdRg8optThZzYbXhs6NVV3hHRNLPPeLnxXKsJcZ+i
 yvFCnyFgtTx61XRHFjY1OR8EEBartL/VU2Qh31GfQnQ1VWlP9jAYp6qoX
 hal3YQHIkqNYN+LhXokEC7WaLUBDCvhs4BD6NQ0enLEkHksmaQciwE8A9
 squsccKdbz5WXc6l/fTTIHpi4dKli8kJ1SaCNbYzpRS0zn9WpFLMylkOm g==;
X-CSE-ConnectionGUID: 0Fyz2akjSgi7z56/MnHeDw==
X-CSE-MsgGUID: rkVx/A3CR1uXKGtAD9/fzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108154026"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108154026"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 02:29:12 -0700
X-CSE-ConnectionGUID: dAKN37joSCSh6mzO6fPN2g==
X-CSE-MsgGUID: s85egI9ZRem4HGtldT7sEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299295818"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa002.fm.intel.com with ESMTP; 22 Sep 2026 02:29:09 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tvrtko.ursulin@linux.intel.com, lyude@redhat.com, David.Francis@amd.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH v2 0/2] drm/dp/mst: fix MST payload PBN accounting
Date: Tue, 22 Sep 2026 17:26:45 +0800
Message-ID: <20260922092647.2263962-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

v2: Send the two related patches together as a series, as requested
by Jani. No code changes from v1.

This series fixes two related issues in MST payload bandwidth
accounting that together caused 4K@60Hz to fail alongside two
1080p@60Hz displays in a 3-display MST daisy-chain topology
(PS8650 hub -> ViewSonic VP2468 x2 -> Lenovo Pro 27UD-10).

Patch 1 fixes the PBN value passed in the ALLOCATE_PAYLOAD sideband
request. The driver was using a TU-aligned PBN (e.g. 537) instead of
the actual video stream bandwidth (e.g. 496 for 1080p@59.94Hz),
inflating the requested PBN and causing -ENOSPC failures for
configurations that should fit within the available link bandwidth.

Patch 2 tracks the allocated_pbn returned in the ALLOCATE_PAYLOAD
reply, and uses it alongside @pbn for bandwidth limit checks. This
ensures that any per-hop capacity constraints from intermediate MST
branches are correctly reflected in the source-side bandwidth check.

Xiao Lu (2):
  drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request to use actual video bandwidth
  drm/dp/mst: track allocated_pbn from ALLOCATE_PAYLOAD reply

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 24 ++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp_mst.c   | 24 +++++++++++------
 include/drm/display/drm_dp_mst_helper.h       | 10 +++++++
 3 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.43.0
