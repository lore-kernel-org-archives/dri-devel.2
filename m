Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C848CD4F25
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 07:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59C210E198;
	Sun, 17 May 2026 07:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PLFmYx+8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6536C10E198
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779004527; x=1810540527;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=i0kfLz76ZUS7mXXRA6d1PSTN4kPR6EHkESc4EYiFmcU=;
 b=PLFmYx+8PP+X7PUKWejWPC9oXi+Pmy4aNUJaOPEb8PYjRbYpp9kEiuN0
 DDguKycuuTuwYlf8Po6TAAesdB6K3c0u547Gd3fBscJNfGN8ITeFgI921
 55N0opdSLHtQESUw31cDpljhtPlyFaM4X3ThPiktGPg6QQPC/K022Nwia
 ye0AecGWmroae7BdAstdsdxHEvCiSaHD6SGpVLHHpAlOZXDD09V43h9Ey
 z99OvQcPj3X32GpSumKiNBXBDAIeicANpCT4PXOUti31bFcKizGBF+lB6
 VpnmxXwQhDDkP1oFl88qRQ5CFiAcIsKt5NHK+S4XCpRLkxyxRCeMwOUo0 A==;
X-CSE-ConnectionGUID: k135lTsFRguyBIbcG5TiwA==
X-CSE-MsgGUID: 6/dutP4LTMiqrkL14qoyyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606872"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="79606872"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 00:55:26 -0700
X-CSE-ConnectionGUID: UauCmfXUSYaqhGk3+0DCCw==
X-CSE-MsgGUID: 7XNc7wVTTtOLron1bLoE+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="236489130"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.182])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 00:55:21 -0700
Date: Sun, 17 May 2026 10:55:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
Message-ID: <agl0Z_EGzX8X4No4@ashevche-desk.local>
References: <20260517074306.30937-1-clamor95@gmail.com>
 <20260517074306.30937-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517074306.30937-3-clamor95@gmail.com>
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

On Sun, May 17, 2026 at 10:43:02AM +0300, Svyatoslav Ryhel wrote:
> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
> Additionally, optimize functions used only by platform data.

This is a mixture of at least (!) three patches:
- devm conversion
- the change of some constants
- the rest

-- 
With Best Regards,
Andy Shevchenko


