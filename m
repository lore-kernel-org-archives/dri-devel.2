Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2027CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A69010EDE1;
	Mon,  8 Jun 2026 07:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ds8FYyBn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070D010EDD5;
 Mon,  8 Jun 2026 07:03:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8DA242DD2;
 Mon,  8 Jun 2026 07:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A31F0089A;
 Mon,  8 Jun 2026 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780902185;
 bh=10dFrUC/6z32jGP8zynGCsubM/uQN+Pn4UzSAjajejM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ds8FYyBnv2B771u4jaYArIjXJx5UpC1WUxFyjTQDVhtf+l1qYyu5NwqVY+oOzuc6C
 YgqUxqU4gV2VnsPffdjORqDHElM1kd63ltUYUyVdF4TYaUEWtF2JD2pU6poVM1ArWL
 lMUinVJ6futH/7sdnAjzkFIuaCbufZx8fG+uk80ePL2EOH8cH49KxCDKv1sJ8txsUy
 Qpsb63Y/49p0ZHrtiY6ZwtKegiVpiUrgHwkrzV4CAq0F0zJwJnRUTZXAStb/+L2/kr
 FA/3lev2TYsrVndJqyIIwBECwbTBWrmYCkIgZRjk+HnLbC8Mzg1CGk5xkLhbQhHDnH
 KQOX+wjtpEfGA==
Received: from johan by xi.lan with local (Exim 4.99.3)
 (envelope-from <johan@kernel.org>) id 1wWU0k-00000000LzQ-1V0O;
 Mon, 08 Jun 2026 09:03:02 +0200
Date: Mon, 8 Jun 2026 09:03:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Message-ID: <aiZpJkQBXg2pcczy@hovoldconsulting.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
 <aiK-EXwp_xhcbty9@hovoldconsulting.com>
 <aiLi0KZskrCyEYO5@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLi0KZskrCyEYO5@ashevche-desk.local>
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

On Fri, Jun 05, 2026 at 05:53:04PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 02:16:17PM +0200, Johan Hovold wrote:
> > On Wed, Jun 03, 2026 at 12:44:55AM +0300, Andy Shevchenko wrote:
> > > On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> > > > Provide a platform-specific variant of device_set_of_node_from_dev(). In
> > > > addition to bumping the reference count of the OF node being assigned,
> > > > it also assigns the fwnode of the platform device.
> > > 
> > > Can we rather investigate the way how to make that of node reuse thingy
> > > (which is used solely by pin control) differently and then drop this confusing
> > > device_set_of_node_from_dev() call altogether?
> > 
> > No, that call is needed. See commit 4e75e1d7dac9 ("driver core: add
> > helper to reuse a device-tree node") for details.
> 
> Bart fixes the problem with the platform driver. At the result this will be
> the only device_set_node() + 'reused = true'.  As for 'reused' flag, the need
> is only for pinmux/pin control stuff.

And any other resource which may (eventually) be claimed by driver core
or bus code.

> The question here is if there is a better
> way to make that 'reused' be done automatically without need of setting some
> flag explicitly.

That's not really relevant to the series at hand.

If this is something we want to merge then you need to continue setting
the flag in order not to cause regressions.

Johan
