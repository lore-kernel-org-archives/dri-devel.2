Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7000EC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C356B10E94B;
	Mon, 29 Jun 2026 16:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XxiRXyqu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0D710E2C8;
 Mon, 29 Jun 2026 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782750122; x=1814286122;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NFSMtVuoxLsda44tJKXSv/IYfieoOuyAy+SzWiTGH00=;
 b=XxiRXyquofvUprey3qzpj1B6cngnQ0wzxDozM2GfTi/P1D2XFui+QYiH
 KU26da8LalLm+f++Mi2RFKOBqJoj5BV0/l8FXIv041emI1UM55Z2wD8Gh
 qBMRGoyeSVJZAbWq/WDbajvp470VwZHizIYTKxBXB587vUHh6DjU1Ta5d
 /WTE1iL5+DpFhHkx76y5GJQORTEBEoLLPP9qGT6bW1Pocqmy9ojJUybn1
 LECYgGn0HMQ6tCJbVk66/4FZblnAet+upMYn7NG9VL1dcXXNzafgGuxs7
 eVcGdQC8BV88JrLkryuykUh5zB5o3cpN8VgYasJ4/uQAcxvhRP1QishPv A==;
X-CSE-ConnectionGUID: 89Bg195ITI2Guk0QG6lgqQ==
X-CSE-MsgGUID: OFscnsG2RYqmGK6U5ur80g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83644926"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="83644926"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 09:21:46 -0700
X-CSE-ConnectionGUID: FxugsHAHT4+THTJwauLSzw==
X-CSE-MsgGUID: nJKI5ILbSS+sjP319WFTsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="290124520"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.207])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 09:21:33 -0700
Date: Mon, 29 Jun 2026 19:21:10 +0300
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
Subject: Re: [PATCH v2 19/19] driver core: platform: count references to all
 kinds of firmware nodes
Message-ID: <akKbdrwQSGAakDcq@ashevche-desk.local>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
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

On Mon, Jun 29, 2026 at 11:12:42AM +0200, Bartosz Golaszewski wrote:
> When using platform_device_register_full(), we currently only increase
> the reference count of the OF node associated with a platform device. We
> symmetrically decrease it in platform_device_release(). With all users in
> tree now converted to using provided platform device helpers for
> assigning OF and firmware nodes, we can now switch to counting references
> of all kinds of firmware nodes.

Yep, that's the expected result, thanks!

...

>  void platform_device_set_fwnode(struct platform_device *pdev,
>  				struct fwnode_handle *fwnode)
>  {
> -	if (is_of_node(fwnode))
> -		platform_device_set_of_node(pdev, to_of_node(fwnode));
> -	else
> -		pdev->dev.fwnode = fwnode;
> +	fwnode_handle_put(pdev->dev.fwnode);

> +	pdev->dev.fwnode = fwnode_handle_get(fwnode);
> +	pdev->dev.of_node = to_of_node(fwnode);

	device_set_node(&pdev->dev, fwnode_handle_get(fwnode));

>  }

...

>  	pdev->dev.parent = pdevinfo->parent;
> -	pdev->dev.fwnode = pdevinfo->fwnode;
> -	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));

> +	pdev->dev.fwnode = fwnode_handle_get(pdevinfo->fwnode);
> +	pdev->dev.of_node = to_of_node(pdev->dev.fwnode);

See above.

...

With them being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


