Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C22CA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 21:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E5810E339;
	Sat,  3 Oct 2026 21:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EXPudDZ6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D1810E15E;
 Sat,  3 Oct 2026 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791061599; x=1822597599;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6YmSDdxKEVQ0IENYScjeZQmJ83BkyUs0pR5KIXOTRHU=;
 b=EXPudDZ62kiS8j7tRxY7M3l2zA193tr54V82HSogfQYk5FDqgohCQHmJ
 6blOYv3xdrk/e1WHwOkTEg0PP/rH1bvfpoaSrURrBqioZDAJnqaGCT3pd
 5nN0Wmup7HJIqFVP8QiWf24akhDZpdBepshNty2LmoZk5V5fa2bbyVF3X
 iQDdgFWAgFOzXl8D/Es9LwGWmjT7CAZwFPynm6cdDdeqSsxGI3YehvqAY
 NeV+vQShQdynBFfB2y0NccK8x4kv1yOiw6KSzTcWCBu/Pg/xZXhr3icqX
 pW946qZ+ITLHTJlCKtA/MoBIfQmOyu5Vnm6eVLUR9vkQPO/AM1r5YoxiY w==;
X-CSE-ConnectionGUID: OzXAYNQEQti4w7ov+IzU1A==
X-CSE-MsgGUID: nse3m8L8Rjq3VJqTNbJuDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90920238"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; d="scan'208";a="90920238"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2026 14:06:38 -0700
X-CSE-ConnectionGUID: xzKpLxD0Q7WmjJcYGWMcHA==
X-CSE-MsgGUID: mTNviLB7RZSKfuuXuz3wGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="588311"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com)
 ([10.245.245.88])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2026 14:06:34 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
 by kekkonen.fi.intel.com (Postfix) with SMTP id DA1B611FA5B;
 Sun, 04 Oct 2026 00:06:32 +0300 (EEST)
Date: Sun, 4 Oct 2026 00:06:32 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-pci@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] media: Consolidate AtomISP v2 PCI IDs in the
 pci_ids.h
Message-ID: <asFuWAQUPxETWqDL@kekkonen.localdomain>
References: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
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

Hi Andy,

On Fri, Oct 02, 2026 at 11:43:43AM +0200, Andy Shevchenko wrote:
> We have a few drivers using same pair of the PCI IDs across the kernel and
> there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h database.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Assuming that media subsystem is the main beneficiary I think it is the best
> to route it via that tree. For others (i915, PCI, PDx86), please Ack if you
> are agree.

I missed this earlier... I'll take this via the media tree.

Thanks!

-- 
Sakari Ailus
