Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6228CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4354810EA96;
	Tue, 23 Jun 2026 10:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZyR4Qyk4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758B010EA96;
 Tue, 23 Jun 2026 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782212219; x=1813748219;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aPIE95mLRe42YcYMyleHpuz76yXdRQVmwRI/yhRFbK8=;
 b=ZyR4Qyk4GdI2nWro0oqh0D+4+2QSVM6KUZfswaSKu9JMZhXmL4yNvFPP
 Dt1b6kVr/e9uwg0LFvcnzspMqKrHTPY9VdochqWSs2YDBbMTu1oz3L/k1
 mYZqkt4/+a59VkG63OHc7VnU/Fn+mctKAf72ob312SEfSg15m5nqDl7FN
 vVpMJtZpopMh7Fappw2e7p0+Mvm+pXa5C6uoDPP+rfohVajwSMrVQ3bAc
 9iSeOuQU9aBNQ9/YKipuwIgo/jloNCdHEEcImwjff7Uih8nuMd/h2L9VF
 qc066k/1JnopqqmOZIvkYmVLiWfHHvnXDNhna2+7KPh0/ydxhEnfstrSc w==;
X-CSE-ConnectionGUID: cdT5ptQOSJ2Jw+RJ5ZWJTg==
X-CSE-MsgGUID: At/gHr/sRFKRNHrTfIq3qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="81931388"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="81931388"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:56:59 -0700
X-CSE-ConnectionGUID: OTLYXidkQ7aSmp6fk9EOCw==
X-CSE-MsgGUID: QnFnGt+ZRLmcYl22vHtP8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="248341192"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.7])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:56:56 -0700
Date: Tue, 23 Jun 2026 13:56:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Raag Jadav <raag.jadav@intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/xe/mcu_i2c: Take over control of the
 controller enabling
Message-ID: <ajpmdQjArQkhQ8fl@ashevche-desk.local>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622114759.3464047-3-heikki.krogerus@linux.intel.com>
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

> +#define IC_CON				0x00
> +#define IC_TAR				0x04
> +#define IC_SAR				0x08
> +#define IC_ENABLE			0x6c
> +#define IC_ENABLE_STATUS		0x9c

Heh, I would like to have a shared header with the registers, but dunno
if the prons will weight out the cons.

...

> +/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
> +static int xe_i2c_disable(struct xe_i2c *i2c)
> +{
> +	int timeout = 100;
> +	u32 status;
> +
> +	do {
> +		/* Disable.*/
> +		xe_mmio_rmw32(i2c->mmio, XE_REG(IC_ENABLE + I2C_MEM_SPACE_OFFSET), 1, 0);
> +
> +		/* Verify. */
> +		status = xe_mmio_read32(i2c->mmio, XE_REG(IC_ENABLE_STATUS + I2C_MEM_SPACE_OFFSET));
> +		if (!(status & 1))
> +			return 0;
> +
> +		/* Repeat. */
> +		usleep_range(25, 250);

fsleep().

> +	} while (timeout--);
> +
> +	return -ETIMEDOUT;
> +}

-- 
With Best Regards,
Andy Shevchenko


