Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6300F54ABF
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB1310E13A;
	Tue, 24 Mar 2026 14:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZgK6ix7Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B08E10E00F;
 Tue, 24 Mar 2026 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774361108; x=1805897108;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jGLH/WfSC3JOvT6EfQfzRq0lC/CbygfoqSNYqC/yU4s=;
 b=ZgK6ix7QrPOLLBDW0I0pgwv3mSpSPdojcueFCWw+u5LlLB6BuxqAKovw
 GDRZwlU8sy7OrVzbfMty32asfqpyeRQraCkUGTfVDo20hH1Y7JWJWbtSz
 djCukMhMpuIJV7My4ZnSTJIv1/dgRfnubRep/8NKnfwVPYwkMe4RfDngB
 TUbYORU/43UUhlt2Qfbji+Sur+8/Px0HBAdJ0cBr/3P7aiQM75zA301k0
 BPostzaNKltK+BKm+BB+ziLq2GfAEs9/vnupjtadtvBwUtii+VsLOf8IB
 xeeaE3YQgViuHkEYNzPvopeYOj2f1ugTl9Vv9ihyY4odOKShVTPk3Q4k2 g==;
X-CSE-ConnectionGUID: mSVDI/DbRraom0ACzS5pWQ==
X-CSE-MsgGUID: +hFO8xaZSyeVvMFVYRG11A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="97995201"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="97995201"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 07:05:03 -0700
X-CSE-ConnectionGUID: NJ71rxhrRo2fAW5U1P6QJg==
X-CSE-MsgGUID: QlZkmqPCS1Kr04fW2X/WKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="226004333"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 07:05:01 -0700
Date: Tue, 24 Mar 2026 15:04:58 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, matthew.brost@intel.com,
 riana.tauro@intel.com, andrealmeid@igalia.com
Subject: Re: [PATCH v2 0/3] Update 'none' recovery method for DRM wedged event
Message-ID: <acKaCrzZlg84F5Kq@black.igk.intel.com>
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <aa_OxUm6vthhaorE@black.igk.intel.com>
 <acFJuRlHeJ8OyLi6@black.igk.intel.com>
 <5d2171ca-aa9b-4b8f-9ea3-eabb823ef2d6@amd.com>
 <acH4qEdJwwRApZ0t@black.igk.intel.com> <acKXBy3WXzrPERxm@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acKXBy3WXzrPERxm@intel.com>
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

On Tue, Mar 24, 2026 at 09:52:07AM -0400, Rodrigo Vivi wrote:
> On Tue, Mar 24, 2026 at 03:36:24AM +0100, Raag Jadav wrote:
> > On Mon, Mar 23, 2026 at 03:11:58PM +0100, Christian König wrote:
> > > On 3/23/26 15:10, Raag Jadav wrote:
> > > > On Tue, Mar 10, 2026 at 08:56:58AM +0100, Raag Jadav wrote:
> > > >> On Thu, Mar 05, 2026 at 06:36:46PM +0530, Raag Jadav wrote:
> > > >>> Currently 'none' recovery method for wedged event expects no explicit
> > > >>> recovery from userspace consumer but it expects driver to have reset
> > > >>> the device, which may not always be the case. Update documentation and
> > > >>> log to reflect this expectation.
> > > >>
> > > >> Anything I can do to move this forward?
> > > 
> > > Invent some tech to clone certain people so that we have more reviewers.
> > 
> > If this allows my clones to also review my patches, I fully support this :)
> > 
> > > > Ping.
> > > 
> > > I will take a look now.
> > 
> > Thank you, I think it's safe to land through drm-misc (if anyone has access).
> 
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> But it is not applying cleanly on drm-misc-next.
> 
> drm-misc maintainers, could you please do a backmerge of drm-next?
> 
> Or ack these patches to go through drm-xe-next

It's already on misc thanks to Brost. Thank you all for the support.

Raag

> > > >>> v2: Rephrase documentation (Rodrigo)
> > > >>>
> > > >>> Raag Jadav (3):
> > > >>>   drm/doc: Update documentation for 'none' recovery method
> > > >>>   drm: Update log for 'none' recovery method
> > > >>>   drm/xe: Send 'none' recovery method for
> > > >>>     XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET
> > > >>>
> > > >>>  Documentation/gpu/drm-uapi.rst | 14 +++++++-------
> > > >>>  drivers/gpu/drm/drm_drv.c      |  2 +-
> > > >>>  drivers/gpu/drm/xe/xe_device.c |  9 ++++++++-
> > > >>>  3 files changed, 16 insertions(+), 9 deletions(-)
> > > >>>
> > > >>> -- 
> > > >>> 2.43.0
> > > >>>
> > > 
