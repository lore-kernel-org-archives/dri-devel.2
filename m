Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D69CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 11:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED44D10E36B;
	Sun, 21 Jun 2026 11:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U2pkkllS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC3F610E36B
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 11:48:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A079144059;
 Sun, 21 Jun 2026 11:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E951F000E9;
 Sun, 21 Jun 2026 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782042486;
 bh=gv/nVMaXeUif7l/amKsk6aa1/vSU1OlPuoDbSNflQKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U2pkkllSOCJKhN7aynR6v7QZ2VWqIRYc/GQDyUCtGZl+qgKD5RGo5LwettZRTCzAR
 1AYAS8dyWVg090/5CGD7PqSkbpcuBxjYt0gxoIW2LgM9j0hgp+vN9iZLYXFpYkO32T
 cbUn0lx9bRAplQyeQnmEQR1OEpn+gynel8mCmXkpfpOjCKSpQQnjzVuVqi5YetlLii
 F3WhfqEmZhhBmYwkU1LNMW5xBHW1kNZ0D01sT2cGmWfnoIEG2vJ+QFPMp4ldjM4ENf
 FNzclOkNw6jmFaWihyrpZLozrq/y5p2L2pRpGLS8gKWqlomwSLpD0FHk3MVbHITWCg
 IrFvK/RwjU73g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 RESEND] drm/amd/amdgpu: remove duplicated code in
 gfx_v11 and gfx_v12
To: "Ulisses Paixao" <ulissespaixao@usp.br>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260620160407.8195-1-ulissespaixao@usp.br>
References: <20260620160407.8195-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 11:48:05 +0000
Message-Id: <20260621114806.59E951F000E9@smtp.kernel.org>
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
- [High] The refactored `amdgpu_gfx_handle_priv_fault` removes the `if (!ad=
ev->gfx.disable_kq)` guard, which can cause spurious scheduler faults and G=
PU resets when kernel queues are disabled.
--

commit 29fea06b4689e38bf654d74c9ec057d4896972a0
Author: Ulisses Paixao <ulissespaixao@usp.br>

drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12

This commit refactors duplicated ring-searching logic from
gfx_v11_0_handle_priv_fault and gfx_v12_0_handle_priv_fault into a common
function amdgpu_gfx_handle_priv_fault in amdgpu_gfx.c.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0506b90f318e4..120843a8d1ba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
[ ... ]
> @@ -855,6 +855,40 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
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
> +	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +		ring =3D &adev->gfx.gfx_ring[i];
> +		if (ring->me =3D=3D me_id && ring->pipe =3D=3D pipe_id &&
> +		    ring->queue =3D=3D queue_id) {
> +			drm_sched_fault(&ring->sched);

[Severity: High]
Is it possible we lost the check for !adev->gfx.disable_kq during this
refactoring?

If kernel queues are disabled (e.g. when MES is managing user queues), the
kernel rings might still exist but not be actively handling submissions.
If a privileged instruction fault originates from a user queue with an
overlapping me_id, pipe_id, and queue_id, could this match an idle kernel
ring and incorrectly trigger drm_sched_fault(&ring->sched)?

This could lead to an unwarranted GPU reset via the TDR handler rather than
leaving the event for proper user queue fault handling.

> +			return;
> +		}
> +	}
[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 6346f16c4e613..83fc2dbe8f7f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6684,37 +6684,12 @@ static void gfx_v11_0_handle_priv_fault(struct am=
dgpu_device *adev,
>  					struct amdgpu_iv_entry *entry)
>  {
>  	u8 me_id, pipe_id, queue_id;
> -	struct amdgpu_ring *ring;
> -	int i;
> =20
>  	me_id =3D (entry->ring_id & 0x0c) >> 2;
>  	pipe_id =3D (entry->ring_id & 0x03) >> 0;
>  	queue_id =3D (entry->ring_id & 0x70) >> 4;
> =20
> -	if (!adev->gfx.disable_kq) {

[Severity: High]
For context, here is where the guard was dropped from the original version
specific handler.

> -		switch (me_id) {
> -		case 0:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620160407.8195=
-1-ulissespaixao@usp.br?part=3D1
