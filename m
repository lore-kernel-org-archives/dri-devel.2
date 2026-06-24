Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226EFCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786F310E06E;
	Wed, 24 Jun 2026 11:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YrcOhbqP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC86F10EE9D;
 Wed, 24 Jun 2026 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782299649; x=1813835649;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4Z1i9Z2EfATKkuXzRV/xbJfEP7bd2JhvUbuiK3wcH8I=;
 b=YrcOhbqPhZ7SKifDidlBZBBK30YuMExxU5XvB/EBam5f06U9jyaIKT8J
 5aUbqY/Q6asDq5EY7hOjMHtzf6r8KM88nG4LvoiMXdma7+3voJ/417dM1
 Dfzb0VSiFqOcJZdnWa9j684oEigwpkkmq8FNLXwmJA1+h0t4Alo2r2AXy
 A58szYXaEiQ3k8UiPvJAUD64fCTf7VyC+rl3vqrlVyrJoC6lb8BZ5EbpU
 I5f8f9eLSANzNjvXoGmqVTUArjHQmKFLYAsEbl/Pfg9hAIF3pbFOQdekd
 uD1XYGv8pfeJi3/lhXRG7tRWoksb5K1FEvJ9PJgicJE9hANiAuI+JPehw g==;
X-CSE-ConnectionGUID: yBbj8pVDT1S3yiN/fQI0Xw==
X-CSE-MsgGUID: A91Uq+DdSnWsw8xab9S9lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82827865"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="82827865"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:14:08 -0700
X-CSE-ConnectionGUID: 5etJSCkMTVeo4aUWC2WejQ==
X-CSE-MsgGUID: RN0RErp7Rpa2d0PdDje2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="254787509"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:14:05 -0700
Date: Wed, 24 Jun 2026 13:14:02 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@intel.com>
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
Message-ID: <aju7-s04LShxB-i8@black.igk.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
 <ajqaid7CHChu35iR@black.igk.intel.com> <ajut5N-FTomAG5DE@kuha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajut5N-FTomAG5DE@kuha>
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

On Wed, Jun 24, 2026 at 01:13:56PM +0300, Heikki Krogerus wrote:
> On Tue, Jun 23, 2026 at 04:39:05PM +0200, Raag Jadav wrote:
> > On Mon, Jun 22, 2026 at 01:47:59PM +0200, Heikki Krogerus wrote:
> > > Some platforms make an assumption that the i2c controller's
> > > enabled state indicates also the power state of the
> > > controller. This can create a problem when the controller is
> > > in disabled state, because the hardware may assume
> > > incorrectly that it is then also in low-power state.
> > > 
> > > To fix this, the controller is kept enabled by taking over
> > > the IC_ENABLE register. The controller has to be disabled
> > > when the configuration is updated and when the target
> > > address or the slave address are assigned, so disabling it
> > > when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> > > then re-enabling it again.
> > 
> > ...
> > 
> > >  static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
> > >  {
> > >  	struct xe_i2c *i2c = context;
> > >  
> > > -	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> > > +	switch (reg) {
> > 
> > Curious, should I expect DW_IC_INTR_MASK case here which skips the MMIO?
> 
> Probable not. We have the ACCESS_POLLING flag set, so the
> i2c-designware will only write 0 to that register. Check
> __i2c_dw_write_intr_mask().

Yes, but I'm not sure if all the writes to DW_IC_INTR_MASK have been
converted to use that helper yet, or did I miss something?

Raag
