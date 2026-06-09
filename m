Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849ECCD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A014310E225;
	Tue,  9 Jun 2026 19:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zl3Uy0gZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630CF10E225
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781031773; x=1812567773;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=deUspC86kBJfg0o/64mhshqzhfCZxHh4On4fEBT3WEI=;
 b=Zl3Uy0gZbwwyzsRUlofJ30QLYh5uLxgNSyajb1qludHqM3HxLCMPGy2W
 aHyOsPPKO333BpxcfRMS/QcTxvEo4zxXUpFNWStbfMbuQZKdF17q/NQki
 PMvi+52pF4V1CTKeuGXOod2u+oQMEZex7V5+VXAChaKC6ZiDQFLgSmbyl
 5onuuy1d+CN2T55z1l4YAuGC/Y8Pckr0ykKvOIleQiHxp5xI9SCUxRNFC
 6QgbTiTGWbQfNHu5str8RaBdKS4ckZ/Z8YWt6IGb8yVpRusdTT8FGTnH1
 nfaFci4JMVVX/EfjY8f/t+pi2vrslQf+tVDFxoHwmvtnoCnW8yOaIj4A2 Q==;
X-CSE-ConnectionGUID: sWW9hLymSGW+2sEnqHIaWQ==
X-CSE-MsgGUID: hsUWUOnwRseSBkr5t+po5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="69341474"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="69341474"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:02:52 -0700
X-CSE-ConnectionGUID: QGqNAd4uTc+4Ed3shPeszQ==
X-CSE-MsgGUID: Ak0qUeEaSXmuteJyhUjHrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="284012438"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.162])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:02:47 -0700
Date: Tue, 9 Jun 2026 22:02:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <aihjVZ9xvM2BRFu4@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-3-clamor95@gmail.com>
 <aiPDzdKuccdLIvlF@ashevche-desk.local>
 <CAPVz0n2rdgw8Xr3uxVdQGwrHTNFqK4SKQDFU2FEB8LzLwPhQ_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2rdgw8Xr3uxVdQGwrHTNFqK4SKQDFU2FEB8LzLwPhQ_A@mail.gmail.com>
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

On Sat, Jun 06, 2026 at 10:22:43AM +0300, Svyatoslav Ryhel wrote:
> сб, 6 черв. 2026 р. о 09:53 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Sat, Jun 06, 2026 at 07:57:26AM +0300, Svyatoslav Ryhel wrote:

...

> > > +     ret = regmap_assign_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
> > > +                              LM3533_ALS_INT_ENABLE_MASK, enable);
> >
> > In cases like this perhaps leaving mask would be fine and together with
> 
> I prefer to remove intermediate variables it the helper allows to
> directly pass needed value.
> 
> >         struct regmap *map = als->lm3533->regmap;
> 
> next patch drops lm3533 so there will be als->regmap which IMHO is
> more logical instead of passing entire lm3533 to child devices.

Still it's longer than map. A local variable may help with making lines
shorter.

> > this be nice one-liner:
> >
> >         ret = regmap_assign_bits(map, LM3533_REG_ALS_ZONE_INFO, mask, enable);
> >
> > >       if (ret) {
> > >               dev_err(&indio_dev->dev, "failed to set int mode %d\n",
> > >                                                               enable);
> >
> > In many cases it won't increase LoC count.

-- 
With Best Regards,
Andy Shevchenko


