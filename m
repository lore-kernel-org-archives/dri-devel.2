Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0997C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D2510E29C;
	Mon, 13 Jul 2026 23:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="GpGwhn6c";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179BC10E29C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 23:33:43 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b8d92a4eso22435e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 16:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783985621; cv=none;
 d=google.com; s=arc-20260327;
 b=MlijeuGD3owEwyVH7XsOUsDng+BVaFmKaRcb61BFUN9IN01Z4KWfSBt3+4iRqQYfhr
 NKR7b19JIrQ5c82KpQKb2Iv4BuwBRcJISjgsoU2r2zbFCfLRjuNef7DRKzQ9tLwteage
 UJPMifJQWa0cmMUgvE13/x3N9Ivo6ldjJ8QYxXVt6j4y3JvneA43MGJMul7a/F8ZKusG
 BHjHGlewJpxJtjt9Z6l/T8nbyuUHtsK1cHzZI3HZ17SAHYoGHZnjtj2UINX4fn3Z+/KK
 vxo/Z57O14hxDL4k8mTclFxdIsmKcNOhxJbyNGMObG0i96fmnWHxQUydj31v3DMcJ+ec
 SF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MhJXcRMH8N66F7+XzpKxCwXc3ej7YKBd+Nc2fID/XdY=;
 fh=JGJi9+H4VNUab9ykDhB6YwPvr006qFxNUr99wAf6VHo=;
 b=dqO9g60+krV2EtQnFfRmr+zI0zoDYHCdZqziv7c+3ML7C7FYjRDslV8SGqomadnerK
 Et6qa80JjGUUblM//s1HwyT8zJ9Jt6I+YoLsL40kII8qgGWZX4PsvMnkllG8tro8SFWe
 FdR6Nh+rtFox9Qm7UGM4LCZMcbCXVsGGh5UK3uInyk5stwio9A1TQMQywpYc5NuOQn/a
 8UuEu1bH21KkdJtuJs9qFZg1wg9B/kI2/QFxDDlHHLIe7nLPIVTtLnx3eA3ZvIwY4ijD
 Il3e/K6hC6Ub21f4S6DNcWKMlVcmrf2cS81r9LxxVfTApqzzOWQfjCb/uQ+H7bqKzAxP
 Y42w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783985621; x=1784590421;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MhJXcRMH8N66F7+XzpKxCwXc3ej7YKBd+Nc2fID/XdY=;
 b=GpGwhn6cC6zJjisqiQ+7K2Hswtw/gYVkBBFHrMrttd0zxczyuJANK1IZK+W17mig+C
 Im2ttOi0/vGIyEGAZb+a4IoGuZi3uyIAuZRJTHYAvPdRt3UK7oaxBjj84xSKzzrNK3VI
 nydgSm4d9UvLLTrgk9dVmmdCqMuCZebsYuv08lv46Si0TMmQ/hZautv2t37ag2pAMkhp
 F0sATM8NsWE3akh7AgK3N4KzEaPMOqcMrdj8ivuIM5FfmTAf1L4Gsi7tcsmKl46GSTvl
 VmOx7rTGXfddlydldF1tNaIu2X3AdgSGmrDZtNDKxpSKvjYjGhxexGf7iKwQMvZnHIxV
 +2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783985621; x=1784590421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MhJXcRMH8N66F7+XzpKxCwXc3ej7YKBd+Nc2fID/XdY=;
 b=Vd64pso6n95M0fTFDGoXQIiswYPPI15f05i50tLmH5Dl6T/6uXHCKZT3MKU1coPzD0
 qPQHhbfppCyFWi5+kYAxa9OEE31X8kSKrjBN44Uf5ClBj7Et8dF3UoDwbUUGBECv27kF
 5nBAvMuuhENgv2vjBf0MGJi7ZY9giUMvU75qbKpdKnQICbmWMdpG64gzmosP6FJzTLHw
 B4wq7Kw2GT07aNyrP8fhj4T+GnPOxZ7qSmcODza5Zc1xl36xoyTRGODecJ/qApJc8Abi
 /dVrNY51jEMEsFJIbGc3POFCzLL8f3WqjtmCEPZBhmSNyqRY+2IjXhf5BGcjEz0juS1v
 6KKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQBpu8Jsd6q+r/Pktrts9UehOkcJopZJ6MgC7pjy/pQ29SAgjQwRcgz8/qKwmJhiu3MQ0K4zjMFWE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxbUxyCHUsaCHFm16Pb//QS1Myn5JC6m41R8rCRRpM7NIUF9jv
 HALapLkg0BGWAYqP3JNF4Bikxiv814+NuUJhZzIOpOMsOeBMX1qhzgM/D0ZHvGFuvZnXywheIS6
 YYW2NiG9iAViZ+1mvbp8QdOGWKjNqZXJAgroPYSjj
X-Gm-Gg: AfdE7cnObgSoadzWjGozkkEvCPF64L0UN0HidAZZmW+p2MiCzVLfjrG/E2qsmYiTG+1
 +G469iY+8uz7FlLv4XDl4lSuWLTRx1jz6SpW3rH4MkDp6J63/EoSlHuo714aiV5x4LmlKQ5rm4I
 CH8twY4n16zvdSaSsVsDgsdn0RPDBBaHDtcJM9vmQrnJYeHp/KE7R/uqq/4EYMnFiSiaCSDQQxI
 i+Y0fQNw132ZQbBhhIr3GQ6r2PJU2WhUiBp5abv9BEXD+dteDG+K6Pex6U1MgA7sxj3UikIujKv
 B0hZs5FzVFNlZmWs6IHT8U5E/zY=
X-Received: by 2002:a05:600c:b48:b0:490:b2ae:44ca with SMTP id
 5b1f17b1804b1-4946215449cmr864595e9.5.1783985620885; Mon, 13 Jul 2026
 16:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
 <20260710105740.3080070-1-shoubaineng@gmail.com>
 <20260710110645.079DC1F000E9@smtp.kernel.org>
 <CABdmKX2xt6diYwCs32E7HNL8ULepDfrDQ20iB+HVw5o-pCd0xg@mail.gmail.com>
 <CAGCp47yZ4fWbuAg7HPPS0bknaTk88dPOVfCzc8J+H7-u4wM7bQ@mail.gmail.com>
In-Reply-To: <CAGCp47yZ4fWbuAg7HPPS0bknaTk88dPOVfCzc8J+H7-u4wM7bQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 13 Jul 2026 16:33:29 -0700
X-Gm-Features: AUfX_my0yOr8TW87vRlRgOFPapFZNgD4NX0kk5EWNSKtxsDMxsrk5E5tdSr98o8
Message-ID: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Cc: gaoxiang17@xiaomi.com, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Sandeep Patil <sspatil@android.com>, 
 "Andrew F . Davis" <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 10, 2026 at 9:18=E2=80=AFPM =E5=AF=BF=E6=9F=8F=E8=83=BD <shouba=
ineng@gmail.com> wrote:
>
> Hi T.J.,
>
> Thanks for the review.
>
> You are right, the export tracing was inadvertently lost when splitting
> dma_buf_fd() apart. I've fixed it in v3 by introducing a new
> dma_buf_fd_install() helper in dma-buf.c that wraps the DMA_BUF_TRACE
> call together with fd_install(), and using that in dma-heap.c instead
> of a bare fd_install(). The trace event fires after copy_to_user()
> succeeds, just before the fd becomes visible to userspace =E2=80=94 the s=
ame
> observable moment as before.
>
>
> Baineng

Thanks Baineng, that LGTM.  Please have my RB:
Reviewed-by: T.J. Mercier <tjmercier@google.com>

You'll probably want to resend this with a "[PATCH v3]" subject though.

Originally I wasn't sure if we really needed dma_buf_fd_install
exported, but I looked around and see that fastrpc_dmabuf_alloc
(drivers/misc/fastrpc.c), gntdev_ioctl_dmabuf_exp_from_refs
(drivers/xen/gntdev-dmabuf.c), and I think video_usercopy
(drivers/media/v4l2-core/v4l2-ioctl.c) also suffer from this same
problem. Want to take a stab at those too? :)

-T.J.


>
> T.J. Mercier <tjmercier@google.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=85=AD 04:20=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Fri, Jul 10, 2026 at 4:06=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>> >
>> > Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
>> > - [Medium] Bypassing the standard dma_buf_fd() API skips the emission =
of the trace_dma_buf_fd tracepoint.
>> > --
>> >
>> > --- Patch [1]: [PATCH v2] dma-buf: dma-heap: don't publish fd before c=
opy_to_user() succeeds ---
>> > commit 869904722955c74d0c6e8c974d3c64c6befabac6
>> > Author: Baineng Shou <shoubaineng@gmail.com>
>> >
>> > dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
>> >
>> > This commit restructures DMA_HEAP_IOCTL_ALLOC to delay publishing the
>> > file descriptor until after copy_to_user() succeeds. It open-codes the
>> > fd allocation and installation steps instead of using dma_buf_fd() to
>> > prevent an fd leak on copy_to_user() failure.
>> >
>> > Link: https://lore.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a=
8f7f62@amd.com/
>> >
>> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
>> > > index 3937dd41bb0f6..983dee947c851 100644
>> > > --- a/drivers/dma-buf/dma-heap.c
>> > > +++ b/drivers/dma-buf/dma-heap.c
>> > [ ... ]
>> > > @@ -175,15 +162,28 @@ static long dma_heap_ioctl(struct file *file, =
unsigned int ucmd,
>> > >
>> > >       switch (kcmd) {
>> > >       case DMA_HEAP_IOCTL_ALLOC:
>> > > -             ret =3D dma_heap_ioctl_allocate(file, kdata);
>> > > +             dmabuf =3D dma_heap_ioctl_allocate(file, kdata);
>> > > +
>> > > +             if (IS_ERR(dmabuf)) {
>> > > +                     ret =3D PTR_ERR(dmabuf);
>> > > +                     break;
>> > > +             }
>> > > +
>> > > +             fd =3D ((struct dma_heap_allocation_data *)kdata)->fd;
>> > > +             if (copy_to_user((void __user *)arg, kdata, out_size) =
!=3D 0) {
>> > > +                     put_unused_fd(fd);
>> > > +                     dma_buf_put(dmabuf);
>> > > +                     ret =3D -EFAULT;
>> > > +             } else {
>> > > +                     fd_install(fd, dmabuf->file);
>> >
>> > [Severity: Medium]
>> > By open-coding the fd reservation and installation here instead of usi=
ng
>> > dma_buf_fd(), does this skip the emission of the trace_dma_buf_fd trac=
epoint?
>> >
>> > If so, observability tools, BPF scripts, and perf tracing relying on
>> > trace_dma_buf_fd to map dmabufs to file descriptors will silently miss=
 all
>> > allocations originating from the dma-heap subsystem.
>>
>> Hi Xiang Gao,
>>
>> It looks like this change in its current form breaks the export
>> tracing that you introduced. It looks fixable by adding a call to
>> DMA_BUF_TRACE in after copy_to_user in dma_heap_ioctl. However I'm
>> wondering if you're aware of the dmabuf iterator that traverses the
>> dmabuf_list? I've backported it to 5.10, so it's available on all our
>> kernels: https://r.android.com/q/Iaeda328f7693acc1506269c12cac5e7955e5c0=
91
>> Someone else from Xiaomi even helped with the 6.12 backport. So I
>> guess I'm wondering if the dmabuf iterator would work for you instead
>> of the tracepoints.
>>
>> Thanks,
>> T.J.
>>
>> > > +             }
>> > > +
>> > >               break;
>> > >       default:
>> > >               ret =3D -ENOTTY;
>> > >               goto err;
>> > >       }
>> >
>> > --
>> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710105740=
.3080070-1-shoubaineng@gmail.com?part=3D1
