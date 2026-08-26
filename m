Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB3BC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759A910E2B4;
	Wed, 26 Aug 2026 14:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FmoimfpO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384CD10E2B4
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:43:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6E1E4028D;
 Wed, 26 Aug 2026 14:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A731D1F000E9;
 Wed, 26 Aug 2026 14:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787755387;
 bh=KGsN8Oi2CCV2OCB/OEFITlbj1Gh64f6IirrHwlBEZKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FmoimfpOn/1nky9fHsTrjcV4YxhPu1K9fGKtkfNtu0iSkOs99j05lPWv+7Euk1Nr6
 vLDDAbVe4IdMRHy5HWEK8joOwp+OJuwtfoZZ6m4bbS0uTKzpBn3uK1muXyOf9eJ3DP
 xrwXNBlp9cFpqSWT+AGktHJKGRW+gRx7yZegWtgKUxnOtTYS5cyZEefpPqYvuYJV55
 5VpUOJ1m6ybS+vU+2SVmVb2A0iSmWM3yzpMqlk1Wys7VN4sECMixca8Z/kCE+jWOLk
 FHQtDN+Ot11eeJ/5OdUNxp9ecAdvsz5rF6RuakMn9Ug4fjjhi2mNxfILOkNFSCydMo
 Q6tBdn0E11s+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] accel/amdxdna: check the command chain payload
 before using it
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826143036.100089-2-taimuraz@kaitmazov.com>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
 <20260826143036.100089-2-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 14:43:07 +0000
Message-Id: <20260826144307.A731D1F000E9@smtp.kernel.org>
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
- [Medium] Missing READ_ONCE() when reading `cc->command_count` from a user=
-space mapped buffer introduces a Time-of-Check to Time-of-Use (TOCTOU) vul=
nerability.

Pre-existing issues:
- [High] Reference leak for the chained GEM object `abo` in `amdxdna_cmd_se=
t_error()` when `amdxdna_gem_vmap()` fails.
- [High] Unprotected access to user-mapped flexible array `cc->data[0]` cau=
ses data races and triggers UBSAN panics via `__counted_by`.
--

commit a1b05572fd8c69d4959c5969b2a34b2e5ce07591
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: accel/amdxdna: check the command chain payload before using it

This commit introduces a new function amdxdna_cmd_get_chain() to ensure the
chain payload of a BO is checked before use. It makes the size parameter
mandatory in amdxdna_cmd_get_payload() and updates amdxdna_cmd_set_error()
to utilize the new chain validation logic.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 855da8c79a1cd..143cbbbf4b310 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c

> [ ... ]

> @@ -125,20 +125,42 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_ob=
j *abo, u32 *size)

> [ ... ]

> +/*
> + * Returns the chain payload of @abo, with @count set to a command count=
 that
> + * has been checked to fit. The chain fields live in a BO user space kee=
ps
> + * mapped, so nothing may read them without going through here.
> + */
> +struct amdxdna_cmd_chain *
> +amdxdna_cmd_get_chain(struct amdxdna_gem_obj *abo, u32 *count)
> +{
> +	struct amdxdna_cmd_chain *cc;
> +	u32 len, ccnt;
> +
> +	cc =3D amdxdna_cmd_get_payload(abo, &len);
> +	if (!cc || len < sizeof(*cc))
> +		return NULL;
> +
> +	ccnt =3D cc->command_count;
> +	if (len < struct_size(cc, data, ccnt))
> +		return NULL;
> +
> +	*count =3D ccnt;

[Severity: Medium]
Since the memory for cc resides in a GEM object mapped to userspace, can the
compiler perform multiple memory loads of cc->command_count here because it
lacks a READ_ONCE() wrapper?

If a user modifies cc->command_count concurrently between the struct_size()
bounds check and the assignment to *count, could this bypass the newly added
bounds check and pass a larger ccnt to the caller?

> +	return cc;
> +}

> [ ... ]

> @@ -177,8 +199,13 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *ab=
o,
>  	cmd->header |=3D FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
> =20
>  	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN) {
> -		cc =3D amdxdna_cmd_get_payload(abo, NULL);
> -		cc->error_index =3D (cmd_idx < cc->command_count) ? cmd_idx : 0;
> +		u32 ccnt;
> +
> +		cc =3D amdxdna_cmd_get_chain(abo, &ccnt);
> +		if (!cc || !ccnt)
> +			return -EINVAL;
> +
> +		cc->error_index =3D (cmd_idx < ccnt) ? cmd_idx : 0;
>  		abo =3D amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);

[Severity: High]
This is a pre-existing issue, but since struct amdxdna_cmd_chain defines da=
ta
as a flexible array u64 data[] __counted_by(command_count), does accessing
cc->data[0] dynamically re-read cc->command_count from memory to assert
0 < command_count?

If cc is backed by user-mapped memory, couldn't a malicious user concurrent=
ly
write 0 to command_count, causing the dynamically validated access to fail
and trigger a UBSAN kernel panic if CONFIG_UBSAN_BOUNDS is enabled?

>  		if (!abo)
>  			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this function leak the reference to
the chained GEM object abo if amdxdna_gem_vmap() fails?

Looking at amdxdna_cmd_set_error(), it successfully looks up the chained BO
using amdxdna_gem_get_obj(), which increments its reference count:

	abo =3D amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
	if (!abo)
		return -EINVAL;
	cmd =3D amdxdna_gem_vmap(abo);
	if (!cmd)
		return -ENOMEM;

If amdxdna_gem_vmap() fails, the function returns -ENOMEM without calling
amdxdna_gem_put_obj(abo). Can an unprivileged user trigger this by causing
job failures under memory pressure or by crafting a BO that fails to map,
leading to a memory leak and eventual Denial of Service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826143036.1000=
89-1-taimuraz@kaitmazov.com?part=3D1
