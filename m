Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B361CD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 07:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF39210E46F;
	Sat, 16 May 2026 07:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nNpNtXRG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1615310E466
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 07:37:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 81E23445E4
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 07:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C9DC2BCF5
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778917028;
 bh=P3vqgwHwD6iLuiEKYHBc9rKUdaJI1VWv+dxZinDZG8M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nNpNtXRGUw0mf4NnH+yNpsGfoHEeYyd5NHflVOhmZkdo7mVPuYo0Sn7ejcQkpbAdL
 Xq4AnHBYR4AGZl8TBwgKc4eBK1jQKV2THXCREwHOk3eNmL2yNugi07+KM4ItzVAMO6
 lSPY0Q0dGzv7nMdKXX7wA4HJVc7hGOOjnXN54jcMnyKjaImX35rvGB1CMn7FnXzrEH
 ttD1bT9CLBvfDdqqOFFKIZxJh2yhLap9F2AzPm/qZYxfkQWJm8kzSDn2H87s6wQ+fJ
 uJXowVoELz8Hq3RAcg3eCdTqAUK/EgUtAJVUnrzr3fZqJNnt9hF+hAPgi/sObhd4Kf
 /5dvJQcCOdrpg==
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8b5cda2dab9so18736146d6.0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 00:37:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8DMSn0zwM4v44MgMM6dFZUB0b1O5ifNBJ3VbUjWD8SDX4Pon7ql/I42VVvXkQkeZ7l48j1mlnByM8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzywI4BXYRgA/Yeglx6YABRM4L/9x5v6tK71U43fDCYJ3gIUzK2
 rTx71N3AG6npNexZeOwhYNV8cpHHojdOTbOuvPcSi7CRsOKBOzIFNHja8Spl1ZSOQjB1JeAOnRf
 R1L5qsRokYL+p4hX6UkNiNwrUwJVXNdQ=
X-Received: by 2002:a05:6214:29ce:b0:8b3:ff3f:5d61 with SMTP id
 6a1803df08f44-8c8fda1ccbbmr178745586d6.22.1778917027156; Sat, 16 May 2026
 00:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 16 May 2026 15:36:56 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
X-Gm-Features: AVHnY4L9M-s1Neba6WebvB2EkXnslTMMIykTYPVPE3skCvVx5rzQK6ntLSW6W0w
Message-ID: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
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

On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On embedded platforms a central process often allocates dma-buf
> memory on behalf of client applications. Without a way to
> attribute the charge to the requesting client's cgroup, the
> cost lands on the allocator, making per-cgroup memory limits
> ineffective for the actual consumers.
>
> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> the mem_accounting module parameter enabled, the buffer is charged
> to the allocator's own cgroup.
>
> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> all accounting through a single MEMCG_DMABUF path.
>
[...]

> -               if (mem_accounting)
> -                       flags |=3D __GFP_ACCOUNT;

Hi Albert,

would it be better to move this and its description to patch 1? It
looks like patch 1 already introduces the double accounting changes,
and patch 2 is mainly just supporting remote charging.

Also, mem_accounting is only used by system_heap.c; has this patchset
also eliminated its need?

Thanks
Barry
