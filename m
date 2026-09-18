Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85566C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9C810E91F;
	Fri, 18 Sep 2026 14:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HYp/j1QX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C858C10E095;
 Fri, 18 Sep 2026 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789741808; x=1821277808;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=YEg0jcvQc1mOshL2/RNi5RSlJ9cuCkQUn+/hJtpivRo=;
 b=HYp/j1QXpQJMhSpN6D31I6X6gYkBIfmePHiqCihrkICj0ucCo6aOkqxH
 l5EwSVIiY1BgZbNBxe9MmrF2EMxpSAKeJbLHy8ekSvTA7wiUe4Ds9hvKs
 7gYKIwS5oTIzh1BfYOdk0QXQc7aw0Sc0/VZi8Ae8xr0riwlmroGE9s7yy
 edCKnI3CGesSMGR6wgpbE6a3A4TLgpmaXRM3Hg5WrC/EqyYr0B0Kx2D52
 eKnvQi28JKS20A4hjdigIMejXT3KBbczxm5txLXdjH9S5yDW7cEKLOS++
 z3vygk9yTqmPctcKIpFXJXcbbFyEPwVo9LUoilqdEbwr/WoL3a0KgHDNV w==;
X-CSE-ConnectionGUID: G4Ia6RAgR92T/qgz4xPS5Q==
X-CSE-MsgGUID: lSGlNFYESZaGmZ5BuXYhjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="115783504"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115783504"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:30:07 -0700
X-CSE-ConnectionGUID: vc2ELreXSRqSyMReXZmiTw==
X-CSE-MsgGUID: iTSBgMDqR9edYlTzeXJRJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2856614"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:30:05 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Fangzhi Zuo <jerry.zuo@amd.com>, timo.proemer04@gmail.com, Harry
 Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Cc: Fangzhi Zuo <jerry.zuo@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
 instead of raw extensions
In-Reply-To: <20260727213305.810014-1-jerry.zuo@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
 <20260713193237.2639-3-timo.proemer04@gmail.com>
 <20260713194945.2AFE11F00A3A@smtp.kernel.org>
 <20260727213305.810014-1-jerry.zuo@amd.com>
Date: Fri, 18 Sep 2026 17:30:02 +0300
Message-ID: <a8a004b82a037ec2f218d6b324298ba505286bc2@intel.com>
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

On Mon, 27 Jul 2026, Fangzhi Zuo <jerry.zuo@amd.com> wrote:
> Hi Timo,
>
> Thanks for the patch. Heads-up that this overlaps with a fix already in
> amd-staging-drm-next:
>
>   21590e1adc9e ("drm/amd/display: Fix 8K Mode Not Parsed by EDID")

More precisely commit 11a90eaf5c80 ("drm/amd/display: Fix 8K Mode Not
Parsed by EDID") upstream.

> That commit addresses the same underlying problem your patch targets --
> edid->extensions (byte 0x7e) not accounting for HF-EEODB blocks, so only
> 2 of 4 blocks of an HDMI 2.1 EDID get copied into sink->dc_edid and the
> 8K modes in the DisplayID extension blocks are lost. It takes a slightly
> different approach: instead of drm_edid_block_count(), it populates
> edid_blob_ptr with a full, HF-EEODB-aware blob and copies
> edid_blob_ptr->length. So on current amd-staging the
> dm_helpers_read_local_edid() hunk here no longer applies cleanly.

That's an awful, ugly hack. Please work to remove it. Drivers are not
supposed to look at or use connector->edid_blob_ptr at all. See the
documentation.

I really did put in a *lot* of effort into abstracting HF-EEODB properly
and neatly for everyone, across the subsystem. The opaque struct
drm_edid is the abstraction. Please embrace it, and you'll get HF-EEODB
for free, with no hacks.

If you face issues, please talk to me instead of hacking stuff and
intentionally working around the the abstractions.

> Could you rebase on the latest amd-staging-drm-next and see what, if
> anything, is still needed on top? There may still be value in the
> helper conversion for readability, but we should avoid re-fixing the
> same HF-EEODB issue two different ways.

The one and only fix for HF-EEODB is to use struct drm_edid everywhere.


BR,
Jani.


-- 
Jani Nikula, Intel
