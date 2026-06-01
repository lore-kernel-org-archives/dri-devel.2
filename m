Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED07CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 23:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1C410EA6F;
	Mon,  1 Jun 2026 23:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bwFeM+dK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A4B10EA6C;
 Mon,  1 Jun 2026 23:35:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2AA7419E3;
 Mon,  1 Jun 2026 23:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5639F1F00893;
 Mon,  1 Jun 2026 23:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780356949;
 bh=BsNyXchE0cQ+WrTEzbPCgdBZhaTxYz8ZYh6ODfO6Thc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bwFeM+dKJids5MGHkWeT2lqLmOE+Z22fpYZVG8IarCaPIkYd1ClJLTF0P+KK4TZC1
 t1HfBIbIgLm2lF9d6SD2H1GRY5GUIy6SJwL9v8EZ3L20jIK/NaVXSt1XPTueO0oIGy
 y19iXABriAlFUODdDTo2f2+FK6UaosZlP/s7kW+eWFj9kPjNXvxZUpQLix9fiYAVMs
 qutOmIhrfL9fMTHLsw3ErfIZs150qZpCJg1stHoIzdshVCQp8iYW9sI4ko81gCNtbL
 eRcz3oBpBUe09WQM6FxiPQKCgb0o3dANEdBD5y5Egf4yKaQOgk8QwaFZYGWRDLloCl
 38TEpySFeTuzg==
Date: Mon, 1 Jun 2026 18:35:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Doug Berger <opendmb@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Bin Liu <b-liu@ti.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, brgl@kernel.org,
 Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
 David Airlie <airlied@gmail.com>, linux-arm-msm@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 Ulf Hansson <ulfh@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 intel-xe@lists.freedesktop.org, Andi Shyti <andi.shyti@kernel.org>,
 linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org,
 linux-sound@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
 linux-mips@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 driver-core@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 imx@lists.linux.dev, Vinod Koul <vkoul@kernel.org>,
 Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Robin Murphy <robin.murphy@arm.com>, Frank Li <Frank.Li@nxp.com>,
 devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Saravana Kannan <saravanak@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, linux-pm@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 09/23] of: platform: use platform_device_set_of_node()
Message-ID: <178035694685.195552.1114165096275774254.robh@kernel.org>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>
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


On Thu, 21 May 2026 10:36:32 +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

