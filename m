Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94CBCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F33510E2A3;
	Mon, 18 May 2026 12:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WhDsoxB7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4300F10E2A3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779106614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
 b=WhDsoxB7L47W8xbX7MDJn5xFkPS7vFUBxSLsjTkdQHpCUvfrZ2macQHMWB5Me9Oz4xFfRy
 rU83cKpB8CWTcAbKWSg8hKQKNCQ8hlhIYhDmkzl2awUlsQhJES36YB3UMNZPoB3GfPhtaw
 3OcK3btvZLxFKGwZt6Fh6qdu7EOZEMI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-vJ-wdwNJOvCqcBLyELtEBQ-1; Mon, 18 May 2026 08:16:52 -0400
X-MC-Unique: vJ-wdwNJOvCqcBLyELtEBQ-1
X-Mimecast-MFC-AGG-ID: vJ-wdwNJOvCqcBLyELtEBQ_1779106612
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7bd795b6288so25758577b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 05:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779106612; x=1779711412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
 b=LPnjRkWJOA//XPVFOmi2ggT/oH0ySVIFSoxxfMWNUYOnB+EAHP3ija8LNtUiUQvaug
 tGklBRAp/gkYiceKOndt11Bwc+iHoAvBxGnoVHOkTs0kVzDknEMhETRfZStzvilrTFaM
 T4WmXoQ9D/vVuP0VPVR4gD+Y+FfSMZgfVCGaC652J8HizICEWKPs/anrO9Tw+08WHpQa
 xyqItl0iXJtYk7Qe7hdKoKoMnjW2jPkHli8ZkIxSsV3ilDbIALq9u83lutDVsrnBw8yG
 OcMNR/pI4TZK4lAYt9ATUFzjRFt2CzDEVQJ2g3CsHgSrkEEGEBt0crso9RTWHUFlnEap
 WTgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VQdgb9ZINC+5T5LNYDhKfLjL5lE+29SewxHv0ZwXrssKdoSNguWSQEQeyjTyNJSgcsAuypddEF/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCshD4WOfi5h4eyhNwQ3P/dvjlFv1y7mhs+DqFOQZERQ0rsucB
 xxFwGLKtOTucuKcfgxtUvs+GBIe+ZL/m8ZFWtUtwazXsH34Y3rarHy7X4LDJDMrjKnjcCa3RF9X
 y2CusVcKgz+EEBlYKt79r2SvSo6gWvqxhYOeSrRBJTwEMvl+7enWJFHYr8jy51cycnXIh0XYUcj
 xmwpB4FS4ps9jMcYKku3TSo5RkFFQa0Tz3y0nWJSZ697Wo
X-Gm-Gg: Acq92OHoKNIits0w4jwGKs0bhpK5ok5cTKWTJtP9OXnaIHvLMt3XWnbBjRQIIKl/tw0
 RLuPeT+P0WuWk0zhkZCxZ/I/g3qSIPUc61N9txbDQ66H3B9WGazQRKQMmGRGWBjthJMvM+yJ1K0
 jomvl6ixcyRJsuhKQdcRLbIoV00T/khez+EbXy/Mb8Zap5ikiQf4uwqppaLWxUWSnB4DhZO7G7T
 OAOsg==
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id
 00721157ae682-7c94765b6ecmr126200917b3.11.1779106612307; 
 Mon, 18 May 2026 05:16:52 -0700 (PDT)
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id
 00721157ae682-7c94765b6ecmr126200267b3.11.1779106611396; Mon, 18 May 2026
 05:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
In-Reply-To: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 May 2026 14:16:37 +0200
X-Gm-Features: AVHnY4KtxiMU87dVIS1J63myR0LimTeIXsyDKnE3-mVGrbnQ2cunkdBN5oMYBbg
Message-ID: <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KoDRUT6rE-hAbd81jSzYHFM1UBDxjMl00Ge4_WBJhXU_1779106612
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

On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On embedded platforms a central process often allocates dma-buf
> > memory on behalf of client applications. Without a way to
> > attribute the charge to the requesting client's cgroup, the
> > cost lands on the allocator, making per-cgroup memory limits
> > ineffective for the actual consumers.
> >
> > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
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
> [...]
>
> > -               if (mem_accounting)
> > -                       flags |=3D __GFP_ACCOUNT;
>
> Hi Albert,
>
> would it be better to move this and its description to patch 1? It
> looks like patch 1 already introduces the double accounting changes,
> and patch 2 is mainly just supporting remote charging.

Hi Barry,

Thanks for looking into this series! Yes, in my head I was trying to
keep patch 1, which was taken from a previous, different series, and
then diverge from it starting with patch 2. This would clarify the
difference between the two. But I can see it just added some confusion
(for example, patch 1 charges on dma_buf_export() and then it is moved
to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
for the next version, including your suggestion.

>
> Also, mem_accounting is only used by system_heap.c; has this patchset
> also eliminated its need?

No, mem_accounting is still handled in this patch for the general case
where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:

+       if (memcg)
+               css_get(&memcg->css);
+       else if (mem_accounting)
+               memcg =3D get_mem_cgroup_from_mm(current->mm);

>
> Thanks
> Barry
>

