Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710F606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lfQM11qe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AE410E1A8;
	Wed, 18 Nov 2026 22:57:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD3510E1A8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795042632; x=1826578632;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=GBgs+ODi2ztYWUpi4l/s9u3RKGP0FkTFUEUp/V7X610=;
 b=lfQM11qe9uLmHuleg4OfDbkM/EfyZdrQfF1dMXODgPYT8egQwxbm6Hul
 3Olq5Y9HLgwUUKxXtt/LcA8+Y7DhL8QGa5qehsBTYJnJfQOKMJ4jltSvM
 QfDeHDnR1sGdUbDD9kZCjBofidcgLC4JHvPS4/8H31RkI/ckL2xKSCJgl
 tzATaujjGUS78SNbw2UTmBx7sbHhqcxTEBe8TQeBJmW26vkTLOwwKS0zr
 S7LakAa/hwAIaiKFi7sVX3yweW1EDIyHugiYG4AZHb1taJ4Bo8Lh2fBjG
 n3VvTV/qq1ik2aXfKaWAf0P2ctGUA+pN3Sc7R6jXEsq+tL41/iVcDGxmp w==;
X-CSE-ConnectionGUID: mVh5Vss+RICLcYUrQnwEUA==
X-CSE-MsgGUID: ZkZixXBITY2Cw10WqjXofw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3764937"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3764937"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:57:11 -0800
X-CSE-ConnectionGUID: soBvD0rWQ3yzozLTX4ssDw==
X-CSE-MsgGUID: aV3B+RZZQRW4xvSYvWCufw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10402633"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:57:09 -0800
Date: Thu, 19 Nov 2026 00:57:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
Message-ID: <av4tQaL6caoqd2w8@intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-21-ville.syrjala@linux.intel.com>
 <20261118221114.GI1923307@killaraus.ideasonboard.com>
 <av4nb98f3ewe2rV3@intel.com>
 <20261118223911.GJ1923307@killaraus.ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118223911.GJ1923307@killaraus.ideasonboard.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 12:39:11AM +0200, Laurent Pinchart wrote:
> On Thu, Nov 19, 2026 at 12:32:15AM +0200, Ville Syrjälä wrote:
> > On Thu, Nov 19, 2026 at 12:11:14AM +0200, Laurent Pinchart wrote:
> > > On Wed, Nov 18, 2026 at 11:45:17PM +0200, Ville Syrjala wrote:
> > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > 
> > > > Make DRM_RCAR_VSP selectable with COMPILE_TEST=y, and enable the hidden
> > > > DRM_RCAR_WRITEBACK option by default, so the VSP and writeback code gets
> > > > built for greater coverage. Builds fine on x86, x86_64, arm and arm64 at
> > > > least.
> > > 
> > > Let's see what build bots will report on more exotic architectures. I
> > > may volunteer you to send a fix if I'm too busy when the builders start
> > > yelling :-)
> > > 
> > > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > > > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > ---
> > > >  drivers/gpu/drm/renesas/rcar-du/Kconfig | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > index 80bd770ae0f6..5394f131c58f 100644
> > > > --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > @@ -76,7 +76,7 @@ config DRM_RCAR_MIPI_DSI
> > > >  	select RESET_CONTROLLER
> > > >  
> > > >  config DRM_RCAR_VSP
> > > > -	bool "R-Car DU VSP Compositor Support" if ARM
> > > > +	bool "R-Car DU VSP Compositor Support" if ARM || COMPILE_TEST
> > > 
> > > This will make it possible to disable the option when ARM64 &&
> > > COMPILE_TEST, which will break operation on Gen3 and up. It would be
> > > best to avoid that.
> > 
> > Break operation, as in when running on real hardware?
> > People actually do that with COMPILE_TEST=y kernels?
> 
> Hopefully not in production, but that may be the case during development
> (I don't though, there are enough kernel options to deal with without
> COMPILE_TEST).
> 
> This should do:
> 
> 	bool "R-Car DU VSP Compositor Support" if ARM || (COMPILE_TEST && !ARM64)
> 
> (untested though). Do you think it brings too much complexity ?

Doesn't bother me.

All I'm really after is being able to have COMPILE_TEST=y
enabled in my x86-32 and x86-64 drm-misc test build configs
so that I don't have to build on all the other architectures,
while still having reasonable confidence that I've not
completely broken some non-x86 drm driver.

-- 
Ville Syrjälä
Intel
