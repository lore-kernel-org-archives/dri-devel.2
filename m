Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2528C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B9BD10E5F3;
	Tue, 25 Aug 2026 13:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="f6dINm/5";
	dkim-atps=neutral
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A475410E5F3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 13:12:57 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49545071724so40320285e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787663576; x=1788268376;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rXohTk4GdfSVv1B1Vj6jhy4ehfsGqcW+TXrVTAjc0Ko=;
 b=f6dINm/52kJ4LCnrTsvgffZ27FXG7GmwPvdyBGC7134237H5SOzFNdjoVEwQ1Hp/di
 u8CkwWjyIkpvYpbOohTye78r2Q5LQXplfaW/029KFgWMcZT0iF1CEolFzkmPMywRi0qG
 ZTR3HqdQ2binnFDQjq0XsXw1T3Rzu1pnwhHeJ0eOqGTT3byS64b9+a1/tpbZhKJqjY8E
 UeMAZ3priwx7nR2wyeNUjyEgRv2Wzxv+WLfJWyiYP+zE6MBxjt3kEEtLff3bvFMrPf7I
 9H0j3m0KSRXhQvPR/OwqBfCDK1piVitObtV4aoyCzH8xyVzLHeZbr9axSsVHw1v+b4P+
 2Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787663576; x=1788268376;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rXohTk4GdfSVv1B1Vj6jhy4ehfsGqcW+TXrVTAjc0Ko=;
 b=sIyno2xLl8w75qLiT5rruxPlT8+B8ETBwmPdug5Vo0TJCKn8PweWCWpO9iGgAH0uRF
 c3JyVDR5dV8kXAKip18bmnBv65aZHDNklycRL4bL3H6xZkUO3yLb5MN/yed7AeEADCVc
 o2oaU4hEbEGfksGbEProEd814p5zcGC0EfE+JWBZfNPkJw5rn4OzEFX2oMdSIZRt6mQS
 oH/fCyqdGxiElOMweHnuY4EtnGzH7CRwqwrcbZGI9D/+TedM9RbysSIiYqsuoBt0M5zn
 tmd8kz+W4Seu7xghsb6GDIqKXg3dxuF0PcNfYRM5lvKYJ4SxdHyYxYbY1HfVm/w/+t5d
 3ZEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwZr/1wa31vMyuqSXESRm0JzWvPLMHu+b1iju1Q0TNU9PD7NT6/jlIFtj7MiCk+JsbxVuXW9G3Pdk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lDAfSeXNi/y4Ol5zdjo/Fhe874jQZKTHyYLdXGMJcERySd1IOC
 27tOHzVlbwafUo+DOzrMVPEse39TIXooVqgAx3sdHFIHw/vofMZQbtagJO7xR5QO1X9Je/Rdy45
 Tw60yflmnAhoB898pYw==
X-Received: from wmoo2.prod.google.com ([2002:a05:600d:102:b0:499:58e2:b51f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b9f:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-499d652362amr77858225e9.12.1787663575869; 
 Tue, 25 Aug 2026 06:12:55 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:12:54 +0000
In-Reply-To: <DKXZ7VHUCLWL.C6IPHWPTEJW4@nvidia.com>
Mime-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
 <DKUHJF1YTTY6.1XXC1L2SYXEMF@nvidia.com> <DKXZ7VHUCLWL.C6IPHWPTEJW4@nvidia.com>
Message-ID: <ao2U1jNaT7waibJW@google.com>
Subject: Re: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
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

On Tue, Aug 25, 2026 at 08:09:13PM +0900, Eliot Courtney wrote:
> On Fri Aug 21, 2026 at 5:39 PM JST, Alexandre Courbot wrote:
> > On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
> >> There is no good reason to allocate an IdPool with zero capacity.
> >> Reflect this in IdPool::with_capacity.
> >>
> >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >
> > I am not sure this one is justifiable; `KVec::with_capacity(0)` is
> > doable, so why not here? As long as it doesn't introduce soundness
> > issues I'd say this is the caller's business; a driver with a legitimate
> > empty IdPool use-case would now need to special-case it.
> >
> > Now we do have an actual soundness issue with zero-sized IdPools, which
> > is that `find_unused_id` would panic with `CONFIG_RUST_BITMAP_HARDENED`,
> > but as I said on patch 5 I don't think it should anyway. Another
> > potential issue is that `grow_request` would not grow anything; but that
> > should be fixed there by handling the `capacity == 0` case. Actually
> > that would give justification for empty IdPools to exist: just like a
> > vector can start empty and grow, so can an IdPool.
> 
> I don't have a very strong opinion here but I can't really think of a
> use case for a zero capacity IdPool. Unlike an empty vector, since
> IdPool doesn't automatically grow (there is a notion of a fixed ID
> space), the only thing you can do with a zero capacity IdPool is grow it
> to non-zero. All the other operations don't do anything useful.

It may not grow automatically, but that's only because Binder (which
will grow its IdPool) holds it in a spinlock and needs to use the
PoolResizer and so on to grow it without allocating under said spinlock.

> If such a use case exists, maybe it'd have to be something like you are
> using the capacity to identify your ID space size (and the ID space size
> is important otherwise you would just use IdPool::new() with the
> MAX_INLINE_LEN capacity) but then the only way you can grow it is via
> grow_request() which doesn't grow the ID space in caller controllable
> way.
> 
> Anyway, let me know if you feel strongly about this one. FWIW, previous
> to this patch series you couldn't construct a 0 capacity IdPool either.

I feel strongly.

Using NonZero to prevent passing zero is a very strong mitigation due to
its big ergonomic cost. There's nothing really wrong about a
zero-capacity IdPool, so let's not pay the ergonomics cost when we don't
need to.

Alice
