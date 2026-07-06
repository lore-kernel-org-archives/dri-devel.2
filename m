Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921C2C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F5210E2FE;
	Mon,  6 Jul 2026 15:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OPlEALGr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B46F10E2FE;
 Mon,  6 Jul 2026 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783353033; x=1814889033;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=of6d9n1ZVp2VvNBWbeQxrIvJaxz8Dqo4F/lZHKvIDzs=;
 b=OPlEALGrWF45df9+2FGlVfUPxWp8SxgKwB69paHaw0kCZMehRZAJKa49
 AfToyvao7tKoeDFrSN+MiByN+U4DVIm6r/rtVRzeDwbU4QKRSSr+mDHJD
 CqApOvmK2YGnL1NkyFTl/fC50o//q0oQ7RGWEOR4o4v5I8oiFttYqM/qT
 01ybk7uevbJpSKQStwhJ9Tca8jqT9/fwgDbHNRd3xVK3iBoUPJxAwcPBn
 azGba6ubVvK9UdGQsYvdD4khyucQptulRT/f7V6pECQSZbRGG4s+IDsPt
 OkdUgUgEQaNNGfZdvUZdgqvitA560OWxiEZMOh4Q1dk2XSGiB3EV9SJ/O A==;
X-CSE-ConnectionGUID: 33uA0905TlWdniKRsWJO/A==
X-CSE-MsgGUID: itVRqDdjTyebAiyZ5kt1sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="101408849"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="101408849"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 08:50:32 -0700
X-CSE-ConnectionGUID: NvB5N+KWQv+u1kUJ01a6bg==
X-CSE-MsgGUID: ST8IrUj4Qs29+PTwG4IXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="283836189"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.244.48])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 08:50:18 -0700
Date: Mon, 6 Jul 2026 18:49:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manuel Ebner <manuelebner@mailbox.org>, Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>,
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
 platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
Message-ID: <akvOo2EeERLYPh72@ashevche-desk.local>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
 <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
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

On Mon, Jul 06, 2026 at 04:39:00PM +0200, Manuel Ebner wrote:
> On Mon, 2026-07-06 at 14:44 +0200, Bartosz Golaszewski wrote:

> I removed Mark Brown <broonie@opensource.wolfsonmicro.com> from recipients because:
> “RCPT TO <broonie@opensource.wolfsonmicro.com> failed:
> <broonie@opensource.wolfsonmicro.com>: Recipient address rejected: Domain not found”.

Perhaps he needs to send a patch to update .mailmap?
Cc'ed to Mark.

-- 
With Best Regards,
Andy Shevchenko


