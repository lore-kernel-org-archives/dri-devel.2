Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57212CD8CA8
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2184F10E6B3;
	Wed, 10 Jun 2026 03:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iF6hMuRO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FD910E6B3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 03:14:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58D886024D;
 Wed, 10 Jun 2026 03:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EA71F00893;
 Wed, 10 Jun 2026 03:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781061272;
 bh=GQjXN//+atwE/ss6Gjga/XFzoriaO2S8xXgRMLSf8Ww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iF6hMuROWkuiK3I2m+OklwTgpfhDnlZ0hrFCOMtI62DePvdTFlx/yt3js02XhgFW+
 8gSLf2ii4akyH+tAqI5nRnwSNDpju0vfzy1Ff7lJKrEc7WKhhn2hUCJ+ljaoQLl5DB
 drBlxxBU6+gfXxHJf2ySE1bBtPvC4UjKbGfmEqXKB8A63NJ9P4/xceT2/s70i5TDwU
 nO4dCuj6fS/nH7IVXEzWC2vkgF+517eJmVmFdnwwGp0dKXJ+GFfANHGqrh5z5GWjCN
 l9iXuSbhmLv+yexZ/DmdTLGTnf8eoDKa2lwxAAyuoFw4k5d3KxJKf9ZJRed7ouRucL
 U3PCzZD4JFwLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] accel/rocket: Fix iommu_group leak and unsafe
 IRQ register access
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610030322.2802744-2-zhaojinming@uniontech.com>
References: <20260610030322.2802744-2-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 03:14:31 +0000
Message-Id: <20260610031431.E8EA71F00893@smtp.kernel.org>
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

New issues:
- [High] Runtime PM usage counter underflow due to incorrect error handling=
 of `pm_runtime_get_if_active()` in threaded IRQ handler.

Pre-existing issues:
- [High] Returning `IRQ_NONE` for valid DMA error interrupts without cleari=
ng the interrupt status causes a hardirq storm.
--

commit 5d8993f6abe579de7eec7f4c98365e11dd141bf8
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix iommu_group leak and unsafe IRQ register access

This commit fixes an iommu_group reference leak in the IRQ handling path
and introduces runtime PM checks in the IRQ handlers to prevent unsafe
hardware register access when the device is suspended.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index cf9f61682dd8b..6ac79b8517319 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -420,7 +420,10 @@ static irqreturn_t rocket_job_irq_handler_thread(int=
 irq, void *data)
>  {
>  	struct rocket_core *core =3D data;
> =20
> -	rocket_job_handle_irq(core);
> +	if (pm_runtime_get_if_active(core->dev)) {
> +		rocket_job_handle_irq(core);
> +		pm_runtime_put(core->dev);
> +	}
> =20
>  	return IRQ_HANDLED;
>  }

[Severity: High]
Does this evaluation handle negative error codes correctly?

pm_runtime_get_if_active() returns 1 if the device is active, 0 if inactive,
and a negative error code (such as -EINVAL) if runtime PM is disabled. Beca=
use
any non-zero value evaluates to true in C, a negative return value will sat=
isfy
this condition.

If that happens, the code proceeds to call pm_runtime_put(). Since the init=
ial
get call failed and did not increment the usage counter, wouldn't this
unconditionally decrement the counter and lead to an underflow?

Could this explicitly check for success, such as evaluating if the return v=
alue
is strictly equal to 1?

> @@ -428,16 +431,24 @@ static irqreturn_t rocket_job_irq_handler_thread(in=
t irq, void *data)
>  static irqreturn_t rocket_job_irq_handler(int irq, void *data)
>  {
>  	struct rocket_core *core =3D data;
> -	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> +	u32 raw_status;
> +
> +	if (pm_runtime_get_if_active(core->dev) !=3D 1)
> +		return IRQ_NONE;
> +
> +	raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> =20
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
> =20
>  	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
> -	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
> +	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1)) {
> +		pm_runtime_put(core->dev);
>  		return IRQ_NONE;
> +	}
> =20
>  	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +	pm_runtime_put(core->dev);
> =20
>  	return IRQ_WAKE_THREAD;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but will this cause a hardirq st=
orm
if a DMA error occurs without a DPU completion?

If an interrupt is raised due to a DMA read or write error, the code logs a
warning via WARN_ON. However, if the DPU completion bits are not set, the
handler returns IRQ_NONE without clearing, acknowledging, or masking the
pending interrupt.

Since the interrupt remains asserted at the hardware level, won't the kerne=
l's
IRQ core immediately re-invoke the handler in an infinite loop, hanging the=
 CPU
until the spurious interrupt detector permanently disables the shared IRQ l=
ine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610030322.2802=
744-1-zhaojinming@uniontech.com?part=3D2
