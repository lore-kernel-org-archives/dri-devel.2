Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E79CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 21:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A8D10E33C;
	Mon, 18 May 2026 21:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PP3w9tdh";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2F610E33C
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 21:13:14 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891b4934ffso205e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779138792; cv=none;
 d=google.com; s=arc-20240605;
 b=e6yCZvLkQgaRKQAyX19cV9QL2zAmYNwgC78oVgb4PDlAY89eFAmZaRdl6EeRXZGI96
 98h0KMEdqsnKH7fz5Wyh2E0bihc/9mAtVA2UDSUNhQbNqFLeYNVMtsgZH4T6DrADJ4MV
 YGHzXjMPnWxr56w4E4R9JGeSuARIZoomXRvTujOkGnLvJgsYkSYr8xk7NzrD/eihzNKr
 6uHENxVZRPkF0YpA1w16HdCd+6IcR160yJ7lTfyHJGhOkjBej9jlc3oKrn3GdFtVY9ap
 Y2unrX8TiyShPwLHoXfTzT3kqASc4qFNUv6Pm2/5iQfUdOzH3tKcnLjiqSqhLNQdA0yl
 3LmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TdtUTbNXCNhmI+LuqRwGM1avFF2CHCXidccR+1bE1AI=;
 fh=oxQbF4L/eDzzcFftPJdg4VOua3S3/xP21z3VO6maScg=;
 b=lwGExaAr3VyiWcW5oC8aZSFGa+BX4rNa0kKFXJTcWVaCO2BuXwIbsbR3K05J5yC6Zn
 1alF0IQHojtsAD4qgV8MT/9A0CvVfxgccAhEQkJUm6CMTco4LnYIhmg4zAbfD0B6CvfX
 i0Uvhc3IV+hG1MGeUWWTiJhLFG5E90vLKIjamBGg8A7jyvVUhW8+OU6hsBHuybzw5Q1w
 P3QdP4A/YMmPEwN94CBqLsn7gZcRc+AR9UdjltxwJnLPEJ16/hFTSSv23JS1PuCXsxOP
 b5WDu16zK0WK7ooXVHAvWnIAW/Wjd1t3M1CyDHcKWBvkohXrCWYFwAIx/a7y6MCAYavJ
 1+YA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779138792; x=1779743592;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdtUTbNXCNhmI+LuqRwGM1avFF2CHCXidccR+1bE1AI=;
 b=PP3w9tdhY0HreORaPVSz/l5/qlUU4B5XP/54OJu4bJqRbzgUwkZJ9FUutwR+G28Ygh
 K9VFIydx6pE5v0LoZ5J7G0HTkSz3oQyeOPT+D1D1joOqMYxX25GgUU4Q2LwU8+hZ7JLv
 eXK1Zl9so9MEB2aNS1zVcMcQ0PyMd86nwKYkbICFARK0Q+onf1b5IY04xgjxiKTHnk0v
 +AMV9FNkmKebKeAH3ddQtCjXIB3OPizjvblQ2HGsQxtBAVxP+G9BeQxLohiVnSRSuNUb
 hCAXuVSgL2lYFneOwjNPM70aVs6BPRdQCwfqcIhnrjlE0kHHBU0+RKg9RhFO3om1adb8
 U0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779138792; x=1779743592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TdtUTbNXCNhmI+LuqRwGM1avFF2CHCXidccR+1bE1AI=;
 b=LcmmNJbGjYLN+q/t406KcstZXFJ8x6iM1VIq5FsyuB18Zf6EYXWeDaVn+JHCIpEoRk
 NAxB0cz8mVHuwyp+BiFPSF3EY2vJ6sMjJRtiR6Imy5ffek5IIsFeuZY/UllX/O1SIf2X
 w64ZtnnFWf8cNUxUlB+y1EtIAuFPCyrJxBygbziTIz/ZAB+Gn2FuEffk/bs0k4b3wQeU
 g6CHIJxrivWKv6yCGbvH/ZXJAG7uATHHQwvkU+AKZkFmW7OwsRpC0+g8MxHwiWDtUhqU
 6jrB+ebMpO+E+57Te8dC3Hxkt6Pspj3PEb0qLirlzfaCvYSAxms3PGZBexTERsqgsUo1
 /A4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/62pfqunUcwTpt2f5uEGPPoMSOTokIpZn6y815uKs/wMeaIoHtevyFtMJkl2tDikg0Fmu9OFXlHmE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHyvPjKkl0CAQuLlDsOhqqM9nvKy6hGqTsl2e6T5Qxr8DBRtXD
 k9IgZDTTqP705RtBnaCZd9LB7CMxQshCsJWtKlDilyk8DdNJv2u/+8hkymqh3Q0qY7sXXALCz+A
 Xlf8WqPUeXMYOGHBOAp+Phv+Tg44MPbhhQUj1z+8L
X-Gm-Gg: Acq92OHM/E/dWul0j3q/vwBH3kwpuveeCeHUue3tOeMRoYUqbZznKWHhsYr8HKzdyZM
 TZJdjElJW3mDewYBIuB1RKPjXtu/J/YVduRjgMaSJuJVLnSHskEdd8Ai7RnlTUC5VoJWfgoOtPt
 NPKirN1f1ZVPOUgCQvgBcbY7OI5lTfeMYlsASU2gFpUHXHtbS/fMHItQ0eQumfhkAzh6jSnNYhs
 Y5Hqu5y18tAz75DXIwzGalhEASNklaDKto9QcoqrzIlZBXNa0BUViMgcG3OWzfKJhS6wlkwgB9q
 AWzPfZZb7M4S/3YVMj9FnyTfz4WhxmLK2zDbxknCi7yavVL4
X-Received: by 2002:a05:600c:5650:b0:48a:5aa3:ac1e with SMTP id
 5b1f17b1804b1-48ffd828c95mr2422185e9.3.1779138791895; Mon, 18 May 2026
 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
 <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 14:12:59 -0700
X-Gm-Features: AVHnY4L4foI9pbyItEwrt04ziyQl1Xw6iN4loxWK62AYv0ZIBdafhEyOwVCgdmg
Message-ID: <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
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

On Sat, May 16, 2026 at 1:40=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, May 13, 2026 at 2:54=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Tue, May 12, 2026 at 3:14=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> > >
> > > On 5/12/26 11:10, Albert Esteve wrote:
> > > > On embedded platforms a central process often allocates dma-buf
> > > > memory on behalf of client applications. Without a way to
> > > > attribute the charge to the requesting client's cgroup, the
> > > > cost lands on the allocator, making per-cgroup memory limits
> > > > ineffective for the actual consumers.
> > > >
> > > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > > the mem_accounting module parameter enabled, the buffer is charged
> > > > to the allocator's own cgroup.
> > > >
> > > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account f=
or
> > > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > > > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and rout=
e
> > > > all accounting through a single MEMCG_DMABUF path.
> > > >
> > > > Usage examples:
> > > >
> > > >   1. Central allocator charging to a client at allocation time.
> > > >      The allocator knows the client's PID (e.g., from binder's
> > > >      sender_pid) and uses pidfd to attribute the charge:
> > > >
> > > >        pid_t client_pid =3D txn->sender_pid;
> > > >        int pidfd =3D pidfd_open(client_pid, 0);
> > > >
> > > >        struct dma_heap_allocation_data alloc =3D {
> > > >            .len             =3D buffer_size,
> > > >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> > > >            .charge_pid_fd   =3D pidfd,
> > > >        };
> > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > >        close(pidfd);
> > > >        /* alloc.fd is now charged to client's cgroup */
> > > >
> > > >   2. Default allocation (no pidfd, mem_accounting=3D1).
> > > >      When charge_pid_fd is not set and the mem_accounting module
> > > >      parameter is enabled, the buffer is charged to the allocator's
> > > >      own cgroup:
> > > >
> > > >        struct dma_heap_allocation_data alloc =3D {
> > > >            .len      =3D buffer_size,
> > > >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> > > >        };
> > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > >        /* charged to current process's cgroup */
> > > >
> > > > Current limitations:
> > > >
> > > >  - Single-owner model: a dma-buf carries one memcg charge regardles=
s of
> > > >    how many processes share it. Means only the first owner (and exp=
orter)
> > > >    of the shared buffer bears the charge.
> > > >  - Only memcg accounting supported. While this makes sense for syst=
em
> > > >    heap buffers, other heaps (e.g., CMA heaps) will require selecti=
vely
> > > >    charging also for the dmem controller.
> > >
> > > Well that doesn't looks soo bad, it at least seems to tackle the prob=
lem at hand for Android and some of other embedded use cases.
> >
> > Yeah I think this might work. I know of 3 cases, and it trivially
> > solves the first two. The third requires some work on our end to
> > extend our userspace interfaces to include the pidfd but it seems
> > doable. I'm checking with our graphics folks.
> >
> > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > /dev/dma_heap/foo)
> > No changes required to userspace. mem_accounting=3D1 charges the app.
> >
> > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allocate
> > -> gralloc)
> > gralloc has the caller's pid as described in the commit message. Open
> > a pidfd and pass it in the dma_heap_allocation_data.
> >
> > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > SurfaceFlinger -> gralloc)
> > In this case gralloc knows SurfaceFlinger's pid, but not the app's. So
> > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > interface, or transfer the memcg charge from SurfaceFlinger to the app
> > after the allocation.
> > It'd be nice to avoid the charge transfer option entirely, but if we
> > need it that doesn't seem so bad in this case because it's a bulk
> > charge for the entire dmabuf rather than per-page. So the exporter
> > doesn't need to get involved (we wouldn't need a new dma_buf_op) and
> > we wouldn't have to worry about looping and locking for each page.
> >
>
> Hi T.J.,
>
> Your description of the three different cases sounds very interesting.
> It helps me understand how difficult it can be to correctly charge
> dma-buf in the current user scenarios.
>
> I=E2=80=99m wondering where I can find Android userspace code that transf=
ers
> the PID of RPC callers. Do we have any existing sample code in Android
> for this?

Hi Barry,

In Java android.os.Binder.getCallingPid() will provide it. Here


> > > I'm just not sure if this is future prove and will work for all use c=
ases, e.g. cloud gaming, native context for automotive etc...
>
> Thanks
> Barry
