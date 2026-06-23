Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAB8CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD57210EABD;
	Tue, 23 Jun 2026 11:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YWQL+7dE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCA810EABD;
 Tue, 23 Jun 2026 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782215070; x=1813751070;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KfC7LNEf+rWrSynyjXVPHNi3QlrfnqyM/nZvUmXLib0=;
 b=YWQL+7dEex2yrB86i1w3JIaLjiEnO0ht9jYbBerieGgwI9+f79/QNxcF
 AbiAnUOYMmKe84XqLu3o2u3jUmuiRPgAyG537TeXKEH/HmRZE5Z7bsUf7
 3Z++CVVLl+NeeD7tvWmcapMZF3yniiTi1CfS3IhYjbIe8BFgRAo4AVVPw
 B26CJg+0QpsUAVtoejiEq3szGlmYCJYwHA+PjMrIUzN2zmqtO9UafXp2n
 zmjq2udQ2z5CUjtLqxV3FEDxMCy6DvKyz92zw3zFcRxriHRyB54inwWyX
 1UZc6jRvUedYhl3bzctHNUkTTK7InCeHUmztMfckCpl0av375Xz38yFmY A==;
X-CSE-ConnectionGUID: niFZCA+6T7yHH4YaU0j6WA==
X-CSE-MsgGUID: 2floyegISs+7ZDJAKsmsRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82997037"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82997037"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 04:44:29 -0700
X-CSE-ConnectionGUID: vkZSM7zBQQ+LKAC5sKVMOg==
X-CSE-MsgGUID: MejXlA9ER2WqsOvVnLYVRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="249615576"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP; 23 Jun 2026 04:44:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id AF54D95; Tue, 23 Jun 2026 13:44:24 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:44:23 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <ajpxl3QTu7GfOmKN@kuha>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
 <ajpl3Tv-bCc8kfWG@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajpl3Tv-bCc8kfWG@ashevche-desk.local>
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

On Tue, Jun 23, 2026 at 01:54:21PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 22, 2026 at 01:47:58PM +0200, Heikki Krogerus wrote:
> > Some devices that are attached to the I2C controller use the
> > SMBus Alert signal for example to inform the host about
> > thermal events, so registering the default SMBus Alert
> > device device for them. The alert device makes sure that
> > the alert is processed and passed to the correct I2C client
> > driver.
> 
> ...
> 
> > +	if (i2c->smbus_alert)
> 
> Unneeded. Also the below incorporates error pointer cases.
> 
> > +		i2c_unregister_device(i2c->smbus_alert);
> > +
> >  	if (!i2c->irqdomain)
> >  		return;
> 
> ...
> 
> > +++ b/drivers/gpu/drm/xe/xe_i2c_smbus.c
> > @@ -0,0 +1,59 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Intel Xe SMBus handling
> > + *
> > + * Copyright (C) 2026 Intel Corporation.
> > + */
> 
> + bits.h // BIT()
> + err.h // IS_ERR()
> 
> > +#include <linux/i2c-smbus.h>
> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
> 
> ...
> 
> > +static struct i2c_smbus_alert_setup xe_i2c_smbus_setup;
> > +
> > +int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
> > +{
> > +	struct i2c_client *alert;
> > +
> > +	alert = i2c_new_smbus_alert_device(i2c->adapter, &xe_i2c_smbus_setup);
> > +	if (IS_ERR(alert))
> > +		return PTR_ERR(alert);
> > +
> > +	i2c->smbus_alert = alert;
> > +
> > +	return 0;
> > +}
> 
> As per above comment, this IS_ERR() is not need, as the removal API is optional-aware.
> OTOH, the other NULL-check in the driver in that case needs to be IS_ERR_OR_NULL().
> 
> But I'm not sure if you want to have alert setup to always succeed.

Thanks Andy. I'll get these fixed.

I have to refactor the code a little. It does not seem to be possible
to try to conditionally include this file based on CONFIG_I2C_SMBUS
like I'm doing now, so I'm going to propose that CONFIG_XE selects
CONFIG_I2C_SMBUS in v2. Since there are only two functions here, I'll
just move them to xe_i2c.c

cheers,

-- 
heikki
