Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB2CC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82EFA10E02E;
	Sat,  8 Aug 2026 11:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eu/N6N0W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE1510E02E
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 11:27:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A90D843E15;
 Sat,  8 Aug 2026 11:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CFB1F00A3A;
 Sat,  8 Aug 2026 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786188433;
 bh=qUB3yFcL+y4urKKC/DRr3wGAWn0/ntoUjaQ7HdDuNEo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eu/N6N0WaXbCiSqs6PO/YXt19R6XxwlWyy7ZGay9ya/6bqHQSegTILDKVV7iPiwmJ
 jxKn9dPh70pQKxeE2QvqXZisIGnL5n74SUMtxXhNXbB3Lbgc1qCm9xzhmwxADOuFY9
 pizERDfX8nVyVJv8A248qcE98cmtF1WqWZwWE6v8KNw7pdd+iAKw7/7Ve4ilhNuFKk
 erInhRJoGU/DK62UPNNstr5/e5PCH1G10spr0dJmRRmvqYXZjjfjmdv1U1XjFbIthp
 Ho1Rkn/SRsx1ESXWQ7lwS5R5UV9sU0dk3SMBCSGuGvdq/BCa7f3TFc+M5IQ8IdLh9C
 vNJHVWaAkXkow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and
 VM_BIND
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 11:27:12 +0000
Message-Id: <20260808112713.69CFB1F00A3A@smtp.kernel.org>
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
- [Medium] Un-rate-limited error logging creates a potential log-spam DoS v=
ector.
- [Medium] Validation of flag-gated syscall parameters outside their flag s=
cope.
- [Low] Format string specifier mismatch in error logging for __u32 counts.
--

--- Patch [1]: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC an=
d VM_BIND ---
commit 6d0adda3ff0dd4a0e4440dc92362fcb0ad993d9a
Author: Junrui Luo <moonafterrain@outlook.com>
Subject: drm/nouveau: bound sync and op counts in EXEC and VM_BIND

This commit introduces upper bounds for sync and op counts in the EXEC and
VM_BIND ioctls. By restricting the size of these counts, it prevents potent=
ial
excessive memory allocations that could trigger warnings or exhaust memory.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nou=
veau/nouveau_exec.c
> index a08ab1cfea9be..7bdccbae53b1d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_exec.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
> @@ -389,6 +389,18 @@ nouveau_exec_ioctl_exec(struct drm_device *dev,
>  		return nouveau_abi16_put(abi16, -EINVAL);
>  	}
> =20
> +	if (unlikely(req->wait_count > NOUVEAU_MAX_SYNCS)) {
> +		NV_PRINTK(err, cli, "exec wait count exceeds limit: %d max %d\n",
> +			  req->wait_count, NOUVEAU_MAX_SYNCS);

[Severity: Low]
Are the format string specifiers correct here? The req->wait_count field is
a __u32 type, so using %d will print large values as negative numbers.

[Severity: Medium]
Could this un-rate-limited NV_PRINTK log be intentionally triggered by
userspace to spam the kernel log buffer and hide other messages?

> +		return nouveau_abi16_put(abi16, -EINVAL);
> +	}
> +
> +	if (unlikely(req->sig_count > NOUVEAU_MAX_SYNCS)) {
> +		NV_PRINTK(err, cli, "exec sig count exceeds limit: %d max %d\n",
> +			  req->sig_count, NOUVEAU_MAX_SYNCS);
> +		return nouveau_abi16_put(abi16, -EINVAL);
> +	}
> +
>  	ret =3D nouveau_exec_ucopy(&args, req);

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index f5e4756b4de4a..bced1481674e7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1807,6 +1807,24 @@ nouveau_uvmm_ioctl_vm_bind(struct drm_device *dev,
>  	if (unlikely(!nouveau_cli_uvmm_locked(cli)))
>  		return -ENOSYS;
> =20
> +	if (unlikely(req->op_count > NOUVEAU_VM_BIND_MAX_OPS)) {
> +		NV_PRINTK(err, cli, "vm_bind op count exceeds limit: %d max %d\n",
> +			  req->op_count, NOUVEAU_VM_BIND_MAX_OPS);
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(req->wait_count > NOUVEAU_MAX_SYNCS)) {

[Severity: Medium]
According to the userspace API documentation, sync objects are only accepted
when DRM_NOUVEAU_VM_BIND_RUN_ASYNC is set in req->flags. If a user submits a
VM_BIND ioctl without this flag, might wait_count and sig_count contain
uninitialized garbage from userspace stack slots?

If so, is it safe to validate these flag-gated parameters outside the scope
of their flag check, rather than explicitly ignoring or rejecting them when
the flag is absent?

> +		NV_PRINTK(err, cli, "vm_bind wait count exceeds limit: %d max %d\n",
> +			  req->wait_count, NOUVEAU_MAX_SYNCS);
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(req->sig_count > NOUVEAU_MAX_SYNCS)) {
> +		NV_PRINTK(err, cli, "vm_bind sig count exceeds limit: %d max %d\n",
> +			  req->sig_count, NOUVEAU_MAX_SYNCS);
> +		return -EINVAL;
> +	}
> +
>  	ret =3D nouveau_uvmm_vm_bind_ucopy(&args, req);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-nouveau-fi=
xes-v1-0-c3ebdc17a89c@outlook.com?part=3D1
