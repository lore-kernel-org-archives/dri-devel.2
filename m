Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACCBCD98CE
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FA610E70E;
	Wed, 10 Jun 2026 18:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hkZ9ibz1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 077AC10E70E
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781117235; x=1812653235;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=XJn1nN80Mrs0zfneGaUZpf4iFT0ELWNA2OOHfHR7TjI=;
 b=hkZ9ibz1WkwKpzctFQ6KyshrYOe9R1rib7fEuFQmd1IdMPru7ODYNrZ9
 7ukBbVsbOEiBnQhJjhJl47Ch0N3+5wOOL1nEX7bCkOkj3nMMe77zPK1/i
 +jQHMOyUfGD7urgqZom27yJDkTABJiK0/kJ3rhiw27H1d3zkz7kUubWoH
 K2cDGTeoPsQ1dCaeDs15Tce2SjKp36TAxGkkVAW03UBY5N9XJi7DgcMfs
 Fna3rXtsCrCfKdnXR6OcCRQiSYOseNuTJpUoU8mCA691QPFyo0Fd9/MoZ
 OKa72FcefpYcz69SFEuWb8Oinf/KIfCo2rGtflmV6gqEaSdNAm4AqDRHB g==;
X-CSE-ConnectionGUID: JKsfDF5uSqimKKOLDyahZw==
X-CSE-MsgGUID: C76xYCK1RkeN8aoEq3Coog==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85761834"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="85761834"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:47:14 -0700
X-CSE-ConnectionGUID: ivWHGwvZSiytIpJqYiLNEQ==
X-CSE-MsgGUID: GJXOPYqCQs++8PYQ2zipPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="246110154"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.38])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:47:09 -0700
Date: Wed, 10 Jun 2026 21:47:07 +0300
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
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to
 device_add_group()
Message-ID: <aimxK3asZjebYrNt@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local>
 <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
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

On Wed, Jun 10, 2026 at 05:38:38PM +0300, Svyatoslav Ryhel wrote:
> вт, 9 черв. 2026 р. о 22:14 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > > Switch from sysfs_create_group() to device_add_group() including device
> > > managed where appropriate.
> >
> > This should use .dev_groups member of struct device_driver.
> 
> Specify pls, device_add_group literally uses dev_groups, I don't
> understand what is wrong.

dev_groups of the struct device_driver. It means that the data should be
static and be available before driver probe is called.

...

> > > +     ret = devm_device_add_group(&bd->dev, &lm3533_bl_attribute_group);
> >
> > This will make Greg KH very grumpy. (For the record, original code as well
> > but it already is in upstream. So, thanks for trying to address this, just
> > needs a bit more of work.)
> 
> In the prev iteration YOU asked to me to adjust this. I have adjusted
> and now you say that this is not appropriate. I will just drop this
> commit altogether.

Yes, and I still tell that this is the way to fix that issue.

You can even do it yourself in a few clicks (hint: `git log --grep` is the tool
of the day): 93afe8ba9b01 ("ACPI: TAD: Use dev_groups in struct device_driver").
This is an example of what I meant.

> > > +     if (ret < 0)
> > > +             return dev_err_probe(&pdev->dev, ret,
> > > +                                  "failed to create sysfs attributes\n");

-- 
With Best Regards,
Andy Shevchenko


