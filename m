Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBD4CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE2110E1AB;
	Mon, 18 May 2026 12:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="A+iE65dw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8EF10E1AB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779108644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRhhMtWag6dFHgJ+9KXfvh39yjXyi0gyNukph7J5ngs=;
 b=A+iE65dwepd/3+vSRtmUf/iqrI1tMTKPLQkOHG6tYXmDxvkUlafCeCC/KLrSGhAf3vG2rz
 Fo3zoZcMDMFXCmHBXlS8F1azQjjDOQJQYc4YVFYCtu9a+2RAtAi0xJvN9rdrqiLNz4IRkn
 t8YGkqbc1bh31TZmT/BVq2u71N38ZvY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-YrBhmwCfMJyFJX4SzKuEwQ-1; Mon, 18 May 2026 08:50:42 -0400
X-MC-Unique: YrBhmwCfMJyFJX4SzKuEwQ-1
X-Mimecast-MFC-AGG-ID: YrBhmwCfMJyFJX4SzKuEwQ_1779108642
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7bd49a2467eso29197487b3.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 05:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779108642; x=1779713442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eRhhMtWag6dFHgJ+9KXfvh39yjXyi0gyNukph7J5ngs=;
 b=Us8QMMTJiD1zgRNhZMsFJirTd/4y0sazKXObWqqvkqC3CHkYBn2qHip/dh2ooDGt/+
 z0oPiGSi3cJgeKHbbDFIKZhOVm425lrhFdqS2KANz7s8D/Wug1DAmIpCS8qtwNS6eKmg
 ewvQX2h6izb2vpmBxMJT+iaAD4av+kyfnBNjKC/+saclCreGGOnUJRNZXSbFfLSlEReq
 5hPQtgKiiHdB3EfinC8mAL6sGgOuS0x9VOfoji2yyEZSsm5utwr/Oi8zUubURCJzQkcB
 QJXfVpbKdRb86tFsNehZmNoC5MoKp1PJW6LvM0N9G6dE4ZI3ba2ivYrTte3hcPuUmJ/I
 Fy4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nD9ggqUyHcGV/4Bl1zEpylduutIcYmvwTJe4+qh1mkQJ7/Acd902yqp1h0l5pkPBbuGx50ZtI1EM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7x1GzZH63DFcP8Ow5avTCg4qdej2vV9NLiUwwQhEJDwj5LDkG
 +mZEF5dtaT8gXMjFlS+G0peqTfJH15flnBjdkR4mn64riz5JodV4wh1KjOqbwTb5WMJfzrBT7yD
 AUvCAIPpeKRUQgZYjH6rhKglZct4eoiZfauYlQ97TEZ6mJc8ln0mIy3GoHtWbEDqBpdIftt8Muj
 YEiIQF2yyDj1wwh3J/aZD9qAuns2lw8OcILoja0Y3kzVdQ
X-Gm-Gg: Acq92OEm+9M9iS5mv0DvM4L80YAUNC1qWOqOmnkA6nvWDJAY2iWMX2mHvU6a5OeW+ZZ
 t10f+5Qksk50qamZHYFWc0xKkJbrw0bv6gxyl/+OcWu9y9qcbYv7GXIgcT7Wu/ZQUTeVhUPxywY
 e47yKWd0KAx1NVnw70E1q9TSVJzsRDGggneyInLRzliASaJOLOulVpsYUFvN7TvGyvVgXjVBSNn
 XAKlw==
X-Received: by 2002:a05:690c:c504:b0:7ba:f0ed:c5ea with SMTP id
 00721157ae682-7c95c202cb8mr151839347b3.39.1779108642020; 
 Mon, 18 May 2026 05:50:42 -0700 (PDT)
X-Received: by 2002:a05:690c:c504:b0:7ba:f0ed:c5ea with SMTP id
 00721157ae682-7c95c202cb8mr151838957b3.39.1779108641320; Mon, 18 May 2026
 05:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
 <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
In-Reply-To: <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 May 2026 14:50:30 +0200
X-Gm-Features: AVHnY4JVeUZbQl3fJZojeCwshobXzZdw1dcYItf6HM2iKIo4t723byYD2xZMKVg
Message-ID: <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: C4EUTFw15up9ZuGz-YATeDCQS0uICEyDCImrayadCUk_1779108642
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

On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/15/26 19:06, T.J. Mercier wrote:
> > On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> >>
> >> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>> On embedded platforms a central process often allocates dma-buf
> >>> memory on behalf of client applications. Without a way to
> >>> attribute the charge to the requesting client's cgroup, the
> >>> cost lands on the allocator, making per-cgroup memory limits
> >>> ineffective for the actual consumers.
> >>>
> >>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>
> >> Please be aware that pidfds come in two flavors:
> >>
> >> thread-group pidfds and thread-specific pidfds. Make sure that your AP=
I
> >> doesn't implicitly depend on this distinction not existing.
> >
> > Hi Christian,
> >
> > Memcg is not a controller that supports "thread mode" so all threads
> > in a group should belong to the same memcg.
>
> BTW: Exactly that is the requirement automotive has with their native con=
text use case.
>
> The use case is that you have a deamon which has multiple threads were ea=
ch one is acting on behalve of some other process.
>
> At the moment we basically say they are simply not using cgroups for that=
 use case, but it would be really nice if we could handle that as well.
>
> Summarizing the requirement of that use case: You need a different cgroup=
 for each thread of a process.

Hi Christian,

Thanks for sharing this atuomotive usecase. If I understand correctly,
the actual requirement is attributing dma-buf charges to the right
client, not putting each daemon thread in a different cgroup? If so,
the `charge_pid_fd` approach achieves this directly by passing the
client's `pid_fd`, without needing to add per-thread cgroup
infrastructure.

>
> Regards,
> Christian.
>
> >
> > Checking the flags from pidfd_get_pid would be the best way for an
> > explicit check of the pidfd type?
> >
> >>> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> >>> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> >>> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> >>> the mem_accounting module parameter enabled, the buffer is charged
> >>> to the allocator's own cgroup.
> >>>
> >>> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> >>> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> >>> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> >>> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> >>> all accounting through a single MEMCG_DMABUF path.
> >>>
> >>> Usage examples:
> >>>
> >>>   1. Central allocator charging to a client at allocation time.
> >>>      The allocator knows the client's PID (e.g., from binder's
> >>>      sender_pid) and uses pidfd to attribute the charge:
> >>>
> >>>        pid_t client_pid =3D txn->sender_pid;
> >>>        int pidfd =3D pidfd_open(client_pid, 0);
> >>>
> >>>        struct dma_heap_allocation_data alloc =3D {
> >>>            .len             =3D buffer_size,
> >>>            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> >>>            .charge_pid_fd   =3D pidfd,
> >>>        };
> >>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >>>        close(pidfd);
> >>>        /* alloc.fd is now charged to client's cgroup */
> >>>
> >>>   2. Default allocation (no pidfd, mem_accounting=3D1).
> >>>      When charge_pid_fd is not set and the mem_accounting module
> >>>      parameter is enabled, the buffer is charged to the allocator's
> >>>      own cgroup:
> >>>
> >>>        struct dma_heap_allocation_data alloc =3D {
> >>>            .len      =3D buffer_size,
> >>>            .fd_flags =3D O_RDWR | O_CLOEXEC,
> >>>        };
> >>>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >>>        /* charged to current process's cgroup */
> >>>
> >>> Current limitations:
> >>>
> >>>  - Single-owner model: a dma-buf carries one memcg charge regardless =
of
> >>>    how many processes share it. Means only the first owner (and expor=
ter)
> >>>    of the shared buffer bears the charge.
> >>>  - Only memcg accounting supported. While this makes sense for system
> >>>    heap buffers, other heaps (e.g., CMA heaps) will require selective=
ly
> >>>    charging also for the dmem controller.
> >>>
> >>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >>> ---
> >>>  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> >>>  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> >>>  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++++=
+++++++---
> >>>  drivers/dma-buf/heaps/system_heap.c     |  2 --
> >>>  include/uapi/linux/dma-heap.h           |  6 +++++
> >>>  5 files changed, 53 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
> >>> index 8bdbc2e866430..824d269531eb1 100644
> >>> --- a/Documentation/admin-guide/cgroup-v2.rst
> >>> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >>> @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> >>>               structures.
> >>>
> >>>         dmabuf (npn)
> >>> -             Amount of memory used for exported DMA buffers allocate=
d by the cgroup.
> >>> -             Stays with the allocating cgroup regardless of how the =
buffer is shared.
> >>> +             Amount of memory used for exported DMA buffers allocate=
d by or on
> >>> +             behalf of the cgroup. Stays with the allocating cgroup =
regardless
> >>> +             of how the buffer is shared.
> >>>
> >>>         workingset_refault_anon
> >>>               Number of refaults of previously evicted anonymous page=
s.
> >>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >>> index ce02377f48908..23fb758b78297 100644
> >>> --- a/drivers/dma-buf/dma-buf.c
> >>> +++ b/drivers/dma-buf/dma-buf.c
> >>> @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentr=
y)
> >>>        */
> >>>       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> >>>
> >>> -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->si=
ze) / PAGE_SIZE);
> >>> -     mem_cgroup_put(dmabuf->memcg);
> >>> +     if (dmabuf->memcg) {
> >>> +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> >>> +                                       PAGE_ALIGN(dmabuf->size) / PA=
GE_SIZE);
> >>> +             mem_cgroup_put(dmabuf->memcg);
> >>> +     }
> >>>
> >>>       dmabuf->ops->release(dmabuf);
> >>>
> >>> @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_=
buf_export_info *exp_info)
> >>>               dmabuf->resv =3D resv;
> >>>       }
> >>>
> >>> -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> >>> -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf-=
>size) / PAGE_SIZE,
> >>> -                                   GFP_KERNEL)) {
> >>> -             ret =3D -ENOMEM;
> >>> -             goto err_memcg;
> >>> -     }
> >>> -
> >>>       file->private_data =3D dmabuf;
> >>>       file->f_path.dentry->d_fsdata =3D dmabuf;
> >>>       dmabuf->file =3D file;
> >>> @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_b=
uf_export_info *exp_info)
> >>>
> >>>       return dmabuf;
> >>>
> >>> -err_memcg:
> >>> -     mem_cgroup_put(dmabuf->memcg);
> >>>  err_file:
> >>>       fput(file);
> >>>  err_module:
> >>> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> >>> index ac5f8685a6494..ff6e259afcdc0 100644
> >>> --- a/drivers/dma-buf/dma-heap.c
> >>> +++ b/drivers/dma-buf/dma-heap.c
> >>> @@ -7,13 +7,17 @@
> >>>   */
> >>>
> >>>  #include <linux/cdev.h>
> >>> +#include <linux/cgroup.h>
> >>>  #include <linux/device.h>
> >>>  #include <linux/dma-buf.h>
> >>>  #include <linux/dma-heap.h>
> >>> +#include <linux/memcontrol.h>
> >>> +#include <linux/sched/mm.h>
> >>>  #include <linux/err.h>
> >>>  #include <linux/export.h>
> >>>  #include <linux/list.h>
> >>>  #include <linux/nospec.h>
> >>> +#include <linux/pidfd.h>
> >>>  #include <linux/syscalls.h>
> >>>  #include <linux/uaccess.h>
> >>>  #include <linux/xarray.h>
> >>> @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> >>>                "Enable cgroup-based memory accounting for dma-buf hea=
p allocations (default=3Dfalse).");
> >>>
> >>>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> >>> -                              u32 fd_flags,
> >>> -                              u64 heap_flags)
> >>> +                              u32 fd_flags, u64 heap_flags,
> >>> +                              struct mem_cgroup *charge_to)
> >>>  {
> >>>       struct dma_buf *dmabuf;
> >>> +     unsigned int nr_pages;
> >>> +     struct mem_cgroup *memcg =3D charge_to;
> >>>       int fd;
> >>>
> >>>       /*
> >>> @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *=
heap, size_t len,
> >>>       if (IS_ERR(dmabuf))
> >>>               return PTR_ERR(dmabuf);
> >>>
> >>> +     nr_pages =3D len / PAGE_SIZE;
> >>> +
> >>> +     if (memcg)
> >>> +             css_get(&memcg->css);
> >>> +     else if (mem_accounting)
> >>> +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> >>> +
> >>> +     if (memcg) {
> >>> +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERN=
EL)) {
> >>> +                     mem_cgroup_put(memcg);
> >>> +                     dma_buf_put(dmabuf);
> >>> +                     return -ENOMEM;
> >>> +             }
> >>> +             dmabuf->memcg =3D memcg;
> >>> +     }
> >>> +
> >>>       fd =3D dma_buf_fd(dmabuf, fd_flags);
> >>>       if (fd < 0) {
> >>>               dma_buf_put(dmabuf);
> >>> @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *=
file, void *data)
> >>>  {
> >>>       struct dma_heap_allocation_data *heap_allocation =3D data;
> >>>       struct dma_heap *heap =3D file->private_data;
> >>> +     struct mem_cgroup *memcg =3D NULL;
> >>> +     struct task_struct *task;
> >>> +     unsigned int pidfd_flags;
> >>>       int fd;
> >>>
> >>>       if (heap_allocation->fd)
> >>> @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file =
*file, void *data)
> >>>       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> >>>               return -EINVAL;
> >>>
> >>> +     if (heap_allocation->charge_pid_fd) {
> >>> +             task =3D pidfd_get_task(heap_allocation->charge_pid_fd,=
 &pidfd_flags);
> >>
> >> Will always get a thread-group leader pidfd and will fail if this is a
> >> thread-specific pidfd. pidfd_open(1234, PIDFD_THREAD) can be used to
> >> open a thread-specific pidfd.
> >>
> >>> +             if (IS_ERR(task))
> >>> +                     return PTR_ERR(task);
> >>> +
> >>> +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> >>> +             put_task_struct(task);
> >>> +     }
> >>> +
> >>>       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> >>>                                  heap_allocation->fd_flags,
> >>> -                                heap_allocation->heap_flags);
> >>> +                                heap_allocation->heap_flags,
> >>> +                                memcg);
> >>> +     mem_cgroup_put(memcg);
> >>>       if (fd < 0)
> >>>               return fd;
> >>>
> >>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/he=
aps/system_heap.c
> >>> index 03c2b87cb1112..95d7688167b93 100644
> >>> --- a/drivers/dma-buf/heaps/system_heap.c
> >>> +++ b/drivers/dma-buf/heaps/system_heap.c
> >>> @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsig=
ned long size,
> >>>               if (max_order < orders[i])
> >>>                       continue;
> >>>               flags =3D order_flags[i];
> >>> -             if (mem_accounting)
> >>> -                     flags |=3D __GFP_ACCOUNT;
> >>>               page =3D alloc_pages(flags, orders[i]);
> >>>               if (!page)
> >>>                       continue;
> >>> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-h=
eap.h
> >>> index a4cf716a49fa6..e02b0f8cbc6a1 100644
> >>> --- a/include/uapi/linux/dma-heap.h
> >>> +++ b/include/uapi/linux/dma-heap.h
> >>> @@ -29,6 +29,10 @@
> >>>   *                   handle to the allocated dma-buf
> >>>   * @fd_flags:                file descriptor flags used when allocat=
ing
> >>>   * @heap_flags:              flags passed to heap
> >>> + * @charge_pid_fd:   optional pidfd of the process whose cgroup shou=
ld be
> >>> + *                   charged for this allocation; 0 means charge the=
 calling
> >>> + *                   process's cgroup
> >>> + * @__padding:               reserved, must be zero
> >>>   *
> >>>   * Provided by userspace as an argument to the ioctl
> >>>   */
> >>> @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> >>>       __u32 fd;
> >>>       __u32 fd_flags;
> >>>       __u64 heap_flags;
> >>> +     __u32 charge_pid_fd;
> >>> +     __u32 __padding;
> >>>  };
> >>>
> >>>  #define DMA_HEAP_IOC_MAGIC           'H'
> >>>
> >>> --
> >>> 2.53.0
> >>>
>

