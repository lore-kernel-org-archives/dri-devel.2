Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD44CDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34B110E32A;
	Tue, 23 Jun 2026 14:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JSClM7pR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC05810E32A;
 Tue, 23 Jun 2026 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782225552; x=1813761552;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dImJFPzxH/4Wshq1scD91Jr8EQJjWmN3JFUnfWJNQRc=;
 b=JSClM7pRSK+poZ88C5LK0HsuUFaONpI4ganseGoVjiswXS7+54xCz09L
 OMXucJSMbtXg7OgYUh7pWFfEWshJ/GiI/HSct/QCbSQlDC1W4KWr5Oz2J
 jp28uyDCVu1h2VUo+2+8CGjBhn1kh6E2ZVYLBjR5IBB+F74FsIhsXQOJ4
 my/x6+20nxGpd6R4YH8mK7tOUxOY+F3f6AH29kf4C9zRVbFPQZ8M/9ZLC
 zWPCYt2APgwwiw5tRQGWItsxtfNDG1anXxC3U4NzCUnK+UPGynGYACMXA
 4nOHlg/1xNd6B1okXpHszzGz3jrHWsed+xMJysTvDyrfSmwCPDEEP7A8u Q==;
X-CSE-ConnectionGUID: JPHeVB6TQ8eSHoE/WBYajg==
X-CSE-MsgGUID: 5x5grzkXShO2pPHmgion7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82737315"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82737315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:39:12 -0700
X-CSE-ConnectionGUID: AdCqRy2dTQS/slZH/nscEw==
X-CSE-MsgGUID: rf7WIfAISQ6Oo/uTRJqshQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="287667559"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:39:09 -0700
Date: Tue, 23 Jun 2026 16:39:05 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
Message-ID: <ajqaid7CHChu35iR@black.igk.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
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

On Mon, Jun 22, 2026 at 01:47:59PM +0200, Heikki Krogerus wrote:
> Some platforms make an assumption that the i2c controller's
> enabled state indicates also the power state of the
> controller. This can create a problem when the controller is
> in disabled state, because the hardware may assume
> incorrectly that it is then also in low-power state.
> 
> To fix this, the controller is kept enabled by taking over
> the IC_ENABLE register. The controller has to be disabled
> when the configuration is updated and when the target
> address or the slave address are assigned, so disabling it
> when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> then re-enabling it again.

...

>  static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct xe_i2c *i2c = context;
>  
> -	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> +	switch (reg) {

Curious, should I expect DW_IC_INTR_MASK case here which skips the MMIO?

> +	case IC_ENABLE:
> +		*val = i2c->ic_enable;
> +		break;
> +	case IC_ENABLE_STATUS:
> +		*val = i2c->ic_enable & 1; /* NOTE: Checking only the enable bit */
> +		break;
> +	default:
> +		*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
> +		break;
> +	}
>  
>  	return 0;
>  }
> @@ -273,8 +312,30 @@ static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
>  static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
>  {
>  	struct xe_i2c *i2c = context;
> +	int ret;
>  
> -	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> +	switch (reg) {

Ditto.

Raag

> +	case IC_CON:
> +	case IC_TAR:
> +	case IC_SAR:
> +		/* Disable the controller. */
> +		ret = xe_i2c_disable(i2c);
> +		if (ret)
> +			return ret;
> +
> +		/* Write the register. */
> +		xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> +
> +		/* Enable the controller. */
> +		xe_mmio_rmw32(i2c->mmio, XE_REG(IC_ENABLE + I2C_MEM_SPACE_OFFSET), 0, 1);
> +		break;
> +	case IC_ENABLE:
> +		i2c->ic_enable = val;
> +		break;
> +	default:
> +		xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> +		break;
> +	}
>  
>  	return 0;
>  }
