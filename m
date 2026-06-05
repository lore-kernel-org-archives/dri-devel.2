Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C7CCD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9572411A8A7;
	Fri,  5 Jun 2026 14:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="AK9jWb9C";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0485911A89A
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:04:11 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-490ae3bcf4cso10363775e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780668250; x=1781273050;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=KzxQflFVSTadDNXMRobclacHPyZHXHcPR4PL2Kdl0Ys=;
 b=AK9jWb9CQvSLBOXAKNGV5974SxqiRSOg0NVYoKYbweJhS7BadG0pPDIG3755mDnnz2
 3aY1YxMoesF3lOUFo/AxDGqgzRFbMdShCUkNDFkLCGevycdttCi2bce3MA2jQ2FDdKKn
 XKwJKijtIjQwF4A7eh6XzY5wBIyfdbrvGqkpRLfl3u9QgsFqrrgqrRLFmQ8qeYtepvsh
 gWgiJxHF8Z8hzpXmqg75HWt2S0L866bSy7smNI+d/UsP7nVQges3ehpvgMYdY133YSoC
 hkK627lPRTPLBWCmo97mCUD05YCMKpcZsaATBaRSWZIYKYiPOzmYYG5NQSzZeim4/QJ2
 mpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780668250; x=1781273050;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KzxQflFVSTadDNXMRobclacHPyZHXHcPR4PL2Kdl0Ys=;
 b=mKHoWKUGYR6MwsGUUV9SOLS6Of19xJ8jfAtbdgS+EokAyWcIoDsa7USTrOIdUNTdMs
 qdxz+sZ7hLHU1yaQkLSpgjpeegJA7HfXVpJ3pMtPAPPF70w/4wUi5pLA0o/mLAERSKIC
 dVQ5M6photPjSq2fjNbnMFqLAY0EMTrtLLUzd0QOSJjHxmb79/QAzMjumMWnl/yPbh43
 FDsIUabl0Hrg4WqzUHCYfpoiujbxu1OahqJZOTE/QwgWUCeTCEXaf3+GTjU2zXf0RFra
 FO3SsdSKfur7xUYhsavwlPXoq92hZFuUlzDGATrhPKZpFWbpjtGbN2rRY4mDg/FOzumU
 r9wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hVj4vhmmBZS0jqTi4++EbUo+pRNL/iYmNMqZXF8pxXfIsC8yzVF5ZKgJNT/o9Rp9cJnKz88pUifE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3eOGTeIz1KWd26DxQz1oVhjvwOkQb/vMZPAoj0p9aKtgHtxIs
 CVySMNHJB1qTevghAzYJEyx0FKG5xGTWdEF/zRfAbk/M9IAD3AVosf4VTznMxIz0sY+pFglGylP
 ClqFUGoZOX+BTvR4i6Q==
X-Received: from wmsk10.prod.google.com ([2002:a05:600d:848a:b0:490:acbb:67d7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45d1:b0:490:b9c3:6c62 with SMTP id
 5b1f17b1804b1-490c261007dmr52711405e9.28.1780668249942; 
 Fri, 05 Jun 2026 07:04:09 -0700 (PDT)
Date: Fri, 5 Jun 2026 14:04:08 +0000
In-Reply-To: <20260605133541.22569-6-boqun@kernel.org>
Mime-Version: 1.0
References: <20260605133541.22569-1-boqun@kernel.org>
 <20260605133541.22569-6-boqun@kernel.org>
Message-ID: <aiLXWHg22P6OTb7O@google.com>
Subject: Re: [RFC PATCH 3/3] rust: rcu: Introduce RcuFreeBox
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Andrew Ballance <andrewjballance@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
 maple-tree@lists.infradead.org, 
 linux-mm@kvack.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Philipp Stanner <phasta@kernel.org>, 
 Lyude Paul <lyude@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
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

On Fri, Jun 05, 2026 at 06:35:41AM -0700, Boqun Feng wrote:
> The current RcuBox will call the `drop()` function after a grace period
> inside an RCU callback. This suffices for maintaining a RCU-protected
> object:
> 
>   RcuBox::drop():
>     call_rcu(
>       |..| { // <- call back after one grace period.
>         T::drop(); // <- call the destructor of the inner object.
>       }
>     )
> 
> However, to support a different RCU usage pattern as below we need to
> extend RcuBox:
> 
> 1. clean up the object, and unshare it from future RCU readers.
> 2. wait for an RCU grace period.
> 3. no other RCU readers, we can free the memory.
> 
> An `RcuFreeBox<T: RcuFreeSafe>` is introduced to provide support for
> this:
> 
>   RcuFreeBox::drop():
>     T::drop_before_gp(); // clean up and ushare.
>     kfree_call_rcu(..);  // free it after one grace period.
> 
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
>  rust/kernel/sync/rcu.rs         | 31 +++++++++++++++
>  rust/kernel/sync/rcu/rcu_box.rs | 68 +++++++++++++++++++++++++++++++--
>  2 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index 7da6b8d22277..7c26591bb318 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
>  
> +use core::pin::Pin;
> +
>  use crate::{
>      bindings,
>      types::{
> @@ -82,3 +84,32 @@ pub trait ForeignOwnableRcu: ForeignOwnable {
>      /// [`from_foreign`]: ForeignOwnable::from_foreign
>      unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorrowed<'a>;
>  }
> +
> +/// Declares a struct is safe to free after a grace period if all readers are guarded by RCU.
> +///
> +/// # Safety
> +///
> +/// Implementation must guarantee `drop_before_gp()` makes sure no future RCU reader will access
> +/// any part of [`Self`], as a result, after `drop_before_gp()` return + one grace period, no RCU
> +/// reader will be on the object, and it's safe to free it.
> +///
> +/// Notes for implementators: implementing this trait in general requires `Self` being a
> +/// [`UnsafePinned`], i.e. a `&mut Self` is not a noalias reference if `Self` has non-trivial
> +/// `drop()` function.
> +pub unsafe trait RcuFreeSafe {
> +    fn drop_before_gp(self: Pin<&mut Self>);
> +}

Should this have an associated type for the rcu-safe view?

pub unsafe trait RcuFreeSafe {
    type RcuView<'a>;

    /// Access this value in a manner that is safe after
    /// `drop_before_gp` for one grace period.
    fn rcu_view<'a>(self: Pin<&'a Self>, _rcu: &'a RcuGuard) -> Self::RcuView<'a>;

    /// Drop this value in a manner where it may still be accessed via
    /// `rcu_view` for one grace period.
    ///
    /// # Safety
    ///
    /// All other accesses to this value must happen before the call to this
    /// method, except for accesses using `rcu_view`.
    fn drop_before_gp(self: Pin<&mut Self>);
}

The idea being that once you call `drop_before_gp()`, the value
immediately becomes unusable as the type itself, but you can still use
it via `rcu_view`. The `RcuView` type can then be a type that has a
subset of the type's methods that is safe to use for one grace period
after `drop_before_gp`.

If you define the trait like this, then PollCondVar becomes RcuFreeSafe.
It can't be RcuFreeSafe today because you must not create new waiters after
`drop_before_gp()` is called. With this modified trait, it can simply
not provide methods for registering new waiters from the RcuView type.

Alice
