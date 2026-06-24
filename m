Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96E7CDB471
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419F010E06A;
	Wed, 24 Jun 2026 11:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R6zoJny2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA6510E06A;
 Wed, 24 Jun 2026 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782300534; x=1813836534;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3LyBggRYlVLVGegoWdh184Yt5kTHu9kf4ms6LZphWcs=;
 b=R6zoJny2JNxNzyeR/DFbinZcFdLfMPv/m42nl1FqhOG74sLoHaF+h9rF
 CctKxlydg1i2I2muymfimctqEl0M+2nHDZnM+hnYVwYIntgWixrHDvej8
 ZJP/C5uH4ghnPcpPtNezmvjOwYohooeMeFJwcbgVZQZyfBx90zUa2r+OX
 rNV2zCDeLuqaflQV29uROfBz50NrHYZJu0PIsrvX0AARfJlVSs2DOJxoB
 bRWfvhD+Zwgz9H5FTVtH5zMlmo5NqdhDsuju2VIphrBgjo85rPiykO+Ll
 5TlIsvE30K32BoJgrKNzKVpv/iahtmaUEXUg8yPypJvGNpda0aTAyJWQe Q==;
X-CSE-ConnectionGUID: S7hnVTTeRwqmKkZFaaRtpg==
X-CSE-MsgGUID: 3kqIIFAwR7ynQob3oWieAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82828970"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="82828970"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:28:53 -0700
X-CSE-ConnectionGUID: xK+qPseBR/W4NNBYsCHXgQ==
X-CSE-MsgGUID: CDXDMU5DSzShzgQa8tRqbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245707388"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa010.fm.intel.com with ESMTP; 24 Jun 2026 04:28:50 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 66CF695; Wed, 24 Jun 2026 13:28:49 +0200 (CEST)
Date: Wed, 24 Jun 2026 14:28:47 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/xe/mcu_i2c: Take over control of the
 controller enabling
Message-ID: <aju_byFudTOeN6qz@kuha>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
 <ajqaid7CHChu35iR@black.igk.intel.com> <ajut5N-FTomAG5DE@kuha>
 <aju7-s04LShxB-i8@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aju7-s04LShxB-i8@black.igk.intel.com>
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

On Wed, Jun 24, 2026 at 01:14:02PM +0200, Raag Jadav wrote:
> On Wed, Jun 24, 2026 at 01:13:56PM +0300, Heikki Krogerus wrote:
> > On Tue, Jun 23, 2026 at 04:39:05PM +0200, Raag Jadav wrote:
> > > On Mon, Jun 22, 2026 at 01:47:59PM +0200, Heikki Krogerus wrote:
> > > > Some platforms make an assumption that the i2c controller's
> > > > enabled state indicates also the power state of the
> > > > controller. This can create a problem when the controller is
> > > > in disabled state, because the hardware may assume
> > > > incorrectly that it is then also in low-power state.
> > > > 
> > > > To fix this, the controller is kept enabled by taking over
> > > > the IC_ENABLE register. The controller has to be disabled
> > > > when the configuration is updated and when the target
> > > > address or the slave address are assigned, so disabling it
> > > > when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> > > > then re-enabling it again.
> > > 
> > > ...
> > > 
> > > >  static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
> > > >  {
> > > >  	struct xe_i2c *i2c = context;
> > > >  
> > > > -	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> > > > +	switch (reg) {
> > > 
> > > Curious, should I expect DW_IC_INTR_MASK case here which skips the MMIO?
> > 
> > Probable not. We have the ACCESS_POLLING flag set, so the
> > i2c-designware will only write 0 to that register. Check
> > __i2c_dw_write_intr_mask().
> 
> Yes, but I'm not sure if all the writes to DW_IC_INTR_MASK have been
> converted to use that helper yet, or did I miss something?

It is only written directly in slave mode, but since slave mode is not
supported with ACCESS_POLLING at the moment, we will never reach that
code.

I'm hoping we will never have to support ACCESS_POLLING in slave mode,
but I'll send a patch (not as part of this series) in any case where
I'll make sure DW_IC_INTR_MASK is only written from that helper.

Thanks,

-- 
heikki
