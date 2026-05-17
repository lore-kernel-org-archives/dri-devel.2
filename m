Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0506CD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 10:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1349510E152;
	Sun, 17 May 2026 10:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SrMB4ckZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9200D10E152
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779013214; x=1810549214;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=oZxUQlyTk0p5nCvK12UZYWCNDBpHz3ibRGJ0b6zd/Es=;
 b=SrMB4ckZT2iUpj53RML+c6dMNRiqLM8IhoG6PAysZIG+NayuCQUZIiGa
 lM/2aaREv+0oNY+axnWelm5C1kFHJqG8gZTs75fWb3+UPck3Q2d8T07ha
 XM8rcTOeHZDtrdgICvDpd2qJxtZKgSn3qJLqciZBtsARLclmVsML7DgSw
 gD0dcZJcTV2YekbQLXCw8hNMDir128p7Q5UBuzCCH06dKYKK1u7CdjrnT
 StHcw/v5txCzFRnmeMRVUFU1pOaijEAqEzis3NtnsEVkBh61bPQ2V9WeC
 YrWSdwJkzh4HmB+F6yGiACMn31PnX9U+CQJWDM1GZ0xnPIkOpsT8ql+65 Q==;
X-CSE-ConnectionGUID: dvws2+3JTo6ZbvNiYKGMpQ==
X-CSE-MsgGUID: +eArox8gTHGI8agLG2+O+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79863936"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="79863936"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 03:20:13 -0700
X-CSE-ConnectionGUID: s1jh4tqGTcmsbArF7Y9qaA==
X-CSE-MsgGUID: Ym8Z6thTR1ql4o7Sr9BdaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="239013867"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.182])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 03:20:09 -0700
Date: Sun, 17 May 2026 13:20:05 +0300
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
Message-ID: <agmWVdi3TkBb2cxV@ashevche-desk.local>
References: <20260517074306.30937-1-clamor95@gmail.com>
 <agl1T8O6kwP7SFZ1@ashevche-desk.local>
 <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0tfbwa1AbgO4eKrmNunHvmTFLDqXDFd1=VfLayuafH8w@mail.gmail.com>
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

On Sun, May 17, 2026 at 01:13:22PM +0300, Svyatoslav Ryhel wrote:
> нд, 17 трав. 2026 р. о 10:59 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> > > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > > setting mapping mode and LED sources based on device tree.
> >
> > How is this being different to
> > https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.com/
> > ?
> 
> I have decided to have a fresh look, this is continuation.

Then it should be something like v4?

> > What about this comment
> > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> > ? Have you talked to Bjorn A and Johan?
> 
> No, but since grep -r "lm3533_platform_data" * gives 0 results there
> are no platform_data users of lm3533.

Johan was against driver removal (while it sounds logical due to above) and
referred to some other patches from somebody else. I think you need to
synchronise with the people to have a clear roadmap that all stakeholders
are agree with. With that, the split and other technical issues can be solved
during the normal process.

-- 
With Best Regards,
Andy Shevchenko


