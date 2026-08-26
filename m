Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505BBC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE8210E2C6;
	Wed, 26 Aug 2026 14:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mqKsxTmC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1913A10E2C6
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:50:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E3D96001D;
 Wed, 26 Aug 2026 14:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60FC1F000E9;
 Wed, 26 Aug 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787755806;
 bh=JHthwPmnUi+JmfTFV9Eu0DxaofrSdWKBn+mG9uv0IqQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mqKsxTmCNBzHujz6+u/Dao7E5XZ6KfWl97PId9pMxVOf3AYO8B6nGtMu5Q+CYcuDt
 /h3ESj0voRIyFb6rmAFmifH2+sQJRMvOxl3GjXZ55VtZVDJXNwVdnwJoSqqrQddrt0
 7g3PA91MhfETUHvTnJz8tnQMrDdVlgDOYF14tMdAL3I7PHKS4rmPi4QSLgBg9L1lOa
 aWpPSDxl0Wa/DjjyJXnryXm3hy9syxFqlHomsB3NfmhXb9AalglI78ABA34TGJ+232
 Q7JPyEKiRpTE3FMYkUG24ElHkQ7WEcJDBZIhu0yjtD7NvkZ0r/O8UESiWpLcxcAez4
 TQ95RdKvDQLjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] accel/amdxdna: use READ_ONCE/WRITE_ONCE on the
 command header
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826143036.100089-3-taimuraz@kaitmazov.com>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
 <20260826143036.100089-3-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 14:50:06 +0000
Message-Id: <20260826145006.A60FC1F000E9@smtp.kernel.org>
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
- [High] Missing READ_ONCE on shared BO field `command_count` leaves it vul=
nerable to compiler refetching optimization.
- [High] Memory leak of a GEM object reference on the error path in `amdxdn=
a_cmd_set_error()`.
- [Medium] Race condition where the error state is written to the command h=
eader before the error payload is populated.
--

commit b8c13d2d8e5350b458948c5624a0d76772f2851a
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: use READ_ONCE/WRITE_ONCE on the command header

The driver modifies state flags in place, allowing the compiler to split or
refetch accesses. This patch annotates these accesses with READ_ONCE and
WRITE_ONCE to stop the compiler from optimizing them in unsafe ways.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 143cbbbf4b310..f809bec425a57 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c

[ ... ]

> @@ -191,12 +192,15 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *a=
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

[Severity: Medium]
This is a pre-existing issue, but does writing the error state here create a
race condition where user-space might read stale or garbage data?

The driver modifies the state flags in the shared cmd->header prior to
issuing the memset and memcpy to populate the error payload later in the
function:

	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
	if (err_data)
		memcpy(cmd->data, err_data, min(size, abo->mem.size - sizeof(*cmd)));

If user-space is polling the state field, could it see the error state and
immediately read the payload before the driver has finished writing it?

[Severity: High]
This is also a pre-existing issue in this same function, but does this code
leak a GEM object reference on the error path?

If amdxdna_gem_vmap() fails after acquiring the abo reference, the code
returns -ENOMEM without calling amdxdna_gem_put_obj():

	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN) {
		...
		abo =3D amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
		if (!abo)
			return -EINVAL;
		cmd =3D amdxdna_gem_vmap(abo);
		if (!cmd)
			return -ENOMEM;
	}

Could successive failures eventually exhaust kernel memory resources?

[Severity: High]
This isn't a bug introduced by this patch, but while annotating BO memory
accesses with READ_ONCE, are there other places where shared BO fields are
read without it?

For instance, command_count is read from shared memory and used in bounds
checks in aie2_cmdlist_multi_execbuf():

	ccnt =3D payload->command_count;
	if (payload_len < struct_size(payload, data, ccnt)) {
		...
		for (i =3D 0; i < ccnt; i++)

And similarly in amdxdna_cmd_get_chain():

	ccnt =3D cc->command_count;
	if (len < struct_size(cc, data, ccnt))

Could the compiler refetch command_count from shared memory after the bounds
check?

If user space concurrently modifies the value after the bounds check, could
the subsequent loop read out-of-bounds kernel memory, potentially leading to
a kernel page fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826143036.1000=
89-1-taimuraz@kaitmazov.com?part=3D2
