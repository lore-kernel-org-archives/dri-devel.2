Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFDFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881BF10EC36;
	Tue, 30 Jun 2026 11:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N95sYqlI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C547210EBFB;
 Tue, 30 Jun 2026 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782820420; x=1814356420;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HHeUzys9SZo4sXJXwBYEOYegZzAOleiFoxqxV4KVsUA=;
 b=N95sYqlIcdWsKyi8Wwj9FSbmqjGRWu1HNJyPFWjEsQM9KZ6EwxOVMLnr
 oE6S2x2tU11XtAjhgQa/9PyqyLQGgR6jG48Ub3QRGNIqZLrkHDdqa/s2y
 17pMKdk0SOFuimdxL8vrYve5mfXqup0jKunjDAdUFJKpvyRgTmU2osO20
 3SJRViL0oeb0fNne6zkP65PIs5l42vI91Al0kllIkUvL6BZHf7L1+k7tc
 wtk/BzYvl3c5iL2D5giZPC1Br450LDOQcxHTrCOxiOn5O/EDgy9XgWPYP
 5cyn2IPLgCA19xASErdGsVNNdHKyZOu7+2WLlwQfDdc4rK4A/ceqk/J34 w==;
X-CSE-ConnectionGUID: pzQmlIuMTfCfWIJ7vNtjVQ==
X-CSE-MsgGUID: kYdo7RkkRXSmrJHBuO1XOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="109080369"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="109080369"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:53:39 -0700
X-CSE-ConnectionGUID: UseMqb4hTouQba8inFEEaA==
X-CSE-MsgGUID: OQAo9beZS6SkUijWaWBaZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="250556196"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.96])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:53:36 -0700
Date: Tue, 30 Jun 2026 14:53:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Timur Tabi <ttabi@nvidia.com>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Ben Skeggs <bskeggs@nvidia.com>, Kees Cook <kees@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Mel Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 1/4] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
Message-ID: <akOuPQ37-zxIJWWH@ashevche-desk.local>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <20260629224350.2870201-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629224350.2870201-2-lyude@redhat.com>
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

On Mon, Jun 29, 2026 at 06:42:33PM -0400, Lyude Paul wrote:
> This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
> 
> It turns out this looked like the right fix on some systems, but it's not -
> as this causes runtime PM to actually fail on many a laptop.
> 
> [I have set the fixes to an older commit then the one that is reverted
> here, because when applied with the other patches in this series, this
> appears to /fully/ fix runtime PM in addition to the regression]

No need to have this in the commit message, move it to the comment block...

> Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")

I'm not sure, actually, that this is a correct approach. You can't revert
something that never appeared (in time range between 53dac0623853 and
8302d0afeaec). Have you consulted with the stable kernel process documentation
and/or respective maintainers?

> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---

...somewhere here.

>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 8 ++++----
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h        | 2 +-

-- 
With Best Regards,
Andy Shevchenko


