Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A750ACD6E76
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049E41127D9;
	Thu,  4 Jun 2026 12:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cqf3MXV4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC306113FC4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:32:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6576044651
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7E71F00899
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780576350;
 bh=LnrtZB0iEg1z1vGOmrpOOK3Cssie/DMPDNqDCPjTdS8=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=Cqf3MXV4TD52LTrKp0CEYIe9g985jGUSnNRQCoaqoWqlQrEUsixL6taFahNCfDLy3
 +Z6as+OOsL9nqoix/FyXeZFm2nSqFAgKe0UdZ200LCLfCzZOsL9e5aeERkfHQuCGQt
 lbsQ7bKitUjPcn+bHj0GDLNxKoY1a2sN6xy3To0Q9KFC5vgDE0UO/KlEqKmvCmGo2q
 tQFH3C8Z7JCY1CQ0ki8z08Rb6/Be/+yEVtXg1G5zNpIwheU8ILhcBZYHgFoWppCuwE
 gB2HgfLQ286akIY4m3Bo3GCPaJEmZyP191eGzCBLL04xi+/lRCrQ3eZvv7giv/r8Wv
 S0m1gGv5CNe1w==
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3967726bc47so6100341fa.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:32:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9a+E3fdToSE0To3g0ya0tTvVfemaaW51+NE7/yP9kN/KsoV6OJs+ZKcnRf/cXL1vhxENitehNwCMw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRrL8TrkWfMcwwRVeeNeC05ohJO5jzCtgUFzHFB71Gqxil86SL
 ipREYMRrjAl8kCI0Dw+97XTatJkOx0BN8Z0+L9UN/YSnmAlXcBtArC5lfkc/32//pk+sG+bNbcv
 jyKkwZfiPSo+ya33fRiff3CM7rrpqYpMYQqO1eMXVEw==
X-Received: by 2002:a2e:bc24:0:b0:396:9cbb:673e with SMTP id
 38308e7fff4ca-396af48a101mr25033101fa.24.1780576348691; Thu, 04 Jun 2026
 05:32:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:32:27 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:32:27 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9OIVyrHEhcMHzN@ashevche-desk.local>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
 <ah9OIVyrHEhcMHzN@ashevche-desk.local>
Date: Thu, 4 Jun 2026 05:32:27 -0700
X-Gmail-Original-Message-ID: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
X-Gm-Features: AVHnY4LlXi8ln45MTUjJfpd_YWjp19dT0a-H21-M7Hc7IKBiGWRxgS3l-OaDEEQ
Message-ID: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Subject: Re: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Ulf Hansson <ulfh@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
>> Provide a helper function encapsulating the logic of assigning firmware
>> nodes to platform devices created with platform_device_alloc(). Make the
>> kerneldoc state that this is the proper interface for assigning firmware
>> nodes to dynamically allocated platform devices. This will allow us to
>> switch to counting the references of the device's firmware nodes in the
>> future, not only the OF nodes.
>
> But why different for of_node and fwnode to begin with?!
>

I'm not following. What are you suggesting?

Bartosz
