Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C12EC43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A009810F0BD;
	Wed,  8 Jul 2026 11:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NKaLLLgY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD5410F0BC;
 Wed,  8 Jul 2026 11:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783509135; x=1815045135;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dXbZA1E6z2cbPpn5lXVwUbC3y8RJZe9PuV/6K4qA1zI=;
 b=NKaLLLgYSGwRbFEUPZ4WXfWAkQLZfXhRPviQaSCCWKxzP1Hwd/RZVyI5
 qhXuK+dXM700naBdhd5VjHzf3fB68yRX1rwFVdBb5K4tRooC+h47nZN0b
 HqlzRyvi3i/kegVxXwlN1Q9bFbd81z5OdScYJJbrEMHBh9n2zirrfivj3
 BLmv97jfpG4CZUhQ06zO8jXEDpEWV04IHrUTpZ4Y4IibitKa+7JaNke2V
 eeZ2GZkWMVMW7okGFl4bSqx3udTAk2pzQVKxjuOZ7hAoPkOtFqIPD9PMt
 rUuZBYfnUwPvVhb5PmwwjRrhP3ahd79YDWKu/qN+x7cMdQsrVi6vnYScE A==;
X-CSE-ConnectionGUID: zPFvwxOaRWa3AIeDOcARmw==
X-CSE-MsgGUID: YkTzvrgqQ7evq5LOpFHqYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84025158"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84025158"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 04:12:14 -0700
X-CSE-ConnectionGUID: xnTXU7N2RFKFpJyFUzPznA==
X-CSE-MsgGUID: WXa6o+4tR/u+kKLX2b+3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="252523743"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.100])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 04:12:00 -0700
Date: Wed, 8 Jul 2026 14:11:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev,
 Manuel Ebner <manuelebner@mailbox.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 05/20] driver core: update kerneldoc for
 platform_device_alloc()
Message-ID: <ak4wfuYxO2serrQt@ashevche-desk.local>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com>
 <ak0jyUbNonSRiP_g@ashevche-desk.local>
 <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
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

On Wed, Jul 08, 2026 at 12:42:58AM -0700, Bartosz Golaszewski wrote:
> On Tue, 7 Jul 2026 18:05:29 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Mon, Jul 06, 2026 at 02:44:17PM +0200, Bartosz Golaszewski wrote:
> >> Users of platform_device_alloc() + platform_device_add() must not modify
> >> certain fields of the dynamically created platform device object. Update
> >> the kernel doc to say which fields are affected and which functions to
> >> use.
> >
> > Consider using __private checker attribute for them as well. It will make
> > sparse scream.
> 
> Sure but let's leave it for another series.

Sure, just a side note comment that you know that we have some facilities for
that type of problems.

-- 
With Best Regards,
Andy Shevchenko


