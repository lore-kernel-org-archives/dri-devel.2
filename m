Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDFFC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 02:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1B910EE85;
	Wed, 15 Jul 2026 02:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmZKxqzA";
	dkim-atps=neutral
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CED10EE84
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 02:04:51 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-74597302e21so143357137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784081090; cv=none;
 d=google.com; s=arc-20260327;
 b=WaJNh8osmTNAVXuMshr7QQlWeLIN44QgTJWq7YQwpr91ij0lVlXKSXHCGdH8NTmXtJ
 NSng2bv0UTvWSE3FE7lbnI6SDHJSmEtSx9Gd9ZKFFObbUm+5aiUes956WIfGNoVvBPSl
 sunk1FZXYcznXUH4/YG6xuCNtMvZEsoZFBAweQuF+zJ3+FH0zi4RuG17Yzb1/6vuw8Lh
 frS1GCC15XYckAOkXqJHEzxdryrjEWHwA0IGPWkFYMon4zyShKlXLeQOhA/DYV17FMXA
 gYQB42DEJdPbxJvpbIh8aKmOid0laaP2j7si6LKdX3AYZCVpMTkJGz40R0qTUfRgz0Pz
 FFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rLEIKhpuef/ug54pd7MBDY/WtzBaRgNJWaxjolHYxgc=;
 fh=CJGGU1V4D/VI6ISh7Sm26EZ4bEOlMrtOD+mF8fgSj54=;
 b=YMS+PDF3Ux/bDbEZGSLQByZSdlj/YHAxlXLHfzl4zxEnAJqOXJ3UBTkCKvjxkkvCrf
 tSIPBkNGlujjccwF9IGUY8wtstDiOdB+8Yi1g8O2aE+UluNlc6sbgdkS30EX1lV21bCK
 HT+QfLQJnVlLrG2NfoCdi0cfCytLCSQvvlhJ+fPHqd/mqgwD3eRy4/80pMRaUNFElAol
 yxMVWK+1ZntjdViRDbWZQnGUBLtQCEJ0Qf8PTgJwWIYfPgKQ16buPCGZv1DLsZcIOkTF
 /MTOelaXGHu1qVObnM+gC8mrt33GpQS3i+MJt6F5ab/Hba2LdU8RkHE39QXbayEK6AWw
 uHfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784081090; x=1784685890; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rLEIKhpuef/ug54pd7MBDY/WtzBaRgNJWaxjolHYxgc=;
 b=BmZKxqzA0MedDR1mwrK7sUuw3ERrRxobBpkNyN18wW5TQ39UDYj16GgEaA1IoWsXtR
 g9bG5WRB8BvaFm/yRUEfh6VIob0zeG2kPsDbJHDmw0CTCiOVuf+VUp/jTfwXd7cWZkEx
 iB0AaLeijI0cpPb2Qagll69i/zIChvFKUAg7cpudzyqZjnTDgZPx3qyfIftAb8R/GhOm
 Uf/QA3Bp3L699z6iG3NNafCHGTEtaq0ubOK4E7DDW/dCQxcAFOLAzCEsROs/UDYmK1Pj
 LwjbVpC45N7TDJ8+B22DR0QeGeGoUIxC5sncUylx4JcLAXSE1yBNpc9lp3LkfX/5ZKvd
 /ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784081090; x=1784685890;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rLEIKhpuef/ug54pd7MBDY/WtzBaRgNJWaxjolHYxgc=;
 b=KeQc5wBhL4x41vkMXEd2XQE9FrVdq80is4x/KTowKA5H8Cb/FbnUwVXSfBzrnSaKVV
 EcOZzZHFL/uBRidA5E/kkcfnKdjnPg1IJflUfpfpOliIaJ8+53kAuPmsYH2YayMkjf9Y
 +jBlGH7NKBuLLx9dzTeFgD73BJsul4lAiTMB1mOAVKclDLr5ehnIHyQdBCltPY+7pYKx
 xOT4pipcb8Ckx2gE8zmlLUncruVT4OwcS95CGpd/ULrQ8+odFYD2WnmFT13BJ3q7CkEk
 mqkONEEjY/krPfuyK0WD0B7kn9AzDFMXaIU+fPUOsVV0oFjcwJ6VdEtwV9E6wDchksJ0
 WsNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwwCO8rqjcWOEkCo+7UqZ+dcvBSLgAOHL3EMwugw8YkchcC994itZ5E+3MQRnDvSUAlCWGSY62JNc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypxhwUZjRxXKTmI5aXGu6uA/O0UgckGfuaJ/0YgpSu6E9ddVv/
 YiJikTgLGJIzhZa+mkUGNQMsXlIA8YTCCixZ92xvQqd17EUvYiGhkouycS8XRN5r9vGvs5gZxuz
 Llg3FGa/e4iww4P2DrREYIoJ5JA9oock=
X-Gm-Gg: AfdE7cnW6gaO9B8e7nWTF4TXjDXHLkLxOBzLaOxfJv+vYUTukBnE5NxMrJCQW2Fj7GY
 F2Ce9bbx6104uQNUVJGReVUx24FssheNuqLXImcuoHtGJhAAhsqcMC7rJCZxG25nsCzwvyXBKTC
 KJwL5vlD40rvFCtUaKAmb2GlH2q9nhkI7z0FdOQJRajNBPCACvksKGK8Xn9atZaMyUfTNpQH3qP
 nakzKjp7qqeF5prhXUpeTASlZTCQnDdZWae2p8tDeGbiedlev2P5Ssc1oxrL7cHxNXbzn0N
X-Received: by 2002:a05:6102:6304:10b0:736:e29f:168d with SMTP id
 ada2fe7eead31-7450caa107amr8868372137.16.1784081089868; Tue, 14 Jul 2026
 19:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
 <20260714114654.3885457-2-shoubaineng@gmail.com>
 <20260714141359.7758575d@pumpkin>
 <CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
 <20260714153319.07b2b1e1@pumpkin>
In-Reply-To: <20260714153319.07b2b1e1@pumpkin>
From: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Date: Wed, 15 Jul 2026 10:04:38 +0800
X-Gm-Features: AUfX_mwfNxpJG_fVC7UlhQprBnyA-zPjc7BWgAEELjI2vNsVGklcYzWirBtOafs
Message-ID: <CAGCp47wsjwstEebFcKSv+Hox0LJo=oYgt5n-2xfKWgq4WLZK1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: David Laight <david.laight.linux@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000009cb5ec06569cbff0"
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

--0000000000009cb5ec06569cbff0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David

The rollback here is the simplest possible case (put_unused_fd +
dma_buf_put), not the complex sockopt scenario you describe.

Baineng

David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=8C 22:33=E5=86=99=E9=81=93=EF=BC=9A

> On Tue, 14 Jul 2026 21:38:07 +0800
> =E5=AF=BF=E6=9F=8F=E8=83=BD <shoubaineng@gmail.com> wrote:
>
> > Hi David,
> >
> > Thanks for the feedback.
> >
> > The concern is not just about the EFAULT return =E2=80=94 it's about th=
e race
> > window between fd_install() and copy_to_user().  Once fd_install()
> > returns, the fd is immediately observable by other threads in the same
> > process (via /proc/self/fd, SCM_RIGHTS, etc.), even before
> > copy_to_user() has a chance to fail.  The triggering condition is a
> > deliberate mprotect() flip, not a corrupted heap.
>
> That is what makes doing the close wrong.
> But that is a program aggressively trying to hit the timing window,
> not a normal program that has managed to pass an invalid pointer.
> The most likely reason for a real program passing an invalid pointer
> is a corrupted heap (assuming the stupid coding errors are fixed).
>
> It is really no different from the sockopt code that receives
> SCM_RIGHTS messages.
> In that case once you've removed the FILE from the socket (or similar)
> you really don't want to have to put it back because the write to the
> sockopt buffer or length field fails.
> The chance of correctly reverting the kernel state is small - and won't
> be tested.
>
>         David
>
> >
> > The fix itself is small and follows the standard kernel idiom:
> > get_unused_fd_flags() reserves the fd without publishing it, so the
> > window between reservation and install is entirely under kernel control=
.
> >
> > Baineng
> >
> > David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > On Tue, 14 Jul 2026 19:46:53 +0800
> > > Baineng Shou <shoubaineng@gmail.com> wrote:
> > >
> > > > DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into th=
e
> > > > caller's fd table via dma_buf_fd() -> fd_install() before
> > > > dma_heap_ioctl() copies the result back to userspace.  If the
> trailing
> > > > copy_to_user() fails, userspace never learns the fd number, but the
> > > > fd (and the underlying dma-buf reference) are already visible to
> > > > other threads in the same process and are leaked for the lifetime o=
f
> > > > the process.
> > > >
> > > > The obvious "close it on the failure path" fix is unsafe: once
> > > > fd_install() has run, another thread can already dup() the fd, send
> > > > it via SCM_RIGHTS, or close() it and let its number be reused, so a
> > > > subsequent close_fd() from the ioctl path can operate on an unrelat=
ed
> > > > file.  This was pointed out by Christian K=C3=B6nig on v1 [1].
> > > ...
> > >
> > > My 2c:
> > >
> > > The other option is just to leave it as a 'problem for user space'.
> > > No reasonable program is going to handle the EFAULT return by doing
> > > anything other than exiting.
> > > Even getting an EFAULT is really an indication that the application
> > > is already in a real mess - most likely with a badly corrupted heap.
> > >
> > > Anything else leaves error recovery code in the kernel that is pretty
> > > much never executed and open to a variety of bugs.
> > > While the recovery here is probably ok, there are some sockopt calls
> > > where it is all more complicated.
> > >
> > >         David
> > >
>
>

--0000000000009cb5ec06569cbff0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0David</div><div dir=3D"ltr"><br>T=
he rollback here is the simplest possible case (put_unused_fd +<br>dma_buf_=
put), not the complex sockopt scenario you describe.</div><div><br></div>Ba=
ineng<div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">David Laight &lt;<a href=3D"mailto:david.laight.linux@gmail.com" target=
=3D"_blank">david.laight.linux@gmail.com</a>&gt; =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 22:33=E5=86=99=E9=81=93=EF=BC=9A<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 14 Jul 2026 21=
:38:07 +0800<br>
=E5=AF=BF=E6=9F=8F=E8=83=BD &lt;<a href=3D"mailto:shoubaineng@gmail.com" ta=
rget=3D"_blank">shoubaineng@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hi David,<br>
&gt; <br>
&gt; Thanks for the feedback.<br>
&gt; <br>
&gt; The concern is not just about the EFAULT return =E2=80=94 it&#39;s abo=
ut the race<br>
&gt; window between fd_install() and copy_to_user().=C2=A0 Once fd_install(=
)<br>
&gt; returns, the fd is immediately observable by other threads in the same=
<br>
&gt; process (via /proc/self/fd, SCM_RIGHTS, etc.), even before<br>
&gt; copy_to_user() has a chance to fail.=C2=A0 The triggering condition is=
 a<br>
&gt; deliberate mprotect() flip, not a corrupted heap.<br>
<br>
That is what makes doing the close wrong.<br>
But that is a program aggressively trying to hit the timing window,<br>
not a normal program that has managed to pass an invalid pointer.<br>
The most likely reason for a real program passing an invalid pointer<br>
is a corrupted heap (assuming the stupid coding errors are fixed).<br>
<br>
It is really no different from the sockopt code that receives<br>
SCM_RIGHTS messages.<br>
In that case once you&#39;ve removed the FILE from the socket (or similar)<=
br>
you really don&#39;t want to have to put it back because the write to the<b=
r>
sockopt buffer or length field fails.<br>
The chance of correctly reverting the kernel state is small - and won&#39;t=
<br>
be tested.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 David<br>
<br>
&gt; <br>
&gt; The fix itself is small and follows the standard kernel idiom:<br>
&gt; get_unused_fd_flags() reserves the fd without publishing it, so the<br=
>
&gt; window between reservation and install is entirely under kernel contro=
l.<br>
&gt; <br>
&gt; Baineng<br>
&gt; <br>
&gt; David Laight &lt;<a href=3D"mailto:david.laight.linux@gmail.com" targe=
t=3D"_blank">david.laight.linux@gmail.com</a>&gt; =E4=BA=8E2026=E5=B9=B47=
=E6=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt; <br>
&gt; &gt; On Tue, 14 Jul 2026 19:46:53 +0800<br>
&gt; &gt; Baineng Shou &lt;<a href=3D"mailto:shoubaineng@gmail.com" target=
=3D"_blank">shoubaineng@gmail.com</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd =
into the<br>
&gt; &gt; &gt; caller&#39;s fd table via dma_buf_fd() -&gt; fd_install() be=
fore<br>
&gt; &gt; &gt; dma_heap_ioctl() copies the result back to userspace.=C2=A0 =
If the trailing<br>
&gt; &gt; &gt; copy_to_user() fails, userspace never learns the fd number, =
but the<br>
&gt; &gt; &gt; fd (and the underlying dma-buf reference) are already visibl=
e to<br>
&gt; &gt; &gt; other threads in the same process and are leaked for the lif=
etime of<br>
&gt; &gt; &gt; the process.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The obvious &quot;close it on the failure path&quot; fix is =
unsafe: once<br>
&gt; &gt; &gt; fd_install() has run, another thread can already dup() the f=
d, send<br>
&gt; &gt; &gt; it via SCM_RIGHTS, or close() it and let its number be reuse=
d, so a<br>
&gt; &gt; &gt; subsequent close_fd() from the ioctl path can operate on an =
unrelated<br>
&gt; &gt; &gt; file.=C2=A0 This was pointed out by Christian K=C3=B6nig on =
v1 [1].=C2=A0 <br>
&gt; &gt; ...<br>
&gt; &gt;<br>
&gt; &gt; My 2c:<br>
&gt; &gt;<br>
&gt; &gt; The other option is just to leave it as a &#39;problem for user s=
pace&#39;.<br>
&gt; &gt; No reasonable program is going to handle the EFAULT return by doi=
ng<br>
&gt; &gt; anything other than exiting.<br>
&gt; &gt; Even getting an EFAULT is really an indication that the applicati=
on<br>
&gt; &gt; is already in a real mess - most likely with a badly corrupted he=
ap.<br>
&gt; &gt;<br>
&gt; &gt; Anything else leaves error recovery code in the kernel that is pr=
etty<br>
&gt; &gt; much never executed and open to a variety of bugs.<br>
&gt; &gt; While the recovery here is probably ok, there are some sockopt ca=
lls<br>
&gt; &gt; where it is all more complicated.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0David<br>
&gt; &gt;=C2=A0 <br>
<br>
</blockquote></div>
</div></div>

--0000000000009cb5ec06569cbff0--
