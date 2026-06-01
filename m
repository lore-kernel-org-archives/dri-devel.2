Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E84DCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FCB112F82;
	Mon,  1 Jun 2026 08:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="s0Xa52lw";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19689112F94
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 08:27:25 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-490a762bcbaso9538495e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780302443; x=1780907243;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fq7ALf+FOEjLDdqPLEA45eziVb8cwXdfxyjqJN+Z0NQ=;
 b=s0Xa52lwH/lfJN9unZ+YdTtIQdJIO84ZJoual5sjkWdZsyP3xph53TjcmVHw5E8lyQ
 uSTf8qAVgmsw1XKD2R6TY1XiqyZK7uWn2Fq/b9KG3oewZBAS7ZoTcn1Ja/5QN7Htonnb
 kSHTvf8ZytnapQKkExIGW0DrrPDZmidgwgT2aWRGL/nM3sZQ0MU9dYAbHTQjVZt6oCST
 Oy9303dMAW8yui15+imao8V1VmLQJqPnqjzHBKYKsW9MKkFPWe0jPV/h+wnQr6wVbQ2M
 v6dCw696032c6KzXqSD6vqGPahDKnkybDTsHUcL4D1NWd0N5hVyfZx/Rm/6OpDW46Ns/
 STNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780302443; x=1780907243;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fq7ALf+FOEjLDdqPLEA45eziVb8cwXdfxyjqJN+Z0NQ=;
 b=tJ5+SRmOCWjq2yYb76aumpZ6Ol+AY6EjS7BUEYT1PapbfrTMAj1FAewKL9aJlv3bLa
 KILEg6DsIsWSB0UEruCdxQn/9AYLQQsUydfq3KtazLxuFpxmoqGSehgZyviTz5MWnHcb
 yP9XvGSpoUGHkDR1eXhA/crElPnFXreVVoQ4TQU4k8IhQkooWCJaVr9lsnFetkRSbOYk
 zZDqD6O/koKRz60264VZZOrEh2i5fvpORHZ4oEHIZrmAiqFXweUuro4HpiDLtKHJshQa
 wFn6wXhE0mRWNLQ+1u1tIdciqnBiQi8Wlm1h5KPKLjnOxfZQIXoU/tDlYlQ70Ajd18Yb
 jpgA==
X-Gm-Message-State: AOJu0Yz2+DW33+D7+CC/t9gjdq36taTfp0COf8YPSSsxtTLDY1vFnc09
 wOM24alIYDF8igc1pM15xXLFz6yQN8pA+vipwfXFC3mcpMDM25/IuLDZEfEUfvvPjblfM9d08Gm
 iYh5qJ3EL6ouCYuuqSQ==
X-Received: from wrbdm2.prod.google.com ([2002:a05:6000:bc2:b0:445:168d:28e9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e92:b0:48d:366:b962 with SMTP id
 5b1f17b1804b1-490a2900ef2mr188288625e9.6.1780302443446; 
 Mon, 01 Jun 2026 01:27:23 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:27:22 +0000
In-Reply-To: <20260529173137.303717-3-lyude@redhat.com>
Mime-Version: 1.0
References: <20260529173137.303717-1-lyude@redhat.com>
 <20260529173137.303717-3-lyude@redhat.com>
Message-ID: <ah1CarNtFhCvAAav@google.com>
Subject: Re: [PATCH v2 2/2] rust: sync: Introduce LazyInit
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>, 
 Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Tamir Duberstein <tamird@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Benno Lossin <lossin@kernel.org>, Will Deacon <will@kernel.org>
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

On Fri, May 29, 2026 at 01:30:42PM -0400, Lyude Paul wrote:
> SetOnce is nice, but it does have one problem - you can't use it with
> fallible initializers. While we will be adding support for doing that with
> SetOnce, this leads into another problem: There's no way for racing callers
> to actually block on the initialization of SetOnce, which makes it a
> difficult type to use safely for situations where we want to initialize
> data fallibly once, and then provide access to it to multiple users at once
> until drop.
> 
> So to solve this, introduce a new type: LazyInit. LazyInit is like SetOnce
> with a couple of important differences:
> 
> * It can't be used in const context
> * It can handle in-place fallible initializers.
> * It uses a Mutex for synchronization instead of an atomic, allowing
>   callers to block on initialization.
> * It requires its contents already be Send + Sync, since the Mutex protects
>   initializing data and not the data itself.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

> +    /// Retrieve the contents of `inner.data` and extend their lifetime.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller guarantees that `self.inner.data` has been previously initialized.
> +    #[inline(always)]
> +    unsafe fn data<'a>(&'a self, inner: &MutexGuard<'_, Inner<T>>) -> &'a T {
> +        // SAFETY:
> +        // - Our safety contract guarantees `inner.data` is initialized.
> +        // - `T` is `Send` + `Sync`, and thus does not need the `Mutex` for synchronization, making
> +        //   it safe to hold onto outside of the lock.
> +        // - We're guaranteed via `Inner`'s type invariants that so long as immutable references to
> +        //   self exist, `data` cannot be uninitialized - ensuring it lives throughout the lifetime
> +        //   of A.
> +        // - We're guaranteed the container of `T` will not be written to via `Inner`s type
> +        //   invariants until `Drop`, ensuring it remains populated for the lifetime of 'a.
> +        unsafe { mem::transmute::<&_, &'a _>(inner.data.assume_init_ref()) }

I'm not a big fan of using these kinds of tricks to access the contents
of a mutex after unlocking it. Could we instead use a struct like this:

struct LazyInit<T> {
    data: UnsafeCell<MaybeUninit<T>>,
    set: AtomicBool,
    lock: Mutex<()>,
}

or even:

struct LazyInit<T> {
    data: SetOnce<T>,
    lock: Mutex<()>,
}

I think this logic will be simpler for everyone.

By the way, another option is to use a similar strategy to
https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-2-f5b4c747eac2@google.com/
where you just use SetOnce and protect calls to `populate` by another
mutex in the structure. Then you don't need a separate LazyInit.

Alice
