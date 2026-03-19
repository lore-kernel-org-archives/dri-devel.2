Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA96C1090233
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57ADA10E8F0;
	Thu, 19 Mar 2026 14:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="f2LP+u3C";
	dkim-atps=neutral
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E032C10E8ED
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:33:21 +0000 (UTC)
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-b9399d68111so109743866b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773930800; x=1774535600;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=WPdU0RGKwneFH7OF6wzVXdtsY6BXzcqmiGE7v4NtV4M=;
 b=f2LP+u3CltkBxiIAGyhH2rcaFZfDJ+dX0lUvHUZZ4386z1aOUE2cvSaitMHeG6so7f
 hUJBstCkWa9Im6tLgN5BHE7Rv4BeIVyAwEnwahxR4msquyIz4Gd+ko6NWJMjOxab2CAN
 fm1bXDInNXmLOJr20aRhRoK+jknE6Y53SiQBr1O9e+TFdQdMqPhXH70WaTba8Q/r5Jck
 9xCGXao+6c+KVXBtDpEPzX+rERypflsWWeY9I+EkMTD4dBLTr/nhr/8TCJrj8iv7y1qb
 o6VBZ6tZ1kvsCPfZc1YUXmtx1uLsy+baqnHxbNkmYC8rle6+md1basrY65cm8jVw3cO8
 Qjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773930800; x=1774535600;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WPdU0RGKwneFH7OF6wzVXdtsY6BXzcqmiGE7v4NtV4M=;
 b=ESSDOy/zv1t2xtIGZ+yeTpRs7PylGp7/Olqg03Nk+PLqiAv8sETli8A5zd0Ow3DYIe
 KaMXWA2pBOCXVNuzXVgoZfkZx8cqeMTrdKLkytWkuyiRohD/skHurRGtJxiBbaNorsZ7
 Er3lsN69S2AlFEpd7ysb4ReM/0Rt5Zk9YjIcNUEFP3RYZSzeVjV/adzjkYwYofU69NG7
 IWafKAnbmKicJ7IBgU4AigZzQdeuZ3sDoW3UC/9qXhXFifa5xlUJAkGAhdVYXU1PSyYo
 W+VP/pn1kCbAMhuGSXX08pBMODRW+3qAFtrYYO3yBXiv/kfDwFjUM3xcyX4fLVSb5cy3
 7WKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHBIw3OQFDC7pU1/bU+wObmTzdb25qu5pkwr1FM6RhvWpBa7N9/OHrCKwSZY9QB2B/quIXr2do3Jg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjrxcEUuZkMqGIKvdVW5IIw0cdJRYOEOgSkgTw6d+CSZ4U2ZGg
 TZ0CDk6LMYhC+wa7XD6SRWmLpgVuk78fbrm+qdbn0wEkhgSCgQGsU03bd4KFsRphWwp1Mbqgo0f
 RtaFsvMpav+0qkXjiOA==
X-Received: from ejcdo3.prod.google.com ([2002:a17:906:c103:b0:b97:ccc1:b250])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:1d01:b0:b97:b9d5:4ae4 with SMTP id
 a640c23a62f3a-b97f48c3840mr428088066b.20.1773930800216; 
 Thu, 19 Mar 2026 07:33:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 14:33:19 +0000
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
Mime-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
Message-ID: <abwJL2OTFzSFdVxt@google.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Tamir Duberstein <tamird@kernel.org>,
 Yury Norov <ynorov@nvidia.com>, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, netdev@vger.kernel.org
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

On Thu, Mar 19, 2026 at 12:16:48PM +0000, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Given the macro scoping rules, all macros are rendered 3 times, in the
> module, in the top-level of kernel crate, and in the prelude.
> 
> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
> re-export inside `build_assert` module so the top-level items are hidden.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
