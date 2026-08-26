Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F600C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA8710E1FA;
	Wed, 26 Aug 2026 15:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3nr6/lB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8544F89452
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 15:21:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19D5543642;
 Wed, 26 Aug 2026 15:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEA11F000E9;
 Wed, 26 Aug 2026 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787757687;
 bh=WS7WGygZRrYUrr6wxSUi/FjSba7UYAhqnNuVEggDric=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l3nr6/lBAycNFEMCNi1Nb+ebgU8tWBQ0yLZipvq275cyUQpcF5/onMKQxFAGs9H2k
 45DNX2yi/maT1H5ZLRh9TfLO+Os9gsJ9nNqzCUayON2Xaoa5fz5iBiuIBr3yLfjWFs
 WVPblwnyuq6x57DhnlI9pgsv7RHUDiMFLkBF0ALIM6xzaoxwUjC5nOPxXyZPKR0bMh
 e0Q9z9s+39gtVFq3kBII4MT2lxMVjdnd/9UyU+gVMMAnHKnN59JJpiWjUWzBf/3SSG
 Va6Y9mRf2x47FrgYBiXPOI060TVwoPGLfDQeXl9tiLSNL7j0Hgz5d32Pwtngkp1Bhk
 PVRIXoukL5Yqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: make the debug BO command wait
 interruptible
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826150726.126296-1-taimuraz@kaitmazov.com>
References: <20260826150726.126296-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:21:26 +0000
Message-Id: <20260826152126.CDEA11F000E9@smtp.kernel.org>
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
- [High] Interruptible wait causes software state to desynchronize from har=
dware, potentially leading to IOMMU faults or memory corruption.

Pre-existing issues:
- [High] Unresolved ABBA deadlock between `xdna->dev_lock` and the DRM TDR =
(Timeout Detection and Recovery) handler permanently wedges the device on a=
 hardware hang.
--

commit ce5b5167020e9399e64c273e9bded5901cfbc67d
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: make the debug BO command wait interruptible

This commit changes the aie2_cmd_wait() function to wait for debug BO
commands interruptibly instead of uninterruptibly. It propagates the return
code up to the callers to allow userspace processes blocked on a hardware
hang to be killed.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 54486960cbf5e..1f910ee4941c9 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -897,17 +897,20 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwct=
x *hwctx, void *buf, u32 size
>  	return ret;
>  }
> =20
> -static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
> +static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>  {
>  	struct dma_fence *out_fence =3D aie2_cmd_get_out_fence(hwctx, seq);
> +	long ret;
> =20
>  	if (!out_fence) {
>  		XDNA_ERR(hwctx->client->xdna, "Failed to get fence");
> -		return;
> +		return -EINVAL;
>  	}
> =20
> -	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
> +	ret =3D dma_fence_wait_timeout(out_fence, true, MAX_SCHEDULE_TIMEOUT);
>  	dma_fence_put(out_fence);
> +
> +	return ret < 0 ? ret : 0;
>  }

[Severity: High]
This is a pre-existing issue, but does making the wait interruptible fully
resolve the underlying deadlock with the timeout handler?

While this prevents an unkillable task, the ioctl still holds xdna->dev_lock
across the wait:

amdxdna_drm_config_hwctx_ioctl()
   guard(mutex)(&xdna->dev_lock);
   ...
   aie2_hwctx_cfg_debug_bo()
      aie2_cmd_wait()
         dma_fence_wait_timeout()

If the firmware hangs, the DRM scheduler invokes aie2_sched_job_timedout()
to recover. However, aie2_sched_job_timedout() also requires xdna->dev_lock.
This deadlocks against the waiting ioctl thread, preventing automatic TDR
recovery unless the waiting process is manually killed.

>  static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_h=
dl,
> @@ -954,7 +957,10 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hw=
ctx *hwctx, u32 bo_hdl,
>  		goto put_cmd;
>  	}
> =20
> -	aie2_cmd_wait(hwctx, seq);
> +	ret =3D aie2_cmd_wait(hwctx, seq);
> +	if (ret)
> +		goto put_cmd;
> +

[Severity: High]
If the wait is interrupted and returns an error, could this early return
cause the software state to desynchronize from the hardware?

By taking the goto put_cmd path, the function skips the state update later
in the function:

aie2_hwctx_cfg_debug_bo() {
    ...
    if (attach)
        abo->assigned_hwctx =3D hwctx->id;
    else
        abo->assigned_hwctx =3D AMDXDNA_INVALID_CTX_HANDLE;
    ...
}

If the hardware successfully processes the command but the software update
is skipped due to the interrupted wait, the driver will consider the BO
unattached.

Can this allow userspace to prematurely free the BO while the firmware still
has it mapped, leading to IOMMU faults or memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826150726.1262=
96-1-taimuraz@kaitmazov.com?part=3D1
