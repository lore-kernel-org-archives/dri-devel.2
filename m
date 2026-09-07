Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8ACC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300F210E795;
	Mon,  7 Sep 2026 20:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L5mZa5WU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E48C10E795
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:31:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA901404B4;
 Mon,  7 Sep 2026 20:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717881F00A3A;
 Mon,  7 Sep 2026 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788813086;
 bh=GKxl/y5Qo5cF+D4fRWwtnqpeKFebeBVA7jeePtpLnx8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L5mZa5WUvQEIw3tieN1wG1XGkIEj5fqB9D1xO/MqdY8adyp3KnvPA1hT9Um9J9PHJ
 ev5gKFWFmRioRwx5asMqMTEIiN6XqOKyCx5DLdFdWSO6RXLO4pKu4fRhj7vHrUJnnD
 85e2/Yp0pkkE2QQZSeZEjRVmfLGI4VmZrQD6i4KyJMBS8cscrw9ZpVG1CFvmyojxVB
 CEn3x59Aeqm3ZoZc4jmza+bqXv7Idt8FXfChXDno9udZ6VWn46Y2q3lsbAj34q9Xav
 QWNGPBaECGar6Fzq+MVfDwue72rHtwIX+XZwkxKSvBs0bnvt+V5Zpd0bDsXGYUDznh
 mDY2SJGQeFg1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/16] drm/panfrost: Explicitly enable MMU interrupts
 at device init
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-7-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-7-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:31:25 +0000
Message-Id: <20260907203126.717881F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver is vulnerable to an asynchronous bus fault (system cras=
h) during driver removal when IRQs are shared. The GPU is powered off befor=
e the devm-managed IRQs are freed, but the `is_suspended` flags are not set=
, allowing the IRQ handlers to read from unpowered registers.
- [High] Hardware register MMU_INT_MASK suffers from a TOCTOU race with the=
 IRQ thread, which can leave interrupts enabled when the device is suspende=
d.
- [High] Incorrect ordering of hardware state update leaves Address Space (=
AS) interrupts permanently masked after recovering from a page fault.
--

commit edb0f05f6a41299dfda9d57b9f1f096e6d1d4aca
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Explicitly enable MMU interrupts at device init

This patch addresses an issue where jobs targeting the tiler buffer object
could time out between device registration and the first autosuspend. It
fixes this by explicitly enabling MMU interrupts at device initialization.

Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c

[ ... ]

> @@ -973,6 +978,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
> =20
> +	panfrost_mmu_enable_interrupts(pfdev);
> +

[Severity: High]
This is a pre-existing issue, but while reviewing the interrupt handling
code, does the driver have a vulnerability to an asynchronous bus fault
during driver removal when IRQs are shared?

In drivers/gpu/drm/panfrost/panfrost_device.c, panfrost_remove() calls
pm_runtime_set_suspended():

static void panfrost_remove(struct platform_device *pdev)
{
        // ...
        pm_runtime_disable(pfdev->base.dev);
        pm_runtime_set_suspended(pfdev->base.dev);
        panfrost_device_fini(pfdev);
}

This bypasses the panfrost_device_runtime_suspend() callback that normally
sets PANFROST_COMP_BIT_MMU. Then panfrost_device_fini() powers off the GPU.
Because PANFROST_COMP_BIT_MMU is not set, if an interrupt arrives on the
shared line before devm cleanup frees the IRQ:

drivers/gpu/drm/panfrost/panfrost_mmu.c:panfrost_mmu_irq_handler()
        if (test_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended))
                return IRQ_NONE;

        if (!mmu_read(pfdev, MMU_INT_STAT))
                return IRQ_NONE;

The handler will bypass the is_suspended check and read MMU_INT_STAT from
the powered-off GPU, potentially causing an SError or system crash.


[Severity: High]
This is also a pre-existing issue, but does MMU_INT_MASK suffer from a
TOCTOU race with the IRQ thread that can leave interrupts enabled when the
device is suspended?

In panfrost_mmu_irq_handler_thread(), the thread checks the suspended state
outside the lock:

        /* Enable interrupts only if we're not about to get suspended */
        if (!test_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended)) {
                spin_lock(&pfdev->as_lock);
                mmu_write(pfdev, MMU_INT_MASK, ~pfdev->as_faulty_mask);
                spin_unlock(&pfdev->as_lock);
        }

If preempted immediately after this evaluates to true, another CPU running
panfrost_mmu_suspend_irq() can set the is_suspended bit, write 0 to
MMU_INT_MASK, and block on synchronize_irq():

        set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);

        mmu_write(pfdev, MMU_INT_MASK, 0);
        synchronize_irq(pfdev->mmu_irq);

When the thread resumes, it locks, writes ~pfdev->as_faulty_mask to unmask
the interrupts, and exits. This allows synchronize_irq() to return, but
leaves the interrupts erroneously unmasked in hardware during suspend.


[Severity: High]
This is another pre-existing issue, but does the hardware state update
ordering in panfrost_mmu_as_get() leave Address Space (AS) interrupts
permanently masked after recovering from a page fault?

When clearing a faulty AS, the code writes to MMU_INT_MASK before clearing
the faulty AS's bit in as_faulty_mask:

                        mmu_write(pfdev, MMU_INT_CLEAR, mask);
                        mmu_write(pfdev, MMU_INT_MASK, ~pfdev->as_faulty_ma=
sk);
                        pfdev->as_faulty_mask &=3D ~mask;
                        panfrost_mmu_enable(pfdev, mmu);

The inverted mask writes a 0 for this AS, keeping it disabled in the
hardware register. Software state is updated immediately afterward, but
the hardware register is never re-written to reflect the unmasked state.
This could cause future GPU jobs on this AS to hang and timeout without
raising an interrupt.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D7
