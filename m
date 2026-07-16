Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B66AC44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5F910E3AA;
	Thu, 16 Jul 2026 18:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mJkPuEof";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB3A10E3AA
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784227049; x=1815763049;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Gp+OUefwokWpgHwdunzLQJOrzjxr3nWteQh1SnYFjOs=;
 b=mJkPuEofFfsm+D9IWB3jcSOKZCtN2gSRGEDHQ8OrFGtnUhJfSxQfyNdn
 eDR15A+qb+45aUrk+FY9ApNpsTTfMFuCf75Dr1BMI1B19Wwfvvmjy+rAy
 vtQ/chJe6PA5yypg1hcBmWVyHNMFdwI3uUSsWg6agtU5Ue+9k+vuZ8hOP
 nqscsqfzEZBf/nnyQwy1NMK6LHQ8o+D4xNMkeIsMyUd5y+IeGAnniWcBa
 OC3Y5FdNv88uVYUsDH4ENskP1EzhrOkTejj7EAqwS/rmneGiBsZfpKoAp
 yaz9sJ5o0ObsN31Kdquasf2UNFhkGRoF1mFdXKFg1dWveaotaTQBPq6FW g==;
X-CSE-ConnectionGUID: vspjUYsPS4udeLZiDNTDcQ==
X-CSE-MsgGUID: 3l6dQgNVS3Onqu3s6Rsv5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="72432333"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="72432333"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 11:37:29 -0700
X-CSE-ConnectionGUID: +TT9WKXMRIuIU+56AVkQqg==
X-CSE-MsgGUID: iYAGxyBWSnKSCN9dwhK/Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="294795210"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.26])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 11:37:28 -0700
Date: Thu, 16 Jul 2026 21:37:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mashikiselby@gmail.com
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
Message-ID: <alkk5CVmeEY6org0@ashevche-desk.local>
References: <20260716-staging-testing-v1-1-2ebc0c6bb27a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-staging-testing-v1-1-2ebc0c6bb27a@gmail.com>
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

On Thu, Jul 16, 2026 at 01:08:33PM +0200, Selby Mashiki via B4 Relay wrote:

> udelay() busy-waits for the specified duration, consuming CPU cycles
> unnecessarily. usleep_range() is preferred for delays that can sleep,
> as it allows the scheduler to run other tasks during the wait.
> 
> Replace two instances of udelay(100) with usleep_range(100, 200) to
> use the preferred sleeping delay function.

NAK. Read mailing list archives why.

-- 
With Best Regards,
Andy Shevchenko


