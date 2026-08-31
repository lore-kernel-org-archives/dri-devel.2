Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE94C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7768B10E6E2;
	Mon, 31 Aug 2026 15:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ATUCZ3uW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BED410E6E2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:24:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28D916013A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7BB1F000E9;
 Mon, 31 Aug 2026 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788189861;
 bh=zh9ymRgbVf3J/Ehv1myxNbWIdAJf4CfSWPVtlH/UkIw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ATUCZ3uW1sPPUsqW+jOUBlW3NOv3sKG8vESDBy/s6+DLSCL2MF4qRDxX0KOeerg0W
 fki3Y/u8LpEqQeqDiulZ+Wi5ZfkAnC6kBk/qbvlPP3J5wkNcKXCOWpRk0kHmIcaSLG
 h6tzLfiFgWclR3sFDsP+4q2J32jzfX0bwLz1Cw8vav1TyBfuDRohWBSIUfkcZq+7rL
 xJ/xqBO7ck+r5eHj+waQZ0/gXj1/0YRYgDXGcvdxDzu0yUWVDSjy+Q/oOh6oaE5VJt
 3rMZpEbsqNarhdeM/BFLcdGTFccGXqFLjPazuVZm0AXbz7fKJH2J5LNAge6PAtxuCJ
 TPmijl5M7HHVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amdgpu: cap ATOM command table nesting
 depth
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-274-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-274-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:24:21 +0000
Message-Id: <20260831152421.BD7BB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds stack/heap access due to unvalidated `ps_shift` =
causing negative `ps_size`.
- [Critical] Integer overflow in `ATOM_ARG_FB` bounds check allows out-of-b=
ounds memory corruption.
- [Medium] The command table loop timeout mechanism in `atom_op_jump` can b=
e trivially defeated by a multi-jump loop.
- [Low] The `debug_depth` counter leaks permanently when the execution of a=
 command table is aborted.
--

commit 0c77b7dbed85cb54e1624a76d5ddd1e7608f6557
Author: Candice Li <candice.li@amd.com>

drm/amdgpu: cap ATOM command table nesting depth

Cap nesting at 32 levels with execute_depth and return -ELOOP when exceeded.

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 7a063e44d4298..639649ef6dd03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -59,6 +59,9 @@
> =20
>  #define ATOM_CMD_TIMEOUT_SEC	20
> =20
> +/* Limit ATOM command table recursion (calltable) to avoid kernel stack =
overflow. */
> +#define ATOM_EXECUTE_MAX_DEPTH	32
> +

[Severity: Critical]
This is a pre-existing issue, but can this lead to an out-of-bounds access?

In atom_op_calltable(), the size calculation could evaluate to a negative
integer:

drivers/gpu/drm/amd/amdgpu/atom.c:atom_op_calltable() {
    ...
    r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps=
_shift,
                                         ctx->ps_size - ctx->ps_shift);
    ...
}

If a crafted VBIOS provides a large ps_shift value, ctx->ps_size - ctx->ps_=
shift
will be negative. When passed as params_size into
amdgpu_atom_execute_table_locked(), this negative value propagates.

Later, in atom_put_dst(), this negative size is promoted to a large unsigned
integer, which would bypass the bounds check:

drivers/gpu/drm/amd/amdgpu/atom.c:atom_put_dst() {
    ...
    if (idx >=3D ctx->ps_size) {
    ...
}

Could this be leveraged for out-of-bounds reads or writes on the stack or h=
eap?

[Severity: Critical]
This is a pre-existing issue, but does this bounds check have an integer
overflow vulnerability?

If a crafted VBIOS sets fb_base to a value near UINT32_MAX, the addition in
the ATOM_ARG_FB bounds check can overflow:

drivers/gpu/drm/amd/amdgpu/atom.c:atom_put_dst() {
    ...
    if ((gctx->fb_base + (idx * 4)) > gctx->scratch_size_bytes) {
    ...
}

If gctx->fb_base + (idx * 4) overflows into a small positive number, it pas=
ses
the bounds check. The subsequent memory access uses the original huge fb_ba=
se:

drivers/gpu/drm/amd/amdgpu/atom.c:atom_put_dst() {
    ...
    gctx->scratch[(gctx->fb_base / 4) + idx] =3D val;
    ...
}

Can this lead to out-of-bounds memory corruption?

[Severity: Medium]
This is a pre-existing issue, but can the command table loop timeout be eas=
ily
defeated?

The timeout mechanism in atom_op_jump() resets the tracker when the script =
jumps
to a different instruction:

drivers/gpu/drm/amd/amdgpu/atom.c:atom_op_jump() {
    ...
    } else {
        ctx->last_jump =3D ctx->start + target;
        ctx->last_jump_jiffies =3D jiffies;
    }
    ...
}

If a VBIOS script uses multiple jump instructions in a loop (for example,
jumping between A and B), ctx->last_jump =3D=3D (ctx->start + target) will =
always
be false. This forces the execution into the else block, continuously reset=
ting
the 20-second timeout tracker.

Could this allow a multi-jump loop to hang the driver indefinitely, causing=
 a
denial of service?

[ ... ]

> @@ -1285,6 +1295,7 @@ static int amdgpu_atom_execute_table_locked(struct =
atom_context *ctx, int index,
>  free:
>  	if (ws)
>  		kfree(ectx.ws);
> +	ctx->execute_depth--;

[Severity: Low]
This is a pre-existing issue, but does the debug_depth counter leak when an
execution is aborted?

In amdgpu_atom_execute_table_locked(), if ectx.abort becomes true, the code
jumps directly to the free label:

    if (ectx.abort) {
        ...
        goto free;
    }

Because the free label is located after the debug_depth--; statement, the
counter is never decremented on this error path. When amdgpu_atom_debug is
enabled, could this cause unbounded indentation in debug logs over time?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-274-sashal@kernel.org?part=3D1
