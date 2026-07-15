Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B03C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAE089561;
	Wed, 15 Jul 2026 14:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="WbcNhu24";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C9B89561
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:09:23 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so49173175e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784124561; cv=none;
 d=google.com; s=arc-20260327;
 b=srZkQBJr5PstG5PtIPx7bLg57UK2VCxdw9LKCs7JBAHU7IkXvzcxZk0CGAuOoF3tRP
 eV0leNBHLPF9aV6uY3DCnZPyA2aARueaHhsC8QSa7AsDP1dXdQM+KTKryr0R+LtY7pLS
 SQxqiPEoo2qDwoune9lD9S90IZUGtgMpgaWlacy0ogFeLLcKt6asmvYpqwNsLqd9qyvm
 YJYEiWH8ns9WGOKZ1SHnnYBdlr+OlTJ/djcecHrdeaZdPdiPgjkaHK4BaytkgPQaUz5W
 JTDMXJxJ5xUJbsAnEaRBswrQayY+Wrixo4cyDNe5n4Vn8gOVWGZdeGcK5EUfoeDBLyTz
 vbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1mcx5kizqsJiWKU3Assktv3idKETuJ14oVMLxFKExzM=;
 fh=n4ElHvlDmHHbJriYQoMDSMmMcjo+hH/BQgcaqEjXLN8=;
 b=aK3ZIxAGH33w/M1siOC0tWR82nBMP7BxJJzNe+Ipzf1i2jleP5V6LpDgrCl82bs2JU
 ArMxJhQdVjqhcbSKqRXgRAz7dsQsNIs4N8zV+jbSuFIMFhBzO9DRRqr08EK5KpHukrfJ
 qigPqkr+lTXNV3z9zJZnRlwWjkPmatTacAZR+kgyQtq6ctRt8qq2rdu1C1Lpa16a+thf
 0HiYUaKA5uHDJwNh+dL3aWyT6cjw4pBhB/4/ftUAHDmRjLd5Zl882g0vmbg+IvxGCKFf
 oNAPwszY2cH8/rs6975E7LZRV1XXkIQ629HETZTNbiA1QAkFpTWLAqOIOyrxVEdCgoFa
 L9mg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784124561; x=1784729361;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1mcx5kizqsJiWKU3Assktv3idKETuJ14oVMLxFKExzM=;
 b=WbcNhu24El/2JxPOOpsU8/w+fHPmktR4q275r2Na9PyuZRXp9dbpywJb2r25Re9oll
 3rodtxHbYraDAiKo9mxY8Yp18ZNg/KDO+01Q5gduqCVDy7vjPj4MnekV3vk0nasQnGE7
 U6zPwC+FFERk4scBIzWMf0/EwTlU5+APC7HOTMobJcoWXs/lCgpQFu/iPSZKMR0YoIwk
 85y7EeLOw3xQ/NY63PtBbfueJxxTUfDugyTSsWRh15nx5rDBTI9nuwkuC3VzmiWj55/4
 H/EdXTZM+BuDqNKMjgs+2z2hyPX8Zd+vIrIqG69aDbtTnt9U/PQ9S4gFgvxati5Qmbxy
 gc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784124561; x=1784729361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1mcx5kizqsJiWKU3Assktv3idKETuJ14oVMLxFKExzM=;
 b=P7ZxOijWcQqrqw2Lbn+mXOT2yah7r2Py7os8OyhyAsiYhIZbL7JQA/m1u1fiRrwja2
 j4ovub24Oiyrjfad3EPMBMeuFwwI/gxZQga83WwL/pwN1slW05vD2HtcJM19DzvdVd8H
 qNHZU7xjnM/23oYgj2XWn+Or9FQYWZS4KfUyTZJbpAG8u2P6mhyiBzTt8Ma4o0NWJoNG
 S+SspPQZ8TRWPCAbN2EEOw7Zhn7Ak4A7r1a4lEOTSmpOv1hDG/XUoQ/7yigxlyNATBWe
 ui+mdNBZo9qQ0HRxd14fHGNdgd/KIqv056qUa5GX//vIICB76MqUWaW2BTkMapPwCyVK
 CD8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Roe58L1TKLNym2dSKfFcX48fHgcV1CJ4Rq/YwMHt5cGGKz+mD+ikf//2t7D0CtwbQ7gmMHpY8EmzRU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLTLqBDiNBqVtYhPdRgC+nIyEfCV32/9VPfP6JMt/67NMtVBrj
 pUc3eRw5IwcFnccpCRaRPaxKWfv4PfrbBMkeAmJV9qowg/VCRJrFDQG8U9W6/ngTf0bfpft6R3a
 JI5LsXABaGIpCvpp+DyyOWv3xr7MTvHm6MX4qVZ/W
X-Gm-Gg: AfdE7ckazxRwBLkn+/IAJwoEtO1b2f4Znw3YAhCiUdQTXAUrP1VPNpxT15CzqJz5Gi0
 Zkmz1hIX9M2c7hrrOb3GpDQNZCfZPO+onuQnsUBhfhXdZmK6TlA37uNgeU+Wwd27iDbu9Cs1vIR
 QqNQySlDGVXT/IuNLr00ZjFzMZuRQWeXJ5a9yFgSqjR/7E8EP7Oyq13Vr8Klqz77XjSN4o0gBQf
 QVxaCB4q3Zi6lcE9HwY6rlPMG6/SQNamGH6HsPWUEgsWdY7wKavcWCqCnMofsWksBAFxOOysLVU
 cg0QLfx4k6181a+bigZgJRlXnAY=
X-Received: by 2002:a05:600d:8443:10b0:495:404b:85eb with SMTP id
 5b1f17b1804b1-495404b8636mr4530305e9.26.1784124560869; Wed, 15 Jul 2026
 07:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260605133541.22569-1-boqun@kernel.org>
 <20260605133541.22569-5-boqun@kernel.org>
In-Reply-To: <20260605133541.22569-5-boqun@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 15 Jul 2026 16:09:08 +0200
X-Gm-Features: AUfX_myXsOMxqzySIL_c6wjy_KTMgParE-LvwcdXFSkdOBkOsDSHqrVd6QhTOvc
Message-ID: <CAH5fLggHxeDMm1ygYEGPpjCdfRD8nEsgN31WMvjX3mMPs5p5yg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: maple_tree: Add load_rcu()
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jun 5, 2026 at 3:35=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote:
>
> From: Alice Ryhl <aliceryhl@google.com>
>
> Now that we have a concept of rcu-safe containers, we may add a
> load_rcu() method to MapleTree that does not take the spinlock.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/maple_tree.rs | 52 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 265d6396a78a..1499191b8935 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -16,6 +16,10 @@
>      alloc::Flags,
>      error::to_result,
>      prelude::*,
> +    sync::rcu::{
> +        self,
> +        ForeignOwnableRcu, //
> +    },
>      types::{ForeignOwnable, Opaque},
>  };
>
> @@ -233,6 +237,54 @@ pub fn erase(&self, index: usize) -> Option<T> {
>          unsafe { T::try_from_foreign(ret) }
>      }
>
> +    /// Load the value at the given index with rcu.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Read the value under an rcu read lock. Even if the value is remo=
ved, it remains accessible
> +    /// for one rcu grace period.
> +    ///
> +    /// ```ignore
> +    /// use kernel::{
> +    ///     maple_tree::MapleTree,
> +    ///     sync::rcu::{self, RcuBox},
> +    /// };
> +    ///
> +    /// let tree =3D KBox::pin_init(MapleTree::<RcuBox<i32>>::new(), GFP=
_KERNEL)?;
> +    ///
> +    /// let ten =3D RcuBox::new(10, GFP_KERNEL)?;
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    ///
> +    /// let rcu_read_lock =3D rcu::Guard::new();
> +    /// let ten =3D tree.load_rcu(100, &rcu_read_lock);
> +    /// assert_eq!(ten, Some(&10));
> +    ///
> +    /// // Even if the value gets removed, we may continue to access it =
for one rcu grace period.
> +    /// tree.erase(100);
> +    /// assert_eq!(ten, Some(&10));
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn load_rcu<'rcu>(
> +        &self,
> +        index: usize,
> +        _rcu: &'rcu rcu::Guard,
> +    ) -> Option<T::RcuBorrowed<'rcu>>
> +    where
> +        T: ForeignOwnableRcu,
> +    {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret =3D unsafe { bindings::mtree_load(self.tree.get(), index=
) };

I think this is only legal if MT_FLAGS_USE_RCU is set on the tree. :(

Alice
