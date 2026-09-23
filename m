Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71412C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B21710E924;
	Wed, 23 Sep 2026 15:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mpWnG9Em";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B4010E924
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:39:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 635B560142;
 Wed, 23 Sep 2026 15:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505C1F000FF;
 Wed, 23 Sep 2026 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790177984;
 bh=pfZlX99sSfdyQbZWmXPgZ6I3VHdILWE2NQZFNvXleCw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mpWnG9EmGvYCObl4ywb+Px2Ykssjhe1w43jKe+sTR/71YimG7tGROdELRt1BsBEAu
 1rJMuD/ThxL4SYWwF9cvlOVsSMJl7lH8yESDMOH89useiMeUSfAsRidp+Y1QjUanb7
 qxFhLtI8ID3mDM+dRFxiw8Z0BzUzb8ur2qu/fu5fnkUETBx1It3abM+OA1Di936zeD
 q9ubUYFhySXIax60XB+mQewk3YM6aErwupBAShFMxm9sha4vZ0V6XClQCdnP+14x49
 Tipd7Wt4ZcvO0bO2gvxHlDyKyqiyP05YBwAMkxz9K44JkZA5mONAFlccI+mJorGbOF
 9ZDNY5nTx5akQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: prevent parameter-space underflow in
 nested ATOM table calls
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923152912.1296884-1-qwe.aldo@gmail.com>
References: <20260923145001.1244517-1-qwe.aldo@gmail.com>
 <20260923152912.1296884-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:39:43 +0000
Message-Id: <20260923153943.E505C1F000FF@smtp.kernel.org>
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
- [High] drm/amdgpu: silent bypass of oversized ATOM table execution fails =
to abort
--

commit 6b59921539d22666969d301a49ef26fc67ab007b
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/amdgpu: prevent parameter-space underflow in nested ATOM table calls

atom_op_calltable() invokes a child ATOM table, forwarding the parent's
parameter space with an offset. The previous logic mixed units (dwords vs
bytes) when subtracting the offset from the remaining capacity. This commit
fixes the unit mismatch by converting ps_shift to bytes.

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 1a599d5cf6a5c..7db0118e654c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -646,8 +646,8 @@ static void atom_op_calltable(atom_exec_context *ctx,=
 int *ptr, int arg)
>  		SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx]);
>  	else
>  		SDEBUG("   table: %d\n", idx);
> -	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> -		r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->p=
s_shift, ctx->ps_size - ctx->ps_shift);
> +	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx) && ctx->ps_shift * 4 <=3D ct=
x->ps_size)
> +		r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->p=
s_shift, ctx->ps_size - ctx->ps_shift * 4);

[Severity: High]
Does this code silently skip the table execution without aborting when the
parameter space request is oversized?

Looking at atom_op_calltable(), the variable r is initialized to 0. When
a child table requests an oversized parameter space where
ctx->ps_shift * 4 > ctx->ps_size, the new condition prevents the call to
amdgpu_atom_execute_table_locked(), leaving r as 0.

>  	if (r) {
>  		ctx->abort =3D true;
>  	}

This means the check above will evaluate to false, failing to abort the
interpreter. The parent table will continue execution assuming the child
table executed successfully, which could lead to using uninitialized
data or skipping critical hardware setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923152912.1296=
884-1-qwe.aldo@gmail.com?part=3D1
