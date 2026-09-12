Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F00C88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C720A10E374;
	Sat, 12 Sep 2026 07:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MFp+mLuB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F8C10E374
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:22:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2AD2600D4;
 Sat, 12 Sep 2026 07:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390FB1F000FF;
 Sat, 12 Sep 2026 07:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789197737;
 bh=ceAkGjp0+Uny6h95sQ8LyWRvR6nOs9CTcdhKkM9xRzw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MFp+mLuBbGeGFW/fU8zEgFm0rzOoBq/LCApHbfwJ68ttLMRyNaGs8rlbPNX04gYOp
 hHsTrH/245vP36ivqN+OX4ikKoZrkBvzoIXfOTlVN8gJmdR5Kfy8Q7y/OJPXYEczbW
 H3wB2aerwe0Wkphkv/Vzo/gBlCD8dTVviBivYHEDb3m5eMjXrYq/pw2ggsvQbJSWFn
 SQPObhcKKOVD3w8l8F4aq57LBLDqLEIjp+gpM/YDrOl0xTljh/NsLW5AJKiAtziV8o
 JSSB10a1gx9Ss19J0QlDDckzdGzeS66LCmE/sdc+hx5r4EaWdyx2TbQCs2BLhHSpHX
 SnFUONUFd0G+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 12/14] accel/rocket: add RK3576 NPU (RKNN) support
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260912065053.1519165-13-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-13-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:22:16 +0000
Message-Id: <20260912072217.390FB1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver improperly tracks active RKNN cores using a sequent=
ial counter (`rdev->num_cores`) to index into the fixed-size `rdev->cores` =
array. Unbinding a core decrements the counter without shifting array eleme=
nts, causing subsequent binds to overwrite active core structures and leadi=
ng to skipped cleanup (use-after-free) and driver state corruption.
- [High] 64-bit IOVA task->regcmd is silently truncated to 32 bits, despite=
 40-bit DMA mask.
--

commit f9d20327e89caf3b9bf4ada2ba21cb2dc6201353
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: add RK3576 NPU (RKNN) support

This commit adds support for the RK3576 NPU by introducing new SoC-specific
definitions, clock/reset handling, PM domains, and adapting hardware task
control structures.

Link: https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock=
-chips.com/

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
[ ... ]
> @@ -231,13 +231,23 @@ static void rocket_remove(struct platform_device *p=
dev)
>  static const struct rocket_soc_data rk3588_soc_data =3D {
>  	.num_clks =3D 4,
>  	.num_resets =3D 2,
> +	.multi_power_domain =3D false,
> +	.task_con_16bit =3D false,
>  };
> =20
> -static const struct of_device_id dt_match[] =3D {
> +static const struct rocket_soc_data rk3576_soc_data =3D {
> +	.num_clks =3D 6,
> +	.num_resets =3D 1,
> +	.multi_power_domain =3D true,
> +	.task_con_16bit =3D true,
> +};
> +
> +const struct of_device_id rocket_dt_match[] =3D {
>  	{ .compatible =3D "rockchip,rk3588-rknn-core", .data =3D &rk3588_soc_da=
ta },
> +	{ .compatible =3D "rockchip,rk3576-rknn-core", .data =3D &rk3576_soc_da=
ta },
>  	{}
>  };
> -MODULE_DEVICE_TABLE(of, dt_match);
> +MODULE_DEVICE_TABLE(of, rocket_dt_match);

[Severity: Critical]
This isn't a bug introduced by this patch, but the way the driver tracks
active RKNN cores using rdev->num_cores appears to have a flaw that can
cause state corruption and a use-after-free.

If multiple cores are probed, and an intermediate core is unbound,
rocket_remove() decrements the counter without shifting the remaining
elements in the rdev->cores array to fill the gap:

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
    ...
    rocket_core_fini(&rdev->cores[core]);
    rdev->num_cores--;
    ...
}

If another core is then probed, rocket_probe() allocates a slot based on the
decremented num_cores, causing the newly bound core to overwrite the
existing, active core structure:

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
    ...
    unsigned int core =3D rdev->num_cores;
    dev_set_drvdata(&pdev->dev, rdev);
    rdev->cores[core].rdev =3D rdev;
    ...
}

When find_core_for_dev() is later called to unbind the overwritten core, it
fails to find it, which aborts rocket_remove() and leaks resources like the
running DRM scheduler thread. Eventually, when the driver is unloaded, the
memory containing the active thread is freed, leading to a use-after-free
crash.

Could we fix the core array management to handle unbinding properly?

[ ... ]
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -142,10 +166,17 @@ static void rocket_job_hw_submit(struct rocket_core=
 *core, struct rocket_job *jo
>  	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INT=
ERRUPT_MASK_DPU_1);
>  	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_I=
NTERRUPT_CLEAR_DPU_1);
> =20
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

[Severity: High]
This is a pre-existing issue, but I noticed there is a potential 32-bit
truncation of a 64-bit IOVA in the hardware submission logic just above this
code in rocket_job_hw_submit().

The driver configures a 40-bit DMA mask in rocket_core_init():

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
    ...
    err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
    ...
}

However, the UAPI struct restricts the IOVA to 32 bits:

include/uapi/drm/rocket_accel.h:drm_rocket_task {
    ...
    __u32 regcmd;
    ...
}

When userspace populates drm_rocket_task.regcmd, the __u32 type silently
truncates addresses greater than 4GB. The kernel then writes this truncated=
=20
address to the 32-bit BASE_ADDRESS hardware register:

drivers/accel/rocket/rocket_job.c:rocket_job_hw_submit() {
    ...
    rocket_pc_writel(core, BASE_ADDRESS, task->regcmd);
    ...
}

Can this lead to IOMMU translation faults, device hangs, or memory corrupti=
on
if an unprivileged userspace process allocates enough memory to receive an
IOVA greater than 4GB?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912065053.1519=
165-1-gahing@gahingwoo.com?part=3D12
