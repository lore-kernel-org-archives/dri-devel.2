Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE3606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XBm88yId
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5290910ED0D;
	Mon, 26 Oct 2026 09:24:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1ED810ED0D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793006684; x=1824542684;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nLVdTbTG3BOOg0NKFoId7DXu+3MHSWUcFw4OvEb/0iI=;
 b=XBm88yIdd3Coz+Z9VFwoFdJBbIt1k2OQLfIRlT3w8jOic6jhIs/ANkix
 ChxO7XdH+rQKNhpTZPrVl3+HZgBk8bpSGf3zFyML9ZGu7YevcmhjMqbe8
 mR/nz5K7cpYPKpklWJBYBJPARTP0P9FT7M9sh+bsY6qT0HmYUli0VvdRy
 SGwr2CG4aYwx/b0lLPXAJrRNb5bC11Srf78P+9Rd/uLKW6hiTxfOTms38
 Qd150j74L0F4LvZ2x/fCxvctpNgMsBbtPuE+gNTlHr0TkmYT86TjS16F1
 /mvVPYO/Y2xH1J+wl8qd7PJsr16kG3u8S14jNFgTYKlubpBQEacZonV4o g==;
X-CSE-ConnectionGUID: a0Xtt4BxQguUZfilDb/gMw==
X-CSE-MsgGUID: cOGr6vrtTk++dwrmRW9u1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1567578"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1567578"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:24:44 -0700
X-CSE-ConnectionGUID: SWD2y8FzSO+MtT9Rg6GkFA==
X-CSE-MsgGUID: vPTCfpkGTMOKogBsIiegLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6044272"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:24:41 -0700
Date: Mon, 26 Oct 2026 11:24:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] staging: fbtft: Remove unused macro
Message-ID: <at8cV1asiwO1FtQA@ashevche-desk.local>
References: <20261026081832.60570-1-himanshu.bakshi478@gmail.com>
 <at8cAMm6psyWsqbe@ashevche-desk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at8cAMm6psyWsqbe@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:23:17AM +0200, Andy Shevchenko wrote:
> On Mon, Oct 26, 2026 at 01:48:32PM +0530, himanshu bakshi wrote:
> > 
> > fbtft_init_dbg is not used in drivers/staging/fbtft directory and
> 
> We refer to the functions and semantically similar macros as
> func() or macro() in the text and comments.
> 
> > since dev_dbg messages are good enough, fbtft_init_dbg should be
> 
> Ditto for both dev_dbg() and fbtft_init_dbg().
> 
> > removed. After compiling the driver, there are no undefined macro
> > issues.
> 
> > Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> > ---
> 
> It doesn't say how you tested this, though.

Ah, after reading Dan's email I noticed that the last sentence in the commit
message actually should be located here, in the comment block.

-- 
With Best Regards,
Andy Shevchenko


