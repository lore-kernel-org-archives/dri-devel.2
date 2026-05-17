Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914CACD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 10:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D1010E1B3;
	Sun, 17 May 2026 10:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oCnt/T1h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1625410E1B3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779014429; x=1810550429;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3+pu7n1CG+XGB3Ldn4JBhKXZKe50YpSBlqvjDoYq7e4=;
 b=oCnt/T1hrNEJC7ZFmXgtq96bERBAv0NCNjyDHCiXlkBJ99nze3/XJ0yT
 C7ZJIjYlFmGBI3P6Og2bxDFREzoVfnJu1eChHDZE9+H1GBgSc5kh53vXr
 8Dd6sNNnZp0De5DCjNFuTM5Z46qEmA2AjW+b4m4lowTKbMVD+TVb3upTj
 j5EDFpol0p/udo08kZkP5iQk76NtunQVwMPlo6KasFiJ40O/6GLT9goWC
 caGy/OcVen2FGhjROf71GhJsE6IxTPr8g+KFk2oCAi1t7dh+fZhFrctD7
 7Wap0sP/dG6C78XkT4kS1iZnAUpfBlUAmP9UhoXoOK7A1uw/iyYBuawDk g==;
X-CSE-ConnectionGUID: N4n/w2q3RS2vx5d/DBIyfw==
X-CSE-MsgGUID: 88+tP3WvQ+Sx0lqRle62FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79864306"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="79864306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 03:40:28 -0700
X-CSE-ConnectionGUID: 0/XQ2Nl4Q3apw4ZJiajANw==
X-CSE-MsgGUID: qo1alMKuTvC8X7PvF427pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="262908978"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.182])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 03:40:23 -0700
Date: Sun, 17 May 2026 13:40:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve
 support
Message-ID: <agmbFQHezUl5Nydn@ashevche-desk.local>
References: <20260517074306.30937-1-clamor95@gmail.com>
 <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
 <agmWVdi3TkBb2cxV@ashevche-desk.local>
 <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3Kn5VVxWxCgq2EcRiOaLWnB85hD+-S2Eou=H1PyycJCQ@mail.gmail.com>
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

On Sun, May 17, 2026 at 01:34:32PM +0300, Svyatoslav Ryhel wrote:
> нд, 17 трав. 2026 р. о 13:20 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> > > нд, 17 трав. 2026 р. о 10:59 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > > > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > > > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > > > > setting mapping mode and LED sources based on device tree.
> > > >
> > > > How is this being different to
> > > > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.com/
> > > > ?
> > >
> > > I have decided to have a fresh look, this is continuation.
> >
> > Then it should be something like v4?
> 
> That was more than a year ago, lets start fresh. Those patches are
> gone, though I did add many of suggestions from there.
> 
> > > > What about this comment
> > > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> > > > ? Have you talked to Bjorn A and Johan?
> > >
> > > No, but since grep -r "lm3533_platform_data" * gives 0 results there
> > > are no platform_data users of lm3533.
> >
> > Johan was against driver removal (while it sounds logical due to above) and
> > referred to some other patches from somebody else. I think you need to
> > synchronise with the people to have a clear roadmap that all stakeholders
> > are agree with. With that, the split and other technical issues can be solved
> > during the normal process.
> 
> And this discussion was 2 years ago, and
> 
> "This device is used in a bunch of Sony phones and Bjorn A posted a
> series adding devicetree bindings a few years ago"
> 
> They have had more than enough time, don't you think? You would
> definitely know if there were any activity since you are IIO reviewer
> and would be included, were there any activity?

At least it's polite to Cc them your version.

-- 
With Best Regards,
Andy Shevchenko


