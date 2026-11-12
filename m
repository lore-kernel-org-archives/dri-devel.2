Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800A606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LMW6WgMG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1082010E57E;
	Thu, 12 Nov 2026 06:16:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1CD10E531;
 Thu, 12 Nov 2026 06:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794464181; x=1826000181;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0mpmoTRLu426T5RAVIn33ucXoQ0Iwd7F/3IT7fyaf9g=;
 b=LMW6WgMG7KdNGY9tCF5fMfNzq6n4SaO9RTjcULlyOXdzT2tZcO64NfhM
 u4igSwaOR5tp1shRVLQw1Wioxsew7O/HbCbBtvg3k1mH6EkiQ11LKRhnx
 hAakjglf292ODf1RLb1c73ZPaKKmt2kOkFw04UPRy9Ik2iKjLKOi/T3nD
 mgwLSb3ayIcfdOVUlpRsgZBIdlkRetAYOerhM4dVULo4hRQ8h7rohNV7B
 lqADjhlUVgNmuvB1cxixWnZgq33d06lhUaSlBzn5aFo/UO37ZbDwbHheN
 9YYXqgPPuGHfHB+sLmEmXp9uXDfzW7F3eFFLtuRb/hvoJWsgAMAV1ZrcL A==;
X-CSE-ConnectionGUID: atxKjgW6Tcy6iF076H7q8A==
X-CSE-MsgGUID: rK2OfndSQeiQdeaIYgMbWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3245279"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3245279"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 22:16:21 -0800
X-CSE-ConnectionGUID: 18N+ri1fRLqTuyY42VmTFw==
X-CSE-MsgGUID: e/6dOnCUTueXxRjBeHUGLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8458615"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa003.jf.intel.com with ESMTP; 11 Nov 2026 22:16:18 -0800
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Xiao Lu <xiaolu.xie@intel.com>, Alexon Oliveira <alolivei@redhat.com>,
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH v2 1/2] drm/dp_mst: Return whether
 drm_dp_remove_payload_part1() removed the payload
Date: Thu, 12 Nov 2026 14:14:09 +0800
Message-ID: <20261112061409.318154-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101033535.2078860-2-xiaolu.xie@intel.com>
References: <20261101033535.2078860-1-xiaolu.xie@intel.com>
 <20261101033535.2078860-2-xiaolu.xie@intel.com>
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

> drm/dp_mst: Return whether drm_dp_remove_payload_part1() removed the payload
>
> drm_dp_remove_payload_part1() doesn't send the removal of a payload to the
> branch devices if the port of the payload is not in the topology anymore.
> The caller can't tell, so it generates the ACT and waits for it afterwards,
> polling DPCD 0x2c0 for up to 3 seconds, although the payload table of the
> branch devices wasn't changed and the ACT will never be handled.
>
> Return whether the removal was sent, so that drivers can skip the ACT in
> the other case. The existing callers ignore the return value and are not
> affected.
>
> Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>

Tested-by: Alexon Oliveira <alolivei@redhat.com>
