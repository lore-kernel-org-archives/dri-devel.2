Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2C7EBFD36
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBE210E3BD;
	Mon, 13 Apr 2026 10:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UNkBm8/9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D73C10E3B8;
 Mon, 13 Apr 2026 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776074943; x=1807610943;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=AYVViBzC1UVd6/9kYCdjk4M6Q1A+ZDLIeh3I/2ejIM8=;
 b=UNkBm8/9Q1dKf8tjajBI/PTItNglZi/HmQ8uUDLSDGA5gYpTKv6S462b
 nlfBwlauTaUaE7YbSHkMP26b8yuUz0yCE5yxg/SjOcXMfsjwOO89LLGqU
 TCVS/oVpqUccgK/D3ZUHrZUh4RemY+AXb63kotFKQWDqLF7zcdvqUbr/m
 Ht5anSHr9pmnHF87sa+yyQrk+Y1m1++eH1zSqul0wTmixaw9sI27Z+xvd
 kp8SXMIcruDBQp8CAr3Ju9wJdEpp8EQPLz0dERnuaKtYLIcFU3nLfUnc3
 HxlIeSod18474ggAxpVS0ux1wLFm7AEtDBgIKZmhNEOzgu0e/Ye5rhDGM w==;
X-CSE-ConnectionGUID: Loq91YdZQnW2WMIXAMwUZA==
X-CSE-MsgGUID: Ld/HIVT5QjqKcJv/pifW5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94395577"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="94395577"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 03:09:03 -0700
X-CSE-ConnectionGUID: yCFRKyYcSBC6EzkbF/wa5g==
X-CSE-MsgGUID: RcbMp991SV+VkCLbiSGoSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="229616762"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.64])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 03:09:00 -0700
Date: Mon, 13 Apr 2026 13:08:57 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@intel.com>,
 Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH 5/6] drm/i915/reset: Handle the display vs. GPU reset
 deadlock using a custom dma-fence
Message-ID: <adzAuSvOP8DkppZU@intel.com>
References: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
 <20260408233458.22666-6-ville.syrjala@linux.intel.com>
 <44fa373c-6216-4cc4-a605-94776b3873ad@amd.com>
 <adeLRHQ2omAv93yM@intel.com>
 <cc51ea63-19b0-4352-9299-e5ab63f57ce4@amd.com>
 <adyzR6ISo_idi38p@intel.com>
 <b93c6c33-2d94-4da8-8e97-04c3bade2575@amd.com>
 <ady-UMqIQUqmKsLv@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ady-UMqIQUqmKsLv@intel.com>
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

On Mon, Apr 13, 2026 at 12:58:40PM +0300, Ville Syrjälä wrote:
> On Mon, Apr 13, 2026 at 11:35:23AM +0200, Christian König wrote:
> > On 4/13/26 11:11, Ville Syrjälä wrote:
> > >>>> I think something is missing in my picture how that is supposed to work.
> > >>>
> > >>> The problem stems from the fact that on old platforms a GPU reset
> > >>> also resets the display hardware,
> > >>
> > >> Which is true for at least AMD GPUs and I think pretty much everybody else as well, but that wasn't so much of a problem so far.
> > >>
> > >>> and to do that safely we need:
> > >>> 1. shut down display
> > >>> 2. perform the GPU reset
> > >>> 3. restore the display hardware to its orignal state
> > >>
> > >> Mhm, I've recently talked with Michel about it and we confirmed that this is perfectly possible without issues. Adding Michel as well.
> > >>
> > >>> We just do that with essentially with a normal atomic commit.
> > >>
> > >> I think that is the source of the problem.
> > >>
> > >> I'm not an expert on that topic but amdgpu and tons of other drivers seem to just use drm_atomic_helper_shutdown() for that.
> > > 
> > > drm_atomic_helper_shutdown() is definitely not the thing to use
> > > for this as it would clobber the stored kms state, leaving everything
> > > permanently disabled. The drm_atomic_helper_commit_duplicated_state()
> > > stuff i915 uses is the correct thing here.
> > > 
> > > But for this problem it doesn't even matter which gets used. Either
> > > would get equally stuck behind a previous atomic commit waiting for
> > > its fences.
> > > 
> > >>
> > >> What is i915 doing differently?
> > > 
> > > I see zero code for any display reset stuff in any other driver. If
> > > amdgpu does anything it must be something completely custom, hidden
> > > somewhere deep.
> > 
> > The display is just fully reset by any MODE1 reset, you don't need to do anything special for that.
> 
> You can't just ignore the fact that there may be a display hardware
> reprogramming already happening in parallel. Failing to follow the
> correct programming sequence is a recipe for even hard system hangs.

Oh, and skipping the controlled shutdown could violate panel power
sequencing requirements, which is not good for the panel's health.

-- 
Ville Syrjälä
Intel
