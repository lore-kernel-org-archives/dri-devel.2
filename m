Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8A6CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C2310E0FA;
	Tue, 23 Jun 2026 08:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Uv14a83H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03A810E0FA
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782204115; x=1813740115;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NVU1esyolU7WLFj8gLpesagVKS9aEicy5xSrvy+QSIE=;
 b=Uv14a83H09LXRWiJxF959aa4MbcxdmMrQ4G6mavmMK0tD5haeWENb6/e
 ZTeSAodxsil2XksaivDZJd0KL1GPylbSgQ4f9v819JQRglbulugiNeTyo
 HAUqw+tfivPKMQIXkgD3OoNbf0GLXkoSS/URBjZOjmK7FET857zr/Kj6d
 p3js7Eo/N0m29qBC7+FySBuAS+Gr+sxWuNYdP+1B407Mh3O+DWDfB+HKK
 gO+YDEPCBTtuVOJllk9B0hVAAzSzmcO2x/jGF7Bs/VfikjT1Ii6I+RIhY
 Dk8amslVzEKJ7Cmduu1fjtYRkaPb3e7zZZPRGDLytxhOtXpl6QWw3B//j A==;
X-CSE-ConnectionGUID: cSrvMadaTEOvhZwIBDdYkQ==
X-CSE-MsgGUID: a8PRnObnQvyZ01QTQ9QruQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86784132"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="86784132"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 01:41:54 -0700
X-CSE-ConnectionGUID: 51sPTZeLQISJJsimKa2cqw==
X-CSE-MsgGUID: 0NozmO/VT3O6HKbZ6+vsYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="253803495"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.7])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 01:41:50 -0700
Date: Tue, 23 Jun 2026 11:41:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andy@kernel.org, gregkh@linuxfoundation.org,
 deller@gmx.de, azuddinadam@gmail.com, chintanlike@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
Message-ID: <ajpGy7K4eM8oJIfD@ashevche-desk.local>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-5-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622152506.78627-5-amit.barzilai22@gmail.com>
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

On Mon, Jun 22, 2026 at 06:25:06PM +0300, Amit Barzilai wrote:
> The SSD1351 support was added to the ssd130x DRM driver. To avoid
> confusion and irrelevant updates, the staging fb_ssd1351 driver is
> removed.

NAK, the fbtft has two drivers in one (SPI + parallel), plus as Maxime said,
it has its own binding.

-- 
With Best Regards,
Andy Shevchenko


