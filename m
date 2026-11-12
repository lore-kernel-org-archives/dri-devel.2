Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD72606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6QbMdWN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16E510EA8A;
	Thu, 12 Nov 2026 06:16:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A6110E57F;
 Thu, 12 Nov 2026 06:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794464185; x=1826000185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o3UbyQg4m8954gJXiW3ra3XlrNaURa4ZmkuO87hf5t8=;
 b=i6QbMdWNi/9/LG5GxI1YDaMIHlDY8OQqQAxANqJsIrqAe2Y9sj9xd9CA
 cemB1Kp2bZ7LuTaxEv9EDDNrmur3ckQQrD5gSPH2v9XEXGtUN6oz+Rsz5
 IptSa2bC8IC3FpiFQy+MBHdORFOXbTL9H0Z+a2nAhE1FErRdp72ueU1DR
 VJAKw4/4UQ/Qv4mJec1barqswKEYUyrZeweDOp0mklu1wsJeapzT9CpXl
 HmpTo5+w754KyZBCcPLmD+ToCypra+22FNmhpDrFltzY1PTFVR0TSrhNh
 9GTXgLigyVqQIbfao68rulTvc3vC16F5rlyZEb837yfwn/j11zYUS7JYP w==;
X-CSE-ConnectionGUID: baowdD1cTp+RzRruCl2omQ==
X-CSE-MsgGUID: Iob+sKvuR46Mk8PvN2J8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3245285"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3245285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 22:16:25 -0800
X-CSE-ConnectionGUID: I7mHiDocTAGXs/ScezK+NA==
X-CSE-MsgGUID: jO3VD0o6SYq0+Lk2ggF7/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8458635"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa003.jf.intel.com with ESMTP; 11 Nov 2026 22:16:22 -0800
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Xiao Lu <xiaolu.xie@intel.com>, Alexon Oliveira <alolivei@redhat.com>,
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH v2 2/2] drm/i915/dp_mst: Skip link retrain and the ACT
 wait for disconnected MST streams
Date: Thu, 12 Nov 2026 14:14:13 +0800
Message-ID: <20261112061413.318164-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101033535.2078860-3-xiaolu.xie@intel.com>
References: <20261101033535.2078860-1-xiaolu.xie@intel.com>
 <20261101033535.2078860-3-xiaolu.xie@intel.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alexon Oliveira (the reporter) tested v2 of this series and gave his
Tested-by on the cover letter. Repeating it here, as patchwork does not
carry a tag from the cover letter over to the individual patches.

He tested on a ThinkPad P1 Gen 7 (Meteor Lake) with a Lenovo ThinkPad
Thunderbolt 4 Dock (Synaptics VMM6212) and a Samsung TV, with Fedora 44
kernel 7.2.15 and drm_display_helper.ko and i915.ko rebuilt with both
patches. The "Failed to get ACT after 3000 ms" errors, 3 without the
patches, are gone, and the new TV connector is connected 2.48 s after the
HPD drop instead of 8.44 s.

  https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741

For reference, the commit message of v2:

> drm/i915/dp_mst: Skip link retrain and the ACT wait for disconnected MST streams
>
> When a dock drops the upstream HPD, for instance when a TV behind it is
> powered on, the MST topology is torn down and the MST connectors get
> unregistered, while the CRTCs stay bound to them in the atomic state until
> userspace disables them.
>
> After the HPD is back, the link status of the link reads as all zeros, so
> intel_dp_retrain_link() selects the pipe still bound to the old MST
> connector and forces a modeset on it, while the topology is being
> rediscovered. drm_dp_add_payload_part1() fails, as the port is not in the
> topology anymore, but the enable sequence carries on and waits for an ACT
> at the branch that is never triggered, since nothing was written to DPCD
> 0x1c0-0x1c2:
>
>   [drm] *ERROR* Failed to get ACT after 3000 ms, last status: 04
>
> The same wait happens when userspace disables the stale pipe afterwards,
> as drm_dp_remove_payload_part1() doesn't remove the payload of a port that
> is not in the topology. The new connector only gets registered after these
> waits are over.
>
> Fix this by:
>
> - Not retraining the link if the MST sinks of all the active pipes are
>   gone. If any stream is still connected all the pipes are kept, as the
>   link only gets retrained after all the streams on it are disabled.
>
> - Only waiting for the ACT at the branch if the payload was allocated to
>   the DFP on enable, and if drm_dp_remove_payload_part1() removed it from
>   the branch on disable. The ACT generation and the wait for it in the
>   source are left as they were.
>
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741
> Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>

Tested-by: Alexon Oliveira <alolivei@redhat.com>
