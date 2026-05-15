Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174E1CD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 17:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E8E10E426;
	Fri, 15 May 2026 17:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cRh8b3zK";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9411C10E426
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 17:07:05 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4891b4934ffso585e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 10:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778864824; cv=none;
 d=google.com; s=arc-20240605;
 b=j8C9unPGIiZjV0iUe1cw1jZ7Znt3J+g9jIMa4ekeptjuwtxozr1ALiwvhYBzU5DBwD
 UtSjMK8nYKwlXTSCMtN8yqAkJHedWaNoe8z6wTVtLUqzujIbH2yuO/DZ6e7XX2iX7FUr
 xcR1fuOcTojnb0BzP/wQFpGP1cdlYp4Q12g+pf2Jj7PrarlsS+rgJXoFGVyP1OVkcHo8
 /qJG5voEHTjU6Jf9fPO9lSCEcmUoLfNvyWoUjY+v/BDIMnG0QVth4ot5m3jcOilvG2sz
 iSKRZquqzVZnm92ilN/9A0dCJMtKXpGYcm3tYYRBWTub1JOvcFyLENJGC2co8oGpDfPD
 IwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LQnzcBlc7+y3xboPXu3CAuDhwWayfDkxWRZzNgig+eE=;
 fh=E2aecF184+SZIaIGVyMus47hDFNOEFRnf+AmL73XUCY=;
 b=NIk49/g5pOip1LzsgEpfvKwxTeSfVNEBoLXE+dEpEugOORw6DwOUIiD8EW2fKAAU85
 UP+V9/CxvDx1m21K2D/uH/GICV2tm2ONKUFPpniH4K9s7ZZzvzzpch94rjAhMMRJkQlP
 lJ4zfpuQjS8p6TyVZwR0/HWHwBugm7SjIeFqH61iQfXumq/alsupA1t+90MaVcOdEuIj
 lpXnOfEa/B0pwtYV/wJcmah0/Fg9RgyUqVK8fCYmnPACOaa74L3Dnr6+0HsyBx6Yce0b
 wkT40v69KZy6si3GS4/mBPKTBsrS5CV5CEoxTM1kn1tBN/roRsV1umAxvHYmq448AmYL
 MDBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778864824; x=1779469624;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQnzcBlc7+y3xboPXu3CAuDhwWayfDkxWRZzNgig+eE=;
 b=cRh8b3zKJpdOlVBtZYohbCvdF9wlYY330GtJjgefkrMg9o+IMJXl220eCdTnFjoE+x
 jEMaESKQRWWo6OFJWx4HyR/EZHV+VoFejOP6fBuTqPYmT7A7KpcnEt/Epf2m8pKmVPrp
 W7hqr7z18s6fcunWEUaGcR9R9/bMl0qzeiZMx5kbte8xqa3eRVntNGS9iJgSrMxN8IQc
 i4455WSJVt9p8Zk2/9/zLTWZpAWvQgtoMm3ohTs4PRTPt7Ux69qB6ba+HTfWNIJDkdUE
 dfvXOANsJ/4sCli+b32IGE1+vQsX7qvBtfe1G23U64R4MUoG43m+XVjrvZsgQMZVYEy8
 V/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864824; x=1779469624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LQnzcBlc7+y3xboPXu3CAuDhwWayfDkxWRZzNgig+eE=;
 b=UXqGVSYIvtzvT0eNMrvhA6XAMdlnmD090FCihT6FiBbyCu2iSu9PW+7MTj9Qs/NmOk
 kEmrGHclkS5YFV6iyEy0Wrr2T9YvIGX20He5ArFKInDvh73N1yxK44TbwukarmuFVYVN
 18mpXUkYUJ9+R0ftlhNkuGSTj5C/9nRlCBM7B3yaSbSkJyNrKXhtOte9LfuCMhI9mqJ4
 iwybVTTcsmZ1vNVVbikWNO436DUbKYmsQRxZdEc1qb6XzYmVhqnDwmcfG+naNyzH67CT
 ofk76rC5He2EnD+Vyzd30Of0pt/q3j8SCvEkVCfG6gnbOIo+J0j8Q5DvujsYyoC5iCS2
 lTYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eEm6h1ZNy/P5uSCR5pr4rjZUAK/BqhOwrhySLPxqeabpDLHyXOuWRvpZXllPeJDjwRWNyDyIOEDU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvxCfbemH9Zxh3ATdNUhLBAImrtTxZGiUWZB3aTqjUEieBmLlD
 QTgzEajTby2TnMDU2R/CO3LQCPjMEnOP812RL7CLo2et86HNLiE5v8SVApZ06bikrBnxvoTQyJQ
 CmLT/7TYNKIRUWivtCFspyH6Kz2ocGubXGBs4PKno
X-Gm-Gg: Acq92OEeP9AxzTjx349IgJ5MMMNweElRqB0S6vJCrrvkoZOEVKYQt5hXpo4j0zxb3xw
 1esxrAQ94gefd0whxyGbPWjCN0iCVF9VVTIM7RbxKoMhseRSjE5uzvyd+ff/xPdw6+3gy9qFMH9
 oZnoiqP88t/WzDiIV/lkDGrhOqYFQsDG4rmNQ/Y78JqTHs8+qo+elADtM6GSrjescy3LBazqIkW
 ZLxvpRZi8NzuSN/8f6jPHAVfqUIBKygJRRF6LKnJwuxdNAgzL0S0RRBmhKK8KbR2dj8zp1Cax0M
 O0+pc95LJJ1mt0VX3S9nuQSyPDFUFbeGyV8wNGgwfEIzJg+U
X-Received: by 2002:a05:600c:4999:b0:489:1adc:f017 with SMTP id
 5b1f17b1804b1-48fe881e582mr645715e9.5.1778864823481; Fri, 15 May 2026
 10:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
In-Reply-To: <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 15 May 2026 10:06:50 -0700
X-Gm-Features: AVHnY4LllvNrEvKpMMJyjJvPlkuCoR7DSmB99jM3FHC68bpYwfg1MyASdUtT0JM
Message-ID: <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Christian Brauner <brauner@kernel.org>
Cc: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
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

On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> > On embedded platforms a central process often allocates dma-buf
> > memory on behalf of client applications. Without a way to
> > attribute the charge to the requesting client's cgroup, the
> > cost lands on the allocator, making per-cgroup memory limits
> > ineffective for the actual consumers.
> >
> > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
>
> Please be aware that pidfds come in two flavors:
>
> thread-group pidfds and thread-specific pidfds. Make sure that your API
> doesn't implicitly depend on this distinction not existing.

Hi Christian,

Memcg is not a controller that supports "thread mode" so all threads
in a group should belong to the same memcg.

Checking the flags from pidfd_get_pid would be the best way for an
explicit check of the pidfd type?

> > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > the mem_accounting module parameter enabled, the buffer is charged
> > to the allocator's own cgroup.
> >
> > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> > all accounting through a single MEMCG_DMABUF path.
> >
> > Usage examples:
> >
> >   1. Central allocator charging to a client at allocation time.
> >      The allocator knows the client's PID (e.g., from binder's
> >      sender_pid) and uses pidfd to attribute the charge:
> >
> >        pid_t client_pid =3D txn->sender_pid;
> >        int pidfd =3D pidfd_open(client_pid, 0);
> >
> >        struct dma_heap_allocation_data alloc =3D {
> >            .len             =3D buffer_size,
> >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> >            .charge_pid_fd   =3D pidfd,
> >        };
> >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >        close(pidfd);
> >        /* alloc.fd is now charged to client's cgroup */
> >
> >   2. Default allocation (no pidfd, mem_accounting=3D1).
> >      When charge_pid_fd is not set and the mem_accounting module
> >      parameter is enabled, the buffer is charged to the allocator's
> >      own cgroup:
> >
> >        struct dma_heap_allocation_data alloc =3D {
> >            .len      =3D buffer_size,
> >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> >        };
> >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> >        /* charged to current process's cgroup */
> >
> > Current limitations:
> >
> >  - Single-owner model: a dma-buf carries one memcg charge regardless of
> >    how many processes share it. Means only the first owner (and exporte=
r)
> >    of the shared buffer bears the charge.
> >  - Only memcg accounting supported. While this makes sense for system
> >    heap buffers, other heaps (e.g., CMA heaps) will require selectively
> >    charging also for the dmem controller.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> >  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> >  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++++++=
+++++---
> >  drivers/dma-buf/heaps/system_heap.c     |  2 --
> >  include/uapi/linux/dma-heap.h           |  6 +++++
> >  5 files changed, 53 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 8bdbc2e866430..824d269531eb1 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> >               structures.
> >
> >         dmabuf (npn)
> > -             Amount of memory used for exported DMA buffers allocated =
by the cgroup.
> > -             Stays with the allocating cgroup regardless of how the bu=
ffer is shared.
> > +             Amount of memory used for exported DMA buffers allocated =
by or on
> > +             behalf of the cgroup. Stays with the allocating cgroup re=
gardless
> > +             of how the buffer is shared.
> >
> >         workingset_refault_anon
> >               Number of refaults of previously evicted anonymous pages.
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index ce02377f48908..23fb758b78297 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
> >        */
> >       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> >
> > -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size=
) / PAGE_SIZE);
> > -     mem_cgroup_put(dmabuf->memcg);
> > +     if (dmabuf->memcg) {
> > +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> > +                                       PAGE_ALIGN(dmabuf->size) / PAGE=
_SIZE);
> > +             mem_cgroup_put(dmabuf->memcg);
> > +     }
> >
> >       dmabuf->ops->release(dmabuf);
> >
> > @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_bu=
f_export_info *exp_info)
> >               dmabuf->resv =3D resv;
> >       }
> >
> > -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> > -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->s=
ize) / PAGE_SIZE,
> > -                                   GFP_KERNEL)) {
> > -             ret =3D -ENOMEM;
> > -             goto err_memcg;
> > -     }
> > -
> >       file->private_data =3D dmabuf;
> >       file->f_path.dentry->d_fsdata =3D dmabuf;
> >       dmabuf->file =3D file;
> > @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf=
_export_info *exp_info)
> >
> >       return dmabuf;
> >
> > -err_memcg:
> > -     mem_cgroup_put(dmabuf->memcg);
> >  err_file:
> >       fput(file);
> >  err_module:
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index ac5f8685a6494..ff6e259afcdc0 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -7,13 +7,17 @@
> >   */
> >
> >  #include <linux/cdev.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-heap.h>
> > +#include <linux/memcontrol.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/list.h>
> >  #include <linux/nospec.h>
> > +#include <linux/pidfd.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/xarray.h>
> > @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> >                "Enable cgroup-based memory accounting for dma-buf heap =
allocations (default=3Dfalse).");
> >
> >  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > -                              u32 fd_flags,
> > -                              u64 heap_flags)
> > +                              u32 fd_flags, u64 heap_flags,
> > +                              struct mem_cgroup *charge_to)
> >  {
> >       struct dma_buf *dmabuf;
> > +     unsigned int nr_pages;
> > +     struct mem_cgroup *memcg =3D charge_to;
> >       int fd;
> >
> >       /*
> > @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *he=
ap, size_t len,
> >       if (IS_ERR(dmabuf))
> >               return PTR_ERR(dmabuf);
> >
> > +     nr_pages =3D len / PAGE_SIZE;
> > +
> > +     if (memcg)
> > +             css_get(&memcg->css);
> > +     else if (mem_accounting)
> > +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> > +
> > +     if (memcg) {
> > +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL=
)) {
> > +                     mem_cgroup_put(memcg);
> > +                     dma_buf_put(dmabuf);
> > +                     return -ENOMEM;
> > +             }
> > +             dmabuf->memcg =3D memcg;
> > +     }
> > +
> >       fd =3D dma_buf_fd(dmabuf, fd_flags);
> >       if (fd < 0) {
> >               dma_buf_put(dmabuf);
> > @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *fi=
le, void *data)
> >  {
> >       struct dma_heap_allocation_data *heap_allocation =3D data;
> >       struct dma_heap *heap =3D file->private_data;
> > +     struct mem_cgroup *memcg =3D NULL;
> > +     struct task_struct *task;
> > +     unsigned int pidfd_flags;
> >       int fd;
> >
> >       if (heap_allocation->fd)
> > @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *f=
ile, void *data)
> >       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> >               return -EINVAL;
> >
> > +     if (heap_allocation->charge_pid_fd) {
> > +             task =3D pidfd_get_task(heap_allocation->charge_pid_fd, &=
pidfd_flags);
>
> Will always get a thread-group leader pidfd and will fail if this is a
> thread-specific pidfd. pidfd_open(1234, PIDFD_THREAD) can be used to
> open a thread-specific pidfd.
>
> > +             if (IS_ERR(task))
> > +                     return PTR_ERR(task);
> > +
> > +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> > +             put_task_struct(task);
> > +     }
> > +
> >       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> >                                  heap_allocation->fd_flags,
> > -                                heap_allocation->heap_flags);
> > +                                heap_allocation->heap_flags,
> > +                                memcg);
> > +     mem_cgroup_put(memcg);
> >       if (fd < 0)
> >               return fd;
> >
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heap=
s/system_heap.c
> > index 03c2b87cb1112..95d7688167b93 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigne=
d long size,
> >               if (max_order < orders[i])
> >                       continue;
> >               flags =3D order_flags[i];
> > -             if (mem_accounting)
> > -                     flags |=3D __GFP_ACCOUNT;
> >               page =3D alloc_pages(flags, orders[i]);
> >               if (!page)
> >                       continue;
> > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-hea=
p.h
> > index a4cf716a49fa6..e02b0f8cbc6a1 100644
> > --- a/include/uapi/linux/dma-heap.h
> > +++ b/include/uapi/linux/dma-heap.h
> > @@ -29,6 +29,10 @@
> >   *                   handle to the allocated dma-buf
> >   * @fd_flags:                file descriptor flags used when allocatin=
g
> >   * @heap_flags:              flags passed to heap
> > + * @charge_pid_fd:   optional pidfd of the process whose cgroup should=
 be
> > + *                   charged for this allocation; 0 means charge the c=
alling
> > + *                   process's cgroup
> > + * @__padding:               reserved, must be zero
> >   *
> >   * Provided by userspace as an argument to the ioctl
> >   */
> > @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> >       __u32 fd;
> >       __u32 fd_flags;
> >       __u64 heap_flags;
> > +     __u32 charge_pid_fd;
> > +     __u32 __padding;
> >  };
> >
> >  #define DMA_HEAP_IOC_MAGIC           'H'
> >
> > --
> > 2.53.0
> >
