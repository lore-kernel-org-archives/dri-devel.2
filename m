Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FECBCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A787010EFD3;
	Wed, 17 Jun 2026 11:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="eyBtFq4F";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC84910EFCA
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:36:34 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-69555d2711cso760040a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781696193; x=1782300993;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UYicJoYFI4w4qF8sCnn+jRXzXN1/GRmTZzaGc7Ox2u4=;
 b=eyBtFq4F3MRMF1ZZq+b0VjoxfcYIl0NDqirl8/ZYEK6sG7Mr1C4xBi70wGQn4JAAkO
 iBjdnW2j5s6WoxpiAgHpaHrMtxyPUcHkkVeaxzsFyyMq3P/69mtIi6jcDUR+BVns8agC
 Wh7amMNh2fh+xeGNP4qx9Mwqa2tvPhaqIIv/yWmKOvGb3Cd17VJbC+Y+sZx5JWah7529
 AsXp4Wqf5lDATUumyOvJXwAbP34V9dWY6n3V+psdJYMiP8tnJLskDldZ3ONwxB4pAPit
 0vhQtclZVPOoqglA+yblZJeUW8rpSWtR5PI3oCFwi9fXRVk+lT7QjizLcpOiO1mwqCVW
 A1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781696193; x=1782300993;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UYicJoYFI4w4qF8sCnn+jRXzXN1/GRmTZzaGc7Ox2u4=;
 b=ZGzSMlVj1sF1eWt+KL2K8e/7IhcOK4vKPABxErXCpamwwJCIb164pAXD7x9kSGX1YK
 W2y/dLsELxlxL79wv9OJgCCCJYyGUNTItLBkRoEdWDxcr/PWYkSEuGuQKk6PIVDQjijK
 p9KZLej+aS3/VMRGv0vEbtTPoD6jfqCqcSvdY6r1uojNhvRqATTPLnz5AEEJh43F6jx+
 3ehmmRN42BUcdfwKUuan5obYiQkqg/GiKtjL4piD3XuQuxq5zKPRcdHdELsFOIv3/4Jw
 WKmIl7wRIxSCYpVWcSuvlWxk9BDMOwV4qithnMN4Pk974CL0Z/JO/5w1NI5YRm46m4z0
 n+bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5ttxXnO/X9hTL6QtO8kK3vKAIK+JN6G/s1e2Csw7lFuWthVjJDFDSEcgzFvl6mdRVDZSF+ge3pP4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yztmhl3ZtJ5wHTgizxLoJnAuAcOe7fov2g0npiijVrL7yzIEd8N
 m8S3DeR1TgwvSAlR51WrOtF2Y8tGBaILpYaZjaQtNj2OBPE8QRrxd5CEyWn6HVzBQ0+vnZNmPTB
 6+99h8aeD9zdn+kA7Hw==
X-Received: from edea23.prod.google.com ([2002:a05:6402:a197:b0:695:72e1:a5a0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a50:cbc1:0:b0:68f:9fd9:435a with SMTP id
 4fb4d7f45d1cf-69554cac360mr960260a12.17.1781696192851; 
 Wed, 17 Jun 2026 04:36:32 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:36:31 +0000
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
Mime-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
Message-ID: <ajKGv5ioLSassmND@google.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 Asahi Lina <lina+kernel@asahilina.net>
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

On Thu, Jun 04, 2026 at 10:11:17PM +0200, Andreas Hindborg wrote:
> From: Asahi Lina <lina@asahilina.net>
> 
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/page.rs | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 3bdcee0e16a8..844c75e54134 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -10,6 +10,11 @@
>      bindings,
>      error::code::*,
>      error::Result,
> +    types::{
> +        Opaque,
> +        Ownable,
> +        Owned, //
> +    },
>      uaccess::UserSliceReader, //
>  };
>  use core::{
> @@ -105,7 +110,7 @@ pub const fn page_align(addr: usize) -> Option<usize> {
>  ///
>  /// [`VBox`]: kernel::alloc::VBox
>  /// [`Vmalloc`]: kernel::alloc::allocator::Vmalloc
> -pub struct BorrowedPage<'a>(ManuallyDrop<Page>, PhantomData<&'a Page>);
> +pub struct BorrowedPage<'a>(ManuallyDrop<NonNull<Page>>, PhantomData<&'a Page>);

BorrowedPage<'a> is no longer needed because it's just &Page.

Alice
