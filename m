Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C85ACD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F344510E373;
	Tue, 19 May 2026 08:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KK+efXO4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E372610E373
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779179121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
 b=KK+efXO4ylYctwcp8LVfDh7CXaZpMeiSf7hoe5yOC3Cv26P7X3ftYv2irWzJ01Dv9/1b58
 /AkcC/zUV1PomlQM/wgknTrbwXhCQYNhGwCvosULkEj2VIf0q6TpyH1cfqZcJrzy2KdA4i
 txlagmXGKw0OU7pXySF3EaXHgUqwu9g=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-cxshhT30NiGHdSXNix9pvg-1; Tue, 19 May 2026 04:25:20 -0400
X-MC-Unique: cxshhT30NiGHdSXNix9pvg-1
X-Mimecast-MFC-AGG-ID: cxshhT30NiGHdSXNix9pvg_1779179119
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7bd5c9e2e4aso8128517b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779179119; x=1779783919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
 b=fkaeE5OfsbjrSJjaC0NK3PGwl374Vi8ki3gqOwsAYvSx+alS0Km6sTQgRPtASOFDx8
 Bfp/uFxQx64MOSooNgPeg5urXyqNrBhp+lQQZBGsIwLl6f4izRLv+FYoab8Y9ej284AG
 vjRKNb3tu3/wGKbrRKyV9S5Ar56LFfsjoNzuHdbQ54CkbKeu8qG9yuA/LQ0niPob1o6S
 H8PUA9sJj7yj9jIbkxderTuXKFYRqUrnuXjONtDu6vhX67SFrQAQVtS6zvamN+2My0SB
 x9LDwvGtXxPge92nVo/rk/kzYU67jIEtUgXVFytKY3uaxKKrpyT8Djo34nf8HDIPwmEM
 q+/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PHVvLBDgQ7Cqq5mKA1iTg6v5D0zIWD4BXakQ8WMmlRs1WJ4VhPL+MysUcuovRRhgksLTii+iYK1M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGLKL/OR7Codp2ZRVow9J5rrptamTcjvYoeLNy+lCJ/JFuGsY2
 yelzLmjruWT23Nz5QH9wxCYWeCttEVV8RC3IZaKjkFEIVmeMMTHQXFxUVxulgKT129v4I9L6Zlq
 x8W6VJwk5/PIR28QvuUaPJvxQ3BVY4f9te+0rgbPMuPTrHIFTE0ovDdMm9Z5+zsgy+2Z2i+8DJr
 xPsGpoRPfj8+5pdwGdjSB9AC8OT1c560jpa5s7AT2FNjB0
X-Gm-Gg: Acq92OGwT69u0yQUER86wQNcYyUPAI7M0y7JOvNBeoq9xcyE7ULPaN1wXSR4iSp8Ft9
 99LR/PztWhBcy1dVipUP1Uq9BR7IqULfFleRK/dmHILgGkoblq1COV0KnO9IAqSXeJcZvH7fkZa
 p3geLjNmumNBvVkSmNUk84Z4nLKw62OWNb9+8mJSbZebuJUS4MAfdupATrVvXy82hh9SwrX82g4
 Agqig==
X-Received: by 2002:a05:690c:e041:b0:7b3:edc7:9bb8 with SMTP id
 00721157ae682-7c955b970femr172557067b3.0.1779179119395; 
 Tue, 19 May 2026 01:25:19 -0700 (PDT)
X-Received: by 2002:a05:690c:e041:b0:7b3:edc7:9bb8 with SMTP id
 00721157ae682-7c955b970femr172556607b3.0.1779179118837; Tue, 19 May 2026
 01:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
 <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
 <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
 <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
 <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
In-Reply-To: <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 10:25:07 +0200
X-Gm-Features: AVHnY4K5LncaNoVhZCnb-g1Oej_4CFtS9sUy70LBQyTJDD76MUlJZifB3Hgf-cg
Message-ID: <CADSE00KCpCHOu2GMJ++ozXXbwF13fd2ZfmC3CnZBdLM_0p+ZMg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>,
 Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>,
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AOHkzKsGrQyeaHVUNuwXDKrlVGn3LxW_DuY7RU5kXgo_1779179119
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

On Tue, May 19, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/19/26 01:39, T.J. Mercier wrote:
> > On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/18/26 14:50, Albert Esteve wrote:
> >>> On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>>
> >>>> On 5/15/26 19:06, T.J. Mercier wrote:
> >>>>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@=
kernel.org> wrote:
> >>>>>>
> >>>>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>>>> On embedded platforms a central process often allocates dma-buf
> >>>>>>> memory on behalf of client applications. Without a way to
> >>>>>>> attribute the charge to the requesting client's cgroup, the
> >>>>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>>>> ineffective for the actual consumers.
> >>>>>>>
> >>>>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>>>
> >>>>>> Please be aware that pidfds come in two flavors:
> >>>>>>
> >>>>>> thread-group pidfds and thread-specific pidfds. Make sure that you=
r API
> >>>>>> doesn't implicitly depend on this distinction not existing.
> >>>>>
> >>>>> Hi Christian,
> >>>>>
> >>>>> Memcg is not a controller that supports "thread mode" so all thread=
s
> >>>>> in a group should belong to the same memcg.
> >>>>
> >>>> BTW: Exactly that is the requirement automotive has with their nativ=
e context use case.
> >>>>
> >>>> The use case is that you have a deamon which has multiple threads we=
re each one is acting on behalve of some other process.
> >>>>
> >>>> At the moment we basically say they are simply not using cgroups for=
 that use case, but it would be really nice if we could handle that as well=
.
> >>>>
> >>>> Summarizing the requirement of that use case: You need a different c=
group for each thread of a process.
> >>>
> >>> Hi Christian,
> >>>
> >>> Thanks for sharing this atuomotive usecase. If I understand correctly=
,
> >>> the actual requirement is attributing dma-buf charges to the right
> >>> client, not putting each daemon thread in a different cgroup?
> >>
> >> Nope, exactly that's the difference.
> >>
> >> The thread acts as a filtering agent for both memory allocation and co=
mmand submission for somebody else, the process on which behalve the daemon=
 does things can even be in a client VM, completely remote over some networ=
k or even something like a microcontroller.
> >>
> >> Everything the thread does regarding CPU time, GPU driver memory alloc=
ation as well as resources like GPU processing and I/O time etc.. needs to =
be accounted to one client which can be different for each thread of the pr=
ocess.
> >>
> >> The only thing which is shared with the main process thread is CPU mem=
ory resources, e.g. malloc() because that is basically just needed for hous=
ekeeping and pretty much irrelevant for this kind of use case.
> >>
> >> The problem is now you can't do that with cgroups at the moment but un=
fortunately only the kernel has the information you need to know to do this=
.
> >>
> >> So what you end up with is to define tons of interfaces just to get th=
e necessary information from the kernel into userspace and then essentially=
 duplicate the same infrastructure cgroup provides in the kernel in userspa=
ce again.
> >>
> >>> If so,
> >>> the `charge_pid_fd` approach achieves this directly by passing the
> >>> client's `pid_fd`, without needing to add per-thread cgroup
> >>> infrastructure.
> >>
> >> Well it's already a massive improvemt, we could basically stop doing t=
he whole duplication part for the GPU driver stack and just use cgroups for=
 this part.
> >>
> >> Doing that automatically for CPU and I/O time would just be nice to ha=
ve additionally.
> >>
> >> Regards,
> >> Christian.
> >
> > Hopefully I'm following correctly here.... So you are duplicating the
> > GPU driver stack to achieve remote accounting on a per-thread basis?
>
> Not quite, we are duplicating the handling cgroup provides in the kernel =
in userspace.
>
> For this memory usage information as well as execution times of the GPU k=
ernel driver is exposed in fdinfo for example.
>
> > Does this mean for GPU allocations you currently have some GFP_ACCOUNT
> > magic in your driver to attribute GPU memory to the correct remote
> > client?
>
> No, we just expose what the kernel driver has allocated for itself. E.g. =
page tables, buffers etc...
>
> When userspace allocates something using memfd_create() for example we ju=
st ignore that.


>
> > So this series would close the gap for dma-buf allocations,
> > but what about private GPU driver memory allocated on behalf of a
> > client?
>
> Well we would need a cgroup which isn't associated with any process were =
we could charge the GPU driver allocations against.

I think I better understand your framing for this now. Thanks again
for taking the time to explain.

I was looking for a way to pass cgroup around to do the charge. I
found that `struct cgroup *cgroup_get_from_fd(int fd)` already exists
in cgroups available symbols to handle cgroup directories.

So here's an idea...

Rename the charge_pid_fd to charge_fd:
- If it is a pidfd (`!IS_ERR(pidfd_pid(fget(charge_fd)))`) then we do
what we're already doing here.
- If it is a cgroup_fd (`!IS_ERR(cgroup_get_from_fd(charge_fd))`) then
we charge to that cgroup.

Also we could add add an ioctl for the generic fd path similar to what
we have for dma-buf heaps. Or have a new flavour for memfd_create:
```
memfd_create2(name, flags, charge_fd);
```

The transfer ioctl could also be made generic to accept both pidfds
and cgroup_fds.

For this series we could move forward as is, and make the generic
solution a follow-up series, knowing that the field can be reused for
cgroup fds.

>
> But good point, charging against a pid wouldn't work in this use case.
>
> Regards,
> Christian.
>

