Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6944CCD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE3810E725;
	Tue, 16 Jun 2026 07:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bhqt1dpg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4540710E725
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 07:49:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5ED7A60154;
 Tue, 16 Jun 2026 07:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7351F000E9;
 Tue, 16 Jun 2026 07:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781596185;
 bh=3Ug0HhUJb41NJJHRiLmhy7ai5OQPV6bxRmWWbbXicAI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bhqt1dpgq7a6o40gHZZm7g7EdKMgMThVCE376w/tkFUY0TCvAGXSZRUMpKBel4W55
 /7vBcCYYNAChLwXSUTqzmx2kByChSoHSj7xf3ZvM97gD5PcOomNUwdF4gCKpBwJ8+7
 77wNCsRbeeJ+1GhHBF4XeCuX7GSbp1vqRz7iAbAAYXyb2zLAHgpX8MPvY1KVQad90x
 kxetFGVLh3gxMZq2rrU+Ra1mk9680U+Rc2XYtAuZvnxuDc3YUtYFJ7NnpQ7Bqh3cX6
 pGD7K3WtrKlZW9r4hSXy++K8UGtcbF3EVmRgSYgnz8JzI5RxMiqLttT+546/YYfi9I
 hyNJxwnrjX3tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616073555.3548595-1-lizhi.hou@amd.com>
References: <20260616073555.3548595-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 07:49:44 +0000
Message-Id: <20260616074944.EC7351F000E9@smtp.kernel.org>
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
- [Critical] Stack corruption via use-after-free when userspace resets sync=
obj during a debug BO sync/config.
- [High] PM resume deadlock in `amdxdna_drm_config_hwctx_ioctl()`.
- [High] Deadlock preventing TDR (Timeout Detection and Recovery) from reco=
vering hung hardware.
--

commit 8a4736ca1e30a73a36f619abfba2f12bdcd407ef
Author: Lizhi Hou <lizhi.hou@amd.com>
accel/amdxdna: Prevent PM resume deadlock in hwctx_sync_debug_bo()

This patch fixes a deadlock by moving the PM resume call before acquiring
the device lock in amdxdna_hwctx_sync_debug_bo.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 855da8c79a1cd..b7dbb60bca711 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c

[ ... ]

> @@ -412,16 +412,25 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_clie=
nt *client, u32 debug_bo_hdl)
>  	if (!gobj)
>  		return -EINVAL;
> =20
> +	ret =3D amdxdna_pm_resume_get(xdna);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
> +		goto put_obj;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the exact same deadlock
pattern still exist in amdxdna_drm_config_hwctx_ioctl()?

When userspace issues DRM_AMDXDNA_HWCTX_ASSIGN_DBG_BUF, the ioctl wrapper
acquires the lock:

amdxdna_drm_config_hwctx_ioctl() {
    ...
    guard(mutex)(&xdna->dev_lock);
    ...
}

It then calls the hwctx_config callback, which traces down to
aie2_hwctx_cfg_debug_bo(), calling amdxdna_cmd_submit().
amdxdna_cmd_submit() unconditionally calls amdxdna_pm_resume_get().

If the device is suspended, this triggers a synchronous PM resume callback,
which attempts to acquire xdna->dev_lock, resulting in the same deadlock.
Unlike the patched code here, the ioctl wrapper doesn't seem to resume
the device before taking the lock.

>  	abo =3D to_xdna_obj(gobj);
> -	guard(mutex)(&xdna->dev_lock);
> +	mutex_lock(&xdna->dev_lock);

[Severity: High]
This is a pre-existing issue, but holding dev_lock here while calling down
to the hardware backend seems to cause a deadlock with TDR recovery.

Both amdxdna_hwctx_sync_debug_bo() and amdxdna_drm_config_hwctx_ioctl()
hold xdna->dev_lock while invoking backend operations. These operations
submit a job and wait indefinitely:

aie2_cmd_wait() {
    ...
    dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
    ...
}

If the hardware hangs, aie2_cmd_wait() blocks. The DRM scheduler timeout
triggers and executes aie2_sched_job_timedout() to reset the hardware.
However, the timeout handler attempts to acquire the lock:

aie2_sched_job_timedout() {
    ...
    guard(mutex)(&xdna->dev_lock);
    ...
}

Since the waiting thread already holds dev_lock and won't release it until
the job completes, does this deadlock the recovery thread, rendering the
system unable to recover from hardware hangs?

>  	hwctx =3D xa_load(&client->hwctx_xa, abo->assigned_hwctx);
>  	if (!hwctx) {
>  		ret =3D -EINVAL;
> -		goto put_obj;
> +		goto unlock;
>  	}
> =20
>  	ret =3D xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, debug_bo_hdl);

[Severity: Critical]
This is a pre-existing issue, but could this synchronous wait lead to stack
corruption if userspace resets the syncobj?

In aie2_hwctx_sync_debug_bo() and aie2_hwctx_cfg_debug_bo(), a command
structure is allocated on the stack:

aie2_hwctx_sync_debug_bo() {
    struct amdxdna_drv_cmd cmd =3D { 0 };
    ...
}

This is submitted and cached in the DRM scheduler job (job->drv_cmd =3D &cm=
d).
The thread then waits using aie2_cmd_wait(), which fetches the out-fence
via drm_syncobj_fence_get(hwctx->priv->syncobj).

Since hwctx->syncobj_hdl is exported to userspace upon context creation,
what happens if userspace erroneously or maliciously calls
DRM_IOCTL_SYNCOBJ_RESET?=20

drm_syncobj_fence_get() will return NULL, causing aie2_cmd_wait() to return
early. The caller function then exits, popping the cmd struct from the
stack while the DRM scheduler job is still executing.

When the job completes, the response handler writes the result:

aie2_sched_drvcmd_resp_handler() {
    ...
    job->drv_cmd->result =3D readl(data);
    ...
}

Would this lead to an arbitrary write-what-where stack corruption?

> =20
> +unlock:
> +	mutex_unlock(&xdna->dev_lock);
> +	amdxdna_pm_suspend_put(xdna);
>  put_obj:
>  	drm_gem_object_put(gobj);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616073555.3548=
595-1-lizhi.hou@amd.com?part=3D1
