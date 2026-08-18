Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3962C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C4E10E3E1;
	Tue, 18 Aug 2026 00:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pqw0UePC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F123810E3E1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:38:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CEB043443;
 Tue, 18 Aug 2026 00:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE871F000E9;
 Tue, 18 Aug 2026 00:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787013508;
 bh=/YhfxYxLLnViO5nZ8X43Pzm2yRTiJT02z13fOH7uPjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pqw0UePCThSFyKRcH+oKDQuhi6HMSOUtL/3HNDWuyuWw5Ewxtp0oD3EEP7fQjLYM7
 1zcmdRadqVJQiFTfzHPcIzPHVMtOuhhuMS7RFSh1qF329Rfkh+D/CVDtTraoduQ75M
 AhSaOP87VWMLYa4ESdhXk65k3m47iATMxJ4FhLZfQ9WS98BxnfHl5QnsH9kxHGxxrc
 7xRmToEtUxFcOIDga8vU535dR07389DPum1NVN6HkjZkHAr7exfebzHgl1n2Jf4g9/
 VnzDiYC0j3U+5LCz+zJ7Q1qFeGghenEVbWFVCoLZcAwlzpfQvI1lnhUTocIUsV858Z
 juKlw3IILi/8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: check the command payload before using it
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818002459.377641-1-taimuraz@kaitmazov.com>
References: <20260818002459.377641-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 00:38:27 +0000
Message-Id: <20260818003828.0CE871F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] An out-of-bounds write of 4 bytes in `aie2_cmdlist_fill_npu_el=
f` leads to an integer underflow in `aie2_cmdlist_multi_execbuf`, enabling =
massive out-of-bounds memory corruption.
- [High] Leaked GEM object reference on error path in amdxdna_cmd_set_error=
().
--

--- Patch [1]: [PATCH] accel/amdxdna: check the command payload before usin=
g it ---
commit ec2f075309e2dcb4167331b4d2cc9a7b02abaa4a
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: check the command payload before using it

This commit fixes an issue where amdxdna_cmd_get_payload() could return NULL
without setting the size output parameter. Callers in aie2_message.c were u=
sing
the uninitialized size for bounds checking and copying from the NULL pointe=
r.
The fix clears the length before an early return and adds checks for the NU=
LL
pointer in callers.

> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna=
/aie2_message.c
> index dfe0fbdf066d2..6f258206d5080 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c

[ ... ]

> @@ -798,6 +812,8 @@ aie2_cmdlist_fill_npu_elf(struct amdxdna_gem_obj *cmd=
_bo, void *slot, size_t *si
>  	u32 arg_sz;
> =20
>  	pd =3D amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
> +	if (!pd)
> +		return -EINVAL;
>  	arg_sz =3D cmd_len - sizeof(*pd);
>  	if (cmd_len < sizeof(*pd) || arg_sz > MAX_NPU_ARGS_SIZE)
>  		return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but if arg_sz is 0, the bounds check incorrec=
tly
permits a size of exactly sizeof(*npu_slot), yet args[0] is unconditionally
written:

drivers/accel/amdxdna/aie2_message.c:aie2_cmdlist_fill_npu_elf() {
    ...
	if (*size < sizeof(*npu_slot) + arg_sz)
		return -EINVAL;

	memset(npu_slot, 0, sizeof(*npu_slot));
    ...
	npu_slot->arg_cnt =3D 1;
	npu_slot->args[0] =3D AIE2_EXEC_BUFFER_KERNEL_OP_TXN;

	*size =3D struct_size(npu_slot, args, npu_slot->arg_cnt);
    ...
}

Does this unconditionally write args[0], causing a 4-byte out-of-bounds
write?

And if so, does it also lead to an integer underflow in
aie2_cmdlist_multi_execbuf()?

drivers/accel/amdxdna/aie2_message.c:aie2_cmdlist_multi_execbuf() {
    ...
		size =3D cmdbuf_abo->mem.size - offset;
		ret =3D aie2_cmdlist_fill_slot(cmd_buf + offset, abo, &size, &op);
		amdxdna_gem_put_obj(abo);
		if (ret)
			return ret;

		offset +=3D size;
    ...
}

If the previous 4-byte overflow artificially inflates size, can offset exce=
ed
cmdbuf_abo->mem.size, causing size to underflow on the next loop iteration
and disable bounds checks for subsequent payloads?

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 31a414c3f0d96..505c249e142e6 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -117,6 +117,9 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj =
*abo, u32 *size)
>  	struct amdxdna_cmd *cmd =3D amdxdna_gem_vmap(abo);
>  	u32 num_masks, count;
> =20
> +	if (size)
> +		*size =3D 0;
> +
>  	if (!cmd)
>  		return NULL;
> =20

[Severity: High]
This is a pre-existing issue, but does the error path in
amdxdna_cmd_set_error() leak a GEM object reference?

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_cmd_set_error() {
    ...
	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN) {
		cc =3D amdxdna_cmd_get_payload(abo, NULL);
		cc->error_index =3D (cmd_idx < cc->command_count) ? cmd_idx : 0;
		abo =3D amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
		if (!abo)
			return -EINVAL;
		cmd =3D amdxdna_gem_vmap(abo);
		if (!cmd)
			return -ENOMEM;
    ...
}

If amdxdna_gem_vmap() fails, it returns -ENOMEM without calling
amdxdna_gem_put_obj() to release the abo obtained from amdxdna_gem_get_obj(=
).
Does this lead to a memory leak of the GEM object under memory pressure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818002459.3776=
41-1-taimuraz@kaitmazov.com?part=3D1
