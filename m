Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D98CDB47C
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA97110EE43;
	Wed, 24 Jun 2026 09:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VhxkMXxm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2175610EE41;
 Wed, 24 Jun 2026 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782293236; x=1813829236;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dI0O288id5nByduVA0CM6QTnd06XGS0SpN64DxnqARQ=;
 b=VhxkMXxmbm5mi6HJHQ17F33ykbjP83LN7oCkpRB7bVD7Fi1qoN90H4bo
 x7z+rG4aox0rvp5ChewXFc3vbaB4vpQNSWtOd1RNwWfc4H0L+QxlhE6MR
 rCys32dkN6dT4685+GPLxXvwuzMfnryWR1TvYNce1kydOr9NjCahYBKt4
 Nques4dsdsYr8B3TNIm4ba2MKmJn5ceX4ihqz42tqee0NK5GUX7WKwcTV
 4LUs5hrhZwiQfbTZrnRn2CfwK3CRE/PtMRQguHlIPTvxcfC+I0Of5RGWS
 QQXnv/wKl+GEKRLa/xq6xbIrjYKhMgU7r1fboMoxAhV8lWxpZ0OFQWLBy A==;
X-CSE-ConnectionGUID: Irnx4W+nSOaQ83LgvkH0MA==
X-CSE-MsgGUID: LckDsjQpQteAOqt233zjNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86731952"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="86731952"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 02:27:15 -0700
X-CSE-ConnectionGUID: XdfY8CY0SduRc8eSn4RE8w==
X-CSE-MsgGUID: hF6WLbKETgOnCpRIH38j7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="273854445"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP; 24 Jun 2026 02:27:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 1DADD95; Wed, 24 Jun 2026 11:27:12 +0200 (CEST)
Date: Wed, 24 Jun 2026 12:27:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
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
Message-ID: <ajui7vNvhzJSNu9C@kuha>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
 <ajpmdQjArQkhQ8fl@ashevche-desk.local>
 <ajqfH5j58Z8L_XJN@black.igk.intel.com>
 <ajrL_5cPDIlXcfXP@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajrL_5cPDIlXcfXP@ashevche-desk.local>
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

On Tue, Jun 23, 2026 at 09:10:07PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 04:58:39PM +0200, Raag Jadav wrote:
> > On Tue, Jun 23, 2026 at 01:56:53PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 22, 2026 at 01:47:59PM +0200, Heikki Krogerus wrote:
> 
> ...
> 
> > > > +#define IC_CON				0x00
> > > > +#define IC_TAR				0x04
> > > > +#define IC_SAR				0x08
> > > > +#define IC_ENABLE			0x6c
> > > > +#define IC_ENABLE_STATUS		0x9c
> > > 
> > > Heh, I would like to have a shared header with the registers, but dunno
> > > if the prons will weight out the cons.
> > 
> > Perhaps something like i2c-algo-pca.h?
> 
> It's different. It's more device specific header and it doesn't look like
> a platform data. For SPI PXA2xx we have them in pxa2xx_ssp.h. And we have
> some device specific i2c headers, seems like the pattern is
> *_i2c.h, exempli gratia, designware_i2c.h.

Okay, I'll add a patch the series where I'll move the register
definitions to include/linux/designware_i2c.h

Cheers,

-- 
heikki
