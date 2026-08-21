Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025F1C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDF510E254;
	Fri, 21 Aug 2026 03:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YBgybVAF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B5B10E254
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 03:50:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7028160A58;
 Fri, 21 Aug 2026 03:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068651F000E9;
 Fri, 21 Aug 2026 03:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787284251;
 bh=nINPXTI1Wz9oWvwzY3oxNip/p4/H+LYDUGzbUmIpfXw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YBgybVAFtamqpKPuOOn8Vy+PKwCHutSiCmAhoVsGqsLYierdIscWYkvI0jKWokOhU
 72fQCU5+vuP2uxpC9eMuq+DqyTZYndqMdUot02p7ziA716BmEdNl/rCf7+xjzK+q2H
 EM8XdZz/WfmAuyIt/oU7O7eZePfu15VVqBKxzR4VTk4gIOoNRfH9Ohy83BsO+7QXfU
 nEKs9cjQQu5E0ETVAQZ9ilSKCQq4hfYQNbdQGU+PSf1V1HJq3mJeQ3cYWLGoGEoVHJ
 kTdRHoqtPv9/ceRzaAkOYbebMYVqCjsstOB2bQsx2eW12QNngw07FLEkZg6GNAnKxk
 /4bywwYjdBplQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Remove __counted_by from struct
 amdxdna_cmd_chain
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821033543.1839719-1-lizhi.hou@amd.com>
References: <20260821033543.1839719-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 03:50:50 +0000
Message-Id: <20260821035051.068651F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Reference count leak of a GEM object on an error path in `amdxdna_=
cmd_set_error()`.
- [High] Calling `memcpy` with a NULL source pointer when processing empty =
payloads.
- [High] Missing READ_ONCE() on shared memory reads allows compiler reloads=
, causing a Time-of-Check to Time-of-Use (TOCTOU) vulnerability that bypass=
es bounds checks.
--

--- Patch [1]: [PATCH V1] accel/amdxdna: Remove __counted_by from struct am=
dxdna_cmd_chain ---
commit fcdbc0a8d70945b3b3d7614f4b69f29895cd2af9
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Remove __counted_by from struct amdxdna_cmd_chain

The commit removes the __counted_by annotation from the data array in
struct amdxdna_cmd_chain. This prevents kernel panics caused by bounds
checks failing if userspace concurrently modifies command_count to zero
in shared memory.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/=
amdxdna_ctx.h
> index b6bef3af7dab4..6e78bab8a02c0 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -55,7 +55,7 @@ struct amdxdna_cmd_chain {
>  	u32 submit_index;
>  	u32 error_index;
>  	u32 reserved[3];
> -	u64 data[] __counted_by(command_count);
> +	u64 data[];
>  };

[Severity: High]
This is a pre-existing issue, but since this patch addresses concurrent
userspace modifications to command_count, are there other Time-of-Check to
Time-of-Use (TOCTOU) issues with this field?

Looking at drivers/accel/amdxdna/aie2_message.c:aie2_cmdlist_multi_execbuf(=
):

	ccnt =3D payload->command_count;
	if (payload_len < struct_size(payload, data, ccnt)) {
		XDNA_DBG(xdna, "Invalid command count %d", ccnt);
		return -EINVAL;
	}

	op =3D ERT_INVALID_CMD;
	for (i =3D 0; i < ccnt; i++) {
		u32 boh =3D (u32)(payload->data[i]);

Can the compiler reload payload->command_count inside the loop condition
since READ_ONCE() is not used? If userspace changes the value to a massive
number after the payload_len check passes, could this bypass the bounds
check and cause out-of-bounds reads on adjacent kernel memory?

A similar issue appears in
drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_cmd_get_payload() where
cmd->header is read multiple times:

	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN)
		num_masks =3D 0;
	else
		num_masks =3D 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);

	if (size) {
		count =3D FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
		if (unlikely(count <=3D num_masks ||
			     count * sizeof(u32) +
			     offsetof(struct amdxdna_cmd, data[0]) >
			     abo->mem.size)) {
			*size =3D 0;
			return NULL;
		}
		*size =3D (count - num_masks) * sizeof(u32);
	}

Could a compiler reload cause the calculated size to exceed the BO size?


[Severity: High]
This is a pre-existing issue, but does amdxdna_cmd_get_payload() return NULL
if the payload is empty?

In drivers/accel/amdxdna/aie2_message.c:aie2_init_exec_cu_req():

	cmd =3D amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
	if (cmd_len > sizeof(cu_req->payload))
		return -EINVAL;

	cu_req->cu_idx =3D amdxdna_cmd_get_cu_idx(cmd_bo);
	if (cu_req->cu_idx =3D=3D INVALID_CU_IDX)
		return -EINVAL;

	memcpy(cu_req->payload, cmd, cmd_len);

If userspace constructs a command BO where count <=3D num_masks,
amdxdna_cmd_get_payload() sets cmd_len to 0 and returns NULL. If a valid CU
index is still returned, this calls memcpy(cu_req->payload, NULL, 0).

Could this undefined behavior reliably crash the kernel if the UBSAN bounds
checker with panic_on_warn is enabled?

The same pattern seems to exist in aie2_cmdlist_fill_cf() and
aie2_cmdlist_fill_npu_cf().


[Severity: High]
This is a pre-existing issue, but is there a reference leak on the error pa=
th
in amdxdna_cmd_set_error()?

In drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_cmd_set_error():

	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN) {
		cc =3D amdxdna_cmd_get_payload(abo, NULL);
		cc->error_index =3D (cmd_idx < cc->command_count) ? cmd_idx : 0;
		abo =3D amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
		if (!abo)
			return -EINVAL;
		cmd =3D amdxdna_gem_vmap(abo);
		if (!cmd)
			return -ENOMEM;
	}

If amdxdna_gem_vmap(abo) fails, the function returns -ENOMEM early. Should
there be an amdxdna_gem_put_obj(abo) call to avoid leaking the GEM object
reference acquired by amdxdna_gem_get_obj()? Could a malicious userspace
repeatedly supply a BO handle that fails to map to cause unfreeable memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821033543.1839=
719-1-lizhi.hou@amd.com?part=3D1
