Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6631BC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC2910E7E6;
	Tue, 28 Jul 2026 07:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VtCRSZV3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A812210E7E6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:26:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D56EC60A62;
 Tue, 28 Jul 2026 07:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3A71F000E9;
 Tue, 28 Jul 2026 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785223603;
 bh=Y0X7YRVnwTXm1bVs+2+BJUZJBU7vjqsJiFjYIhAUXWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VtCRSZV3poSGZVgF3Fj+t2NbpLGma7NzK11A4S5n8kTbhWW9KKJYrIo02NniFkUP/
 fgDC0NtHHBe2wy6jISQsD0QySzUe+MfP+E9MfAGDzu4E1KWlJKLcG/GLFZYmwvdmWd
 4Y92SpZj+4apHk7ObiQ4PNl4uGm2tInUkwLMOH7ZynuAvV70TwjMxDzlMW6c/lLEk/
 trhyj+f+0fqQ/Lhe6bTxizmQ9kyZyRpd931kPaBxMOrCQSp/chjAHeHvPTI0XV1WF4
 E+lqGX/cWKSiiT7yf+CE/P76JKWO7emNawh5ThWgqTiu/CQeFHafBbtRHsL2kT1RY2
 DmpZ+GE3aWQ6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/amd/amdgpu: remove duplicated code in gfx_v11
 and gfx_v12
To: "Ulisses Paixao" <ulissespaixao@usp.br>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728025048.14970-1-ulissespaixao@usp.br>
References: <20260728025048.14970-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:26:40 +0000
Message-Id: <20260728072643.5F3A71F000E9@smtp.kernel.org>
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
- [Medium] Missing early return in the compute ring search loop causes unin=
tended fall-through to user queue processing.
--

--- Patch [1]: [PATCH v6] drm/amd/amdgpu: remove duplicated code in gfx_v11=
 and gfx_v12 ---
commit 554dbb6c1295b4176f2248f06098908b58cf4225
Author: Ulisses Paixao <ulissespaixao@usp.br>

drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12
   =20
This commit consolidates the shared logic for finding and handling a
scheduler fault on a ring into a common function, amdgpu_gfx_handle_priv_fa=
ult,
in amdgpu_gfx.c.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 1e275c2e7dd3e..3b612e9a5bb8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c

[ ... ]

> @@ -855,6 +856,56 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>  	return r;
>  }
> =20
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @entry: interrupt vector entry containing fault information
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +					struct amdgpu_iv_entry *entry,
> +					u8 me_id, u8 pipe_id, u8 queue_id)
> +{
> +	struct amdgpu_ring *ring;
> +	int i;
> +
> +	/*
> +	 * Try KQ first by ring_id (HW slot is authoritative). The
> +	 * KMD compute_hqd_mask contract guarantees KCQ and user queues
> +	 * never share a HW slot.
> +	 */
> +	if (!adev->gfx.disable_kq) {
> +		for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring =3D &adev->gfx.gfx_ring[i];
> +			if (ring->me =3D=3D me_id && ring->pipe =3D=3D pipe_id &&
> +			    ring->queue =3D=3D queue_id) {
> +				drm_sched_fault(&ring->sched);
> +				return;
> +			}
> +		}
> +
> +		for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +			ring =3D &adev->gfx.compute_ring[i];
> +			if (ring->me =3D=3D me_id && ring->pipe =3D=3D pipe_id &&
> +			    ring->queue =3D=3D queue_id)
> +				drm_sched_fault(&ring->sched);

[Severity: Medium]
Should there be a return statement here?=20

Without an early return, the loop correctly triggers a scheduler fault on a
matching compute ring, but then execution erroneously continues to the MES
user queue fallback logic below. This could result in spuriously processing=
 a
reset IRQ for a user queue if the PASID and doorbell offset happen to alias.

> +		}
> +	}
> +
> +	u32 doorbell_offset =3D entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_=
MASK;
> +
> +	/* No KQ matched: HW slot is a MES-scheduled user queue. */
> +	if (adev->enable_mes && doorbell_offset)
> +		amdgpu_userq_process_reset_irq(adev, entry->pasid,
> +					       doorbell_offset);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728025048.1497=
0-1-ulissespaixao@usp.br?part=3D1
