Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28311CDE012
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2D910F3B9;
	Thu, 25 Jun 2026 22:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FHPbnc6d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6192010F3B9
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:38:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 925D960098;
 Thu, 25 Jun 2026 22:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4AF1F000E9;
 Thu, 25 Jun 2026 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782427082;
 bh=vC9WlzsSM4RzXn8TPcwR/7nr1vMaD+RbHbC/T7Iy5o4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FHPbnc6dm25/xzm3ZBTrW5+DNXzhUHexmezCK/TEHFaYRnqc++QLKaCbqVr9vOpEe
 lzjDR6CSLHQsObBh5LpkevxBv4lfV4oFUFAwKiOT2ZILPSpL0LPkhq9qZwYmIO+nJ+
 h/9ZfJNsg/gXY6IRPMNphy2P8g8hQgeIQeFfvZuP36Y60LPvkShk+VE4phCZOf14mN
 3mpzHhj4bOMbwKF2gJX9o2hWWoOZEubqtNfI9pK1CCF2sUDrbcgAf/1u9w+PbsxK4k
 6BDlcjRnfwtXH8NbBHsZ2zusnDHU1KVWINyIfRHECLtix4dWXL4lCZjUJq53S4wzp0
 HXR9AWA5ZPyiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] drm/msm: Validate lazy VM in GEM_NEW
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625222744.22254-4-robin.clark@oss.qualcomm.com>
References: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
 <20260625222744.22254-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:38:01 +0000
Message-Id: <20260625223802.1B4AF1F000E9@smtp.kernel.org>
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
- [Medium] The check `if (!vm)` fails to reject shared VMs because `msm_con=
text_vm()` returns the shared VM on older targets.

Pre-existing issues:
- [Critical] Checking `if (sz > SIZE_MAX)` after assigning `struct_size()` =
to a u64 variable fails to detect overflow on 64-bit systems, leading to a =
heap buffer overflow.
--

commit 9eb8afbe441694e41365a15234a56e98a4a30b7c
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Validate lazy VM in GEM_NEW
   =20
This commit fixes a potential NULL pointer dereference by validating that
a lazy VM exists before creating a _NO_SHARE buffer object.
   =20
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 2cb3ab04f1250..b083790dba042 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1148,7 +1148,14 @@ int msm_gem_new_handle(struct drm_device *dev, str=
uct drm_file *file,
> =20
>  	if (flags & MSM_BO_NO_SHARE) {
>  		struct msm_context *ctx =3D file->driver_priv;
> -		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
> +		struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);
> +
> +		if (!vm) {
                ^^^^

[Severity: Medium]
Does this check properly reject shared VMs?

When per-process page tables are unsupported, msm_context_vm() falls
back to returning the global shared VM (gpu->vm). Since the returned
vm is not NULL, this check is bypassed, allowing NO_SHARE buffers to
be created on the shared VM.

Should this check also ensure that the returned VM is not the global
shared VM?

> +			ret =3D UERR(EINVAL, dev, "not supported with shared VM");
> +			goto out_put;
> +		}
> +
> +		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(vm);

[ ... ]

While reviewing this, I noticed a pre-existing issue in the msm submit code:

drivers/gpu/drm/msm/msm_gem_submit.c:submit_create() {
	...
	sz =3D struct_size(submit, bos, nr_bos) +
			((u64)nr_cmds * sizeof(submit->cmd[0]));

	if (sz > SIZE_MAX)
		return ERR_PTR(-ENOMEM);
	...
}

[Severity: Critical]
This is a pre-existing issue, but does this sz check work on 64-bit systems?

Since sz is a u64, sz > SIZE_MAX is impossible on 64-bit platforms where
SIZE_MAX is U64_MAX. If nr_bos is excessively large, struct_size() returns
SIZE_MAX, and adding the cmd size wraps sz around to a small positive
value.

The check is bypassed, leading to a small buffer allocation. Could this
allow out-of-bounds writes in submit_lookup_objects() when it loops up
to nr_bos?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625222744.2225=
4-1-robin.clark@oss.qualcomm.com?part=3D3
