Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E056BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 04:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E44210E27B;
	Sat, 11 Jul 2026 04:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NolADXat";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7E310E27B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 04:18:57 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-9667ea2fc22so254540241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783743536; cv=none;
 d=google.com; s=arc-20260327;
 b=N9hD1ESmNQ3dbRIG9HQZOG1hXZo8RJ3ablsBxlK69hiDvk/S0tkZepeb2LDvEkSCRS
 ehSWjmTiYpZOM/UH8p00pdnBcp/grPtxvU7+YZfflrQ0SRXsP2MwEghZ36cPUaRurMQF
 UrXpa4TrzVIXpnptEXYytGt1zYVZHldCkV7MhBv6qSitgj3HjN5ruTJ+JVNcdYhvH7m+
 EgT1KtLvO9biZkPM3A2K80qo3mI7+GjjSnxg7aE1o1Y5xkZvcCW2ZvWGPKMxe7zt8T4O
 2rq8YuoB+Qg6YGmG8jQRp70yN2XiTjCM5yx+9YD2qij2K2yOmPPC/yhESsfdgsM61onH
 pP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3Zacn2CaK0792+M2PwLSCr3vBJN5a7DeqDpxwL9Vx9Y=;
 fh=cx5dFqeXVwnQAZ2sy7N01s0fH3u46CXTCtOYQ8TbGi0=;
 b=pzUSGJOdPVjvbNywflN+ng7EhxD6Bc/Gk4KUtA5Tsc4mFECrrXrmBVG+mbxV9FwFPb
 ryM5ajUafQBeb+/JHIgAs1rFLetBEQQhR9RBRP26nUNSaQtL2HthcZSXgRUf5IuMzCrc
 FdgHcxKgzRiJ/8AHQHFpn5nf77s5wFrHtL/cYaUM41j31MUd4xXVzA2E9+I2ID5TdC28
 txtTND0r8RsUl+RecRLLoAjrdFTp8JgW01lKP6HNYBmWBqixeUwAgcOvBWS58/iYaRqu
 H4zamqco7PDX9WhOSwxBu+rojn6sJgXN3ujj/Nbgcpi0G9rxguS1k2bHoWGz0IKXay34
 9bYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783743536; x=1784348336; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3Zacn2CaK0792+M2PwLSCr3vBJN5a7DeqDpxwL9Vx9Y=;
 b=NolADXatDysQRAiDY7P4bpmhlsgj8wzmC8n8FCVGMdWNCovErSTdefO2uGmWRGP9tm
 UghUJ/4rYi2Wd4ulJ71/ksyQlgnKTHXKAOH6zQdJG/9KslVKlyyhvLcodIBaLG9XWWml
 wjOHaTlRt2otUPaRX7zBUPPukPVKoE93ZVdAc/t7393PiiYzheEwlLONIUZ1QAK06Mft
 ajQUgVAzcoD/d877TlQLvutOBE8iGKdA8ulWqZ1fudykLAVCMbIpMgruAhyqe7gFPWBv
 vMxmRAMEyfxhMoMS+6ZaCKPttTQX0JCRkPLZVymZWMT1d4qoiq14z69w15q4Xqx9MNDp
 9nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783743536; x=1784348336;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3Zacn2CaK0792+M2PwLSCr3vBJN5a7DeqDpxwL9Vx9Y=;
 b=f2c88vTP2J7oZO4PO2Ixh7ArRQj0DOu0fEcnOWdyAKpMF77rhomtVykzj1tKGpsvk8
 JQs0pVvhB9wivWmSdSbfGZW3AGSz3IEHxH6nTjW4wFZz2tjpSjfJ1aHY21Pnq/CTXT29
 yKDAhthWCDRKkh84SUSo82gTGO+pep4hKH/BSuv/o0PO+7nJulEUV2cs6yxS16zqry44
 pvg0n1YzJM5VlLa6xnCqSoXXlHnme6DNIm62Z+DLm1dFytQk2e3h8jg921D+VAQWJFev
 4h4C6KTUDggs0sCZDrFIqxyG11aMhYJ9EWAZ2SC2YyKtCuwNm7wWEOqVUs6+izuYYS2p
 816A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe3MCsbRzZw85Urj1dG9Z1xnmA2p9yPdjez78o+b6q2azRo/7gTjRjJJVr5whLEpctAYJI6aZrCA0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8Yd6c6ySSStU3e6RXaTVp1nyOFSD1QOM1f8QIkyknOV1zRBns
 ibfTBNINthNLozs2QJZyTxraQSaaqxGHXb+eCosIy9E1IYKHyahbpjKcgicISpqMO3wQKNjejcN
 1K+yT/eDMl2So27GQWslJ+zVIU2BEiJ4=
X-Gm-Gg: AfdE7cnf05LnDBooDqNjhE7qPBNxutIs0/FRC0P7zadgjnYgzAlA+Hryc9R5dse/jjp
 Jf5BttU9yfHOnWCtzuepyZ8raYsxkJME9ecZL8j3Tro0Lm4JSw3uJ8neYDkBrnCJ70dOM4fcMoN
 KaPDaX9ym6Mg+eSj108bEN0IlrK80tghNHeYuGoVhlnUD3riZ483gfBlAhYcj7AIh4FgHnZZDrr
 6MCWuXZEGw3VgIKqADij46YuO4FfAqmoI4Q5B3VDcPGw0HSQ0mtISTouZRaJfvoenFjA+Cw
X-Received: by 2002:a05:6102:548b:b0:73a:322d:1bb4 with SMTP id
 ada2fe7eead31-74533dffae6mr1204342137.22.1783743536168; Fri, 10 Jul 2026
 21:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
 <20260710105740.3080070-1-shoubaineng@gmail.com>
 <20260710110645.079DC1F000E9@smtp.kernel.org>
 <CABdmKX2xt6diYwCs32E7HNL8ULepDfrDQ20iB+HVw5o-pCd0xg@mail.gmail.com>
In-Reply-To: <CABdmKX2xt6diYwCs32E7HNL8ULepDfrDQ20iB+HVw5o-pCd0xg@mail.gmail.com>
From: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Date: Sat, 11 Jul 2026 12:18:45 +0800
X-Gm-Features: AUfX_mySkzT4jEr3xLNHXeM3ZrS4a6BX2cMda2zZlVK-8vuZV6MSoVh-7UNkg6M
Message-ID: <CAGCp47yZ4fWbuAg7HPPS0bknaTk88dPOVfCzc8J+H7-u4wM7bQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gaoxiang17@xiaomi.com, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
 "Andrew F . Davis" <afd@ti.com>
Content-Type: multipart/alternative; boundary="000000000000d801a106564e2793"
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

--000000000000d801a106564e2793
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi T.J.,

Thanks for the review.

You are right, the export tracing was inadvertently lost when splitting
dma_buf_fd() apart. I've fixed it in v3 by introducing a new
dma_buf_fd_install() helper in dma-buf.c that wraps the DMA_BUF_TRACE
call together with fd_install(), and using that in dma-heap.c instead
of a bare fd_install(). The trace event fires after copy_to_user()
succeeds, just before the fd becomes visible to userspace =E2=80=94 the sam=
e
observable moment as before.


Baineng

T.J. Mercier <tjmercier@google.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=85=AD 04:20=E5=86=99=E9=81=93=EF=BC=9A

> On Fri, Jul 10, 2026 at 4:06=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> > - [Medium] Bypassing the standard dma_buf_fd() API skips the emission o=
f
> the trace_dma_buf_fd tracepoint.
> > --
> >
> > --- Patch [1]: [PATCH v2] dma-buf: dma-heap: don't publish fd before
> copy_to_user() succeeds ---
> > commit 869904722955c74d0c6e8c974d3c64c6befabac6
> > Author: Baineng Shou <shoubaineng@gmail.com>
> >
> > dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
> >
> > This commit restructures DMA_HEAP_IOCTL_ALLOC to delay publishing the
> > file descriptor until after copy_to_user() succeeds. It open-codes the
> > fd allocation and installation steps instead of using dma_buf_fd() to
> > prevent an fd leak on copy_to_user() failure.
> >
> > Link:
> https://lore.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a8f7f62@am=
d.com/
> >
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > > index 3937dd41bb0f6..983dee947c851 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > [ ... ]
> > > @@ -175,15 +162,28 @@ static long dma_heap_ioctl(struct file *file,
> unsigned int ucmd,
> > >
> > >       switch (kcmd) {
> > >       case DMA_HEAP_IOCTL_ALLOC:
> > > -             ret =3D dma_heap_ioctl_allocate(file, kdata);
> > > +             dmabuf =3D dma_heap_ioctl_allocate(file, kdata);
> > > +
> > > +             if (IS_ERR(dmabuf)) {
> > > +                     ret =3D PTR_ERR(dmabuf);
> > > +                     break;
> > > +             }
> > > +
> > > +             fd =3D ((struct dma_heap_allocation_data *)kdata)->fd;
> > > +             if (copy_to_user((void __user *)arg, kdata, out_size) !=
=3D
> 0) {
> > > +                     put_unused_fd(fd);
> > > +                     dma_buf_put(dmabuf);
> > > +                     ret =3D -EFAULT;
> > > +             } else {
> > > +                     fd_install(fd, dmabuf->file);
> >
> > [Severity: Medium]
> > By open-coding the fd reservation and installation here instead of usin=
g
> > dma_buf_fd(), does this skip the emission of the trace_dma_buf_fd
> tracepoint?
> >
> > If so, observability tools, BPF scripts, and perf tracing relying on
> > trace_dma_buf_fd to map dmabufs to file descriptors will silently miss
> all
> > allocations originating from the dma-heap subsystem.
>
> Hi Xiang Gao,
>
> It looks like this change in its current form breaks the export
> tracing that you introduced. It looks fixable by adding a call to
> DMA_BUF_TRACE in after copy_to_user in dma_heap_ioctl. However I'm
> wondering if you're aware of the dmabuf iterator that traverses the
> dmabuf_list? I've backported it to 5.10, so it's available on all our
> kernels: https://r.android.com/q/Iaeda328f7693acc1506269c12cac5e7955e5c09=
1
> Someone else from Xiaomi even helped with the 6.12 backport. So I
> guess I'm wondering if the dmabuf iterator would work for you instead
> of the tracepoints.
>
> Thanks,
> T.J.
>
> > > +             }
> > > +
> > >               break;
> > >       default:
> > >               ret =3D -ENOTTY;
> > >               goto err;
> > >       }
> >
> > --
> > Sashiko AI review =C2=B7
> https://sashiko.dev/#/patchset/20260710105740.3080070-1-shoubaineng@gmail=
.com?part=3D1
>

--000000000000d801a106564e2793
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi T.J.,<br><br><div>Thanks for the review.<br><br>You are=
 right, the export tracing was inadvertently lost when splitting<br>dma_buf=
_fd() apart. I&#39;ve fixed it in v3 by introducing a new<br>dma_buf_fd_ins=
tall() helper in dma-buf.c that wraps the DMA_BUF_TRACE<br>call together wi=
th fd_install(), and using that in dma-heap.c instead<br>of a bare fd_insta=
ll(). The trace event fires after copy_to_user()<br>succeeds, just before t=
he fd becomes visible to userspace =E2=80=94 the same<br>observable moment =
as before.<br><br><br>Baineng</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">T.J. Mercier &lt;<=
a href=3D"mailto:tjmercier@google.com">tjmercier@google.com</a>&gt; =E4=BA=
=8E2026=E5=B9=B47=E6=9C=8811=E6=97=A5=E5=91=A8=E5=85=AD 04:20=E5=86=99=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Fri, Jul 10, 2026 at 4:06=E2=80=AFAM &lt;<a href=3D"mailto:sashiko-bot@k=
ernel.org" target=3D"_blank">sashiko-bot@kernel.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:<br>
&gt; - [Medium] Bypassing the standard dma_buf_fd() API skips the emission =
of the trace_dma_buf_fd tracepoint.<br>
&gt; --<br>
&gt;<br>
&gt; --- Patch [1]: [PATCH v2] dma-buf: dma-heap: don&#39;t publish fd befo=
re copy_to_user() succeeds ---<br>
&gt; commit 869904722955c74d0c6e8c974d3c64c6befabac6<br>
&gt; Author: Baineng Shou &lt;<a href=3D"mailto:shoubaineng@gmail.com" targ=
et=3D"_blank">shoubaineng@gmail.com</a>&gt;<br>
&gt;<br>
&gt; dma-buf: dma-heap: don&#39;t publish fd before copy_to_user() succeeds=
<br>
&gt;<br>
&gt; This commit restructures DMA_HEAP_IOCTL_ALLOC to delay publishing the<=
br>
&gt; file descriptor until after copy_to_user() succeeds. It open-codes the=
<br>
&gt; fd allocation and installation steps instead of using dma_buf_fd() to<=
br>
&gt; prevent an fd leak on copy_to_user() failure.<br>
&gt;<br>
&gt; Link: <a href=3D"https://lore.kernel.org/dri-devel/175e98de-f414-47d7-=
81c1-c0fe0a8f7f62@amd.com/" rel=3D"noreferrer" target=3D"_blank">https://lo=
re.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a8f7f62@amd.com/</a><b=
r>
&gt;<br>
&gt; &gt; diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-hea=
p.c<br>
&gt; &gt; index 3937dd41bb0f6..983dee947c851 100644<br>
&gt; &gt; --- a/drivers/dma-buf/dma-heap.c<br>
&gt; &gt; +++ b/drivers/dma-buf/dma-heap.c<br>
&gt; [ ... ]<br>
&gt; &gt; @@ -175,15 +162,28 @@ static long dma_heap_ioctl(struct file *fil=
e, unsigned int ucmd,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (kcmd) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case DMA_HEAP_IOCTL_ALLOC:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dma_heap=
_ioctl_allocate(file, kdata);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf =3D dma_h=
eap_ioctl_allocate(file, kdata);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(dmabu=
f)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D PTR_ERR(dmabuf);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D ((struct =
dma_heap_allocation_data *)kdata)-&gt;fd;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_to_user=
((void __user *)arg, kdata, out_size) !=3D 0) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0put_unused_fd(fd);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dma_buf_put(dmabuf);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D -EFAULT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fd_install(fd, dmabuf-&gt;file);<br>
&gt;<br>
&gt; [Severity: Medium]<br>
&gt; By open-coding the fd reservation and installation here instead of usi=
ng<br>
&gt; dma_buf_fd(), does this skip the emission of the trace_dma_buf_fd trac=
epoint?<br>
&gt;<br>
&gt; If so, observability tools, BPF scripts, and perf tracing relying on<b=
r>
&gt; trace_dma_buf_fd to map dmabufs to file descriptors will silently miss=
 all<br>
&gt; allocations originating from the dma-heap subsystem.<br>
<br>
Hi Xiang Gao,<br>
<br>
It looks like this change in its current form breaks the export<br>
tracing that you introduced. It looks fixable by adding a call to<br>
DMA_BUF_TRACE in after copy_to_user in dma_heap_ioctl. However I&#39;m<br>
wondering if you&#39;re aware of the dmabuf iterator that traverses the<br>
dmabuf_list? I&#39;ve backported it to 5.10, so it&#39;s available on all o=
ur<br>
kernels: <a href=3D"https://r.android.com/q/Iaeda328f7693acc1506269c12cac5e=
7955e5c091" rel=3D"noreferrer" target=3D"_blank">https://r.android.com/q/Ia=
eda328f7693acc1506269c12cac5e7955e5c091</a><br>
Someone else from Xiaomi even helped with the 6.12 backport. So I<br>
guess I&#39;m wondering if the dmabuf iterator would work for you instead<b=
r>
of the tracepoints.<br>
<br>
Thanks,<br>
T.J.<br>
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EN=
OTTY;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; --<br>
&gt; Sashiko AI review =C2=B7 <a href=3D"https://sashiko.dev/#/patchset/202=
60710105740.3080070-1-shoubaineng@gmail.com?part=3D1" rel=3D"noreferrer" ta=
rget=3D"_blank">https://sashiko.dev/#/patchset/20260710105740.3080070-1-sho=
ubaineng@gmail.com?part=3D1</a><br>
</blockquote></div>

--000000000000d801a106564e2793--
