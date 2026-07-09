Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477AAC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A453D10F59B;
	Thu,  9 Jul 2026 12:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c4byk8YJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01B510F59B;
 Thu,  9 Jul 2026 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783600387; x=1815136387;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tiVr5NlYsZcsHpK6BRTFvxIB5tl3yk+S0wEBZSkRx7g=;
 b=c4byk8YJ5t0h+JCHD6w1RyJBPtFCYmrUdJOGYn2aKf5p44aMPmR/d08T
 IvtOe6ZCItSoV5Xww8ua+ndLqb8aBOlm9tgEt6oS7vgblSZuw/MVSxdvU
 7tmOeM/2IYDKUEg/293JMY2uhppM4xnG53D/zfIrdYSI6Cc6AhdLIdfM3
 rsLs10jcdC+iMzTZlw95gKAi2qPfwdwY7Zo06ALun06zRzTULy1rkYslM
 9K0KfL1Q+H8BlAAgb8O4Thi5fkd5PdyF97t+o7B6FrNQEexPTnhxsOGrS
 tibKXC5ij0qeu4egPKvzky6sF4TSvEaBKFKyNttNJUt1RfxLNoezFKTnq g==;
X-CSE-ConnectionGUID: Ry/Iup3wRSWyAW+AuMXJVQ==
X-CSE-MsgGUID: tmsUxoVZQWyktoGNWcHAYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86821469"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="86821469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 05:33:06 -0700
X-CSE-ConnectionGUID: RtmrszJ8QyG/9rEsPua9rA==
X-CSE-MsgGUID: LrgbutjvQsWTPI4YAp3ZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251920890"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 05:33:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 7587495; Thu, 09 Jul 2026 14:33:02 +0200 (CEST)
Date: Thu, 9 Jul 2026 15:33:00 +0300
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
 Andi Shyti <andi.shyti@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/xe/i2c: Handler for SMBus Alerts
Message-ID: <ak-U_HXXukQ22xLm@kuha>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
 <akOAy1AhbMkSxdjA@black.igk.intel.com> <akOS0bAhabVXVtqM@kuha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akOS0bAhabVXVtqM@kuha>
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

Hi Raag,

On Tue, Jun 30, 2026 at 12:56:34PM +0300, Heikki Krogerus wrote:
> On Tue, Jun 30, 2026 at 10:39:39AM +0200, Raag Jadav wrote:
> > On Thu, Jun 25, 2026 at 02:59:38PM +0200, Heikki Krogerus wrote:
> > > Some devices that are attached to the I2C controller use the
> > > SMBus Alert signal for example to inform the host about
> > > thermal events, so registering the default SMBus Alert
> > > device for them. The alert device makes sure that the alert
> > > is processed and passed to the correct I2C client driver.
> > 
> > ...
> > 
> > > +static int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
> > > +{
> > > +	struct xe_device *xe = kdev_to_xe_device(i2c->drm_dev);
> > > +	struct i2c_client *alert;
> > > +
> > > +	if (xe->info.platform != XE_CRESCENTISLAND)
> > 
> > Rather, introduce a has_i2c_smbus flag in xe_device_types.h and keep
> > things platform agnostic. I think you'll also need it to early return
> > from xe_i2c_create_irq().
> 
> OK. Feature flags are nice.

There is an issue with the interrupts. Right now with mainline the
i2c-designware enables the interrupt because it is supplied with the
adapter_irq, even though the interupt can only be used for these
alerts. So that really has to be fixed.

I'm going to drop this alert handler, and instead propose that we
process the alerts from AMC directly here in Xe, and at the same time
remove the problematic adapter_irq completely like you proposed
earlier.

Thanks,

-- 
heikki
