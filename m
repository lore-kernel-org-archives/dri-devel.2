Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520BCC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C1810E1B1;
	Tue, 30 Jun 2026 09:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bALv2/0y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2003D10E1B1;
 Tue, 30 Jun 2026 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782813399; x=1814349399;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tVQbfGP0k8yz2W9KVQvlZMNsQQuav4FqShdctd5GCug=;
 b=bALv2/0y4QFjm9ZsdQgsNzPzEE83LgE9NKTJiDcl176aZjE0I3wnZ0j0
 EF724MxEPNZ21A/dU6pDculJnH50VTPffIVgf92Uv01MD9n+kCHnHR30g
 Hb4ws8PWhZbqIRQ5LhfD3SurouIiD6tgmoyIY4S09ODaSST+uK/gSfz7L
 ut/Tl3iMzsudUJVnQqxLScRvhHHEaJ/UFcOjEFWwJJEKQQB5kiSViVme7
 EitgJ0CYQzu+/3V/ggmVXu812ZVZK4WpscLytYtovJ+MgPO4ZSKqwphcg
 dfgOX+VsBmDeqgVuLyYrPICEUt7338gssb3GWtC0CXQFZeuN1EfGUk7aC A==;
X-CSE-ConnectionGUID: j/hY2/uJTTmYtNnaG9tfWQ==
X-CSE-MsgGUID: 620tljwMSKmP3+8h9DiYfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="109071209"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="109071209"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:56:39 -0700
X-CSE-ConnectionGUID: HU1QXltHRxWH76yAXNpY2w==
X-CSE-MsgGUID: rkRorjRkQ5KMuS7SW2SRtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="249576680"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jun 2026 02:56:36 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id E15FA95; Tue, 30 Jun 2026 11:56:34 +0200 (CEST)
Date: Tue, 30 Jun 2026 12:56:33 +0300
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
Message-ID: <akOS0bAhabVXVtqM@kuha>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
 <akOAy1AhbMkSxdjA@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akOAy1AhbMkSxdjA@black.igk.intel.com>
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

On Tue, Jun 30, 2026 at 10:39:39AM +0200, Raag Jadav wrote:
> On Thu, Jun 25, 2026 at 02:59:38PM +0200, Heikki Krogerus wrote:
> > Some devices that are attached to the I2C controller use the
> > SMBus Alert signal for example to inform the host about
> > thermal events, so registering the default SMBus Alert
> > device for them. The alert device makes sure that the alert
> > is processed and passed to the correct I2C client driver.
> 
> ...
> 
> > +static int xe_i2c_register_smbus_alert(struct xe_i2c *i2c)
> > +{
> > +	struct xe_device *xe = kdev_to_xe_device(i2c->drm_dev);
> > +	struct i2c_client *alert;
> > +
> > +	if (xe->info.platform != XE_CRESCENTISLAND)
> 
> Rather, introduce a has_i2c_smbus flag in xe_device_types.h and keep
> things platform agnostic. I think you'll also need it to early return
> from xe_i2c_create_irq().

OK. Feature flags are nice.

Thanks!

-- 
heikki
