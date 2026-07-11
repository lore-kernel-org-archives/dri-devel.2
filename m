Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0C6C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 12:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5B110E347;
	Sat, 11 Jul 2026 12:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="U7/FwH6T";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF22A10E347
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 12:28:43 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-493bdf90adaso13575915e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783772922; x=1784377722;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1zqV6pU7J/up3BiO4WkzdnwyvKk4FnHi04KFj10WU3o=;
 b=U7/FwH6TIhuZK+ps0j0p4/BnBlfJ8K0b5XzHmTe8IVOWQpZcMYnBkVe5yobRLPY+cC
 EG4kvRZEmkcARrww3pZ70nDKR4vqsIM0Vb6DjswOA3m9dQek6Or/tZ7MlC850FE/EOrj
 fEdxmNbocTaimNof3eh4XdpLmdZQfaXyV3y2rk20SqEWvhQ5uNQOCZZOOe1s2pb4fwgq
 chp8rVhrSuQPB2f8acyHpIyUUCrXPsVWXVk2evVN+02/RkWUgcuLn7R0iOj2mt5n2ilE
 fEsSrbQwjeGRQWyh/I1CCOZWBOXbJWRwNkDqvjF2tcHielwXIK4J6NOf3b+cPiiw28Do
 iecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783772922; x=1784377722;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1zqV6pU7J/up3BiO4WkzdnwyvKk4FnHi04KFj10WU3o=;
 b=XZGkbBdQ/ke8TWjrCY27jQSSnfFMRO/UX/C8/QhHkAUSV+DIoRgFf43Sx8g6iIijSU
 Z/S9R9PfY1wU9AVllNcF/z3TO2JQ4LTsfsIW0sCTcvLWRQEVfTUOkbzxC/DTC+Kct4ZO
 p6Sfh9V8eo9/k0iioQ6529AwnSi5ULhqtxXJ1jK8phlfAvPuxE1w1SeUNsPLtGbvsxsk
 BFQsdJ0EIDfpWYRQLiVTGxVMIQRDoeVfg4UVRCzW+C1dHK2rbEqscJoESMurAUb8k9wn
 yqX4IkItQ/WB0UPX8QZna0WrVdXn3mva6K08VBWUjHLjkpjOOIuBlns3F7j6yc8hOq0Q
 53dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYUirZIor5ZvqckMJ2NHqcDUGixAfe4YQHdxRC5uv4X3oTC6/m/axMtiG8wnDuSsapw66IkWXy/Oc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNHlGDv3uhsYzN1PEy9nkUzU0+Mk7vxYu6ci+CKwKXl038OsS3
 9Tf0IJAMFV9xmbeGUDbNLvi5cQYu8aTHpPe4/j1xVWb91xwLHOZbgMDEM6QCxwXAaYj+dM0dLX/
 LA/OWqbYYr2ax4wh9mw==
X-Received: from wrue11.prod.google.com ([2002:a5d:4e8b:0:b0:46c:d068:1ef8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6692:b0:493:bf84:53d8 with SMTP id
 5b1f17b1804b1-493f87e472cmr24827145e9.9.1783772921797; 
 Sat, 11 Jul 2026 05:28:41 -0700 (PDT)
Date: Sat, 11 Jul 2026 12:28:40 +0000
In-Reply-To: <84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com>
Mime-Version: 1.0
References: <20260710-chid-maple-v1-1-4ee869055268@nvidia.com>
 <84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com>
Message-ID: <alI2-KaHDTmUvNK8@google.com>
Subject: Re: [PATCH] gpu: nova-core: add ChannelIdPool
From: Alice Ryhl <aliceryhl@google.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 Greg KH <gregkh@linuxfoundation.org>, 
 Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

On Fri, Jul 10, 2026 at 02:29:39PM -0700, John Hubbard wrote:
> On 7/10/26 6:42 AM, Eliot Courtney wrote:
> ...
> > +use kernel::{
> > +    maple_tree::MapleTreeAlloc,
> 
> Hi Eliot, Alice, all,
> 
> Eliot already laid out the maple costs (the alloc_range+erase loop
> replicating find_next_zero_area, the extra mutex, allocation on
> alloc and free), so I won't rehash them. What I can add is why the
> alignment is a hard requirement, since that is what seems to make
> the decision clearer to me at least.
> 
> Pre-Blackwell, USERD sits in BAR1 at page granularity, 8 channels to a
> 4K page (chid = page*8 + slot). Giving a VM its own channels means
> giving it whole USERD pages, so a VM's chid range has to be 8-aligned
> and a multiple of 8. Blackwell moves submit to a per-function doorbell
> keyed by (runlist, chid), and the constraint goes away. So it's a
> constraint we're stuck with pre-Blackwell, not one we can design away.
> 
> Given that, the bitmap version is hard to argue with. The aligned
> allocation is the one call the API is built around, roughly:
> 
>     let mut ids = self.inner.lock();
>     let area = ids.find_unused_area(0, count, align_mask)
>                   .ok_or(ENOSPC)?;
>     // area.acquire() reserves and returns the range, drop clears it
> 
> One lock, no retry, and release is a bitmap_clear that can't fail. For
> 2048 IDs the backing store is a 256-byte array. find_next_zero_area()
> is also the existing idiom for this (IOMMU, DMA, IRQ), so it answers
> Greg's reuse-what-exists point as well.
> 
> I'd go with the bitmap id_pool.

Completely agreed. The loop in this patch seems like a really bad idea
to me. If the maple tree doesn't natively provide a way to allocate the
range with an alignment requirement, we should not attempt to hack in
support for alignment by looping. Please use the bitmap.

(Even without the alignment requirement, I think that the 2048 size
limit is also a good reason to use a bitmap, but the argument is less
strong in that case.)

Alice
