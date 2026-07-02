Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073EAC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533F010F1E2;
	Thu,  2 Jul 2026 07:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F4o4oEbZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E15710F1E2
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:55:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00D6940530;
 Thu,  2 Jul 2026 07:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBCC1F00A3E;
 Thu,  2 Jul 2026 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782978949;
 bh=lnj+h5nMbPBzaNti3hr9AvK1UpqN3NZcNLTQ4nKK3JQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F4o4oEbZjgQy3s+fF2PkRoXlCK0u/zgYK6ECUzDn9Rr++eFjJxaQnkTHQAaeXLHyT
 qmLiimrEJXXsFx5f2a723/ThWU1z+Qp5xzL3RsXtDtEvAmdVdWfWPkDiDoHdF6UHEf
 vXUOT9wSgvfqojbpXfGwCHm8S5YGRs4LpAnIpDCxgEu0hVgTQoMEtt9d+9UR2iHbXE
 9imMOPT945SU+rg255APFcK+5XrgvNYFmwEPraSdjvnaftRMG7ruTmaRG964Zi73nB
 arXWoyMBh2Uz5CgwNjpS2BlJah8weDykCmRApS9gp9QgzNzOus5nHKlNerzAr9uXbp
 hYI9icYxsjeIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/amd/amdgpu: remove duplicated code in gfx_v11
 and gfx_v12
To: "Ulisses Paixao" <ulissespaixao@usp.br>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701173741.39177-1-ulissespaixao@usp.br>
References: <20260701173741.39177-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:55:49 +0000
Message-Id: <20260702075549.ABBCC1F00A3E@smtp.kernel.org>
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
- [High] Inverted logic for checking kernel queues status breaks privileged=
 instruction fault handling.
--

commit 7d87e331de93eb7e4e60fea7e6c8746a5d76ff9d
Author: Ulisses Paixao <ulissespaixao@usp.br>

drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12

This commit deduplicates the handling of privileged instruction faults for
gfx v11 and v12. It introduces a common function, amdgpu_gfx_handle_priv_fa=
ult,
to identify the faulty ring and trigger a scheduler fault.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0506b90f318e4..836dad8fe06bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
[ ... ]
> @@ -855,6 +855,46 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
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
> +	/* The scheduler only handles kernel queues so this is a no-op
> +	without them. */
> +	if (!adev->gfx.disable_kq) {
> +		return;
> +	}

[Severity: High]
Is this early return condition inverted?

The original code executed the fault handling logic inside an
if (!adev->gfx.disable_kq) block, but here it returns and bypasses the
logic when disable_kq is false (meaning kernel queues are enabled).

Could this cause the scheduler to miss privileged instruction faults during
normal operation, potentially leading to unrecovered GPU hangs since it
fails to trigger a timeout or recovery reset?

> +
> +	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +		ring =3D &adev->gfx.gfx_ring[i];
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701173741.3917=
7-1-ulissespaixao@usp.br?part=3D1
