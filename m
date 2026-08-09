Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BB5C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695F910E694;
	Mon, 10 Aug 2026 06:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFQhh9j+";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D00610E0E7
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 18:34:23 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-81ee6b2da98so15618217b3.3
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 11:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786300462; cv=none;
 d=google.com; s=arc-20260327;
 b=C+2JuFictok4Dwqzs2Wo9y8dm92TS1Q3LZdgxXInxWJ9o/p8AWLj63tOf+imrYW66q
 gvs9I+5RkOYeph6I27626sIOLbv+akrBCoAe8aEA4cwFgaH7HdnZRxitSr0nDwt9GOCK
 8fbTZPcxZuRZspkQ4A6VZjKHiApT1V6wcAUlwhFk7LabKo7xmyta3gVKFYFgvUSaSHc2
 2UeOh7SjfwCq6JEvHBnwfgrWCfDSR0xuMj9+I4ZYp+oBOl+qK+K898bNdE531uXKcD82
 lgIDQ51iVZxMto+j+CcrNdRJAdF1K7W9tVrhxyvPUR+Y7SzWCT1m3NxtWNWRZpQrjDP+
 m5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GIT1CkndZoPFGz2aHXZk381lfAI936YVS/8/Au1pb8A=;
 fh=otjR1ydunTJk0fPS51Ls3JXICOEaW9x5X/pvorWC7rE=;
 b=Po8mBbG5I24JVx++GRRD8Bj4a3ZNmrZH2KImVc9St+kY7+hIrSKyXYENu/KoETvzwv
 Cj8PS6R8uRVtmWccMVjmHp3uVG+4TH5X8nmt23blr2XUYdzI9Pvk2QTdSmBISP9P4ZPY
 3R6jiTmBxeQaoAKJN1+5n4rOeDSjgWbAzK29FgMmLN/2VY+Su18bxtJ1pymg82z4PkD6
 SSMY6iQpODQ7aA/J7C8wwILZ0hadPE9IdKU7ajdLfX+vBrieVvHELQHeHokOSuPLben/
 D6PhHNa4ohzFwPRi16axJgpJiPswfVx14R2ndMTwXW5B1a8Prlv2zSuv+TpQ6Ij9GIU4
 l0dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786300462; x=1786905262; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GIT1CkndZoPFGz2aHXZk381lfAI936YVS/8/Au1pb8A=;
 b=IFQhh9j+pqp04wTem3j1glY+3AxxzvTLKAEgSoQfdb8GybsY2yAR/9f5Hczx+rAltU
 9CQAIj+6esHqRqrEhr5k89sd0b2Y/yfLa02GgQt8ForU9thgXXMkqU2Akdpue9b74NBE
 s8sK8VFQ/Yqi8mwLzAzuF3s/WPmy7JDcZytVtBzw+dVMRs2CxDo2bUSGWfFq43QN5rGp
 79Zzr7cyOHxdBlT5MuCTBQ8NfwUIVZqN0KW9/PPSTi/THOaw8K4mD9+XljVElinSwGC4
 PKc24lQZInXrybNwMG4u4U5YXcJe2cnNWy4RPs2ZoicaGPaZCZxju3mo0b18cRWic6af
 CuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786300462; x=1786905262;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GIT1CkndZoPFGz2aHXZk381lfAI936YVS/8/Au1pb8A=;
 b=Um/YCMrWFOgRmuTinWbCzd0zDrcEfeFIdzqCEkdDI7/JopxgUyOMKr8mok7mAeZnoX
 lFd6ZMqHAbR5FYBwfg53hGwLD2m8A71HzQTcTfvRc3RCDHw9oKKihReok4U2i0kEACPU
 fsx3Vfhgfn3pgedXpXYgCa5l+yTY8v0XAXQ2Xzo6untoUDvWGrkMl3snT2cKo5gJcp6A
 hpv1rI+EQcA9iWQ3BL+shhBxhkJjDLJZkk+G/ROYBnJBN8KdgIWJaz+XHIiEVF0SAc+p
 iNVcbhrU2burLs16rdsRAECeByFQqLA9PwDG7mu9kkMMqdQZN6blYOKxFSFDyM0FTFNJ
 /nMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAgY0qFYLRya7xy01ehVm6c50gSwMrsOn0lQ/Am15N3I8d5chBJLBqrQ4suZZpJshfxp1b+ZWKpXk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCimetV4BHPQXHRZ+dnBRNZCHeUKNNu9EoZQhNoPuf2DZ6jqr4
 phWBtllKdBUSTnuANNWnLTxMELdxm10v0ose6RWY/JHaFqeNt4B5TOz2kEHJMNftjYevNew+rTu
 pJH8IXVPNAXY9NsJYxrDUWnzrihCdO00=
X-Gm-Gg: AR+sD12IZwnd5MOMwUyugbh8mYc1eOgQyXqTRYmlEbTYvmAN+NZari+8xMQbvm4AWZM
 C25/Z3iNwXDMwr0LQilWISswqVgmtKcqA8b9tJz7VXeEZM+r8W4SX4KqMX8VVlYw8EoHDrqrK/q
 nQxGsLqHOHGzmzTYATZm9Mh+DRZGB+zfHB+C/hr2qnPgGWpuxs3KlLGtZylnNwDbMO4C+xy7+zK
 dF9pR6RLz64544tJlGD4j9rCYeS+qBpbuHUrQQuVnaK059MMI4qAKBy991uV2zasv9ylddXsozs
 EH1B4iJtBcS5QpDCk9Gxnwta3bv3sTurOqSqQtPyaFI=
X-Received: by 2002:a05:690c:a9e:b0:81d:489e:8847 with SMTP id
 00721157ae682-825728d10f0mr95488087b3.2.1786300462179; Sun, 09 Aug 2026
 11:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260808231002.67559-1-qwe.aldo@gmail.com>
 <CABQX2QOWeCRBKXPv7gZrCXE9FuesWn0_3SEC33RjPDJHgPUxHw@mail.gmail.com>
In-Reply-To: <CABQX2QOWeCRBKXPv7gZrCXE9FuesWn0_3SEC33RjPDJHgPUxHw@mail.gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sun, 9 Aug 2026 15:34:11 -0300
X-Gm-Features: AUfX_mxm52pL0I996Nl3gAUsnN_6w12VYsp16aNvkJbsr4Xro1BwUGpF6YHyfns
Message-ID: <CAP48HftXmnzuhGQRcmproerVA9YYQGdytsei1+Vnjg_MKEaDww@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: return an error when a shared GB surface has
 no backup buffer
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000082b2710658a17cf1"
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:38:24 +0000
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

--00000000000082b2710658a17cf1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zack, thanks for the careful review.

I used an LLM only to help with the analysis. The work behind it is
manual, though =E2=80=94 I audit the vmwgfx code by hand and run instrument=
ed
builds of the driver (KASAN/KMSAN under syzkaller).

This particular bug came from reading vmw_gb_surface_reference_internal()
rather than from a fuzzer. I confirmed the disclosure by building with
CONFIG_INIT_STACK_NONE and watching the reply come back with 53 of the 72
bytes non-zero, several of them kernel pointers =E2=80=94 so the impact is
measured, not assumed. (KASAN wouldn't flag this one on its own, since
it's an uninitialised-stack read.)

The three commits I referenced (a97e21923b42, 14b1c33e8429, c594285f30fa) I
traced by hand through the git history.

Agreed the description is far too long for what it is; I'll cut it down.

And thanks for the ttm_ref_object_base_unref() catch =E2=80=94 you're right=
 that
-EINVAL turns the previously-balanced reference into a leak (user space
no longer calls DRM_VMW_UNREF_SURFACE). I'll drop it on the error path in
v2.

v2 coming with both changes.

Thanks,
Aldo

El dom, 9 de ago de 2026, 14:35, Zack Rusin <zack.rusin@broadcom.com>
escribi=C3=B3:

> On Sat, Aug 8, 2026 at 7:10=E2=80=AFPM Aldo Ariel Panzardo <qwe.aldo@gmai=
l.com>
> wrote:
> >
> > vmw_gb_surface_reference_internal() rejects a surface without a backup
> > buffer by logging an error and jumping to the exit label, but it never
> > sets ret on that path:
> >
> >         ret =3D vmw_surface_handle_reference(dev_priv, file_priv, req->=
sid,
> >                                            req->handle_type, &base);
> >         if (unlikely(ret !=3D 0))
> >                 return ret;
> >         ...
> >         if (!srf->res.guest_memory_bo) {
> >                 DRM_ERROR("Shared GB surface is missing a backup
> buffer.\n");
> >                 goto out_bad_resource;
> >         }
> >         ...
> > out_bad_resource:
> >         ttm_base_object_unref(&base);
> >
> >         return ret;
> >
> > ret is still 0 from the successful vmw_surface_handle_reference() above=
,
> > so the function returns success while leaving *rep completely unwritten=
.
> > The other goto to the same label is inside an if (ret !=3D 0) block and=
 so
> > carries a real error; this one is the only path that reaches the label
> > with ret =3D=3D 0.
> >
> > The caller then copies that untouched output structure to user space.
> > For DRM_VMW_GB_SURFACE_REF, vmw_gb_surface_reference_ioctl() passes a
> > stack local:
> >
> >         struct drm_vmw_gb_surface_ref_ext_rep rep_ext;
> >         int ret;
> >
> >         ret =3D vmw_gb_surface_reference_internal(dev, req, &rep_ext,
> file_priv);
> >
> >         if (unlikely(ret !=3D 0))
> >                 return ret;
> >
> >         rep->creq =3D rep_ext.creq.base;
> >         rep->crep =3D rep_ext.crep;
> >
> > so 48 + 24 =3D 72 bytes of an uninitialised stack variable are copied i=
nto
> > the ioctl buffer, and drm_ioctl() copies that buffer back out.  The ioc=
tl
> > is a DRM_IOWR of exactly 72 bytes, so in_size =3D=3D out_size and the c=
ore
> > does not zero any tail.  DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALLOW, so
> > this is reachable by an unprivileged local user through a render node.
> >
> > What actually leaks depends on how the kernel was built.  With
> > CONFIG_INIT_STACK_ALL_ZERO, which is the Kconfig default whenever the
> > compiler supports it and therefore what the major distributions ship,
> > rep_ext is zeroed on function entry and user space receives 72 zero
> > bytes.  With CONFIG_INIT_STACK_NONE the contents are whatever the
> > previous call at that stack depth left behind; on a test kernel built
> > that way, 53 of the 72 bytes came back non-zero and several of them wer=
e
> > kernel pointers.  So the information disclosure is configuration
> > dependent, but the control flow defect is not: on every configuration
> > the ioctl reports success and hands back a reply that was never
> > produced, which user space cannot distinguish from a real one.
> >
> > The path was correct when the ioctl was introduced in a97e21923b42
> > ("drm/vmwgfx: Hook up guest-backed surfaces"): ret was initialised to
> > -EINVAL and the first assignment to it came after this goto, so the
> > label really did return -EINVAL.  14b1c33e8429 split the handler into
> > vmw_gb_surface_reference_internal() and moved the
> > vmw_surface_handle_reference() call - and with it the first assignment
> > to ret - above the check, which left the initialiser dead and this path
> > returning 0.  The dead initialiser was removed later, as a Coverity
> > "unused value", by c594285f30fa ("drm/vmwgfx: remove redundant
> > assignment to variable ret"); that removal was correct in itself.
> >
> > The driver already knows the request failed - it logs an error - so
> > report that to the caller.
> >
> > Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create
> and reference")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>
> Hi, thanks for the patch! Did you forget to disclose the llm used to
> find and fix it? I'm asking because that commit description is very
> hard to read for what is essentially "ret hasn't been correctly
> assigned, returning stale success status and leading to possible
> invalid reads in userspace". Plus, I'd like to know how to handle the
> commits referenced in the description. In general, I'd trust them if
> you have looked them up yourself by hand but I'll need to validate a
> lot more carefully if they're llm generated.
>
> We probably also want to add a ttm_ref_object_base_unref(tfile,
> base->handle); to the out_bad_resource section because before with
> this function returning success it, accidently, made userspace still
> call DRM_VMW_UNREF_SURFACE balencing out the ttm file reference count.
> Now we're just going to be leaking the reference added by
> ttm_ref_object_add in vmw_surface_handle_reference.
>
> z
>

--00000000000082b2710658a17cf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Zack, thanks for the careful review.<div dir=3D"auto">=
<br></div><div dir=3D"auto">I used an LLM only to help with the analysis. T=
he work behind it is</div><div dir=3D"auto">manual, though =E2=80=94 I audi=
t the vmwgfx code by hand and run instrumented</div><div dir=3D"auto">build=
s of the driver (KASAN/KMSAN under syzkaller).</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">This particular bug came from reading vmw_gb_surface=
_reference_internal()</div><div dir=3D"auto">rather than from a fuzzer. I c=
onfirmed the disclosure by building with</div><div dir=3D"auto">CONFIG_INIT=
_STACK_NONE and watching the reply come back with 53 of the 72</div><div di=
r=3D"auto">bytes non-zero, several of them kernel pointers =E2=80=94 so the=
 impact is</div><div dir=3D"auto">measured, not assumed. (KASAN wouldn&#39;=
t flag this one on its own, since</div><div dir=3D"auto">it&#39;s an uninit=
ialised-stack read.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">The=
 three commits I referenced (a97e21923b42, 14b1c33e8429, c594285f30fa) I tr=
aced by hand through the git history.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Agreed the description is far too long for what it is; I&#39;=
ll cut it down.</div><div dir=3D"auto"><br></div><div dir=3D"auto">And than=
ks for the ttm_ref_object_base_unref() catch =E2=80=94 you&#39;re right tha=
t</div><div dir=3D"auto">-EINVAL turns the previously-balanced reference in=
to a leak (user space</div><div dir=3D"auto">no longer calls DRM_VMW_UNREF_=
SURFACE). I&#39;ll drop it on the error path in</div><div dir=3D"auto">v2.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">v2 coming with both chan=
ges.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div d=
ir=3D"auto">Aldo</div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">El dom, 9 de ago de 2026, 14:35=
, Zack Rusin &lt;<a href=3D"mailto:zack.rusin@broadcom.com">zack.rusin@broa=
dcom.com</a>&gt; escribi=C3=B3:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On =
Sat, Aug 8, 2026 at 7:10=E2=80=AFPM Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; vmw_gb_surface_reference_internal() rejects a surface without a backup=
<br>
&gt; buffer by logging an error and jumping to the exit label, but it never=
<br>
&gt; sets ret on that path:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmw_surface_handle_reference(=
dev_priv, file_priv, req-&gt;sid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 req-&gt;handle_type, &amp;base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(ret !=3D 0))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return re=
t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!srf-&gt;res.guest_memory_bo) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR=
(&quot;Shared GB surface is missing a backup buffer.\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_=
bad_resource;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt; out_bad_resource:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttm_base_object_unref(&amp;base);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;<br>
&gt; ret is still 0 from the successful vmw_surface_handle_reference() abov=
e,<br>
&gt; so the function returns success while leaving *rep completely unwritte=
n.<br>
&gt; The other goto to the same label is inside an if (ret !=3D 0) block an=
d so<br>
&gt; carries a real error; this one is the only path that reaches the label=
<br>
&gt; with ret =3D=3D 0.<br>
&gt;<br>
&gt; The caller then copies that untouched output structure to user space.<=
br>
&gt; For DRM_VMW_GB_SURFACE_REF, vmw_gb_surface_reference_ioctl() passes a<=
br>
&gt; stack local:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_vmw_gb_surface_ref_ext_rep=
 rep_ext;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmw_gb_surface_reference_inte=
rnal(dev, req, &amp;rep_ext, file_priv);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(ret !=3D 0))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return re=
t;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rep-&gt;creq =3D rep_ext.creq.base;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rep-&gt;crep =3D rep_ext.crep;<br>
&gt;<br>
&gt; so 48 + 24 =3D 72 bytes of an uninitialised stack variable are copied =
into<br>
&gt; the ioctl buffer, and drm_ioctl() copies that buffer back out.=C2=A0 T=
he ioctl<br>
&gt; is a DRM_IOWR of exactly 72 bytes, so in_size =3D=3D out_size and the =
core<br>
&gt; does not zero any tail.=C2=A0 DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALL=
OW, so<br>
&gt; this is reachable by an unprivileged local user through a render node.=
<br>
&gt;<br>
&gt; What actually leaks depends on how the kernel was built.=C2=A0 With<br=
>
&gt; CONFIG_INIT_STACK_ALL_ZERO, which is the Kconfig default whenever the<=
br>
&gt; compiler supports it and therefore what the major distributions ship,<=
br>
&gt; rep_ext is zeroed on function entry and user space receives 72 zero<br=
>
&gt; bytes.=C2=A0 With CONFIG_INIT_STACK_NONE the contents are whatever the=
<br>
&gt; previous call at that stack depth left behind; on a test kernel built<=
br>
&gt; that way, 53 of the 72 bytes came back non-zero and several of them we=
re<br>
&gt; kernel pointers.=C2=A0 So the information disclosure is configuration<=
br>
&gt; dependent, but the control flow defect is not: on every configuration<=
br>
&gt; the ioctl reports success and hands back a reply that was never<br>
&gt; produced, which user space cannot distinguish from a real one.<br>
&gt;<br>
&gt; The path was correct when the ioctl was introduced in a97e21923b42<br>
&gt; (&quot;drm/vmwgfx: Hook up guest-backed surfaces&quot;): ret was initi=
alised to<br>
&gt; -EINVAL and the first assignment to it came after this goto, so the<br=
>
&gt; label really did return -EINVAL.=C2=A0 14b1c33e8429 split the handler =
into<br>
&gt; vmw_gb_surface_reference_internal() and moved the<br>
&gt; vmw_surface_handle_reference() call - and with it the first assignment=
<br>
&gt; to ret - above the check, which left the initialiser dead and this pat=
h<br>
&gt; returning 0.=C2=A0 The dead initialiser was removed later, as a Coveri=
ty<br>
&gt; &quot;unused value&quot;, by c594285f30fa (&quot;drm/vmwgfx: remove re=
dundant<br>
&gt; assignment to variable ret&quot;); that removal was correct in itself.=
<br>
&gt;<br>
&gt; The driver already knows the request failed - it logs an error - so<br=
>
&gt; report that to the caller.<br>
&gt;<br>
&gt; Fixes: 14b1c33e8429 (&quot;drm/vmwgfx: Add new ioctl for GB surface cr=
eate and reference&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D=
"noreferrer">stable@vger.kernel.org</a><br>
&gt; Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.com</a>&gt;<br>
<br>
Hi, thanks for the patch! Did you forget to disclose the llm used to<br>
find and fix it? I&#39;m asking because that commit description is very<br>
hard to read for what is essentially &quot;ret hasn&#39;t been correctly<br=
>
assigned, returning stale success status and leading to possible<br>
invalid reads in userspace&quot;. Plus, I&#39;d like to know how to handle =
the<br>
commits referenced in the description. In general, I&#39;d trust them if<br=
>
you have looked them up yourself by hand but I&#39;ll need to validate a<br=
>
lot more carefully if they&#39;re llm generated.<br>
<br>
We probably also want to add a ttm_ref_object_base_unref(tfile,<br>
base-&gt;handle); to the out_bad_resource section because before with<br>
this function returning success it, accidently, made userspace still<br>
call DRM_VMW_UNREF_SURFACE balencing out the ttm file reference count.<br>
Now we&#39;re just going to be leaking the reference added by<br>
ttm_ref_object_add in vmw_surface_handle_reference.<br>
<br>
z<br>
</blockquote></div>

--00000000000082b2710658a17cf1--
