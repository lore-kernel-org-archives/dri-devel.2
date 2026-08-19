Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A158C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 23:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8347910E012;
	Wed, 19 Aug 2026 23:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YabKA6dL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BA010E012
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 23:19:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C7A140870;
 Wed, 19 Aug 2026 23:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3DB1F000E9;
 Wed, 19 Aug 2026 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787181563;
 bh=5602htgj7twMP7Zhor6Dt4FdosG2n+g/4Rf+qtQYlRo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YabKA6dLKDnuiUVogjiTG/SrcWn2iCuqxRWOb1cWcb/1++12SZeyRhWBtFpFoNZA7
 F9/wKz2ztyRpyTdulUsT0wozFvw7y6wuNhbzRdNJjuJiZkGaBiNtWwQrjA21USjkKg
 RRkuzaDLrICI7Rw6cFHx6myvMpXNUWvYFjqVDJwe4pcsyX5VlRe1m5o5ZUQ4qM7k7g
 EySPyYXxvbF4ny9SKFCaduiJzM9dEvE809vBKaveHNv6/rA0XD4zzqJxZUvuNrLAaw
 asKMX13niE3xHcjhz0Dp8ub+AYegp6k4+E69ohXkUMcULZ+KrB3iC+289Mz3EBf2hu
 f1xpqGlQEl4ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: put the chained BO when its mapping fails
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819230721.287529-1-taimuraz@kaitmazov.com>
References: <20260819230721.287529-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 23:19:22 +0000
Message-Id: <20260819231923.2B3DB1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Kernel panic via `__counted_by` array bounds violation when us=
erspace supplies `command_count =3D=3D 0`.
--

--- Patch [1]: [PATCH] accel/amdxdna: put the chained BO when its mapping f=
ails ---
commit 78a13180a3a2715c4d150e03603955519d45a53a
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: put the chained BO when its mapping fails

This commit fixes a reference leak in amdxdna_cmd_set_error(). When the
chained BO fails to map, the previously acquired reference on the BO is now
properly dropped.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 31a414c3f0d96..888e857ec5582 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *ab=
o,
>  		if (!abo)
>  			return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but does this code unconditionally access
cc->data[0] before reaching here?

Looking slightly above this diff hunk in amdxdna_cmd_set_error():

	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN) {
		cc =3D amdxdna_cmd_get_payload(abo, NULL);
		cc->error_index =3D (cmd_idx < cc->command_count) ? cmd_idx : 0;
		abo =3D amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);

Because the data flexible array member in struct amdxdna_cmd_chain is
annotated with __counted_by(command_count), accessing cc->data[0] when
command_count is 0 will result in an array bounds violation.

Can a user intentionally trigger a kernel panic and a local denial of servi=
ce
by submitting a crafted ERT_CMD_CHAIN with command_count =3D=3D 0 that late=
r times
out or fails?

>  		cmd =3D amdxdna_gem_vmap(abo);
> -		if (!cmd)
> +		if (!cmd) {
> +			amdxdna_gem_put_obj(abo);
>  			return -ENOMEM;
> +		}
>  	}
> =20
>  	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819230721.2875=
29-1-taimuraz@kaitmazov.com?part=3D1
