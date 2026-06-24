Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C3FCDE002
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248F410EF3B;
	Wed, 24 Jun 2026 13:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OVWlcFLP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACE010EF38;
 Wed, 24 Jun 2026 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782308506; x=1813844506;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=UYzeCihKwsZTIJt7qUu/V5ZgXRyji+cIh9sSDnuivWg=;
 b=OVWlcFLPWR4m+ImxVNPxZJOgsDcfQr7ZEa7GPrcN87hVlMaUigzLKV2K
 aQnl6zYBFMGvk3Isa6rCKiOylL8mgedO8YQOG1bHPi+Fqxsb1p6BdKUgE
 fsYWUbobjTNf20//x218iZm00BvM8WDkxNJfWiRgzsFEjqyq4TIvLmMd0
 kfLKdos9gj4tmCgeHbRnC76u1Xguk7c7dMXdNP8EAcBgve5J1x4woHs+9
 K5xlLAJQG7/3oNUCS45c4yzRm52UZqszOJtpy/Tr/AWKrEF0fxyFIzKY3
 ul9i5w25LpcNV8Q/VydkgPxbdFSB32flp60+5jKPfF7ZaaVu/3ZqvtBMv A==;
X-CSE-ConnectionGUID: IO5n5D05QXOoWp1RJA1PnQ==
X-CSE-MsgGUID: cetbGABGS1uojPdkoCQNZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100619608"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="100619608"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 06:41:45 -0700
X-CSE-ConnectionGUID: DUU7xX6vReSGiGuBw+JA6w==
X-CSE-MsgGUID: i+kWJjACT+e7w5yfBYrvgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="249693218"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
 by orviesa008-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 06:41:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Suraj
 Kandpal <suraj.kandpal@intel.com>, Ankit Nautiyal
 <ankit.k.nautiyal@intel.com>, Michel =?utf-8?Q?D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
Subject: Re: [PATCH v2 0/5] drm/i915: Work harder to enable VRR based
 refresh rate changes on eDP
In-Reply-To: <20260622213602.7244-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260622213602.7244-1-ville.syrjala@linux.intel.com>
Date: Wed, 24 Jun 2026 16:41:41 +0300
Message-ID: <04d7e819ccb7301a9484a15906e118306fd786a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 23 Jun 2026, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> Tweak the eDP fixed mode selection algorithm to allow
> userspace to do refresh rate changes on VRR capable
> eDP panels without full modesets.

Acked-by: Jani Nikula <jani.nikula@intel.com>

I think this is orthogonal to the concerns raised by Michel in the v1
sub-thread at [1], and is not aimed blocking or being an alternative to
min/max refresh rates.


BR,
Jani.


[1] https://lore.kernel.org/r/3d441831-71bc-49fd-823f-3af443e55b20@mailbox.org



-- 
Jani Nikula, Intel
