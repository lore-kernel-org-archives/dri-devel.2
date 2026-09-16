Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C737BC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265B010E45D;
	Wed, 16 Sep 2026 11:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aJn4ZUtA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D7310E33C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789556765; x=1821092765;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HzRpDUemKObzUrc8XbP7CS1ebBC8gLFixWIizYLS1YQ=;
 b=aJn4ZUtAG4ws9fKk1mLb+oAb/QFYzcgdNnuu4Aa+KxZxgTvgYZ4sGgWi
 k9Y+1eRlyS+JaI6CtnbUOAY8B9SHFmmySBQuRabiuZfdoZ+JSAxnG+9hw
 hbTROmxwjDYqwYYmc+740+w9PGcK1RQbfsOtGLiRoTEYJw4fhvSQK4M+t
 f5jlPgvSWj6DCnfIOQZVonJcBO2nAKqi/3WRUZtdk6dBwUX1tNrM7Jk73
 2M38H9qPOTTfqbdFcyR6/HnIfaDCgE78pNtCk2V3FSIwg+IAqNFpL9DDE
 SKYpA1Wd5QFXI2iirXT12Gd/8UWPCf3dED/JVSjttpnrVeEEFnYJGsTWZ g==;
X-CSE-ConnectionGUID: N7JPvpjZRHiVOeD7W7Ng8w==
X-CSE-MsgGUID: /qDkAGEYSp6Gbp07EuSSLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100255068"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100255068"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:06:04 -0700
X-CSE-ConnectionGUID: hL6MRQfjT8WMVh/W/Yapgw==
X-CSE-MsgGUID: 74I0UvttTXCxG+cNXNYKTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272832452"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.145])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:06:03 -0700
Date: Wed, 16 Sep 2026 14:06:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Omer PALA <palaomer100@gmail.com>, andy@kernel.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
Message-ID: <aqp4GA1q6cLKivZo@ashevche-desk.local>
References: <20260916093928.52057-1-palaomer100@gmail.com>
 <87ecet5xos.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecet5xos.fsf@yellow.woof>
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

On Wed, Sep 16, 2026 at 11:53:55AM +0200, Nam Cao wrote:
> Omer PALA <palaomer100@gmail.com> writes:

...

> Btw, I am curious why we have these udelay(). Can we remove them?

Once again remind people that FBTFT works for both busses: SPI and parallel,
the latter one is usually GPIO-based and quite slow (I have one of the panel in
this mode, it gives me ~2-3fps at best on a 10y.o. x86_64 embedded device).

Maybe that's the reason? In any case, I think the datasheet on the panel should
answer the question.

-- 
With Best Regards,
Andy Shevchenko


