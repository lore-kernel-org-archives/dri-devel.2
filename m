Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6193F1075280
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C607D10E933;
	Thu, 19 Mar 2026 09:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MStv9cT2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD4810E933
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773911313; x=1805447313;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZRcVOhPdowDvzKLSuXQMCOObGmNVbYTZjhSNJcyjj9I=;
 b=MStv9cT21XXLVoEKeGMT4nu7aB7m4JcP+A6dEop6GOIBNp3ef4WemeCl
 kEdHnWfivgfRSYTee1gI7SKohWFvhZQSl9aKiezuAPDyjOopE8/Hxp5r3
 Jv7ytT/YkTUz+cOgydHuQ331pmih5QWjcxcnza8XQ19Vg+HSIrQiugX4v
 5n4IuSEaGHc6tyNvIdqoXO2XbiczIJACF7uhShY84SnVz+YjSM7gimqUf
 VcR9QZeiQtvtZpaYDUx0nDNnqE1RpssqG5lpcf2VXs2vh2we0RGulSvKn
 PEN4XesoQkF26CtLaioxzPB3USvxIoYEa7TWiiEMajB1GnfZLqcHclpC+ w==;
X-CSE-ConnectionGUID: JFDrQZ+3Qx+UVplt4StzjA==
X-CSE-MsgGUID: X2bpPDiVQ9mx/wNbnLA7FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85605750"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85605750"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 02:08:32 -0700
X-CSE-ConnectionGUID: /HYQIwtlSlGVn7EFhK3P+w==
X-CSE-MsgGUID: xLwpsofwQ36F7lTP//oKmw==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.120])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 02:08:31 -0700
Date: Thu, 19 Mar 2026 11:08:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Helge Deller <deller@gmx.de>
Cc: Jason Yan <yanaijie@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 b.zolnierkie@samsung.com
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
Message-ID: <abu9DKMN660yd3Sd@ashevche-desk.local>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org>
 <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
 <abun9dwCYAWd1nIB@ashevche-desk.local>
 <e5f7611f-f087-4835-99e3-4fddc927aab8@huawei.com>
 <abuyJDK6E2aHA4rC@ashevche-desk.local>
 <c717b7b6-ffb6-47f9-b345-de0eddcfe7a4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c717b7b6-ffb6-47f9-b345-de0eddcfe7a4@gmx.de>
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

On Thu, Mar 19, 2026 at 09:35:33AM +0100, Helge Deller wrote:
> On 3/19/26 09:21, Andy Shevchenko wrote:
> > On Thu, Mar 19, 2026 at 04:06:44PM +0800, Jason Yan wrote:
> > > 在 2026/3/19 15:38, Andy Shevchenko 写道:
> > > > On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:

...

> > > > Helge, can we revert this change and start over, please? (I can also send
> > > > revert if you think it's a better way)
> 
> Andy, all points you make against removing relevant code is absolutely right.
> 
> But for this specific commit 7b987887f97b ("video: fbdev: matroxfb: remove dead code and
> set but not used variable") I have to agree with Jason, that the patch is ok.
> I don't see any build errors either.

Just run on today's Linux Next (since the driver has not been changed in that
sense for a few years, the very same issue is present for a long time):

drivers/video/fbdev/matrox/g450_pll.c:412:18: error: variable 'mnp' set but not used [-Werror,-Wunused-but-set-variable]
  412 |                                 unsigned int mnp;
      |                                              ^
1 error generated.

> Are we mixing up things here maybe?

...

FWIW, I dove to the history of the driver.

So, the code, that was guarded by #if 0 was introduced in the original commit
213d22146d1f ("[PATCH] (1/3) matroxfb for 2.5.3"). And then guarded in the
commit 705e41f82988 ("matroxfb DVI updates: Handle DVI output on G450/G550.
Powerdown unused portions of G450/G550 DAC. Split G450/G550 DAC from older
DAC1064 handling. Modify PLL setting when both CRTCs use same pixel clocks.").

Even without that guard the modern compilers may see that the pixel_vco wasn't
ever used and seems a leftover after some debug or review made 25 years ago.

The g450_mnp2vco() doesn't have any IO and as Jason said doesn't seem to have
any side effects either than some unneeded CPU processing during runtime. I
agree that's unlikely that timeout (or heating up the CPU) has any effect on
the HW (GPU/display) functionality.

So, since the commit 7b987887f97b ("video: fbdev: matroxfb: remove dead code
and set but not used variable") the 'mnp' became unused, but eliminating that
code might have side-effects. The question here is what should we do with mnp?
The easiest way out is just mark it with __maybe_unused which will shut the
compiler up and won't change any possible IO flow.

-- 
With Best Regards,
Andy Shevchenko


