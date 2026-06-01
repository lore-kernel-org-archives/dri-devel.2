Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B035CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF379112F87;
	Mon,  1 Jun 2026 08:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UHbhTkWC";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1269112F87
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 08:28:23 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-68bc68bc910so3281992a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780302502; x=1780907302;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=FNCDtya95lHSsHMXITL21ruuRscfBvAweyPJ3bnEneE=;
 b=UHbhTkWCLakpIXc7k9sF9bdCswzJysspkwOE9jLvwXxKKnAbxUnCDDsj5ZM0TbKrXJ
 daxkpUhgolgy65z29U53opbPwS2kQrlmcC5Nrz+wv2fCZpNj4HylwafBUsN15KkFG64x
 1QLqV7esm6oUFRqPYJnOAEQnVfxywD8CR3WPAhC+WAw/pk/K7ZZjFtKBKA6ZKVhkXXSC
 lBAnpY1T2mbN+YXfLsrbVlEv0mrf9YeI7nXKYHUcjiHS7W1Jt1r5cPO7aG6dJ/uN8xcG
 8GejRjBkOIyizlcixIVK7mHxJs5Wypv+TavxmI7o11bTlpYi4WmTd75IfSkxZb04b3EU
 YRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780302502; x=1780907302;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FNCDtya95lHSsHMXITL21ruuRscfBvAweyPJ3bnEneE=;
 b=YG0e5oaF6ZQfE5/wr6/LCagnfWS0DvPYjNnR9xuopirMD6nmE3zyvctDBZr4AVf7pk
 oM6GePT0HIo8W7aUfJyeKksvqQtxw3+FoZSAEqgwRof4iszso/QwCkgBdurbdNZ7Axvz
 5HA4Ec5EG0lCm5Osa/tyEdL97b/z0uZE6lnKSBQnq0DJpYnxWpzDXkvxxY778XLgi0xA
 gjaikm1hqINdumt/Jl+qwxhk3TbM+URUfv6UYVVUFjrVTVGorS9vxAVdDiVEmYPcNc9H
 UXPAxvWkLeLoCfA3ScKBcZr+qyf3HiIYkC8/L3NwdcN4LmhehLDmf/UkF4VCKanbjsiF
 4feA==
X-Gm-Message-State: AOJu0Yxcl7X/lAxoVD5xjbV/vQCAffm1HBqoCHRk7vR0YjXoeJhzFbim
 uc3QhxDHItgDx/BDqcwPxGeBIGTtFaq5ESrjLegUt33iQ3kbad7hIjPqgCqQv9GkwJtNI8Wqsq7
 pTwogxx2RBE/zJglTyg==
X-Received: from edbdk3.prod.google.com ([2002:a05:6402:1d83:b0:68b:767b:1828])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d1d3:0:b0:671:9dec:ba3 with SMTP id
 4fb4d7f45d1cf-68c07b60fc3mr4435388a12.13.1780302502114; 
 Mon, 01 Jun 2026 01:28:22 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:28:20 +0000
In-Reply-To: <20260529173137.303717-2-lyude@redhat.com>
Mime-Version: 1.0
References: <20260529173137.303717-1-lyude@redhat.com>
 <20260529173137.303717-2-lyude@redhat.com>
Message-ID: <ah1CpIJaWBiUrNNr@google.com>
Subject: Re: [PATCH v2 1/2] rust: sync: lock: Add Lock::get_mut_pinned()
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>, 
 Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Tamir Duberstein <tamird@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Benno Lossin <lossin@kernel.org>,
 Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

On Fri, May 29, 2026 at 01:30:41PM -0400, Lyude Paul wrote:
> These two functions are inspired by the Rust stdlib equivalent:
>=20
>   https://doc.rust-lang.org/std/sync/struct.Mutex.html#method.get_mut()
>=20
> The idea here is very simple - if the user has access to a Pin<&mut
> Mutex<=E2=80=A6>>, we can guarantee that no one else can look at the data=
 protected
> by the lock. Thus in such situations, locking the mutex isn't necessary t=
o
> access its contents. This can be useful in situations like `Drop`
> implementations, where we may want to access the contents of a Mutex with=
in
> a struct before dropping it.
>=20
> So to do this, we add `get_mut_pinned()` to `Lock` - which provides a
> function to access the inner contents of a Mutex provided a Pin<&mut =E2=
=80=A6>.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/sync/lock.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 10b6b5e9b024f..5ca36baed34f5 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -190,6 +190,17 @@ pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
>          // that `init` was called.
>          unsafe { B::try_lock(self.state.get()).map(|state| Guard::new(se=
lf, state)) }
>      }
> +
> +    /// Returns a pinned mutable reference to the underlying data.
> +    ///
> +    /// Because this borrows the lock mutably, no actual locking needs t=
o take place - as the
> +    /// mutable borrow statically guarantees no new locks can be acquire=
d while this reference
> +    /// exists.
> +    #[inline(always)]

Normal #[inline] is sufficient.

> +    pub fn get_mut_pinned(self: Pin<&mut Self>) -> Pin<&mut T> {
> +        // SAFETY: We return a pinned T, ensuring we don't move T.
> +        unsafe { self.map_unchecked_mut(|data| data.data.get_mut()) }
> +    }
>  }
> =20
>  /// A lock guard.
> --=20
> 2.54.0
>=20
