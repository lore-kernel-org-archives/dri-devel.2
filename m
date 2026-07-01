Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4908CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50C610EE04;
	Wed,  1 Jul 2026 07:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mqvi2MnN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA06C10EE04
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:13:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87EE24168D;
 Wed,  1 Jul 2026 07:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7201F000E9;
 Wed,  1 Jul 2026 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782890013;
 bh=zj4kVnbHdT/JpJV3pJpSsdUh2JAzlXxLvJVxNKheY+8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mqvi2MnNs/RhxED6dECi12pLvQjgyZMW0NU0mWO7Y8ZQVZ6WwL694HHIxCma1TzPh
 7w5Mi6R4OfjvFr0Zwf5UK3mlofiv+5oxy7rzkA0aMA358D+nJ5RjLAVGEojR8JWqzs
 1+QHntLM+4sfTwHdzZyDt0xESb4i6mJoyYEBmNm9yZG1Bx7LWFyu13nC+Tv2IWwrBR
 wdzxgzyhNtV6IYoAeQEif0dT7r8JhQ3sz7VntEQFoV+Y0y5uOQoGiMVCc1Oyw2rfPI
 oZsUUt6G7bNp/XEzwtodrpFaV+19e21xMuoMJAhqikR9pBunxTTf13iFK4JnVoXZvD
 WnQBLjXQuFUOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/amd/amdgpu: remove duplicated code in gfx_v11
 and gfx_v12
To: "Ulisses Paixao" <ulissespaixao@usp.br>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630205545.23920-1-ulissespaixao@usp.br>
References: <20260630205545.23920-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:13:32 +0000
Message-Id: <20260701071333.0E7201F000E9@smtp.kernel.org>
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
- [Medium] The generic helper `amdgpu_gfx_handle_priv_fault` lacks an `xcc_=
id` parameter and hardcodes array indexing for a single-XCC configuration, =
breaking multi-XCC support.
- [Low] Missing early return in the `compute_ring` search loop causes unnec=
essary iteration.
--

commit 249c05a6da6280bb2499d0d7191928c66dd35d25
Author: Ulisses Paixao <ulissespaixao@usp.br>

drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12

This patch moves the shared ring-searching logic for handling privileged
instruction faults into a common function amdgpu_gfx_handle_priv_fault.
Hardware-specific decoding remains in the version-specific files.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0506b90f318e4..25a4b33f42a81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
[ ... ]
> @@ -855,6 +855,42 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>  	return r;
>  }
> =20
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +					u8 me_id, u8 pipe_id, u8 queue_id)
> +{
> +	struct amdgpu_ring *ring;
> +	int i;
> +
> +	if (!adev->gfx.disable_kq) {
> +		for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring =3D &adev->gfx.gfx_ring[i];

[Severity: Medium]
Does this logic fully support multi-XCC configurations?

In multi-XCC setups, the gfx_ring array contains rings for all XCCs
continuously. Iterating only up to adev->gfx.num_gfx_rings (the per-XCC
count) strictly searches the rings belonging to XCC 0.

If a privileged instruction fault occurs on a ring belonging to an XCC
other than 0, will it fail to find the matching ring because the search
isn't offset by the xcc_id?

> +			if (ring->me =3D=3D me_id && ring->pipe =3D=3D pipe_id &&
> +			    ring->queue =3D=3D queue_id) {
> +				drm_sched_fault(&ring->sched);
> +				return;
> +			}
> +		}
> +
> +		for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +			ring =3D &adev->gfx.compute_ring[i];

[Severity: Medium]
Will this also miss compute rings for XCC > 0, similar to the gfx_ring
loop above?

> +			if (ring->me =3D=3D me_id && ring->pipe =3D=3D pipe_id &&
> +			    ring->queue =3D=3D queue_id)
> +				drm_sched_fault(&ring->sched);

[Severity: Low]
Is there a missing return statement here?

The loop for gfx_ring above added an early return once a match is found,
but this loop continues iterating through the remaining compute rings
needlessly after the target ring is handled.

> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630205545.2392=
0-1-ulissespaixao@usp.br?part=3D1
