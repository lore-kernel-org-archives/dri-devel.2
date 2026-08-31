Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EC8C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFC010E785;
	Mon, 31 Aug 2026 09:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B+VZSEGO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4E210E785
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:11:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35D8143E5E;
 Mon, 31 Aug 2026 09:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51B61F000E9;
 Mon, 31 Aug 2026 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167514;
 bh=dFkIgamocZ5YZRlrVpt65lGeGmrtq4l95mIhklfkei0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B+VZSEGO6oEiMCmt+P/CjLjC+XL1D/aUrCtaewkvxgX/9lqDATQfxFoC+khOpVwtS
 6jxu5upohJbHtK/OmVQblGRkKtPyhZeOwnf17kFRrzdrZVR48KbZIUaLS2a5mSSy9G
 6Hqm7hxjAQzOJjY5qLy20FEQq4pM2oQ7Q94adQwnyvQFXU4fWlez2r/e6KZZvMAU+T
 +2Qki1DR35/VpFajlhZdqhAxz8jhBdUETpOuGv7RTs+Uod0uBbpI1Zhkg+D6gLwGHD
 Z0NDxNYkrj0Q+4Gh6KWiMnZoUzRcTY00zgIJ0khomRcUYVaSgjtes4QgqyNcoFlJ+T
 B6ov7XpVMjKcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/14] accel/rocket: add RK3576 NPU (RKNN) support
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260831081956.84871-13-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-13-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:11:53 +0000
Message-Id: <20260831091153.C51B61F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Shared IRQ handler accesses hardware registers without checking PM=
 state, and runtime suspend lacks synchronize_irq().
- [High] Reference leak of iommu_group in job completion path.
- [High] Array bounds mismatch and logic error in `find_core_for_dev` and c=
ore registration due to naive decrement on device removal.
- [High] Concurrent probe of multiple NPU cores causes data races in global=
 rdev initialization and array management.
- [High] Leaking devm resources on unbound pseudo-device across rebinds or =
`-EPROBE_DEFER`.
- [High] A 64-bit DMA address is truncated to 32 bits when written to the h=
ardware, leading to IOMMU faults if the address exceeds 4GB.
--

commit da7c000fc37b3b36196f66187168ddef41f790b6
Author: Jiaxing Hu <gahing@gahingwoo.com>

    accel/rocket: add RK3576 NPU (RKNN) support
   =20
    The RK3576 has two cores of the same RKNN block and a few platform
    differences:

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/=
rocket_device.c
> index 46e6ee1e72c5f..923add5bdc87e 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -9,6 +9,7 @@
>  #include <linux/of.h>
> =20
>  #include "rocket_device.h"
> +#include "rocket_drv.h"
> =20
>  struct rocket_device *rocket_device_init(struct platform_device *pdev,
>  					 const struct drm_driver *rocket_drm_driver)
> @@ -27,7 +28,11 @@ struct rocket_device *rocket_device_init(struct platfo=
rm_device *pdev,
>  	ddev =3D &rdev->ddev;
>  	dev_set_drvdata(dev, rdev);
> =20

[Severity: High]
This is a pre-existing issue, but does rocket_device_init() leak devm
resources if probe defers or unbinds?

It appears that devm_drm_dev_alloc() is called earlier in this function
and binds the allocation to the persistent global drm_dev instead of the
pdev being probed. If probe defers, or if the cores are unbound,
rocket_remove() simply clears the rdev pointer without freeing the memory
bound to drm_dev, leading to memory leaks on successive probe deferrals.

> -	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
> +	/*
> +	 * Count over the same match table the platform driver binds with, so
> +	 * that a core added there is counted here without a second edit.
> +	 */
> +	for_each_matching_node(core_node, rocket_dt_match)
>  		if (of_device_is_available(core_node))
>  			num_cores++;
> =20

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 6e7dc91c5faac..e469629499fdb 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -217,13 +217,23 @@ static void rocket_remove(struct platform_device *p=
dev)

[Severity: High]
This is a pre-existing issue, but are there concurrent probe data races her=
e?

In rocket_probe(), the global rdev pointer is checked and assigned without
synchronization, and rdev->num_cores is used as an array index concurrently.
If multiple NPU cores are probed concurrently, could this lead to double
initialization or out-of-bounds array accesses?

Additionally, when rocket_remove() executes:

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
    ...
    rdev->num_cores--;
    ...
}

It decrements the active core count without compacting the array.
Could a subsequent bind overwrite active devices and truncate search
boundaries in find_core_for_dev()?

>  static const struct rocket_soc_data rk3588_soc_data =3D {
>  	.num_clks =3D 4,
>  	.num_resets =3D 2,
> +	.multi_power_domain =3D false,
> +	.task_con_16bit =3D false,
>  };
> =20

[ ... ]

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 69e29f40f27a0..2a272c2ef6bed 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this driver safely handle shared IRQs
during runtime suspend?

In rocket_job_irq_handler(), the code unconditionally reads from
INTERRUPT_RAW_STATUS:

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    ...
    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

However, rocket_device_runtime_suspend() disables clocks without calling
synchronize_irq(). Because this uses a shared IRQ line (IRQF_SHARED), if
another device on the same line triggers an interrupt while the NPU is
suspended, could reading these unpowered hardware registers cause a system
hang or external abort?

[Severity: High]
This isn't a bug introduced by this patch, but is there a reference leak of
the IOMMU group in the job completion path?

In rocket_job_next_locked():

drivers/accel/rocket/rocket_job.c:rocket_job_next_locked() {
    ...
    iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

This calls iommu_group_get() inline, which increments the reference count,
but there appears to be no corresponding iommu_group_put(), meaning the
reference is leaked on every job completion.

> @@ -142,10 +165,17 @@ static void rocket_job_hw_submit(struct rocket_core=
 *core, struct rocket_job *jo
>  	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INT=
ERRUPT_MASK_DPU_1);
>  	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_I=
NTERRUPT_CLEAR_DPU_1);
> =20

[Severity: High]
This is a pre-existing issue, but could the DMA address get truncated here?

The driver explicitly asks the IOMMU for up to 40-bit IOVAs via
dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40)) in rocket_core_init().

However, the hardware submission path writes the command buffer address
using a 32-bit register write:

drivers/accel/rocket/rocket_job.c:rocket_job_hw_submit() {
    ...
    rocket_pc_writel(core, BASE_ADDRESS, task->regcmd);
    ...
}

Since task->regcmd is written to a 32-bit hardware register, and userspace
may pass a truncated IOVA, will this cause IOMMU faults if the address exce=
eds
4GB?

> -	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
> -					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
> -					 PC_TASK_CON_TASK_NUMBER(1) |
> -					 PC_TASK_CON_TASK_PP_EN(1));
> +	if (core->soc->task_con_16bit)
> +		rocket_pc_writel(core, TASK_CON,
> +				 RK3576_PC_TASK_CON_LAST_LAYER_CLEAR |
> +				 RK3576_PC_TASK_CON_COUNT_CLEAR |
> +				 RK3576_PC_TASK_CON_PP_EN |
> +				 RK3576_PC_TASK_CON_TASK_NUMBER(1));
> +	else
> +		rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
> +						 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
> +						 PC_TASK_CON_TASK_NUMBER(1) |
> +						 PC_TASK_CON_TASK_PP_EN(1));
> =20
>  	rocket_pc_writel(core, TASK_DMA_BASE_ADDR, PC_TASK_DMA_BASE_ADDR_DMA_BA=
SE_ADDR(0x0));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D12
