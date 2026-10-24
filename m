Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B3606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PWdCNNq8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEB410E156;
	Sat, 24 Oct 2026 20:49:10 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5111A10E1D2
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:49:04 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8b0a921ee46so14667437b3.2
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792874943; cv=none;
 d=google.com; s=arc-20260327;
 b=LbH44BG7oe22JA7t2eu1LnVpe20PIQ279dlpwh04ZzlMl4mj6vWwHF0kvSjAMI1/Gl
 OMXU0eXp3mX7EsFO8RR9lE3VWbkBLaTie7JfNxFygfFYIdjydiztBas4fx1Fzj9Ev6y1
 GSW7gGSKd9ljmgFiHxShLwTuqL3XADOlrfm7oIgJ/z5I/k8AhyO12OOvw/tfUdyb/J6e
 wTDopfdYeCOtOLmf9LFxbeyT4lpZUCqHyW9vcnpqolw+6JyQGJGsHW5Kk6Wky2qGg4D6
 kBsuy+/rKkK9byUcgIZJwju6jY9xCrZbHmk+nYrm6ypcEogpLT1tDrok09YrLoQZ0tMy
 mffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oGOpDt5hTBOwyatPqLiX1Cu6VE1WJai8/pltTFw/Xv4=;
 fh=c3Sql78Qxq9XqaWF5lgU8Er1tP3SIvKq0vMqdVbQG4k=;
 b=e1L8A5UPP5xDcEf7km4IcQYAP2tEr0qxSOXPeRvBbMvRvND88bWrnpaM1zuIrPRY6p
 KTXBj5/nU1dkHcGStm4h19tqYOPzWTHHVJQwgoyUNcA2KxWNS0YwljDsbG9FSEQXzD6y
 Knefo4gmb9WsVh0hd1VMgu4skq1gzE5jzBHXgSbn8CA3f1ePbWDE2uV2cXuljDWujg4i
 j09lVhFzc6mkadRFE5f/fluNDuim7HZlzqQ5LqjmKemnuBNL6itTqY7tSAPyIJMzSlPD
 Fomzhc9aW+mLFH7GnF4iL0gYhL+xAjoSTvOM3ex5f2N0wmNBPDWxU4itpGWwFTFNZrTI
 KNMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792874943; x=1793479743; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oGOpDt5hTBOwyatPqLiX1Cu6VE1WJai8/pltTFw/Xv4=;
 b=PWdCNNq8LIcfkUSiIoZVPtnHcBWKXMCRh157z+XIy46/RxJuAiFiynbLowRbVRS3Cn
 SKZYVjB0qoaYcpEEBr6CRIS/olOQoRTObJ5Kk1EvYSTn/QPiITDZ8HLKiZzlSUNsMQZQ
 K6zTKw/IghfKxzMUZN1R4SyMF3SJbNkvmU/FUTJxV6kU6CvWnCxyi+iG6RQBSAvfYAZJ
 qN+jwDv752pXE2iChW6ACQnrp2W9mCPBUu3RJ4ymbrK3nQdXVMQ2LSt7fLnwxorMoea1
 hz1/xgxYlXPIwGqSgaqvaMHs+DPcdEehHG4QFDv9y6CpeGFzTO5aO9McN2VTeuV9pdsE
 m21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792874943; x=1793479743;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oGOpDt5hTBOwyatPqLiX1Cu6VE1WJai8/pltTFw/Xv4=;
 b=Wbn8z+28tnDket1C7CBGLmNDqdGcBQGHxWp4XHOTXQW7ZebmpBNdeBhS9BW066rnHb
 JSBJIQXMHU7tBLIuzX202UaMU/q28IrLWinFprDiilFlh76UlbFia/pMBDuSweOV5Gmb
 sy9pGNA3v+UTkcxftMfmMc5ZIUJuXHJJX+SRMcktyHx++Pf+HDHlhTNsdjuK3m5T5JmF
 ENY55Avf3nz5dQADoekrphhOCsppPJIa7BZLAeGvg56BBv06NCTmtvce9JlD8JrfMOzm
 j2jVlIXf5WxDVHT22vQiBz/wkCq7lokDdybD8ivyYTUTWQxmyEHRbWuVDZsId2LrWxwd
 qodg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxn1oz3ApsoUceu5JNda8/D2JtzMakmLuDvNReur9EFH4/dpeXztcKjAqm5+gblZf4K8XEcGQYCvXI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLqInND7/wsI38Jk5uHs99OVg8f+WJ6rcrg7Fn23AA+CQVULc22
 RDrfYgfRQhJqNE2ymfkvWLmXNPXJlEPB4suhSEBcjIPMo8QuOjgPtPlr8AL4atobIzP9E2nnNgM
 r7zRqlKiUHpkJGV6RFOFIelYlOe+LCbY=
X-Gm-Gg: AYBFou1olvygOG87DvCjBqADilxeHGd3SHoPmmHN3B+iSQlQhyClkD6bsK0zrbCV8up
 eUOlfDQ9ygZSdGZYen2IY/ATJMeKC+e0d13/tS1srr8ZJ2mEqUD4xs/McP1/FVCY6OwlvrGc4bm
 7uXrt+IVYBg667Y1N013k+sUlLtpPZsjgWaYRlFhIL1/ex8LTzpM/LO46kgdTGuTUjaX/gohLyu
 AROi7DK/ic+sWSHUHyEENjWwwoLOxtZ+SOPlBcrbuoRMfSzrX8ubTapBsyNwI2V3UFi7dryE1ly
 pjXcxGPIScnA+ehHE+XD4WyxGkuAvyrMAKM9BuFXmCiYEW0qlVC6v1a/wiZedxdBLnZkBJHoUB+
 y+0IOYlUWILtfjmw5R8A4fN3uDYuR4omZ5E4=
X-Received: by 2002:a05:690c:6d81:b0:8b0:f0cc:db0e with SMTP id
 00721157ae682-8b166c3e768mr19087577b3.78.1792874942607; Sat, 24 Oct 2026
 13:49:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923152912.1296884-1-qwe.aldo@gmail.com>
 <20260923154357.1319689-1-qwe.aldo@gmail.com>
 <CADnq5_PuveD6MFtdLFkkHk24jVCQqgyC1R6pUy7ri_RyWVSZXw@mail.gmail.com>
In-Reply-To: <CADnq5_PuveD6MFtdLFkkHk24jVCQqgyC1R6pUy7ri_RyWVSZXw@mail.gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:48:51 -0300
X-Gm-Features: AclHuK_zPYbCeC6EeY7wu8k7LkFZqFRZDodTP3-jmQGg2_aDFjYe5voeFfBXbPw
Message-ID: <CAP48Hftn=4fRju0BiDw84THpgOe=jn23zJT_9HFmvfWZHvfS=A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: prevent parameter-space underflow in
 nested ATOM table calls
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000014b6f6065e9c3a17"
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
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000014b6f6065e9c3a17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for applying this fix. Could you point me to the commit or
the branch where it landed? I haven't been able to locate it and
would like to track its integration.

Thanks,
Aldo



On Thu, 24 Sep 2026 17:52:34 -0400, Alex Deucher <alexdeucher@gmail.com>
wrote:
> Applied.  Thanks!
>
> On Wed, Sep 23, 2026 at 11:44=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gm=
ail.com>
wrote:
> >
> > atom_op_calltable() invokes a child ATOM table, forwarding the
> > parent's parameter space with an offset:
> >
> >     amdgpu_atom_execute_table_locked(ctx->ctx, idx,
> >         ctx->ps + ctx->ps_shift,
> >         ctx->ps_size - ctx->ps_shift);
> >
> > ctx->ps_shift is in dwords (set to ps / 4 in
> > amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
> > remaining capacity in bytes. The subtraction therefore mixes units:
> > a child table requesting 60 bytes (ps_shift =3D 15 dwords) with only
> > 16 bytes remaining would compute 16 - 15 =3D 1 instead of the correct
> > 16 - 60 =3D underflow.
> >
> > Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
> > subtraction so the units are consistent. Abort the interpreter when
> > the request exceeds the available space so the parent table does not
> > continue with stale or uninitialized data.
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table
support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> > ---
> > v3: abort the interpreter (ctx->abort =3D true + return) when the
> >     child table's parameter space exceeds the parent's remaining
> >     capacity, instead of silently skipping execution (found by
> >     Sashiko AI review on v2).
> > v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
> >     ps_size, fixing the unit mismatch (found by Sashiko AI review).
> >
> >  drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
b/drivers/gpu/drm/amd/amdgpu/atom.c
> > index e0e585f..af283cd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> > @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context
*ctx, int *ptr, int arg)
> >                 SDEBUG("   table: %d (%s)\n", idx,
atom_table_names[idx]);
> >         else
> >                 SDEBUG("   table: %d\n", idx);
> > -       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> > -               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx,
ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
> > +       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
> > +               if (ctx->ps_shift * 4 > ctx->ps_size) {
> > +                       ctx->abort =3D true;
> > +                       return;
> > +               }
> > +               r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx,
ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
> > +       }
> >         if (r) {
> >                 ctx->abort =3D true;
> >         }
> > --
> > 2.43.0

--00000000000014b6f6065e9c3a17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Alex,<br>
<br>
Thanks for applying this fix. Could you point me to the commit or<br>
the branch where it landed? I haven&#39;t been able to locate it and<br>
would like to track its integration.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Thu, 24 Sep 2026 17:52:34 -0400, Alex Deucher &lt;<a href=3D"mailto:alex=
deucher@gmail.com" target=3D"_blank" rel=3D"noreferrer">alexdeucher@gmail.c=
om</a>&gt; wrote:<br>
&gt; Applied.=C2=A0 Thanks!<br>
&gt; <br>
&gt; On Wed, Sep 23, 2026 at 11:44=E2=80=AFAM Aldo Ariel Panzardo &lt;<a hr=
ef=3D"mailto:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.a=
ldo@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; atom_op_calltable() invokes a child ATOM table, forwarding the<br=
>
&gt; &gt; parent&#39;s parameter space with an offset:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0amdgpu_atom_execute_table_locked(ctx-&gt;ctx, =
idx,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;ps + ctx-&gt;ps_shift,<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;ps_size - ctx-&gt;ps_shi=
ft);<br>
&gt; &gt;<br>
&gt; &gt; ctx-&gt;ps_shift is in dwords (set to ps / 4 in<br>
&gt; &gt; amdgpu_atom_execute_table_locked()), while ctx-&gt;ps_size is the=
<br>
&gt; &gt; remaining capacity in bytes. The subtraction therefore mixes unit=
s:<br>
&gt; &gt; a child table requesting 60 bytes (ps_shift =3D 15 dwords) with o=
nly<br>
&gt; &gt; 16 bytes remaining would compute 16 - 15 =3D 1 instead of the cor=
rect<br>
&gt; &gt; 16 - 60 =3D underflow.<br>
&gt; &gt;<br>
&gt; &gt; Convert ps_shift to bytes (ps_shift * 4) in both the guard and th=
e<br>
&gt; &gt; subtraction so the units are consistent. Abort the interpreter wh=
en<br>
&gt; &gt; the request exceeds the available space so the parent table does =
not<br>
&gt; &gt; continue with stale or uninitialized data.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: d38ceaf99ed0 (&quot;drm/amdgpu: add coordinate ATOMBIOS ta=
ble support&quot;)<br>
&gt; &gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" r=
el=3D"noreferrer">stable@vger.kernel.org</a><br>
&gt; &gt; Reported-by: Sashiko &lt;<a href=3D"mailto:sashiko-bot@kernel.org=
" target=3D"_blank" rel=3D"noreferrer">sashiko-bot@kernel.org</a>&gt;<br>
&gt; &gt; Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.com</a>&gt;=
<br>
&gt; &gt; ---<br>
&gt; &gt; v3: abort the interpreter (ctx-&gt;abort =3D true + return) when =
the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0child table&#39;s parameter space exceeds the =
parent&#39;s remaining<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0capacity, instead of silently skipping executi=
on (found by<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Sashiko AI review on v2).<br>
&gt; &gt; v2: convert ps_shift to bytes (ps_shift * 4) before comparing wit=
h<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0ps_size, fixing the unit mismatch (found by Sa=
shiko AI review).<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++++-<br>
&gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/=
amd/amdgpu/atom.c<br>
&gt; &gt; index e0e585f..af283cd 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; &gt; @@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_cont=
ext *ctx, int *ptr, int arg)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDEB=
UG(&quot;=C2=A0 =C2=A0table: %d (%s)\n&quot;, idx, atom_table_names[idx]);<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDEB=
UG(&quot;=C2=A0 =C2=A0table: %d\n&quot;, idx);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (U16(ctx-&gt;ctx-&gt;cmd_table + 4=
 + 2 * idx))<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amd=
gpu_atom_execute_table_locked(ctx-&gt;ctx, idx, ctx-&gt;ps + ctx-&gt;ps_shi=
ft, ctx-&gt;ps_size - ctx-&gt;ps_shift);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (U16(ctx-&gt;ctx-&gt;cmd_table + 4=
 + 2 * idx)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctx-&=
gt;ps_shift * 4 &gt; ctx-&gt;ps_size) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ctx-&gt;abort =3D true;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amd=
gpu_atom_execute_table_locked(ctx-&gt;ctx, idx, ctx-&gt;ps + ctx-&gt;ps_shi=
ft, ctx-&gt;ps_size - ctx-&gt;ps_shift * 4);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-=
&gt;abort =3D true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; --<br>
&gt; &gt; 2.43.0

--00000000000014b6f6065e9c3a17--
