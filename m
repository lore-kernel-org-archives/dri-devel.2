Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638ABF46126
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB70010E11F;
	Mon, 23 Mar 2026 14:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XZgWawm6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D603F10E029;
 Mon, 23 Mar 2026 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774275007; x=1805811007;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=o7ONyWWXr7BZpIuvHFAnJnEAz0PIKVMIwLElkyh0rH4=;
 b=XZgWawm6xRyc9bA97gtYc83kz1c7SLxp9EEmK9AXzhOXk/6BkXWvB7qR
 2RPmPWJK7UIkf0ftWct1viiFg+doIu94wKJM9tLb+e+ZQlj4fG4bgj8uP
 cJRzdayu6eZ7SKEiXrb8uziPpT7fwjw8ta+2d1ytxWpR8hmEDGA4c+4SP
 +kvCAsypFx9mAt1i3XF3Ay/pKF1ijfw4p00ai+KQQYSlRt1KuoA/0ohix
 fpGRoSlrts76yTnNPp2ne4/wtJhSf5zcPMS3KWGBaPmvQ+TLkHdD5R7xM
 WMFziqFLnRj+z1PpOMvLo5xLkXelfGfpuC/PUQSgdGtoo+jnbSvHOTi04 A==;
X-CSE-ConnectionGUID: VHjIFBxGSX+8t3rR3fvMkw==
X-CSE-MsgGUID: F+PtwBW2QV2cC90NDLjIRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79179760"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="79179760"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 07:10:06 -0700
X-CSE-ConnectionGUID: GueCB3UtSjCCZHhU/3HUIw==
X-CSE-MsgGUID: OLhmd5GDSQq1xLlIIdG7Yg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 07:10:04 -0700
Date: Mon, 23 Mar 2026 15:10:01 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, mripard@kernel.org,
 matthew.brost@intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, christian.koenig@amd.com, andrealmeid@igalia.com
Subject: Re: [PATCH v2 0/3] Update 'none' recovery method for DRM wedged event
Message-ID: <acFJuRlHeJ8OyLi6@black.igk.intel.com>
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <aa_OxUm6vthhaorE@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa_OxUm6vthhaorE@black.igk.intel.com>
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

On Tue, Mar 10, 2026 at 08:56:58AM +0100, Raag Jadav wrote:
> On Thu, Mar 05, 2026 at 06:36:46PM +0530, Raag Jadav wrote:
> > Currently 'none' recovery method for wedged event expects no explicit
> > recovery from userspace consumer but it expects driver to have reset
> > the device, which may not always be the case. Update documentation and
> > log to reflect this expectation.
> 
> Anything I can do to move this forward?

Ping.

Raag

> > v2: Rephrase documentation (Rodrigo)
> > 
> > Raag Jadav (3):
> >   drm/doc: Update documentation for 'none' recovery method
> >   drm: Update log for 'none' recovery method
> >   drm/xe: Send 'none' recovery method for
> >     XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET
> > 
> >  Documentation/gpu/drm-uapi.rst | 14 +++++++-------
> >  drivers/gpu/drm/drm_drv.c      |  2 +-
> >  drivers/gpu/drm/xe/xe_device.c |  9 ++++++++-
> >  3 files changed, 16 insertions(+), 9 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
