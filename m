Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C92EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A334810E18E;
	Tue, 30 Jun 2026 08:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QMe5WCND";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E18D10E18E;
 Tue, 30 Jun 2026 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782808786; x=1814344786;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EUfQGRyasCSbmwp8IOII8FDqfG3pxS91aWxjSPo+AW8=;
 b=QMe5WCNDlT+9NXh0qEUvESOoXUvgRbtyZgp0sHla3LfC2fviDCHcv+Ff
 tGT/fGT0MPm7ilWm3RMIGPOkfAv8bNBVyF9Wj7boi5KijNnmmSe7DzkCX
 jzyVHaZR0aLiYFKyUH3Qe6nYvxx0+SJDxePCBWIRU9LFCZc9fKEphWgfI
 3aXPMWPWHwDF0tGuG9eh77frJeDf4mMi+nn57rY2GgMD/oiNstG7lLHPw
 boUI+Kl7YAgjH1ze/xcF0mXlCGxP5hlnBUx2R/qrwgjXbRTOB31LuRagK
 8Yly588bYiIihVv7/EPhYePi3zKA6WH2ANkcXmlIrt6xVtVf9ICegCIjn w==;
X-CSE-ConnectionGUID: rzU7P5YgQ4KXqA2PaArE6A==
X-CSE-MsgGUID: w7tJl7QmQXizix9t/NKSPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="71038342"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="71038342"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 01:39:46 -0700
X-CSE-ConnectionGUID: jlcP/zO/SX+BvGRiA8zevg==
X-CSE-MsgGUID: GVF3NpmfRRar7SSIHgmKzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="255798935"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 01:39:43 -0700
Date: Tue, 30 Jun 2026 10:39:39 +0200
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
 Andi Shyti <andi.shyti@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/xe/i2c: Handler for SMBus Alerts
Message-ID: <akOAy1AhbMkSxdjA@black.igk.intel.com>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
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

On Thu, Jun 25, 2026 at 02:59:38PM +0200, Heikki Krogerus wrote:
> Some devices that are attached to the I2C controller use the
> SMBus Alert signal for example to inform the host about
> thermal events, so registering the default SMBus Alert
> device for them. The alert device makes sure that the alert
> is processed and passed to the correct I2C client driver.

...

> +static int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
> +{
> +	struct xe_device *xe = kdev_to_xe_device(i2c->drm_dev);
> +	struct i2c_client *alert;
> +
> +	if (xe->info.platform != XE_CRESCENTISLAND)

Rather, introduce a has_i2c_smbus flag in xe_device_types.h and keep
things platform agnostic. I think you'll also need it to early return
from xe_i2c_create_irq().

> +		return 0;
> +
> +	alert = i2c_new_smbus_alert_device(i2c->adapter, &xe_i2c_smbus_setup);
> +	if (IS_ERR(alert))
> +		return PTR_ERR(alert);
> +
> +	i2c->client[XE_I2C_CLIENT_ALERT] = alert;
> +
> +	return 0;
> +}

...

> @@ -182,7 +222,10 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
>  		return;
>  
>  	/* Forward interrupt to I2C adapter */
> -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> +	if (xe->info.platform == XE_CRESCENTISLAND)

Ditto.

Raag

> +		xe_i2c_handle_smbus_alert(xe->i2c);
> +	else
> +		generic_handle_irq_safe(xe->i2c->adapter_irq);
