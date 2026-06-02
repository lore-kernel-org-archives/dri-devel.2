Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C460CCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D84910E75D;
	Tue,  2 Jun 2026 21:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bOrxwt7d";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFD610E75D;
 Tue,  2 Jun 2026 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780436425; x=1811972425;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4eyZw4UOnHhwv4cFQ/JjHG+RrOIvOOmydNLwutjD+3M=;
 b=bOrxwt7dDdlu+tP9OU2MHGU2Tagrr5urXNNZGyFg9SW7iyaS4ycJF/jt
 G7DzFSRuUviQCr4+/0YBH90Zi26k4nKHka39YsxJ6e/ItU1hjSddgaOze
 Zrnu4wLJG/HAnwt4N4+RhcBYjnjIc4fWKDvu32buOY4fA8jSOILZRuc6/
 Oquoy7V+wOXq3BuLTRFX4PV1ZZJLwm4xqKhixuJqCflyB/YT3R+DxvCGn
 X+w/m00sEp/majR84hpYlILQE6N1uFcoiv4u+uasR+bJNnBpo3/gQxMNF
 9HnQztpLpcpEsMpDc608AE4H5W8Evy7VyjMoMUy/vB74FP2Ok41osAO+j A==;
X-CSE-ConnectionGUID: GPXSBp4xQBOk87P/T5cHNQ==
X-CSE-MsgGUID: HOmwDi+CR2uBiKVJoWdXww==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80972407"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="80972407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 14:40:24 -0700
X-CSE-ConnectionGUID: PcIQbEzqTbKa1yc0yhfIOQ==
X-CSE-MsgGUID: nO91ZzCfR2qu25nrSJCLRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="239575909"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.116])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 14:40:11 -0700
Date: Wed, 3 Jun 2026 00:40:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 06/23] driver core: platform: provide
 platform_device_set_of_node()
Message-ID: <ah9NXwJFrkK_yuw8@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-6-88c324a1b8d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-pdev-fwnode-ref-v1-6-88c324a1b8d2@oss.qualcomm.com>
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

On Thu, May 21, 2026 at 10:36:29AM +0200, Bartosz Golaszewski wrote:
> Encapsulate the reference counting logic for OF nodes assigned to
> platform devices created with platform_device_alloc() in a helper
> function. Make the kerneldoc state that this is the proper interface for
> assigning OF nodes to dynamically allocated platform devices. This will
> allow us to switch to counting the references of the device's firmware
> nodes, not only the OF nodes.

...

> +/**
> + * platform_device_set_of_node - assign an OF node to device
> + * @pdev: platform device to add the node for
> + * @np: new device node
> + *
> + * Assign an OF node to this platform device. Internally keep track of the
> + * reference count. Devices created with platform_device_alloc() must use this
> + * function instead of assigning the node manually.
> + */
> +void platform_device_set_of_node(struct platform_device *pdev,
> +				 struct device_node *np)

Why not fwnode to begin with?

> +{
> +	of_node_put(pdev->dev.of_node);

And if it has an fwnode?

> +	pdev->dev.of_node = of_node_get(np);
> +	pdev->dev.fwnode = of_fwnode_handle(np);

This looks like

	device_set_node(&pdev->dev, fwnode_handle_get(...));

> +}

-- 
With Best Regards,
Andy Shevchenko


