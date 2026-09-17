Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E0AC982D3
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0029A10E918;
	Thu, 17 Sep 2026 07:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGtjyhaX";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04DA10E7A8
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 06:30:04 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469b35611so297040b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 23:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789626604; cv=none;
 d=google.com; s=arc-20260327;
 b=K7PcmCQUR6k+ayTz7hdjS7DUJPWfODjDg9Lxq3AS2JwppofuARMozRoXo0AFMgych+
 HNhn7KejtNQ58v/pmKK7PeECODfh6lQ0nAm7wdqJGXtwIXI2/fCJAtYoy5b+CXw86m6V
 +ZWBQcFWSfnkJ1fXifGO3rXe6wNtGytHzsz2mcl7zlSzL41KhwW1JYB0vmzRfk/zZ1Jt
 5lPBQD6Vq/m7fyVI0JySIZcQU6qwSm1hR4tQthinFWNKJcAOfBEmhGQwv1qifRVvdVkT
 tRKOYkjY9h2bMCHDeL86gasXswwOv7VsR9t6mZb3ZRofOBmx0HGU8N4g2B9rTYDZt2Kp
 KqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f6s3jd19IN086xpWWaFW+yKBtO38Ikk4W70kReBkn/M=;
 fh=c8f29PrtDWrcZCovQ5fULWe5iLQylkX5/HmaAHvOeuw=;
 b=fj4wi64j/BiXzUbSRAqcE4t7qZSwdtIs3mnnGLYI6xJS2wA0KS0XUhYmKB62tIFRLq
 ZK5CA+Lo3SD9XgSdTQxipBIlFYamm4OpAVK5/oqxVKHhgCL4M0M29Hwl/2tnhrq+VvKM
 qnhcLzG0TP+0/AOPaL1xv31fR8gBZw70cHMyOlZ9xCCbF2vakLDxCL+4wAMH2HRh6rQs
 6PNfqyqN+lzN3aIH4uR94Sba86rdfRfeBddM1zMyDsfXFWREZTwgLdNtsCSkDYYe1WO0
 3gNVB1t4Srg06/qpcjW5v4qDVTsOL4DglszWvYhcO4PcaV+PCV3SJG0c88HnG5Gul5zx
 Y38A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789626604; x=1790231404; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f6s3jd19IN086xpWWaFW+yKBtO38Ikk4W70kReBkn/M=;
 b=hGtjyhaX5/vwrEkCkg/Z96ONFN80gCRccusjrVPKvMqjQ2pIEkaZ2ZIFCVGYyvaKYv
 eRYdFD39bXQ2OrZXvBDBwGcsrR7udq9UI5a+CQPW24RsmAfE1kFMh985PP2zKXBkkcas
 JfF8Ak6sE8N1dKxzqcXMObd+jIIvS83XiFHHy798A+vyPs6hDwE+BbN30F4MsnuHWrYy
 6mzxMIlOhVhGnXbNrIAxcRvQ7GVZvD8cuUHkvDy3Fo58uDWNQdEQWS5uIwHKc6x5uVzL
 4rB6NROusnQ1WnhXmwOYlcHK35My6NhlULubk4I4tYPBDUJ9487BrQJUd1kPWWG+8jsA
 oK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789626604; x=1790231404;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f6s3jd19IN086xpWWaFW+yKBtO38Ikk4W70kReBkn/M=;
 b=Rwfu4Krl55sbi8FyJt6gcymtFguvEUWp3FP3ou3wOvO2Hqy78lZHP8l9B5nAXdcHRh
 Ywgk60LHKnEsvIofyXFLhQJWKdIQOfC62oml5tMtKSyhSPZ1jiG6dUwswo1DYzV/BJPf
 Y5nJitEyH38QnVRIKk87AaagWeweRulNM3bjTVGA16RLLaB/8CGNmxtFAgN0SAgeypSI
 PZ207BL+9xtT/nuHo6VuZtu5R5AjjN1tGdvJm2Y/nzVOdc1yCEm1oxQRpbWNl3Esmhif
 3tmmN5BGeZ4wgRtSIaf1CINYNv99CZ+DiOgZev0BOL9k3Oj8hvueHClcv4imcvCFfqTS
 uCqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwio8HXl+r5daHPiibAAKdD1onBsTSdGOb3IlKW85krnXm6HGgCuJn5f4TuQNZ3t0pRunrG3waReHA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkGLMYxMEY3ULB2nxrYoiLyv+QscC1vuS2gLqvdv2SmjT4BQX7
 g1kpJ6WXwdDvssH64FdUauEzmMcs5N+Tm/oQD6V+XtPoIQ7BBtumJsUiKtG79BoAgDFh4XYaLxc
 +weE0HLnrhjWpOMRebElILxlx46/rp2o=
X-Gm-Gg: AYBFou1S37Tyax7ZgmA8btCW3CP2W320DIS0aGgEOPPcjMarBqZ6ddKd6AD6ObNVfuI
 tunn763bCl+jN6dUtMmxKWf/CABdJt4IfoxtSbV4wV6r+3YBXcZsKBjX5M8oskfEbnmDcCiqcYp
 GJDnl+mMmMW/19VinpExd+6p/Yy+y0SqVFMN5YEUe/YiTES1Pb05qNtlCv1Nzs3qv/JzAz0KYm+
 PBWBX5nu/lNVWD+3kgW/ZHyOz+ErFF2wV4ZM/SYJqaZtbFBJS5pTmcG2EgCZR8bUpcIPmokfuTA
 uzY23C7L8IckwfGQMcyt/UuPX3oo7SyePybjlsxx2ZNVyW/SCCU9O5Fdog==
X-Received: by 2002:a05:6a20:d70f:b0:3db:2c66:6638 with SMTP id
 adf61e73a8af0-3dd5f471e3emr15031230637.10.1789626603999; Wed, 16 Sep 2026
 23:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260909-descriptive-name-v2-0-d7dd7c099049@tencent.com>
 <aqQZus_Cc3mRiuXn@localhost.localdomain>
In-Reply-To: <aqQZus_Cc3mRiuXn@localhost.localdomain>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 17 Sep 2026 14:29:50 +0800
X-Gm-Features: AcwNN1UARSNuee55eRj5g9Q9pOjCPBt25LiYNXQWqlZv1UTyIwozsFpLVuPTTQA
Message-ID: <CAJqJ8ihb71wv9qaKvoP990oKmoA+ErB7MB1sksjNhJf3enwJww@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mm: page_counter: move hierarchical protection out
 of struct page_counter
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linuszeng@tencent.com, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <nat@pixelcluster.dev>, Tejun Heo <tj@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, 
 Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

On Fri, 11 Sept 2026 at 23:17, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hi.
>
> On Wed, Sep 09, 2026 at 05:44:18PM +0800, linuszeng via B4 Relay <devnull=
+linuszeng.tencent.com@kernel.org> wrote:
> > No functional change is intended: protection semantics and the cgroup
> > v1/v2 behaviour are preserved.
>
> It is not clear from the description what is the intention then :-)

You are right, and that is my fault for posting these three patches
without the context they came from.

They implement what Johannes asked for when I last tried to make a
combined memory+swap limit available on the default hierarchy [1]:

  My suggestion is to factor out from struct page_counter all the stuff
  that is not necessary for all users, and then have separate counters
  for swap and memsw.

  The protection stuff is long overdue for this. It makes up nearly half
  of the struct's members, but is only used by the memory counter. Even
  before your patches this is unnecessary bloat in the swap/memsw, kmem
  and tcpmem counters.

  Fix that and having separate counters is a non-issue.

and, in the same thread, about the cost of a second counter [2]:

  It seems like a good opportunity to refactor struct page_counter.

So the intention is not the cache footprint on its own.

The combined memory+swap counter is the one v1 exposes as
memsw.limit_in_bytes.  On the default hierarchy it does not exist:
struct mem_cgroup keeps swap and memsw in a union, because v1 only ever
charges memsw and v2 only ever charges swap, so the two never needed to
be live at the same time.  Making the combined limit available on v2
means charging both on both hierarchies, which means giving them separate
page counters.

That is where struct page_counter comes in.  Adding a counter costs a
cgroup one more of them, and at 192 bytes each that is 192 bytes per
cgroup for a feature most of them will not use.  Trimming the counter to
128 bytes first frees 128 bytes per cgroup, which is very nearly what the
new counter then costs, so the combined limit becomes close to free in
struct mem_cgroup rather than something every cgroup pays for.  This is
the "good opportunity to refactor struct page_counter" from [2], and it
is why the preparation is a prerequisite rather than a cleanup I happened
to do on the side.

The follow-up is written and tested; I should have posted it together
with these patches instead of sending the preparation on its own, and I
will do that now (details at the end).

>
> Do you have any measurements that the reduced cache footprint
> changes performance for setups without protection?

No.  So far I have only used pahole to look at the cache line footprint
of struct mem_cgroup and struct page_counter (pahole, x86_64,
64-byte cache lines, CONFIG_MEMCG_V1=3Dy)::

  struct page_counter             192 -> 128 bytes  (3 -> 2 cache lines)
  struct page_counter_protection    -  ->  72 bytes
  struct mem_cgroup              2176 -> 2048 bytes

The four embedded counters lose 64 bytes each and the one protection
context takes 72 back, which nets out to 128 bytes per cgroup.  The
counters that never participate in protection - swap/memsw, kmem, tcpmem
and hugetlb - are also down from three cache lines to two.

The reason I need these patches is the prerequisite
above, and those 128 bytes are exactly what the follow-up needs to afford
splitting the swap and memsw counters.

> And what is the positive impact on protected scenarios where the
> counters are in (possibly) different cacheline and one indirection
> further?

There is none, and in the form I posted it was worse than before.  Your
reading of the layout was correct.

propagate_protected_usage() runs once per level on every charge and
uncharge, and touches min, low, min_usage, low_usage and the parent's
children_{min,low}_usage.  Counting the cache lines each level touches:

  before this series   page_counter 3 + parent 1 =3D 4, no indirection
  v2 as posted         page_counter 2 + prot 2 + parent prot 1 =3D 5
  with the fix below   page_counter 2 + prot 1 + parent prot 1 =3D 4

In v2 the new structure kept the field order of the old one, which put
min at offset 56 and low at 64.  The two values the propagation path
reads together ended up on either side of a cache line boundary, while
emin and elow - which are only recomputed by
page_counter_calculate_protection() during reclaim - occupied the first
line.  That is how the count got to 5.

The seven fields the charge path touches are 56 bytes and do fit in one
line, so I have reordered the structure to parent, min, low, min_usage,
low_usage, children_min_usage, children_low_usage, then emin and elow
last.  Both embedders already place the context on a cache line boundary
- offset 384 in struct mem_cgroup, 192 in the dmem pool state - so no
alignment attribute is needed and the structure stays 72 bytes.  That
brings the per-level line count back to what it was before the series.

The dependent load of ->prot stays; it cannot be removed while the state
lives outside the counter.  The pointer shares a line with ->parent and
->local_watermark, which the same loop reads anyway, so it costs an
address dependency rather than an extra miss.

To summarise honestly: this series is size-neutral for a cgroup and,
after the reorder, layout-neutral for protected charging.  It earns its
place only as groundwork for the combined limit.

So rather than reposting these three patches on their own, I am going to
send them as the first half of

  [PATCH 0/6] mm/memcontrol: implement the memsw limit on cgroup v2

which is not posted yet; it will follow shortly after this reply, with
the reordered protection context folded into patch 1.  The second half
builds directly on them: it splits the swap and memsw page counters out
of their union - which is what needs struct page_counter to have stopped
carrying the protection state - maintains the combined counter on both
hierarchies, and adds memory.memsw.current and memory.memsw.max to the
default hierarchy.

[1] https://lore.kernel.org/all/20250320144722.GH1876369@cmpxchg.org/
[2] https://lore.kernel.org/all/20250320142846.GG1876369@cmpxchg.org/

Thanks for looking at this.

>
> Thanks,
> Michal
