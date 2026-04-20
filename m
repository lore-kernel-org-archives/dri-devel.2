Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E03AF5A8B9
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E4B10E73E;
	Mon, 20 Apr 2026 20:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Mi1ca8tJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC2010E73E;
 Mon, 20 Apr 2026 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776716185; x=1808252185;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=oMtMJLf468skbAvPUkah2zUaPhN+UoubHT4hynUdiKg=;
 b=Mi1ca8tJccELmflNjVzH+730c0RcCn6nQlq0LaAJuL6DWBqfEXZQSUgZ
 hN6Cs/TyubCM1Uat6gcYvvq9lXLFw7tgTD5GUQZVCs118aGTJHbc80pYU
 vqV5HfG5/Ank6R08xgpv4YzBCZnLfizJEwb1cvLGnuUBjTnVV0AjvS4z/
 zbpZJgIy9CYyTxI9kWic98SH9WmG833UizebPpH92R1JeA7wgYeExoiXb
 gAr4LrtaXKE4YsCE2UHm7beGsDTUoBpdMkk/ju+KJldHG1pep+WKrDzE0
 vrUwD+t6V10utFiVqt+EX5ZeYPiScugis8cKoSeL1FQEzzgxhLvHNhMvq w==;
X-CSE-ConnectionGUID: ip2dgmj9SGyTZuIqRw8tbw==
X-CSE-MsgGUID: MAoYUAMwS5GaAH66BCPGUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88258280"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="88258280"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 13:16:25 -0700
X-CSE-ConnectionGUID: sftt6tfqT3OWhOU9fqlC6A==
X-CSE-MsgGUID: F5ikM8XuROizasin1S99UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="255080203"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.159])
 by fmviesa002-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:16:23 -0700
Date: Mon, 20 Apr 2026 23:16:20 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 Simon Ser <contact@emersion.fr>, xorg-devel@lists.x.org
Subject: Re: Native DisplayID support in core DRM
Message-ID: <aeaJlED2e1ZXsLlt@intel.com>
References: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Mon, Apr 20, 2026 at 02:51:18PM -0500, Vidith Madhu wrote:
> Hi all,

Exposing the native DisplayID blob will need userspace support as well.
CCing some folks...

I think if people want to implement this before actual displays are
available then what would be needed are some reasonable sample
DisplayIDs so that the code can actually be tested.

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
> 
> Here are some issues I have identified in core DRM that need to be 
> considered for native DisplayID support:
>     1. A mechanism for reading and validating native DisplayID needs to be 
>        added. EDID reads in amdgpu and i915 appear to leverage 
>        drm_edid_read_ddc() -> drm_do_probe_ddc_edid(), and _drm_do_get_edid() for
>        validation. These utilities are all supplied through core DRM. Similar
>        functions should exist for native DisplayID.
> 
>     2. drm_edid_info needs to be updated to support a native DisplayID 2.1  
>        structure (i.e. have a drm_edid_info::displayid in addition to 
>        drm_edid_info::edid, perhaps in a union). To do this, I think we 
>        first need to maintain the full layout of a DID2.1 structure. 
>        Currently, in drm_displayid_internal.h, there are a few block structs
>        present (e.g. displayid_tiled_block,  displayid_formula_ timing_block,
>        displayid_detailed_timing_block), but there are several more data 
>        block types in DID2.1 that may be relevant if no EDID base block is
>        present (e.g. Product Identification Data Block for name, manuf. data,
>        serial number, etc).
>        Also, drm_connector should have some way to indicate that its edid_blob_ptr
>        contains DisplayID data.
> 
>     3. update_display_info() needs to handle the case where native DisplayID is
>        being used. All of the fields of drm_display_info that are being 
>        populated from the EDID will need to be accordingly updated.
>        This includes the EDID extension work in drm_parse_cea_ext() and drm_edid_to_eld().
>        In addition, _drm_edid_connector_add_modes() will need to just parse the 
>        displayid timing blocks (already being done today from the EDID 
>        extension).
> 
>     4. There is also the question of how the user interfaces for overriding and reading
>        EDID will need to change (/sys/class/drm/cardX/edid and /lib/firmware). Should there
>        be separate nodes for native DisplayID, or should they just deal with an opaque blob
>        of bytes, and leave it up to the user/DRM to interpret whether it is EDID or native
>        DisplayID?
> 
> We are rolling out native DisplayID support in the NVIDIA Linux drivers in an upcoming
> release; we have implemented our own reading/parsing and are able to populate 
> drm_connector::probed_modes with native DisplayID supplied modes. However, 
> due to the current gaps, we are unable to populate drm_connector::edid_blob_ptr if
> native DisplayID is being used, which leads to inconsistent state.
> 
> 
> Would like to hear any thoughts on this topic, or if there is a roadmap from any in-tree
> vendors to add this support.
> 
> Thanks,
> Vidith

-- 
Ville Syrjälä
Intel
