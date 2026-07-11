Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C7AC44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609D610E03D;
	Sat, 11 Jul 2026 06:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mVzYtiDW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F2E10E03D
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:36:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA442600C3;
 Sat, 11 Jul 2026 06:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B411F000E9;
 Sat, 11 Jul 2026 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783751798;
 bh=JogfN73SWne51LzGJNSir4GAt/uI9nlNm8r6mVlz5J8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mVzYtiDWlHaNnqBsW+nGjIEvoQ+IrKkc0+NdoM9+P/m7+n2x1YuSTfV6C/xVxjtos
 ls3wQUpxv3TEJwX8WjgyIG8T7+uzf13HPVQyxnHlY0aRLkVU1yaVNu9XOupfygjQrK
 3lxrPoYECuD1Q3MdpTQuEKdnfROldg6SwvrjcsVyrYpPHeAntCI4jd4J08Zu/Nfmjh
 XTubfM6u1/03jzyxg7fPGY+AYJzMc8qP5xO6kYcgcVLhrP73co3YSB4WfyEbCaAVZT
 eNchC0MiRpqX/mgbt6b4iPNL8J+qpvFoiEUxGqPrO74fNWVXGoopp8yoghsyJH3rXh
 8bH5M/I4jJv6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: Validate task regcmd address and count on
 submission
To: "Sidong Yang" <sidong.yang@furiosa.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711062137.36044-1-sidong.yang@furiosa.ai>
References: <20260711062137.36044-1-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:36:37 +0000
Message-Id: <20260711063638.61B411F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Signed integer overflow in loop counter allows massive out-of-=
bounds kernel memory write.
- [High] Silent failure of job submission due to ignored return value.
- [High] IOMMU group reference leak on every job completion.
- [High] Hardware incompatibility due to 32-bit DMA address truncation for =
IOMMU allocations.
- [High] Unprivileged userspace can trigger a WARN_ON and panic the kernel =
via an invalid DMA address.
--

--- Patch [1]: [PATCH] accel/rocket: Validate task regcmd address and count=
 on submission ---
commit f9e96d89fbac295861e6b6ae4bd9fc056fddf28a
Author: Sidong Yang <sidong.yang@furiosa.ai>
Subject: accel/rocket: Validate task regcmd address and count on submission

This commit adds validation to the drm_rocket_task regcmd fields from
userspace. It rejects unaligned addresses and out-of-range counts with
-EINVAL at submission time to prevent hardware drops and mode flips.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index bb77b6bf0f231..9ebabf86fe97f 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -95,6 +105,20 @@ rocket_copy_tasks(struct drm_device *dev,
>  			goto fail;
>  		}
> =20
> +		if (task.regcmd_count > ROCKET_MAX_REGCMDS) {
> +			drm_dbg(dev, "regcmd_count field in drm_rocket_task should be <=3D %u=
.\n",
> +				ROCKET_MAX_REGCMDS);
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +
> +		if (!IS_ALIGNED(task.regcmd, ROCKET_REGCMD_ALIGN)) {
> +			drm_dbg(dev, "regcmd field in drm_rocket_task should be aligned to %u=
 bytes.\n",
> +				ROCKET_REGCMD_ALIGN);
> +			ret =3D -EINVAL;
> +			goto fail;
> +		}
> +
>  		rjob->tasks[i].regcmd =3D task.regcmd;

[Severity: Critical]
This is a pre-existing issue, but can the loop counter i overflow here?

Looking at rocket_copy_tasks(), the loop is defined as:

for (int i =3D 0; i < rjob->task_count; i++)

Since rjob->task_count is a u32 controlled by userspace and i is a signed
32-bit integer, if a user requests exactly 0x80000001 tasks, could i wrap
to a negative value?

If i wraps to a negative value, does this assignment allow an out-of-bounds
memory write before the allocated array?

>  		rjob->tasks[i].regcmd_count =3D task.regcmd_count;
>  	}

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the error
handling for these new -EINVAL checks, it appears the return value of
rocket_ioctl_submit_job() might be ignored.

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit() {
    ...
    rocket_ioctl_submit_job(dev, file, &jobs[i]);

exit:
    kvfree(jobs);

    return ret;
}

Does this allow the ioctl to silently return 0 even if the job was rejected
by the validations added in this patch?


[Severity: High]
This is a pre-existing issue, but does this code leak an IOMMU group
reference on every job completion?

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
    iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

Since iommu_group_get() increments the kref and iommu_detach_group() does
not consume it, are we missing a matching iommu_group_put()?


[Severity: High]
This is a pre-existing issue, but can the 32-bit regcmd truncate 64-bit
IOVAs?

include/uapi/drm/rocket_accel.h:drm_rocket_task {
    ...
    __u32 regcmd;
    ...
}

The allocator appears to be given the full IOMMU aperture:

drivers/accel/rocket/rocket_drv.c:rocket_open() {
    ...
    drm_mm_init(&rocket_priv->mm, start, end - start + 1);
    ...
}

If a buffer object is allocated above 4GB, does the UAPI structure truncate
the DMA address, causing the NPU to read unmapped memory?


[Severity: High]
This is a pre-existing issue, but can unprivileged userspace trigger a
kernel panic here?

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    ...
    WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
    ...
}

If userspace provides an invalid DMA address, the hardware will trigger a
DMA read error. Could this WARN_ON crash the system if panic_on_warn is
enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711062137.3604=
4-1-sidong.yang@furiosa.ai?part=3D1
