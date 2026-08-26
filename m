Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DECC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695C210E332;
	Wed, 26 Aug 2026 22:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dFbkxcMO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9526D10E332
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 22:27:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FD0760A63;
 Wed, 26 Aug 2026 22:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3909C1F000E9;
 Wed, 26 Aug 2026 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787783272;
 bh=cLB1QivCx4eJL3drJsSbykFG6BFK9jYfOi6iXB689ZI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dFbkxcMOG/v+g0IyGTfwpzNh9fFZLidPPPYh1t0SM0/cE/upEiZDyreoUMNEY0btz
 kG9r9fgS95VdfhG0ge+MSxeWg5Hma4hKLPWSzAGwAIWaV7qJpGOHjUopmLnWMbCa7y
 MaEq3QzZwiqqc0FEg8LHSoMwobBgLWmQQsY0qNd+s2E95CfCRbNk2I0Pmu0z4nKT7y
 C+M869iKZoEftMUcLh3qtboexMDcRrGDGOCsIZ8AEP2KW/sE8gdSQk0Ro2UBCG1l1M
 BOEimTGf8Y5d2Y2RXdrAA716KQ3I3lymHAOhMpI8IzM1Smglg9JiWwH7mGMKMND1Qy
 rEh2Tobw794jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] accel/amdxdna: use READ_ONCE/WRITE_ONCE on the
 command header
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826221334.625974-1-taimuraz@kaitmazov.com>
References: <a203be1c-d28d-c33e-0a94-da725ec2d5aa@amd.com>
 <20260826221334.625974-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 22:27:51 +0000
Message-Id: <20260826222752.3909C1F000E9@smtp.kernel.org>
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

New issues:
- [High] The patch fails to resolve the TOCTOU vulnerability because it iss=
ues multiple independent `READ_ONCE(cmd->header)` calls instead of storing =
a single local snapshot.

Pre-existing issues:
- [High] Undefined behavior caused by passing a `NULL` source pointer to `m=
emcpy()` when parsing an empty command payload.
- [High] Uninitialized kernel stack memory is sent to the hardware mailbox,=
 causing an information leak.
--

commit c8e0faf1355b7f70321f8abedf7d99ec0ac63c46
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

    accel/amdxdna: use READ_ONCE/WRITE_ONCE on the command header

This commit attempts to fix a TOCTOU race condition in the command header
parsing by using READ_ONCE and WRITE_ONCE macros. It aims to read the
user-mapped command header once into a local variable to prevent the
compiler from splitting loads.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 888e857ec5582..02027522210d9 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -123,10 +123,11 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_ob=
j *abo, u32 *size)
>  	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN)
>  		num_masks =3D 0;
>  	else
> -		num_masks =3D 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
> +		num_masks =3D 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK,
> +					  READ_ONCE(cmd->header));
> =20
>  	if (size) {
> -		count =3D FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
> +		count =3D FIELD_GET(AMDXDNA_CMD_COUNT, READ_ONCE(cmd->header));

[Severity: High]
Does this actually fix the race condition? The commit message explicitly
claims to fix this by reading the header "once into a local with
READ_ONCE()".

Because READ_ONCE() enforces a volatile memory access, the compiler is
forced to issue multiple distinct memory loads for the opcode,
EXTRA_CU_MASK, and COUNT fields.

Could the fields still be fetched from different snapshots of the header,
maintaining the TOCTOU vulnerability?

>  		if (unlikely(count <=3D num_masks ||
>  			     count * sizeof(u32) +
>  			     offsetof(struct amdxdna_cmd, data[0]) >
> @@ -151,7 +152,7 @@ u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *ab=
o)
>  	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN)
>  		return INVALID_CU_IDX;
> =20
> -	num_masks =3D 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
> +	num_masks =3D 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, READ_ONCE(cmd->h=
eader));

[Severity: High]
Does this suffer from the same issue? amdxdna_cmd_get_op() already reads
the header, and here it is read again with a separate READ_ONCE(), rather
than using a single local variable.

[ ... ]

> @@ -169,12 +170,15 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *a=
bo,
>  	struct amdxdna_client *client =3D job->hwctx->client;
>  	struct amdxdna_cmd *cmd =3D amdxdna_gem_vmap(abo);
>  	struct amdxdna_cmd_chain *cc =3D NULL;
> +	u32 header;
> =20
>  	if (!cmd)
>  		return -ENOMEM;
> =20
> -	cmd->header &=3D ~AMDXDNA_CMD_STATE;
> -	cmd->header |=3D FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
> +	header =3D READ_ONCE(cmd->header);
> +	header &=3D ~AMDXDNA_CMD_STATE;
> +	header |=3D FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
> +	WRITE_ONCE(cmd->header, header);
> =20
>  	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN) {

[Severity: High]
Does this code read the header again after modifying it?

amdxdna_cmd_get_op() internally does a READ_ONCE(cmd->header), which
happens right after the write. Could it end up reading a newly injected
opcode if userspace modifies the header concurrently?

[Severity: High]
This isn't a bug introduced by this patch, but could this trigger undefined
behavior if a user passes an empty payload?

If a userspace application configures a command buffer with
count <=3D num_masks, amdxdna_cmd_get_payload() can validly return NULL:

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_cmd_get_payload() {
    ...
		if (unlikely(count <=3D num_masks ||
			     count * sizeof(u32) +
			     offsetof(struct amdxdna_cmd, data[0]) >
			     abo->mem.size)) {
			*size =3D 0;
			return NULL;
		}
    ...
}

In drivers/accel/amdxdna/aie2_message.c:aie2_init_exec_cu_req(), the
returned pointer is passed directly to memcpy() without validation:

	cmd =3D amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
	if (cmd_len > sizeof(cu_req->payload))
		return -EINVAL;

	cu_req->cu_idx =3D amdxdna_cmd_get_cu_idx(cmd_bo);
	if (cu_req->cu_idx =3D=3D INVALID_CU_IDX)
		return -EINVAL;

	memcpy(cu_req->payload, cmd, cmd_len);

Passing a NULL pointer to memcpy() triggers undefined behavior according
to the C standard, even if the length is 0. Will this cause a kernel
panic if panic_on_warn is enabled when UBSAN catches this?

[Severity: High]
This is a pre-existing issue, but does this leak uninitialized stack
memory to the hardware mailbox?

In drivers/accel/amdxdna/aie2_message.c:aie2_execbuf(), an uninitialized
union is allocated on the stack:

	union exec_req req;
    ...
	ret =3D aie2_init_exec_req(&req, cmd_abo, &msg.send_size, &msg.opcode);

If aie2_init_exec_cu_req() processes a small payload (e.g. cmd_len =3D 0),
the remainder of the payload array retains uninitialized stack contents:

	memcpy(cu_req->payload, cmd, cmd_len);
	*size =3D sizeof(*cu_req);

Could the remaining 76 bytes of uninitialized kernel stack memory be
transmitted when xdna_mailbox_send_msg() is called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826221334.6259=
74-1-taimuraz@kaitmazov.com?part=3D1
