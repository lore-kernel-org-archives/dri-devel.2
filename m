Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8897C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D65910E68B;
	Wed, 23 Sep 2026 16:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eNOvIBvW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3112210E68B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:22:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19FDC41645;
 Wed, 23 Sep 2026 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C081F000FF;
 Wed, 23 Sep 2026 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790180547;
 bh=HeYVYB7oEGZGaP/eMdKlbZI32vBnk3tKnmbKGvQ/uOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eNOvIBvWF6ORV5SfDK/1hvmL30wvDCTDtrwvggrUHDOz1atOkOfqyrVmBMgWn6291
 uFO0Lx766+P13VS1g+EzM6ew9FfAtHCPlPzF4pDc5Hn4ibCNi9SiJ/YttyTJXxU3F3
 X7qY3E7/lzZaxRoq0Mj0Zl6kcSfmxYsIRlw4VWbDv+ug7UThCvPuN+PKlB7o+mYdJc
 AN6CN6mrMS6g8YvI2jdk7MidXVlAEhmp4801RHvxfAinSxBAxGUzYQzZZ7c9UHyhyM
 zA7g9bHer41QRhPU2UsvtiJfnr9rimBfOciYA4uDqASHJRrq8TnrZ448EP1l8yTnNi
 RJaK+CE+B/UXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix ATOM parameter space index bounds check
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923161252.1363895-1-qwe.aldo@gmail.com>
References: <20260923161252.1363895-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:22:26 +0000
Message-Id: <20260923162226.D0C081F000FF@smtp.kernel.org>
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
- [Low] drm/amdgpu: confusing log message for ATOM PS index out of range
--

commit dd873e6794eea339db29a3fa2da08121624e1439
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/amdgpu: fix ATOM parameter space index bounds check

This commit divides ctx->ps_size by 4 in atom_get_src_int() and
atom_put_dst() to prevent out-of-bounds dword accesses into the parameter
buffer.

Closes: https://sashiko.dev/#/patchset/20260923163157.1354872-1-qwe.aldo@gm=
ail.com?part=3D1

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 1a599d5cf6a5c..b86ed700c5f87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -232,7 +232,7 @@ static uint32_t atom_get_src_int(atom_exec_context *c=
tx, uint8_t attr,
>  		(*ptr)++;
>  		/* get_unaligned_le32 avoids unaligned accesses from atombios
>  		 * tables, noticed on a DEC Alpha. */
> -		if (idx < ctx->ps_size)
> +		if (idx < ctx->ps_size / 4)
>  			val =3D get_unaligned_le32((u32 *)&ctx->ps[idx]);
>  		else
>  			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);

[Severity: Low]
Does this print a mathematically confusing log message? Since the check now
validates idx against ctx->ps_size / 4, if idx is between ctx->ps_size / 4
and ctx->ps_size - 1, the log could print something like "5 > 16". Should
we also divide ctx->ps_size by 4 in the pr_info() statement to match the
dword indexing?

> @@ -510,7 +510,7 @@ static void atom_put_dst(atom_exec_context *ctx, int =
arg, uint8_t attr,
>  		idx =3D U8(*ptr);
>  		(*ptr)++;
>  		DEBUG("PS[0x%02X]", idx);
> -		if (idx >=3D ctx->ps_size) {
> +		if (idx >=3D ctx->ps_size / 4) {
>  			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);

[Severity: Low]
Similarly, does this print the byte size instead of the dword size? Since t=
he
out of bounds check now uses ctx->ps_size / 4, this could also print
contradictory statements when the error condition is hit.

>  			return;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923161252.1363=
895-1-qwe.aldo@gmail.com?part=3D1
