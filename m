Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5006D107526F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D2010E8B9;
	Thu, 19 Mar 2026 07:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="crNIu7fA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B080510E8B9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773905914; x=1805441914;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=dPpdN8u+SML07SnvGR2+AIbmK6kEI0YZuMKYIxaP3i4=;
 b=crNIu7fAG+gtFgbaCNy5+uzB1WGg8yux7fnv9nJk4bbL0lHxloPcF3mR
 rah2GCpNbJQE28rLV88H5cLsqsK/yeNZH28DHPXPF4yyASXFBp2fVwXSu
 sJg7XFKBsZcFe2V8swkAtk5xKA4wLWV2mobF4HLhpKihlpBw1IijJQ/7d
 9oAayGPxPriaL78Fwb4OiAtRMQnKuJTtm5AkSG2OdQsMJCYjNt81c+fr9
 juubtt40OaRsvwSL9uWX1JJvlOrNBrKSCGkgtTVE7RgT52ZlF52Opm17C
 6NaQKW/lNGz+4Hq1tf7Wds/SOSuznXkGgA6HoxsUWlPid2tniuBw8Mwns w==;
X-CSE-ConnectionGUID: D+q5t+6wTIK2PaNhX78KyQ==
X-CSE-MsgGUID: dnFQ6DjSSCKFWSSWudNF4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74668597"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="74668597"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 00:38:34 -0700
X-CSE-ConnectionGUID: DzveBHIDRf277YVAG8uwrw==
X-CSE-MsgGUID: pDGffJpHTOCIIcN85P2ANg==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.120])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 00:38:31 -0700
Date: Thu, 19 Mar 2026 09:38:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jason Yan <yanaijie@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 b.zolnierkie@samsung.com
Subject: Re: [PATCH] video: fbdev: matroxfb: remove dead code and set but not
 used variable
Message-ID: <abun9dwCYAWd1nIB@ashevche-desk.local>
References: <20200403021609.20968-1-yanaijie@huawei.com>
 <20200408101852.GC20795@ravnborg.org>
 <abpX_2PUWie03GdG@black.igk.intel.com>
 <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17605e19-065c-4b71-abb2-a9c9a7b9ddc6@huawei.com>
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

On Thu, Mar 19, 2026 at 10:22:08AM +0800, Jason Yan wrote:
> 在 2026/3/18 15:45, Andy Shevchenko 写道:
> > On Wed, Apr 08, 2020 at 10:18:52AM +0000, Sam Ravnborg wrote:
> > > On Fri, Apr 03, 2020 at 10:16:09AM +0800, Jason Yan wrote:
> > > > Fix the following gcc warning:
> > > > 
> > > > drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
> > > > ‘pixel_vco’ set but not used [-Wunused-but-set-variable]
> > > >    unsigned int pixel_vco;
> > > >                 ^~~~~~~~~
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > > 
> > > Thanks, committed and pushed to drm-misc-next.
> > > The fix will show up in upstream kernel at the next
> > > merge window.
> > 
> > The most of the patches from so called Hulk Robot appeared to be controversial.
> > 
> > First of all, even so called "dead code" may have side effects on the registers
> > in HW which may lead to other issues. Second, the mentioned dead code elimination
> > patch doesn't improve anything as now the dead code is 'mnp' variable (that's how
> > I got into that, I still have a build error).
> 
> Sorry, I do not understand what side effects this may cause. Would you
> please explain it in detail?

Any IO (and specifically on PCI bus) may have side effects. If the removed code
did some HW accesses (especially reads), it affects the state of HW. You can
read more about PCI bus and what read from it does.

Helge, can we revert this change and start over, please? (I can also send
revert if you think it's a better way)

I do not believe this change was ever tested on real HW, and I see an evidence
that this most likely was blindly made as it led to the similar issue after
the change.

> > That said, for the starter I suggest to revert this change. After one need go
> > carefully through code to understand if it's exactly the case and what to do with
> > 'mnp' which involves some IO.
> > 
> > +Cc: current fbdev maintainers

-- 
With Best Regards,
Andy Shevchenko


