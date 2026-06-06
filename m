Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDCCCD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 06:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C2C10E23A;
	Sat,  6 Jun 2026 06:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dk+LZpHv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766FC10E71B
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780728405; x=1812264405;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DSxIRnTXK40EJiQzC44uhcd9hVw68raQ06IMzoojolQ=;
 b=dk+LZpHvJrJ80lj61xNhPbGqQ/04+eXa14g+9ko6g4vJT1x7fyGos2Ir
 FTnFamrlYd0qorVBoNNEgcSm3cUcsLElJv0AyGeCWcE2+givgh6BbD3Q7
 k1PvUecNKTGRrwJ/0rFC5kRDT4TpzttgMw7AsFYPSNSbAAH4Bgx+T2Ozm
 1+cVS2/MHXwxBBETx6HCavGpFHdQYl7qGhxhTvcUcdDhoIZI+Ej0eALEs
 EkDbmCWpjI27kA0owlSovs29+2iNhUDp6Sh7j3qmcmndTRb++m9DIwZZr
 Xvr7P4EBZ5rDCofxOQr9OfD4k4J7i/8NMfdOkkh/Yb8/sMlpPmESxMgOI w==;
X-CSE-ConnectionGUID: BcWdx4z1TcyPqBhI7JjW0g==
X-CSE-MsgGUID: ntMIoHPDSMigpBblIFfLIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="92121091"
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; d="scan'208";a="92121091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 23:46:44 -0700
X-CSE-ConnectionGUID: b+3Z64H6SE6PXSgvrpJa/w==
X-CSE-MsgGUID: JwMTLQe7Q3WEGxDkk49JsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; d="scan'208";a="283121212"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.57])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 23:46:39 -0700
Date: Sat, 6 Jun 2026 09:46:36 +0300
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
Subject: Re: [PATCH v4 03/14] mfd: lm3533: Remove extern from shared
 functions in the header
Message-ID: <aiPCTBFGgnfhFgLl@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-4-clamor95@gmail.com>
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

On Sat, Jun 06, 2026 at 07:57:27AM +0300, Svyatoslav Ryhel wrote:
> Using 'extern' is not required, drop them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


