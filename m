Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF97CCD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEF010E5D5;
	Tue,  9 Jun 2026 19:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UbF7LTy8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACFA10E5D5
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781032448; x=1812568448;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kHAFo30QUtXvLKXA/8ylRwSsXrZr+2hcR1czMiLOh1Y=;
 b=UbF7LTy8m7WW/LvlhvAXZ9AObY8JTPfJ+Xvn8ky4LbJtZJRlHVnQt5A0
 QM1mlXA85wc0O6hnbyvN0m54SaHhZmapG8l9zs08aSjVaHbRcKLtZA9yR
 xM94TT8dKVnRsK1tPAnSkhXq5wAmNqKDoSzfJp2sNVs1cmTFczh8op4gz
 30f9DxrKHUxBbnNzeA0yjh118XaazogzEuGB1jqLYfqZllP1J6hJfu8pf
 f3S06tnipflz/PySyX/cs24ZHQEM0t0jDQurd5YpzDhJ6ZkuKJFVg5Ima
 reLl9IdMd0oAEMwpe+8SLI21mUPJPtfoqUlke2rJ0sVFnef+O/kG+6q0M Q==;
X-CSE-ConnectionGUID: mb335uRDSemozUE4Gsp3/w==
X-CSE-MsgGUID: n3fbV75iRVO8ldx/5MpFDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81554901"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81554901"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:14:06 -0700
X-CSE-ConnectionGUID: X0qVWR8NQgqGxTo5R+G26A==
X-CSE-MsgGUID: drwEeY1KSoSQ1tXR0KjPlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="243485062"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.162])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:14:02 -0700
Date: Tue, 9 Jun 2026 22:13:59 +0300
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
Message-ID: <aihl9yIqN3adKWLr@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-8-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-8-clamor95@gmail.com>
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

On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> Switch from sysfs_create_group() to device_add_group() including device
> managed where appropriate.

This should use .dev_groups member of struct device_driver.

...

> +	ret = devm_device_add_group(&bd->dev, &lm3533_bl_attribute_group);

This will make Greg KH very grumpy. (For the record, original code as well
but it already is in upstream. So, thanks for trying to address this, just
needs a bit more of work.)

> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to create sysfs attributes\n");

-- 
With Best Regards,
Andy Shevchenko


