Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8106CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77DD10ED55;
	Tue, 14 Jul 2026 13:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yx4ws7fg";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DF610ED55
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:38:20 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-7387ac7d28cso298823137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784036299; cv=none;
 d=google.com; s=arc-20260327;
 b=Ew+qBfTLIAFIqZzjE74waBKqMj2SiDVHRGGFByAKqjybMinVdAY9QkpWeAZj1F2P1H
 VCg01wBVYhhKx/CHe2lWsUFA0o+164jhm04s/I6n+vWKztPiB8nI0QjO8y+GxwkUGmTs
 5v+JSCMq2aIqiIF/op1wQcy3zesw2yTTDgvYXYKQ6whQ3ZFUj04rmw+TFpEsZQ88H4/l
 Iu2AH9x9hBuvjq2pd7YSSPka5gJB1tbtCvMqd2h+TPtgD1TQoidVQzQDLmuzvDK1dfzS
 1vu7WWL+XvCni3EiLEEqDbYoc6RcFDYbFobPVv/utGFi54y9d/hZcj2tcjUOYRlRVLFS
 zoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+yVoZZisszpSLmfLdAUvwAS484Eh2rr1NVxc27+kKiA=;
 fh=wkjPa/oW6tC6aA7+6wiJQaK0iLxg0cpH3NEtGWBYXZg=;
 b=F83cdg+WAJ6yl/qt8MH084vkAefRHYyei3HmOoPEIEIEUYLpBoKSUaDCptrCy8os4S
 rCTdwNpflr6VhOyqP9t5oa9dHePpsza8fN4KkycZ2Lb4ol2jSfL0KEzgKSTpOqkGQVZR
 OmwWaYi6y/3qTbgWwVBwOfmhSEv6m31QpE6IvhB5M2HKqINdUEQVVe5j1qiDejnTd8Df
 i3EjQr3upDE6U8eAqJR6hMwWhZeUGO4C8NjHX8hORASLt2j04nsJgmCMslqBYfdtTRIC
 4O5FqbVL6hNtoni7gYKRJQgYoKVmN8Al/NNF+0ki2xvQzuQJaBiiKnpUjzlHMVKF/dwa
 xPzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784036299; x=1784641099; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+yVoZZisszpSLmfLdAUvwAS484Eh2rr1NVxc27+kKiA=;
 b=Yx4ws7fgvdU5lmNqsVFvX1luK1f9jUQxJ2xsjAfyMmo40TJlWqAami0cV1JqTlGOo/
 NRlKxXTlwddfwaxR6rw2V5VJh6eDMwuj8vvA8qIFJW3vVUXiojlPpE3zoRarykipUBDc
 5an6gjWuUPQd8THXF4wDErOYMcbzhknlklMkYgGZQiJsaMUOfnEDWDbXsD6SIEKZAQeo
 +JgqwchUiPbRNjlMe5y/7BedmzRxsPV122fRb0ImVtPDjsOPg2mudLNLS13D02j/HYU/
 DmK8mCmtB/xC71El/HAo+2osOgYoN82v88oE1L09VP4xYxxXfJvmW7KtlW7UmIRNDrm6
 Vgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784036299; x=1784641099;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+yVoZZisszpSLmfLdAUvwAS484Eh2rr1NVxc27+kKiA=;
 b=mbKRnYSYg3kY9uGfNp/eMupvQrWsOFX87gtLO2VX7iFDZKqL+GlSw+nNxd9d3u9IrK
 KDmJLHOaTjz6Wg5wqA5Lu1guuivvklZD8FsYEMZYVwyqzEtCUGNQVOevrGa//0shIOTD
 zARDtpl1z60JGVIStOPD30TBNtpoL7JpdIx9NiqV7qGJfpI+N3QaqUfI+VD4CHIWYHVj
 3ggyAXzo8E6KoLpSEjPwyuE0lmuXyD3Cu3meY/e1/PuCkHxFQxBJENx/+gJFWZrXmyun
 4voWCZTAYnC7vH1GiyhTlvszZ9L3FDDIfLYVWekjU5gFJ9Cbv5WqU9ymuTg5ATVLvE4a
 2QRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVmDizRP++xZoFfuR28rI297ZXCXGSozp8eBIGtX+dpFktLCCan+t2tcCBhBFs5jOkYdmYtcVvcFU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGVB3K+WQmpOWtnlOjD7HZ3RFpGF9iTtDdsbkwB7O0SN0xUSkg
 TdZSg7PMDBuv/F3DlsOlOV6IGzaunj5wFgPjTKLGBc5HJO2y2bpIeZs5zDH3bUIgOP6CBIEkHm2
 4Jutt2aDpK4CRZ412DUSkszlakuEkHrI=
X-Gm-Gg: AfdE7ckToAF6o4VdGJTXtQLa/SWPGH5s5mHyFBA5w27KlKSsrHm9W3NT/+87COMmiKR
 401wMHsEQa8Pp9RuQACcOdaRkPOVw418fvZuNh1W+Xdf6URIyjmJ99iO7IRI81me69ytUtB3tce
 Kx+2mJUcCBV+cJLRoJD/XBJAuId0LMmzlyZKnf3+IFk1mqvApR2LePQgZ4dBJD7Ahbr7kHuiIOB
 ILTLUp+i6x1JEkrx9Aj8fV/mva53lGNn9QawSnN/GTGwuasUuB4QMlBw0pEBn8HD6BVo7yt
X-Received: by 2002:a05:6102:162b:b0:728:4383:c831 with SMTP id
 ada2fe7eead31-74533c0db8amr7920334137.10.1784036299352; Tue, 14 Jul 2026
 06:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
 <20260714114654.3885457-2-shoubaineng@gmail.com>
 <20260714141359.7758575d@pumpkin>
In-Reply-To: <20260714141359.7758575d@pumpkin>
From: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Date: Tue, 14 Jul 2026 21:38:07 +0800
X-Gm-Features: AUfX_mx1gzgtwPtEVIakIcvDj32vKgHlWBxFDDJMPc3hmyJ9ZkcCZUxyrzActqo
Message-ID: <CAGCp47zPkd6MWcMpxobphJp6giufpnJL46iFQMt9p76gb7OtKA@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000e3af9c06569251b4"
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

--000000000000e3af9c06569251b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the feedback.

The concern is not just about the EFAULT return =E2=80=94 it's about the ra=
ce
window between fd_install() and copy_to_user().  Once fd_install()
returns, the fd is immediately observable by other threads in the same
process (via /proc/self/fd, SCM_RIGHTS, etc.), even before
copy_to_user() has a chance to fail.  The triggering condition is a
deliberate mprotect() flip, not a corrupted heap.

The fix itself is small and follows the standard kernel idiom:
get_unused_fd_flags() reserves the fd without publishing it, so the
window between reservation and install is entirely under kernel control.

Baineng

David Laight <david.laight.linux@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A

> On Tue, 14 Jul 2026 19:46:53 +0800
> Baineng Shou <shoubaineng@gmail.com> wrote:
>
> > DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
> > caller's fd table via dma_buf_fd() -> fd_install() before
> > dma_heap_ioctl() copies the result back to userspace.  If the trailing
> > copy_to_user() fails, userspace never learns the fd number, but the
> > fd (and the underlying dma-buf reference) are already visible to
> > other threads in the same process and are leaked for the lifetime of
> > the process.
> >
> > The obvious "close it on the failure path" fix is unsafe: once
> > fd_install() has run, another thread can already dup() the fd, send
> > it via SCM_RIGHTS, or close() it and let its number be reused, so a
> > subsequent close_fd() from the ioctl path can operate on an unrelated
> > file.  This was pointed out by Christian K=C3=B6nig on v1 [1].
> ...
>
> My 2c:
>
> The other option is just to leave it as a 'problem for user space'.
> No reasonable program is going to handle the EFAULT return by doing
> anything other than exiting.
> Even getting an EFAULT is really an indication that the application
> is already in a real mess - most likely with a badly corrupted heap.
>
> Anything else leaves error recovery code in the kernel that is pretty
> much never executed and open to a variety of bugs.
> While the recovery here is probably ok, there are some sockopt calls
> where it is all more complicated.
>
>         David
>

--000000000000e3af9c06569251b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<br><br>Thanks for the feedback.<br><br>The conce=
rn is not just about the EFAULT return =E2=80=94 it&#39;s about the race<br=
>window between fd_install() and copy_to_user().=C2=A0 Once fd_install()<br=
>returns, the fd is immediately observable by other threads in the same<br>=
process (via /proc/self/fd, SCM_RIGHTS, etc.), even before<br>copy_to_user(=
) has a chance to fail.=C2=A0 The triggering condition is a<br>deliberate m=
protect() flip, not a corrupted heap.<br><br>The fix itself is small and fo=
llows the standard kernel idiom:<br>get_unused_fd_flags() reserves the fd w=
ithout publishing it, so the<br>window between reservation and install is e=
ntirely under kernel control.<br><br>Baineng</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">David Lai=
ght &lt;<a href=3D"mailto:david.laight.linux@gmail.com">david.laight.linux@=
gmail.com</a>&gt; =E4=BA=8E2026=E5=B9=B47=E6=9C=8814=E6=97=A5=E5=91=A8=E4=
=BA=8C 21:14=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Tue, 14 Jul 2026 19:46:53 +0800<br>
Baineng Shou &lt;<a href=3D"mailto:shoubaineng@gmail.com" target=3D"_blank"=
>shoubaineng@gmail.com</a>&gt; wrote:<br>
<br>
&gt; DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the<b=
r>
&gt; caller&#39;s fd table via dma_buf_fd() -&gt; fd_install() before<br>
&gt; dma_heap_ioctl() copies the result back to userspace.=C2=A0 If the tra=
iling<br>
&gt; copy_to_user() fails, userspace never learns the fd number, but the<br=
>
&gt; fd (and the underlying dma-buf reference) are already visible to<br>
&gt; other threads in the same process and are leaked for the lifetime of<b=
r>
&gt; the process.<br>
&gt; <br>
&gt; The obvious &quot;close it on the failure path&quot; fix is unsafe: on=
ce<br>
&gt; fd_install() has run, another thread can already dup() the fd, send<br=
>
&gt; it via SCM_RIGHTS, or close() it and let its number be reused, so a<br=
>
&gt; subsequent close_fd() from the ioctl path can operate on an unrelated<=
br>
&gt; file.=C2=A0 This was pointed out by Christian K=C3=B6nig on v1 [1].<br=
>
...<br>
<br>
My 2c:<br>
<br>
The other option is just to leave it as a &#39;problem for user space&#39;.=
<br>
No reasonable program is going to handle the EFAULT return by doing<br>
anything other than exiting.<br>
Even getting an EFAULT is really an indication that the application<br>
is already in a real mess - most likely with a badly corrupted heap.<br>
<br>
Anything else leaves error recovery code in the kernel that is pretty<br>
much never executed and open to a variety of bugs.<br>
While the recovery here is probably ok, there are some sockopt calls<br>
where it is all more complicated.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 David<br>
</blockquote></div>

--000000000000e3af9c06569251b4--
