Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE64CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEFF10E42F;
	Thu, 30 Apr 2026 11:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GkgQDX5F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A8210E157
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777549612; x=1809085612;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NTVYcIL/w1sQtMNYrrV2a74rDO7vqtiEkVH+wPMfvTU=;
 b=GkgQDX5FyqeaIUw6n0fElb1K603ZxeY0Ee6QtwoNvRGvXhzvna84X2eq
 /YbysRBBDeCwz8ewt3KwCFPGE/JFU8fpTPI37EX8Q+Ni5pXeLMKUax3N9
 +ogVD8eqm2/6KZxXFxCtK6jLxwW88MmoyshNR2mPwM4/caVYJgCDBMMra
 2rYL1sY6AnoOrnZX44FOkroGp6eMDtBHH0RJWRIkeJKSR+z8UQX1WaUVj
 0he2c625a/xTMoB/HY3OShSIHdL1pAgapVFwJcUsIyQJscYmUpnMFAjJs
 tjH+5/62TrcjzssN71vA2PldMOf+N6DaEafSORAQddZTIts3zXLwEXozQ A==;
X-CSE-ConnectionGUID: PZbCPOHhQOWs4Qve7qigCQ==
X-CSE-MsgGUID: lOyg9FBTSnOQfkJct7ZtpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78551263"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78551263"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:46:51 -0700
X-CSE-ConnectionGUID: n+8JpiroRtmzz5dfjEWvDA==
X-CSE-MsgGUID: Mm9UkdVtTMW6BwhpoFRylQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="231916923"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:46:48 -0700
Date: Thu, 30 Apr 2026 14:46:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: remove unused function
 fbtft_write_gpio16_wr_latched
Message-ID: <afNBJZOZSova0p22@ashevche-desk.local>
References: <20260430102529.25019-1-dennylin0707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430102529.25019-1-dennylin0707@gmail.com>
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

On Thu, Apr 30, 2026 at 10:25:29AM +0000, Hungyu Lin wrote:
> The function fbtft_write_gpio16_wr_latched is not referenced anywhere

fbtft_write_gpio16_wr_latched()

> in the driver and only contains a stub implementation.
> 
> Remove it from the driver.

Agree, pure code removal is always welcome.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


