Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B01FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4302B10EE71;
	Wed, 29 Apr 2026 06:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fx7ihXJ8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D6210EE6D;
 Wed, 29 Apr 2026 06:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777443278; x=1808979278;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=u19cZe4uphaObeNRajl6+3fQGSo6ktKhIWkAlKGwXG8=;
 b=Fx7ihXJ8gc41sf3+OqQmCHadNqxzYsikEuz0wiTbUbyX96JthGgd5NRJ
 PEtfZd6I5KzYcJTfpCbgf8fAY2ywB4Lkg5goPYRuHsWvp8YdR8UeoG/Lm
 AGVDlk67Q86W69ZZkkKO4a95O3PltLT50xl8X+l8Dpd2kpH9/a1mfnHra
 7qVmXJfFAWxEc3MzDoIdaWKJFnRzaaFL6AIznp5aRHEqtigUfQEcxALoi
 VSyBeaVHBDD9Go3qOcbJhc9dOIYrPthfMLdVfgYkZAF31QHNqphO6GbTw
 zSjn27nF0XibCJ/x4T9YIeYmHHZWtgjUvV40jApQu7/ft4voU4JQpyE5D Q==;
X-CSE-ConnectionGUID: 4QH/yQfZQ5az5OyZwSxA9g==
X-CSE-MsgGUID: niVfLO3wS/S80HIKIKOntQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78380539"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="78380539"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 23:14:38 -0700
X-CSE-ConnectionGUID: 5i34rrQ2QUyVhBI6f89KvA==
X-CSE-MsgGUID: UIVWTR2fSU6J8gFJkt1CLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="234454349"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.141])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 23:14:35 -0700
Date: Wed, 29 Apr 2026 09:14:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Don't use UTS_RELEASE directly
Message-ID: <afGhx3voJpWrxJDl@ashevche-desk.local>
References: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
 <afDYn8Uy6PwvOVbH@ashevche-desk.local> <afDiNw30ud7hA4CN@monoceros>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afDiNw30ud7hA4CN@monoceros>
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

On Tue, Apr 28, 2026 at 06:39:53PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Tue, Apr 28, 2026 at 06:56:15PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 28, 2026 at 04:45:53PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> > > uncommitted changes in the source tree or new commits). So when checking
> > > if a patch introduces changes to the resulting binary each usage of
> > > UTS_RELEASE is source of annoyance.
> > > 
> > > Instead of using UTS_RELEASE directly use init_utsname()->release which
> > > evaluates to the same string but with that a change of UTS_RELEASE
> > > doesn't affect msm_disp_snapshot_util.o or msm_gpu.o.
> > 
> > Would you like to submit similar changes against driver/auxdisplay?
> 
> These didn't pollute my build results so far, so my pressure is small.
> (Two of the three are not relevant for an allmodconfig build and the
> third depends on PLAT_VERSATILE which isn't in my build matrix.)
> 
> I assume you ask because if I say no you'd address that? In that case
> please go on.

Okay, noted.
Thanks for bringing in the way how to solve it!

-- 
With Best Regards,
Andy Shevchenko


