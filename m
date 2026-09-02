Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE99FC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D569510F27B;
	Wed,  2 Sep 2026 15:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HHPFGnl7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF91010F27B;
 Wed,  2 Sep 2026 15:29:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9ADBB405A8;
 Wed,  2 Sep 2026 15:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B391F00A3A;
 Wed,  2 Sep 2026 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788362990;
 bh=9bodAhVe9Ta/ktGTFwbIfPf1VAanOOZWGRz/ad0xXWM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HHPFGnl7uJZFE6CVLxutCDjenl2N+5fKgAfSCjqLyq3XgRFab2cc7yPXltAx46RqL
 jQPwrmdGBtNJ/SYKbFCWxcQzBkXSkFHDP3VRpvKY6z/oXahopRGaZmomVBahtLTitq
 Wy+Ep5f926AdtI7IY7NIYClq2RFNnSVMjOKAb19xuSLBoSL8mrZZqcRb4IUJ4wWSBT
 7kH/Iwu8C37I1DGYtNMkbRDJAxEjms5lqZYf/UVXNbML24VnwB+6tfuYP+qt/AT5Em
 rT2GIheLZ301MO++P3WnWmTiJ8bL1cgsVybefOXOmlOVRPwS0YPHfTwIPeMrR4YQbg
 8n/FirXXV9E4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] drm: Add per-signal compare functionality to
 drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260902152049.183685-4-srinivasan.shanmugam@amd.com>
References: <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-1-srinivasan.shanmugam@amd.com>
 <20260902152049.183685-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:29:49 +0000
Message-Id: <20260902152950.52B391F00A3A@smtp.kernel.org>
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
- [High] copy_from_user_nofault() disables page faults, causing legitimate =
completion events to be permanently dropped if the CPU PTE is not populated.
- [Medium] drm_user_fence_set_compare() returns void and silently ignores i=
nvalid configuration arguments.
--

commit ff537705b8c71e85d2a5b3d68ffe3a36096823b1
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm: Add per-signal compare functionality to drm_user_fence
   =20
This patch adds optional compare fields to drm_user_fence to support per-si=
gnal
filtering, as used in the EOP eventfd path. It introduces
drm_user_fence_set_compare to configure the comparison and modifies the wor=
ker
to read the userspace value using copy_from_user_nofault before signaling.

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> index 0f229b7210a9b..06a5683db10d9 100644
> --- a/drivers/gpu/drm/drm_user_fence.c
> +++ b/drivers/gpu/drm/drm_user_fence.c

[ ... ]

> @@ -30,13 +39,46 @@ static void drm_user_fence_do_work(struct drm_work_fe=
nce *wfence)

[ ... ]

> +	if (ufence->cmp_op !=3D DRM_USER_FENCE_CMP_NONE &&
> +	    !(wfence->fence && wfence->fence->error)) {
> +		if (!mm) {
> +			call_worker =3D false;
> +		} else {
> +			__le64 raw;
> +
> +			/*
> +			 * Use copy_from_user_nofault() to prevent a
> +			 * userfaultfd-registered page from blocking this
> +			 * workqueue thread indefinitely (DoS).
> +			 */
> +			if (copy_from_user_nofault(&raw, ufence->cmp_addr,
> +						   sizeof(raw))) {
> +				call_worker =3D false;

[Severity: High]
Because copy_from_user_nofault disables page faults in drm_user_fence_do_wo=
rk,
will this return -EFAULT and permanently drop legitimate completion events =
if
the CPU PTE is not populated?

This can happen if the page is not resident, such as when NUMA balancing
sets PROT_NONE, or if the memory uses lazy mapping and the CPU hasn't
touched it since the GPU wrote to it.

> +			} else {
> +				/* GPU writes LE; convert before comparing. */
> +				u64 cur_val =3D le64_to_cpu(raw);

[ ... ]

> @@ -63,8 +105,47 @@ void drm_user_fence_init(struct drm_user_fence *ufenc=
e,

[ ... ]

> +void drm_user_fence_set_compare(struct drm_user_fence *ufence,
> +				u64 __user *addr, u64 value,
> +				enum drm_user_fence_cmp op)
> +{
> +	/*
> +	 * get_user() of u64 is not atomic on 32-bit =E2=80=94 caller should not
> +	 * reach here on non-64-bit kernels.
> +	 */
> +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT)))
> +		return;

[Severity: Medium]
Because this function returns void, does this early return on unsupported
architectures silently fail without the caller knowing?

If a driver attempts to configure a comparison here, it appears it would
silently leave cmp_op disabled as DRM_USER_FENCE_CMP_NONE, treating the
fence as an unconditional signal.

Could this function return an error code instead so the driver can
propagate the failure to userspace?

> +
> +	if (op !=3D DRM_USER_FENCE_CMP_NONE) {
> +		if (!addr || !IS_ALIGNED((unsigned long)addr, sizeof(u64)))
> +			return;

[Severity: Medium]
Similarly, if a driver passes an unaligned userspace address, does this
return silently bypass the intended logic and leave the fence as an
unconditional signal?

> +	}
> +
> +	ufence->cmp_addr  =3D addr;
> +	ufence->cmp_value =3D value;
> +	ufence->cmp_op    =3D op;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902152049.1836=
85-1-srinivasan.shanmugam@amd.com?part=3D4
