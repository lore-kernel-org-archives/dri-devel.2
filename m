Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96822CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38F110E63F;
	Fri,  2 Oct 2026 18:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KN2FJHDY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7F210E636;
 Fri,  2 Oct 2026 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790967143; x=1822503143;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=acZn+DQwzgqtDPZktYzvVkV1BU/0NMyBtMEghpn7H/o=;
 b=KN2FJHDYTjcHTAj+XUusKTThgQQoqNbom58gEAcVAkRgfH1SpAjvVY6H
 5RA42lyO8SWq+TKqs6z4FY+xP31hNwZG0cOHRGsPKLq9gr65gNZH5T2ri
 yN/2Jc4GINhwOnDyiqJS217mcBjHcdPL3AkxzI6AawxCtGz9jV/g/Tyd/
 5K8HuXqdzKVB1jasrxo6iJ7cO+JAHKOBGqI3JAa7oG0aQkEwBiyDqUdqh
 S3W+9M5BgXlWCwF4vL08dCa09p+JTWNquAxway2peGeGDLwOk2K1H5V3c
 2Mf+ctmq6hTJhbN2lNiHVR7o6IwbXuM6X2y1FP49JZlnOGpSiGn5bDaGm g==;
X-CSE-ConnectionGUID: /SXQJUhLQ9qtJOX7Q+iKLg==
X-CSE-MsgGUID: 5JlVYsaqT3WdwH4JQeTcyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90796832"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="90796832"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 11:52:23 -0700
X-CSE-ConnectionGUID: i+pvZfXuQjmOzwIpjBRQqw==
X-CSE-MsgGUID: o/UNA2bRR5G0Dm95Wq1/6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="391566"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com)
 ([10.245.245.45])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 11:52:19 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
 by kekkonen.fi.intel.com (Postfix) with SMTP id 696F6121BB9;
 Fri, 02 Oct 2026 21:52:16 +0300 (EEST)
Date: Fri, 2 Oct 2026 21:52:16 +0300
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
Message-ID: <ar_9YLJj5_PbzGEO@kekkonen.localdomain>
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

On Fri, Oct 02, 2026 at 11:43:43AM +0200, Andy Shevchenko wrote:
> We have a few drivers using same pair of the PCI IDs across the kernel and
> there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h database.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
