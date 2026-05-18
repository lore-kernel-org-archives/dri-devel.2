Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D5CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E9A10E9DF;
	Mon, 18 May 2026 23:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SjloN+ya";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035B410E9DF
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:39:31 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488940ccfa6so885e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147569; cv=none;
 d=google.com; s=arc-20240605;
 b=LTpS7lwbuM8qqyp1odoSDJMpsUlYhtuUZBOAUrI5grSbWXFCnoPVedCVLMyCkM/B0Q
 lytk5hMCLZkgxF7vAFJkkIVOoplhs6oQGsWXnaDZUC2j5XA0k8f703to5AYS3DfsF6cU
 Jnso93DAaii/6leYlKYw20sq5iJaRYYU1K4T8gcN4Nsul8wGuuo7i1E8PqfEJcaFuiwq
 fCa62wLq1Z8kL3FTGbEsBenpqFjC21gu1lHPm8tDBt7KYzIMdGMjNDmuS6Ns8/BJGWVo
 oiqIkEMU2XBfd1VVTB9dAzj6LwoIenAQ0lx9VsP6xCIB/NLfedv+4mjXpqPhh9e0JShb
 9xKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
 fh=IWT+aHwOHdURW7UnkRaRNEkPpavzu4jS7Jd1u81IgE0=;
 b=F86FWhjWWo1pgusNrAAblddw5Ypr7ayNknvp1I2dZVDFXlDo9bL+FUaLq1DczH0TnW
 ggSZoTFf18wiBRkPrfzFnIFvyy5NlBb37k+VXnI+Kj4JFlA5eygVs+OhCMO5daQun+TO
 8W+tqmkvNAsrflDM1jnLS5ZHtCBAJGVg83ja22VJy8FPOQ1pdJVjrqy9eD5fWudOi451
 x5NxmCwJHOlV8g6LAWs1G9N4iAvra2rw8nTmcG60aqVWcX+cRU70g6XWd9tH2Ldpcp+e
 DsciqLtyPmxTQodqeHcpsbgDmHldbe4bEfwAsX3vbIvujy1bUju+2829qNvIM+wV7h7/
 PAZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779147569; x=1779752369;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
 b=SjloN+yactRvg+MTXYZRz6Cn756wKBuk3jkXfb/Pu36iLrbJegXH5D3f51iMLBwCJn
 m4dNEw2lZCTJSr4isUJ3BNhbwkGuWS9nYAP/IQpniAIvmI/ulzbGEXICSqmprFbZz2xh
 lhpO6LpuVuGROPs6e+cGeMATKaU8CRULbxOHaRGcxR0yAt3rUN5nA2cWm3mrqdvuTcqB
 xMdpEbdZ5qFKRK2KIBayWb9POKzbaqXR9muIuD5b9NGfuYonuTWcs8MMaz+5K5VgSuAe
 T0aFnCnuacMBl2gXmilYvmtNRzyJssKqX7ZXdNpeGEjr9ay9qMID5EcVVwDIdfuX4t3u
 I9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779147569; x=1779752369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
 b=ZON4CEyDofyOAXAK8cdbHihs23z331XsqeFXdZstodjQtu0qpg/H0Noajxs6dkSYyr
 bFTDjJeNOiR+xR6gTdSyikVV45g4e2aEVSAjePNx4nMxHc6QUN1ttW1JMVk2GvVuoi3p
 QyXLbdAxx/K3fZXi2Mxj1oMFc7a0t3wk9nMFZTWxR+142aFTrgGV2aToHd+hNImuApI9
 BCSncnMojekRU2UI8TCq4jYwCZeFZIuKLV5DWAx3rxtu+sxt3sbDVyKgK90vRdlzL7ZT
 MkFtZ0wiXdMfpYg7PCZwRiqDxWPKrSWcN7xb88agth0k07F3m961U0MF7WiUsz6yrYsP
 jt2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TiUM3p6D/V64Oas4Mo4J2sEVvA8rHx4AArGKF1eS7WXy8/vFFKE58KmtPUVZr12FV1uTUHC5DJz0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrQLswWUjbLZk1ZHsqNy3DyQS23+KjV2z0jnZH2AFDAsrCRDaw
 xMywp9KsGp77+tQJXUrmCnnxAG0y4fTM1rkQDfYNvZZjBtxFFaLPVKQIP2Ri6rniqG3dvGhLcDK
 SfbRRZo7jHWAyv1lAcJCMdvAHHduaCqa5+Np/BurY
X-Gm-Gg: Acq92OENSGKgdjy6d/gQPwNLLXwMko5TDycpxGCLadJBMFBq25X6umpYiGwuYAP7nX7
 wUimnq3ISLMTe/C+jLZxkkxlcbZsPPG2J7fOm60ibpSbIG+hioAxOD22z6PSTNp0vuTvkuzzf59
 k+GcgjGxrciWjNkFGD0xufDk+oalntNls0oVCHBLnJiZ7hHOiE4nwucJjuJeqohYuw2TamcvQ2B
 kqzIyZ7Otde/ylxaEoOpS0bulBy4oKtStaOJat3+t1piUZWF58qDgRjeeJ41EQ+TbBt7+Vchc5u
 iEAxgKNnVvxOuuKc1YhvsSVrHPH9FnWx72jMZgCO269iWD9K
X-Received: by 2002:a05:600c:828f:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-48ffa06d607mr3320695e9.0.1779147569161; Mon, 18 May 2026
 16:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
 <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
 <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:14 -0700
X-Gm-Features: AVHnY4JenMsTlW8PdrNyXvGhnvZE3E4HsfXXDBDrw2kB1e9N8h1WWqyjOLM9WZU
Message-ID: <CABdmKX2+PqZJc588dL7Yp7hYDnfXw7LRCKfLJ6n5=faKBvWBWg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
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

On Mon, May 18, 2026 at 3:43=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Mon, May 18, 2026 at 8:16=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> =
wrote:
> > >
> > > On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat=
.com> wrote:
> > > >
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
> > > [...]
> > >
> > > > -               if (mem_accounting)
> > > > -                       flags |=3D __GFP_ACCOUNT;
> > >
> > > Hi Albert,
> > >
> > > would it be better to move this and its description to patch 1? It
> > > looks like patch 1 already introduces the double accounting changes,
> > > and patch 2 is mainly just supporting remote charging.
> >
> > Hi Barry,
> >
> > Thanks for looking into this series! Yes, in my head I was trying to
> > keep patch 1, which was taken from a previous, different series, and
> > then diverge from it starting with patch 2. This would clarify the
> > difference between the two. But I can see it just added some confusion
> > (for example, patch 1 charges on dma_buf_export() and then it is moved
> > to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
> > for the next version, including your suggestion.
>
> Yep, I understand the situation now. I also understand
> that you were referring to T.J.'s patch, which caused
> some back-and-forth confusion for readers when reading
> patches 1 and 2.

Albert, please don't feel obligated to keep my patch intact if
integrating it into other patches simplifies the series.

> > > Also, mem_accounting is only used by system_heap.c; has this patchset
> > > also eliminated its need?
> >
> > No, mem_accounting is still handled in this patch for the general case
> > where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:
> >
> > +       if (memcg)
> > +               css_get(&memcg->css);
> > +       else if (mem_accounting)
> > +               memcg =3D get_mem_cgroup_from_mm(current->mm);
>
> I see. What feels a bit odd to me is that mem_accounting
> could either be dropped (with unconditional charging), or
> it should cover both remote and local charge cases.
>
> I don=E2=80=99t have a strong opinion here=E2=80=94it just feels a bit
> strange, since its description is quite generic for memcg:
>
> "Enable cgroup-based memory accounting for dma-buf heap
> allocations (default=3Dfalse)."
>
> Best Regards
> Barry
