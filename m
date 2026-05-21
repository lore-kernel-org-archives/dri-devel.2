Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E915CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E9810F30C;
	Thu, 21 May 2026 13:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OxrI1RPw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22DB10E06E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779368491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmwC58HJBimxH19t4ZPSn9X111oVOA5kpRJyuTfhJLQ=;
 b=OxrI1RPwhVeaoFNNn9BmIFIvKgUPnSaJ2diRLZJItmw1EkyR60Ud4dz4qUFUA6tNxkpXrv
 vLHM47e6KQFujMSpBqp/2EdlexxUmM+d5H7U1EvqMrrKWwoLnqBvAV2yHX6cjWuTWv5EW+
 1qvoc9AlYE+j+M4s1vT7t1IBuJ7bsxQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-1SqYA3YdOOWgmTm4E0Yr5w-1; Thu, 21 May 2026 09:01:29 -0400
X-MC-Unique: 1SqYA3YdOOWgmTm4E0Yr5w-1
X-Mimecast-MFC-AGG-ID: 1SqYA3YdOOWgmTm4E0Yr5w_1779368489
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7bd5c9e1826so86204077b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779368489; x=1779973289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LmwC58HJBimxH19t4ZPSn9X111oVOA5kpRJyuTfhJLQ=;
 b=oyZE7wyEYmcTFZFp1ujs3LwQYzItyAxPCAjOicAzTPV5N0c5WHW8COhWfVEzcdY/G1
 fTar2hkysevs+kNv1AS+3FlW6c+zesoZuZ976/Srs/m1Gq+EFHU6hk6LwrVokHvqacNJ
 bVChnuzjszQUCi2zV3oSTUQR7WoocsTXoCpTF7l7YMp0udD+KgtuNpny8QVC96m1avTi
 KmkNnFTA02K3MQp0VOcaReoVM0dNLRPQjPa3KVk95iG8IPpAiT9/yQ7aZ309r5wqzy9U
 ZI14R3+pgtEEi+QZDFt+w/9lmoLBOWUFfc9c9turQFdmr7v7fX7BWZk/DFi5VkrU6daB
 OUgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xpQTgefvhf1Dk3T3+NIJ4g6OZ22vzyeqmxeFLpuVdc0yom/MpLtHNilcD17ClLzZfA1QTtwTI2IA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpIYHTqeZkB29MssbmpSjb223jbnC3OaGNTTaGCwhyUqRv6DSY
 UEoK5v4upLkRox2LAQfGeA6dIxodWLlIrQaX3qEO7yHNoSvt3eCVf78aPHGoh2lWu/oHS8aC5xG
 xQVOcs4hQDyR2AbmKOQxFsDMIoM0KWDmjPEj93ihQ/9QDnCHa3MFovXuEmLSm7mEeUWUcnvGPQJ
 R9RjVcRKg67sJaoOR++FCN6dJ6vKWZowRT3jmxUP28UVpj
X-Gm-Gg: Acq92OGo8ZIi2y4RR8LemSUFtZGEiYVDqcI0LwarblCH0OMmilCu+xX/PAiqsltO8mA
 yJCCufqJF37Gm9glGmNCSILUB/0TkYyhdKhJ/O3qMQROpNW6zEx17nVQNVDRcD73cZ47yRcVs1D
 BPTmjJg7/ZDtO7WJfPWDlk/yLKCAM18i7kIA3G0IUgqZBj8p5szO0KdQthlaMe+OYIXRUv4DYXV
 jVygg==
X-Received: by 2002:a05:690c:2701:b0:798:5213:d90e with SMTP id
 00721157ae682-7d21458c414mr20821487b3.25.1779368487433; 
 Thu, 21 May 2026 06:01:27 -0700 (PDT)
X-Received: by 2002:a05:690c:2701:b0:798:5213:d90e with SMTP id
 00721157ae682-7d21458c414mr20820547b3.25.1779368486638; Thu, 21 May 2026
 06:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260521-dmabuf-limit-access-v1-0-26c01e27365a@redhat.com>
 <7b662fcd-3bcd-40a2-b014-d9ce36f6425b@amd.com>
In-Reply-To: <7b662fcd-3bcd-40a2-b014-d9ce36f6425b@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 21 May 2026 15:01:15 +0200
X-Gm-Features: AVHnY4LBiwiMio4g-NMYwHAheob8lHj03QTb2KFQDfp0pjJRm1wTbuvqILl5JEg
Message-ID: <CADSE00J1+V4=qFZPOL8Cr8hYw6d=hf_XcDPezjYGkcxAwLYGyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] dma-buf: add DMA_BUF_IOCTL_DERIVE for
 reduced-permission aliases
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 Shuah Khan <shuah@kernel.org>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, mripard@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nlYpT8vRuCHRcdmekC_MIX0Zp1D2Tf5oC-cPn8JASrA_1779368489
X-Mimecast-Originator: redhat.com
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

Hi Christian,

On Thu, May 21, 2026 at 2:28=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/21/26 11:10, Albert Esteve wrote:
> > When sharing a dma-buf between components of different trust levels, th=
e
> > allocator may need to hand a consumer a read-only view of a buffer it
> > holds with read-write access. An example is a camera pipeline where the
> > capture component writes frames into a buffer and needs to pass a
> > read-only handle to a downstream processing component that should not b=
e
> > able to modify the data.
> >
> > However, no such mechanism exists today. The access mode of a dma-buf
> > file descriptor is fixed at export time, and the standard POSIX
> > interfaces for duplicating or changing file descriptors (i.e., dup(2),
> > dup3(2), and fcntl(F_SETFL)) cannot alter the read/write access mode of
> > the copy.
> >
> > One natural candidate would be reopening via /proc/self/fd/<N> with
> > O_RDONLY, which works for regular files. For dma-buf this would fail
> > (that is, if we were to add a new handler for open f_op) with ENXIO
> > because the dmabuf pseudo-filesystem carries SB_NOUSER, which prevents
> > the VFS from opening its files through path-based resolution from
> > userspace.
>
> OH MY GOD! This is the like the sixth time I had to clarify that in the l=
ast few weeks, I'm really wondering where that is suddenly coming from.

Sorry! I do not know where others came from. But my interest comes
from automotive, safety, and mixed criticality scenarios. I kind of
hinted at that in the opening when referring to "different trust
levels".

>
> Creating the DMA-buf with O_RDONLY does *NOT* make the DMA-buf itself rea=
d only!
>
> That's a really common misconception. The flag only controls if mmap() ca=
n be done read/write or read-only to handle cache coherency issues.
>
> It is still perfectly possible for a device to write into a DMA-buf creat=
ed with O_RDONLY with DMA!
>
> So long story short there is not such feature as a read only DMA-buf, and=
 putting read-only pages into a DMA-buf and then expecting that nobody can =
write to them is an absolutely clear No-Go.
>
> If we would want to implement a read-only DMA-buf feature we would need t=
o go over all the different DMA-buf importers in the kernel and add securit=
y checks.

This clarifies a lot. Too bad, but it makes sense. I will abandon the
series then.

Thanks for the review and the explanation!

BR,
Albert

>
> Regards,
> Christian.
>
>
> >
> > Alternatively, exporting the buffer twice would produce two independent
> > dma_buf instances, which breaks fence synchronization.
> >
> > Therefore we add a new DMA_BUF_IOCTL_DERIVE ioctl, which produces a new
> > file descriptor for an existing dma-buf with a caller-specified subset
> > of the original permissions:
> >
> > ```
> >   struct dma_buf_derive { __u32 flags; __s32 fd; };
> >
> >   struct dma_buf_derive req =3D { .flags =3D O_RDONLY | O_CLOEXEC };
> >   ioctl(rw_fd, DMA_BUF_IOCTL_DERIVE, &req);
> >   /* req.fd is now a read-only alias of the same buffer */
> > ```
> >
> > Permission escalation is rejected with -EACCES. The new fd aliases the
> > same struct dma_buf as the original, same dma_resv, same exporter ops,
> > same underlying memory; so importers attaching to either fd see the sam=
e
> > fence timeline and operate on the same object. Access control for which
> > components may receive or pass on restricted descriptors can be layered=
 on
> > top via SELinux file:read and file:write permissions.
> >
> > A shared writable mapping (PROT_WRITE | MAP_SHARED) on the read-only fd=
 is
> > rejected with -EACCES in dma_buf_mmap_internal().
> >
> > Two small internal adjustments accompany the ioctl:
> > - __dma_buf_list_del() is moved to dma_buf_release() so it fires exactl=
y
> >   once on dentry destruction rather than on every file close.
> > - dma_buf_file_release() is updated to call dma_buf_put() only for
> >   files that are not the primary dma-buf file.
> >
> > This may not be the best approach, but after considering different
> > options and alternatives (as described above), we decided to raise the
> > discussion upstream. Thus, we welcome any alternative proposal or ideas=
.
> >
> > The series is structured as:
> > - Patch 1 adds the new ioctl implementation.
> > - Patch 2 adds selftests covering the new ioctl.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> > Albert Esteve (2):
> >       dma-buf: add DMA_BUF_IOCTL_DERIVE for reduced-permission aliases
> >       selftests: dma-buf: add DERIVE ioctl tests
> >
> >  drivers/dma-buf/dma-buf.c                          |  58 ++++++++++-
> >  include/uapi/linux/dma-buf.h                       |  28 +++++
> >  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 114 +++++++++++++=
+++++++-
> >  3 files changed, 198 insertions(+), 2 deletions(-)
> > ---
> > base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
> > change-id: 20260520-dmabuf-limit-access-73261353841a
> >
> > Best regards,
>

