Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3A1C5DF8B
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5147B10E52E;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVWNQU6F";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B17210E6FD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:53:31 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-6689f36ae56so5574746d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 02:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786960410; cv=none;
 d=google.com; s=arc-20260327;
 b=G79HM18fC5FIJVUYg50NE+/yH7VsZVsnXlHmznbq9xw8oM74F7AYiajryH4oXf9mq9
 +M8jQEzavLe0+AzG8wBoyDEdJ1bpy7+U8lycuzU4ObghuzRhVTdfOzhjNpMLoAnZXKuD
 eOueZn+2RorWThkUzvcSViaO3SuublUL9SS5haoH6G3yDunP/XV/znX+drhkw0BpQbyw
 ymEy37zgdK+f7Q50j9ljZr5Bk1GXnoBeZswFNS+xx1S8i+5nSUT01DAtaLNGiT6R/4sS
 Q3nyng49c25DqCh/WNaJUl5izuC/DCv19N/RfYkadmT0pQbtZrjiaM8Oj8/sHsocj6In
 +tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N/EEYdhpCQCijow2x9We7uzMffjFpSIB5dAL9mjSlVA=;
 fh=0QKqX5sJhFstXAIahZVcqp8OlGpFemZPLO84Mf9Ug7Y=;
 b=hUBXzJ2BgGSfszlBl2DTHkzdf02Q76fnhc/qsC9d7xcHDJmNvgHBaB4H4z94ouV1Oz
 C0XxTMAYLbqWMrvTND1U86vcjPLVsMyNsO2KcNLWK1rUwQ6EeWIshSTDCmdXZvRUQlM8
 kGOIURdF8vRmHcUIAhV/uDVSOosYTNOiSAdP52bN1kjvk97sLKSMQTtqoH8eUCPtCd+3
 yKNnTov1413aLW7C3I79k6wOG4ilSpXeoFGHd/kgQuVExq1VbH4Y7ZUmARd5Y6TNFhOg
 VLZEuA+d2/ivKd8q1WEwrCCPuzN3p1eRijpDEUxgTk8Xfn5+dxKKlzoOYODxQDwzuNc0
 Yq9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786960410; x=1787565210; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N/EEYdhpCQCijow2x9We7uzMffjFpSIB5dAL9mjSlVA=;
 b=QVWNQU6Fr7Pb/wo8RQKb7YOYkoORn/8TuA9FE3iOuyqeiSjEvFMiHvv1+hg6h027Tj
 MR3r5aa/eMuXzyn0tK1pRShOn1hgXYItb9Q+zfmDZN5+q71REIi4B5Xw6OF7X29FAmYF
 b+Ml7UtFhsPitrlwQSNcne0mDRWobKQgydpAspyFF5IMpNRt/bGSgF/tqHxzNy5mQJGp
 QLiVj9uSpg8c0+sIDC8GVqhAWIx04/ESrYT6IzCOsjKf/9MFd6Tife5PflPgpS2Nw2lq
 fBY3aDxlCxiD+q7d4iX3TxY3ZXHhwXAJx6qLisoTJqhKpPOxlzPhGwBma8A73t5u6HB+
 U/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786960410; x=1787565210;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N/EEYdhpCQCijow2x9We7uzMffjFpSIB5dAL9mjSlVA=;
 b=R5MLpdWAjkduPq8oRSs30IojA9qW+85LX/jbFAsQyIfcKhImDKe1C9iG8GMY7r87+9
 d7FjsEnR7syeGybeH1CoHMbXFjMpup0qQ3aTWItwuOlsVNg7IBEXMzoCehBv7uqLhNYZ
 FYG1g6PLGEbjD7yt6DX/dxofJAs7NjAFA9xHSAAYrHZBEDIyK3w7mg3qHZsVW5RvGAP4
 p4otGfYODOVnDp1Ng/JL9PD8Re7I77dU7XueAxpdoyE6ccClf3DJnfReCmXjJ7hNzS5O
 JuZFZimfSZ560b8PVgJXTcPGmeQsQeL9kcnnRMf9xtgap/n9jRO7hLsNQGACEcSJDXL4
 peGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNFAq2xtjRokcXfbkHCmPK7iKqaxfSy5pBqETBTzyMpJM5gW+5h+XfnN5QAAq45NmUAxKyKagRkMw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwauNYZRaU41vp9owbobG8jiMkmm2xsKSo0Vg6nKPfhT9yuCLhu
 XLhgnDYDsmrP++7xLJllCfRfuD/CsjxH4TE7e8DkRDD26GdJm1D5ev20ZJeEkqXgB94rmB29XCH
 3klmCjr+U8daJIe2ity30K3XtMA43zA==
X-Gm-Gg: AR+sD10fcZQbGMC7SFSFxoGIk5SRdjGpr45G9tD8mQ10qH0jloz2g4XqxavugPLL5y8
 OPAmoEcjhfDZDTncYS5J8I+YT0aDevs9Q1p7w3fGRqGeAIKShjWXXOWCqYtJG02lPqgWBvz8wKw
 B1vg3VKlDzZMX9hMvGUZlYPPntRRfHUygPPVhK9y4YV9EAV+WK0xH9eQ2NunzyKdPpaJXCY6IDT
 0bccbBe1NeFYhtgppJR/gWXi1tn7d+fVvs2EMyBfuKljmtBVQx1fhNjoft7ltrlmn9sUUx6ORVb
 1yngCN6oBqzc7ddF7H7ncUN6Ze/UMpfORUQl67LK9w7mtGITIH7DKllOzCB5
X-Received: by 2002:a53:d00a:0:b0:669:9498:301e with SMTP id
 956f58d0204a3-66c72d2b3b8mr9435352d50.27.1786960409907; Mon, 17 Aug 2026
 02:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260817055315.C9AA41F000E9@smtp.kernel.org>
 <20260817072045.876042-1-triet.hoang.dev@gmail.com>
 <20260817093009.22359-1-royalnet026@gmail.com>
In-Reply-To: <20260817093009.22359-1-royalnet026@gmail.com>
From: Triet Hoang <triet.hoang.dev@gmail.com>
Date: Mon, 17 Aug 2026 16:53:19 +0700
X-Gm-Features: AcwNN1UK23e05nGNFTcWCzbI4ARYSOGh2fHYtAIOJL-VOqEMAcNQ2jXFQmBGmEk
Message-ID: <CAJThnnWW9hVoajcdfybRRRk4KB6HAQUGzGQeBqnsqUWp5OCCzw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000075d5b006593b2491"
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

--00000000000075d5b006593b2491
Content-Type: text/plain; charset="UTF-8"

Hi Igor,

Thanks so much for clearly reviewing and explaining for me.

I'm still a beginner start contributing to kernel and this is very
meaningful to me.

I will keep go on what you suggested.

Best regards,
Triet

On Mon, 17 Aug 2026, 16:30 Igor Paunovic, <royalnet026@gmail.com> wrote:

> Hi Triet,
>
> Thanks for picking this up -- the rocket driver has few enough eyes on it
> that allocation-check patches are welcome.
>
> The rocket_job_push() half looks right to me. The early return skips the
> err: label, but bos is NULL there anyway, and the caller
> (rocket_ioctl_submit_job()) takes the goto out_cleanup_job path, which
> does drm_sched_job_cleanup() and rocket_job_put(). Nothing is leaked and
> nothing is armed yet, so returning early is safe.
>
> On rocket_job_open(), the v2 change fixes the error path, but I think it
> only covers half of what was reported. The other half is still there:
> the array leaks on a single-core device even when nothing fails.
>
> drm_sched_entity_init() stores the caller's array only when it will
> actually need it:
>
>         entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
>
> (drivers/gpu/drm/scheduler/sched_entity.c, unchanged in current
> mainline). And rocket_job_close() frees exactly that field:
>
>         kfree(entity->sched_list);
>         drm_sched_entity_destroy(entity);
>
> So when rdev->num_cores == 1, drm_sched_entity_init() succeeds,
> entity->sched_list is NULL, rocket_job_close() frees NULL, and the array
> that rocket_job_open() allocated is never freed. One pointer per open(),
> unbounded across open/close cycles.
>
> That is not a hypothetical configuration. The RK3576 series currently on
> the list enables exactly one core on the ROCK 4D -- its commit message
> says so in as many words ("Only rknn_core_0 is enabled: the driver binds
> one core per node and the second core is left to whoever can test it").
> Any RK3588 DT that leaves a single core enabled lands in the same place.
>
> I would suggest not depending on drm_sched_entity_init()'s internal
> choice about sched_list at all: keep the pointer in rocket_file_priv and
> free it unconditionally in rocket_job_close(). That covers one core and
> many cores with the same line, and it stops rocket_job_close() from
> reaching into a scheduler-internal field to decide what it owns. But
> that is a bigger change than the one you set out to make, so it may be
> better as a separate patch -- Tomeu's call.
>
> Two smaller things:
>
>   - With the check added, ret is assigned unconditionally from
>     drm_sched_entity_init(), so the "int ret = 0" initialiser in v2 is
>     no longer doing anything.
>
>   - Heads-up on collision: I have a patch in flight that touches these
>     same lines of rocket_job_open() ("accel/rocket: keep core slots
>     stable across unbind and rebind", part of a two-patch lifecycle
>     series). Whichever of us lands first, the other rebases -- I am happy
>     for that to be me. Worth mentioning because in my version the count
>     passed to drm_sched_entity_init() is the number of *live* cores, so
>     once cores are unbound down to one, the leak above starts happening
>     on a multi-core board too, at runtime.
>
> I have not run your patch, so no tag from me. If it would help, I can
> test it on RK3588 with three cores and again with two of them unbound,
> and check the single-core case with kmemleak.
>
> Regards,
> Igor
>

--00000000000075d5b006593b2491
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Igor,<div dir=3D"auto"><br></div><div dir=3D"auto">Tha=
nks so much for clearly reviewing and explaining for me.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">I&#39;m still a beginner start contributin=
g to kernel and this is very meaningful to me.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">I will keep go on what you suggested.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Best regards,</div><div dir=3D"auto">=
Triet</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, 17 Aug 2026, 16:30 Igor Paunovic, =
&lt;<a href=3D"mailto:royalnet026@gmail.com">royalnet026@gmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Triet,=
<br>
<br>
Thanks for picking this up -- the rocket driver has few enough eyes on it<b=
r>
that allocation-check patches are welcome.<br>
<br>
The rocket_job_push() half looks right to me. The early return skips the<br=
>
err: label, but bos is NULL there anyway, and the caller<br>
(rocket_ioctl_submit_job()) takes the goto out_cleanup_job path, which<br>
does drm_sched_job_cleanup() and rocket_job_put(). Nothing is leaked and<br=
>
nothing is armed yet, so returning early is safe.<br>
<br>
On rocket_job_open(), the v2 change fixes the error path, but I think it<br=
>
only covers half of what was reported. The other half is still there:<br>
the array leaks on a single-core device even when nothing fails.<br>
<br>
drm_sched_entity_init() stores the caller&#39;s array only when it will<br>
actually need it:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 entity-&gt;sched_list =3D num_sched_list &gt; 1=
 ? sched_list : NULL;<br>
<br>
(drivers/gpu/drm/scheduler/sched_entity.c, unchanged in current<br>
mainline). And rocket_job_close() frees exactly that field:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(entity-&gt;sched_list);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_sched_entity_destroy(entity);<br>
<br>
So when rdev-&gt;num_cores =3D=3D 1, drm_sched_entity_init() succeeds,<br>
entity-&gt;sched_list is NULL, rocket_job_close() frees NULL, and the array=
<br>
that rocket_job_open() allocated is never freed. One pointer per open(),<br=
>
unbounded across open/close cycles.<br>
<br>
That is not a hypothetical configuration. The RK3576 series currently on<br=
>
the list enables exactly one core on the ROCK 4D -- its commit message<br>
says so in as many words (&quot;Only rknn_core_0 is enabled: the driver bin=
ds<br>
one core per node and the second core is left to whoever can test it&quot;)=
.<br>
Any RK3588 DT that leaves a single core enabled lands in the same place.<br=
>
<br>
I would suggest not depending on drm_sched_entity_init()&#39;s internal<br>
choice about sched_list at all: keep the pointer in rocket_file_priv and<br=
>
free it unconditionally in rocket_job_close(). That covers one core and<br>
many cores with the same line, and it stops rocket_job_close() from<br>
reaching into a scheduler-internal field to decide what it owns. But<br>
that is a bigger change than the one you set out to make, so it may be<br>
better as a separate patch -- Tomeu&#39;s call.<br>
<br>
Two smaller things:<br>
<br>
=C2=A0 - With the check added, ret is assigned unconditionally from<br>
=C2=A0 =C2=A0 drm_sched_entity_init(), so the &quot;int ret =3D 0&quot; ini=
tialiser in v2 is<br>
=C2=A0 =C2=A0 no longer doing anything.<br>
<br>
=C2=A0 - Heads-up on collision: I have a patch in flight that touches these=
<br>
=C2=A0 =C2=A0 same lines of rocket_job_open() (&quot;accel/rocket: keep cor=
e slots<br>
=C2=A0 =C2=A0 stable across unbind and rebind&quot;, part of a two-patch li=
fecycle<br>
=C2=A0 =C2=A0 series). Whichever of us lands first, the other rebases -- I =
am happy<br>
=C2=A0 =C2=A0 for that to be me. Worth mentioning because in my version the=
 count<br>
=C2=A0 =C2=A0 passed to drm_sched_entity_init() is the number of *live* cor=
es, so<br>
=C2=A0 =C2=A0 once cores are unbound down to one, the leak above starts hap=
pening<br>
=C2=A0 =C2=A0 on a multi-core board too, at runtime.<br>
<br>
I have not run your patch, so no tag from me. If it would help, I can<br>
test it on RK3588 with three cores and again with two of them unbound,<br>
and check the single-core case with kmemleak.<br>
<br>
Regards,<br>
Igor<br>
</blockquote></div>

--00000000000075d5b006593b2491--
