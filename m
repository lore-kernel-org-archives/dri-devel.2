Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3190ACC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 22:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E32410E311;
	Thu, 15 Oct 2026 22:29:34 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3A710E311
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 22:29:28 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso662922d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792103367; cv=none;
 d=google.com; s=arc-20260327;
 b=r7iIFvjnxrFoEBuBFMpv1MtbU0E1Yghue/2WQoV+Po8aJz5+VTqKQVMKcklWmHlipa
 G/FKVJVUULAv705Wjvjv4yOQwBwOiZM6jPRvgywXXkyGw/4SzF75CYMQ8gYkbuxNH/Kw
 Z/D0pSNmW/GOuls9h1ot0M4BAIvrwrfEUNa6vb/BXKwfAt1vnLspeHBsG8Y7P3IMmImd
 sKH0edqSjnvXVLCKTXVZagGgnxyiWuehLLOV9MUO0bZL70mIefKdfoUK+0jBRtxr3SHK
 WbVp8fP8raPbFfs8l+lFabsqs/WZgR+AvwoT9qfTvHVUGyCa6ZC3QAaJ0d1Kchwpt+h4
 zpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WZ1OyRzHt1ZBX79eoZyilrSKmMYQjSY/4VnaBjrbrhg=;
 fh=1Kv7r5XAgG/EP+S7raafvoJJ587VsnA0PB4xxXkng+Y=;
 b=LUIsaxlH/iir6Sezp+eprR6CfnNhMDQCOGohtxlnMFx/zqC1JcWw300Hz0/jQ6k0yK
 YjXNj/bl5TfohKf+IyfqgOuDaV5iuo93uFwcmkCVkE/nRBepYOKpRfl/GYnKsVIuSK33
 WnLH2cTYEBXVwP2oUrzkeh7kQr5nXge17+o9iDpq2LAXhiq6tZ22cH+KtGAh5Yx8nmho
 BuMw/G2QjF7YzsfvHoZY21yHa1qRjiGsxR0ZT+HZlWactpQoLl2GI05+V13txRwamQYJ
 fqVx3yf90QwC54A1qeMzAuDDeyx6bFwChhTqu3xwIB6WcGDLo6qQeM1rjJ+YUU+PL8FM
 mu9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792103367; x=1792708167; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WZ1OyRzHt1ZBX79eoZyilrSKmMYQjSY/4VnaBjrbrhg=;
 b=ex0kDIm9N+/zMIHodlekUJcDNUvwn0NeANUyx0ySGFN2WlLxQhlhV0gomm/vIaORev
 1R4+YtciLVKUXOY4GrZoNiy9ftpoSHsGv3QaCdddWbxVRZrh6HpnWhOCpi6oQeW6pvtu
 1fd+m9RHooCsz1fFT6I3VJ+85MGTQgdWqR6oeBCGgACBhYcc/FyUVNF9q4ulCmzGLjQ7
 WogkB96HDdFRj+XDvI0wlAFfOOdOM7Xd/tnFKv1jtsXX8ZwQTLLyXJdAvDZTLEjRiy8S
 ra09RAeL54gb3U3APMfi9jNl3WO7QzHMgiZpDo5pvdily1l0zysW50BLpeHxriAx5YaV
 cF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792103367; x=1792708167;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WZ1OyRzHt1ZBX79eoZyilrSKmMYQjSY/4VnaBjrbrhg=;
 b=ZUWfFmjU38lplsGDicPM8wirhdPAmEoop8RNr7WI+Er6SutfpcuR3AeJapW/cW35Jv
 A4bLcXfr8Hn45QsbuHB4rdBZYaKEoLDtTpGX2cdQDTYS3Hy/Jw1ko/QIPlizcCFgJu86
 ZOWWu2bqIgjjBTT/sNiWkQXkZhnvKCzpzcjChNt/h0HmzkCeUaxArOja4Sq0C8BU52qh
 FTeDobRuECo97YiSDwwAx4hGwWpaRnxtCh9ehP3/ldOSz9Of6o3Qr0mq/CVdxwh+iSr8
 1hCbpK4paYnZHj9OjxQcpsn5i+Ls8mAijqlYuj80Yzee8slZHW9h8LCQXXBSKwxL1Dju
 RqWA==
X-Gm-Message-State: AFq9FYLDCAAM+THNklbUJsE7ieAium9sQ241+q48tmS9B+6JcmwUFapW
 7WKXyn9K/bOpZoMXidJvYHDDVX1p38wcV1PQE+hLOp9MfM0go7rvbBGdVVibFpcnu7qenbUoumo
 +ZxWF+3bqw67tVM7LRWpwvrDI42CWaps=
X-Gm-Gg: AYBFou2BfNm58ahRWN9AW7wrGRfgeF48TiGZt6MoNqYFBonQMZcHinSQflQfFS4zvvx
 DvQxtxKTpB7eLYw7GPZb603B4jL8cAjyPwD5fNI175iD1c1uvhhxdQk89g56/iEAWHxMc8EdKnl
 tLuCWSsd4Uh8a98oBJtmT72vMmKLq+K+AQz1X4uO7X2d3XM4lQB2byWz/ZIqDrpuQvt266mhER9
 XX3OOCbUvpX2GZpUWbvguRPQaUx9JwMb8Y84OUC+BVE3Obetvjl0ZXlWn0D+J7H7NsRzs0vEl/G
 sq/aPDPKN5IILL14So7DL2ZYjXjHZL1Lm7+oMEefZWSLZJRiGB4FSGA2
X-Received: by 2002:a05:690c:3489:b0:8b0:e10d:1975 with SMTP id
 00721157ae682-8b0e10d1ffcmr5726827b3.29.1792103366501; Thu, 15 Oct 2026
 15:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
 <20261011-pvr-gpuvm-immediate-v2-1-744ddc6644c3@gmail.com>
 <sashiko-outbox-167146@kernel.org>
In-Reply-To: <sashiko-outbox-167146@kernel.org>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Fri, 16 Oct 2026 07:29:10 +0900
X-Gm-Features: AclHuK8-D8pReVGIBv0OUN0G87STfZ_9okqUcud5PK2ya0w7oJOijIVLcma891o
Message-ID: <CAKbEznuHom600zb9XNqaXW9U8+4wDT66aA0KJaeY9jswKsJAJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/imagination: Switch the GPUVM to immediate mode
To: sashiko-reviews@lists.linux.dev
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000008fa830065de89492"
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

--0000000000008fa830065de89492
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To be clear, this is a pre-existing issue and should be fixed in a separate
patch.

Thanks,
Gyeyoung

2026=EB=85=84 10=EC=9B=94 11=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 6:56, =
<sashiko-bot@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] drm/imagination: infinite loop in pvr_vm_unmap_all() on unmap
> failure
> --
>
> commit e8ae922e82d0545dbcb5536fc88e9f62e91d62ac
> Author: Gyeyoung Baek <gye976@gmail.com>
>
>     drm/imagination: Switch the GPUVM to immediate mode
>
>     Use DRM_GPUVM_IMMEDIATE_MODE so that each GEM's GPUVA list is protect=
ed
>     by its gpuva.lock instead of its dma_resv. This prepares for
>     asynchronous VM_BIND, whose run_job() will update the GPUVA lists
>     before signalling its fence. That section imposes three rules:
>
> [ ... ]
>
> > diff --git a/drivers/gpu/drm/imagination/pvr_vm.c
> b/drivers/gpu/drm/imagination/pvr_vm.c
> > index cbdd15ed74fdb..807a01aab1dae 100644
> > --- a/drivers/gpu/drm/imagination/pvr_vm.c
> > +++ b/drivers/gpu/drm/imagination/pvr_vm.c
>
> [ ... ]
>
> > @@ -906,6 +925,8 @@ pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
> >       }
> >
> >       mutex_unlock(&vm_ctx->lock);
> > +
> > +     drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> >  }
>
> [Severity: High]
> Can this result in an infinite loop if the unmap operation fails?
>
> Looking at the loop just above this context in pvr_vm_unmap_all():
>
>         for (;;) {
>                 struct pvr_gem_object *pvr_obj;
>                 struct drm_gpuva *va;
>
>                 va =3D drm_gpuva_find_first(&vm_ctx->gpuvm_mgr,
>                                           vm_ctx->gpuvm_mgr.mm_start,
>                                           vm_ctx->gpuvm_mgr.mm_range);
>                 if (!va)
>                         break;
>
>                 pvr_obj =3D gem_to_pvr_gem(va->gem.obj);
>
>                 WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
>                                                 va->va.addr,
> va->va.range));
>         }
>
> If pvr_vm_unmap_obj_locked() returns an error (which is highly possible,
> for
> example when kzalloc_obj() or pvr_mmu_op_context_create() return -ENOMEM
> inside pvr_vm_bind_op_unmap_init() during process teardown), the VA remai=
ns
> in the tree.
>
> Since the loop evaluates WARN_ON() but does not break on error, it appear=
s
> drm_gpuva_find_first() will find the exact same VA again, causing the loo=
p
> to
> spin indefinitely. This could lead to a kernel soft lockup.
>
> It looks like the series end commit removes the drm_gpuvm_exec_lock but
> leaves the -ENOMEM failure paths intact, so the lockup potential remains.
>
> --
> Sashiko AI review =C2=B7
> https://sashiko.dev/#/patchset/20261011-pvr-gpuvm-immediate-v2-0-744ddc66=
44c3@gmail.com?part=3D1
>

--0000000000008fa830065de89492
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>To be clear, this is a pre-existing issue and should=
 be fixed in a separate patch.</div><div dir=3D"auto"><br></div><div data-s=
martmail=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,</div><div>Gyeyou=
ng</div></div></div></div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">2026=EB=85=84 10=EC=9B=94 11=EC=
=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 6:56,  &lt;<a href=3D"mailto:sashiko-=
bot@kernel.org">sashiko-bot@kernel.org</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Thank you for your contr=
ibution! Sashiko AI review found 1 potential issue(s) to consider:<br>
- [High] drm/imagination: infinite loop in pvr_vm_unmap_all() on unmap fail=
ure<br>
--<br>
<br>
commit e8ae922e82d0545dbcb5536fc88e9f62e91d62ac<br>
Author: Gyeyoung Baek &lt;<a href=3D"mailto:gye976@gmail.com" target=3D"_bl=
ank" rel=3D"noreferrer">gye976@gmail.com</a>&gt;<br>
<br>
=C2=A0 =C2=A0 drm/imagination: Switch the GPUVM to immediate mode<br>
<br>
=C2=A0 =C2=A0 Use DRM_GPUVM_IMMEDIATE_MODE so that each GEM&#39;s GPUVA lis=
t is protected<br>
=C2=A0 =C2=A0 by its gpuva.lock instead of its dma_resv. This prepares for<=
br>
=C2=A0 =C2=A0 asynchronous VM_BIND, whose run_job() will update the GPUVA l=
ists<br>
=C2=A0 =C2=A0 before signalling its fence. That section imposes three rules=
:<br>
<br>
[ ... ]<br>
<br>
&gt; diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/im=
agination/pvr_vm.c<br>
&gt; index cbdd15ed74fdb..807a01aab1dae 100644<br>
&gt; --- a/drivers/gpu/drm/imagination/pvr_vm.c<br>
&gt; +++ b/drivers/gpu/drm/imagination/pvr_vm.c<br>
<br>
[ ... ]<br>
<br>
&gt; @@ -906,6 +925,8 @@ pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;vm_ctx-&gt;lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0drm_gpuvm_bo_deferred_cleanup(&amp;vm_ctx-&gt;gpu=
vm_mgr);<br>
&gt;=C2=A0 }<br>
<br>
[Severity: High]<br>
Can this result in an infinite loop if the unmap operation fails?<br>
<br>
Looking at the loop just above this context in pvr_vm_unmap_all():<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pvr_gem_obje=
ct *pvr_obj;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_gpuva *v=
a;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 va =3D drm_gpuva_fi=
nd_first(&amp;vm_ctx-&gt;gpuvm_mgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
m_ctx-&gt;gpuvm_mgr.mm_start,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
m_ctx-&gt;gpuvm_mgr.mm_range);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!va)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pvr_obj =3D gem_to_=
pvr_gem(va-&gt;gem.obj);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN_ON(pvr_vm_unma=
p_obj_locked(vm_ctx, pvr_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 va-&gt;va.addr, va-&gt;va.range));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
If pvr_vm_unmap_obj_locked() returns an error (which is highly possible, fo=
r<br>
example when kzalloc_obj() or pvr_mmu_op_context_create() return -ENOMEM<br=
>
inside pvr_vm_bind_op_unmap_init() during process teardown), the VA remains=
<br>
in the tree.<br>
<br>
Since the loop evaluates WARN_ON() but does not break on error, it appears<=
br>
drm_gpuva_find_first() will find the exact same VA again, causing the loop =
to<br>
spin indefinitely. This could lead to a kernel soft lockup.<br>
<br>
It looks like the series end commit removes the drm_gpuvm_exec_lock but<br>
leaves the -ENOMEM failure paths intact, so the lockup potential remains.<b=
r>
<br>
-- <br>
Sashiko AI review =C2=B7 <a href=3D"https://sashiko.dev/#/patchset/20261011=
-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com?part=3D1" rel=3D"noreferre=
r noreferrer" target=3D"_blank">https://sashiko.dev/#/patchset/20261011-pvr=
-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com?part=3D1</a><br>
</blockquote></div>

--0000000000008fa830065de89492--
