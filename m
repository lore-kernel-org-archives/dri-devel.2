Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9ED606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kb+cC3cj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA3E10E769;
	Thu, 29 Oct 2026 04:48:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E7810E380;
 Thu, 29 Oct 2026 04:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793249294; x=1824785294;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mwsTPyG24xiOdg+/X+JzMCOeRkv2EWrlFb1PEpp5Iis=;
 b=kb+cC3cj61lgnrLwyxoYlnAC1pyWDlu/TrGjPgkwAT9pE4GElMdsMh58
 w7SzLjMG8+mEgQDG+Ykg07PsG/HzQj1wX4ET8KKNlW+02O2YsKNIagLL2
 3NnE19HWnJK1LEc3BclURJNlTRN380cJvMW1SZ7xjSYU/tpltGZWNJtr7
 /d59frriosWSjNv+krYsuOFqLV27Z+7z8hk1EtuBEtI8lBGZprxbNOW6m
 PkWpsTDy4dOsnOSW141lYviXpZrLq8LmmuBsv6bHCIVJbzIWQPRnaDR3j
 8k50oYKh+5XE1CtnMbzSXV376RdPSPux6XuhQ0Z1ALKVqLH2Mc0tkpjdA Q==;
X-CSE-ConnectionGUID: TE+qaThLQrKRMAHMUOr4tA==
X-CSE-MsgGUID: F0IO7jl0Qs+i/ACRMi0agw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2000011"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="2000011"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 21:48:13 -0700
X-CSE-ConnectionGUID: xUGuG75hTpKRPq/hrQpfSg==
X-CSE-MsgGUID: bJqmcgEMQfaC2Zd96Phqww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4905369"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 21:48:12 -0700
Date: Thu, 29 Oct 2026 05:48:09 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
Cc: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Tauro, Riana" <riana.tauro@intel.com>,
 "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Message-ID: <auLQCWmLV395IoS7@black.igk.intel.com>
References: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
 <auFpdeRIafjgKSV9@black.igk.intel.com>
 <f7f8745978c21de8687e1e539a15f0be9f9d4a6a.camel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f8745978c21de8687e1e539a15f0be9f9d4a6a.camel@intel.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 02:31:21AM +0530, Teres Alexis, Alan Previn wrote:
> On Wed, 2026-10-28 at 04:18 +0100, Jadav, Raag wrote:
> > On Fri, Oct 23, 2026 at 10:36:25AM -0700, Alan Previn wrote:
> > > Today, when the driver faces issues with early pcode errors
> > > and attempts to enter survivabilty (when explicitly requested)
> > > it may either succeed or fail (latter being possible due to
> > > underlying subsystem blockers). During this flow the driver remains
> > > loaded and completely silent. No messages indicate that it may need
> > > or it attempted and succeeded or it attempted and failed, to enter
> > > survivability mode. This patch adds some awareness in dmesg.
> > 
> > What case are you exactly hitting here? From what I understand both pcode
> > and survivability failures are logged inside their helpers.
> > 
> > Raag
> 
> I believe the issue couple of us observed was unexpected value in check_boot_failure
> called from xe_survivability_mode_is_requested. But as we went back up the stack we
> had absolutey zero indication there was any error. nothing indicated we were even
> in survivability mode. At least in that failure point case.
> 
> I understand we have injected sigid code logging in the various other branches
> of downstream logic (from xe_device_probe_early->xe_pcode_probe_early /
> xe_survivability_mode_is_requested), however, I it would be more intuitive
> to put a single message at that top level to at least indicate some kind of
> survivability activity was directed, attempted and entered-or-failed-to-enter
> 
> If you believe the correct fix should be to ONLY keep error logs at every
> subbranch instead at the top level, thats fine with me too too but i notice
> they currently don't actually convey the survivability state.
> We have messages like "Firmware flash required" or "Boot mode enabled"
> but nothing saying we are in survivability and the gpu isnt usable.

From what I found both success and fail cases are logged here.

        if (check_boot_failure(xe))
                xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
        else
                xe_log_info(pdev, SURVIVABILITY, "Boot Mode enabled!\n");

These logs use SURVIVABILITY as a component which would appear in dmesg
(not a fan of it myself, but that's unfortunately the xe_log design).

I do agree that we could log something like "Entering survivability mode"
somewhere if xe_survivability_mode_is_requested() were to return true,
unless Riana has a better idea.

Raag
