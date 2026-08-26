Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55991C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2284C10E6A8;
	Wed, 26 Aug 2026 20:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ELdMkREo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7C410E6A8
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 20:14:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CF0142EA4;
 Wed, 26 Aug 2026 20:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1D01F000E9;
 Wed, 26 Aug 2026 20:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787775290;
 bh=kb/ohx4R1/m1oMASbk5X2kAYN5ShRNSS3LjpamgXdaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ELdMkREo1dQBYpqTZapImFk/cyxPpP1I3S2aHvYBPqgKDbpY/LXB6AP7U0sDEeE2N
 Ax6dVhPmK/A8IOruHAFUT9SAKpi0sp49v/NgkkJVwcrQjZce84Fh8NFTM0XoUDR2Jb
 sIO6q4MjVXJDPUfSQi2S6x8MSvbUBK7ejtwqE2nZZLZZDLpuZMGRqIL5RRsZIWGsQ/
 F8gv1od8Xl/Zhj2dsQCxBBMisDPDnWxhprSGSPVvBfmHhEUQv9Wh66yk/GbeLZgyvB
 hA5ZJ3RiYpijaGoiskiNXPhtDQQhvggqNFtx7OtEv5sTJ+DVZJmqAZMNT/E0rbS6dq
 QPUJgphIPBmwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/amdxdna: make the debug BO command wait
 interruptible
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826195751.358629-1-taimuraz@kaitmazov.com>
References: <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
 <20260826195751.358629-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 20:14:49 +0000
Message-Id: <20260826201450.2B1D01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Returning `-EINTR` while leaving the software state modified break=
s standard ioctl restart semantics.

Pre-existing issues:
- [High] Hardware Page Fault / Use-After-Free when debug BO is closed while=
 attached.
- [High] Missing Error Handling in aie2_cmd_wait allows state desynchroniza=
tion.
- [High] Denial of Service via device-wide client_lock during unbounded wai=
t.
--

commit 5562369312b08033baebb62691f056cab3d5a6c1
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: accel/amdxdna: make the debug BO command wait interruptible

This commit changes aie2_cmd_wait() to wait interruptibly instead of
uninterruptibly, returning -EINTR on interruption. It also leaves the BO
attached when interrupted to prevent detachment failures if the hardware
is successfully attached.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index baf9a8b90a4d6..d3c80f760a1d3 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -908,20 +908,30 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwct=
x *hwctx, void *buf, u32 size
>  	return ret;
>  }
> =20
> -static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
> +static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>  {
>  	struct dma_fence *out_fence =3D aie2_cmd_get_out_fence(hwctx, seq);
>  	struct amdxdna_dev *xdna =3D hwctx->client->xdna;
> +	long ret;
> =20
>  	if (!out_fence) {
>  		XDNA_ERR(xdna, "Failed to get fence");
> -		return;
> +		return 0;

[Severity: High]
This is a pre-existing issue, but does returning 0 here indicate success to
the caller despite the inability to wait for the command?

If aie2_cmd_get_out_fence() fails (e.g., an unprivileged user concurrently
resets hwctx->syncobj_hdl), the driver skips waiting for the hardware but
proceeds as if the command finished.

It seems this would cause subsequent logic to evaluate an uninitialized or
zeroed cmd->result, leading to software state desynchronization.

>  	}
> =20
>  	mutex_unlock(&xdna->dev_lock);
> -	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
> +	ret =3D dma_fence_wait_timeout(out_fence, true, MAX_SCHEDULE_TIMEOUT);

[Severity: High]
This is a pre-existing issue, but is it safe to sleep here for potentially =
an
unbounded amount of time without dropping the device-wide client_lock?

While dev_lock is explicitly dropped, the caller in
amdxdna_drm_config_hwctx_ioctl() acquires the device-wide client_lock before
initiating the wait:

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_drm_config_hwctx_ioctl() {
    ...
    mutex_lock(&xdna->client_lock);
    mutex_lock(&xdna->dev_lock);
    ...
}

An unprivileged user could submit a long-running compute job, issue a config
ioctl (e.g., ATTACH) that waits behind the compute job, and simply let their
thread sleep without sending a signal.

This would keep the device-wide client_lock held indefinitely, blocking all
other users from opening or closing the device.

>  	mutex_lock(&xdna->dev_lock);
>  	dma_fence_put(out_fence);

[ ... ]

> @@ -968,7 +978,17 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hw=
ctx *hwctx, u32 bo_hdl,
>  		goto put_cmd;
>  	}
> =20
> -	aie2_cmd_wait(hwctx, seq);
> +	ret =3D aie2_cmd_wait(hwctx, seq);
> +	if (ret) {
> +		/*
> +		 * The command may still attach the BO. Record it as attached,
> +		 * or DETACH will refuse it and there is no way back.
> +		 */
> +		if (attach)
> +			abo->assigned_hwctx =3D hwctx->id;
> +		goto put_cmd;
> +	}
> +
>  	if (cmd->result) {
>  		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>  		ret =3D -EINVAL;

[Severity: High]
Does returning -EINTR while leaving the software state modified break stand=
ard
ioctl restart semantics?

When aie2_cmd_wait() is interrupted, userspace receives -EINTR and will
typically retry the identical syscall.

If an interrupted ATTACH_DEBUG_BO proactively sets abo->assigned_hwctx,
userspace treating -EINTR as a failure will not issue a subsequent DETACH,
permanently stranding the BO.

If a DETACH_DEBUG_BO is interrupted, abo->assigned_hwctx intentionally skips
cleanup.

If the hardware successfully detached the BO, retrying the ioctl sends anot=
her
DETACH command. The firmware rejects the redundant detach, and the driver
handles the failure here in the cmd->result check.

This again skips clearing abo->assigned_hwctx, cementing the
desynchronization and leaving the BO permanently stuck as "attached".

[Severity: High]
This is a pre-existing issue, but does dropping the reference to the BO aft=
er
the goto put_cmd; jump allow a use-after-free and hardware page fault?

When aie2_hwctx_cfg_debug_bo() jumps to put_cmd, it falls through to put_ob=
j:

put_obj:
    amdxdna_gem_put_obj(abo);
    return ret;

The reference to the BO is completely dropped before returning, meaning the
kernel does not artificially keep the BO alive while it remains attached to
the hardware context.

If user space closes the BO handle while it is attached, the BO is destroye=
d:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_gem_dev_obj_free() {
    ...
    if (abo->pinned)
        amdxdna_gem_unpin(abo);

    amdxdna_gem_vunmap(abo);
    amdxdna_gem_heap_free(abo);
    drm_gem_object_release(gobj);
    amdxdna_gem_destroy_obj(abo);
}

The BO is freed and unmapped from the IOMMU without checking
abo->assigned_hwctx or sending a DETACH command to the hardware.

The hardware context remains configured to write debug data to the freed
memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826195751.3586=
29-1-taimuraz@kaitmazov.com?part=3D1
