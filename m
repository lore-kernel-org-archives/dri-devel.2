Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C439C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD0510F36A;
	Thu, 24 Sep 2026 07:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b5y96raD";
	dkim-atps=neutral
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com
 [74.125.230.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7433410F36C
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:07:30 +0000 (UTC)
Received: by mail-lr2-f10.google.com with SMTP id
 38308e7fff4ca-3a499fd4357so9253441fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790233648; cv=none;
 d=google.com; s=arc-20260327;
 b=kO2V4zI9Mko428fa0ccmUEZiEFuPyWPhclLHTVUUuAz8YDcNW/CIqLs9aMIxdlG6UM
 JcPhmqU6JGzFnzvqP6MMgKg9qM976iSe021sVCyutFjAWQ0uHPlZhqzAWBig/3NO65X5
 zx3Y1d/LCw2CRzBy/zloNqyp1aQ8I2PKRV2J+54TaBafI27/Ptw3JF55RBb8DSLFY3a6
 xXYUUKK56VBVyTRHH5CZ4x5RdXlyScGYKgJXvxYQMru0jo1dkROd9UAKCprfB9HMITY6
 5yOfkIZA5Ajuh0F/UZu68I8geGlXXmR+CUwgj8fmmibJWVKLtQ+kC9wb9MN4OOTpMopH
 bV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Omcsv3OsXwGCeJM+502nGcJqAvAo2uAuiV3zLSTgZqs=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=sLY9zzgXVU9PAp0HTcNMQ+BbsIBX48ng+wj/JiLnJ5mAxABAKDfiKCsSxNroM9UKTF
 GD961YuRkmdt4uccJ3EDjbrsCruM10iXsG7ixFNF0ogw/qYEbSUwod9lDuxTChaHngy8
 Pr6QpXZXqqnckuGL9kkO3zE6W2xGY+VIDB49bf7ewijPIL2w9pJfuYkzDd/t3xv1OYmA
 CT0sWJ/0MBjtKUwGDaXAf7zZM4aU94oyWqSDxuwRtk0PzEuAYq9bLW+V4DkHq/5keV0T
 tkLvy5pudiI7KdxzCxwpaRdZsijdZsGX5u0r9heXszjrs4wKz6zlgjUowR+fht+gVj7V
 V9vQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790233648; x=1790838448; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Omcsv3OsXwGCeJM+502nGcJqAvAo2uAuiV3zLSTgZqs=;
 b=b5y96raD1neef8G7oUrX1f0p/D+RvvtAO0JIOnbKPg7ACO2jIXT0aklzzKa4ho+br7
 BIdjw/holhjmMLGrTRWtRJbxmcnZYqxCtp6OtSZuUsi9YCBovF3SRqFAiXg6nueaWVSz
 4KMtbvfdbWZAwq8OFUlD3LzXWwQxJUVMwHhn1ko+iiXuFM35dS6XWNmB/Nnff7pLO7JV
 Qdb5dgAQERbs/Sog+Ex6yKr1BfDehZsfLar6+6eoweD3Kn/z8CkMph51+IihcJ9Lx5Nu
 zNH9w4fSBSayr3FIo8iyXo0dlak+a7eVMHhTz1/5byszf3cnqeUv/+NBioHTB5EQmr5P
 CtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790233648; x=1790838448;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Omcsv3OsXwGCeJM+502nGcJqAvAo2uAuiV3zLSTgZqs=;
 b=WdnEESnWiVU9zkPJOb6DBTdwP9UBoiQQ0eyZ92C2/fbGEStGgLvrRnQFma6Spuvtsy
 xY41iMmlIuz5jc2+Zp6+W8S2R7KqPLiEpi5+MMcaBH10TL5r+mf/pVlozC3GSiQRZsnP
 cEzYMdo6IvZZ+yXD38HdXLMuwhunoY5NUdFP+bVPiKr6wtcp0Y0fIKxzU+T149okegPe
 090DTZ1pnLMzoX1qtqgH3blMu/0FR87VpyZ2mGsdBy5Eeifm7yIyuDFEGlkLIUCaocpV
 iweZ4hHWpxmv/0ijNdTxrujW4kruL8jBrr/Vj0eR+xnK4mJrPZuwWp9G6cpAsvmDUAUO
 uIyg==
X-Gm-Message-State: AFuF++l+gE4r/yINmOQaNlB3C6/pFyocklac8Dyy2tw4LFGeVFK6bPVc
 dxCVvbtaDlpL2dUNVc2dSRc68Q2prxVJKBWjTdb8T1+XM7O6+nMQ4jiN90OUw9Y5KQBWhJN2itE
 1sx6SBYHNUxThvYgrdLWCgqGes3lNL+xiet48Vsr5Ug==
X-Gm-Gg: AYBFou24AdMCg+r8vJagTpt5KI0vDE+yo/Y4qtHS4tqfia33HyaTphMBdZzWDS9ZdVB
 fG6mZ0/vBvALGLTCLYiWhix0/dLKz+wROP676o2Vfq2e45ULogYLpLykMY5KY7koEyKbST39oAg
 cHorBE3egGy19VxJiA4rJSToOWTXy1Hn+j501xZUGRwoxtZ2F/Ss3wBxEtzhzjRH9U0C7Okv9Mi
 7Vv01Zp/JLnxuvtLJLZZMgm3DS1vThr/hE4fkCnZomezTt4Y+cSkzPtrlVcb6TcLMhIz9ukpjkm
 bEUrn0fSsT76L+3yoqhc+F4lOkn/7/iVLGpEdfFzVRK3F6twvdA6
X-Received: by 2002:ac2:4432:0:b0:5b6:1a7c:aa12 with SMTP id
 2adb3069b0e04-5b8df0740a1mr328772e87.42.1790233648057; Thu, 24 Sep 2026
 00:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
 <20260923150753.170D11F000FF@smtp.kernel.org>
In-Reply-To: <20260923150753.170D11F000FF@smtp.kernel.org>
From: Roman <roman.demidov.nn@gmail.com>
Date: Thu, 24 Sep 2026 10:07:16 +0300
X-Gm-Features: AclHuK8B0wcB9AXBAefU608zGQqzZG-52fzOuJjtER2pzb9jjs1oILlcpKXbyq0
Message-ID: <CA+KF4b+8T9YaZVvA7x2=KMxdxsvJ9QM6hw4-8ft_zDvzB51T1g@mail.gmail.com>
Subject: Re: [PATCH 5.15 1/2] drm/amdgpu: Use vmemdup_array_user in
 amdgpu_bo_create_list_entry_array
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000a85014065c3540d8"
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

--000000000000a85014065c3540d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

vmemdup_array_user() is already available in 5.15.y via commit 24b17d530c42
(string.h: add array-wrappers for (v)memdup_user()). So there is no
implicit declaration or pointer truncation, and the described build failure
does not apply to the target stable tree.


=D1=81=D1=80, 23 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 18:0=
7, <sashiko-bot@kernel.org>:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Low] build: missing vmemdup_array_user helper
> --
>
> commit 4d70c808a81c22c8b9f6c03847fa45f071b2e967
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array
>
> This commit replaces kvmalloc_array() + copy_from_user() with
> vmemdup_array_user() on the fast path. This aims to shrink the source cod=
e
> and improve separation between kernel and userspace slabs.
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> > index 15c45b2a39835..b364f3f5fb918 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> > @@ -223,43 +223,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list
> *list)
> >  int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in=
,
> >                                     struct drm_amdgpu_bo_list_entry
> **info_param)
> >  {
> [ ... ]
> >       /* copy the handle array from userspace to a kernel buffer */
> > -     r =3D -EFAULT;
> > -     if (likely(info_size =3D=3D in->bo_info_size)) {
> > -             unsigned long bytes =3D in->bo_number *
> > -                     in->bo_info_size;
> > -
> > -             if (copy_from_user(info, uptr, bytes))
> > -                     goto error_free;
> > -
> > +     if (likely(info_size =3D=3D bo_info_size)) {
> > +             info =3D vmemdup_array_user(uptr, bo_number, info_size);
>
> [Severity: Low]
> Does this code call a function vmemdup_array_user() that does not exist i=
n
> this kernel tree?
>
> When compiling drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c with
> CONFIG_DRM_AMDGPU=3Dy or m, this will result in a build failure due to an
> implicit function declaration in amdgpu_bo_create_list_entry_array(). If
> the
> compiler allows implicit declarations, it would assume a 32-bit int retur=
n
> type, which truncates the pointer on 64-bit systems and can lead to an
> invalid pointer dereference or use-after-free when IS_ERR(info) or
> kvfree(info) is called later.
>
> > +             if (IS_ERR(info))
> > +                     return PTR_ERR(info);
>
> --
> Sashiko AI review =C2=B7
> https://sashiko.dev/#/patchset/20260923145453.76114-1-roman.demidov.nn@gm=
ail.com?part=3D1
>

--000000000000a85014065c3540d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-ds-message gmail-_63c77b1"><div class=
=3D"gmail-ds-markdown gmail-ds-assistant-message-main-content"><blockquote>=
<p class=3D"gmail-ds-markdown-paragraph"><code>vmemdup_array_user()</code><=
span class=3D"gmail-"> is already available in 5.15.y via commit </span><co=
de>24b17d530c42</code><span class=3D"gmail-"> (</span><code>string.h: add a=
rray-wrappers for (v)memdup_user()</code><span class=3D"gmail-">).
 So there is no implicit declaration or pointer truncation, and the=20
described build failure does not apply to the target stable tree.</span></p=
></blockquote></div></div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 23 =D1=81=D0=
=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 18:07, &lt;<a href=3D"mailto:s=
ashiko-bot@kernel.org">sashiko-bot@kernel.org</a>&gt;:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Thank you for your contribution! Sas=
hiko AI review found 1 potential issue(s) to consider:<br>
- [Low] build: missing vmemdup_array_user helper<br>
--<br>
<br>
commit 4d70c808a81c22c8b9f6c03847fa45f071b2e967<br>
Author: Tvrtko Ursulin &lt;<a href=3D"mailto:tvrtko.ursulin@igalia.com" tar=
get=3D"_blank">tvrtko.ursulin@igalia.com</a>&gt;<br>
<br>
drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array<br>
<br>
This commit replaces kvmalloc_array() + copy_from_user() with<br>
vmemdup_array_user() on the fast path. This aims to shrink the source code<=
br>
and improve separation between kernel and userspace slabs.<br>
<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt; index 15c45b2a39835..b364f3f5fb918 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c<br>
&gt; @@ -223,43 +223,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *l=
ist)<br>
&gt;=C2=A0 int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_=
in *in,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_am=
dgpu_bo_list_entry **info_param)<br>
&gt;=C2=A0 {<br>
[ ... ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* copy the handle array from userspace to a=
 kernel buffer */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0r =3D -EFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (likely(info_size =3D=3D in-&gt;bo_info_size))=
 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long bytes =
=3D in-&gt;bo_number *<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0in-&gt;bo_info_size;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_from_user(in=
fo, uptr, bytes))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto error_free;<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (likely(info_size =3D=3D bo_info_size)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D vmemdup_arra=
y_user(uptr, bo_number, info_size);<br>
<br>
[Severity: Low]<br>
Does this code call a function vmemdup_array_user() that does not exist in<=
br>
this kernel tree?<br>
<br>
When compiling drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c with<br>
CONFIG_DRM_AMDGPU=3Dy or m, this will result in a build failure due to an<b=
r>
implicit function declaration in amdgpu_bo_create_list_entry_array(). If th=
e<br>
compiler allows implicit declarations, it would assume a 32-bit int return<=
br>
type, which truncates the pointer on 64-bit systems and can lead to an<br>
invalid pointer dereference or use-after-free when IS_ERR(info) or<br>
kvfree(info) is called later.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(info))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return PTR_ERR(info);<br>
<br>
-- <br>
Sashiko AI review =C2=B7 <a href=3D"https://sashiko.dev/#/patchset/20260923=
145453.76114-1-roman.demidov.nn@gmail.com?part=3D1" rel=3D"noreferrer" targ=
et=3D"_blank">https://sashiko.dev/#/patchset/20260923145453.76114-1-roman.d=
emidov.nn@gmail.com?part=3D1</a><br>
</blockquote></div>

--000000000000a85014065c3540d8--
