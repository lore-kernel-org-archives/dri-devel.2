Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6070CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E5A10ED7F;
	Thu, 11 Jun 2026 08:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="t5V+BQyH";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E5F310ED7F
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:03:42 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so62058925e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781165021; x=1781769821;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Zn3bOdZdUuKhUFaYqBi4NI8K8WLwOEN+61v6c7A6xo=;
 b=t5V+BQyH6A/JcKv7RaH/OnB2BjkaEAIIzbzdDKgAuKMZIhz43xaSv4WP96BR+JNHG2
 Rq/tIGJlXvPMrBNbDq+zTGeuylPDEOJff9sCAbe08Uhaa3YlftmEfzGjKEfw5B4auEiY
 sa8r3Us2JK70Bppgw86ioRg1OzFb/7ACEsine7enIp1j3pv32ztSlcgkI+aIMCysDBYn
 Sow31OYlTSmXh7fk52Wu7TNqI3ryFWpaEnGICW1NQZKO9yEvKdxBlfPtKME0C0JxTKrt
 d/BlTNCdqlWLRamU/L2lLmN7KsN3MYb26qxndpnEY0Oj6xvhvdhDZyFKC8CgDcIvs+5/
 xMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781165021; x=1781769821;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Zn3bOdZdUuKhUFaYqBi4NI8K8WLwOEN+61v6c7A6xo=;
 b=AmOu3dJ/7MFGYRCHRFuP3oYDdNnzYvEJ1JN5OyLf2sjq3/oIWMuHPguq1K5DuUSUMU
 3OAbwtSo4fRU6nwucV7aMLSTt/mQdIpoQ6rLHGNHHd20DG8NtxKKPViK1XmX7/A+ABmj
 PcNqbvpA/ZGRM+oGMiNsGJk9P/Bms/gMQghpMlXlPqP2orciETREjijr9Ag908FDY1gQ
 riW0WlyEkj/3E0FXe9m7F2wwWlfYxHaYt1bB4MmxrY/gVJAOdCH0F1FQf4sXlw+biWEp
 BYjCj0Q31EYwWD9H5NZxjKEkWCyqyL8XxL4s60cL20IJpudM/v72qOfN8uEpbYBwhRaR
 Sa6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HDyFcXlGI5cEAoN4zXFBS73uT8L07B3PT6XBdzJTpOCX+pS58H/S/YMFuazECJ5W8eFYEKkGNBSs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrFp/m7XdHXBj2KoMyf5yd2h/WZFnfSMvjExjlCRPBgrTEUOPj
 APvNPdHkSYfTI6OcVKHxyZy6s9fWhfls44+vZgvLMiHh8egS9nKKjytWX+g8knIouae6431BIRf
 f8iGpqnkrgXkQUEhZAw==
X-Received: from wmgf12.prod.google.com ([2002:a05:600c:154c:b0:490:adcb:7374])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:e555:20b0:490:bd66:e523 with SMTP id
 5b1f17b1804b1-490e560b322mr11403345e9.20.1781165020957; 
 Thu, 11 Jun 2026 01:03:40 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:03:39 +0000
In-Reply-To: <20260610-gpuvm_smcontext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com>
Mime-Version: 1.0
References: <20260610-gpuvm_smcontext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com>
Message-ID: <aipr26YVZZMVKIt_@google.com>
Subject: Re: [PATCH] rust: drm: gpuvm: add SmContext lifetime bound
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, laura.nao@collabora.com, 
 samitolvanen@google.com, boris.brezillon@collabora.com
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

On Wed, Jun 10, 2026 at 05:04:31PM -0700, Deborah Brouwer wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> If a DriverGpuVm implementation is lifetime-parameterized, its
> SmContext<'ctx> type may depend on lifetimes carried by that driver
> implementation. In this case, SmContext<'ctx> is only valid if the
> driver implementation outlives 'ctx.
> 
> Add a Self: 'ctx bound to DriverGpuVm::SmContext<'ctx> to express that
> requirement. Then propagate the corresponding T: 'ctx bound to the GPUVM
> state machine helper types that store T::SmContext<'ctx>.
> 
> This allows drivers to provide lifetime-parameterized implementations of
> DriverGpuVm.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  rust/kernel/drm/gpuvm/mod.rs    | 4 +++-
>  rust/kernel/drm/gpuvm/sm_ops.rs | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
> index ae58f6f667c1..1ec649fa50ea 100644
> --- a/rust/kernel/drm/gpuvm/mod.rs
> +++ b/rust/kernel/drm/gpuvm/mod.rs
> @@ -264,7 +264,9 @@ pub trait DriverGpuVm: Sized + Send {
>      type VmBoData;
>  
>      /// The private data passed to callbacks.
> -    type SmContext<'ctx>;
> +    type SmContext<'ctx>
> +    where
> +        Self: 'ctx;

This imposes the requirement that the GpuVm private data cannot contain
any references that expire during 'ctx. Since 'ctx represents the
duration of a call to sm_map() or sm_unmap(), this seems reasonable.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
