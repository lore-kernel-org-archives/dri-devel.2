Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9EDFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119F110E428;
	Tue,  5 May 2026 16:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P3c57A43";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC13310E428;
 Tue,  5 May 2026 16:26:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EC0740403;
 Tue,  5 May 2026 16:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7D5C2BCB4;
 Tue,  5 May 2026 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777998391;
 bh=d9oRhAaRGwydDiDuK7BhCRvRWDp8pOBlU9+d0qcoLXY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=P3c57A43Ly9U95oakv1tzSfsBDMAQvbGX3L5fDur0PPxN8g/BkGWOrF0IQ1vnb8kn
 q5FpFULXXt5CFm8Sy/qdB+pGfZ+595OPQ/+H2h/dpiAmaAvc14vlTx4Z7a774smhAG
 mRi8mWrUgi+n3TQ7klBwMiCHYz3eCKtTXeoo5Vugwd9W8wFUQWC/qxp4tUJmAVvLgS
 jHSgvFYD9WkXPVvCXJZvfwe/RjozMVbFHi4OoCu3mLeSQZDLHCSt79QQSlDeG2UmtL
 GPSyoqLckepvJjFkRnrQa3yfyKh+iIz18B0bEQzeLYkJERNnopW8hE0+mQWVZV5SLC
 bwYA1sJR8mQqw==
Date: Tue, 5 May 2026 11:26:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manikandan K Pillai <mpillai@cadence.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: Re: [PATCH v8 phy-next 01/31] PCI: cadence: Preserve all error codes
 in cdns_plat_pcie_probe()
Message-ID: <20260505162629.GA734488@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505100523.1922388-2-vladimir.oltean@nxp.com>
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

[+cc Tom, author of bd22885aa188 in case there's something subtle here]

On Tue, May 05, 2026 at 01:04:53PM +0300, Vladimir Oltean wrote:
> The blamed commit functionally changed the error path of
> cdns_pcie_host_probe(), now cdns_plat_pcie_probe().
> 
> When the old code path executed "goto err_get_sync", the PCIe controller
> probe function propagated the pm_runtime_get_sync() error code. The new
> code doesn't, and returns 0.
> 
> Similarly for the "goto err_init" previously triggered by
> cdns_pcie_host_init() errors, and now triggered by
> cdns_pcie_host_setup() and cdns_pcie_ep_setup() errors. These are not
> propagated and will result in probing success, which is incorrect.
> 
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manikandan K Pillai <mpillai@cadence.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>

I guess this driver is orphaned.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> v7->v8: patch is new, issue was flagged by Sashiko
> https://sashiko.dev/#/patchset/20260430110652.558622-1-vladimir.oltean@nxp.com
> ---
>  drivers/pci/controller/cadence/pcie-cadence-plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index b067a3296dd3..8b12a46b5601 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -126,7 +126,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	while (phy_count--)
>  		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
>  
> -	return 0;
> +	return ret;

This affects cases where pm_runtime_get_sync(),
cdns_pcie_host_setup(), or cdns_pcie_ep_setup() return failure.

Seems right to me to fail the probe when these fail.

Not all users of pm_runtime_get_sync() check for failure, but I think
all the other controller drivers that do check return failures from
the .probe().

>  }
>  
>  static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
> -- 
> 2.34.1
> 
