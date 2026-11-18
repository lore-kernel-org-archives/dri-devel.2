Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C954606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NYQ/qxvb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5AE10ECAB;
	Wed, 18 Nov 2026 22:32:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1765910ECAB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795041141; x=1826577141;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ijl2H9CnM6VlEivNU5uwbVxHdUdUBHYqdOVBJrLJWxQ=;
 b=NYQ/qxvbAeM2gNs7ouOKjICT7qUbC8GPSbba0TOJey7stnNSltwOB9Ca
 9MIr0qvuzWJ5czQGy4d4DttTWMG9JQ1LMg83+mzCQ+EWYQbKuHRo4g5fE
 YVCbqVvDS2aBqR4HuOqk64LYaK6htu3rQ4wWvY36LxwJPcADk7Xq+nCqk
 mXsv4dxASP1rChEl9uAgA/5f4VvCpEHYZM/kYestSQvX/seVqx150tMvJ
 W4AvGkEIks8FWYLrFaAVpW410e4W5Mr8aUfquzKb7D6v3OjtGd7vu+vXB
 Gplx2b1nF5lRGKwlF1ECdO8OmnFHjm44iYtSDhXHSPUyeXFLBliRKfwcn Q==;
X-CSE-ConnectionGUID: 0LpwV1yrQSuHle/41q1Iyg==
X-CSE-MsgGUID: sjH2gXNeR5+D1Zm9R1erlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3767946"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3767946"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:32:21 -0800
X-CSE-ConnectionGUID: ioznNgFlS8W5BD16WL8QtA==
X-CSE-MsgGUID: ZMqaDGIPSBqHAexSHxdgKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10397887"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 14:32:18 -0800
Date: Thu, 19 Nov 2026 00:32:15 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
Message-ID: <av4nb98f3ewe2rV3@intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-21-ville.syrjala@linux.intel.com>
 <20261118221114.GI1923307@killaraus.ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118221114.GI1923307@killaraus.ideasonboard.com>
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

On Thu, Nov 19, 2026 at 12:11:14AM +0200, Laurent Pinchart wrote:
> On Wed, Nov 18, 2026 at 11:45:17PM +0200, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Make DRM_RCAR_VSP selectable with COMPILE_TEST=y, and enable the hidden
> > DRM_RCAR_WRITEBACK option by default, so the VSP and writeback code gets
> > built for greater coverage. Builds fine on x86, x86_64, arm and arm64 at
> > least.
> 
> Let's see what build bots will report on more exotic architectures. I
> may volunteer you to send a fix if I'm too busy when the builders start
> yelling :-)
> 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/renesas/rcar-du/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > index 80bd770ae0f6..5394f131c58f 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > @@ -76,7 +76,7 @@ config DRM_RCAR_MIPI_DSI
> >  	select RESET_CONTROLLER
> >  
> >  config DRM_RCAR_VSP
> > -	bool "R-Car DU VSP Compositor Support" if ARM
> > +	bool "R-Car DU VSP Compositor Support" if ARM || COMPILE_TEST
> 
> This will make it possible to disable the option when ARM64 &&
> COMPILE_TEST, which will break operation on Gen3 and up. It would be
> best to avoid that.

Break operation, as in when running on real hardware?
People actually do that with COMPILE_TEST=y kernels?

> 
> >  	default y if ARM64
> >  	depends on DRM_RCAR_DU
> >  	depends on VIDEO_RENESAS_VSP1=y || (VIDEO_RENESAS_VSP1 && DRM_RCAR_DU=m)
> > @@ -85,5 +85,5 @@ config DRM_RCAR_VSP
> >  
> >  config DRM_RCAR_WRITEBACK
> >  	bool
> > -	default y if ARM64
> > +	default y if ARM64 || COMPILE_TEST
> >  	depends on DRM_RCAR_DU
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Ville Syrjälä
Intel
