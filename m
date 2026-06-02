Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50DFCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF6F10EF45;
	Tue,  2 Jun 2026 11:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GtqNmkKi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73E410EF45
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780398477; x=1811934477;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mFctebV6efZPkxdiXhNEx0eARojG2bev1G/ivejaxqo=;
 b=GtqNmkKiHYxgS/pR7eb2nzTkf5YsNS6sXIejUXeiRLOvAJhJX9qoAGpw
 ObOKfNRNVwJqjfv7gAACJWqLdTiPJ+4vULeju+46k6xXa1bU3wK0PfDMK
 Qy/TGUbdt4A+bp+5RuwT+iigjO1U4/1Xmx8gSvQ5JmjGPeSYsbVElDJWZ
 xJ49EIumUT+nAFLUsAuRNkPOY+LwaQUE/UfOnvZYgO1JiT9jPaG/kYeWg
 CeehIYAE8bx1qVCCKzs7g5wSh0/bqhgf3iWVoxdBO2j1dj8onSkmGzi4O
 N+ODTu142I61sKxhrfR6tJJ3TNKXJRtDaY8sc3TLhjXTRGN2T2eR5BRQL Q==;
X-CSE-ConnectionGUID: W89ZIV59Qo+WD7yZcyqTLQ==
X-CSE-MsgGUID: hf3XlP23RGOLLY8+WINKMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81207822"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="81207822"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 04:07:56 -0700
X-CSE-ConnectionGUID: lhiRJlaQQHmUbKHn1VV+4A==
X-CSE-MsgGUID: r7XmoXFkTjavabE0tmKG2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="243975444"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 04:07:52 -0700
Date: Tue, 2 Jun 2026 14:07:49 +0300
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
Subject: Re: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear
 sysfs logic
Message-ID: <ah65hfgoM67V6-iR@ashevche-desk.local>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-9-clamor95@gmail.com>
 <ah6PxFtoJUWkd79P@ashevche-desk.local>
 <CAPVz0n0P7Jk17cM2M1zuHZfySo2=Uibr5izwKU2tqiBpBcg0FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0P7Jk17cM2M1zuHZfySo2=Uibr5izwKU2tqiBpBcg0FQ@mail.gmail.com>
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

On Tue, Jun 02, 2026 at 01:19:00PM +0300, Svyatoslav Ryhel wrote:
> вт, 2 черв. 2026 р. о 11:09 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Mon, Jun 01, 2026 at 06:18:28PM +0300, Svyatoslav Ryhel wrote:

...

> > >       if (kstrtoul(buf, 0, &linear))
> > >               return -EINVAL;
> >
> > Besides _assign_bits() in the below, side note here to unshadow error codes:
> >
> >         ret = kstrtoul(buf, 0, &linear);
> >         if (ret)
> >                 return ret;
> >
> > (obviously in a separate change).
> 
> Won't happen in this patches.

You mean both suggestions or you are talking about kstrotoul() only? If it's
only about the latter, it's fine with me, but _assign_bits() makes sense to do
in this patch as you already change the parameters enough to make it better.

...

> > >       ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> > > -                              mask, val);
> > > +                              CTRLBANK_AB_BCONF_MODE(id),
> > > +                              linear ? CTRLBANK_AB_BCONF_MODE(id) : 0);
> > >       if (ret)
> > >               return ret;

^^^ left for the context.

-- 
With Best Regards,
Andy Shevchenko


