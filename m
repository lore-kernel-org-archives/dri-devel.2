Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B204CCD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10DA01128F8;
	Thu,  4 Jun 2026 17:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PfjNQ4V3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AA51128F8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:55:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 921A14393C;
 Thu,  4 Jun 2026 17:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593331F00893;
 Thu,  4 Jun 2026 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780595754;
 bh=zaFj2py8TsK6T7o0SYWKM/IbFagJ8zS2Zepg+odLIdw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PfjNQ4V33FjbielV006qgc5f3dfdTUcIW/3DxqQl51cVSsGOq+yRZ3eMc3CAaLIlI
 Zvit11VH2el80eooPKlvnpF/A524Bbb1w98LjwnqDKAcZxNU8b9hxP32StJCNeEQIy
 xKNlQ230WYZiGWnsEtl4lVDO1QA+f/b5ciiJVriwZ277LH6PE6VkjtTw3ZO31E3Hb1
 m+6J3VVxfj5BnTsAETSWAhN8hjvDI9RrUvR2fbMQmsU8JmNjSTedeB6Ic49kbnb7rs
 cXTGASd3vt2E37RBIo4fYkhm1wfGNIrRwJybLVJ+1BMYRSn2BUaajCr73Achq6KdfH
 1j3c5zyzzsfBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] drm/panfrost: Explicitly enable MMU interrupts
 at device init
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-claude-fixes-v2-7-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-7-57c6bd4c1655@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:55:53 +0000
Message-Id: <20260604175554.593331F00893@smtp.kernel.org>
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
- [High] The MMU IRQ handler remains active while device clocks and power d=
omains are disabled during error teardown, causing unclocked MMIO accesses =
(S-Error).
- [High] panfrost_reset() does not mask or synchronize the MMU interrupt be=
fore resetting the GPU hardware, leading to a race condition with the MMU I=
RQ thread.
--

commit cac1cfb873df895888c7871605b659cdaf55b78e
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Date:   Thu Jun 4 17:35:26 2026 +0000

    drm/panfrost: Explicitly enable MMU interrupts at device init
   =20
    Because the device must be in a position to accept jobs between the time
    drm_dev_register() is called and autosuspend first kicks in, there's a =
very
    narrow window inbetween during which jobs targeting the tiler buffer
    object would time out, since the device's PM status is 'Active', but no=
 MMU
    interrupts were enabled at device initialisation time.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 4a3162c3b659f..0e1ad6256c2cb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
[ ... ]
> @@ -355,8 +361,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
> =20
>  	spin_unlock(&pfdev->as_lock);
> =20
> -	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
> -	mmu_write(pfdev, MMU_INT_MASK, ~0);
> +	panfrost_mmu_enable_interrupts(pfdev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the interrupt
handling during reset, does panfrost_reset() need to mask and synchronize
the MMU interrupt before resetting the hardware?

When a job timeout occurs, panfrost_reset() correctly masks and synchronizes
the job manager interrupts:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_reset() {
	/* Mask job interrupts and synchronize to make sure we won't be
	 * interrupted during our reset.
	 */
	job_write(pfdev, JOB_INT_MASK, 0);
	synchronize_irq(pfdev->js->irq);
...
	panfrost_device_reset(pfdev, true);
...
}

However, it does not do the same for the MMU interrupt (pfdev->mmu_irq).

Because MMU faults often cause job timeouts, the
panfrost_mmu_irq_handler_thread could be actively running concurrently on
another CPU.

If the IRQ thread attempts to handle an MMU page fault, it will write to MMU
registers while panfrost_device_reset() concurrently calls
panfrost_gpu_soft_reset() to reset the hardware.

Can uncoordinated MMIO accesses to hardware undergoing a soft reset lead to
unpredictable behavior or bus errors?

[ ... ]
> @@ -970,6 +975,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
> =20
> +	panfrost_mmu_enable_interrupts(pfdev);
> +

[Severity: High]
This is a pre-existing issue, but by explicitly enabling the MMU interrupts
here during init, does this expose a race condition in the device
initialization error paths?

If a subsequent initialization step like panfrost_jm_init() fails,
panfrost_device_init() will jump to the out_mmu label:

drivers/gpu/drm/panfrost/panfrost_device.c:panfrost_device_init() {
...
	err =3D panfrost_jm_init(pfdev);
	if (err)
		goto out_mmu;
...
out_mmu:
	panfrost_mmu_fini(pfdev);
...
out_clk:
	panfrost_clk_fini(pfdev);
...
}

panfrost_mmu_fini() masks the interrupt in hardware, but does not synchroni=
ze
or disable the IRQ handler in the kernel:

void panfrost_mmu_fini(struct panfrost_device *pfdev)
{
	mmu_write(pfdev, MMU_INT_MASK, 0);
}

Because panfrost_mmu_init() registers a shared threaded IRQ handler using
devm_request_threaded_irq(), the handler remains active during the rest of
the teardown.

If an interrupt fires or the thread runs after panfrost_clk_fini() has
disabled the hardware clocks, panfrost_mmu_irq_handler() will read unclocked
MMIO registers (e.g., mmu_read(pfdev, MMU_INT_STAT)).

Could this lead to a fatal S-Error (synchronous external abort)?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-claude-fix=
es-v2-0-57c6bd4c1655@collabora.com?part=3D7
