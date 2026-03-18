Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE62FCD0CA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E82810E6AA;
	Wed, 18 Mar 2026 07:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wbk/Qgfn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73EB10E6AA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773819907; x=1805355907;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jWgGMifsQ3freusuV/ahi2DVbgp0kEG51OyaqwJEvEQ=;
 b=Wbk/QgfnawEFf5FalJmWBmk9CuBdqWEXvA5MJTUwG0ANgWHy5E5LoUwC
 N2wN397GiFIa+mkqUqKPPeuf32io5HI4oIBJCNf3aCQIZBmgL6CNRNaJ2
 WuFEa7TZPHASqxboiy0FDWei/xdZk0iEdSBnQRtgJ/fBYWZRRy9gSA57s
 13VKa2gVjR+cVLD6E2VaYdIk/Rm32p0cOPGKfLc5wsqNanXUafdfGSRP3
 vXa7NgFlNj9SHXvY61U1y0QR0QQ5NwNBqq8LJVv0TmQ15TR0rIj6N1Qsy
 4QKHzoLdZqozjIkqBQQJtP5vsbfjhPT+q4HFsRIITsPhTNR4V3sEWzgvc g==;
X-CSE-ConnectionGUID: oqnksr0FQ8Osl6fQS4E+MQ==
X-CSE-MsgGUID: EeucmaHbQ5ScHmFO222jpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74987432"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74987432"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 00:45:06 -0700
X-CSE-ConnectionGUID: PvuGLc/2RRW7odVzQF1kVg==
X-CSE-MsgGUID: AXA2HqpoR4i6DTZrKlf0Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="222514288"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2026 00:45:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id A69FC98; Wed, 18 Mar 2026 08:45:03 +0100 (CET)
Date: Wed, 18 Mar 2026 08:45:03 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc: Jason Yan <yanaijie@huawei.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
Message-ID: <abpX_2PUWie03GdG@black.igk.intel.com>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200408101852.GC20795@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Wed, Apr 08, 2020 at 10:18:52AM +0000, Sam Ravnborg wrote:
> On Fri, Apr 03, 2020 at 10:16:09AM +0800, Jason Yan wrote:
> > Fix the following gcc warning:
> > 
> > drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
> > ‘pixel_vco’ set but not used [-Wunused-but-set-variable]
> >   unsigned int pixel_vco;
> >                ^~~~~~~~~
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> Thanks, committed and pushed to drm-misc-next.
> The fix will show up in upstream kernel at the next
> merge window.

The most of the patches from so called Hulk Robot appeared to be controversial.

First of all, even so called "dead code" may have side effects on the registers
in HW which may lead to other issues. Second, the mentioned dead code elimination
patch doesn't improve anything as now the dead code is 'mnp' variable (that's how
I got into that, I still have a build error).

That said, for the starter I suggest to revert this change. After one need go
carefully through code to understand if it's exactly the case and what to do with
'mnp' which involves some IO.

+Cc: current fbdev maintainers

-- 
With Best Regards,
Andy Shevchenko


