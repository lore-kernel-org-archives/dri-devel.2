Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465BCCDE000
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3E710EE6A;
	Wed, 24 Jun 2026 10:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cb1UhANJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C516310EE6A;
 Wed, 24 Jun 2026 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782296042; x=1813832042;
 h=date:to:cc:subject:message-id:references:mime-version:
 in-reply-to:from;
 bh=qdlq6hba7pUusRaImB9v9jjJNCh0CdFKio3R9kCkqvU=;
 b=cb1UhANJD1yCWt32cfuhO2bQVFbxQk0b1yQ2QrsJZjPSQlo5XDM5Lp9b
 JVcPWxTgSSyUtxa2DgJaGOs37AvG1wfLB7cPz0CGHpY2UJ6v+/7QZdOgb
 gqfequiD/m/QRgHpAtpTm9FA8XBpg9nSgwxyD9ib46MHn5P6gwUFAIqPd
 D7yuneUwP93fGXnG05xghuZKRXQXYgxPFPtboEc2lc9NSmjGJeIBZK1KB
 0eUk0UZsXFjaRbafPpnKRp6Q+lFGMC+q7B0RpHDDnfALVxqwFp0tLYliL
 h5bXvEAlKsx9dayai5dxBdjnZBRDBHaLrXDjv2psx0BvyWwMiPMD6hkSY A==;
X-CSE-ConnectionGUID: sWZgOoF1Qwu+XZ3t05N6zQ==
X-CSE-MsgGUID: ZV6zrJg3Qlm0NrHh7RrGzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82925091"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="82925091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:14:02 -0700
X-CSE-ConnectionGUID: bXmnm89bST2CeeccQjTeLg==
X-CSE-MsgGUID: 924S/CsuRYC0LULGuH/zSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="273873653"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP; 24 Jun 2026 03:13:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id B4CC395; Wed, 24 Jun 2026 12:13:57 +0200 (CEST)
Date: Wed, 24 Jun 2026 13:13:56 +0300
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
Message-ID: <ajut5N-FTomAG5DE@kuha>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
 <ajqaid7CHChu35iR@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqaid7CHChu35iR@black.igk.intel.com>
rom: Heikki Krogerus <heikki.krogerus@linux.intel.com>
From: Heikki Krogerus <heikki.krogerus@intel.com>
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

On Tue, Jun 23, 2026 at 04:39:05PM +0200, Raag Jadav wrote:
> On Mon, Jun 22, 2026 at 01:47:59PM +0200, Heikki Krogerus wrote:
> > Some platforms make an assumption that the i2c controller's
> > enabled state indicates also the power state of the
> > controller. This can create a problem when the controller is
> > in disabled state, because the hardware may assume
> > incorrectly that it is then also in low-power state.
> > 
> > To fix this, the controller is kept enabled by taking over
> > the IC_ENABLE register. The controller has to be disabled
> > when the configuration is updated and when the target
> > address or the slave address are assigned, so disabling it
> > when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> > then re-enabling it again.
> 
> ...
> 
> >  static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
> >  {
> >  	struct xe_i2c *i2c = context;
> >  
> > -	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> > +	switch (reg) {
> 
> Curious, should I expect DW_IC_INTR_MASK case here which skips the MMIO?

Probable not. We have the ACCESS_POLLING flag set, so the
i2c-designware will only write 0 to that register. Check
__i2c_dw_write_intr_mask().

Thanks,

-- 
heikki
