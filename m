Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2D7CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F4310E323;
	Fri,  2 Oct 2026 13:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Azlx7Cm0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5244010E323
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790947569; x=1822483569;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CWPptF2POV/5KDvdcCNlvnaNBA/ndWYIWDLd9SWVH2g=;
 b=Azlx7Cm0esLpYe08ggJU7cJ3B5ksdbUmYve21Q6XrwR5VBjC9A5GhtpN
 8LUHyQJMNVxKZH7xtp6w/ecy1/gAUYwUB338mvUTgo8kmk/z6phLxTswe
 tCG75uu734jYmGnQKyeOp7MEFJpE3hBzh3PpVX0esyPoWBtswewLM57fq
 5CG7cGSWBX1NaGPS8RG2Ngi48EPrvR/DxPMF4DBMIW5QgFkSMQ9oEgxOb
 c6OX7bH7DdFcEmYBGH71bqTM8xHGJvjyU9gTpayE8lOo5je3lZOpXW28s
 z78e/QGVVt0YLo4SLEoIWdfDluTP53+SK6GN5XCxlPT/gled0ZCzrmzRI g==;
X-CSE-ConnectionGUID: 2AoHo4wDSy663nGCv2SAqQ==
X-CSE-MsgGUID: Ur3pfHqBSsSLFkU9QiAviA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90768480"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="90768480"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 06:26:08 -0700
X-CSE-ConnectionGUID: AszzBaCqSZ+UMEBZg/kajw==
X-CSE-MsgGUID: 8TCjU4HQR1SGXLQUZWjSPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="272653951"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.188])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 06:26:03 -0700
Date: Fri, 2 Oct 2026 16:26:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, decui@microsoft.com,
 ssengar@linux.microsoft.com, andy@kernel.org,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 0/7] drm: Remove simple-display pipe
Message-ID: <ar-w6GUQqROQkdec@ashevche-desk.local>
References: <20261002124456.741011-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
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

On Fri, Oct 02, 2026 at 02:41:50PM +0200, Thomas Zimmermann wrote:
> There are no drivers using struct drm_simple_display_pipe left. Remove
> the related helpers from DRM and clear any TODO items. Hyperv-drm needs
> a minor fix to include some additional headers.
> 
> Since we're at it, also remove include statements for the simple-kms
> header that are no longer needed. Most of them are likely left over from
> earlier usage of the simple-display pipe.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
for the patches 3-7.

-- 
With Best Regards,
Andy Shevchenko


