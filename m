Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D0BC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1282D10E0B5;
	Fri, 18 Sep 2026 09:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aXapxUfY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD2C10E0A6;
 Fri, 18 Sep 2026 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789724498; x=1821260498;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=qoCT8+OJwUfIIu6uOIUmQbA9gD0s9kE4uk26Q91uYAA=;
 b=aXapxUfYcQpE2nGOKhy3xlvd6lnorkTG2SS4nhelGCKMPZobZZMQ6zv/
 7jXQCUBuLJnc1iD42/huUIu7aF0W4FdkrxEQlJJUFuHiOYoWMvqdrGCL4
 /hwPYK3WltjX36UM9vtll+xPuyNeKE0wNwi6QMkaZHyIa7zRoRyWnU2vz
 fAXAmU3y4V2TybMAVT0te6RBBFFqH/avgFvRlP5LtwsN8BpqUhLuSmNV2
 Os5b9jL6GSodA3hwG360s/VHmaJbWC18X22M7Is5D67eYSSRr5uFNzyrO
 OITQn8QzjEBaaJRA200SZ9BWZoA8Uoj4iJmcwRwy/sd2KlEwLLUuVSovY w==;
X-CSE-ConnectionGUID: xJ5KcMiCSlabwph5sR6L6g==
X-CSE-MsgGUID: XKXK/OIVTCK4eNmIIPnjYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89151074"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89151074"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 02:41:38 -0700
X-CSE-ConnectionGUID: KCz4oVR0QHyw7LfrIpicuA==
X-CSE-MsgGUID: nsABig7KQTCPu7xDCLxf1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270637800"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 02:41:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 0/2] drm/edid: Honor overrides when DDC is unresponsive
In-Reply-To: <20260917135949.2552704-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260917135949.2552704-1-mario.limonciello@amd.com>
Date: Fri, 18 Sep 2026 12:41:34 +0300
Message-ID: <1efb1842489bc50e87ab0476e3d3ad861d6ef807@intel.com>
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

On Thu, 17 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
> DRM's EDID read helpers probe DDC before consulting debugfs or firmware
> overrides. This preserves connector-detection semantics for drivers that
> use a successful EDID read as evidence that a sink is connected, but it
> prevents drivers with independent presence detection from using an
> override when DDC is unresponsive.

IOW, your use case is that you want to use an override EDID with
reliable presence detection other than the DDC probe, and don't want to
use connector forcing.

> This affects AMD Display Core, which establishes physical presence from
> HPD before attempting to read the EDID. When a connected sink stops
> responding over DDC, the configured override is ignored and AMDGPU falls
> back to a 640x480 mode.
>
> Add an override-only EDID reader that does not access hardware, then use
> it in AMD Display Core before trying ACPI, VBIOS, or DDC sources. The new
> helper preserves DRM_FORCE_OFF handling and the existing preference for
> debugfs overrides over firmware EDIDs.

It was quite a bit of work to unify the firmware/override EDID handling
to be the same for all drivers. I'm not exactly thrilled about exposing
a mechanism to *only* get the override EDID, just to allow drivers to
deviate from the unified mechanisms.

The goal was to plug in the override at the low level, hidden away from
drivers, to make it as close to the normal case as possible. One of the
follow-up ideas, which I never really got around to, was to do the exact
same validity checking in _drm_do_get_edid() for override EDIDs as
regular EDIDs.

I'm thinking maybe we need a way to allow drivers to define a
drm_probe_ddc() alternative as a connector callback? If you set it, you
can use another mechanism for presence detection than DDC probe,
otherwise fall back to DDC probe. It could be used in the regular case
too, if you have a reliable and quicker mechanism than DDC probe.


BR,
Jani.


>
> The first patch introduces the helper. The second fixes the AMDGPU
> regression.
>
> Mario Limonciello (2):
>   drm/edid: Add an override-only EDID reader
>   drm/amd/display: Honor EDID overrides for connected sinks
>
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 14 +++++++-----
>  drivers/gpu/drm/drm_edid.c                    | 22 +++++++++++++++++++
>  include/drm/drm_edid.h                        |  1 +
>  3 files changed, 32 insertions(+), 5 deletions(-)

-- 
Jani Nikula, Intel
