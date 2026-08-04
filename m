Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A473CC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E137D10EA51;
	Tue,  4 Aug 2026 13:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q87ATBFA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADBA10EA51;
 Tue,  4 Aug 2026 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785849216; x=1817385216;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version; bh=rybi2gi45uqGfa5yrMPOMczdwx7wNC+VlwwLMKCBhbw=;
 b=Q87ATBFAE6CH7FwID30qTrJ3oi6Kp1O3RcRvP8d65fooHhIbgo7TiH8W
 xDVqMCPTAo2KB2nAdLNV57T7KRNvd7mrVN7QTVPMG4K5C0ykjjdWxhHsW
 Q3z3P+Xz0Evk/R6PNT+tEotpKXxNtGyoep2Gdz4QOLwc6FzPAfniFkoAp
 qnupI5+8MECwvlIkNxagFKLXrf9AxaXmOfXOD/X97HjVwlycMFbNf8wc6
 noI2AUlClh26VTEPpaNO94mLCJthnTHbociTdoWMHg0+5Fktfz1qq9YXF
 vz3oimK6RJ7RS91m2Nfr6F1OnsnKogjEQVaANIPqSBnOrDPgsG+8/Kadq A==;
X-CSE-ConnectionGUID: fuxDITwfSPChIhcF5Vpv8Q==
X-CSE-MsgGUID: b/YM7dX0S++Ca9qa+/XDFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86598227"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="86598227"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 06:13:35 -0700
X-CSE-ConnectionGUID: XMyW5Z1hRrOr/tsJXKHLKA==
X-CSE-MsgGUID: kxcnGRXETP2+j7OiRh0Y0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="284885289"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.151])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 06:13:01 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Haram Choi <haram@choiharam.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com
Subject: Re: [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,3 -
 PCI bridge left with VGA enable set and VGA 16-bit decode cleared,
 aliasing legacy VGA I/O over the gmux ports
In-Reply-To: <0102019fcb5d411c-e0a555b7-46da-43a1-bd9d-6cb120f58a7f-000000@eu-west-1.amazonses.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <0102019fcb5d411c-e0a555b7-46da-43a1-bd9d-6cb120f58a7f-000000@eu-west-1.amazonses.com>
Date: Tue, 04 Aug 2026 16:12:58 +0300
Message-ID: <4bf694add4bcd5b6361b3f8a827fb8dab9f250eb@intel.com>
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

On Tue, 04 Aug 2026, Haram Choi <haram@choiharam.com> wrote:
> I think I have found the commit. It is not in drivers/pci at all, and
> my previous suspicion of 94555ea9a048 was wrong. Apologies to Simon
> for the noise.
>
> The regression is:
>
>   cc6ed470caa2 ("drm/i915/vga: Avoid VGA arbiter during
>                  intel_vga_disable() for iGPUs")
>   Ville Syrjala <ville.syrjala@linux.intel.com>, 2025-12-08

Uh, that's a bit of a bummer. As you can see, I've only acked it,
because quite honestly, I don't fully understand what's going on, but I
fully trust Ville to follow through with any issues it might cause. Like
this one. However, Ville's not available for a few weeks now, and the
commit also does not revert cleanly anymore.

We can either try to hack together some sort of fix/revert, or wait for
Ville's input.


BR,
Jani.

-- 
Jani Nikula, Intel
