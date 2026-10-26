Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1493606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=inmRO8Ln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E205C10E1DF;
	Mon, 26 Oct 2026 17:01:10 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02D310E351
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 17:01:04 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-3646e6de3e8so247615eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793034064; cv=none;
 d=google.com; s=arc-20260327;
 b=IffAU4g2Mi64Cxroci/Pn47Xkzf0sAVbnC+A12uO3b52zK8zPQnIK0ZZyhJ2KUJl9N
 cHPxBmDz4kHbTkw105Y6k7Cr/1lfvLElEM8ndnA5U24SFRdqcGiGqBs5YFDVFUdphV/m
 wFTf5+csEQj/QviOFZmeZqIfWCOHxQ2P11q8/qKlD3GO2oQdisgAMfLtU0wyh19Zw7xY
 4r8p3KU11Sbxl5qa9x/KBG51Xd4h7n5ZkmxmM38kOIX2p9cn/gdVuGQ5AB8fNziaP3od
 dcYTgNLTgTvpebuGPtF/h3WV3RjjRFrARHYiCFQXHIGTZ6bkGYwztMfWK7H7AueywVr1
 EGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BS54ovh1nB1Pr1TNbVZrV/xnE/i+a7dkc4mdMDvEa3E=;
 fh=VhYhSBXzMzveaaoj8ntGzLP9C387uOWA/3bBXIuNOmc=;
 b=GpAQ5SpsceJ6ucLrtgw5baELfWJxidbExysQwBGiS4F2kI9qQdElX9w+8QgDWpflTe
 3fwx1Bg2pVjgh9B/26nKtyYK2gX0pic+GV8bvcYlvIu8D9qUmI0edOhUF2aAM6ZxFT8I
 vq7tPBT18GAbuY+yabATiMSwnsy7wYI+EHW/lk6ZZDb9CKsv85wt4noDgjk1rpIM/rZ/
 mcnuOVgoFmALRz2i2Cl9TP74Co3JWoput10qwxZDqP4Fty6mgcHsniycDfe9xvFfYXfa
 56tYHaeeG1AWFEbJ7f60ravItNsmRji3toc9Lsgf6XSr0cdfNEDtNtau01hlmoZKJzHS
 cX9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793034064; x=1793638864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BS54ovh1nB1Pr1TNbVZrV/xnE/i+a7dkc4mdMDvEa3E=;
 b=inmRO8LnlyEUDfFSuW9gusZuU+5+Cp/L0ffwSwo3/pA0sZg0RRyyIV+XPbj0Grz3XB
 bBsehq4gT2Dsa1029f5QZI7FqgKyglUihXffJTbuJzPBa391meU1UMDlkMWpmmHjkj+m
 Ok+/CY2mmIAtJVtMJBqm9g4U2nV1W1NJccl79mz2PgXo8BNgYjuz9XCasauEiJUFLVKJ
 pbfCTYzFKdkiN3iHfzlYoM82zO0MCSv6z5HwSEZ/bY9Och5zes5PmwzOUQlts2zenNMx
 8Ev33ksfEgIM9jlfq1plVCVCThlAF+w1kZ5Gl8IvAOMC8AtNJ3OmDsJDWmSi3Dn8qwiw
 3r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793034064; x=1793638864;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BS54ovh1nB1Pr1TNbVZrV/xnE/i+a7dkc4mdMDvEa3E=;
 b=sByb6s/GVICvV7f35ogAMf//K1OZO+4DWmH9QIhMDRX9nFniwWo+zaZxPBR5rJtuIa
 sfdCnIwGN0DLC43df9S22wyWvmT4e1uTtuKApjD4Q/o/YSeQZExJOCJ7qJibRqd9c77O
 mf/qrkwTmPtxUm/ev3GWOYIz+ewCRvG6dOEQ75HnewxTQ1xocnK+h6Np/d5levp0G45F
 Ky/t4O4RckrDVMcYELQz03lzxmwHK49RpQ/E5TudyJcpAdhNNC6ZnEadVV3PDoUQ1kt1
 eAcP+pRuq/Q0qLP1UfX9ZiZgy0gt6ankWnT2m7D4vf//yT0ghrrWdKBVxwwKSxEGcfxU
 XQ7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLkgPJgpmSnHxhzMaFOcgB1J4FNmdBfjVWTd4TpvLJz5EbycUnpVgDHm4RrnqXnurimR1WrnOE4KQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKj4DLvfCeSefUch+KVJw5sxENbzRfnLr0F1+3bD36vt28bIeeD
 +ZHgH615wHyLqFsd0PaaBk/qZQwEd84qAMnfocZRbx7AbDiiw5VL1LmyoQ7mP55RjDqpyvc+NCx
 2MXyUxDrDKT2axAZUWWBVOJlNA0KSbUk=
X-Gm-Gg: AYBFou1/iaWF45rY0wBhOn0X1qVRqbj5hnkIrtRcPqsMOJgm63bORApAxVKLvqEIjvH
 BonUkEFHw8jjGTUVNx91LsQg0yQ8JYM3DrsZ7FyFa8N7Sv6JAS+eZydjyRiXg3Mpz20sUPYW/OM
 6BwH68ynqvdLyjKpJAxzsg/1l/qy4qlGgYSjWcbU0l9SPL7M9Y4mHLKXJtiYC8a5h0KjaakyrZC
 IWpqwjC6V3W2le7m8mBCgpov1nssqD9BMU/pGvC5gsosEhHf7C3u5tHdhUW9Z6fmSdzet6VB65r
 swh0Vow++O2TqioQlz8yCSAcLa/jxDsGr/l/rD7MlNBzc/WGEiPiVuovl4mZG06LSjPK38Iqg9u
 hc2VzOoI+yIRy5VV/E0Hkwx3BidFIAMQfdkabvNr6ze+7+kSUifF5gxk96I7aSUs3iVk8At9GF/
 1ihEcYmX7zthIPBksieLLLzRE=
X-Received: by 2002:a05:701b:430a:b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-1991b142105mr15395135c88.0.1793034063564; Mon, 26 Oct 2026
 10:01:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923152912.1296884-1-qwe.aldo@gmail.com>
 <20260923154357.1319689-1-qwe.aldo@gmail.com>
 <CADnq5_PuveD6MFtdLFkkHk24jVCQqgyC1R6pUy7ri_RyWVSZXw@mail.gmail.com>
 <CAP48Hftn=4fRju0BiDw84THpgOe=jn23zJT_9HFmvfWZHvfS=A@mail.gmail.com>
In-Reply-To: <CAP48Hftn=4fRju0BiDw84THpgOe=jn23zJT_9HFmvfWZHvfS=A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 13:00:51 -0400
X-Gm-Features: AclHuK-ZJnBGjssDmaDNeuleS1m5YvnvGtHzqQMdnRIj_FC0Z9Z0M08nvMiS3aY
Message-ID: <CADnq5_PGM6sh3ZidW=_ZrPP7d0oANFvFXfiarF_5UVj4HZwGqw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: prevent parameter-space underflow in
 nested ATOM table calls
To: Aldo Ariel <qwe.aldo@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 5:01=E2=80=AFPM Aldo Ariel <qwe.aldo@gmail.com> wro=
te:
>
> Hi Alex,
>
> Thanks for applying this fix. Could you point me to the commit or
> the branch where it landed? I haven't been able to locate it and
> would like to track its integration.

Sorry, I forget to mention that it caused a regression in atombios
parsing when I ran it through CI.

Alex

>
> Thanks,
> Aldo
>
>
>
> On Thu, 24 Sep 2026 17:52:34 -0400, Alex Deucher <alexdeucher@gmail.com> =
wrote:
> > Applied.  Thanks!
> >
> > On Wed, Sep 23, 2026 at 11:44=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@=
gmail.com> wrote:
> > >
> > > atom_op_calltable() invokes a child ATOM table, forwarding the
> > > parent's parameter space with an offset:
> > >
> > >     amdgpu_atom_execute_table_locked(ctx->ctx, idx,
> > >         ctx->ps + ctx->ps_shift,
> > >         ctx->ps_size - ctx->ps_shift);
> > >
> > > ctx->ps_shift is in dwords (set to ps / 4 in
> > > amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
> > > remaining capacity in bytes. The subtraction therefore mixes units:
> > > a child table requesting 60 bytes (ps_shift =3D 15 dwords) with only
> > > 16 bytes remaining would compute 16 - 15 =3D 1 instead of the correct
> > > 16 - 60 =3D underflow.
> > >
> > > Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
> > > subtraction so the units are consistent. Abort the interpreter when
> > > the request exceeds the available space so the parent table does not
> > > continue with stale or uninitialized data.
> > >
> > > Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table suppo=
rt")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> > > ---
> > > v3: abort the interpreter (ctx->abort =3D true + return) when the
> > >     child table's parameter space exceeds the parent's remaining
> > >     capacity, instead of silently skipping execution (found by
> > >     Sashiko AI review on v2).
> > > v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
> > >     ps_size, fixing the unit mismatch (found by Sashiko AI review).
> > >
> > >  drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/=
amdgpu/atom.c
> > > index e0e585f..af283cd 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> > > @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context =
*ctx, int *ptr, int arg)
> > >                 SDEBUG("   table: %d (%s)\n", idx, atom_table_names[i=
dx]);
> > >         else
> > >                 SDEBUG("   table: %d\n", idx);
> > > -       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> > > -               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx,=
 ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
> > > +       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
> > > +               if (ctx->ps_shift * 4 > ctx->ps_size) {
> > > +                       ctx->abort =3D true;
> > > +                       return;
> > > +               }
> > > +               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx,=
 ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
> > > +       }
> > >         if (r) {
> > >                 ctx->abort =3D true;
> > >         }
> > > --
> > > 2.43.0
