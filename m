Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFE2CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F7610E235;
	Tue,  9 Jun 2026 19:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wxc6FhHu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950AC10E235
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781031997; x=1812567997;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZzI9gm2rnwVsOuZIILAhH/PEbhSZzbC826SvMBF3MYc=;
 b=Wxc6FhHuLfy7cJ6zcidp+Ta6T84pV3YEUD1QRvrNaPWse0QYgyk4M5Ey
 +oAHN2hlYM7PFkunA2mNu8cOtqdaaNCtI4rdvanL+Bmv6loExfjdMMfra
 XjuB1NWRng+5T43/z1vvRsNJu1v67imPXgwbh95cicQkhGBguULzs8wIw
 tgWlxwysBAmFNya51etBHfjYbyLiKAuWi+URKi4XXsjWr76LHoruTGZpg
 ciaRpSfwDGS+0o9EH6kiMIpddzOxpp2NMDZGJ4S7M1by4x/3gpVgyWXDx
 tVuJQiRALjrx2QAwVYislARNyuPxjDVfuoLxlG0x63ZnDgwik+KPj+8LF Q==;
X-CSE-ConnectionGUID: mcCt2YIaQheBQeNb0nGaCg==
X-CSE-MsgGUID: y5snTx11R1S2bU/eo1zvAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85655597"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="85655597"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:06:36 -0700
X-CSE-ConnectionGUID: 2hlOv1h7SOiWJTRk+l/wxg==
X-CSE-MsgGUID: LuhpETyxQC60gUwspMHaVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="241806001"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.162])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:06:31 -0700
Date: Tue, 9 Jun 2026 22:06:29 +0300
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
Subject: Re: [PATCH v4 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <aihkNekrgfu6-6Q_@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-5-clamor95@gmail.com>
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

On Sat, Jun 06, 2026 at 07:57:28AM +0300, Svyatoslav Ryhel wrote:
> Instead of passing the entire lm3533 core data structure, only pass the
> regmap and the light sensor presence flag to child devices.

...

>  struct lm3533_als {
> -	struct lm3533 *lm3533;
> +	struct regmap *regmap;
>  	struct platform_device *pdev;

And this pdev is probably not needed. But I haven't checked the whole lot of
the patches yet.

>  	unsigned long flags;

...

>  struct lm3533_ctrlbank {
> -	struct lm3533 *lm3533;
> +	struct regmap *regmap;
>  	struct device *dev;

Ditto. 

>  	int id;
>  };

-- 
With Best Regards,
Andy Shevchenko


