Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2759CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48CC10F98C;
	Wed,  3 Jun 2026 07:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YUHtBAje";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EE510F98C
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 07:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780472958; x=1812008958;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YJk+GNWjFh/CK4jio5r8wPylzH3wGu9XWpulsn/tGw0=;
 b=YUHtBAjeoJ0ubyHwg2X1iWNF1oS68CcPkidsPuJi3Lu3hiJT//b2IKBI
 UDqtuiUYIJSjTmKEjR+lja3h/KsF90yBOGsTxvpMrsyS7P26hj+pekrXr
 pHr/hkXzgWfKLcBmiy9do5EG/xJ3ld7z7naa146WOsGFISwgFePxA2yJf
 0oc41WwdlIyefGXzPbZIpgYu3ATigq/99e6bUYknS7kBEd9swVf1muytw
 oAadcLX744N6xKAlUB8lhVOyJmRNEnN8jW+mKPOpGligoYF0RzUOc372E
 /+bH6sdRXGTaAnL4hW5wgKEoOTRaEn/cFmQauXlxIHr/pcfkDZbusXHXc g==;
X-CSE-ConnectionGUID: 2Cl7dF5/QAScMs0fP1AEDQ==
X-CSE-MsgGUID: gF6x1O65SUOiIJIJg4+cIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81268658"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="81268658"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 00:49:17 -0700
X-CSE-ConnectionGUID: PCLuX4qET0+zXvW9H90qYQ==
X-CSE-MsgGUID: Gl7WtXZgSPOGLNVeHVWrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="237790888"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.116])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 00:49:13 -0700
Date: Wed, 3 Jun 2026 10:49:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Chintan Patel <chintanlike@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use sysfs_emit_at() to print to sysfs file
Message-ID: <ah_cd9Ax4fzOhBp7@ashevche-desk.local>
References: <ah_Y_Y2RtqeGxchF@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_Y_Y2RtqeGxchF@stanley.mountain>
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

On Wed, Jun 03, 2026 at 10:34:21AM +0300, Dan Carpenter wrote:
> This scnprintf() uses the wrong limit.  It should be "PAGE_SIZE - len"
> instead of just PAGE_SIZE.  We're not going to hit the limit in real
> life since we are printing at most FBTFT_GAMMA_MAX_VALUES_TOTAL (128)
> u32 values, however, it's still worth fixing.
> 
> Use sysfs_emit_at() to fix this since this is a sysfs file.

OK,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	for (i = 0; i < par->gamma.num_curves; i++) {
>  		for (j = 0; j < par->gamma.num_values; j++)
> -			len += scnprintf(&buf[len], PAGE_SIZE,
> +			len += sysfs_emit_at(buf, len,
>  			     "%04x ", curves[i * par->gamma.num_values + j]);

Can we switch to use hex_dump_to_buffer() at some point?

-- 
With Best Regards,
Andy Shevchenko


