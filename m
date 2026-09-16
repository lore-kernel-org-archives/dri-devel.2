Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804CFC982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81D410E167;
	Wed, 16 Sep 2026 16:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SycwjrV8";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F9510E167
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:03:47 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b5e50eb70so50025e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789574626; cv=none;
 d=google.com; s=arc-20260327;
 b=V/jeGT5fY9eIev5JAHQfrkOLb3RkTEZGYiKN/iHWZ6Os+MSD1cuf9kSL31FBCa1yZE
 z9P54amq77Jxu6iBKLmFi3tykkusqJrWhPznX6BUk09K36rvN39XwmHCtazICzqFeCtj
 dUeIbg2Du932bqwhSphWP7dGVcvD41/bAH7hNlvZOayVjIyvW01gvq1vHN6ZL7VswKmH
 htSGKegQbZ+TR7IwD39Xcca7gfiGzbtKMK3AhBDpxwB1tU6xNpp54amz4vzY2OOMBcq3
 BPpVQez8HtJDLi3YuaMOlVgpEmqvQt9StlkYUeZLzwBL7j8xGGOLqH4hTkgHR31iG0hI
 QoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/sYg6HCX2NniI5KvZuS6t1I10Labn2Y/FeR9nIXb/pc=;
 fh=E4ilo64kcl3SzBap/gKRLOR18fHQO1XSXRZNiGge4wE=;
 b=Y0vQCJtcFWPG0hSyaUknZNrPWI9XS3xF3QHYiZVyP4tK+9uaPaZ95xFIiDCTJ01N+A
 XbuCWbpYO6HQf5E/e13LdkG1HkYEN4g12Z3/bxkwj89UNYV/jm2fF3QOiuyMcV1FcgNP
 B3MT3D2xHzDvIrE+GxxP+b+hmAHyszytRvLP1pljcA1csvPN3mi/gRKbCi/okXjjfmrd
 37HlPT9IAX0MX/s8PTeYYMn7s3/6jaP+DnMoAKdRnBQnijSYzTegVpOYlqtwCz/sZyHk
 t9nT099RDAFzlJPMS9hq/E34y9dfsL1LQKxWn4vH+ui/ndIWftSbJyJEtN61pd0xQ6de
 tB5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789574626; x=1790179426;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/sYg6HCX2NniI5KvZuS6t1I10Labn2Y/FeR9nIXb/pc=;
 b=SycwjrV8teBybQmCUjkF4kEQ918VlHs2DKtzBh2TxYnPj3RzBUB33iqjRGdi2jPrtm
 cG8yNrZRU0mQvnzeEFx3w2m5hXYK8qkNLM4EFVWcnme+I9InB7hhWCchPlprWuSSt2Y1
 n1PUPFrJwvqszXACVDGnjoYseLsI+9OhluPCQLKmfCkSmPDGjJ3te6GM9PIqk4W1aiw6
 seaPoOvYB3pSWfGo7IwS8zwFs4HQVkvH4S3Cp+y/nY6a4wPzh6MAqu7gMg3Hpojxbk2G
 E4TONq6u5FnuS1990XxAQzL/A04fSubuo/WJtONFj2C8tqN9otp38wHXurieTQWM2SNw
 wSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789574626; x=1790179426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/sYg6HCX2NniI5KvZuS6t1I10Labn2Y/FeR9nIXb/pc=;
 b=zaFdNFexKJ28MYKDH6TrPhLtu5CXENhkN9pnD/NwqQ2xs29as/Ha/4uA1bJ+k7AVJz
 ZOaNXxai/wbrHtRSx7+MsClMe+SUpl97RVD3voRBuonngztbDuKlP5KICa0L5SqFlWzj
 Dg8TGacX7PETmZk+hoxDcTkJfTSyBp1H/BI5L66CfhHPzW80h6sv32Pm1ySNcgI9qq2Q
 wybUk5h2nY4pNCfH+EoNJqSbzyAFbGhdKBTDQ1XBGvV+kVAUIlWCSQa5RlT5nC9zmblf
 02FJokfEOxQ18BxvhWN/wsUGlgNUMcxV/Xx39fuGzRM4ibyv22EXnOyYEziHJxjqRdgZ
 v/AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2i/dl/69L0DDP6+++9LXlZJa5DSAwMI/XVywzoxwgkBmjFgMDNsc+oB+hh5sWxBh1aohXQiCXQ4w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mEO8xp3JLQTKdf2NQ/xa86A3Zw1ReuGQFiV+DHy2fglQYbnV1V
 Opqc63T3Avzrfq1GHnsx2ZQ9m+dVwP8PNZlEdG4EEFzpCkV6vntaD54cmDffBiOyiRAu85P82J9
 v89MT4qHHSJAWOy7M2HP/o9A9A008Hzbo4OMc9re16xnjxGFBUogIA+Uw
X-Gm-Gg: AYBFou2nMzVdjm69efza72E4uKNSWS0PnwaLo5d4c5spRRggSD1uVWBAOdKg7G2n4aw
 69pwPos0bgxPMPxR/92LIl6aVVlKC5TFzerdn7w81kQEpVXk7XWww2DkY/P+1beyRyrA6kFUR3V
 +X4U9GwY0jiqLodThUDFHhI9o5nWfbIHXONwVi1WASnHnNn58Asn10MCvb8YtGbDrvuF8xnaDeE
 VDUC0hAIj7/0R+3IhXwJo6aj6XSN/yz6dKMSuuiiWYErlzLlZaJdISRywJ5NPmNKybGjwHkXQft
 7vZjdiVwAPzkgRRBJch9AF5k1b/CFWYTIaF39JZU8gLsCYc91X2q6ZQZmDpQwQAvi8F0ePQLrLG
 N6F/ZIEIXu+RthSs+glGRHo9tt8m6MRpTUV/+s2reCA==
X-Received: by 2002:a05:600c:4d95:b0:49e:7946:d8ce with SMTP id
 5b1f17b1804b1-49efca9e4a5mr423505e9.3.1789574625116; Wed, 16 Sep 2026
 09:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
 <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
 <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
 <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
 <CABdmKX1g=wcLHOFkRN6DLPTABrnn2uWmgCKpCtixhiV_b+9J1g@mail.gmail.com>
 <CABdmKX2GU0Eby=SEeALzeEp5ragEjU3Fw468Jv1yykD1Zdrgag@mail.gmail.com>
 <d8d3af91-4f21-44ea-bc90-339fa1adacf9@amd.com>
In-Reply-To: <d8d3af91-4f21-44ea-bc90-339fa1adacf9@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Sep 2026 09:03:32 -0700
X-Gm-Features: AcwNN1WPGZ8Iyy7HZsw1Xg5R6VdTYd3IYP7pEJKqY6H8Wjci94V-WOlkQcsrMBc
Message-ID: <CABdmKX1YtyFM_MoMbPr4JUCXCr8TGPVbXUrAoQRELpp54cK-0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, sumit.semwal@linaro.org,
 phasta@kernel.org, benjamin.gaignard@collabora.com, jstultz@google.com, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Wed, Sep 16, 2026 at 1:41=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/15/26 19:26, T.J. Mercier wrote:
> > On Tue, Sep 15, 2026 at 9:26=E2=80=AFAM T.J. Mercier <tjmercier@google.=
com> wrote:
> >>
> >> On Tue, Sep 15, 2026 at 8:44=E2=80=AFAM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> ...>> Even on arm64 phones free 2M pages aren't likely to be available fo=
r
> >> very long after boot, but lately we have been doing more proactive
> >> reclaim triggered by userspace before launching workflows that desire
> >> large dma-buf allocations (and also at other times during application
> >> lifecycle in general). That somewhat increases the likelihood that
> >> high order pages will be available. I agree there's no guarantee we'll
> >> get any, but without __GFP_RECLAIM the attempt is pretty cheap and the
> >> payoff can be pretty benficial which Davidlohr's allocation and
> >> mapping measurements demonstrate.
> >
> > Oh I forgot to add that this behavior is similar to how slab
> > allocations are done for slabs requiring more than an order 0 page per
> > slab. A large optimal order is attempted first with ~__GFP_RECLAIM,
> > but if that fails a fallback to a smaller min order is done. When the
> > optimal order allocation attempt fails, the cost is just taking the
> > zone lock for a quick peek at the free lists.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/mm/slub.c?h=3Dv7.2#n3373
>
> Well from a lot of experience with AMDs ROCm stack and Intels XE driver I=
 think that this is a really bad idea.
>
> The background is that there are a lot of operation which can fragment me=
mory to a point where only 4k pages are available, e.g. for example storage=
 I/O can do that trivially (the kernel compile is a really good test case f=
or that).
>
> Now acceleration HW usually has a very specific sweet spot where it works=
 best. AMDs GPUs for example can work with 1G, 2M and 4k in the L2 and ever=
ything between 2M..4k in the L1. On Intel it is only 2M and Nvidia has 1G a=
nd 2M (but really don't nail me on that this is just as far as I know).
>
> So if reclaim of smaller pages into larger ones isn't requested what you =
end up with is unstable performance, e.g. if you only run application A eve=
rything is fine, if you switch to application B and then run application A =
you see a performance penalty of up to 30% which eventually doesn't go away=
 over time.
>
> On the other hand when reclaim is always enabled for multiple different o=
rders you start to see stuttering when allocations are made because the cor=
e memory management tries to fulfill all those different orders.

Yup I understand the tradeoff you're describing here between
allocation latency and performance predictability for GPU/HPC. But for
a generic allocator like the system heap with very loose constraints
on what memory can be used, this lack of optimism permanently incurs a
penalty that might not have been necessary. Users of the system heap
don't demand any particular page order they just deal with what
they're given. There is no single driver or use case for system_heap
users. Opportunistic allocation without reclaim gives the upside when
pages are free without stalling when they aren't.

> We literally had tons of bug reports regarding those problems and it is o=
ne of the major reasons why we doesn't use DMA-buf heaps for HPC use cases.=
 Instead drivers even communicate the sweet spot to for example TTMs alloca=
tion backend.

This behavior isn't an inherent property of all dma-buf heaps though,
it's just how the system heap does it. You could create a different
heap that always tries to allocate the sweet spot for a particular use
case.

> I don't have much of a problem when we say that this is just for Android,=
 we never do reclaim here, instead reclaim is triggered solely by userspace=
 on application switch etc... but the general idea of DMA-buf heaps is that=
 it should work for everybody.

I'm not sure these patches were motivated by Android (based on x86
focus in the commit message), but Davidlohr would have to comment on
that. That's just where most of my experience comes from and what I
can share details about.
