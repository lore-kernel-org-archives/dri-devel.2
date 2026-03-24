Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6875CF532C6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 02:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AA110E591;
	Tue, 24 Mar 2026 02:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c2rFPM4H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D522310E590;
 Tue, 24 Mar 2026 02:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774319789; x=1805855789;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=aoVES+fNMNs0j0AQvGkOu6fbsfT5KvJjw5UEr76m16c=;
 b=c2rFPM4Hp9ZGFj97+XC+TjKSff7QbpFrbGAuVc0alQ3We7iijSVur2Wd
 PlG8P1r+iuT2oDYKNPzp/qeNaVM7siLCRj8x4sE7cQ+Rml869EQ5CW1zk
 IG77jzl8T9UwNuYUBFNnf7bzs/xVukIT7oB6ln99nZVteqY4zpD5a3qog
 bgnmB0m2Cn9wXVXSug/ABPZIJVtMOir259TYqrL9+xbkGROzMGQIpN8UV
 yCCMCEHP0YRKjrbKZNezbDoCqirrkUlxfKTHbCzlQLd4LFlfw1UR9ffzc
 mFZcuq0KfkdpqhO3770kCsb+rlzrnAE+gfBzQil/l59jkLk+QJ7iWtoaI A==;
X-CSE-ConnectionGUID: 0dvvV1+tQNqT9Z3JDvNtAA==
X-CSE-MsgGUID: 5MTGczAkTYKIfbbtNGdwzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="78928372"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="78928372"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 19:36:29 -0700
X-CSE-ConnectionGUID: 6x2O7qloT6m+V/gv1QMnhg==
X-CSE-MsgGUID: qAssdncyTimEG2xi13nzSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="225882632"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 19:36:27 -0700
Date: Tue, 24 Mar 2026 03:36:24 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, mripard@kernel.org,
 matthew.brost@intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, andrealmeid@igalia.com
Subject: Re: [PATCH v2 0/3] Update 'none' recovery method for DRM wedged event
Message-ID: <acH4qEdJwwRApZ0t@black.igk.intel.com>
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <aa_OxUm6vthhaorE@black.igk.intel.com>
 <acFJuRlHeJ8OyLi6@black.igk.intel.com>
 <5d2171ca-aa9b-4b8f-9ea3-eabb823ef2d6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d2171ca-aa9b-4b8f-9ea3-eabb823ef2d6@amd.com>
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

On Mon, Mar 23, 2026 at 03:11:58PM +0100, Christian König wrote:
> On 3/23/26 15:10, Raag Jadav wrote:
> > On Tue, Mar 10, 2026 at 08:56:58AM +0100, Raag Jadav wrote:
> >> On Thu, Mar 05, 2026 at 06:36:46PM +0530, Raag Jadav wrote:
> >>> Currently 'none' recovery method for wedged event expects no explicit
> >>> recovery from userspace consumer but it expects driver to have reset
> >>> the device, which may not always be the case. Update documentation and
> >>> log to reflect this expectation.
> >>
> >> Anything I can do to move this forward?
> 
> Invent some tech to clone certain people so that we have more reviewers.

If this allows my clones to also review my patches, I fully support this :)

> > Ping.
> 
> I will take a look now.

Thank you, I think it's safe to land through drm-misc (if anyone has access).

Raag

> >>> v2: Rephrase documentation (Rodrigo)
> >>>
> >>> Raag Jadav (3):
> >>>   drm/doc: Update documentation for 'none' recovery method
> >>>   drm: Update log for 'none' recovery method
> >>>   drm/xe: Send 'none' recovery method for
> >>>     XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET
> >>>
> >>>  Documentation/gpu/drm-uapi.rst | 14 +++++++-------
> >>>  drivers/gpu/drm/drm_drv.c      |  2 +-
> >>>  drivers/gpu/drm/xe/xe_device.c |  9 ++++++++-
> >>>  3 files changed, 16 insertions(+), 9 deletions(-)
> >>>
> >>> -- 
> >>> 2.43.0
> >>>
> 
