Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C59C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA1D10E202;
	Tue, 30 Jun 2026 11:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JicJHmBM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AC710E202;
 Tue, 30 Jun 2026 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782820235; x=1814356235;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Q62f07SbwkgKGBg+I3Ip6MjJhwO1ctHYM8PsIAqG6fA=;
 b=JicJHmBMnYyq6hD0RzPe8qk1QSqmCwgdnLCr93BTDHWeJGND0UrI2V92
 vMTMDuavJ5J3Fdl7FKRxwSbvWpsnTjQuEuuoLGCDRXFySl4tVla0a9KXU
 h7KGdde3Pwm50CfH/u6EHCZ3V6tEEgLvzQV1NjTDXde6Q5rvXMv3QEhnt
 X5PPUFzkgEMKeANgR52NDDK8lURoxtu3W0jB3A3cS45nQTEmoRQVJ3utG
 MQ23zszdoNwqVpK/mNBGIH6hrCRzvVl+ptGaarK/dzzI4PdKeTtHVxo9C
 dg4kfJLElO2vE4nsP+NNYG7MeLKSHIN5ew+7U2S5DU0LhacZuiZw9fWc6 g==;
X-CSE-ConnectionGUID: opOP9ZhGRhi4ZlnCblWb8Q==
X-CSE-MsgGUID: yKwPrLN1RziUJE1GrHrpUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83307022"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="83307022"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:50:35 -0700
X-CSE-ConnectionGUID: jT0KX4JNRZy9+wdOUWGUVw==
X-CSE-MsgGUID: TLe8MUBAQRWusE0sQDirjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="248263524"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.96])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:50:31 -0700
Date: Tue, 30 Jun 2026 14:50:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>,
 Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Ben Skeggs <bskeggs@nvidia.com>, Kees Cook <kees@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Mel Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 0/4] drm/nouveau/gsp/r570: Fix runtime PM
Message-ID: <akOthKT6XeaUnhH6@ashevche-desk.local>
References: <20260629224350.2870201-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629224350.2870201-1-lyude@redhat.com>
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

On Mon, Jun 29, 2026 at 06:42:32PM -0400, Lyude Paul wrote:
> Runtime PM has been kind of unreliable with GSP for a while. It works
> well enough to shut the GPU off and turn it back on, but more often then
> not it ends up leaving the GPU in a broken state on resume - which makes
> it impossible to really do anything else with it.
> 
> Recently however, I discovered that it's been failing much harder on
> some ampere systems. This lead me down a rabbit hole that lead me to
> figure out one of our previous fixes for runtime PM wasn't correct.
> After fixing that and combining it with some fixes we had tried in the
> past without success, I finally managed to get nouveau to handle runtime
> PM with the GSP perfectly. These are those fixes.
> 
> Tested on a Lenovo P16 G1 (100 runtime PM cycles!), and RTX4000.

This is v2, and no changelog. What's going on?

-- 
With Best Regards,
Andy Shevchenko


