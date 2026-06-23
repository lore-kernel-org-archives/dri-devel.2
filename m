Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FE6CDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A193C10EB81;
	Tue, 23 Jun 2026 14:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OQMgZsbV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779B210EB81;
 Tue, 23 Jun 2026 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782225252; x=1813761252;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vZ9Ueq2wXFM4RPdfadUQVI4GnefEfSs6G+k0W6B2X3c=;
 b=OQMgZsbVK7dOZWqgeF1lakVWAPpOfMusPhn1cTCVx+tm1xeils4PnKRi
 dAjMH/0XCukmoO6COzC239LmDFT4StQJKISRA0jlW7uYm0uD0JP0CAXKL
 d5jff2cpOk4bebEtzOVDK/4291+t7+geUDCfQ97LAU7kHFnx8km7STqbN
 L2Kv5u+OgZ+fPR+Cteq+9IjfJmc+yvTPg+CBXl2JccQX66T40+DjOViOm
 qtTrCrES51+C1tKnvkGV+AOLcrFE6rWZiuGzK8jUeGUPe6q+Jr4RmwSOB
 A3zvCOIiHwJLtKD7bp8xWrvMinsNi8TPh5eth2xqgpXVS6F5ys8Yqip9k w==;
X-CSE-ConnectionGUID: tcWvXQP0SZ2djrq8S0y21w==
X-CSE-MsgGUID: HHkSm8rySxGBLOeUS7xK5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86656736"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="86656736"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:34:12 -0700
X-CSE-ConnectionGUID: uC6Z1sxGSDWvvF2T7tK4Zw==
X-CSE-MsgGUID: sfSDphYiR06aKAwOflL6jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="248384070"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:34:09 -0700
Date: Tue, 23 Jun 2026 16:34:06 +0200
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
Subject: Re: [PATCH v1 1/2] drm/xe/i2c: Handler for SMBus Alerts
Message-ID: <ajqZXnaU7709IlzA@black.igk.intel.com>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
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

On Mon, Jun 22, 2026 at 01:47:58PM +0200, Heikki Krogerus wrote:
> Some devices that are attached to the I2C controller use the
> SMBus Alert signal for example to inform the host about
> thermal events, so registering the default SMBus Alert
> device device for them. The alert device makes sure that

Nit: Duplicate 'device' ;)

> the alert is processed and passed to the correct I2C client
> driver.

...

> @@ -182,7 +183,10 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
>  		return;
>  
>  	/* Forward interrupt to I2C adapter */
> -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> +	if (xe->i2c->smbus_alert)
> +		xe_i2c_handle_smbus_alert(xe->i2c);
> +	else
> +		generic_handle_irq_safe(xe->i2c->adapter_irq);

This looks like the else case will never hit since no other platform
supports irq. Is it on the cards at some point or can we make it obsolete?

Raag
