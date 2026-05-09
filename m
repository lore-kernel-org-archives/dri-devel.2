Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF8ECD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 17:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB75C10E0D2;
	Sat,  9 May 2026 17:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lHMveWvA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50A710E0D2
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778346144; x=1809882144;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DZ9Vzy9EQuMpdpebAGj5naA0x7BLfOQ0ducYTB95hzU=;
 b=lHMveWvAgVS0rgTtZWivJDf3bCCXSSWo4i1D8Zx7WJZG1V4TtnY1BnDn
 /w/Bzac4232Qu4dQY+1HGyx3dPaWl+oxTGBvkI/mYc+12o5+uBemZeWQV
 Oqutp2VsuwNz2xugo3zhw25PHK6ZLk9wvliSiBqBj5JuH/wnxx9HzEVll
 6DQQc7WJ0dXrF+nutOEVsfbe8LDaFFg4dTXltbx168Olarq8vma32puYP
 fwLd3NMK7WJsE6XQbfA8fO9EGftI6krZK5GqI7TATUl8DB0QL9E6d514O
 In8Sb+2ZWbtUnmVwkuj24H1Rm7+3n7a9m+x0liOFMf0bFOwzo9cHr0R7Q Q==;
X-CSE-ConnectionGUID: CavwFF85RyaBtJRcq3q8Fw==
X-CSE-MsgGUID: u2mTjq8jR8mWmZnZXIHwag==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="83169068"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="83169068"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2026 10:02:24 -0700
X-CSE-ConnectionGUID: N0H3E+y0RMecToAgBYWHSA==
X-CSE-MsgGUID: ITxvYUo8Q0WQE4mtSomAWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="267418505"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.146])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2026 10:02:21 -0700
Date: Sat, 9 May 2026 20:02:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <david@lechnology.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/st7735r: simplify with
 spi_get_device_match_data()
Message-ID: <af9ommD7xYIu-JzG@ashevche-desk.local>
References: <20260508080004.1143774-1-andriy.shevchenko@linux.intel.com>
 <5093f74c-9f74-4ec3-967f-c77c3d59097d@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5093f74c-9f74-4ec3-967f-c77c3d59097d@lechnology.com>
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

On Fri, May 08, 2026 at 07:53:12AM -0500, David Lechner wrote:
> On 5/8/26 3:00 AM, Andy Shevchenko wrote:
> > Use spi_get_device_match_data() helper to simplify a bit the driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> Reviewed-by: David Lechner <david@lechnology.com>

Sorry, this was script-type change, it won't compile.

-- 
With Best Regards,
Andy Shevchenko


