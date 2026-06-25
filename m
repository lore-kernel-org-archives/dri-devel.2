Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A25DCDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47A610F2CC;
	Thu, 25 Jun 2026 14:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d3qQK7m5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3153610F2CC
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396497; x=1813932497;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=G4bOlvhhdVwBaq8kCvvh+9q6vDkJkXVzE3VkYXm/UN0=;
 b=d3qQK7m5HkPq7LmbK2cF3gLuj47S1TUrLY8eglMaD8jSjtVbSrJfExVa
 7fZdwvfnae93mdqSGs/oJyCjkWaHPwIZ2uybRGEist3cfJKOgEsDrtVhT
 x1M63/NLba0bGJF5Ss9NZtMarsnc3w1l6wHq1UfFM6LBrfhcKr9tCe/DY
 5Z3310+VUGxHOei38g3qXu/Kp7sn3iDeH6wO3oMbdanbld1qxTirxCHbU
 wrZtk7zVeRXtPEAmk1ibIgup/uxA/AMOUkhkq+LU/OuNmnMaX4tv5TeRL
 ZVaH/GhvsZbzb+V97vUaHKfCFFyW9k0ToSa2hiMMROzCkjix57C2YTioo Q==;
X-CSE-ConnectionGUID: IhLGIgnNSWqr26p7bD7KlQ==
X-CSE-MsgGUID: 1XQ4II+sQhikoX2w5lP+XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94569711"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="94569711"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:08:16 -0700
X-CSE-ConnectionGUID: O6ZI7uD3TeG2GgYuKgT3ZQ==
X-CSE-MsgGUID: shf94d8NTFWU0aUritrzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="244368609"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:08:15 -0700
Date: Thu, 25 Jun 2026 17:08:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and buffer size
 when startbyte is used
Message-ID: <aj02TPm9nawLC18g@ashevche-desk.local>
References: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
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

On Thu, Jun 25, 2026 at 06:30:41PM +0800, suryasaimadhu wrote:
> When par->startbyte is non-zero, buf is advanced by one byte creating
> an unaligned pointer for 16-bit types (u16, __be16). Dereferencing this
> unaligned pointer can cause a kernel panic on strict-alignment
> architectures.
> 
> Fix by using put_unaligned() instead of direct pointer dereference.
> 
> Also fix incorrect buffer size calculation in fbtft_write_buf_dc() call:
>   len * (sizeof(data_type) + offset)  /* wrong: multiplies offset by len */
>   len * sizeof(data_type) + offset    /* correct: one startbyte +
>                                          len items */

Same comments as per your other patch contributions. Make it cleaner next time.
So it seem a v2 should be a mini-series with fixes for different
issues/drivers/et cetera.

-- 
With Best Regards,
Andy Shevchenko


