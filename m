Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC764606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QXfsJqiv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C0010FC7A;
	Wed, 18 Nov 2026 13:55:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6FF710FC7A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795010137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
 b=QXfsJqivqBNqfL8AggaLxuMEBU7EfXUwQ79yX9mkY0DsyoJKv14Jj/OiqP17IwmtwHUvtm
 hDttkoYGz0xiCc9jOMzkOF5g6m+QAdI/wa8hDJ5BtVIpXff4tFeOjBu8nPrel8lbwUuT3W
 PR8WTtsSxNEPBpbDUz0KfAdFrL/sUoM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-O6IRuKcUP52ZY-0MWXmb6A-1; Wed, 18 Nov 2026 08:55:36 -0500
X-MC-Unique: O6IRuKcUP52ZY-0MWXmb6A-1
X-Mimecast-MFC-AGG-ID: O6IRuKcUP52ZY-0MWXmb6A_1795010136
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b4dca1ef03so12830337b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795010136; x=1795614936;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
 b=zZudsWubFET/7vjZz8aKhfNIlderJ30HZL6uSGmzNhPXJ50VAeFm2v5fomPbFsj7cJ
 bpe/uQBVin9rIAu9LijzENDuNJ9HY1fAEMnSYozjBPMrru0KyxfFAv6dKRrUpyjLD0xa
 WaAgKSPZ6zcNE3RlVndUUhAh1OWdf+wohKjuf3rxf8QrbtVvu+gml+1aA+nwAFzQRTzW
 /7XPFwzegZJRGN9uE8QFka1KovbQebaW1JETMNedvKUSVx2Udv2PIEtLCqXxHDYY0bf/
 5R0lYTLpT0A1ENJOcbGTQFUissyTWHIOikjjhoxQ8v5+CtAGm5qg1djZU0NE2BGV+1RG
 Z+Vg==
X-Forwarded-Encrypted: i=1;
 AL+hErEUCmYaodGrtXvUWdAtYbKCVkuYs/DBn6WyVGHLrf6XFV3t/4vkgK2NEfcCx9fjbQP+NjY8UMRgd6c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z96ULgmdlbaoBYeayRDDrW6jcrfqqfkz1zIYcjn2MDMtfeK0zzC
 IrjBVuKuyazObZwPYr0W+FLPPH4fe+ZgntCq/o7bM0aA48Kwvaoq+DyKOuz/gnbjVddQouar8dQ
 50vQANK7ns5xYDtZZQ6PVv/D9F+iA3ViChf5SofP1LKA91NFGgRHSvcxtWCZnuJc6Kjc4yLGAA/
 YNmSQuVGppzBo6GIxg2/feMbj8BSHpIFZ8A9ukMUf9gnTz
X-Gm-Gg: AZFdTZeDGq2zWYuNNrvA59ipkIlpzq6moBUAzPe5qXO+Xx/w8lTLyD0cJi8nyH6rEHv
 Me9KfAuZldHLm+l2u3sRjcNJPW8ql8+K3Ssz1E2KM8SYe2lMm29d0OTP1VuCcVYTAhvhpITa0lR
 O/P3RdCemvCX23NfRMHRD15/Y3YdDGQHqTq8hhd+DWFKSuJOgNaddeeT4J
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id
 956f58d0204a3-67dd3fdee8amr1338637d50.55.1795010135940; 
 Wed, 18 Nov 2026 05:55:35 -0800 (PST)
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id
 956f58d0204a3-67dd3fdee8amr1338592d50.55.1795010135440; Wed, 18 Nov 2026
 05:55:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
 <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
In-Reply-To: <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 18 Nov 2026 14:55:24 +0100
X-Gm-Features: Aa3M54okPSWfJ_g3ixS3iw1yy5owTDFGTKhnOXZ64bND8Gaqu8R-9XYtSNGyOOw
Message-ID: <CADSE00LVsFVOmezzLgPrPWDd+L+SSGzGvqKTiX25waxRnVPh9Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
To: Paul Moore <paul@paul-moore.com>
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
 Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
 echanude@redhat.com, mripard@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VTR8MJSsNahluRlGuAAdGI2pL-EupRkvb2mWImM_eK4_1795010136
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> > accept a charge_fd field that, when set, causes the allocation to be
> > charged to an arbitrary process's cgroup rather than the caller's.
> >
> > Charging is currently limited to the caller's own memcg subtree unless
> > the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing=
.
> > A process holding it, along with a dma-heap device node or a dma-buf
> > fd can charge unlimited memory to any other process's cgroup, potential=
ly
> > exhausting that cgroup's limit and triggering OOM kills independent of
> > the victim's own activity or privileges.
> >
> > Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> > when charge_fd refers to another process. The hook receives
> > the credentials of the allocating process (from) and the credentials
> > of the process whose cgroup will be charged (to), giving security
> > modules a controlled enforcement point for cross-cgroup objcg
> > attribution policy.
> >
> > When CONFIG_SECURITY is not set the hook compiles to an inline
> > returning 0, adding no overhead to the fast path.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  7 +++++++
> >  mm/memcontrol.c               | 11 +++++++++++
> >  security/security.c           | 15 +++++++++++++++
> >  4 files changed, 34 insertions(+)
>
> ...
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 03cd90d5e623..2e6fcbe14d43 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -60,6 +60,7 @@
> >  #include <linux/lockdep.h>
> >  #include <linux/resume_user_mode.h>
> >  #include <linux/psi.h>
> > +#include <linux/security.h>
> >  #include <linux/seq_buf.h>
> >  #include <linux/sched/isolation.h>
> >  #include <linux/kmemleak.h>
> > @@ -3198,10 +3199,12 @@ static bool mem_cgroup_may_charge(struct mem_cg=
roup *memcg)
> >  struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> >  {
> >       struct cgroup_subsys_state *css;
> > +     const struct cred *tcred;
> >       struct obj_cgroup *objcg;
> >       struct mem_cgroup *memcg;
> >       struct task_struct *task;
> >       unsigned int pidfd_flags;
> > +     int ret;
> >
> >       if (mem_cgroup_disabled())
> >               return ERR_PTR(-EOPNOTSUPP);
> > @@ -3226,6 +3229,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd=
)
> >               if (IS_ERR(task))
> >                       return ERR_CAST(task);
> >
> > +             tcred =3D get_task_cred(task);
> > +             ret =3D security_memcg_charge_task(current_cred(), tcred)=
;
>
> Do you ever envision this "from" cred being something other than
> current_cred()?

Good point. No, I do not.

> If the answer is "no", we might want to consider changing
> the LSM hook slightly to help prevent misuse in the future:
>
>   int security_current_memcg_charge_task(const struct cred *tcred);

Agreed. I'll apply the same to the cgroupfd variant for symmetry (its
"from" is also always current_cred()).

BR,
Albert.


>
> > +             put_cred(tcred);
> > +             if (ret) {
> > +                     put_task_struct(task);
> > +                     return ERR_PTR(ret);
> > +             }
> > +
> >               rcu_read_lock();
> >               css =3D task_css(task, memory_cgrp_id);
> >               put_task_struct(task);
>
> --
> paul-moore.com
>

