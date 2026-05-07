Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2551CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 07:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A61E10EF8D;
	Thu,  7 May 2026 07:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DETxu+FB";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BD710EF8D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 07:18:48 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-44cc3c9b2feso468727f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778138327; x=1778743127;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=STH36cS/F87DhIyaZ+8OVzfArrGCDV+Ojd5JS20sYwA=;
 b=DETxu+FBptRqPj/xsTa1eTtv7k36DgC3zaa2/gt6SbHrjCQbynfHZ8zUiryC5covqo
 izd376JPJf+7Bd4qtR8qIfLkUcAxoL48GPILx1kJ++edpd/RdlKqSfEYptmGKeU48Hr2
 DPzacXI+LhsH63ltMuIz0FzjoaVX0bQQvHziKsBdEfOJmMjkLKGvnr4VmlIBqQ55XzBJ
 2RPqZXnGIAr6IBwNi09xXYPSwjyEPbb58XJ/opbLGJrDkwEWZfWTJx1qUNg7WoTvB3A1
 iKCbxSX1XU2p0NpOG2zzpwS1aKz80kjnSZVvcoMoE+lERCtryEES48JnETTjmK3EX4nb
 WBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778138327; x=1778743127;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STH36cS/F87DhIyaZ+8OVzfArrGCDV+Ojd5JS20sYwA=;
 b=VCWDAldive4yvb8bcYq8a1l3fxUSNo19/OwgUAq69PEql+AgTF6QgSL2hjguolDFa0
 OS3rNE8sm78ygSh60HqRwxSofzTurHoRWlv6hZmt20x3yEhg0gW6oRDKmdBfeja9ZAjY
 rDVC9hn8pzIQtzgAyGuN4vAbn/LG3+Ep7xAZVJB87xN89qYFYopJGqlPDgumlWRp5mFO
 ArlqV/OTYNH3qyQLmTLubObfAASDrdqSY1cVjRhoPGU5FWnhAw3YK0g1PIQBlQ1Ep0fg
 rUhQ6m7sxUVNQ//zZPE4xeY810Vn3Mw3QGiK379uAYXV5R71RVZ94jJjOD23tBczsw7X
 dblw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dDeN7JfAOHfX/K78Bzyq11bt+CWIl+cvw1LkkfdBnrzKxxIU9id4ONr2mvEkaeBczcKf65xupeGY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxtq9xKvVLP+3EEWjvqVQ7MKRUEujHN0M6fxq9EvlutiuKh3Fo
 bC8hkzJFlC9My+p6WODcaXtuO2BqK0ki9SIw36JH3jS9DZq//aryEo4zlg7uikKIPaL7EH4XjWn
 s+LcH2CEj9crOZVfG8w==
X-Received: from wrqr6.prod.google.com ([2002:a5d:4986:0:b0:43c:f906:ae85])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4381:b0:441:247a:e98e with SMTP id
 ffacd0b85a97d-4515ce1c738mr11025046f8f.24.1778138326535; 
 Thu, 07 May 2026 00:18:46 -0700 (PDT)
Date: Thu, 7 May 2026 07:18:45 +0000
In-Reply-To: <20260506135122.GA1432412@joelbox2>
Mime-Version: 1.0
References: <20260506135122.GA1432412@joelbox2>
Message-ID: <afw81cVYyF6hRhkj@google.com>
Subject: Re: [PATCH v2] rust: maple_tree: implement Send and Sync for MapleTree
From: Alice Ryhl <aliceryhl@google.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 Nikola Djukic <ndjukic@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, 
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
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

On Wed, May 06, 2026 at 09:51:22AM -0400, Joel Fernandes wrote:
> The C maple_tree struct contains a *mut c_void, which prevents Rust from
> auto-deriving Send/Sync. Following is an example error message when using
> MapleTree in nova-core's Vmm.
> 
> This propagates up through MapleTreeAlloc to Vmm, BarUser, Gpu, and NovaCore,
> causing NovaCore to fail the Send bound required by pci::Driver:
> 
>   error[E0277]: `*mut c_void` cannot be sent between threads safely
>       --> drivers/gpu/nova-core/driver.rs:77:22
>        |
>   77   | impl pci::Driver for NovaCore {
>        |                      ^^^^^^^^ `*mut c_void` cannot be sent between threads safely
>        |
>        = help: within `MapleTreeAlloc<()>`, the trait `Send` is not implemented for `*mut c_void`
>   note: required because it appears within the type `kernel::bindings::maple_tree`
>   note: required because it appears within the type `Opaque<kernel::bindings::maple_tree>`
>   note: required because it appears within the type `MapleTree<()>`
>   note: required because it appears within the type `MapleTreeAlloc<()>`
>        = note: required for `Box<MapleTreeAlloc<()>, Kmalloc>` to implement `Send`
>   note: required because it appears within the type `core::pin::Pin<Box<MapleTreeAlloc<()>, Kmalloc>>`
>   note: required because it appears within the type `Vmm`
>   note: required because it appears within the type `BarUser`
>   note: required because it appears within the type `Gpu`
>   note: required because it appears within the type `NovaCore`
>   note: required by a bound in `kernel::pci::Driver`
>       --> rust/kernel/pci.rs:294:19
> 
> Implement Send and Sync for MapleTree. The tree contains no thread-local
> state, and all shared access goes through the internal ma_lock spinlock.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
