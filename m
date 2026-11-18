Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C03606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rg+Fp7gG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4769310E690;
	Wed, 18 Nov 2026 08:13:59 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B00110E763
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:13:53 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so5118925e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:13:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794989632; cv=none;
 d=google.com; s=arc-20260327;
 b=TO5H4w4vSinqaur5k+8ot23nl21QnBraah7Eb+mRK4LMTsbmcyBmDembbgAy0OipDx
 7YhhB2UHjXIcV586qxpSQ0KWidwVTqYy1K7HJo5/MdTm7rGu+lD3FdJW7wWl89C5XcMp
 pwAxT08aAoEis9xwIr8qLNV8YDSH3QT1PMN1tTh6FwjEGLG20BU1+KT4k0lp8BBRZrot
 JYmqnXW56nL2/FXvqEy6td+TjhwrndcU525mg4KMURPy5Dh7FK1oSet7tpbqYj4Kmd8X
 uHT06JJ1s1P8V2zKVrWVHNq+DgPwYxnKRIiYFS1fG5Z8VtEAIZN4wpzVynBQUiyZxCMY
 9pGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ff00ug9gApPN4aPXoacgE+gcCygc8x9Aqk+39n/itA0=;
 fh=n9dU3i5kQPBG8KJS6aJC46h33B/C+3MB3reUNjDZq4I=;
 b=MWtUdNuGna0C5fuYKK0KgSx5BLb59Vy9Mq5JxSQGSVJ/9UAYZtCSXtgo13l/ZxrUD8
 G+eNcHL5LnXzKL24JjMDRIUjxfv7KeECHYitXc0IKX8vK//EAELIVYiBYYWcvv8mQDpV
 InM44Xbb+J2eIvqC+3a1HQWC5S0Xf4N5iYoAqxJZsbN32Mr5kW6Xbdpj5C4vNIr7RZFm
 hre9HJaKHV63fsqsYx3plY+dKuoxyTw1KrrFSPotuMQzHcww8wwTfGQJeU+26rxHbu88
 LEs8kdA9PxDlhcgANI6ZWov3XoxoLYco6wQb74B46gYBOz1il1yVeyBik72g6RuMTo2R
 Q+tA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794989632; x=1795594432;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ff00ug9gApPN4aPXoacgE+gcCygc8x9Aqk+39n/itA0=;
 b=Rg+Fp7gGnxx9Sx+4CbnUdV1wrQ/oFwVZYGWVH+7rErJRWd0Nw/Bi+O7KUkmJudKgge
 dSRSd0YfN6PZNAbhalUR/bwAWC//KqQaLmy1RjTCiuB8GNyn8OkbKrIbodbSTPxd20yz
 WOArG9nf8xRFR9M3uj7RpbfVXaA3ulVlGLezukX9XSKt/+C0Jxquuyx33g+UGG6als/V
 BBEh12pdIG9W3QppQZjWRANgObF7W+0g3k05szD7nUa6sTBVwSRlOXpazjHokntlasek
 BOsXomfQSFCzrod3vw/Bz3F5LjvNcM4JXyOzNt5DfS3ivAgLHSePV/6+F6b0t5SwrszX
 4U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794989632; x=1795594432;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ff00ug9gApPN4aPXoacgE+gcCygc8x9Aqk+39n/itA0=;
 b=a/KyHdeEwBeIBPQeJJjUPV9KuUO0Rx4UrhEjzlr/eYGTpWfpZuGbaBhGD8jmoU8NXY
 dItrMzZg2Y33g+l/l0SWlhTSG5232JxuKDyFzMtdARTb6inVgD7mixcVkDrkDXe1H4os
 Dp2fBvq2vRfWab+IlgVrGQa1SC6Ba14iLGxR1p94DtheKILQg5VMBoAUU9BosttXagE3
 BvM1pqutTr5gPOkLmvte70cdyT4LvJzkWrMeOcAfOJ7vOczF7tycqvuaQ+SptdfCFgxO
 V3DcH5i7HwcnDq8A1mMkXm/pvAcMSylnQgF8/bAg9d3VaUfwjH+GcciOeVGnJ72sFlRP
 /dqA==
X-Gm-Message-State: APuU4Z9Tr2bNa/tfumV16gzKseKgeWpkVDY964hadKoUo4PFPSdlqSL5
 PSiH/OAawct+fHeaKTDsCRI8ZvBXjNqkX7dp4ZUnFqHt7nnjNZuSZ3BTMP08nljOSk3lkpdGCPn
 yuK9lFHPKAEVrM+e9TXbLmWject8sB34uLd6VeSuW
X-Gm-Gg: AYBFou2383YBRgsqFmRD1tVGFog+6WVVEcHbIFaV0t3iswswfkAMV1mpFYscBKIZuA+
 46NezhXDry7nZMmy/gtP9ge3M5s+ht1U/SpyVBXIuxBgxphavKep7NmF8C+3GQZkj+KXq7+e4+0
 GWGEifKuCbIMBDQlRjrfxPGhq26dy+Y1Wf/NXvy/oLgkTDRVqh9LHszQnY9Ih4XlCRp2h9VJz5c
 7vZy+UiiZCzrYXF6HAZbFgelXSNarzHCy7890200x8zY+A8c6aXreoZDSYaDKADJ2yWEuWuCLmX
 iXQhBKqv+vFKyheUAgj0iMQRHASBNLv6DSwjZdUlBZD4wsOdrU7mEf/2OMJItmUm8IXDGuJyaaC
 fMuMkbwWaLdxMWbpEhje09Kxpf8LMW5zphIwVee2LmYXruV51zWzQMriGuITDgyFiZazFEzmM8J
 1sdvMaL9yrNU94
X-Received: by 2002:a05:600d:6011:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4bb7da12dd2mr31321575e9.6.1794989631363; Wed, 18 Nov 2026
 00:13:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
 <20261117-tyr-remap-2mb-v1-3-2a8efd4c8180@google.com>
 <sashiko-outbox-219548@kernel.org>
In-Reply-To: <sashiko-outbox-219548@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 18 Nov 2026 09:13:36 +0100
X-Gm-Features: Aa3M54oJZdT7-ajHsujlEqHjejtQJ-wbRg89LRwChMZkFv84X9L5dIr8h3QO4eE
Message-ID: <CAH5fLghi4y1623FwMeRH60zZUqAoATABEJ-bBp8uPD1goYwPFw@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/tyr: vm: expand sub-block unmaps to 2MB
 boundaries on remap
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 9:02=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/tyr: page table desync and GpuVa leak on pt_map() error
>   in sm_step_remap()
> --
>
> commit 890e6d1a0c182be186e5d6f90855d935bae30eda
> Author: Sami Tolvanen <samitolvanen@google.com>
>
> drm/tyr: vm: expand sub-block unmaps to 2MB boundaries on remap
>
> This commit expands sub-block unmaps in sm_step_remap() to 2MB boundaries=
 when
> the surviving fragments are physically contiguous and remaps the survivin=
g
> head and tail fragments as 4KB pages.
>
> > diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> > index 1dd11b2b12532..bcc864b174284 100644
> > --- a/drivers/gpu/drm/tyr/vm.rs
> > +++ b/drivers/gpu/drm/tyr/vm.rs
>
> [ ... ]
>
> > @@ -749,10 +780,50 @@ fn sm_step_remap<'op>(
> >              op.va_to_unmap().addr() + op.va_to_unmap().length()
> >          };
> >
> > -        let unmap_length =3D unmap_end - unmap_start;
> > +        // The surviving fragments inherit the protection of the mappi=
ng being
> > +        // split.
> > +        let prot =3D op.va_to_unmap().data_ref().prot;
> > +
> > +        let block =3D Alignment::SZ_2M;
> > +        let aligned_start =3D unmap_start.align_down(block);
> > +        let aligned_end =3D unmap_end.align_up(block).ok_or(EINVAL)?;
> > +
> > +        // An end may only be expanded if the fragment the expansion s=
weeps and
> > +        // rebuilds is fully mapped and physically contiguous, because=
 the
> > +        // rebuild maps it linearly from a single recovered address. A=
 genuine
> > +        // 2MB block is always contiguous, so this never misses one an=
d the
> > +        // partial-block unmap can never reach arm-lpae. A fragmented =
region is
> > +        // never expanded, so its sub-range unmap stays correct.
> > +        let head_paddr =3D match op.prev() {
> > +            Some(prev) if aligned_start < unmap_start && prev.addr() <=
=3D aligned_start =3D> {
> > +                contiguous_phys(context.pt, aligned_start..unmap_start=
)
> > +            }
> > +            _ =3D> None,
> > +        };
> > +        let tail_paddr =3D match op.next() {
> > +            Some(next) if aligned_end > unmap_end && next.addr() + nex=
t.length() >=3D aligned_end =3D> {
> > +                contiguous_phys(context.pt, unmap_end..aligned_end)
> > +            }
> > +            _ =3D> None,
> > +        };
> > +
> > +        let region_start =3D if head_paddr.is_some() {
> > +            aligned_start
> > +        } else {
> > +            unmap_start
> > +        };
> > +        let region_end =3D if tail_paddr.is_some() {
> > +            aligned_end
> > +        } else {
> > +            unmap_end
> > +        };
> > +
> > +        let prev_va =3D context.preallocated_gpuva()?;
> > +        let next_va =3D context.preallocated_gpuva()?;
> >
> > -        if unmap_length > 0 {
> > -            let region =3D unmap_start..(unmap_start + unmap_length);
> > +        if region_end > region_start {
> > +            let region =3D region_start..region_end;
> > +            context.extend_lock(region.clone())?;
> >              pt_unmap(context.dev, context.pt, region.clone()).inspect_=
err(|e| {
> >                  dev_err!(
> >                      context.dev,
> > @@ -764,14 +835,29 @@ fn sm_step_remap<'op>(
> >              })?;
> >          }
> >
> > -        let prev_va =3D context.preallocated_gpuva()?;
> > -        let next_va =3D context.preallocated_gpuva()?;
> > +        if let Some(head_paddr) =3D head_paddr {
> > +            pt_map(
> > +                context.dev,
> > +                context.pt,
> > +                aligned_start,
> > +                head_paddr,
> > +                unmap_start - aligned_start,
> > +                prot,
> > +            )?;
> > +        }
> > +        if let Some(tail_paddr) =3D tail_paddr {
> > +            pt_map(
> > +                context.dev,
> > +                context.pt,
> > +                unmap_end,
> > +                tail_paddr,
> > +                aligned_end - unmap_end,
> > +                prot,
> > +            )?;
> > +        }
> >
> > -        let (op_remapped, remap_ret) =3D op.remap(
> > -            [prev_va, next_va],
> > -            pin_init::init_zeroed(),
> > -            pin_init::init_zeroed(),
> > -        );
> > +        let (op_remapped, remap_ret) =3D
> > +            op.remap([prev_va, next_va], GpuVaData { prot }, GpuVaData=
 { prot });
>
> [Severity: Medium]
> Can a pt_map() failure here leave context.pt out of sync with GpuVm and l=
eak
> the GpuVa?
>
> pt_unmap() has already torn down the expanded 2MB range in context.pt bef=
ore
> pt_map() allocates L3 page tables for the surviving 4KB fragments.  If ei=
ther
> pt_map() fails with ENOMEM, sm_step_remap() returns without restoring the
> unmapped range in context.pt or updating the GpuVm tree via op.remap().
>
> When Vm::kill() or Vm::unmap_range() later calls sm_step_unmap() on the
> unsplit GpuVa, pt_unmap() hits the already-unmapped PTEs, triggers a WARN=
_ON
> in __arm_lpae_unmap(), and returns Err(EINVAL) before op.remove() can unl=
ink
> and free the GpuVa and its GEM BO references.

This is valid, but allocation failure in pt_map() is a pre-existing
problem. It will go away once these page table entries are
pre-allocated.

alice
