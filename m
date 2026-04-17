Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032DAF43691
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B01E10EA01;
	Fri, 17 Apr 2026 11:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BdtM41Zc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B4B10EA01
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776424832; x=1807960832;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZJ/IkHzAzvd9vULVzY+BMeJBCQ616LS8tQLsbyyNNFM=;
 b=BdtM41ZcozJHQUpdYh1lU9H2hYdOyRYYOfbY+DxmWJMpyGHZ1Zn5ka7U
 InAB/y4W+xWqq7KwtO5wzO86H9sNMnEHe0SHtiTwbkeSPhJnynmhK50i6
 MMurnAMu9HGWw6LR3PhiSDK9xnupmTX9rsW4mYUnQbbpiKz+yA2JkVRE1
 rk7dcu3pbd345kfIU3WhT/A5aNEW3pytYwNx/uE4+fQ+5J6bedvdcy+Z2
 cXClE2lX1A2Y/rY8fDmAPhn6zsFHCXdTOXLSecQwcoyuz6T5u/YDI97fD
 pF0/EbY0+ddRI7qs5A/6nHvERhm3EUxtwEQ107F+KrvKGGXbz1JXjjdXf g==;
X-CSE-ConnectionGUID: cFf/3H5jSCu/nQykm9lsdA==
X-CSE-MsgGUID: ao37Mhx2Qi2oId8/V6Kgew==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77512119"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77512119"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:20:32 -0700
X-CSE-ConnectionGUID: ov5K17c3SU6ti8os0AnsgA==
X-CSE-MsgGUID: YPpPWat4QSurhH6SDlYWLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="229997857"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.78])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:20:31 -0700
Date: Fri, 17 Apr 2026 14:20:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prasaanth <prasaanth2k@gmail.com>
Cc: linux-staging@lists.linux.dev, andy@kernel.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: fix alignment in write_reg
 call
Message-ID: <aeIXfMcia6e8cQvy@ashevche-desk.local>
References: <20260417101457.7599-1-prasaanth2k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417101457.7599-1-prasaanth2k@gmail.com>
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

On Fri, Apr 17, 2026 at 03:44:57PM +0530, Prasaanth wrote:
> Fix alignment of multiline arguments in write_reg() call to
> match kernel coding style
> 
> Reported by checkpatch.pl

NAK. Use a common sense.

-- 
With Best Regards,
Andy Shevchenko


