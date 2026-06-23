Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0078DCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D3C10EC27;
	Tue, 23 Jun 2026 17:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="SaENjC/C";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112B810EC27
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1782237341; x=1782496541;
 bh=3anUjfUqAfKXRz52ChpQC6zD/lO83bxGXry/MLwNSO4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=SaENjC/CMfJZ7aHHoNXuyYXWirhvR5ckMqH4I14+a2qrFUk93bDnMCqeErFBQUP0v
 PxAWcf5MDaK/h1+PD7Xztk8DHBmAJYuQzUbbofQh31Vb4K0rPbNtP+Zj5Ti0PaEz8l
 y7CEtR0ABhnvuBrjq3wJCkhsDkXd88Kz77ci8Kb9M/DzKOTlJnxdVVucC3zmG0+KJo
 xF912ecuCseGcuSm2pLKB+3MqPL1t5fQg6fwfBm0AgiTbsz/L7KnDM+K/Mc8yoO1Cu
 m/g4LsTaCYFIk2IHmf42GmBOu40VhyMkU9d5U+5iUSwTb8XcKR+78rOM4IGjygJn3N
 vwMFoIeCYeWDQ==
X-Pm-Submission-Id: 4glCQr5V5Bz1DDKr
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v17 08/10] rust: aref: update formatting of use statements
Date: Tue, 23 Jun 2026 20:55:29 +0300
Message-ID: <20260623175531.85421-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 04 Jun 2026 22:11:20 +0200=0D
Andreas Hindborg <a.hindborg@kernel.org> wrote:=0D
=0D
> Update formatting if use statements in preparation for next commit.=0D
=0D
I guess you meant "formatting use statements"? Also, why not doing this in=
=0D
the next commit directly?=0D
=0D
Onur=0D
=0D
> =0D
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>=0D
> ---=0D
>  rust/kernel/sync/aref.rs | 7 ++++++-=0D
>  1 file changed, 6 insertions(+), 1 deletion(-)=0D
> =0D
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs=0D
> index 7491382bcf29..818c84fa923a 100644=0D
> --- a/rust/kernel/sync/aref.rs=0D
> +++ b/rust/kernel/sync/aref.rs=0D
> @@ -17,7 +17,12 @@=0D
>  //! [`Arc`]: crate::sync::Arc=0D
>  //! [`Arc<T>`]: crate::sync::Arc=0D
>  =0D
> -use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonN=
ull};=0D
> +use core::{=0D
> +    marker::PhantomData,=0D
> +    mem::ManuallyDrop,=0D
> +    ops::Deref,=0D
> +    ptr::NonNull, //=0D
> +};=0D
>  =0D
>  /// Types that are internally reference counted.=0D
>  ///=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
> =0D
