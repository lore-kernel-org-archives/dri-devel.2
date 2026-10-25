Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C8606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J5UxPb0b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37DBA10E094;
	Sun, 25 Oct 2026 21:02:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDC810E094
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 21:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792962142; x=1824498142;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=37MGO2THk65O9dDokHGzcZKqr//7mBwQ9K6mW3baZm0=;
 b=J5UxPb0bOFqmL0XhRfCwfZsip+8QAw9YrhJ8qXu1ps+0BO7TOjk18DEz
 xAT4TqN7De5t3iuydmM4Ch7TV6SCm7aRA+dDZ4lCkiFNo5KnhOZ+oWy81
 Y3+YSx2hiV9lemORPC+/rCtiJg9ttR91XHIgjQknVsCfCPYSTRObK/RF+
 VJHaVUqKsnwxUVk2gM1fUHou8Yu6jhSkmmNawxeYD0NUS5T81vUY7fwl7
 JKr9DBJXHwrwC7muWOIEOssD1j1uSyC7ngSuJnJZlXwsfDajThN/g9E9b
 iuE4THvuulCBz21BtDuUjDA0dKt8bEquSen+loG9CCSPOPUU4vnwXXjiR A==;
X-CSE-ConnectionGUID: oABnq4wGQriIsmKZj4VvIg==
X-CSE-MsgGUID: I1djTTi1RMaePc/iU2TYcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1528272"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1528272"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 14:02:21 -0700
X-CSE-ConnectionGUID: ToPmKdFtRiuRbKxXnKj03g==
X-CSE-MsgGUID: 0To/CPXJSHa4daZpMUiu4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4133394"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.10])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 14:02:18 -0700
Date: Sun, 25 Oct 2026 23:02:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
Message-ID: <at5uWNXO1pP3kAPD@ashevche-desk.local>
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
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

On Sun, Oct 25, 2026 at 10:10:03PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> Hi Andy,
> 
> I have made sure that the \ (backslash) is properly aligned to the same
> column as the rest of the macro. I have also taken into account your
> advice and hence added a local variable for platform data.
> 
> After some thorough searching through the respective directory, I have
> not found any calls for fbtft_init_dbg. This might be because it's a
> helper macro that might be useful as the driver progresses.
> 
> I have also noticed that some other macros around this one have simple
> style issues and if you would like, I can send another different patch
> cleaning up those too.
> 
> I have also done minimal testing by using the macro once to make sure it
> compiles and has no errors, if you would like, I can also run any
> standalone tests for this macro.
> 
> Thanks and Regards,
> 	Himanshu Bakshi

It's not a commit message. Please, make commit message be appropriate and
any comments like above is better to be sent in the reply of the previous
discussion (v1 round in this case, for instance).

> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

-- 
With Best Regards,
Andy Shevchenko


