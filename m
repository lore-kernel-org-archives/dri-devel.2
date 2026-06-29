Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E1C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0568F10E988;
	Mon, 29 Jun 2026 16:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OZidQczZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8883D10E2C8;
 Mon, 29 Jun 2026 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782750196; x=1814286196;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=60Kkhn1S4xFp8KF1ZAF46WPmvC0pF6KOvaZqQh2Mlf4=;
 b=OZidQczZx8P1Vo1Xs+EgC9oVEH+HS3OI/1r8KI2aLZljAIhr5r29CPvP
 fPyhEGqQK5Ck1cue2yJKQWs8l65/IKe50DwaNTk6PQW5pJWD4PwPVo5Bi
 jG+btG192ssMAKVka6mPYAOi39hdkIUnsP9S1Hlf0k4pDsCu1deH7Ug9s
 yO1WkR8C/B4uvOgGQZA1jxgagRDY+4fQDdnq0Hlp+6Yu/OzoscAakHEeF
 GtxTyIlFaaQKufCiyypLxbn4ZGc4R3IBxu5OR14sZYLvFykWqxfBSz5Kq
 +YoLxQFsQVEdHshYRR8QyDI6IwIxkY7Grrxkm7aC3dhkhu1WFWLyCROcm w==;
X-CSE-ConnectionGUID: Wf/Z+a6bRziUGyTcRQSnRA==
X-CSE-MsgGUID: ul1f/wOcQleTeWvokiJf8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83476035"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="83476035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 09:23:15 -0700
X-CSE-ConnectionGUID: tfo8W8J/QcSmRxl6mSfrug==
X-CSE-MsgGUID: qa+c086/QemtMiZKLSzfAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="256920930"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.207])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 09:23:02 -0700
Date: Mon, 29 Jun 2026 19:23:00 +0300
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
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2 00/19] driver core: count references of the platform
 device's fwnode, not OF node
Message-ID: <akKb5LPBIMenF9yD@ashevche-desk.local>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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

On Mon, Jun 29, 2026 at 11:12:23AM +0200, Bartosz Golaszewski wrote:
> Platform device core provides helper interfaces for dealing with
> dynamically created platform devices. Most users should use
> platform_device_register_full() which encapsulates most of the
> operations but some modules will want to use the split approach of
> calling platform_device_alloc() + platform_device_add() separately for
> various reasons.
> 
> With many platform devices now using dynamic software nodes as their
> primary firmware nodes and with the platform device interface being
> extended to also better cover the use-cases of secondary software nodes,
> I believe it makes sense to switch to counting the references of all
> kinds of firmware nodes.
> 
> To that end, I identified all users of platform_device_alloc() that also
> assign dev.of_node or dev.fwnode manually. I noticed five cases where
> the references are not increased as they should (patches 1-5 fix these
> users) and provided three new functions in platform_device.h that now
> become the preferred interfaces for assigning firmware nodes to dynamic
> platform devices (in line with platform_device_add_data(),
> platform_device_add_resources(), etc.). The bulk of the patches in this
> series are small driver conversions to port all users to going through
> the new functions that now encapsulate the refcount logic. With that
> done, the final patch seamlessly switches to counting the references of
> all firmware node types.
> 
> This effort is prerequisite of removing platform_device_release_full()
> and unifying the release path for dynamic platform devices using
> unmanaged software nodes.
> 
> Merging strategy: The entire series should go through the driver core
> tree, possibly with an immutable branch provided to solve any potential
> conflicts though these are rather unlikely.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for patches 2-4 assuming they will be accompanied with patch 19 at the same
time.

-- 
With Best Regards,
Andy Shevchenko


