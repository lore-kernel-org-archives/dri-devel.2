Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7312FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABB710F1FD;
	Wed,  8 Jul 2026 17:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jToJBdFt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E5910F1FD
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:53:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27E7B403A4;
 Wed,  8 Jul 2026 17:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC141F000E9;
 Wed,  8 Jul 2026 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783533194;
 bh=a+4141KicCVthroKvhPKqAicl3da0KeDjUWCdJIE/qw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jToJBdFts8AaacEjSZy5NBJVA023VnLEfCk2S3sYnr10DpUHT80EmwwaPJFS64lto
 5PYu6rnrEI/3jk11bmnGM4esYsl3hqjqyl828T2Q6pWZqSPXThJdb1P1J2HGAaXHIY
 RNiJHlT7c9yN0bfEVLf3AKtaz/pMlXTBKBBcrCNHkkVatH8zks7jL7n3RQO1ojsDUs
 C/eRwW+AwIrkRvX7PYZJikGJMmeibv8gK3RnzekA4+TO8LdrHoadWSTI0EbzwEDNDK
 aJwxvuQQ+0QpkaaJxrv7I1JkCdw4sxJ3ZV7lgqapKDZj5Z+nON+CBzgIMROLEkrO5f
 WKjgNdrFTqYEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] drm/msm: Validate lazy VM is created in GEM_SUBMIT
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708173356.578713-4-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
 <20260708173356.578713-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:53:13 +0000
Message-Id: <20260708175313.DEC141F000E9@smtp.kernel.org>
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
- [Critical] Direct access to `ctx->vm` without calling `msm_context_vm()` =
leads to a NULL pointer dereference in `msm_gem_new_handle()`.
- [Critical] Adding to the saturated result of `struct_size()` causes an in=
teger wrap-around on overflow, defeating overflow protection and leading to=
 a massive heap buffer overflow.
- [High] Validation bypass in `adreno_set_param()` when enabling `MSM_PARAM=
_EN_VM_BIND` allows userspace to enable VM BIND on unsupported hardware, le=
ading to a system-wide GPU DoS.
--

--- Patch [3]: [PATCH v4 3/6] drm/msm: Validate lazy VM is created in GEM_S=
UBMIT ---
commit a317c04b26f6bc5a511792869e55bcddc1d9014f
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Validate lazy VM is created in GEM_SUBMIT

This commit fixes a potential NULL pointer dereference in the GEM_SUBMIT
ioctl by ensuring the lazy VM is created before validating it. It passes the
instantiated VM to submit_create() to avoid redundant context lookups.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 26ea8a28be474..0dc983d155cd2 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -30,7 +30,7 @@
>   */
> =20
>  static struct msm_gem_submit *submit_create(struct drm_device *dev,
> -		struct msm_gpu *gpu,
> +		struct msm_gpu *gpu, struct drm_gpuvm *vm,
>  		struct msm_gpu_submitqueue *queue, uint32_t nr_bos,
>  		uint32_t nr_cmds, u64 drm_client_id)
>  {

[Severity: Critical]
This is a pre-existing issue, but can this size calculation overflow?

submit_create() calculates the size as:

	sz =3D struct_size(submit, bos, nr_bos) +
			((u64)nr_cmds * sizeof(submit->cmd[0]));

	if (sz > SIZE_MAX)
		return ERR_PTR(-ENOMEM);

If struct_size() saturates to SIZE_MAX, adding to it will wrap around uint6=
4_t.

Also, the sz > SIZE_MAX check is dead code on 64-bit systems because an
unsigned 64-bit integer can never exceed SIZE_MAX. This defeats overflow
protection and could allow an undersized allocation to succeed, potentially
leading to an out-of-bounds heap write when submit->bos and submit->cmd
are processed.

[ ... ]

While reviewing this commit's handling of lazy VM initialization, I noticed=
 two
other pre-existing issues in related code where ctx->vm is accessed without
being instantiated:

[Severity: Critical]
This is a pre-existing issue, but does msm_gem_new_handle() dereference a
NULL pointer if the VM isn't created yet?

In drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle():

	struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);

Since ctx->vm is lazily initialized, it will be NULL if msm_context_vm()
hasn't been called. drm_gpuvm_resv_obj expands to (ctx->vm)->r_obj, which
would dereference NULL. Could an unprivileged userspace program trigger
this by calling DRM_IOCTL_MSM_GEM_NEW with MSM_BO_NO_SHARE immediately
after opening the device?

[Severity: High]
This is a pre-existing issue, but is the VM_BIND validation bypassed in
adreno_set_param()?

In drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_set_param():

	if (ctx->vm =3D=3D gpu->vm)
		return UERR(EINVAL, drm, "requires per-process pgtables");

Because ctx->vm is lazily created, it is NULL here. This makes the check
evaluate to NULL =3D=3D gpu->vm, which is false, bypassing the validation.
Could this allow userspace to enable VM BIND on unsupported hardware and
cause lock contention during job submission?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708173356.5787=
13-1-robin.clark@oss.qualcomm.com?part=3D3
