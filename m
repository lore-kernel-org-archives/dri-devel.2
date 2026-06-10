Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EB0CD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4A510EB98;
	Wed, 10 Jun 2026 18:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N8XJTKA0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A811910EB98
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781117669; x=1812653669;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=n2hV3B6fSubnHZBMr0PxV8zbuDwCIP6mPGSYy7ANljI=;
 b=N8XJTKA0GatgLugjB8xAOpEJ27IY8Pmn3gstdZWB5v0m2eCcLIv63Hnd
 UoetNvREVtCQewES7n1lIG83PuwiPDYddZlFPaAosJbPTZpP5krhGo2MH
 EcYE4HwIPqvdDmZHn6I+9i3K++QIHYQCPO77PSmS10/DMh3lUlGTRlJSn
 GvDNYcP/tV6kBUnWe4krzAWqMVpUdEwICJxBxvQKOuWXRMLzPASvQO9r5
 mn3RedqFaHDgejkspORMGhGx08adhLuJRjEEuBAZVkVncXeLhdBJJF5so
 aFgI1vKhAfW+e8QhbbDS3pRPO2xfsboEleaVTXRBlhrgaXL0Jk8IP7baZ g==;
X-CSE-ConnectionGUID: eqPvKkunTTeh2GH1LstKYw==
X-CSE-MsgGUID: S1JGV9EiRwmRyNYsCtZ06Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81054260"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81054260"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:54:28 -0700
X-CSE-ConnectionGUID: bQUxm7piTyaMuGNbETdheg==
X-CSE-MsgGUID: 17pHQK9bRmy31JSdm4IojA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="250530135"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.38])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:54:22 -0700
Date: Wed, 10 Jun 2026 21:54:20 +0300
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
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
Message-ID: <aimy3BxBaXQ3Uigd@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-15-clamor95@gmail.com>
 <aihoH9Pmzufa9pnE@ashevche-desk.local>
 <CAPVz0n0m+i7wexfC0BWwvdOuJxDk_=x+EpxEbNmoHN1AsEmfNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0m+i7wexfC0BWwvdOuJxDk_=x+EpxEbNmoHN1AsEmfNg@mail.gmail.com>
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

On Wed, Jun 10, 2026 at 05:45:28PM +0300, Svyatoslav Ryhel wrote:
> вт, 9 черв. 2026 р. о 22:23 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > > defined in the device tree.

...

> > > +     int ret, i;
> >
> > No need to add 'i'.
> 
> This is personal preference as well. There is no strict rule that
> iteration variable must be defined strictly in the for loop.

This is a preference by Linus who is the leader of the project.
Also in IIO we have some set of maintainer preferences.

> > > +             for (i = 0; i < led->num_leds; i++) {
> >
> >                 for (unsigned int i = 0; i < led->num_leds; i++) {
> >
> > > +                     if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
> > > +                             continue;
> > > +
> > > +                     output_cfg_shift = led->leds[i] * 2;
> > > +                     output_cfg_val |= led->id << output_cfg_shift;
> > > +                     output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
> > > +             }

-- 
With Best Regards,
Andy Shevchenko


