Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E345CCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B9F10E9B5;
	Tue, 16 Jun 2026 09:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iHSt0Rt/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD4110E684;
 Tue, 16 Jun 2026 09:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781603356; x=1813139356;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jiLEocxNQBK6GjMpzXPf7ZOCUOSYAPAZ38ELX1lscIw=;
 b=iHSt0Rt/rBIbpqXsBkWlC4QDA75MPkQ4zAQ/X1atbbGyc4C8w9zgl4m7
 gIzRrD5UYpjacYWlr+2cqtuTMc/SMIVavqhO01+vbiZmNYuDlx2Is5+sD
 qW/g/LKiyD15nqPsagiRosgIMCHyAErzFF20mNV56p0aYy8/d+4wvmBpe
 OqN95KoClpY4vxjp1sGYg2kMVW1Yvjn5OFGjkKBnYQd4k/oo/VmuwbfHR
 aT+HdQcVH+YezSEaojnVRegBrOqHcwFXBMu6oXF9f6zmMbOGC6UW2O4eO
 7JUW7Sgb/HJ1xGlQsDJ+ru+f0i3wISsN2DaDSf5nRvhDallWrNrUBIMVF A==;
X-CSE-ConnectionGUID: D2jOG2bbTcGKK0WTupdZRg==
X-CSE-MsgGUID: Nvy1+9orRzuSDCCJi+hWNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86265563"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="86265563"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 02:49:15 -0700
X-CSE-ConnectionGUID: PsDbiwgJQOK0qFPdNMiIBg==
X-CSE-MsgGUID: FmU0ORA5TbecfDzPUgOXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="246844027"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa010.jf.intel.com with ESMTP; 16 Jun 2026 02:49:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 6626895; Tue, 16 Jun 2026 11:49:02 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:49:02 +0200
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
 platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
Message-ID: <ajEcDq0S067wMFaK@black.igk.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
 <ah9OIVyrHEhcMHzN@ashevche-desk.local>
 <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Thu, Jun 04, 2026 at 05:32:27AM -0700, Bartosz Golaszewski wrote:
> On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
> >> Provide a helper function encapsulating the logic of assigning firmware
> >> nodes to platform devices created with platform_device_alloc(). Make the
> >> kerneldoc state that this is the proper interface for assigning firmware
> >> nodes to dynamically allocated platform devices. This will allow us to
> >> switch to counting the references of the device's firmware nodes in the
> >> future, not only the OF nodes.
> >
> > But why different for of_node and fwnode to begin with?!
> 
> I'm not following. What are you suggesting?

After re-reading of this thread, I think I'm suggesting the same what you have
in plans to do in the future as you put it as "This will allow us to switch to
counting the references of the device's firmware nodes in the future, not only
the OF nodes."

// Offtopic
I haven't heard from you for more than a month on this:
https://lore.kernel.org/r/af18zdP5HF3_P9Vo@black.igk.intel.com
Anything should I do? Please, answer to that thread.

-- 
With Best Regards,
Andy Shevchenko


