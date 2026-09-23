Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CBAC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2077210F118;
	Wed, 23 Sep 2026 15:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eRxHkhsJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF1810F118
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:04:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8007241A72;
 Wed, 23 Sep 2026 15:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ABB1F00898;
 Wed, 23 Sep 2026 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790175850;
 bh=Ge6g16cNsQU9u+Vx74E1A4JoVGyNfu4QfnuB0DeO0Ik=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eRxHkhsJm/9Oap5O+FvUJKz7BRC+b+t+N4nMsJfZhvj54JKfY2jFWRXJbU4TUr9bE
 6QPNzZi7D/iGo3yt9I+yHMQtpZRKlXhDubAPfpomg3u3vxtGLCHQvt6bwh9MF7SPd8
 3/gYUmJZAew1JvouoXvL5Twwc0fx9YG/2CupxwW7qaEBHaoYAqEQ7xqSLxlfvFidNZ
 nOT+VMsrxuq/p3fuCa/10mVVSKscHozmEqdr2A14IoEWpCSfNj3GITsmFfBf7rntmI
 Xss+xKs5ZuRC4UCPKvnnDeQ94DlM7MrxII+K2B2GbdhOuwtXAbqRSsVuUsTUC48/dU
 H1HITbtDTzyfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: prevent parameter-space underflow in nested
 ATOM table calls
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923145001.1244517-1-qwe.aldo@gmail.com>
References: <20260923145001.1244517-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:04:09 +0000
Message-Id: <20260923150410.39ABB1F00898@smtp.kernel.org>
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
- [High] amdgpu: incomplete bounds check in atom_op_calltable() mixes units
--

commit 6d85d4d710e40392c30bb7f8392682eb670b9185
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
drm/amdgpu: prevent parameter-space underflow in nested ATOM table calls

This commit attempts to prevent underflow when calculating parameter
space for nested ATOM table calls. It adds a check to verify if the
required shift exceeds the available size.

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 1a599d5cf6a5c..bcaeec1b057d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c

[ ... ]

> @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context *ctx=
, int *ptr, int arg)
>  		SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx]);
>  	else
>  		SDEBUG("   table: %d\n", idx);
> -	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> +	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
> +		if (ctx->ps_shift > ctx->ps_size) {

[Severity: High]
Does this code compare mismatched units? ctx->ps_shift appears to be
calculated in dwords (ps / 4) in amdgpu_atom_execute_table_locked(),
while ctx->ps_size is in bytes.

If a child table requests 60 bytes (15 dwords), but only 16 bytes are
available in ps_size, the comparison 15 > 16 evaluates to false. This
would bypass the abort check even though the required capacity exceeds
the available capacity.

> +			ctx->abort =3D true;
> +			return;
> +		}
>  		r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->p=
s_shift, ctx->ps_size - ctx->ps_shift);

[Severity: High]
Does this subtraction mix bytes and dwords, corrupting the parameter
size passed to the child table?

Following the example above where ps_shift is 15 dwords and ps_size is
16 bytes, ctx->ps_size - ctx->ps_shift would compute to 1, while
advancing the ctx->ps pointer by 15 dwords (60 bytes). This advances
the pointer far past the allocated stack buffer, potentially leaving the
code vulnerable to out-of-bounds reads and writes.

> +	}
>  	if (r) {
>  		ctx->abort =3D true;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923145001.1244=
517-1-qwe.aldo@gmail.com?part=3D1
