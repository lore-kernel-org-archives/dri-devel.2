Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440EAF33804
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C66910E33D;
	Tue, 17 Mar 2026 06:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="HTXgldAm";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA9910E33D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:50:03 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-485c45885e6so2064925e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773730201; x=1774335001;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FxvRr8+lOBB6LohtXEdeEzhkagUanjKQw+ztADkvzGQ=;
 b=HTXgldAmjNEuLJXJQQVaOYJimOMnUWcQfGTYeZtWsr5FhMs0qf8S2n0H505xaAlSiU
 QdMmeXFiMEcGU4iES6nNG4C9br9dgSUodwiJMtGHnRl1l+S2UhXib5b7P2fTdcwyXU1A
 rY/gEPL1EjGa/sqqfGdIlYVs1VzB9Ht/KfBcW0NFEHhJ0BNTWym1Z8S7V+BkRm95/D4T
 PQsSGQi93lbCgR9IlE0KcksXYiT6dD00td9U1E8MExSbCN+m+0/McpUnH7VH5l1vSgXQ
 jbBlo55KHN/zFLwnObbRSzT8CsPRxVU7zKOqOD+i1LRsI3P/57jZgfyZhnEyn1kDESYE
 3sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773730201; x=1774335001;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FxvRr8+lOBB6LohtXEdeEzhkagUanjKQw+ztADkvzGQ=;
 b=V/6uDHwz+dPljlSgIs94N4e6qgytjlJBI+d1VsBC9t4kXDMGYRaHQCsqU33s163s8R
 GfS/uV/z5kQViRGeRUOb5ZdTisgiZXW4FR5IHovfcJLJQDLEATMcak4tq3WWX2yaR428
 dBpe3wQQ/TSFm+y40phKqLziTiBontG0ACUAifHOonboUED26OQ0+aHfBq3a681BTjUP
 pNvPzezFh2/9B4/i9ITSx2JGDV/Gb05NFmkblmygMgQpktlHeHcSXeoHAKn6hxjOqcZ6
 63MKPcbSCmJob2D8FVdyukdQLUbVY7e748GHLeYTfa/P+4um7Cki4+eZIJ3LVDPkBkWl
 Y4HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHrlv22lwjeqpfn4P1hd12kSbI0aVLGFFdcn5RdjLyzb3h50djaKZpajMfeR9qYH02g3ghD6AYgb4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXlDlFR1QwGoFDqxcMY51Lam0rEb3UK0HBulC/QCv3KINNYNut
 APpWxt6d4b37JNUoakaIe+4B3c+0j/oW7rC+Jm8P2nHomDZu4a1Il5xddtpThgT7hPlbyztVZrw
 JGLg3Cy8+3uEI6NaIKA==
X-Received: from wmop12.prod.google.com ([2002:a05:600c:468c:b0:485:40d2:1eb1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8519:b0:485:5812:bb9e with SMTP id
 5b1f17b1804b1-4855812bbddmr300430745e9.0.1773730201517; 
 Mon, 16 Mar 2026 23:50:01 -0700 (PDT)
Date: Tue, 17 Mar 2026 06:50:00 +0000
In-Reply-To: <20260303162314.94363-3-dakr@kernel.org>
Mime-Version: 1.0
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-3-dakr@kernel.org>
Message-ID: <abj5mOYQAY290nqY@google.com>
Subject: Re: [PATCH 2/8] rust: dma: add generalized container for types other
 than slices
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
 robin.murphy@arm.com, driver-core@lists.linux.dev, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 03, 2026 at 05:22:53PM +0100, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Currently, `CoherentAllocation` is concecptually a DMA coherent container
> of a slice of `[T]` of runtime-checked length. Generalize it by creating
> `dma::Coherent<T>` which can hold any value of `T`.
> `Coherent::alloc_with_attrs` is implemented but not yet exposed, as I
> believe we should not expose the way to obtain an uninitialized coherent
> region.
> 
> `Coherent<[T]>` provides a `len` method instead of the previous `count()`
> method to be consistent with methods on slices.
> 
> The existing type is re-defined as a type alias of `Coherent<[T]>` to ease
> transition. Methods in use are not yet removed.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I see you have both `size()` and `len()`. I think it would be clearer to
rename `size()` to `len_bytes()`.

Otherwise LGTM.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

