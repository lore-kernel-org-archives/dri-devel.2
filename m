Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E4606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ce3gG4my
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A793110EA0E;
	Thu, 26 Nov 2026 18:11:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063D810EA0E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:11:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 178AF60E44;
 Thu, 26 Nov 2026 18:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924A01F000EB;
 Thu, 26 Nov 2026 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795716687;
 bh=PqaT3TLk49gdQy3zpvwFM2szkreofyDrgsVEIRnESWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ce3gG4myL2NvDOv1PEayUE63ja20wXv07hrfH85Cp1sd/aSJmdf/eU6Ic913iKWmQ
 KtTmlsWTmpqHpmOUinzM0V9SmY6kus+o+vFMIegrfIW/JEWhfEO2ROYQFWyT2X4Jgi
 Iuz67YMgm0V9fRA35G/HoqTG6pJduB4YYirlIbD84f7Q7ib0TG8PKcDrGZb5XqRSgR
 L4isXcO8OCPbGS/5jKai2b8aasko+L1U5qqd0a6viLNdikuyAdD2v3YkysViWwS1Ad
 03RGFuGH3evbcpg2wfUmQBnUYUifdx6FmK2UQBSocxCwW1M965MUyV2bPhXK0WtMj/
 XJobiGE5KgSgQ==
Message-ID: <sashiko-outbox-235999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/fifo/gf100-: reset the faulting engine even
 if it switched channels
To: =?utf-8?b?RnLDqWTDqXJpYyBNYWjDqQ==?= <frederic.mahe@cirad.fr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126175531.916097-1-frederic.mahe@cirad.fr>
References: <20261126175531.916097-1-frederic.mahe@cirad.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 18:11:26 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/nouveau/fifo: unsynchronized engn->rc_reset in
  gf100_fifo_mmu_fault_recover()
--

commit c25dc87b435d54f44150db91d3c558d0942a3224
Author: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>

drm/nouveau/fifo/gf100-: reset the faulting engine even if it switched chan=
nels

This commit records when an engine reports an MMU fault in engn->rc_reset
and resets that engine during runlist recovery even if its current context
no longer points to the faulting channel group.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/fifo/gf100.c
> index e4a4fad2eafce..4f221c0b23fa6 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
> @@ -597,9 +597,16 @@ gf100_fifo_mmu_fault_recover(struct nvkm_fifo *fifo,=
 struct nvkm_fault_data *inf
>  		   info->reason, er ? er->name : "",
>  		   chan ? chan->id : -1, info->inst, chan ? chan->name : "unknown");
> =20
> -	/* Handle host/engine faults. */
> -	if (chan)
> +	/* Handle host/engine faults.  The engine that reported the fault must
> +	 * be reset even if it has already switched to another channel (its
> +	 * status then no longer points at the faulting channel), otherwise it
> +	 * stays stalled and the runlist update never completes.
> +	 */
> +	if (chan) {
> +		if (engine)
> +			atomic_set(&engn->rc_reset, 1);
>  		nvkm_runl_rc_cgrp(chan->cgrp);
> +	}
> =20
>  	nvkm_chan_put(&chan, flags);
>  }

[Severity: High]
Can setting engn->rc_reset before nvkm_runl_rc_cgrp() leave a stale
rc_reset flag armed when cgrp->rc has already left NVKM_CGRP_RC_NONE?

nvkm_runl_rc_cgrp() only schedules recovery when cgrp->rc transitions from
NVKM_CGRP_RC_NONE to NVKM_CGRP_RC_PENDING, and cgrp->rc stays at
NVKM_CGRP_RC_RUNNING once recovery starts while the channel remains in
runl->chid until userspace closes it.  If a faulting channel generates
more than one MMU fault entry (for example, multiple fault buffer entries
drained by gv100_fault_buffer_process() or a second fault interrupt before
the engine is reset), the second call sets engn->rc_reset =3D 1 while
nvkm_runl_rc_cgrp() returns early without scheduling runl->work:

CPU0 (fault handler)              CPU1 (runl->work)
gf100_fifo_mmu_fault_recover()
  /* fault 1 on chan A */
  atomic_set(&engn->rc_reset, 1)
  nvkm_runl_rc_cgrp(cgrpA)
    cgrpA->rc: NONE -> PENDING
    nvkm_runl_rc_runl()
                                  nvkm_runl_rc()
                                    cgrpA->rc: PENDING -> RUNNING
                                    ...
                                    atomic_xchg(&engn->rc_reset, 0)
                                    nvkm_engine_reset(engn->engine)
gf100_fifo_mmu_fault_recover()
  /* fault 2 on chan A */
  atomic_set(&engn->rc_reset, 1)
  nvkm_runl_rc_cgrp(cgrpA)
    cmpxchg(cgrpA->rc) !=3D NONE
    return;  <-- engn->rc_reset stays 1

A later recovery on the same runlist (such as a fault on another engine)
will then see engn->rc_reset =3D=3D 1 and reset engn while an unrelated
channel is running on it.

Conversely, if a second engine in the same channel group faults after
nvkm_runl_rc() has already passed the engine reset loop for the first
fault, setting engn2->rc_reset =3D 1 followed by nvkm_runl_rc_cgrp()'s early
return will never schedule another recovery pass to consume engn2->rc_reset,
leaving the second engine stalled.  And if an unrelated channel group
cgrpB faults on engn while nvkm_runl_rc() is already past the cgrp loop
(for example, waiting for PBDMA idle), the in-progress pass will consume
engn->rc_reset and reset engn before cgrpB's channels have been disabled
and removed from the runlist.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126175531.9160=
97-1-frederic.mahe@cirad.fr?part=3D1
