Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90182C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E1910E165;
	Fri, 18 Sep 2026 21:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brHveIcU";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C90710E165
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:40:44 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469f20513so1204991b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789767644; cv=none;
 d=google.com; s=arc-20260327;
 b=Ap70PsOEaWU9xwQioEUROaJ7fUIcVKUk5Lk1dFTXd+AOe8qJ5jzAC2ja/m9YjJLPd4
 KwwdarUzWPGYFRZwA+2SE2rJxCPsYgtdwVEsTuG4jj9zaNva8zQf2FMrg4h+vzsd4+st
 5dtQc16ELMGQf/QCf7Z356RPfmkex/J4hF4VvKaDn2ZuY5N13VFdZN/Zp2x/wNlea8AB
 KYjbga5L/J9bmxgbBUiaaeOJtA1nRj+QU3VWEB2UKGimwIlPrJTyMX94sGfxQbvF8yvF
 oZbW4iVb/QCke+W6EtBFFoEOs0SIL+kgsqq7YXISLNF6herrx0BLiZeXbZqx+FPhLTve
 HT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eVjYFi4juTcm+rsW63IVvlO0wPLOf9bPjkkjpmm0xMQ=;
 fh=QGqPfYh1BSBiop1vIUIElfQSkUkpvk1luwjsoiE8i/k=;
 b=I5mIW9CpFkB0uySFYw+q5wUN3up9Ac/smztNYayqm5JqCv5jZNd2UmTudFbaBzxenj
 rzV0pXeA04Huv6vIETYM88yKzcCZ3aWaB7el5/oK0i1lZ9npF4/N3PaqcNo/StT+BdDu
 QD0VdLuiT3ahiZmtBTFpl/vgBQYZxL04Q8Fi8ifMdSPSmwpo3ABxTTULUvHqgoWN7D9C
 kSm7FCj3wmAXqCsnMhyNykmXfZ4yRd2I1rR2prfZklFaGVNltuegMxWgf1uA2oTv7iCO
 LUNvok4wNP00JZhirXelhhuPOBqPjX5CMGtlH4zseL+qnwsFlrH8K/pZEbyW2EbYly7g
 bQgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789767644; x=1790372444; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eVjYFi4juTcm+rsW63IVvlO0wPLOf9bPjkkjpmm0xMQ=;
 b=brHveIcUGC6Ep0cWblifeJuyVZ3+AHSGV8X3E2lh+L84jbJZ1hJXznO5iKm8h40wZF
 sjXiox7dtNdZdbHXt0Wa/teAjEBMTnyQCSq/PV9oWiJTIxImLCcpU5kmUwpvCUeTAy6X
 EeoTRSOPfJKYDrdk7sCRdcNkJojd8FrKV8CytuYWRpnfuSSArwR9DGsW0ZGjsmgs/nI2
 mJjCr9eGkcfCIDUFY3niHqg8GftFPz3MyAociQ/N/88eqCisD1vsdBy7pDFNvcdptAJf
 r7VoS8QxMh2djxwHT+nKwQ90IGHkX8xUXHS11NNmPNWyaDwcjeS7xiTzgBH0WgAui2oA
 rFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789767644; x=1790372444;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eVjYFi4juTcm+rsW63IVvlO0wPLOf9bPjkkjpmm0xMQ=;
 b=getxpmDYM6WXDGQg7s+Nrhhvv/kJSlDlLPVPhuNu0I6+zBfuUcs8rmXkNwSIcClxZO
 ndKvgciw6CpTveOMrpF+ed9r5JveIciV5hBTDp3YCuCEdLC6Ig0U8+cN1VrB4y6kYd46
 x6CpEIop7/9Z1JiSdc+GdVTlO5ormVTIVXXhgTpMRFZpVfAvov5/TQ5UzDgU4F3OIvHN
 bvUhqRspkbA5wZxdmYjsnea9xSkq8WLQocxjIfarPkbMMBmk2cPZMyIYdrmkP4GwSgxa
 kOhckltGA+9P1IcP0BvY3syoitBfmwb5D3PZ/S1hgVi3vh0V1j3q8PKIbgb/B8shENHt
 TFVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0r5CkO11I7yko6wXSkRh9Kjk3eYystZWYfeLh+xJ9vcKq+jKQiL+6hX6n7L5RsUEgiC6Cci0SAGw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kwMsGeSMNYPzY2dVQd5gAvj/Ey7OljgNBte2xi66H86pTfQhTf
 cxD5kESnpNSbPDuE0u0P698NMZFfpxY/ljQ2rTQ5TM8gp1r8ko9VOs2wySUstijJNGm/FIe/GU+
 mALfa3XTCADH5fK36nGHfaBrM74lkXXc=
X-Gm-Gg: AYBFou1eIsBBB+4rcn2aaOsvSj3K1dShnXQctnpUDTCiGNOig9py6D9zokaj0C1JetK
 XUAv0I/L/z8xmtz0e3RS8Cs+1Km2zh7GbdOmt+dh6fXd3WzOWUroKgQXh0iXsCZwBlLIMYyKu15
 KpftCxxmVAIFcmLyVAst5n4XyxET9dL426D1v+yLznEB2AhISO58nbCHU9xx0Dn+t2jrMQP+4Dh
 f5/pUl5Ew2rZFQmuh1n6UKC/EcURxMu/77QyJk6aUrHaKP+otrP2K9VqMtI1VpNrM9n0/HCHhuz
 JiSSAgK1CiDWliPMX/s/ehKd0ddtMKsTrRXjS0Zw7qzPsYKHJF2yLfg=
X-Received: by 2002:a05:6a00:91a8:b0:877:c77d:af8d with SMTP id
 d2e1a72fcca58-877c78cfc98mr589453b3a.13.1789767643638; Fri, 18 Sep 2026
 14:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260918131620.405133-1-postadelmaga@gmail.com>
 <20260918131620.405133-2-postadelmaga@gmail.com>
 <fa3a44fa852c8fd3b86eeb7e03ba87692056fc3e.camel@redhat.com>
In-Reply-To: <fa3a44fa852c8fd3b86eeb7e03ba87692056fc3e.camel@redhat.com>
From: Francesco <postadelmaga@gmail.com>
Date: Fri, 18 Sep 2026 23:40:31 +0200
X-Gm-Features: AcwNN1WkGwQapgIvU0wW05aI28ChAAPb89xFrPrCg3f4MGxXxjaz8TlioID0Pls
Message-ID: <CAHwn+vnS7=ikU=VYx536AS9SEquN4UEOHj4zeoYVM6zNLW6DTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/nouveau/clk: fix list cursor use after loop in
 nvkm_clk_ustate_update
To: lyude@redhat.com
Cc: Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <error27@gmail.com>, Karol Herbst <kherbst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a12ff0065bc8c099"
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

--000000000000a12ff0065bc8c099
Content-Type: text/plain; charset="UTF-8"

All things for all people
Thanks you, peace

Il giorno ven 18 set 2026 alle ore 20:05 <lyude@redhat.com> ha scritto:

> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> Will push to drm-misc-fixes in just a moment, thank you for the fixes!
>
> On Fri, 2026-09-18 at 15:16 +0200, Francesco Magazzu wrote:
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > If list_for_each_entry() exits without hitting a break then "pstate"
> > is
> > not a valid pstate pointer.  Introduce a "found" variable instead.
> >
> > The check is reachable from userspace: nvkm_clk_ustate_update() takes
> > the
> > pstate id straight from the 'pstate' debugfs file, so requesting an
> > id
> > that is not in clk->states - or any id at all when the perf tables
> > are
> > broken and the list is empty - makes the pstate->pstate != req test
> > dereference the list head cast to a struct nvkm_pstate, which is an
> > out-of-bounds read.
> >
> > Fixes: 7c8565220697 ("drm/nouveau/clk: implement power state and
> > engine clock control in core")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > [Francesco: rebased on drm-misc-next, expanded the commit message]
> > Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
> > ---
> > This is Dan's 2022 patch, reposted with his authorship restored as
> > asked
> > in the review of v2.  The diff is byte for byte what he sent; the
> > commit
> > message keeps his original two sentences and adds a paragraph on how
> > the
> > check is reached from userspace.
> > Link: https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@kili/
> >
> >  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > index 572e63846..5da82db71 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > @@ -473,6 +473,7 @@ static int
> >  nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
> >  {
> >       struct nvkm_pstate *pstate;
> > +     bool found = false;
> >       int i = 0;
> >
> >       if (!clk->allow_reclock)
> > @@ -480,12 +481,14 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk,
> > int req)
> >
> >       if (req != -1 && req != -2) {
> >               list_for_each_entry(pstate, &clk->states, head) {
> > -                     if (pstate->pstate == req)
> > +                     if (pstate->pstate == req) {
> > +                             found = true;
> >                               break;
> > +                     }
> >                       i++;
> >               }
> >
> > -             if (pstate->pstate != req)
> > +             if (!found)
> >                       return -EINVAL;
> >               req = i;
> >       }
>
>

--000000000000a12ff0065bc8c099
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">All things for all people=C2=A0<br>Thanks you, peace=C2=A0=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">Il giorno ven 18 set 2026 alle ore 20:05 &lt;<a href=
=3D"mailto:lyude@redhat.com">lyude@redhat.com</a>&gt; ha scritto:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Reviewed-by: Lyude Paul &=
lt;<a href=3D"mailto:lyude@redhat.com" target=3D"_blank">lyude@redhat.com</=
a>&gt;<br>
<br>
Will push to drm-misc-fixes in just a moment, thank you for the fixes!<br>
<br>
On Fri, 2026-09-18 at 15:16 +0200, Francesco Magazzu wrote:<br>
&gt; From: Dan Carpenter &lt;<a href=3D"mailto:dan.carpenter@oracle.com" ta=
rget=3D"_blank">dan.carpenter@oracle.com</a>&gt;<br>
&gt; <br>
&gt; If list_for_each_entry() exits without hitting a break then &quot;psta=
te&quot;<br>
&gt; is<br>
&gt; not a valid pstate pointer.=C2=A0 Introduce a &quot;found&quot; variab=
le instead.<br>
&gt; <br>
&gt; The check is reachable from userspace: nvkm_clk_ustate_update() takes<=
br>
&gt; the<br>
&gt; pstate id straight from the &#39;pstate&#39; debugfs file, so requesti=
ng an<br>
&gt; id<br>
&gt; that is not in clk-&gt;states - or any id at all when the perf tables<=
br>
&gt; are<br>
&gt; broken and the list is empty - makes the pstate-&gt;pstate !=3D req te=
st<br>
&gt; dereference the list head cast to a struct nvkm_pstate, which is an<br=
>
&gt; out-of-bounds read.<br>
&gt; <br>
&gt; Fixes: 7c8565220697 (&quot;drm/nouveau/clk: implement power state and<=
br>
&gt; engine clock control in core&quot;)<br>
&gt; Signed-off-by: Dan Carpenter &lt;<a href=3D"mailto:dan.carpenter@oracl=
e.com" target=3D"_blank">dan.carpenter@oracle.com</a>&gt;<br>
&gt; [Francesco: rebased on drm-misc-next, expanded the commit message]<br>
&gt; Signed-off-by: Francesco Magazzu &lt;<a href=3D"mailto:postadelmaga@gm=
ail.com" target=3D"_blank">postadelmaga@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; This is Dan&#39;s 2022 patch, reposted with his authorship restored as=
<br>
&gt; asked<br>
&gt; in the review of v2.=C2=A0 The diff is byte for byte what he sent; the=
<br>
&gt; commit<br>
&gt; message keeps his original two sentences and adds a paragraph on how<b=
r>
&gt; the<br>
&gt; check is reached from userspace.<br>
&gt; Link: <a href=3D"https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@ki=
li/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/dri-devel=
/YvSkKAdk8Pe0g2K9@kili/</a><br>
&gt; <br>
&gt; =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 7 +++++--<br>
&gt; =C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br>
&gt; b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br>
&gt; index 572e63846..5da82db71 100644<br>
&gt; --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br>
&gt; +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c<br>
&gt; @@ -473,6 +473,7 @@ static int<br>
&gt; =C2=A0nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0struct nvkm_pstate *pstate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool found =3D false;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (!clk-&gt;allow_reclock)<br>
&gt; @@ -480,12 +481,14 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk,<br>
&gt; int req)<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (req !=3D -1 &amp;&amp; req !=3D -2) {<br=
>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_en=
try(pstate, &amp;clk-&gt;states, head) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (pstate-&gt;pstate =3D=3D req)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (pstate-&gt;pstate =3D=3D req) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D true;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0i++;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pstate-&gt;pstate=
 !=3D req)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!found)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req =3D i;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--000000000000a12ff0065bc8c099--
