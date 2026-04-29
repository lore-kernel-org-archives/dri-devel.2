Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF5EFF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E5A10E069;
	Wed, 29 Apr 2026 08:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Q/0J1mYN";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F11CE10EEB5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:19:43 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-43d7d0947aeso7499302f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777450782; x=1778055582;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UnWFkQyHgeOIkEs/wIKBFV9O4AMa1adBSTGrokeVPN0=;
 b=Q/0J1mYNC5yx/TCVGmC2+o7vJsuVjVorVsjdhCR8ZSp0yPFNMochlcnDP7RP8NsTAq
 7zcPzk+u8H+rLS9JR91wvLp2SnZBN9tCl/hwEnHSk0Y/seQAqN+vL7biKPWNtK4uzvrd
 b30CRVrsaV7XuLeOEe5ISOhyg5NyisVQ/PJoHroWa88xZjapaLxlDr+mz8rMVwxtZgLX
 Jwi9TnNMe9UBVvXOlHvESAs09sBfP7WddU9WCZVDZ2Gru/wP97y/vRuyAYQSJj6LgQpC
 E1vzleOb9uB/Z+ZrNXOEUlhmiMDu8b65n10SeAobiboGv1HPjkQc0gAT8aetqUk79E9y
 PEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777450782; x=1778055582;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UnWFkQyHgeOIkEs/wIKBFV9O4AMa1adBSTGrokeVPN0=;
 b=hN1hXU+uQMYJp8toRw/dllEG7oX8aGNzX3Rnj7p94Oe7QprlB6Z06RWDqVFmrtEJJG
 03ML7sawPtz3ebWySO+cmNkalL4srt01nebnSXdVEYx7grerJG2vQpsbythHZ/eV/mlc
 mxkk7pmY4HwQvutlUZjDwE/CaqhXJYFtfXLChPsD6gotXX5qmiW5/K91GA+4Fx6wcQkX
 Lzd7qtG3AthqkP8OaG7qWoGFvfii2aJuczmVxKtTwRpTZy938k69uFEkjN97Z7cDDqnJ
 3WXqD0LHdZJuIn0koMCXwnlt7r6aefqfIvadBKCPSG8VUGzJpyyzhRXacmWuRyN5oZyi
 RKdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+31IMMcuMKI5acaI661l8/bCqckfX8jt2JBk8MBijw0oMOeLkPzoePdCtA5a4nKUioKgpofqIRiiw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze20J5GenIf3dX9Is0D26H2biKaTfrohMNLB5Sa2kX6n9SzasM
 jT96a+W+caJHH0/coUigBCKYTTlD8Z38XMmlTbIWqyrPE/MAD/cEFdL/I4wwizljBgo1zJH5l7j
 V7hSjRvF7jgVzsrrpoA==
X-Received: from wrve6.prod.google.com ([2002:a5d:5306:0:b0:43c:f94d:a0b5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:616:b0:43f:e43a:d85d with SMTP id
 ffacd0b85a97d-44648f28d2amr11438300f8f.3.1777450782265; 
 Wed, 29 Apr 2026 01:19:42 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:19:41 +0000
In-Reply-To: <20260428190605.3355690-5-lyude@redhat.com>
Mime-Version: 1.0
References: <20260428190605.3355690-1-lyude@redhat.com>
 <20260428190605.3355690-5-lyude@redhat.com>
Message-ID: <afG_HUjCMH2qKjPS@google.com>
Subject: Re: [PATCH v13 4/5] rust: drm: gem: Introduce shmem::SGTable
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Matthew Maurer <mmaurer@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, christian.koenig@amd.com, 
 Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Boqun Feng <boqun@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 linux-media@vger.kernel.org, Shankari Anand <shankari.ak0208@gmail.com>, 
 David Airlie <airlied@gmail.com>, Benno Lossin <lossin@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, linaro-mm-sig@lists.linaro.org, 
 Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
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

On Tue, Apr 28, 2026 at 03:03:44PM -0400, Lyude Paul wrote:
> In order to do this, we need to be careful to ensure that any interface we
> expose for scatterlists ensures that any mappings created from one are
> destroyed on driver-unbind. To do this, we introduce a Devres resource into
> shmem::Object that we use in order to ensure that we release any SGTable
> mappings on driver-unbind. We store this in an UnsafeCell and protect

Outdated? No longer UnsafeCell.

> access to it using the dma_resv lock that we already have from the shmem
> gem object, which is the same lock that currently protects
> drm_gem_object_shmem->sgt.
> 
> We also provide two different methods for acquiring an sg table:
> self.sg_table(), and self.owned_sg_table(). The first function is for
> short-term uses of mapped SGTables, the second is for callers that need to
> hold onto the mapped SGTable for an extended period of time. The second
> variant uses Devres of course, whereas the first simply relies on rust's
> borrow checker to prevent driver-unbind when using the mapped SGTable.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

>      obj: Opaque<bindings::drm_gem_shmem_object>,
>      /// Parent object that owns this object's DMA reservation object.
>      parent_resv_obj: Option<ARef<Object<T>>>,
> +    /// Devres object for unmapping any SGTable on driver-unbind.
> +    /// TODO: Drop the mutex once we can use Init with SetOnce.
> +    #[pin]
> +    sgt_res: Mutex<SetOnce<Devres<SGTableMap<T>>>>,

As far as I can tell, you don't need this Mutex. Also, it causes
problems like requiring the reference transmute below.

Alice
