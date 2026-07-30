Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BB9C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5C210E1E7;
	Thu, 30 Jul 2026 17:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NYyJ59gU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA66A10E1E7
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:14:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41AE5434A3;
 Thu, 30 Jul 2026 17:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8481F000E9;
 Thu, 30 Jul 2026 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785431699;
 bh=6zjj3q+CgGVOGF4KObTHKvL9FNV8D8xnB2fVykQCWGo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NYyJ59gUWu6ij1/+Dx1vxfRWwLVeV2zL33kbFNQAMxH9gM0svBbV9/6yRusBaMMiD
 HDuw9gDFHjFVmVayyb4c7Z4ShPkUhIGRtQXsY+/o2D1u1oseUtmgiZiU45knwvcNV/
 yxEdX62VWYmBKNzNzpH//XND0HDAbyG7zOxq/48LNURb2YjgsAgRZWmBGdFnDbZQ0I
 g/3UYaUlZOpZMW339vkmNDpqUGyhd611LwDHkoSFJ5CSRaYOEHNpRpTdrE8vPY47f+
 Vdx1HRQ7oxv9Eto2B9UrdwGytFO3AR9+rchgYIXVwgu9KTh/T3jBVelPYx2WjF+0IS
 Q2TKeLh/W0UbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: bound ATOM bytecode cursor within the VBIOS
 image
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730170011.28915-1-harimishal1@gmail.com>
References: <20260730170011.28915-1-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 17:14:58 +0000
Message-Id: <20260730171458.ED8481F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The newly added bounds check in `atom_op_switch` breaks out of the=
 loop on malformed data without setting the abort flag, allowing garbage ex=
ecution.

Pre-existing issues:
- [Critical] Kernel stack buffer overflow due to unit mismatch between `ps_=
size` (passed in bytes) and parameter array indexing (processed in dwords).
- [Critical] Nested ATOM command tables can underflow `ps_size` and bypass =
bounds checks, causing an arbitrary kernel stack buffer overflow.
- [Critical] The bounds check for `ATOM_ARG_FB` scratch memory accesses is =
vulnerable to an off-by-one error and integer overflow, allowing arbitrary =
out-of-bounds kernel memory corruption.
- [High] The patch bounds-checks the initial opcode fetch but fails to boun=
d variable-length operand fetches, leaving the interpreter vulnerable to ou=
t-of-bounds reads.
- [High] Command table directory index `base` is read from the VBIOS image =
without bounds checking the index calculation itself.
--

--- Patch [1]: [PATCH] drm/amdgpu: bound ATOM bytecode cursor within the VB=
IOS image ---
commit e34469f5366554f7ff6d1ad26ef62ec969ed0a40
Author: Hari Mishal <harimishal1@gmail.com>
drm/amdgpu: bound ATOM bytecode cursor within the VBIOS image

The commit bounds-checks several ATOM interpreter opcode fetch and table
jump paths against the VBIOS image size to prevent out-of-bounds reads
on malformed images. It utilizes the existing ctx->bios_size infrastructure.

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c

[ ... ]

> @@ -1032,8 +1032,12 @@ static void atom_op_switch(atom_exec_context *ctx,=
 int *ptr, int arg)
>  	uint32_t src, val, target;
>  	SDEBUG("   switch: ");
>  	src =3D atom_get_src(ctx, attr, ptr);
> -	while (U16(*ptr) !=3D ATOM_CASE_END)
> +	while ((uint32_t)*ptr + 2 <=3D ctx->ctx->bios_size &&
> +	       U16(*ptr) !=3D ATOM_CASE_END)
>  		if (U8(*ptr) =3D=3D ATOM_CASE_MAGIC) {
> +			/* magic byte + immediate (up to 4) + 2-byte target */
> +			if ((uint32_t)*ptr + 7 > ctx->ctx->bios_size)
> +				break;

[Severity: High]
Does breaking out of this loop without setting ctx->abort =3D true allow the
interpreter to continue execution?

It seems the function advances the pointer and returns normally when this
bounds check fails, which might cause the interpreter loop to fetch the next
byte from the middle of the switch data and execute it as garbage opcodes.

[ ... ]

> @@ -1237,6 +1248,13 @@ static int amdgpu_atom_execute_table_locked(struct=
 atom_context *ctx, int index,
>  	if (!base)
>  		return -EINVAL;
> =20
> +	/* the table offset itself comes from the VBIOS master table */
> +	if ((uint32_t)base + ATOM_CT_CODE_PTR >=3D ctx->bios_size) {

[Severity: High]
This isn't a bug introduced by this patch, but is the retrieval of base its=
elf
bounds-checked before this new check?

The command table directory index is read via:
CU16(ctx->cmd_table + 4 + 2 * index)

If index is arbitrarily large and controlled by the VBIOS, could the macro
perform an out-of-bounds heap read before reaching this newly added validat=
ion?

[ ... ]

>  	if (ctx->execute_depth >=3D ATOM_EXECUTE_MAX_DEPTH) {
>  		DRM_ERROR("atombios command table nesting exceeded limit (%u)\n",
>  			  ATOM_EXECUTE_MAX_DEPTH);

[Severity: Critical]
This isn't a bug introduced by this patch, but are nested ATOM command tabl=
es
safe from size underflows?

When atom_op_calltable() recursively calls amdgpu_atom_execute_table_locked=
(),
it passes ctx->ps_size - ctx->ps_shift for the params_size.

If a malformed VBIOS specifies a ps_shift larger than ps_size, could this
uncontrolled subtraction underflow and promote to a large unsigned bound
during execution, bypassing bounds checks like idx < ctx->ps_size?

[Severity: Critical]
This is another pre-existing issue, but do atom_get_src_int() and
atom_put_dst() incorrectly process ps_size as a dword limit instead of byte=
s?

External callers pass a stack-allocated structure and its byte size to
amdgpu_atom_execute_table(). If the VBIOS-supplied idx is used to index the
uint32_t *ps array, could passing idx =3D 7 for an 8-byte structure pass the
idx < 8 check but access the 7th dword, leading to out-of-bounds stack
reads and writes?

[ ... ]

> @@ -1273,6 +1291,13 @@ static int amdgpu_atom_execute_table_locked(struct=
 atom_context *ctx, int index,
> =20
>  	debug_depth++;
>  	while (1) {
> +		/* jump/skip targets are bytecode-supplied; stay inside the image */
> +		if ((uint32_t)ptr >=3D ctx->bios_size) {
> +			DRM_ERROR("atombios cursor 0x%x outside VBIOS image (table %04X)\n",
> +				  ptr, base);
> +			ret =3D -EINVAL;
> +			goto free;
> +		}
>  		op =3D CU8(ptr++);

[Severity: High]
This isn't a bug introduced by this patch, but does this bounds check only
protect the opcode byte itself?

The individual opcode handlers executed later via opcode_table[op].func()
appear to unconditionally fetch subsequent variable-length arguments. If the
image ends immediately after an opcode, could these operand fetches perform
out-of-bounds reads?

[Severity: Critical]
This is a pre-existing issue, but is the bounds check for ATOM_ARG_FB scrat=
ch
memory accesses in atom_put_dst() susceptible to integer overflow?

The bounds check appears to be:
if ((gctx->fb_base + (idx * 4)) > gctx->scratch_size_bytes)

Since it uses > instead of >=3D, it might allow an off-by-one access. More
importantly, if gctx->fb_base and idx are 32-bit values controlled by the
VBIOS, could their addition wrap around a 32-bit integer and bypass the
bounds check entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730170011.2891=
5-1-harimishal1@gmail.com?part=3D1
