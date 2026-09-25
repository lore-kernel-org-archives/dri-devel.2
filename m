Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFD9C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA59510E5B2;
	Fri, 25 Sep 2026 10:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EOK0Fjdr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBFB10E1DD;
 Fri, 25 Sep 2026 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790331058; x=1821867058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nGspYnnDwbxEw2uzhbTdVx6pk6eDe92BH9ntuHaRs/s=;
 b=EOK0Fjdr34Yf3OvVmlSnGB4jzD7HexmD248y0nC+Hrlv2Pc9Qez0RCIl
 4AY0nQ3A9S1AdLSpPkEKoOVLV+IsU463igPd6+gcQUJiQkT4NBjoHS8Ym
 191ljFUj9TV98ad42fQfHO9kaViyaYjX7iOsB5rkWBomQMlvZThawGY6G
 SZmhpeh6fC9THPJoOmZzLkpnSY6I8G6Iq+d05d6v0KiDXjCbnr/X0LuQf
 8zzQdMtS6XVzkpTLQT4EadzRidfMUBEF+w97pTZAd2TTkfCR3sir+533G
 M94YK8A/jINXNK60v9RVGFQoBJElCFym6h4lwnmZvDU2UkR74/N1BSBaa Q==;
X-CSE-ConnectionGUID: sYIGa51BQ96px2M5uzPIbA==
X-CSE-MsgGUID: 5YmyWRhQT+WGpDiGsKT+NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101288016"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="101288016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:10:58 -0700
X-CSE-ConnectionGUID: prgoZqEoTTSgWFpNLRmd4w==
X-CSE-MsgGUID: nO3lvYNQTrWGkYi4OVRZxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282384381"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.27])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:10:52 -0700
Date: Fri, 25 Sep 2026 13:10:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
 u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
 Ritwick.Sharma@arm.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
Message-ID: <arZIqk6wgV_LF0rg@ashevche-desk.local>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <arZB2s3HOBgSRuE4@ashevche-desk.local>
 <e0f113ea-92cc-4e82-85ae-f61814c230c7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f113ea-92cc-4e82-85ae-f61814c230c7@ti.com>
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

On Fri, Sep 25, 2026 at 03:29:27PM +0530, Aniket Limaye wrote:
> On 25/09/26 15:11, Andy Shevchenko wrote:
> > On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:

...

> > Still doesn't look good. The current register layout may be left as is. What
> > you need is translate it in the respective regmap callbacks in case we are
> > enumerated on the different IP. Also possible to have a different regmap
> > config for the different HW where you translate them only in one place.
> 
> Is it confusing to keep using existing offsets in regmap_read/write() call
> sites for TDA54, and let the regmap silently handle the translation?
> 
> Given that we do *not* have any new registers in use on the tda54 version
> that were not there in the original one, I guess it works... will send a v4
> as per your suggestion.

Depends on the mapping. Your series also forgot to provide the differences
Check this as an example: e539f435cb9c ("spi: dw: Add support for DesignWare DWC_ssi").

-- 
With Best Regards,
Andy Shevchenko


