Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB7C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2AE10F4DF;
	Fri, 17 Jul 2026 10:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ofxz/03T";
	dkim-atps=neutral
Received: from mail-m2460.xmail.ntesmail.com (mail-m2460.xmail.ntesmail.com
 [45.195.24.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C0F10F4DF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:19:42 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46969559a;
 Fri, 17 Jul 2026 18:19:38 +0800 (GMT+08:00)
Message-ID: <b921b071-4187-4e53-b4c4-69bab0cea278@rock-chips.com>
Date: Fri, 17 Jul 2026 18:19:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/9] iommu/rockchip: take all DT clocks
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-7-gahing@gahingwoo.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260717085220.3212274-7-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9f6f96c23c09dakunm3c6aa1ca9c9ec
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUNJVhpKGUNOH01DTU0YTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Ofxz/03TjZrHZN71x5wg4XZHSMeVGRnlrU/saD9oYpiWkJcbrwu8PUBFz4i6f/7AfPCtqiloFRJ/dR1AFHyEt/vJnbU5WcnJGz5SvvKEpeu0TbHXMGbYur+AMN+8jKWl0YfCwqftKasqgtgZb1qP8Ga/bvcekMhsS/bohnLNUbU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=fukq5CudpGBKu5jdyMM5vf8cGCrXvOss1I+wnUPLRAc=;
 h=date:mime-version:subject:message-id:from;
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

Hello Jiaxing,

On 7/17/2026 4:50 PM, Jiaxing Hu wrote:
> rk_iommu only enabled a fixed {aclk,iface} pair. On the RK3576 NPU the
> MMU sits behind the CBUF/DSU gates, so writes to DTE_ADDR are silently
> dropped until those clocks run too (reads work, writes need more clocks).
> Take every clock described in the DT for the IOMMU instead of a fixed
> pair, so a platform can list the full set it needs.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index ce586919b..49c841095 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -93,11 +93,6 @@ struct rk_iommu_domain {
>  	struct iommu_domain domain;
>  };
>  
> -/* list of clocks required by IOMMU */
> -static const char * const rk_iommu_clocks[] = {
> -	"aclk", "iface",
> -};
> -
>  struct rk_iommu_ops {
>  	phys_addr_t (*pt_address)(u32 dte);
>  	u32 (*mk_dtentries)(dma_addr_t pt_dma);
> @@ -1274,25 +1269,20 @@ static int rk_iommu_probe(struct platform_device *pdev)
>  	iommu->reset_disabled = device_property_read_bool(dev,
>  					"rockchip,disable-mmu-reset");
>  
> -	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
> -	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
> -				     sizeof(*iommu->clocks), GFP_KERNEL);
> -	if (!iommu->clocks)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < iommu->num_clocks; ++i)
> -		iommu->clocks[i].id = rk_iommu_clocks[i];
> -
>  	/*
> -	 * iommu clocks should be present for all new devices and devicetrees
> -	 * but there are older devicetrees without clocks out in the wild.
> -	 * So clocks as optional for the time being.
> +	 * Take every clock the devicetree provides.  Most IOMMU instances
> +	 * need exactly "aclk" + "iface", but e.g. the RK3576 NPU IOMMUs sit
> +	 * behind additional gates (CBUF/DSU) whose clocks must be running
> +	 * for register writes to land.  Clocks stay optional because there
> +	 * are older devicetrees without clocks out in the wild.
>  	 */

It does not seem necessary to modify the comments, as there are indeed
many MMUs with multiple clocks :)

> -	err = devm_clk_bulk_get(iommu->dev, iommu->num_clocks, iommu->clocks);
> -	if (err == -ENOENT)
> +	err = devm_clk_bulk_get_all(iommu->dev, &iommu->clocks);
> +	if (err == -ENOENT || err == 0)
>  		iommu->num_clocks = 0;

err == 0 is redundant.

> -	else if (err)
> +	else if (err < 0)
>  		return err;
> +	else
> +		iommu->num_clocks = err;
>  
>  	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
>  	if (err)

-- 
Best, 
Chaoyi
