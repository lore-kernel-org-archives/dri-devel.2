Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA134606D840
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZnoo3NZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43266112731;
	Fri, 13 Nov 2026 17:51:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A875A10E533;
 Fri, 13 Nov 2026 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794592304; x=1826128304;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ot8aUgvttzN3zhP6CmenM57WhZx/wtpRsYm0cuIyEHE=;
 b=EZnoo3NZvmcGgFi7IcJyP/rwtnkdlDaQW+LwCM4/YQcTOmJgwO6Nupa+
 qC07ooTjBVhDBHIv6gJAJkbYWsxMXQ+rEeBQGQJWhCZYuP+TH2hs521UX
 Q3EtH9OipKHa8CMkDM1wYKt5RHuyjMANaOtif/f/qiSqfk92b0c6FC799
 E+xMS7DEuCR+WHRI5riTys2W2EtTYjD0cC03wXQtHzDO2LN3LYaZ6/L46
 OQqDeGs/UWpYjZfeCSQFoRjUvf2L9On1I/Tw36pOF2ZFMD58aR79/atqD
 AF55cL/gHMIYZRuhLjInL+Ny2rAOoW3tfpzTBXk7TTHexzHSdRdC2pRL9 A==;
X-CSE-ConnectionGUID: W/qHUSPyQH+46l1jG1yTBg==
X-CSE-MsgGUID: iC1Hiae/QF2ABz49BW0D/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3396822"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3396822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 09:51:43 -0800
X-CSE-ConnectionGUID: RWBCcPdcRdOXUO4f8jkJ1g==
X-CSE-MsgGUID: PepsrX++TK6EbR3/6QVo0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9410690"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 09:51:40 -0800
Date: Fri, 13 Nov 2026 18:51:36 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Arnd Bergmann <arnd@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lucas De Marchi <demarchi@kernel.org>,
 Riana Tauro <riana.tauro@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Matthew Auld <matthew.auld@intel.com>,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Armin Wolf <W_Armin@gmx.de>, Zhanjun Dong <zhanjun.dong@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Piotr =?iso-8859-1?Q?Pi=F3rkowski?= <piotr.piorkowski@intel.com>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xe: select configfs
Message-ID: <avdOKFx63ZPNTTJ2@black.igk.intel.com>
References: <20261026102603.2045493-1-arnd@kernel.org>
 <avS7mZMrS7nQv_RK@intel.com> <20261113162212.GB7214@mdroper-desk1>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113162212.GB7214@mdroper-desk1>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 08:22:12AM -0800, Matt Roper wrote:
> On Wed, Nov 11, 2026 at 02:01:45PM -0500, Rodrigo Vivi wrote:
> > On Mon, Oct 26, 2026 at 11:25:50AM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The original addition of configfs to xe missed a compile-time dependency,
> > > which leads to a link failure when configfs is enabled as a loadable module:
> > > 
> > > ld.lld-21: error: undefined symbol: xe_configfs_get_survivability_mode
> > > >>> referenced by xe_survivability_mode.c:224
> > > >>>               drivers/gpu/drm/xe/xe_survivability_mode.o:(xe_survivability_mode_is_requested) in archive vmlinux.a
> > > 
> > > A recent workaround added a 'IS_REACHABLE()' check around the calls into
> > > configfs, which makes it link in this configuration, but this is generally
> > > a bad idea because it makes the actual behavior inconsistent and confusing
> > > to users that expect configfs to work if both xe and configfs are enabled.
> > > 
> > > Use 'select CONFIGFS_FS' instead, like every other configfs user does,
> > > and remove the unnecessary stub functions. There is little practical
> > > difference here as anyone using XE graphics is likely to have a complex
> > > configuration that already selects configfs anyway, and the link error
> > > or the IS_REACHABLE() would only manifest during randconfig testing.
> > > 
> > > Fixes: 30499cbd7961 ("drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m")
> > > Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/gpu/drm/xe/Kconfig       |  1 +
> > >  drivers/gpu/drm/xe/xe_configfs.h | 30 ------------------------------
> > >  2 files changed, 1 insertion(+), 30 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> > > index 4fc8abdc5cb6..b52a8dc28f97 100644
> > > --- a/drivers/gpu/drm/xe/Kconfig
> > > +++ b/drivers/gpu/drm/xe/Kconfig
> > > @@ -11,6 +11,7 @@ config DRM_XE
> > >  	# the shmem_readpage() which depends upon tmpfs
> > >  	select SHMEM
> > >  	select TMPFS
> > > +	select CONFIGFS_FS
> > 
> > Perhaps another option would be what Jani had suggested:
> > 
> > config DRM_XE_CONFIGFS
> > 	def_bool y
> > 	depends on DRM_XE && CONFIGFS_FS
> > 	depends on CONFIGFS_FS=y || DRM_XE=m
> > 
> > But anyway, we are depending more and more on the configfs for
> > production choices. So, let's go with you select and close this
> > for good.
> 
> I really don't think this patch was the way we wanted to go.
> IS_REACHABLE was giving us exactly the behavior that we wanted, but now
> we're getting behavior that we did not want.  Xe absolutely does not
> depend on configfs in any way.  _If_ configfs is there we'll enable some
> config options in it, but none of those are mandatory for our driver as
> a whole.  We're perfectly happy to build and run without configfs if
> it's not selected in the config.  We're also happy to build and run
> without configfs functionality if the user wanted Xe built directly into
> the kernel, but configfs was built as an unreachable module solely for
> other non-Xe purposes.
> 
> While this change won't matter to 99% of the cases where someone is
> running with a typical distro kernel, this is the kind of thing that
> makes embedded users unhappy since they're very carefully managing their
> configurations and we've taken away their ability to avoid configfs now.

+1'ing on this. People go to great lengths to save a few bytes, only to
be undone by a non-essential config.

Raag
