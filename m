Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8A6CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5690410E276;
	Thu,  1 Oct 2026 19:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="New+6PZH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE6710E276
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790882001; x=1822418001;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Vr4V/gCzPPo+UnjwMdgsC+wmyLcsr9HE+lOJEU++tgo=;
 b=New+6PZHIshejQPb4U4JzzaOq4v+iJhRCYq042Nh/x47MS9QJ49vJSX5
 UXK570c+/NxARjk/LaBTaOxT+/QVNW+5ktbAA6EIopbgG1ffoqzDonZfX
 4LVCHYMzyCQDxPVCPpsY6gKOL5T46Pj+6JOfMFBV0ykg/dnsU1vrnqVbc
 8TdwVGP8sH01iu6Uo0yjFjRltg364laB1jEDSnKGKHhqQTk3i2m5nQWJg
 APqF5qZTPOdzk7kuo4btKlkXupFvwBG1s7NADNaR4ZpuFDR7a6k/dMSiX
 zxm166JzB9miZ59oVEqBrjxSvIMmsX7qVL5EorGtyu6EVJ9gssl3mBcvp w==;
X-CSE-ConnectionGUID: twJsEBZfQ4u6gKlhuqScZQ==
X-CSE-MsgGUID: VKU1F2eaTXSz9lzN/UypZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="117180990"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="117180990"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 12:13:20 -0700
X-CSE-ConnectionGUID: 18tymik5T7qQu8HwzKvanA==
X-CSE-MsgGUID: S0AQYo3oQXCtbS4+WZHidA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="279834236"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.27])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 12:13:17 -0700
Date: Thu, 1 Oct 2026 22:13:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/3] iio: adc: add stm32 mdf support
Message-ID: <ar6wypoRS-5j9iM7@ashevche-desk.local>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-3-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001145702.2628429-3-olivier.moysan@foss.st.com>
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

On Thu, Oct 01, 2026 at 04:56:46PM +0200, Olivier Moysan wrote:
> Add the STM32 Multi-function Digital Filter (MDF) core, serial interface
> and digital filter drivers. The MDF converts bitstreams from sigma-delta
> modulators or digital microphones into samples exposed through IIO.
> 
> Audio: capture PDM microphones via cyclic DMA for an ASoC consumer.
> Support CIC scaling and filtering, synchronized and interleaving modes.
> Audio use case requires a DMIC filter, and a separate ASoC DAI.
> 
> Analog: expose sigma-delta modulators as IIO voltage channels with
> direct reads or DMA buffering mode. STM32 timer triggers can be used as
> clock source.
> Analog use case requires an IIO backend for the SD modulator.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/iio/adc/Kconfig               |   27 +
>  drivers/iio/adc/Makefile              |    3 +
>  drivers/iio/adc/stm32-mdf-adc.c       | 2078 +++++++++++++++++++++++++
>  drivers/iio/adc/stm32-mdf-core.c      |  857 ++++++++++
>  drivers/iio/adc/stm32-mdf-serial.c    |  309 ++++
>  drivers/iio/adc/stm32-mdf.h           |  312 ++++
>  include/linux/iio/adc/stm32-mdf-adc.h |   19 +
>  7 files changed, 3605 insertions(+)

Unreviewable. Make sure the single patch is ~750 lines.


-- 
With Best Regards,
Andy Shevchenko


