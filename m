Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ADCC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 23:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6126710E134;
	Mon, 29 Jun 2026 23:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ot0qqQP/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C2D10E112;
 Mon, 29 Jun 2026 23:15:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1A2D40AA3;
 Mon, 29 Jun 2026 23:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4810E1F000E9;
 Mon, 29 Jun 2026 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782774920;
 bh=PTDwVtGU6wid+Bgktvqm3ZvyMDN9HQ00NiQBzjMDb5o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ot0qqQP/lCjO5k6zzU+QNvbWLaxMC7H+3qFT92VX2UvZABSNZ6N/MA2JGDbKJUoW1
 4M3ANFO3DORGIYjuAUU/OKyDgSRndVEow6+eo7gKf5g+h6Nta8gSgEIp649T4tfv2a
 8Ktiv40iRLVXohmb+zQ3jkItGTS3vZB6ZyGiV6EAadMM+RSY9n/MsJxwkhpr50kHGz
 K31LH0XcB6aN8eoHIi7kAdwqtv4A2jLe1FlUnosYLazPLozsAtx0LBNaD3AJjzlXwS
 /WnVFsJ7hsxiDjHHixfIDpBA9qNUdqfbiOjfquNqtwGGDI5/40gxsVd0QLBzUBZA0k
 MY+MvMrB9YDBw==
Date: Mon, 29 Jun 2026 16:15:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown
 <broonie@opensource.wolfsonmicro.com>, Thierry Reding
 <thierry.reding@avionic-design.de>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla
 <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod
 Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger
 <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, Paul Cercueil
 <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, Hans de
 Goede <hansg@kernel.org>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 09/19] net: bcmgenet: use platform_device_set_of_node()
Message-ID: <20260629161517.34754824@kernel.org>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 29 Jun 2026 11:12:32 +0200 Bartosz Golaszewski wrote:
> +	if (dn) {
> +		struct device_node *np __free(device_node) = bcmgenet_mii_of_find_mdio(priv);
> +
> +		platform_device_set_of_node(ppdev, np);
> +	} else {

Please don't blindly use __free() in cases where it's clearly
unnecessary.
