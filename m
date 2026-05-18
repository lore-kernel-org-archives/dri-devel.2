Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41192CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234A810E358;
	Mon, 18 May 2026 23:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="INB6rHjC";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183ED10E26C
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:39:16 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488940ccfa6so565e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147554; cv=none;
 d=google.com; s=arc-20240605;
 b=BLlDGPgyOy7Pz8ESiQ9EkwagKWLkiP8sfYVkgg6t2kKQ7r5MzkdREkRIZ/lQwcQKxq
 VmKv3Lctn1sJWVM+3AKcjKi1w0rsgjZj21whggxTmKOigM7EVjUCFxahjqVU4Nqbpupf
 +m9A0BdOBrFOd4Y+AxdlJylrJsgnv7vCDwOAyslEx6petg5HD7FIm1lsIGozb1nf8NoO
 8HZSC360b7uupXFvofQla1Zmq0ZLvtK4HzhHurbXquFiVO7hLBQIMnESt9Spg5SJbIZn
 +5P41VNsznzH0hR15h+bbIt4LA1x5Rr3BQeSl/0HQ0gJ7LrcaVD+QVDRgn45krZ/EwxG
 c9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
 fh=nYswPVnizM6VhCZXy97Cg6ZkasbDvrQPnM7TgMDsr6c=;
 b=PXDVoS8N2GLFkzWweCCKthBUJyVd4K7oGVpGvOi+jKc3qgHX+j8wQiiGg2Q3P6mInd
 7LOL5IvivYP30ahZ6gxSgM658uoF+MxPajESuOE/uQuT1GtDfSqNe0azWS43NxA++Yqj
 pbJKQcLwqkAJYr/9JPRtDT/CW6ssQB3Xbg0qkh2LGLZ/kw7MvSNfGgewmKrSEn4Gqu45
 WejQXUldYYC9t7s/AXlNiakniVKiUyQEKP9i16Iu7kUrNo9xZoUpqZnEI14u1bTHwwEM
 HAnZuapGaFVF1GEfzwSJbAp2b4KFAApRlbJh1atc+6jqo7ILEY9w3ZSv7aXhh/uETncZ
 huxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779147554; x=1779752354;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
 b=INB6rHjCpSZJZR6GJkz0mcWNF1svZYyJFZSgqKX5GVjlztyfrxHi3MaY/U5FafWkII
 dfbGVxNEdvIFxHt0HJLdH/ho9TDxdq7gUwN15NTYdpwtdI0pKPz8htGGyyIvnBbI68+v
 kD/Ae48uAjBcypMCUAbQDKJFN6cWgW6nth1lpyqwlPpNyYJsZHdCo1cg2yHHyAg+jhEF
 RhhGWL5ztw8nddyZghY7Dcn+CV5U3FbSuUJCiOtcUNWde7fvVPplis3ra1ovw2hnXxB2
 74OIOgufU2DgZzVcw7PFf82SnxujLkOEsKlJb9GX7fSU03ZvnVhK9JUk0wmNqqW8HbQ4
 YGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779147554; x=1779752354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
 b=o00I22B5IvAYY2m4pm+XYV6eyItR4m68tkcxajdZ5v2nQWlVZGIyPHSlqIW4ofTkbu
 B73y4kHxw7svHk+Xc/iyXClrmEIS9iLAIZlf5wgg2+pbPPEoPHzMl/XzgpMOKcCP8qWl
 w4RiAg1/CZO22fz6zCK9kVl/DwHdLvAwMu1SCXETQ81/2jg6jM9gFdn2x0mYTW9nFC0h
 RRay+boAjzcVf9ZpgugRkjz0YTlz9E3JUJ+ojmXwf6mVoxLkpUkJV5rAk+vrzjbnQZ3U
 ZqThcY4FxqgN7Nf3GpwbnNQsmvtI5k6JInP2GUenxWL2Xc3PdDgEOHbNktG5XW6xmnXJ
 eZsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gGzopIgG+oFX3XnLK2Zb7KM2Ez3QBjNR+IMImh9YWp3u67JBslyLyMKJX4nt3C+nl8ZGgurMgSJM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgxPQIRT7+84+N4ze6pHex0MGtxNGKn8m5saXqwH8ncm+ZEEgK
 K20139ocsAQ9j8QZ/++uDPyQYpZgz83PVIRc+IcPbcbdn/oIO2Mhfn0inPLuddQSuBTg5yKPeHM
 o0sH36essCfMFOelI4Tm+blBjO8ltExFWGf7zzW7w
X-Gm-Gg: Acq92OGqoOynHDYa2kF9QKr7By0KyZfOCe6sVBDoEz/sQ7Loww7Sv+bLpQk3C9/OJgq
 VUVAZ5Kff3/5FUZHMet4QDTPMVlZ0Vru/7K5tZVyKR1A4N3PVNni3477X8fxrz8o2DZPU7euki2
 /98k/sBApNFOlluhWv94+WmkGK9/CAeaR6QggVRGI3IL0rY1Cg1JipSH2WPc5zNp+9kXvDj6DjU
 EY9+065Kofyf/ON2sknJ0MmH/Wr0oZus/N/CHTZouIiZOp/EXq6cGoCTxnO7VjPP+Vtk1go7bIA
 MZ0osdAaQoq74GBLtN22oA9W20dOKVrWQHZ0UqT4J6eCbg99
X-Received: by 2002:a05:600c:83c4:b0:48a:56fa:36dd with SMTP id
 5b1f17b1804b1-48ffd85790amr3271995e9.11.1779147554173; Mon, 18 May 2026
 16:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
 <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
 <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
In-Reply-To: <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:02 -0700
X-Gm-Features: AVHnY4K5WzHxjnmBKK1J4Ij9G3s1JmujGOC18rtfp3AXYH6mFeA4fkV1W-efX6I
Message-ID: <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Albert Esteve <aesteve@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, mripard@kernel.org, 
 echanude@redhat.com
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

On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:50, Albert Esteve wrote:
> > On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/15/26 19:06, T.J. Mercier wrote:
> >>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>>
> >>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>> On embedded platforms a central process often allocates dma-buf
> >>>>> memory on behalf of client applications. Without a way to
> >>>>> attribute the charge to the requesting client's cgroup, the
> >>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>> ineffective for the actual consumers.
> >>>>>
> >>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>
> >>>> Please be aware that pidfds come in two flavors:
> >>>>
> >>>> thread-group pidfds and thread-specific pidfds. Make sure that your =
API
> >>>> doesn't implicitly depend on this distinction not existing.
> >>>
> >>> Hi Christian,
> >>>
> >>> Memcg is not a controller that supports "thread mode" so all threads
> >>> in a group should belong to the same memcg.
> >>
> >> BTW: Exactly that is the requirement automotive has with their native =
context use case.
> >>
> >> The use case is that you have a deamon which has multiple threads were=
 each one is acting on behalve of some other process.
> >>
> >> At the moment we basically say they are simply not using cgroups for t=
hat use case, but it would be really nice if we could handle that as well.
> >>
> >> Summarizing the requirement of that use case: You need a different cgr=
oup for each thread of a process.
> >
> > Hi Christian,
> >
> > Thanks for sharing this atuomotive usecase. If I understand correctly,
> > the actual requirement is attributing dma-buf charges to the right
> > client, not putting each daemon thread in a different cgroup?
>
> Nope, exactly that's the difference.
>
> The thread acts as a filtering agent for both memory allocation and comma=
nd submission for somebody else, the process on which behalve the daemon do=
es things can even be in a client VM, completely remote over some network o=
r even something like a microcontroller.
>
> Everything the thread does regarding CPU time, GPU driver memory allocati=
on as well as resources like GPU processing and I/O time etc.. needs to be =
accounted to one client which can be different for each thread of the proce=
ss.
>
> The only thing which is shared with the main process thread is CPU memory=
 resources, e.g. malloc() because that is basically just needed for houseke=
eping and pretty much irrelevant for this kind of use case.
>
> The problem is now you can't do that with cgroups at the moment but unfor=
tunately only the kernel has the information you need to know to do this.
>
> So what you end up with is to define tons of interfaces just to get the n=
ecessary information from the kernel into userspace and then essentially du=
plicate the same infrastructure cgroup provides in the kernel in userspace =
again.
>
> > If so,
> > the `charge_pid_fd` approach achieves this directly by passing the
> > client's `pid_fd`, without needing to add per-thread cgroup
> > infrastructure.
>
> Well it's already a massive improvemt, we could basically stop doing the =
whole duplication part for the GPU driver stack and just use cgroups for th=
is part.
>
> Doing that automatically for CPU and I/O time would just be nice to have =
additionally.
>
> Regards,
> Christian.

Hopefully I'm following correctly here.... So you are duplicating the
GPU driver stack to achieve remote accounting on a per-thread basis?
Does this mean for GPU allocations you currently have some GFP_ACCOUNT
magic in your driver to attribute GPU memory to the correct remote
client? So this series would close the gap for dma-buf allocations,
but what about private GPU driver memory allocated on behalf of a
client?
