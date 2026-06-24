Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912F6CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DD010EE39;
	Wed, 24 Jun 2026 09:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XVtWEvxQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D2A10EE39;
 Wed, 24 Jun 2026 09:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782292986; x=1813828986;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ER0Ha8/W/1ogI3UhR2iFbBaUkIegTlSxqgNA1aKKQ+Q=;
 b=XVtWEvxQIhFeSv7pjYFWwkB6OMDfK18TROn9pKzHsJaf+MW1U3YSI7x5
 xHJ6nhR0NsJiDCy0BZNVlD+nuTLtivWp4gjE0mm/b13TJigafujliuMyi
 z883c6Q2btEF/lJrRC7Hw/EDfFPqZ2IT5nUDegUEn+lsvEDvfR3D7sSLg
 rHVMrMgKryVbpWmljwqmGXjSGrINqliZVnXMZ6WZS6z7ZuS/8n03fnc4m
 cMT3+a9iOwwImibNeg981XD9C/79wLWZ0QgFBXcZasFNmzOdPfUFRl9nB
 k61ZAdno6yh4FvtBxASPwINEhxnaf6IzwWbS5jk41xND7Uj4raYVzJ4My g==;
X-CSE-ConnectionGUID: SOKylyyWSGmxuWrmMoNR4w==
X-CSE-MsgGUID: d0D/S9TARMGJfuYchUbdPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100473637"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="100473637"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 02:23:05 -0700
X-CSE-ConnectionGUID: BxUn7xoeRPSQeDtkX+eq4g==
X-CSE-MsgGUID: TayrNkd3RB6Ru63uwUvdAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="254762946"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa005.jf.intel.com with ESMTP; 24 Jun 2026 02:23:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id E525295; Wed, 24 Jun 2026 11:23:01 +0200 (CEST)
Date: Wed, 24 Jun 2026 12:23:00 +0300
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
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/xe/i2c: Handler for SMBus Alerts
Message-ID: <ajuh9K5C3gcDeKwl@kuha>
References: <20260622114759.3464047-1-heikki.krogerus@linux.intel.com>
 <20260622114759.3464047-2-heikki.krogerus@linux.intel.com>
 <ajqZXnaU7709IlzA@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajqZXnaU7709IlzA@black.igk.intel.com>
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

On Tue, Jun 23, 2026 at 04:34:06PM +0200, Raag Jadav wrote:
> On Mon, Jun 22, 2026 at 01:47:58PM +0200, Heikki Krogerus wrote:
> > Some devices that are attached to the I2C controller use the
> > SMBus Alert signal for example to inform the host about
> > thermal events, so registering the default SMBus Alert
> > device device for them. The alert device makes sure that
> 
> Nit: Duplicate 'device' ;)
> 
> > the alert is processed and passed to the correct I2C client
> > driver.
> 
> ...
> 
> > @@ -182,7 +183,10 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
> >  		return;
> >  
> >  	/* Forward interrupt to I2C adapter */
> > -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> > +	if (xe->i2c->smbus_alert)
> > +		xe_i2c_handle_smbus_alert(xe->i2c);
> > +	else
> > +		generic_handle_irq_safe(xe->i2c->adapter_irq);
> 
> This looks like the else case will never hit since no other platform
> supports irq. Is it on the cards at some point or can we make it obsolete?

I'm not sure yet. Right now it looks like there could be need for it
later, but I'm just not sure. Let's keep it for now.

thanks,

-- 
heikki
