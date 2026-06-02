Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3475CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442AB10F620;
	Tue,  2 Jun 2026 21:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GJ5oML5+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967DA10F620;
 Tue,  2 Jun 2026 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780437190; x=1811973190;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=U2Ci0y5zstQSqkf04hmNdjkbNsyqDpkboO1KnVKRMOs=;
 b=GJ5oML5+Ctf884JcW1blm6+nWVqkMp6/FtaDmKyQ/ybFUyx0PKyeAtEE
 ywaouyI5kVYEalzUFtMG8RsIFr+sdr2pbaJdQXKCNIYvMjqIwq+tOGPJM
 7zSGvPCj5rlvtQIq+4wLFIlC77g2aDXxSs1KJKHZx5kOmMiBnLsnGXcft
 4dXmPtDCR8aQtkb/5vbRellpC+6SL09v3fGXwrx6JUulu+leVpF5ikJjn
 2IlgQN+HVDH/n3Iz+mVyzMVeRopsnZwciC8hkOecW/6iMnBl1JiFU2dWz
 Ba0gfsl4gMkUfnYkVclcALbrIVfucMFAW/EcEwGxUMjFVWnKqbPsebAcG g==;
X-CSE-ConnectionGUID: Wz/C8NNBSmamp4v1fZWL6Q==
X-CSE-MsgGUID: WjmwYkHZSaCshod29/1rSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81139235"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="81139235"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 14:53:09 -0700
X-CSE-ConnectionGUID: YYc13f2oRhu39dVGUvMdoA==
X-CSE-MsgGUID: IznHTBKXQ4W8nlCW1v1K1g==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.116])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 14:52:54 -0700
Date: Wed, 3 Jun 2026 00:52:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH 22/23] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
Message-ID: <ah9QtExF2rUUTMNo@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
 <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
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

On Tue, Jun 02, 2026 at 10:24:41AM +0200, Philipp Zabel wrote:
> On Do, 2026-05-21 at 10:36 +0200, Bartosz Golaszewski wrote:
> > Ahead of reworking the reference counting logic for platform devices,
> > encapsulate the assignment of the OF node from another device for
> > dynamically allocated platform devices with the provided helper.

...

> > -	device_set_of_node_from_dev(&vdev->dev, dev);
> > +	platform_device_set_of_node_from_dev(vdev, dev);

Same Q here, why it uses inherited call? Cargo cult?

'reused' flag is solely pin control (provider!) thingy as far as I remember.

-- 
With Best Regards,
Andy Shevchenko


