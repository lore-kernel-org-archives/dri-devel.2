Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF07E99060
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A67610E8FD;
	Fri, 10 Apr 2026 09:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L5ii5BzB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394D210E8FD
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775813251; x=1807349251;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=f8WJia9701gyvoswJQ+79ezdURxBHSKpAOTsbCEWWVk=;
 b=L5ii5BzBBFn8AVdbdxjY+KGMC4UGZSyX8ChzMDSgF3EPTMgeYsjk0c+Q
 RYjRIlJDjNqPr0E5o8zl8uOrlzWEE1Y8YEvbn4AQ4BXl4mCkOUrSFuWYm
 MRqLXT3I6qyx6W1vmmPCOneAuKKsgHyKQ017+AKMgZgvzGyq6/gAbeggf
 mcVY+7FqdR+rnoIo1qVj3A8udI2zByl1dWSERiymTtqId82GP/KhgzyGq
 URgQnVYNfu8o5+I5h/QNx8VA2BTx8okD2eQwx2YniMAA82B05aWklzP6F
 PXBK+U/rpirG0SucvInKxc/BSEBYrHp50+QXOMNGP8ZeCAHmaEH9jZLzt A==;
X-CSE-ConnectionGUID: /Rzy+5VXQFCpqyMRYsZaVA==
X-CSE-MsgGUID: p7rgTkEGRPeKMquyBxeGGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="99462940"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="99462940"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 02:27:31 -0700
X-CSE-ConnectionGUID: TMNBMbTSTwyo+V2EkC+YPg==
X-CSE-MsgGUID: pV7D+rmfQAy0Vwq+IYLxIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="267006134"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.89])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 02:27:26 -0700
Date: Fri, 10 Apr 2026 12:27:23 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xlnx/zynqmp-dpsub: Fix dependencies for COMPILE_TEST
Message-ID: <adjCewq5NkXJ10_H@intel.com>
References: <20260408081430.1712335-1-wenst@chromium.org>
 <386241e0-3d1b-43cc-8bc0-b6d35a97ba89@ideasonboard.com>
 <CAGXv+5HjX3FagZs5K+Z=PYQWt2a92My6wgG+ZXKh140w3Hz-QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5HjX3FagZs5K+Z=PYQWt2a92My6wgG+ZXKh140w3Hz-QA@mail.gmail.com>
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

On Fri, Apr 10, 2026 at 05:08:00PM +0800, Chen-Yu Tsai wrote:
> On Fri, Apr 10, 2026 at 4:49 PM Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
> >
> > Hi,
> >
> > On 08/04/2026 11:14, Chen-Yu Tsai wrote:
> > > The zynqmp-dpsub driver does not have build time dependencies on the PHY
> > > or DMA drivers. These are runtime hardware restrictions.
> > >
> > > Group the two dependencies with ARCH_ZYNQMP so that the driver can be
> > > compile tested without them.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > > IMO the two driver dependencies could be removed altogether, but that
> > > would be up to the driver and platform maintainers.
> > > ---
> > >   drivers/gpu/drm/xlnx/Kconfig | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
> > > index cfabf5e2a0bb..4c6729459f40 100644
> > > --- a/drivers/gpu/drm/xlnx/Kconfig
> > > +++ b/drivers/gpu/drm/xlnx/Kconfig
> > > @@ -1,10 +1,8 @@
> > >   config DRM_ZYNQMP_DPSUB
> > >       tristate "ZynqMP DisplayPort Controller Driver"
> > > -     depends on ARCH_ZYNQMP || COMPILE_TEST
> > > +     depends on (ARCH_ZYNQMP && PHY_XILINX_ZYNQMP && XILINX_ZYNQMP_DPDMA) || COMPILE_TEST
> > >       depends on COMMON_CLK && DRM && OF
> > >       depends on DMADEVICES
> > > -     depends on PHY_XILINX_ZYNQMP
> > > -     depends on XILINX_ZYNQMP_DPDMA
> > >       select DMA_ENGINE
> > >       select DRM_CLIENT_SELECTION
> > >       select DRM_DISPLAY_DP_HELPER
> >
> > I think the above looks more difficult to understand than the current
> > version. We should perhaps rather drop the dependencies. But if we go
> > that way, then... we can also drop DMADEVICES, DMA_ENGINE, GENERIC_PHY
> > at least.
> 
> Perhaps. All the APIs for these are properly stubbed, so I guess
> they also count as runtime dependencies.
> 
> > What problem does this solve? Why are these two dependencies bad for
> > compile testing, but the other dependencies/selects are ok?
> 
> I was build testing changes across multiple DRM drivers in addition to
> the main platform I work on. Having to find and select each dependency
> was annoying.

I've had the same experience. It's really hard to do drm subsystem
wide changes, and be sure that all the code being touched is actually
getting compiled.

> 
> I would say DMADEVICES and GENERIC_PHY are much more common to embedded
> devices than SoC specific drivers.
> 
> > I personally don't mind hard runtime dependencies expressed in the
> > Kconfig, as searching for the correct dependency-drivers when your
> > driver doesn't probe is always a PITA.
> 
> I don't mind it either. But the way they are described means that compile
> testing is overly dependent on having some other platform specific
> driver enabled.

If only "select" worked in a sane way :/ Although that would still
force you to actually compile all the runtime dependencies, making
the build slower.

> 
> 
> I suppose another way to write this would be:
> 
>     depends on ARCH_ZYNQMP if !COMPILE_TEST
>     depends on PHY_XILINX_ZYNQMP if !COMPILE_TEST
>     depends on XILINX_ZYNQMP_DPDMA if !COMPILE_TEST

I believe the ||COMPILE_TEST pattern is much more common.

>     ...
> 
> Does that work for you?
> 
> 
> Thanks
> ChenYu

-- 
Ville Syrjälä
Intel
