Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D0CD6E6E
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 01:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D2E11A3A9;
	Fri,  5 Jun 2026 01:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y3Bvc45C";
	dkim-atps=neutral
Received: from mail-m1040.netease.com (mail-m1040.netease.com [154.81.10.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CE111A3A9
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 01:59:30 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 412827f77;
 Fri, 5 Jun 2026 09:59:26 +0800 (GMT+08:00)
Message-ID: <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
Date: Fri, 5 Jun 2026 09:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Midgy BALON <midgy971@gmail.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260604135255.62682-1-midgy971@gmail.com>
 <20260604135255.62682-7-midgy971@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260604135255.62682-7-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e9581b64203a7kunm811ff8bb36f5c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUtDVk1PTUMZSk1LSElDTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Y3Bvc45CIW1NaueqHEUkrrc13tHP57PqG6D2cUlho677APrf8hPJYnVsf6QyD0Zk7yVvbfA0ZPSedpeaoQA52ct4LgKHetxAmjcdQmZWwmJ+EqDR7sdzv54ClZGO6nzhL/GGcQNa0SaMChUshrzbZtTRabCXibPw3II/YdwRamU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=JhwLEVlbuMyJ2TM379GNJ3NbYdaquaVpgzGyK/FsXPQ=;
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

Hello Midgy,

On 6/4/2026 9:52 PM, Midgy BALON wrote:
> On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
> auto clock-gating of the page-table walker, so the walker's AXI master
> loses its clock between transactions; a TLB-miss page walk then never
> completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).
> 
> Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
> so the walker keeps its clock. This is required for the RK3568 NPU MMU.
> 
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4da80136933c4..e3d8b6e9ca12b 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>  
>  	ret = rk_iommu_enable_paging(iommu);
>  
> +	if (!ret) {
> +		/*
> +		 * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page-walker
> +		 * auto clock-gating; the walker's AXI master then loses its clock
> +		 * between transactions and a TLB-miss page walk never completes,
> +		 * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE).  Clear
> +		 * bit 1 (keep bit 0, the slave-port gate) once paging is enabled.
> +		 */
> +		for (i = 0; i < iommu->num_mmu; i++)
> +			rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, 0x2);
> +	}
> +
>  out_disable_stall:
>  	rk_iommu_disable_stall(iommu);
>  out_disable_clocks:

As I said, it is v2. Could you please try using the code below
instead and see if it works? Thank you.

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0013cf196c57..89e3a83a0251 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -930,6 +930,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
        struct iommu_domain *domain = iommu->domain;
        struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
        int ret, i;
+       u32 auto_gate;
 
        ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
        if (ret)
@@ -948,6 +949,10 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
                               rk_ops->mk_dtentries(rk_domain->dt_dma));
                rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
                rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
+
+               auto_gate = rk_iommu_read(iommu->bases[i], RK_MMU_AUTO_GATING);
+               auto_gate |= BIT(31);
+               rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, auto_gate);
        }
 
        ret = rk_iommu_enable_paging(iommu);

-- 
Best, 
Chaoyi
