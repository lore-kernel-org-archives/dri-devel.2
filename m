Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80906C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A644610E485;
	Wed, 30 Sep 2026 04:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OrXaGufs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C4D510E485
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:04:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C54B60236;
 Wed, 30 Sep 2026 04:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66771F000FF;
 Wed, 30 Sep 2026 04:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790741057;
 bh=wse0xj7VtWPGcqKK4uH6YL4bz7s+dsqDDWkYHql6qzw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OrXaGufsmtgGEtq/4L8xTAsPZQ2jzHjC+OBk4q3sg7t+2xSumKBhbZ+diKG8852h2
 /RbiPA4odB3bU90LAjNnT9CGOOfnBf1+FiteWhIFpw5aRFK8GpbI7Rb/hJgh5vK7tr
 60MH+HqcweNIMVVUUg7+sjg9+cSAZFSehIEqWK4xH3hMmTNbnT8kJDi6ENFlnW6CAq
 nByx/vfMtUHYOmQqmdAEOvIBQO7xWhS4GZan5GTk80WOFeYuvtyboA4AAp29dOL5Ql
 /zHlY5utvFlXdNJV5ZNZtr97Ck6dKpCnnwIvhSUUHgSKOgU2Stf4hj9GKfdlW+h1h9
 MktivOf37trPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 14/20] accel/amdxdna: Implement AIE4 command packet
 building and submission
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-15-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-15-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:04:16 +0000
Message-Id: <20260930040416.D66771F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] accel/amdxdna: TOCTOU in submit_job_cmds allows arbitrary DMA =
to freed memory (UAF)
- [High] accel/amdxdna: Unhandled mid-chain submission failure permanently =
hangs dma_fence
- [High] accel/amdxdna: dtrace_buffer address truncated to 48 bits, corrupt=
ing memory
- [High] accel/amdxdna: dma_fence uses unreferenced struct device pointer c=
ausing UAF
- [High] accel/amdxdna: Submitter holding SRCU lock waits forever for recon=
nect, deadlocking teardown
- [High] accel/amdxdna: Missing READ_ONCE allows double-fetch of user-share=
d control fields
--

commit 3eb430c5785965c7805a7d4c133aa9e24f11869b
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Implement AIE4 command packet building and submission

Implement kernel-mode command submission and hardware queue packet
assembly for AIE4.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c

[ ... ]

> @@ -622,7 +622,10 @@ static int wait_till_connected_hsa_not_full(struct a=
mdxdna_hwctx *hwctx,
>  			if (!ret)
>  				hsa_not_full =3D true;
>  		}
>  		ret =3D wait_event_freezable(priv->job_list_wq,
>  					   aie4_hwctx_connected(hwctx) ||
>  					   (!wait_through_reset &&
>  					    aie4_hwctx_has_reset(hwctx)));

[Severity: High]
Can this block indefinitely and cause an SRCU deadlock?

When wait_through_reset is true for the first command, the wait condition
completely ignores the reset or error state. Since the submitter thread hol=
ds
the hwctx_srcu read lock, if a device unplug occurs and the teardown thread
calls synchronize_srcu(), the teardown will wait forever for this lock to be
released, while this code waits for a reconnect that will never happen.

>  		mutex_lock(&priv->io_lock);

[ ... ]

> @@ -696,7 +699,8 @@ static int fill_indirect_pkt(struct amdxdna_hwctx_pri=
v *priv, u64 slot_idx,
>  	for (i =3D 0; i < entries; i++, dpu++, hipe++) {
>  		struct host_indirect_packet_data *hipd;
>  		u64 indirect_pkt_dev_addr;
>  		u32 uci =3D dpu->uc_index;

[Severity: High]
Can the compiler double-fetch dpu->uc_index from shared memory here?

Because READ_ONCE() is missing, a concurrent userspace thread could modify
the value immediately after the bounds check against
HSA_MAX_LEVEL1_INDIRECT_ENTRIES, allowing an out-of-bounds array index into
priv->umq_indirect_pkts[idx] later in this function.

>  		u32 idx;
> =20
>  		/*

[ ... ]

> @@ -715,7 +718,8 @@ static int fill_indirect_pkt(struct amdxdna_hwctx_pri=
v *priv, u64 slot_idx,
>  			upper_32_bits(dpu->instruction_buffer);
>  		hipd->payload.dtrace_buf_host_addr_low =3D
>  			lower_32_bits(dpu->dtrace_buffer);
>  		hipd->payload.dtrace_buf_host_addr_high =3D
>  			lower_16_bits(upper_32_bits(dpu->dtrace_buffer));

[Severity: High]
Does this truncate the 64-bit user address to 48 bits?

By using lower_16_bits(upper_32_bits()), bits 48-63 of the virtual address
are silently dropped. On SVA/IOMMU platforms with 5-level paging, user
virtual addresses can reach 57 bits, which might cause the hardware to write
trace data to unintended memory locations.

>  	}
>  	pkt->pkt_header.common_header.distribute =3D 1;

[ ... ]

> @@ -730,7 +732,8 @@ static void fill_direct_pkt(struct amdxdna_hwctx_priv=
 *priv, u64 slot_idx,
>  	ebuf->dpu_control_code_host_addr_high =3D upper_32_bits(dpu->instructio=
n_buffer);
>  	ebuf->dtrace_buf_host_addr_low =3D lower_32_bits(dpu->dtrace_buffer);
>  	ebuf->dtrace_buf_host_addr_high =3D lower_16_bits(upper_32_bits(dpu->dt=
race_buffer));

[Severity: High]
Similar to fill_indirect_pkt(), can this truncate the user address to 48
bits, potentially corrupting memory on systems with 5-level paging?

>  	pkt->pkt_header.common_header.distribute =3D 0;

[ ... ]

> @@ -772,7 +774,8 @@ static int submit_one_cmd(struct amdxdna_hwctx *hwctx,
>  	 * against the actual payload size before dereferencing chained+1 DPU
>  	 * entries, so a bogus count cannot drive an out-of-bounds read.
>  	 */
>  	chained =3D dpu->chained;

[Severity: High]
Could the lack of READ_ONCE() here allow a double-fetch of dpu->chained?

If userspace modifies this value after the bounds check, it could bypass the
validation.

>  	if (chained >=3D HSA_MAX_LEVEL1_INDIRECT_ENTRIES) {
>  		XDNA_ERR(xdna, "Invalid DPU data");

[ ... ]

> @@ -1012,7 +1014,8 @@ static int submit_job_cmds(struct amdxdna_hwctx *hw=
ctx,
>  		XDNA_ERR(xdna, "Invalid cmd payload for chained cmd");
>  		return -EINVAL;
>  	}
>  	ccnt =3D payload->command_count;

[Severity: High]
Since payload points to a GEM object mapped into user memory, can the compi=
ler
optimize this and re-fetch payload->command_count after the bounds validati=
on?

Without READ_ONCE(), userspace could potentially modify the count concurren=
tly
to bypass the checks and trigger out-of-bounds reads.

>  	/*
>  	 * A chain (runlist) must fit within the queue. CERT advances the host-=
visible

[ ... ]

> @@ -1032,15 +1034,22 @@ static int submit_job_cmds(struct amdxdna_hwctx *=
hwctx,
>  	for (i =3D 0; i < ccnt; i++) {
>  		u32 boh =3D (u32)(payload->data[i]);
>  		struct amdxdna_gem_obj *abo;
> =20
>  		abo =3D amdxdna_gem_get_obj(hwctx->client, boh, AMDXDNA_BO_SHARE);
>  		if (!abo) {
>  			XDNA_ERR(xdna, "Failed to find cmd BO %u", boh);
>  			ret =3D -ENOENT;
>  			break;
>  		}
> =20
>  		/*
>  		 * submit_one_cmd() blocks in wait_till_connected_hsa_not_full() until=
 the
>  		 * ctx is connected and a slot is free, so a concurrent suspend/discon=
nect
>  		 * is waited out inline rather than returned here. The first sub-comma=
nd
>  		 * (i =3D=3D 0, nothing published yet) waits through a TDR reset and r=
uns on
>  		 * the recreated ctx; a later sub-command returns -ECONNRESET if a res=
et
>  		 * landed while waiting for a slot, so the published prefix is not spl=
it
>  		 * across the reset. It also returns -ERESTARTSYS on a signal, or a
>  		 * validation error. Break on any; a published prefix is then reaped by
>  		 * the job worker's reset drain (see below).
>  		 */
>  		ret =3D submit_one_cmd(hwctx, abo, i + 1 =3D=3D ccnt, i =3D=3D 0, &job=
->seq);
>  		amdxdna_gem_put_obj(abo);

[Severity: Critical]
Does this allow arbitrary DMA to freed memory?

The driver reads the BO handle (boh) directly from the user-shared GEM obje=
ct.
Userspace can modify this handle concurrently after the DRM scheduler
validates job->bos.

Because this substituted BO is not part of job->bos, it lacks a tracking
fence. By immediately dropping the kernel reference via amdxdna_gem_put_obj=
(),
userspace can close the handle and free the memory while the hardware
asynchronously executes DMA operations on the freed physical memory.

>  		if (ret)
>  			break;

[ ... ]

> @@ -1054,6 +1056,7 @@ static int submit_job_cmds(struct amdxdna_hwctx *hw=
ctx,
>  	 * published prefix and reports the partial chain as failed (ABORT). On=
ly when
>  	 * nothing was published (i =3D=3D 0) is the error returned to the call=
er.
>  	 */
>  	if (i > 0)
>  		return 0;

[Severity: High]
If submit_one_cmd() fails for a sub-command mid-chain (e.g., due to an
invalid payload) after the first command is published, this masks the failu=
re
and returns success.

Since the final command is never published, CHAIN_FLG_LAST_CMD is never sent
to the hardware. Will this cause the hardware to wait indefinitely, prevent=
ing
job_done() from ever signaling the dma_fence?

> =20
>  	return ret;
>  }

[ ... ]

> @@ -1182,7 +1184,8 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, st=
ruct amdxdna_sched_job *job,
> =20
>  	job->out_fence =3D dma_fence_get(job->fence);
>  	for (i =3D 0; i < job->bo_cnt; i++)
>  		dma_resv_add_fence(job->bos[i]->resv, job->out_fence, DMA_RESV_USAGE_W=
RITE);

[Severity: High]
Following up on the mid-chain failure issue in submit_job_cmds(), since the
fence is attached to shared BOs here, if it never signals due to an abandon=
ed
hardware queue, won't any future access to those BOs by other processes hang
forever, creating a denial of service?

> =20
>  	up_read(&xdna->notifier_lock);

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c

[ ... ]

> @@ -47,7 +49,8 @@ static const char *amdxdna_fence_get_timeline_name(stru=
ct dma_fence *fence)
>  	 * another process). The device outlives any individual context, so
>  	 * dev_name() is safe to call at any point during the fence's lifetime.
>  	 */
>  	return dev_name(xdna_fence->dev);

[Severity: High]
Can this trigger a use-after-free if the sync_file outlives the DRM device?

Userspace querying the timeline after the device has been torn down or
hot-unplugged would access the freed struct device pointer here.

>  }
> =20

[ ... ]

> @@ -62,7 +65,8 @@ static struct dma_fence *amdxdna_fence_create(struct am=
dxdna_hwctx *hwctx)
>  	if (!fence)
>  		return NULL;
> =20
>  	fence->dev =3D hwctx->client->xdna->ddev.dev;

[Severity: High]
Does this store the struct device pointer without taking a reference via
get_device()?

This allows the use-after-free mentioned above when the fence outlives the
device.

>  	spin_lock_init(&fence->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D14
