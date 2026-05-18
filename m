Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AD9CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 22:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A2010E09B;
	Mon, 18 May 2026 22:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nTTN3vFX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D1710E09B
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:43:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AA6FC4451F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87017C2BCB7
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779144218;
 bh=ZqxlUv6AphBiZDSxvrCBSCRC+/VdjzoWlIzND7rNfMs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nTTN3vFXwxkfBS/2diN6IbZTP+fnH/T8FI57XIZGAO3FwpjPhvbx8RkqrZbC8ZFny
 w0CTYVupfTF1PxaWyksrncAABDZgMf0CsrWEZVJcONhx0u5eRQSHUJkzEAgUfxTlTc
 TjcJu1uys5Rz/+NZlGn4OJMjLDyVvp2Bgid8g+MEj2FoR02tepl95QTjFwWDxfmbnU
 iJlYDCPdbch72+TN2b/JFGuDSuckVFSTYqbjgXo+Fc/WDdFIpj4UDZEsy0DroMLdDd
 WUNA1Mf58ShT5mhH7O13rSyfQeSo1ya9ZPgbrV5tATX4E9HRL35JIGM6VKgNHc8EzH
 Mnkq9OHVwsW8Q==
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-631a7868228so2152659137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/xXIr9oiuKnKb1j5b8kbt0X741okpmDh6+1o2hFi3Ae93ilMftnFGhHpXzLD/4lQYa56ke8i4VIpc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQn6wwSQHmk9Z+DxfvQ42t+gH1E11rzrqIbMPRyzhvsc/DpYBH
 OwO7gKspTgDx/peZqVYDxgqJMMyX/gDe5Is3ta6Q6UeEsrdrEQ+T5a6aPUi6irSyBB+strBhruy
 AfYsAGi+vSYt0caQYAX2pOV7Z0sX1SrU=
X-Received: by 2002:a05:6102:1497:b0:632:eef7:4b7f with SMTP id
 ada2fe7eead31-63a3f38ed3dmr9090434137.22.1779144217888; Mon, 18 May 2026
 15:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
 <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
In-Reply-To: <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 06:43:26 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
X-Gm-Features: AVHnY4KEVuNU5LGUxbEGufPnQvVfof22PSDgrj8C9uNhmMZb-wsisqSstH9JT8s
Message-ID: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Albert Esteve <aesteve@redhat.com>
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

On Mon, May 18, 2026 at 8:16=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> wr=
ote:
> >
> > On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.c=
om> wrote:
> > >
> > > On embedded platforms a central process often allocates dma-buf
> > > memory on behalf of client applications. Without a way to
> > > attribute the charge to the requesting client's cgroup, the
> > > cost lands on the allocator, making per-cgroup memory limits
> > > ineffective for the actual consumers.
> > >
> > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > the mem_accounting module parameter enabled, the buffer is charged
> > > to the allocator's own cgroup.
> > >
> > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> > > all accounting through a single MEMCG_DMABUF path.
> > >
> > [...]
> >
> > > -               if (mem_accounting)
> > > -                       flags |=3D __GFP_ACCOUNT;
> >
> > Hi Albert,
> >
> > would it be better to move this and its description to patch 1? It
> > looks like patch 1 already introduces the double accounting changes,
> > and patch 2 is mainly just supporting remote charging.
>
> Hi Barry,
>
> Thanks for looking into this series! Yes, in my head I was trying to
> keep patch 1, which was taken from a previous, different series, and
> then diverge from it starting with patch 2. This would clarify the
> difference between the two. But I can see it just added some confusion
> (for example, patch 1 charges on dma_buf_export() and then it is moved
> to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
> for the next version, including your suggestion.

Yep, I understand the situation now. I also understand
that you were referring to T.J.'s patch, which caused
some back-and-forth confusion for readers when reading
patches 1 and 2.

>
> >
> > Also, mem_accounting is only used by system_heap.c; has this patchset
> > also eliminated its need?
>
> No, mem_accounting is still handled in this patch for the general case
> where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:
>
> +       if (memcg)
> +               css_get(&memcg->css);
> +       else if (mem_accounting)
> +               memcg =3D get_mem_cgroup_from_mm(current->mm);

I see. What feels a bit odd to me is that mem_accounting
could either be dropped (with unconditional charging), or
it should cover both remote and local charge cases.

I don=E2=80=99t have a strong opinion here=E2=80=94it just feels a bit
strange, since its description is quite generic for memcg:

"Enable cgroup-based memory accounting for dma-buf heap
allocations (default=3Dfalse)."

Best Regards
Barry
