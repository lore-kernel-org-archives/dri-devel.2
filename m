Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kXc7Y1nZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E86910EBA5;
	Thu, 12 Nov 2026 21:35:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF3D10E133;
 Thu, 12 Nov 2026 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794519304; x=1826055304;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qiPKcs32cIql2L4FKZiiE+381T/H6p7Ydei/f5AE/Xk=;
 b=kXc7Y1nZakc4z6acqtuMcvVf6lPAD6UaTf1jv00vuJ820ElUNxVTJ7v3
 qCXIygQKo6GCfbAFAL1TYnwK/rBPSHKuFhaFVFlSfjRJEPB44Cqz4OjnX
 Pkuw3iwcmW1ldvbqhjR05l3L3ptVi2Dhn3n4wXq4YcNOvY8aHVX7KHjDc
 uCx7ZRJlKcSw6S9JvsnL3j3ZbYBesWGzcHk42wHPAIELDE8VTYHc5mg7j
 Hh0hK/nPqGmBYVVOSGVhpvpbFkgQ1gO8IL8JJAw1fUFEdNtK0rzlR4Fpb
 0YmBKchY0W7IvjyliatlSvNUuppZ6dgMaTgNV7BvKCQHrbekPWSTXBf+7 A==;
X-CSE-ConnectionGUID: ykpOQ8dUQzGjLIFas9uQqg==
X-CSE-MsgGUID: BxyYB7nxQWSPEmVwHpEWhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3337902"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3337902"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 13:35:04 -0800
X-CSE-ConnectionGUID: RpXP1+IKRjCrp7G288nWEQ==
X-CSE-MsgGUID: 7Z8WZBzRQqymuNkyk7JalA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9317428"
Received: from zzombora-mobl1 (HELO kekkonen.fi.intel.com) ([10.245.244.107])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 13:34:59 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
 by kekkonen.fi.intel.com (Postfix) with SMTP id 153E5121B71;
 Thu, 12 Nov 2026 23:34:59 +0200 (EET)
Date: Thu, 12 Nov 2026 23:34:59 +0200
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
Message-ID: <avYxAxh61Rv956SO@kekkonen.localdomain>
References: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
 <asFuWAQUPxETWqDL@kekkonen.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asFuWAQUPxETWqDL@kekkonen.localdomain>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sun, Oct 04, 2026 at 12:06:32AM +0300, Sakari Ailus wrote:
> > Assuming that media subsystem is the main beneficiary I think it is the best
> > to route it via that tree. For others (i915, PCI, PDx86), please Ack if you
> > are agree.

Just checking -- are the respective maintainers fine with merging this via
the media tree?

-- 
Regards,

Sakari Ailus
