Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C5CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056E710E73B;
	Thu,  8 Oct 2026 04:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ko7bUlR+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFFC10E73B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 04:10:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 773A6433C3;
 Thu,  8 Oct 2026 04:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311351F000FF;
 Thu,  8 Oct 2026 04:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791432641;
 bh=GZSlpQodxJK+XbxCWa15cXuPSS2ykzM3XD//QZnSqi8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ko7bUlR+UGNIgXDHOMxCqM/s8xFqUktDnDtspYr7Qs/o6FQhWh2Bpd2sdp9HKGfm9
 CkLUx90hYYf8mYvANdlhRHqgZz0LxcoZyAYDkPawCDF/+JUbgTlTkdW3Bn1Jat6CXg
 r4IQcr+Hu2JqSoH/UxSvn+zVC3gtsA5rJb3Caapo+P/rhkwG380+hC3FzdDWDsniPf
 LHr+R0X230JQpFnd9ItbG7ZsQTzUmt0JrTNeidf51/Y8JYSyiQuqyV220wC7yqM9Vd
 dbAxNPNsNijg9/5stDWgHqJVHU2kG2LKcMr97LvEnuU98ZGsHJ4X3IWy4bMMtYiFAv
 ClUhtHyh68C6w==
Message-ID: <sashiko-outbox-163605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 16/19] accel/amdxdna: Implement AIE4 command packet
 building and submission
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-17-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-17-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 04:10:40 +0000
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
- [Critical] amdxdna: DMA UAF via user-writable UMQ read index spoofing
- [High] amdxdna: out-of-bounds read of dpu->chained before payload size va=
lidation
- [High] drm: dma_fence_context_alloc() per job breaks dma_resv timeline co=
alescing
--

commit 2abb65f20d471579d835973557557cc2b94cacf8
Author: David Zhang <yidong.zhang@amd.com>
Subject: accel/amdxdna: Implement AIE4 command packet building and submissi=
on

This patch implements kernel-mode command submission and hardware queue pac=
ket
assembly for AIE4. It adds functions to validate command buffers, build
direct and indirect packets, and manage fence contexts for jobs. It also
holds references to sub-command BOs during chained submissions to prevent
use-after-free conditions.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> index 09c92b1b5134e..31bf30b9dc86a 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c

[ ... ]

> @@ -469,3 +502,717 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 =
seq, u32 timeout)

[ ... ]

> +static int validate_cmd_abo(struct amdxdna_dev *xdna, struct amdxdna_gem=
_obj *cmd_abo,
> +			    struct amdxdna_cmd_start_dpu **dpu_out, u16 *chained_cnt)
> +{
> +	struct amdxdna_cmd_start_dpu *dpu;
> +	u32 payload_size;
> +	u16 chained;
> +	u32 op;
> +	u16 i;
> +
> +	op =3D amdxdna_cmd_get_op(cmd_abo);
> +	if (op !=3D ERT_START_DPU) {
> +		XDNA_ERR(xdna, "Invalid exec buf op, %d", op);
> +		return -EINVAL;
> +	}
> +
> +	dpu =3D amdxdna_cmd_get_payload(cmd_abo, &payload_size);
> +	if (!dpu) {
> +		XDNA_ERR(xdna, "Invalid DPU payload");
> +		return -EINVAL;
> +	}
> +	chained =3D READ_ONCE(dpu->chained);
> +	if (chained >=3D HSA_MAX_LEVEL1_INDIRECT_ENTRIES ||
> +	    payload_size < (u32)(chained + 1) * sizeof(*dpu)) {

[Severity: High]
Does this code risk an out-of-bounds read if the user supplies a command BO
where the payload pointer falls at the very end of a mapped page?

The speculative read of dpu->chained happens before the payload_size is
validated to be at least sizeof(*dpu). If the payload leaves fewer bytes
than sizeof(*dpu) at the end of a page and the adjacent page is unmapped,
accessing dpu->chained could cause a fatal kernel page fault.

Should the payload_size check for at least sizeof(*dpu) happen before
accessing any fields from dpu?

> +		XDNA_ERR(xdna, "Invalid DPU chained entries %u, payload %u",
> +			 chained, payload_size);
> +		return -EINVAL;
> +	}

[ ... ]

> +static void job_worker(struct work_struct *work)
> +{
> +	struct amdxdna_hwctx_priv *priv =3D
> +		container_of(work, struct amdxdna_hwctx_priv, job_work);
> +	struct amdxdna_hwctx *hwctx =3D priv->hwctx;
> +	struct amdxdna_sched_job *job;
> +
> +	while ((job =3D peek_running_job(hwctx))) {
> +		wait_till_seq_completed(hwctx, job->seq);
> +		if (get_read_index(hwctx) > job->seq) {

[Severity: Critical]
Can this implementation be tricked by userspace into releasing BOs while the
hardware is still executing?

The kernel determines job completion by reading the hardware completion sta=
tus
from a memory location via get_read_index(), which points to a GEM object
allocated by the user.

If malicious userspace maps this object as writable and manually advances t=
he
read_index to match the write_index, the worker would see completion and
call job_complete(). This would prematurely signal the job's fence and drop
references to the command and argument BOs.

Since the fence is signaled, userspace can free the BOs immediately, causing
the physical pages to be returned to the system while the NPU hardware might
continue executing and DMA-ing to those pages. Could this lead to memory
corruption on systems using iommu=3Dpt?

> +			dequeue_running_job(hwctx, job);
> +			/* Abort partially submitted jobs; complete fully submitted ones. */
> +			if (job->aie4_job_state !=3D AIE4_JOB_STATE_SUBMITTED)
> +				job_abort(job);
> +			else
> +				job_complete(job);
> +		} else if (aie4_hwctx_has_error(hwctx)) {
> +			dequeue_running_job(hwctx, job);
> +			job_abort(job);
> +		} else {
> +			/* suspend/resume */
> +			break;
> +		}
> +	}
> +}

[ ... ]

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 888e857ec5582..608b86fe8f6bb 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c

[ ... ]

> @@ -55,9 +51,9 @@ static struct dma_fence *amdxdna_fence_create(struct am=
dxdna_hwctx *hwctx)
>  	if (!fence)
>  		return NULL;
> =20
> -	fence->hwctx =3D hwctx;
>  	spin_lock_init(&fence->lock);
> -	dma_fence_init(&fence->base, &fence_ops, &fence->lock, hwctx->id, 0);
> +	/* Unique timeline context prevents eviction from shared BO reservation=
. */
> +	dma_fence_init(&fence->base, &fence_ops, &fence->lock, dma_fence_contex=
t_alloc(1), 0);

[Severity: High]
Can allocating a unique context per job break dma_resv timeline coalescing
and cause unbounded kernel memory allocation?

By using dma_fence_context_alloc(1) for every job, each job gets a unique
timeline context. When dma_resv_add_fence() adds these fences to a shared BO
in fence_job_bos(), it cannot identify older fences as belonging to the same
timeline because dma_fence_is_later_or_same() will fail to match contexts.

If userspace spawns multiple threads to concurrently submit jobs referencing
the same shared BO, could dma_resv accumulate every unsignaled fence and gr=
ow
its internal array linearly until the jobs complete, potentially leading to
OOM or page allocation failures?

>  	return &fence->base;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D16
