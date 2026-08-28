Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E64C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A2910F486;
	Fri, 28 Aug 2026 21:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g69Bzlcu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469E410F486
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:11:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F54341455;
 Fri, 28 Aug 2026 21:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E851E1F000E9;
 Fri, 28 Aug 2026 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951500;
 bh=HI//bFDlNM51Qdel24eLIbsSlK8G/gDTtkf2Gpt9f3k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g69Bzlcug4HW9YTymlzPr/LvK3n1uvIZmympVtnxgrk71bKq/l0/wDa+1Hc+3X0Np
 W0/ltJc5X6dota8luQb5CYePq0IqZ8yT71D0FCxtaJ16t4BL2/gNQDQnvpVrcnlK3Z
 +QlF6n3dkHhoQoVm9c2okKjDiy5c2EEuyEI+borrr03bFW3srgR/DnMR0Vb92w0I2c
 QZYeVVORE9r/0K8jX1P7Nqatm6XKt0iVzfQQorA3ItWibkZI0k08pXjlQMtVI0HDAS
 X51tbNeN8DsgXN0PnAjB+hLltiXRUCYTWOuEongFNpBPlpZzFQis/KvfiEozwIz632
 XbxWb2gETdL/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/17] drm/panfrost: Split subsystem init/reset from
 interrupt enablement
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-8-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-8-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:11:39 +0000
Message-Id: <20260828211139.E851E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IRQ suspension in device probe error paths causes potentia=
l bus faults on shared IRQ lines.
--

commit 57c2c2f2f808cb53bd917f5b98f5700e0bc31b52
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Split subsystem init/reset from interrupt enablement

This commit decouples GPU, MMU, and Job Manager initialization and reset
sequences from interrupt enablement. It ensures subsystems only enable their
interrupts explicitly and handles IRQ toggling manually during probe, reset,
and removal.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 9e02fb5f73c82..99f7da2180f92 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -315,6 +338,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  out_devreg:
>  	pm_runtime_disable(pfdev->base.dev);
> +	panfrost_device_disable_hw(pfdev);
>  	panfrost_gem_fini(pfdev);
>  out_perfcnt:
>  	panfrost_perfcnt_fini(pfdev);
>  out_job:
>  	panfrost_jm_fini(pfdev);
>  out_mmu:
>  	panfrost_mmu_fini(pfdev);
>  out_gpu:
>  	panfrost_gpu_fini(pfdev);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing IRQ
suspension in the earlier error paths?

If probe fails early (for example, during panfrost_mmu_init() or later), the
error path jumps to out_mmu or out_gpu, calling panfrost_gpu_fini(),
panfrost_clk_fini(), etc. This powers off sub-blocks and disables clocks.

However, because panfrost_gpu_suspend_irq() (and its equivalents) are bypas=
sed
on these early error paths, the is_suspended state remains 0. The IRQ was
already requested with devm_request_irq() in panfrost_gpu_init(), and is on=
ly
freed later during devres cleanup.

If the IRQ line is shared with another active device (IRQF_SHARED is used by
the driver), an interrupt in this window could cause panfrost_gpu_irq_handl=
er()
to read GPU_FAULT_STATUS from disabled hardware:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_irq_handler() {
    if (test_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended))
        return IRQ_NONE;

    fault_status =3D gpu_read(pfdev, GPU_FAULT_STATUS);
    ...
}

Can this lead to a bus fault and kernel panic on systems where the GPU IRQ =
is
shared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D8
