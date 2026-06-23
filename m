Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA5CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C8B10EC32;
	Tue, 23 Jun 2026 18:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lpt2Gg4Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE20010EC32;
 Tue, 23 Jun 2026 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782238213; x=1813774213;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HdcZ4UxFv4lma4c30QOnVADv5AllBw6dqoVSKRKWQ9A=;
 b=lpt2Gg4Yr/l4ZXoiwebiUNnwJzm3+DzNMQYVDusWGqECk8emGz9s6YWv
 z51TDaNEahviBT22F0xp9b54HaKme5xgBx0FmGhyJQ8fSh4AWZ0Nwpzdw
 x0uivENbKiIzSELfj6IntnFn50LQ9RWS/2gwX5KGK2Nj6N4SqzbPGho1N
 Y+1uofeTxG8dJvlGRUk+FVpQDXrlw2LkEoCbjl4fuS/7hS8s6KVKMaR7F
 4o1oq3v7WRt6b8JinBjmmlINVbmm+7tjPzxsjJYdqcKagmovoMJ4d70mC
 fS7sTwlnYWfjLX7plv4MxyujuAsbp28qtOQabCbdggMPnxzqmJbMzl54b Q==;
X-CSE-ConnectionGUID: llQ3WNnnRAqr3WZOGPWDhw==
X-CSE-MsgGUID: pwtJYCxhSEWaEVBjHOdgpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86828400"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="86828400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 11:10:13 -0700
X-CSE-ConnectionGUID: 1z3lX5exRQe9p5/awCFuVw==
X-CSE-MsgGUID: X24uG0eJTPCluVdZdOhI8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="243222741"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.7])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 11:10:10 -0700
Date: Tue, 23 Jun 2026 21:10:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/xe/mcu_i2c: Take over control of the
 controller enabling
Message-ID: <ajrL_5cPDIlXcfXP@ashevche-desk.local>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
 <ajpmdQjArQkhQ8fl@ashevche-desk.local>
 <ajqfH5j58Z8L_XJN@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqfH5j58Z8L_XJN@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Tue, Jun 23, 2026 at 04:58:39PM +0200, Raag Jadav wrote:
> On Tue, Jun 23, 2026 at 01:56:53PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 22, 2026 at 01:47:59PM +0200, Heikki Krogerus wrote:

...

> > > +#define IC_CON				0x00
> > > +#define IC_TAR				0x04
> > > +#define IC_SAR				0x08
> > > +#define IC_ENABLE			0x6c
> > > +#define IC_ENABLE_STATUS		0x9c
> > 
> > Heh, I would like to have a shared header with the registers, but dunno
> > if the prons will weight out the cons.
> 
> Perhaps something like i2c-algo-pca.h?

It's different. It's more device specific header and it doesn't look like
a platform data. For SPI PXA2xx we have them in pxa2xx_ssp.h. And we have
some device specific i2c headers, seems like the pattern is
*_i2c.h, exempli gratia, designware_i2c.h.

-- 
With Best Regards,
Andy Shevchenko


