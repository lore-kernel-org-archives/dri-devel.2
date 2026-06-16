Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4237CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A2A10E8A1;
	Tue, 16 Jun 2026 21:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aKo/8Y2B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B923110E8A1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 21:41:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B45B42B1B;
 Tue, 16 Jun 2026 21:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184A31F000E9;
 Tue, 16 Jun 2026 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781646063;
 bh=gSV3c0Kbcgsbb5m7MmCMphcOGMc8wh8PDHJY4HP61OQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aKo/8Y2Be0eTpqsh3sSDRb/7La3vFnZbc8gyzZrE2DIqmdVyZc25TzIgmhL+aram+
 IldBLx0s0SZ58IqepfsFsS30DPGI/luP9wwsyEADGMMIbANMm5xU0sspTuwUxPXHHK
 vz2smYl+SRUlvFrodaOIMrchCI6NzXFYiJBvsCFfEvaAGj9LTZC2d1U4hJ/8IDvLnq
 FfSsXB4h8g6Ty12N3gGwi42zJQ555GDezi+tf6rJbVf+8FSXi5FiCpeq/Hl2J7OF6A
 /hXNgQXTFm68wHdtAOWx8R67O/JGipYAFp1NDnHV5uIjnfJnj2eU79PMnSrzrcx+Eo
 Ivi+m8DMDop+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616212429.3620645-1-lizhi.hou@amd.com>
References: <20260616212429.3620645-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 21:41:02 +0000
Message-Id: <20260616214103.184A31F000E9@smtp.kernel.org>
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
- [High] Concurrent destruction of hwctx causes a Use-After-Free because `d=
ev_lock` is temporarily dropped during PM runtime resume without holding th=
e SRCU read lock.
--

commit 3f02e0b8320e3b9382db4505bfac1b4c92265f29
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Prevent PM resume deadlock in hwctx_sync_debug_bo()

This commit addresses a potential deadlock by calling amdxdna_pm_resume_get=
()
before acquiring xdna->dev_lock in both amdxdna_hwctx_sync_debug_bo() and
amdxdna_drm_config_hwctx_ioctl().

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 855da8c79a1cd..67a2abcf173ee 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -382,16 +382,25 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_devic=
e *dev, void *data, struct dr
[ ... ]
> +	mutex_lock(&xdna->dev_lock);
>  	hwctx =3D xa_load(&client->hwctx_xa, args->handle);
>  	if (!hwctx) {
>  		XDNA_DBG(xdna, "PID %d failed to get hwctx %d", client->pid, args->han=
dle);
>  		ret =3D -EINVAL;
> -		goto free_buf;
> +		goto unlock;
>  	}
> =20
>  	ret =3D xdna->dev_info->ops->hwctx_config(hwctx, args->param_type, val,=
 buf, buf_size);

[Severity: High]
This isn't a bug introduced by this patch, but does dropping the lock inside
this callback expose hwctx to a use-after-free?

If hwctx_config() (for example, aie2_hwctx_cu_config()) calls
amdxdna_pm_resume_get_locked(xdna), which temporarily unlocks and re-locks
xdna->dev_lock:

	mutex_unlock(&xdna->dev_lock);
	ret =3D amdxdna_pm_resume_get(xdna);
	mutex_lock(&xdna->dev_lock);

During this window, could a concurrent amdxdna_drm_destroy_hwctx_ioctl()
acquire dev_lock, erase hwctx from the xarray, and call
amdxdna_hwctx_destroy_rcu()?

Because the SRCU read lock (client->hwctx_srcu) is not held here,
synchronize_srcu() wouldn't block, and hwctx could be freed while still
in use after re-acquiring dev_lock.

It appears a similar issue might also exist in amdxdna_update_heap(), which
iterates over hwctx_xa without the SRCU read lock and drops both mm_lock
and dev_lock inside the loop body via amdxdna_hwctx_expand_heap().

> =20
> +unlock:
> +	mutex_unlock(&xdna->dev_lock);
> +	amdxdna_pm_suspend_put(xdna);
>  free_buf:
>  	kfree(buf);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616212429.3620=
645-1-lizhi.hou@amd.com?part=3D1
