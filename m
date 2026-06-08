Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DD7CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A3D10EDB4;
	Mon,  8 Jun 2026 06:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L1813wxY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF69710EDBF;
 Mon,  8 Jun 2026 06:53:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 313B943A31;
 Mon,  8 Jun 2026 06:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2AF1F00893;
 Mon,  8 Jun 2026 06:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780901583;
 bh=havdYnCEiwh5vTCKe1DHbkaoT5AWDXTLJ1Y7Ln7iWgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=L1813wxYCSG23bMqgH0ctBCaj9Bpvn+Mzei1rNqsq0WCcwGOsXm6XM2KGxAXsFIYY
 PNDm8BVVIy+mxZVPKU4wVu6h4p0KPjoC1XxutYgkz/tkmmhAG8rVrOOKTNPIdmEki7
 ZhxSUdrBlMWLeL8QBDbyNq9XDMsiOMNBfZ2GhLV/YwyVuA/eN004Tel/YWmS0caTVI
 1Ki3J3QunXEpB3QhQYJVMtlF0mA4AxTKTG00ZLd+5TQtr+P/xrxmp+UI8GKHBADra+
 51Vuz5yLHqFvIOweKB/4wkDinKL1buqvy1wE9fbYOVn6sWyc24920VQdY8amOd7RLf
 3b6jOlh5wB1iw==
Received: from johan by xi.lan with local (Exim 4.99.3)
 (envelope-from <johan@kernel.org>) id 1wWTr1-00000000Lrw-2QFM;
 Mon, 08 Jun 2026 08:52:59 +0200
Date: Mon, 8 Jun 2026 08:52:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
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
Subject: Re: [PATCH 22/23] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
Message-ID: <aiZmy1lxcYzMF78e@hovoldconsulting.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
 <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
 <ah9QtExF2rUUTMNo@ashevche-desk.local>
 <aiK-qZqpuC-OEigf@hovoldconsulting.com>
 <aiLjE0SLwrDytyw0@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLjE0SLwrDytyw0@ashevche-desk.local>
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

On Fri, Jun 05, 2026 at 05:54:11PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 02:18:49PM +0200, Johan Hovold wrote:
> > On Wed, Jun 03, 2026 at 12:52:52AM +0300, Andy Shevchenko wrote:
> > > On Tue, Jun 02, 2026 at 10:24:41AM +0200, Philipp Zabel wrote:
> > > > On Do, 2026-05-21 at 10:36 +0200, Bartosz Golaszewski wrote:
> 
> ...
> 
> > > > > -	device_set_of_node_from_dev(&vdev->dev, dev);
> > > > > +	platform_device_set_of_node_from_dev(vdev, dev);
> > > 
> > > Same Q here, why it uses inherited call? Cargo cult?
> > > 
> > > 'reused' flag is solely pin control (provider!) thingy as far as I remember.
> > 
> > No, it's needed for pin control *consumers*, which can be any device,
> > and potentially any other resource managed by driver core or bus code.
> 
> Why don't we set it for every pin control consumer automatically?

It must only be set on the second (child) one to prevent driver core
from trying to acquire resources already claimed by the parent.

Setting it on both would break things.

Johan
