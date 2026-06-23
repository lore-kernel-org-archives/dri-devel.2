Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B221CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E1D10EA93;
	Tue, 23 Jun 2026 10:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m/rEn9M7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DCF10EA93;
 Tue, 23 Jun 2026 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782212067; x=1813748067;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3+cV/NKPssPEg2R6Cmh9eMoc75Lw0+c1VYJ0GE5YGWo=;
 b=m/rEn9M78kUV0dnv9lk85HCRMDwBjQ7Jo/zcjoDRIhnkbXXGDI7B30JH
 MD9NuHc+N4jVBhZFy9hfUfWoqoU3mmLlPlGyfLjiM8GBwv+6SECyLhYJb
 cKLM53Zt6rzkOA0tLWsHGQ6B/zkqykA3os85kq3tZNYstawF5/3irmp5Y
 JArRDldUGBAPNE/02B5eqRau/qNkMFMJTTJvVOFKuHNZnf5ds5MYoQhQ+
 xNV6IdPRdibsZgEfkh3o2u+4mKns19t3+6q9bDhDupzJMJ2v3cIAximav
 5eHh8j8pA1m/JBjfyPhVM2WHjS/dyjA6p3qq55EbUSxxAEf+YPeF9Mtfr Q==;
X-CSE-ConnectionGUID: DFCgOsedR/aYYq4+k+aT0Q==
X-CSE-MsgGUID: eWk1qG3KSVSjhZquu81jxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="83140419"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="83140419"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:54:27 -0700
X-CSE-ConnectionGUID: zJm17iTsSFyKrz3qAwQDfA==
X-CSE-MsgGUID: BxWKVuh4Ql6siAOUuaYliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="273183758"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.7])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:54:23 -0700
Date: Tue, 23 Jun 2026 13:54:21 +0300
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
Subject: Re: [PATCH v1 1/2] drm/xe/i2c: Handler for SMBus Alerts
Message-ID: <ajpl3Tv-bCc8kfWG@ashevche-desk.local>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
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

On Mon, Jun 22, 2026 at 01:47:58PM +0200, Heikki Krogerus wrote:
> Some devices that are attached to the I2C controller use the
> SMBus Alert signal for example to inform the host about
> thermal events, so registering the default SMBus Alert
> device device for them. The alert device makes sure that
> the alert is processed and passed to the correct I2C client
> driver.

...

> +	if (i2c->smbus_alert)

Unneeded. Also the below incorporates error pointer cases.

> +		i2c_unregister_device(i2c->smbus_alert);
> +
>  	if (!i2c->irqdomain)
>  		return;

...

> +++ b/drivers/gpu/drm/xe/xe_i2c_smbus.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Intel Xe SMBus handling
> + *
> + * Copyright (C) 2026 Intel Corporation.
> + */

+ bits.h // BIT()
+ err.h // IS_ERR()

> +#include <linux/i2c-smbus.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...

> +static struct i2c_smbus_alert_setup xe_i2c_smbus_setup;
> +
> +int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
> +{
> +	struct i2c_client *alert;
> +
> +	alert = i2c_new_smbus_alert_device(i2c->adapter, &xe_i2c_smbus_setup);
> +	if (IS_ERR(alert))
> +		return PTR_ERR(alert);
> +
> +	i2c->smbus_alert = alert;
> +
> +	return 0;
> +}

As per above comment, this IS_ERR() is not need, as the removal API is optional-aware.
OTOH, the other NULL-check in the driver in that case needs to be IS_ERR_OR_NULL().

But I'm not sure if you want to have alert setup to always succeed.

-- 
With Best Regards,
Andy Shevchenko


