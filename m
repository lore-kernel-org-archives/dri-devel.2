Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5B7C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BC210E301;
	Wed, 16 Sep 2026 11:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GODMjDyG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9102F10E301
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789556623; x=1821092623;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IWnV54RNLS5F9xKNa2KWOePuLIifnOT2PSpdpWwTw/M=;
 b=GODMjDyGycuQ6I6mbWcPo7UM1BBeZ5hNLGdzXYm8TRlyJmG+IAJCWv6C
 2ha2168Tk1HIL9YWGcnFNcB608rsKEl0oJ1b1G50PFjZjxvYB5z4FTInx
 ivjjPlsnS+IUbWlqnebcqwpksmlTYEr9hLNigdc7AIh3FR+F2d85J67lY
 JRd4LStAKftcMp213VNK6hLi4SOfujlN3xIlTzN2ouZWnIOEceBH4bGMM
 qkJ9AQBdlIreL3GW/UpEQgs396FGhKv/rm2JEsxHv41K6K8MjKAUoHU8X
 6c3IGrPWBTctFsw3YvW3jF/tyYNE79nqZKq9AQLPwTbTxdAmTistEuLtW Q==;
X-CSE-ConnectionGUID: S02L3V7YRRaUksGGY3WK0A==
X-CSE-MsgGUID: Dt0BzFnaSZCyzXg4KFE4ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="438862"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="438862"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:03:43 -0700
X-CSE-ConnectionGUID: sp8bFXe2Qju9twLMm3wY3g==
X-CSE-MsgGUID: OMGnJVYkR/ijCWfmFIVi5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1531519"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.145])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:03:41 -0700
Date: Wed, 16 Sep 2026 14:03:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Omer PALA <palaomer100@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
Message-ID: <aqp3ihtGN5-J9TPa@ashevche-desk.local>
References: <20260916093928.52057-1-palaomer100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916093928.52057-1-palaomer100@gmail.com>
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

On Wed, Sep 16, 2026 at 12:39:28PM +0300, Omer PALA wrote:
> Replace udelay() calls with usleep_range()
> to avoid busy-waiting and allow the
> scheduler to sleep during delays.

First of all, too condensed commit message. We have as twice room on each line.
Second, do you understand the difference on what code is doing before and after
your change?

...

Please, instead of posting patches, read first, check email archives, understand
the code...

-- 
With Best Regards,
Andy Shevchenko


