Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B52BC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556CD10E6A8;
	Tue, 22 Sep 2026 09:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WunSJF4r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE8810E697;
 Tue, 22 Sep 2026 09:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790069722; x=1821605722;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=qnDF93QjcAKgkMEa8QZJDiYcG6EYGErzkklEZ/hYGnY=;
 b=WunSJF4rVQuJ1stjjzficaL/l0DV2FhLV9gqc4gJE4k9Jvlho+2SM+Dt
 5KGGSP9g0LxML20/etCfY07E+g6Ot27iHWIqwmaSGLkB/r3E1TvDBTap5
 248YwU78rdxYgLLO7l64jua5kcTzzMDWJARe4/G1ScuXonwVwv+m6enkl
 mqcXHao8ZZIxtnmKNPKCuKgZTCN1oNRoFQNy1AwkdK/2SKq7LhSY4mGmp
 +/mi5hGCHebtYGmCULYUAreFOf35okcmsHFVt34+wsfGCpdpREoMJWZd8
 /ufwy2BejxcFZCjVJxXDLUrnqN5BB4p6kH56jwfVYnunl9yyEXwOp4jiC g==;
X-CSE-ConnectionGUID: R5peXyH+Rj2csdsG5v+BKQ==
X-CSE-MsgGUID: 338Ua2BQSAWXeACbye0Vaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89790828"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="89790828"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 02:35:22 -0700
X-CSE-ConnectionGUID: qNBjKUdvT1Gtp3PsDCWBeg==
X-CSE-MsgGUID: lqp1fhNLTnyN5vWYnna0xA==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 02:35:19 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Xiao Lu <xiaolu.xie@intel.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com, lyude@redhat.com,
 David.Francis@amd.com, Xiao Lu <xiaolu.xie@intel.com>
Subject: Re: [PATCH v2 0/2] drm/dp/mst: fix MST payload PBN accounting
In-Reply-To: <20260922092647.2263962-1-xiaolu.xie@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
Date: Tue, 22 Sep 2026 12:35:16 +0300
Message-ID: <29cbe9a712812effa11c3e8f9c830a0fda9eb7ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 22 Sep 2026, Xiao Lu <xiaolu.xie@intel.com> wrote:
> v2: Send the two related patches together as a series, as requested
> by Jani. No code changes from v1.

I bounced this series to intel-xe@lists.freedesktop.org as well, since
the display code is shared with xe, and we want to run xe CI on it too.

MAINTAINERS should indicate this. For future reference, please send
Intel display patches to both intel-xe and intel-gfx mailing lists.

Thanks,
Jani.

>
> This series fixes two related issues in MST payload bandwidth
> accounting that together caused 4K@60Hz to fail alongside two
> 1080p@60Hz displays in a 3-display MST daisy-chain topology
> (PS8650 hub -> ViewSonic VP2468 x2 -> Lenovo Pro 27UD-10).
>
> Patch 1 fixes the PBN value passed in the ALLOCATE_PAYLOAD sideband
> request. The driver was using a TU-aligned PBN (e.g. 537) instead of
> the actual video stream bandwidth (e.g. 496 for 1080p@59.94Hz),
> inflating the requested PBN and causing -ENOSPC failures for
> configurations that should fit within the available link bandwidth.
>
> Patch 2 tracks the allocated_pbn returned in the ALLOCATE_PAYLOAD
> reply, and uses it alongside @pbn for bandwidth limit checks. This
> ensures that any per-hop capacity constraints from intermediate MST
> branches are correctly reflected in the source-side bandwidth check.
>
> Xiao Lu (2):
>   drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request to use actual video bandwidth
>   drm/dp/mst: track allocated_pbn from ALLOCATE_PAYLOAD reply
>
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 24 ++++++++++++++----
>  drivers/gpu/drm/i915/display/intel_dp_mst.c   | 24 +++++++++++------
>  include/drm/display/drm_dp_mst_helper.h       | 10 +++++++
>  3 files changed, 46 insertions(+), 12 deletions(-)

-- 
Jani Nikula, Intel
