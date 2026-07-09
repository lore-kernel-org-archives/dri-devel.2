Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2FCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D712110E02B;
	Thu,  9 Jul 2026 05:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PMF7MIfe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A787C10E02B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 05:41:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 915A9600C3;
 Thu,  9 Jul 2026 05:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE21F000E9;
 Thu,  9 Jul 2026 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783575677;
 bh=GUR46VabSVZbPyehLw4syLT30MNmMe+mudnTx0VnTpA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=PMF7MIfeOb6sPplAJM3ptwtGVrsjDjcmNM8+KBGIZapvBcxEoEW05Z71w8wT7OiCo
 DpyTqd8LBQSOVV2LXf12bv3I6Pc0h9ojZxvVDoieC+rI/KlduqQsbmNYRbApokpMUS
 906x2f5dfccmHGNLaQwrgeNkFJeM+vrwSPjhiXoBgGmr7P/GzXUVoT8b+iN+kTpuYZ
 3miqhB4alxgUPujwFkL9mVwHxHABNpvGLd+MKygFosR17bCiXd9AFhTno3Tpzpr8G2
 W04sec2rt03zdANmLtdpyqOtx7Xh3Wl/PfkGMSLLD5Y/7X7CmPps6HOirGFsnoRUm/
 YRXFW3BE6RuOQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>, 
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, 
 Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Jiri Kosina <jikos@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Zhou Wang <wangzhou1@hisilicon.com>, Longfang Liu <liulongfang@huawei.com>, 
 Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, 
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, Will Deacon <will@kernel.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Srujana Challa <schalla@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Antoine Tenart <atenart@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Raag Jadav <raag.jadav@intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Robert Richter <rric@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, 
 Tomasz Jeznach <tomasz.jeznach@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-i3c@lists.infradead.org, 
 dmaengine@vger.kernel.org, Philipp Stanner <phasta@kernel.org>, 
 netdev@vger.kernel.org, nic_swsd@realtek.com, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-cxl@vger.kernel.org, linux-crypto@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, 
 mhi@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 linux-spi@vger.kernel.org, Jonathan Derrick <jonathan.derrick@linux.dev>, 
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
 linux-mmc@vger.kernel.org
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: (subset) [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector
 management by removing devres auto-free
Message-Id: <178357565325.731734.7291964273199898845.b4-ty@b4>
Date: Thu, 09 Jul 2026 07:40:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
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


On Mon, 23 Feb 2026 23:29:39 +0800, Shawn Lin wrote:
> This patch series addresses a long-standing design issue in the PCI/MSI
> subsystem where the implicit, automatic management of IRQ vectors by
> the devres framework conflicts with explicit driver cleanup, creating
> ambiguity and potential resource management bugs.
> 
> ==== The Problem: Implicit vs. Explicit Management ====
> Historically, `pcim_enable_device()` not only manages standard PCI resources
> (BARs) via devres but also implicitly triggers automatic IRQ vector management
> by setting a flag that registers `pcim_msi_release()` as a cleanup action.
> 
> [...]

Applied, thanks!

[13/37] bus: mhi: host: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
        commit: 256995e80fcd39cab94eee8135dd90f6da6ac744

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


