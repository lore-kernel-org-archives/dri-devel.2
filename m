Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628AC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E588110E2E1;
	Wed, 26 Aug 2026 15:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IEvt+WcB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E7C10E2E1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 15:48:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 907BB41FE8;
 Wed, 26 Aug 2026 15:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454671F00A3D;
 Wed, 26 Aug 2026 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787759327;
 bh=PpxIDv5r7KhTKiI5yru91c662Y9ad2Qwe9KGXgWJwbQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IEvt+WcB0rma2FYjx58NkL088x/ECBihm8soWwDz4cMnw18GO1KHS6JRmNITGrlXm
 QAlSdcYhDC8n//pIoqvWn5Te7erHIFw1dXVoDmbazGJPhYtXw7FRtcvd48mpQKjKGW
 bTVHJlbKZim5nvpxFMaZ/Tiu4lZ3H71EvHcNojVW2O13sDd7mgmwpuXwamFOKYCzGL
 mtJ3rthf6uP5OQbcdCsZL5552AGrTdwhs4mSXGa/Qi2vmITJxSOy2C2mkCdrfC1Gpf
 0qBO9q0go3apmn+Ilukb2wRAOnZl751WuphDkVKwNCUjXnJr7SixFQ8k8DtJJJsJKZ
 f8XeuWfPfo9AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] accel/amdxdna: check the command chain payload
 before using it
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826153121.133507-2-taimuraz@kaitmazov.com>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
 <20260826153121.133507-1-taimuraz@kaitmazov.com>
 <20260826153121.133507-2-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:48:46 +0000
Message-Id: <20260826154847.454671F00A3D@smtp.kernel.org>
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
- [High] amdxdna_cmd_set_error() writes the error state to the wrong chain =
command BO by hardcoding index 0.
--

commit 5dc0906b3cc41016d562034c7287f924681a97d7
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: check the command chain payload before using it

This commit updates amdxdna_cmd_get_payload() to make the size parameter
mandatory and introduces amdxdna_cmd_get_chain() to ensure the command
count fits within the BO before returning the chain payload.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 888e857ec5582..caf7295a2b5b9 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c

[ ... ]

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
This isn't a bug introduced by this patch, but does this logic write the
error state to the wrong command BO?

In amdxdna_cmd_set_error(), the code correctly assigns cc->error_index based
on cmd_idx, but then it hardcodes cc->data[0] when looking up the BO. If a=
=20
chained command fails at an index greater than 0, won't this clobber the
first command in the chain with error data and completely ignore the actual
failing command?

>  		if (!abo)
>  			return -EINVAL;
>  		cmd =3D amdxdna_gem_vmap(abo);
>  		if (!cmd) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826153121.1335=
07-1-taimuraz@kaitmazov.com?part=3D1
