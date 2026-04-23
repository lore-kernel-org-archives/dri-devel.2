Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F4EF99344
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA97F10E09A;
	Thu, 23 Apr 2026 07:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Cha2WyZo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09AC10E09A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776930810; x=1808466810;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version; bh=LUV8XnRCUnsUVKelFA6tEEP8QdNV49EyiwCPrDQHqRM=;
 b=Cha2WyZoatUw+d2hbIUVSUpRI3rvHINNW4dX8Rlho0hipwxo2NZQO8SJ
 FxkoR5vo1s7kFtfezURFCA36JyR+qqSNjrwK2iERogy3EA/NcbrYPJLSY
 16V94U0rEELaOy84d3ACmAwQ5Pz8lVpX7U7s37Vt1pISQr1nsvAEAadJU
 gWx70VnJgPBW4dVjfRgy+0RRveUCXJaWXYmgnbUjM9/7RAdMneK76/PaH
 u/JjBoSLBd588wmd5CyAeWRRWh5TUpDuAiB90spz4BhA1RBw4HtfLH+vU
 wUwbNE7EK2fe9MNgLJHcmcvCA2YoKhIltQUI9nN1Hr55sGPxqdlVW0KXt g==;
X-CSE-ConnectionGUID: C6qK9KPUS+uQpP4sMAGoCw==
X-CSE-MsgGUID: DU1+Zkg7QK+FnaADF3hvoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77595742"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="77595742"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 00:53:30 -0700
X-CSE-ConnectionGUID: NoF9gUg/TXCKpc3LGQhDGw==
X-CSE-MsgGUID: v1HFeeGCQDSG0PgVgTUwhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="236952177"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.142])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 00:53:28 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Vidith Madhu <vmadhu@nvidia.com>, dri-devel@lists.freedesktop.org
Subject: Re: Native DisplayID support in core DRM
In-Reply-To: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
Date: Thu, 23 Apr 2026 10:53:24 +0300
Message-ID: <b96132559af30da90436a301e68741b603492996@intel.com>
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

On Mon, 20 Apr 2026, Vidith Madhu <vmadhu@nvidia.com> wrote:
> Hi all,
> I would like to inquire about adding native DisplayID support to core DRM. 
> Native DisplayID is the anticipated successor to EDID for display metadata reporting. 
> DisplayID is already available as an EDID extension block and is widely 
> used by newer monitors and eDP notebook panels. Native DisplayID was
> officially introduced rather recently in DisplayID 2.1 (Nov 2021) and 
> requires reading the DisplayID structure directly over i2c/DDC in a 
> similar fashion to EDID. Overall, the native DisplayID structure/data 
> blocks are the same as the DisplayID2.1 EDID extension, but there are some 
> specific requirements for what sinks must populate in the native
> structure, due to the lack of an EDID base block.
>
> While no consumer displays currently utilize native DisplayID, beginning  
> this year VESA has mandated it be supported for new DP2.1 source device 
> certification submissions. Therefore, display certification
> on Linux is the most pressing motivation for native DisplayID support. 
> Beyond that, ensuring this support is present by the time consumer 
> displays start adopting it will provide a seamless consumer experience for all Linux
> display driver vendors, including NVIDIA.

By far the biggest hurdle in implementing native DisplayID support in
its own DDC address is exactly the "support" in current consumer
displays.

The specs say try the DisplayID DDC address first, and if there's
something, use it, otherwise fall back to EDID DDC address. At some
point in time I experimented with this in our CI, and the results
weren't encouraging.

Some displays return zeros or garbage, some lead to errors, some have
plain old EDID in the DisplayID DDC address. There might have been a
display that indeed had native DisplayID, not sure. But the point is,
the existing display behaviour make this fallback to plain old EDID is
going to be a bit tricky.

Some thoughts on implementation details below.

> Here are some issues I have identified in core DRM that need to be 
> considered for native DisplayID support:
>     1. A mechanism for reading and validating native DisplayID needs to be 
>        added. EDID reads in amdgpu and i915 appear to leverage 
>        drm_edid_read_ddc() -> drm_do_probe_ddc_edid(), and _drm_do_get_edid() for
>        validation. These utilities are all supplied through core DRM. Similar
>        functions should exist for native DisplayID.

No.

The exact same EDID functions should handle native DisplayID under the
hood, with no variation in drivers. The native DisplayID structure
contents should be stored in the (intentionally) opaque struct drm_edid.

IMO it would be a massive mistake to expose interfaces to let drivers do
this wrong in many different ways. One of the reasons is the old display
behaviour explained above.

>     2. drm_edid_info needs to be updated to support a native DisplayID 2.1  

There is no drm_edid_info. Maybe you're talking about struct drm_edid?

>        structure (i.e. have a drm_edid_info::displayid in addition to 
>        drm_edid_info::edid, perhaps in a union). To do this, I think we 
>        first need to maintain the full layout of a DID2.1 structure. 
>        Currently, in drm_displayid_internal.h, there are a few block structs
>        present (e.g. displayid_tiled_block,  displayid_formula_ timing_block,
>        displayid_detailed_timing_block), but there are several more data 
>        block types in DID2.1 that may be relevant if no EDID base block is
>        present (e.g. Product Identification Data Block for name, manuf. data,
>        serial number, etc).

struct drm_edid should contain a displayid member in addition to the
edid member, both as pointers to the blob that's read from DDC. struct
drm_edid should not contain parsed data, but rather the raw data.

>        Also, drm_connector should have some way to indicate that its edid_blob_ptr
>        contains DisplayID data.

I fear having the current EDID blob property only contain the native
DisplayID might amount to an ABI breakage. It all depends on how robust
the userspace handling of the data is. We might have to have a separate
blob for DisplayID.

It might be nice to read both the DisplayID and the EDID from the
display, and expose the EDID to userspace for backward
compatibility. However, I think reading the EDID when DisplayID is
present goes against the VESA spec.

>     3. update_display_info() needs to handle the case where native DisplayID is
>        being used. All of the fields of drm_display_info that are being 
>        populated from the EDID will need to be accordingly updated.
>        This includes the EDID extension work in drm_parse_cea_ext() and drm_edid_to_eld().
>        In addition, _drm_edid_connector_add_modes() will need to just parse the 
>        displayid timing blocks (already being done today from the EDID 
>        extension).

For example the CTA data block iterators in drm_edid.c already go
through both EDID and DisplayID. The DisplayID iterators just need to be
amended to handle native DisplayID in addition to DisplayID in EDID
extension.

>
>     4. There is also the question of how the user interfaces for overriding and reading
>        EDID will need to change (/sys/class/drm/cardX/edid and /lib/firmware). Should there
>        be separate nodes for native DisplayID, or should they just deal with an opaque blob
>        of bytes, and leave it up to the user/DRM to interpret whether it is EDID or native
>        DisplayID?

Per spec only one or the other should be used at a time. I think
firmware EDID and debugfs EDID override could be extended to handle
native DisplayID as well... though if we want to expose both to
userspace, might be cleaner to have them separate. This needs to be
thought out.

> We are rolling out native DisplayID support in the NVIDIA Linux drivers in an upcoming
> release; we have implemented our own reading/parsing and are able to populate 
> drm_connector::probed_modes with native DisplayID supplied modes. However, 
> due to the current gaps, we are unable to populate drm_connector::edid_blob_ptr if
> native DisplayID is being used, which leads to inconsistent state.
>
>
> Would like to hear any thoughts on this topic, or if there is a roadmap from any in-tree
> vendors to add this support.

You could always join the party, and submit your work upstream.


BR,
Jani.


-- 
Jani Nikula, Intel
