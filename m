Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFA606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nJaZNf5L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E7010E062;
	Sun, 25 Oct 2026 15:01:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5872A10E214
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792940496; x=1824476496;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L3ipZTsNucMPzNkW+kxXI9G3iUL6JjrKCA2IMBnMnBo=;
 b=nJaZNf5L/rYoCssx9wNz2/xvR4nyix5cog2qweK5jFqDMsQiepwEWdLu
 c5wuHliK/bbNdOSyciMQnWoBEWnjaO+rZVa8jLLnnQw8IoaFl4OPxvAP5
 oSBV2DVMbb8p0k3qj8P5D9IsjXA3gxY7J+nNd2q2oJFd3BmvLEMhv0yJ+
 hKAzHip4PRODg8Uk7u8ikWuIjm02oE26gE7588Nnz0eAY3RN3jqA0JnGU
 F3Qjyl/UXl3Izl7+l7Qyrz7RIaaTYYZluNRLp8DoBLGT9dRiTgDJfgGeD
 SD6Npq/F2v98aUevdSK07kY+Z26FY0HroHdy1Xqxu4r/lCZJ+hx+Xe9LJ g==;
X-CSE-ConnectionGUID: eiAdE4siQ1a+fUh4MMZg0Q==
X-CSE-MsgGUID: T0YXRfiIROC38b4cQmDvkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1629434"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1629434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 08:01:35 -0700
X-CSE-ConnectionGUID: IJ5YdLbERyyITfSahx/fEQ==
X-CSE-MsgGUID: jbpnSTeYSNOhBbOZEZN2nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4097073"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.10])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 08:01:33 -0700
Date: Sun, 25 Oct 2026 17:01:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Fix line length warning
Message-ID: <at4Zyt9QP3Yo-ZTC@ashevche-desk.local>
References: <20261024180803.108872-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024180803.108872-1-himanshu.bakshi478@gmail.com>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 11:38:03PM +0530, himanshu bakshi wrote:
> 
> Split the line in fbtft_init_dbg macro to keep it within the limit of 100
> columns and address the check-patch warning.

checkpatch
(in one word)

...

>  #define fbtft_init_dbg(dev, format, arg...)                  \
>  do {                                                         \
>  	if (unlikely((dev)->platform_data &&                 \
> -	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> +	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
> +	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
>  		dev_info(dev, format, ##arg);                \
>  } while (0)

First of all, make sure that \ (backslashes) occupy the same column on each
line of this macro. Next one, it's better to add a temporary variable to
hold the platform data pointer. Something like

	struct fbtft_platform_data *__pd = dev_get_platdata(dev);	    \
									    \
	if (unlikely(pd && pd->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS) \
		dev_info(dev, format, ##arg);				    \

And last, but not least, have you checked with `git grep` how it's being used?

-- 
With Best Regards,
Andy Shevchenko


