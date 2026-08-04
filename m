Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D7EC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BF410E166;
	Tue,  4 Aug 2026 14:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HBnSGZoX";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F6F10E166
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 14:01:08 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38cfcb507a3so445744a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 07:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852068; cv=none;
 d=google.com; s=arc-20260327;
 b=Le9wzwnkrtaSIWkqMu38DOoE1VQwFZWxnn22GNFdhMfBjaYI0ZoW+IjhfibURr0fVr
 HXA9n7kLNRq0bo0q3XmKaymz9ziHHjm4o2REP314SuZxMNqGl6v2aFLmmrcpIYnbPkj9
 VlMBpb9s7DctZt51UadNy17wWqfnMBaW7DG5JqfQsFfE1ddmNqsRzKH+gTc0OQO43RRM
 NmNna7dLKLlN9GjHoRXiA3PwEGsz3tuNdAKtIbkkjHfuCV7kZdqxcawMLh5FzU176SWL
 RN4GbomsL9BWmX9AjLIyLQxNa3wVEDNi5XPLo2Vy6ovyqdLfXVVPG4Yv5PSbAYocb2ec
 BVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jr5seHTvJXwM5lFrOeXOrJpAk4DxLxwscIyr+3p9G4g=;
 fh=bYy1gdffJzDCrIK7z4EL5b/4iCdagfa/eUW4B0maKQ0=;
 b=rnjL+UsWKu7EnhVOalvhyb9Cy6EBRNDjveE12sMXKfaws7fuh6Kip0FJlF3fZWs7qv
 bHykTk0+Z3N6tvDPw6PhKcatdGM0zPehqH5/Dd4p1FeFIaaORRu7d5mShzMRXHVj/Dpc
 Xk3KR9RWFW8AAqClUXY9DxQF+vBi3jWEe2yH1d7EPZPIc6+5P/j3aoFNIbty5cEjfPw9
 11v+crNOjsTc0KgWa5gNImy3qBDT69GbNEeYsvDhcvm9hNvdZ4GzojtGAifnsf3z2pOA
 DCYIFBYqkMtxKcfVlnBuLb32AFgThsvKXx9TQ//XX3F25wKgOhvXvDjiMHTKoc+9hbZu
 RB9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785852068; x=1786456868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jr5seHTvJXwM5lFrOeXOrJpAk4DxLxwscIyr+3p9G4g=;
 b=HBnSGZoXOWbb23uMOpVbNx7Rgw2zmbBvRlZ+2ReS3TWGacSReQsgOMfx3gsAXUIEBb
 IkV1CxyuSMbBTU4MyESnTlco+osgKgdPaUghVKXilIcNXWKP8+CvakSR/n/I+3zE7CfS
 OBXZkq9E0W0omVdyu9zoNgynwTCwYXVruUjsf43TYFdBSVPu9nkYQ+7kTMJL0ICPfgiE
 5uIE81L3tBa1vBKwTbMkAOMCDIjX93t/YXZ8HgZFxIfhI07+J2FDka95F1NKxddYasom
 48G8SbEa6AzkSAuBb7WdxmAnBdxvfvZbcqSpWonh807W4sVr4mgL1eEm/MeW4juyn3ju
 loGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852068; x=1786456868;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jr5seHTvJXwM5lFrOeXOrJpAk4DxLxwscIyr+3p9G4g=;
 b=hbpmIhGALx1Apige2ZfDFfgPrAE5j4qxGHr0OJDftqNeOhsarXNl+181oKvBt81qDZ
 dTLMb4+d5t2nFEuON1aKTANjXU/RSKeyjDaaieKUM3mTSbNGv83nD/UVZQ2Bs3fnK/ld
 FabmuKDmybT9D29IGdKwoEsmkO2hrFtcL3/YmrcEopAyaItO/+2SP0cMjT2f2VPFpm+v
 3aFgH7EG9vUDYjqK53yWiN+heTLOAUoZy2Xz4n1BwNkQnOg+PPoz+NMSQHgnDepSvMz7
 x/ETHP9ThNcvaRBt941hEwNfoVC1+mNT+aOdrjS3GqJErU0ikxz/1On2/Nl9XaGFQtwV
 vG4w==
X-Gm-Message-State: AOJu0Yyc0mbz0Gx2VXmC2tmOIyHZ+QzGHqYmQXvk33m/hIaECSoPrJZE
 Yp0zEXOErmnrYxG+GEoHxOBM4Va8M8Z3EA8+dAzfJb/rIZGGDRLWPkig2rKxt+fEWf7YqCPO0QT
 ugHy4mFziN3CduGoWrae8ZtWBVtKi+XSt0A==
X-Gm-Gg: AR+sD13zg0uKA47YJ6/aJ3hMaIsTvVTQlDR9inDzoDhtUnJkbbKBm8HOTuCmNZVVkEC
 gQV/SP0+vvkdjediNh6UnJwfgVYcK7ENgAqU6VA14F21UVb+AMjzoLk5V6ECSN2p9ScnsNW+Y5n
 sO5tn3TxLr3RTIT3B9wlcmlaBx+uOF9rHFIFSU29YNIw7SKrDsVdD3fP2XPafUBjsmHk10KU+/E
 Wx3VAEx5NtqIVRtFC/XFh9tO5egTg6OaB7bz6kmoksjPGFLJn3NYmYt+dqprpJ9h+mCB+O26ER4
 yFN3R3vmRe6LLbJBi0h7fLIzd5N4VXYj0GQFzzfPEhKsLOUK2Vr0+NlV/RE7tmPhXwkJQ18ZZQj
 wNbA5wXvbw9YRZEu8ILtTX/jXe5DDjVQ=
X-Received: by 2002:a17:90b:584d:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-38fbc52adf6mr18937864a91.2.1785852065736; Tue, 04 Aug 2026
 07:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260730170011.28915-1-harimishal1@gmail.com>
 <20260730171458.ED8481F000E9@smtp.kernel.org>
In-Reply-To: <20260730171458.ED8481F000E9@smtp.kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 10:00:54 -0400
X-Gm-Features: AUfX_mwCaiVsPcXhRnX6KyhVMHYfZNjobvIYbx4-30KYLLssVMrG8IahYQ69xqA
Message-ID: <CADnq5_PZ2i9d+eOdMEkSYynxzqO5E0iO0fXX77PRhZ420eBVNA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bound ATOM bytecode cursor within the VBIOS
 image
To: sashiko-reviews@lists.linux.dev, Hari Mishal <harimishal1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jul 30, 2026 at 1:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 6 potential issu=
e(s) to consider:
>
> New issues:
> - [High] The newly added bounds check in `atom_op_switch` breaks out of t=
he loop on malformed data without setting the abort flag, allowing garbage =
execution.
>
> Pre-existing issues:
> - [Critical] Kernel stack buffer overflow due to unit mismatch between `p=
s_size` (passed in bytes) and parameter array indexing (processed in dwords=
).
> - [Critical] Nested ATOM command tables can underflow `ps_size` and bypas=
s bounds checks, causing an arbitrary kernel stack buffer overflow.
> - [Critical] The bounds check for `ATOM_ARG_FB` scratch memory accesses i=
s vulnerable to an off-by-one error and integer overflow, allowing arbitrar=
y out-of-bounds kernel memory corruption.
> - [High] The patch bounds-checks the initial opcode fetch but fails to bo=
und variable-length operand fetches, leaving the interpreter vulnerable to =
out-of-bounds reads.
> - [High] Command table directory index `base` is read from the VBIOS imag=
e without bounds checking the index calculation itself.
> --
>
> --- Patch [1]: [PATCH] drm/amdgpu: bound ATOM bytecode cursor within the =
VBIOS image ---
> commit e34469f5366554f7ff6d1ad26ef62ec969ed0a40
> Author: Hari Mishal <harimishal1@gmail.com>
> drm/amdgpu: bound ATOM bytecode cursor within the VBIOS image
>
> The commit bounds-checks several ATOM interpreter opcode fetch and table
> jump paths against the VBIOS image size to prevent out-of-bounds reads
> on malformed images. It utilizes the existing ctx->bios_size infrastructu=
re.
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/am=
dgpu/atom.c
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>
> [ ... ]
>
> > @@ -1032,8 +1032,12 @@ static void atom_op_switch(atom_exec_context *ct=
x, int *ptr, int arg)
> >       uint32_t src, val, target;
> >       SDEBUG("   switch: ");
> >       src =3D atom_get_src(ctx, attr, ptr);
> > -     while (U16(*ptr) !=3D ATOM_CASE_END)
> > +     while ((uint32_t)*ptr + 2 <=3D ctx->ctx->bios_size &&
> > +            U16(*ptr) !=3D ATOM_CASE_END)
> >               if (U8(*ptr) =3D=3D ATOM_CASE_MAGIC) {
> > +                     /* magic byte + immediate (up to 4) + 2-byte targ=
et */
> > +                     if ((uint32_t)*ptr + 7 > ctx->ctx->bios_size)
> > +                             break;
>
> [Severity: High]
> Does breaking out of this loop without setting ctx->abort =3D true allow =
the
> interpreter to continue execution?
>
> It seems the function advances the pointer and returns normally when this
> bounds check fails, which might cause the interpreter loop to fetch the n=
ext
> byte from the middle of the switch data and execute it as garbage opcodes=
.
>

Hari, can you double check this and respin if necessary?

Thanks,

Alex

> [ ... ]
>
> > @@ -1237,6 +1248,13 @@ static int amdgpu_atom_execute_table_locked(stru=
ct atom_context *ctx, int index,
> >       if (!base)
> >               return -EINVAL;
> >
> > +     /* the table offset itself comes from the VBIOS master table */
> > +     if ((uint32_t)base + ATOM_CT_CODE_PTR >=3D ctx->bios_size) {
>
> [Severity: High]
> This isn't a bug introduced by this patch, but is the retrieval of base i=
tself
> bounds-checked before this new check?
>
> The command table directory index is read via:
> CU16(ctx->cmd_table + 4 + 2 * index)
>
> If index is arbitrarily large and controlled by the VBIOS, could the macr=
o
> perform an out-of-bounds heap read before reaching this newly added valid=
ation?
>
> [ ... ]
>
> >       if (ctx->execute_depth >=3D ATOM_EXECUTE_MAX_DEPTH) {
> >               DRM_ERROR("atombios command table nesting exceeded limit =
(%u)\n",
> >                         ATOM_EXECUTE_MAX_DEPTH);
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but are nested ATOM command ta=
bles
> safe from size underflows?
>
> When atom_op_calltable() recursively calls amdgpu_atom_execute_table_lock=
ed(),
> it passes ctx->ps_size - ctx->ps_shift for the params_size.
>
> If a malformed VBIOS specifies a ps_shift larger than ps_size, could this
> uncontrolled subtraction underflow and promote to a large unsigned bound
> during execution, bypassing bounds checks like idx < ctx->ps_size?
>
> [Severity: Critical]
> This is another pre-existing issue, but do atom_get_src_int() and
> atom_put_dst() incorrectly process ps_size as a dword limit instead of by=
tes?
>
> External callers pass a stack-allocated structure and its byte size to
> amdgpu_atom_execute_table(). If the VBIOS-supplied idx is used to index t=
he
> uint32_t *ps array, could passing idx =3D 7 for an 8-byte structure pass =
the
> idx < 8 check but access the 7th dword, leading to out-of-bounds stack
> reads and writes?
>
> [ ... ]
>
> > @@ -1273,6 +1291,13 @@ static int amdgpu_atom_execute_table_locked(stru=
ct atom_context *ctx, int index,
> >
> >       debug_depth++;
> >       while (1) {
> > +             /* jump/skip targets are bytecode-supplied; stay inside t=
he image */
> > +             if ((uint32_t)ptr >=3D ctx->bios_size) {
> > +                     DRM_ERROR("atombios cursor 0x%x outside VBIOS ima=
ge (table %04X)\n",
> > +                               ptr, base);
> > +                     ret =3D -EINVAL;
> > +                     goto free;
> > +             }
> >               op =3D CU8(ptr++);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this bounds check onl=
y
> protect the opcode byte itself?
>
> The individual opcode handlers executed later via opcode_table[op].func()
> appear to unconditionally fetch subsequent variable-length arguments. If =
the
> image ends immediately after an opcode, could these operand fetches perfo=
rm
> out-of-bounds reads?
>
> [Severity: Critical]
> This is a pre-existing issue, but is the bounds check for ATOM_ARG_FB scr=
atch
> memory accesses in atom_put_dst() susceptible to integer overflow?
>
> The bounds check appears to be:
> if ((gctx->fb_base + (idx * 4)) > gctx->scratch_size_bytes)
>
> Since it uses > instead of >=3D, it might allow an off-by-one access. Mor=
e
> importantly, if gctx->fb_base and idx are 32-bit values controlled by the
> VBIOS, could their addition wrap around a 32-bit integer and bypass the
> bounds check entirely?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730170011.28=
915-1-harimishal1@gmail.com?part=3D1
