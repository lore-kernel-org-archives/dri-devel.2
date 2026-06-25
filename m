Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC12BCDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED1D10E228;
	Thu, 25 Jun 2026 14:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TNeglqTd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0352910E228
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396595; x=1813932595;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=c0Bmn6hGAyuAnYk1EnLNUGmPoh3wiWyFQ1JCR1xdNDM=;
 b=TNeglqTdTJbbhXlleiqx0UCu7VPf2DhTyRxjkpgcK8GgjRxlE+8WOBgZ
 UlAOX+ERFa0gkJ+ljgEv+HUOZIGpnqp6JKKag4j3G/vrkZDMWjdmsa6Lu
 Sz5DqzYCDrp5BQltjGEWOA25SKVwcOnxKEVsqT3lzVMDH/LSaMhxLWKhI
 pcTEutiDE5TIK13Br6cmWI+aOLFaVCswSuIqUKHS9z87Bi9RQBGwgh/0Q
 1mXwdb9jLVWWDf69FA7MHHUXjw6R/XNpcww/93Hf5m0QK4mSn0QXUH8+r
 KbOCm653RwN48NEq/1eSCPDpbpGSYZSZcckEr11O9HYnj4eHV5N/t971C g==;
X-CSE-ConnectionGUID: C0em/IOZRhWBS+8LJwTF+g==
X-CSE-MsgGUID: oYldQvnbROOM/dVCcvKdcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100597976"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="100597976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:09:54 -0700
X-CSE-ConnectionGUID: fJBYsruzT7O3YosKUuaS6w==
X-CSE-MsgGUID: DDU2IQeoRC2DL9WI0rmhJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="255652309"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:09:52 -0700
Date: Thu, 25 Jun 2026 17:09:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sai Madhu <suryasaimadhu369@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>, andy@kernel.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace empty modifier argument with
 no-op macro
Message-ID: <aj02rT4eRKRPhrNe@ashevche-desk.local>
References: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
 <aj0Cv0Wzb3rieNqW@stanley.mountain>
 <CAB0uMAeMOV4Xhq2cNVjxne89yqF8vdubM8-OpPYGK4f4yBLMNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0uMAeMOV4Xhq2cNVjxne89yqF8vdubM8-OpPYGK4f4yBLMNw@mail.gmail.com>
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

On Thu, Jun 25, 2026 at 04:00:24PM +0530, Sai Madhu wrote:

First of all, do not top-post!

> Thank you for the feedback. I understand and will drop this patch.
> 
> I have also noticed two pre-existing bugs in the same file
> (unaligned access and buffer size calculation when startbyte is used)
> and have sent a separate patch to fix those.

> On Thu, 25 Jun 2026 at 15:58, Dan Carpenter <error27@gmail.com> wrote:
> > On Thu, Jun 25, 2026 at 05:27:21PM +0800, suryasaimadhu wrote:

> > I don't hate this patch, but I think we've decided to leave this
> > as-is.

Yep. as Dan said,

-- 
With Best Regards,
Andy Shevchenko


