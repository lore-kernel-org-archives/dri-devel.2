Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ACFCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8829C10F056;
	Tue,  6 Oct 2026 04:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tp9MJxS0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B0410F056
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:41:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED543602D3;
 Tue,  6 Oct 2026 04:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838041F000FF;
 Tue,  6 Oct 2026 04:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791261662;
 bh=UDXGuc/yvvvluopEoBJaeETI3AVysq4ApRcIqelBKj0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tp9MJxS0ypy1g27lP6yelAduWM3YCbItVkDxU5GP3WbuWJv8vC3sJVWH1iw6bombj
 1vBQte7mbMyTi+YD99kr/KcUTp8nfNPpIh29oUJ1vdOc1ZZq+uEy4R8CmALheSkPTV
 V6zlR7yoLR80F9U74qgTjsUoAsITXYb1el3Vq1lIVBBLdqiBPH8Zo7Me+QrNEbev/c
 NPcLmnI4U5XR9ATrtlbVli6ubGWlHbYhYA1evflQl6FNNQbJPH6E7SuA1y072ynxo/
 E2oFl28K8cQE2Plf84kGz/o+9TX6t0j+UHW8EPcG9eLDtkfsO5eX76hZCNGwLHV9e9
 5NSWdx7wGK7qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 14/20] accel/amdxdna: Implement AIE4 command packet
 building and submission
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006042230.547807-15-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
 <20261006042230.547807-15-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 04:41:02 +0000
Message-Id: <20261006044102.838041F000FF@smtp.kernel.org>
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
- [Critical] accel/amdxdna: TOCTOU out-of-bounds read/write in amdxdna_cmd_=
get_payload()
- [High] accel/amdxdna: chained sub-command BOs bypass fence attachment
--

commit c176cc9653a37bd631df8131c299b9255f903027
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Implement AIE4 command packet building and submission

This commit implements kernel-mode command submission and hardware queue
packet assembly for AIE4. It introduces aie4_cmd_submit() to validate
incoming command buffers, lock reservations, and dispatch to the hardware
queue while tracking job completions.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
[ ... ]
> @@ -731,21 +731,21 @@ static int submit_one_cmd(struct amdxdna_hwctx *hwc=
tx,
>  			  struct amdxdna_gem_obj *cmd_abo, bool last_of_chain,
>  			  u64 *seq)
>  {
>  	struct amdxdna_hwctx_priv *priv =3D hwctx->priv;
>  	struct amdxdna_dev *xdna =3D hwctx->client->xdna;
>  	struct amdxdna_cmd_start_dpu *dpu;
>  	struct host_queue_packet *pkt;
>  	u64 slot_idx;
>  	u16 chained;
>  	int ret;
> =20
>  	ret =3D validate_cmd_abo(xdna, cmd_abo, &chained);
>  	if (ret)
>  		return ret;
> =20
>  	dpu =3D amdxdna_cmd_get_payload(cmd_abo, NULL);

[Severity: Critical]
Is there a TOCTOU race window here between validation and payload retrieval?

Userspace can concurrently modify cmd_abo (which is a mapped BO) between
the bounds checks in validate_cmd_abo() and this call to
amdxdna_cmd_get_payload().

When the size argument is passed as NULL, amdxdna_cmd_get_payload() skips
its internal size bounds checks and computes the pointer offset directly
from the potentially modified header (AMDXDNA_CMD_EXTRA_CU_MASK).

This could allow it to return a pointer significantly out of bounds,
leading to an out-of-bounds read when dpu is subsequently accessed, or
potentially leaking arbitrary kernel memory to the hardware queue.

[ ... ]
> @@ -911,21 +911,21 @@ static int submit_job_cmds(struct amdxdna_hwctx *hw=
ctx,
>  			   struct amdxdna_sched_job *job, u32 op)
>  {
[ ... ]
>  	/* Validate all sub-command BOs and payloads before dispatching packets=
. */
>  	for (i =3D 0; i < ccnt; i++) {
>  		u32 boh =3D (u32)(payload->data[i]);
> =20
>  		job->aie4_cmd_bos[i] =3D amdxdna_gem_get_obj(hwctx->client, boh, AMDXD=
NA_BO_SHARE);
>  		if (!job->aie4_cmd_bos[i]) {
>  			XDNA_ERR(xdna, "Failed to find cmd BO %u at index %u", boh, i);
>  			ret =3D -ENOENT;
>  			goto err_put_bos;
>  		}

[Severity: High]
Does this skip dma_resv fence attachment and mapping checks for sub-command
BOs?

Userspace can submit an ERT_CMD_CHAIN job with sub-command handles in the
payload that are omitted from the ioctl's top-level args->bos array.

Because these sub-command BOs are fetched dynamically here from user handle=
s,
their reservations aren't locked and map_invalid is never checked before
dispatch.

[ ... ]
> @@ -1050,15 +1050,15 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, =
struct amdxdna_sched_job *job,
[ ... ]
>  	job->out_fence =3D dma_fence_get(job->fence);
>  	for (i =3D 0; i < job->bo_cnt; i++)
>  		dma_resv_add_fence(job->bos[i]->resv, job->out_fence, DMA_RESV_USAGE_W=
RITE);

[Severity: High]
Are the dynamically fetched sub-command BOs missing their execution fences?

The execution fences are exclusively attached to BOs present in the top-lev=
el
job->bos array.

Since the dynamically fetched sub-command BOs in job->aie4_cmd_bos bypass t=
his
fence attachment, hardware DMA can occur on BOs without a corresponding
dma_resv execution fence.

This might lead the memory manager to consider these BOs idle, potentially
reclaiming, migrating, or unmapping their pages while the device is actively
writing to them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006042230.5478=
07-1-yidong.zhang@amd.com?part=3D14
