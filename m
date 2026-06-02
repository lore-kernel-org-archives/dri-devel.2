Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F80C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1BA1138C0;
	Tue,  2 Jun 2026 08:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HgVU5AEo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CB41138C0
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780387650; x=1811923650;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QeRLT4nVGcn0FGb2agv9AHWg3M49O/B8jVmKTpZqt6Q=;
 b=HgVU5AEokOMB87KJmTo1g8Q4foTFqDkFPeTjR9Ih3Ad1SzOTAc8AhtBr
 3RSMZuFHwvReT0KIc5dKG+7CezggllmeQ5GfYN9+m73eQA7/9zmwCW6lA
 G7E4bDSh6LtXKkmggaDHQLVjYp2HlBIUVoeDVXz63cdyyhK8Q+z7ZH3VT
 XPQb8PKGziRUhPoTeMrpsUIURJobog5aU2aPXqeWLzrj1s9fEsS6+y8O0
 5iu4efDErc6iZLpKJZk3ezlb1YkJcKglTkp05C4jnuJKyVvmn1YYP3c4J
 wyvC7EWBTXSPpd3qP/Hq2KP1g3NV76eDh+reHVXpaWW/LVSJJW+BQuRqx Q==;
X-CSE-ConnectionGUID: oPV70RSXTd6wt+qr80/27Q==
X-CSE-MsgGUID: PQUuWl1tQ4y5paM5DxvF8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81347945"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="81347945"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 01:07:29 -0700
X-CSE-ConnectionGUID: mgksFXFCTzmnmm35dce/mA==
X-CSE-MsgGUID: zKU2EH9+S5GVvGNF3pQm8A==
X-ExtLoop1: 1
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.229])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 01:07:24 -0700
Date: Tue, 2 Jun 2026 11:07:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata
 helpers
Message-ID: <ah6POiAiwmc7FVUu@ashevche-desk.local>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-4-clamor95@gmail.com>
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

On Mon, Jun 01, 2026 at 06:18:23PM +0300, Svyatoslav Ryhel wrote:
> The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> used only in lm3533_als_setup. Incorporate their code into
> lm3533_als_setup directly to simplify driver readability.

Same comments as per previous patch.
I stop my review here as it seems may be more of this.

-- 
With Best Regards,
Andy Shevchenko


