Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FD606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtOFRBsC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D381F10E160;
	Wed, 25 Nov 2026 16:14:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758CB10E160
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795623256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
 b=UtOFRBsCKAK3E8Bsu3A8rziiu4/aqAhE/qioSN+enl9xu6asu7MYmZxBpWnwgM6JAJ10eH
 GeuaMt0x+rQF7dmkSzy8byorSs4CqhqwSkdzDKJ4NU36OhlMRXg42v6WqTsD7ri9JlJGwU
 zmrSWBx/pnkzJtxscC6RhgstvSiYf98=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-DYgbuRE_P5S4IK1Q1dWl0A-1; Wed, 25 Nov 2026 16:14:14 +0000
X-MC-Unique: DYgbuRE_P5S4IK1Q1dWl0A-1
X-Mimecast-MFC-AGG-ID: DYgbuRE_P5S4IK1Q1dWl0A_1795623254
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4c7f887ac6bso10192905b6e.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795623254; x=1796228054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
 b=02lmi0h56qeKLdk1fYcOKr5FD83F9Br8r/t29ZLWfmtY57MZfMZL84SDNNNQrzAynL
 8UEXgEXKCYRwYuTxwbIwx8L5yqmJghx/7QkNyKYfv0tB6uIWxgI3t2PJ8a2xJREP5uPC
 cKaIerKh9BzaT3kzxi5+m4SlAGH3yyMH+egQvgnktM5xwiAhikoDqbQwL98fChKP0L1k
 oIhIhb7FKm/uaNhM+xeL33yPpfmsLgqQOCA5gTvVoNax+R5IOudCtZu+bno1iYFntHr9
 geXYIdOgLApf2UaIwRbH0BcJJd0L+HWYb8ZO+yGGFpQezRXrZPM0D652V94wkcLbWvfj
 qFpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF7qHii5vrbWhyWnCLal7HlnPyK58qGB5A4/9CLEY87aMqgYj+RvQqLvKC7ASxwr5WDnUv76Aiu2Bo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+nzQjeqmQe5naIgKWlbR+mhGS+gdKBc2BZRJQWmfmcM/5OWe9/
 6Bu7GG5OKCAzYHtoQZsHWYuomJTBIELOnrhX0V3pIrTlQ/YzVA3fYiVNymHuG6YLb7mJKhQraJ4
 xU2S1ODSGX5+wG14JJtTLNx3e2gZqswcTLwmpe9S6CBhKtl/FGoESmc6dRQqJ8qeWFbV50ZAt4J
 GG6jS7iX1waM8mAvBdCjPbS1QHqT9JkWrPkY1vRvpMzjHr
X-Gm-Gg: AZFdTZe4wOHBjVp2uiMX4oxZGEQd90YrTHgAQGW8NpXfydX29OHarMIj//CDRIMlfiY
 Zu/L1mxG/dAHayNCwAMYsk/YwCajqv22p6EKawWfiat2npby0alSk+aJhxRdHQxqK68rtKFNoMt
 IN7Jg4LVa2ru/BzGKMqWGypJpEwluyfKwyWpsbN5aFNxTluD+QsYDuvcZz
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id
 5614622812f47-57a0ac33d63mr20058882b6e.44.1795623253432; 
 Wed, 25 Nov 2026 08:14:13 -0800 (PST)
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id
 5614622812f47-57a0ac33d63mr20058815b6e.44.1795623252854; Wed, 25 Nov 2026
 08:14:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com>
 <sashiko-outbox-233444@kernel.org>
In-Reply-To: <sashiko-outbox-233444@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 25 Nov 2026 17:13:58 +0100
X-Gm-Features: Aa3M54qC4BhV46Zvi5xNNVUyWvQwOqnECHDuj67-iKiUZ4P0AUQ6JhGMrN001Kw
Message-ID: <CADSE00KEAYZ+saAoTY81VNhNyevsWFD_nSDNgsPVfvvLBsE5vQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dma-heap: charge dma-buf memory via explicit memcg
To: sashiko-reviews@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
 echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xt2UrezDihAiP2lnQk93sCQQLfbk2P0fgib1K0NKzPc_1795623254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 2:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm: memcontrol: task_css() race with migration in
>   get_obj_cgroup_from_fd()
> --
>
> commit 62e5304eba9bb9d84f6229eddf1a9273649483b8
> Author: Albert Esteve <aesteve@redhat.com>
>
> dma-heap: charge dma-buf memory via explicit memcg
>
> This commit adds a charge_fd field to struct dma_heap_allocation_data so
> DMA_HEAP_IOCTL_ALLOC can resolve a target cgroupfd or pidfd via
> get_obj_cgroup_from_fd() and charge system heap allocations to that
> cgroup.
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e4a9af2fdaa3b..7826bc21bea9e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> [ ... ]
> > @@ -3171,6 +3172,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(con=
st struct folio *folio)
> >       return objcg;
> >  }
> >
> [ ... ]
> > +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> > +{
> > +     struct cgroup_subsys_state *css;
> > +     struct obj_cgroup *objcg;
> > +     struct mem_cgroup *memcg;
> > +     struct task_struct *task;
> > +     unsigned int pidfd_flags;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
> > +     CLASS(fd_raw, f)(fd);
> > +     if (fd_empty(f))
> > +             return ERR_PTR(-EBADF);
> > +
> > +     css =3D css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
> > +                                      &memory_cgrp_subsys);
> > +     if (!IS_ERR(css) && !cgroup_on_dfl(css->cgroup)) {
> > +             css_put(css);
> > +             css =3D ERR_PTR(-EBADF);
> > +     }
> > +
> > +     if (IS_ERR(css)) {
> > +             if (PTR_ERR(css) !=3D -EBADF)
> > +                     return ERR_CAST(css);
> > +
> > +             /* fd is a pidfd */
> > +             task =3D pidfd_get_task(fd, &pidfd_flags);
> > +             if (IS_ERR(task))
> > +                     return ERR_CAST(task);
> > +
> > +             rcu_read_lock();
> > +             css =3D task_css(task, memory_cgrp_id);
> > +             put_task_struct(task);
> > +             if (!css || !css_tryget_online(css)) {
> > +                     rcu_read_unlock();
> > +                     return ERR_PTR(-ENOENT);
> > +             }
> > +             rcu_read_unlock();
> > +     }
>
> [Severity: Low]
> Can the pidfd lookup in get_obj_cgroup_from_fd() spuriously fail with
> -ENOENT when the target task is concurrently migrated or has an exited
> thread-group leader?
>
> Between task_css() and css_tryget_online(), the task can be migrated to
> another cgroup and its previous cgroup offlined, causing the one-shot
> css_tryget_online() on the stale css to fail.  Also, pidfd_get_task() on
> a process pidfd returns the thread-group leader, which in a
> multi-threaded process may already have PF_EXITING set and remain
> attached to an offline css even while its obj_cgroup has been reparented
> to an online ancestor that get_obj_cgroup_from_memcg() walks up to:
>
> include/linux/cgroup.h:task_get_css() {
>         rcu_read_lock();
>         while (true) {
>                 css =3D task_css(task, subsys_id);
>                 /*
>                  * Can't use css_tryget_online() here.  A task which has
>                  * PF_EXITING set may stay associated with an offline css=
.
>                  * If such task calls this function, css_tryget_online()
>                  * will keep failing.
>                  */
>                 if (likely(css_tryget(css)))
>                         break;
>                 cpu_relax();
>         }
>         rcu_read_unlock();
>         return css;
> }

Valid. I will apply this for the next version.

>
> Using task_get_css(task, memory_cgrp_id) before put_task_struct(task)
> would avoid both failure modes.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_20230=
123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com?part=3D2
>

