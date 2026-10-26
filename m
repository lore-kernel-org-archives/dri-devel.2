Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E054606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eT6zOUVN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD0210E0D9;
	Mon, 26 Oct 2026 09:08:47 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5479410E0D9
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:08:41 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a2065a2ef9so27247645e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793005720; x=1793610520;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6xeXvSy4w9o/b7yWR4xuzrTkC32fzIISOboFKZOljJg=;
 b=eT6zOUVNdy3M3HLIqRL7Y3+lvuE8K9lZ0oqhjUxWaAt1MIRewCaoTrVgfp0Y+nSG9f
 7RuYQS8U5thCZDorgY0jUhhL/XSTMOKMBfIqjPJJBW/FdnBSYxbbb/97k7tno2pr4Yue
 zUQ56OqScX7gUJ7nUcjTbNG1erg63vH4t+qts2utYdgq6GzFCvYqBkEZ/4HQcmqT8aD+
 yx4hpDfzonKnNbD0tZtMt9DvD1FZPMfCNMXjFZgPixdcVYSjnGsKWZ483Vm+xwo+AIqA
 SIfJ3pFXlCzw8n7KnFgGNGFrim5lSJEVRZIDaFJ5vrVasf9DeaPGI626yysm4shQJ32e
 4IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793005720; x=1793610520;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xeXvSy4w9o/b7yWR4xuzrTkC32fzIISOboFKZOljJg=;
 b=mbpDkq8jNZ988LbUib2Q0vYUu2w94B5/BrHynIl+tz/yaM42BEVD722JdcL5Nj92jB
 GfLkchRp5lfnBimhEqSZmsuZGoq2BdA7HawuDoxz6EvNguyofkcU3vL2JHG0+9dMepZT
 zUiLdBhNvFkvP9nGPokCJ590+jKpiGbrK/DlxtLBzaNaUOGKTcK5yzyK80Lzd/hZSi7d
 wYaZBbgHz2Kp+Yb9zMAD/Ce82y36SQyeF9GIPRZPdccz+5CILfQmQOv5kExMM6ApAWqi
 nKaJ6eK63TcjBCV1UpZgyl8dReHXCVbI8/712kB2BK7A0inhPX27BMMua9kTfDEecWBP
 SwKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4EbIJdoH25f8JJk1zVdelwbRJ11zz3n/HenTUmIYyvnPaxhclgSN6PRxx8kgnTvZucLgmh4JPeK4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJBWUrGRSeM3RH1FeeU2wRBDR/CpWggrUKuW58MIolIzZoBUEwN
 nOaY5HCpIjMEwkRaM7QIkDj66kfiY1QQVgRDjuUUMVvsuhzHedPBwhOAN3VxOQxN26phaCZOc2m
 Rg8Hwkcx9ZuGs5kEcQA==
X-Received: from wrvd13.prod.google.com ([2002:a5d:538d:0:b0:48a:fe63:7751])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c9:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4a35acebc28mr107940825e9.33.1793005719194; 
 Mon, 26 Oct 2026 02:08:39 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:08:36 +0000
In-Reply-To: <20261005134010.302208-1-laura.nao@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <arOP5iuLuj1aTiLl@google.com>
 <20261005134010.302208-1-laura.nao@collabora.com>
Message-ID: <at8YlKUJOWc_X-JV@google.com>
Subject: Re: [PATCH v6 2/2] drm/tyr: add Job IRQ handling
From: Alice Ryhl <aliceryhl@google.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com, 
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, 
 daniel.almeida@collabora.com, deborah.brouwer@collabora.com, 
 dri-devel@lists.freedesktop.org, gary@garyguo.net, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org, 
 tmgross@umich.edu, work@onurozkan.dev
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 03:40:10PM +0200, Laura Nao wrote:
> Hi Alice,
> 
> On 9/23/26 10:37, Alice Ryhl wrote:
> > I agree with sashiko's review here.
> >
> > This needs to happen after the free_irq() call in the destructor of
> > TyrIrq.
> 
> Thanks for the feedback.
> 
> In v5, I was masking the interrupts in TyrIrq's PinnedDrop impl which
> resulted in clear_mask() being called after free_irq(). However, sashiko
> warned the device could then assert irqs after free_irq() completes
> but before clear_mask() runs, potentially leading to an IRQ storm that
> could result in the shared line being permanently disabled. 
> 
> So calling clear_mask() before free_irq() should avoid this, but we
> still have to deal with threaded handlers potentially re-enabling the
> mask after clear_mask() has run (as per sashiko's review on this current
> revision). Adding the atomic state should help with that though, as you
> suggested:
> 
> > And most likely, we need an atomic along the lines of ACTIVE /
> > PROCESSING / SUSPENDING in panthor_irq.
> >
> 
> So I'm thinking something like this for the state:
> 
> #[derive(Clone, Copy, PartialEq, Eq)]
> #[repr(i32)]
> enum IrqState {
>     Active = 0,
>     Processing,
>     Unregistering,
> }
> 
> unsafe impl AtomicType for IrqState {
>     type Repr = i32;
> }
> 
> This could then be stored in TyrIrq:
> 
> #[pin_data]
> pub(crate) struct TyrIrq<T: TyrIrqTrait> {
>     irq: T,
>     state: Arc<Atomic<IrqState>>,
>     #[pin]
>     _pin: PhantomPinned,
> }
> 
> Then TyrIrq::handle() proceeds only when the state is active and
> TyrIrq::handle_threaded() re-enables the mask only if the state is not
> `Unregistering`.
> 
> Does this make sense to you?
> 
> As for masking before free_irq() runs, I'm thinking of possible
> alternatives to JobIrqMaskGuard and its ordering convention (i.e. must
> be stored in a field declared before the corresponding
> `ThreadedRegistration` in the struct that owns both). Would it make
> sense to define a TyrIrqRegistration struct that wraps
> ThreadedRegistration instead? and then clear the mask in
> TyrIrqRegistration's drop impl.
> 
> Something like:
> 
> #[pin_data(PinnedDrop)]
> pub(crate) struct TyrIrqRegistration<'a, T: TyrIrqTrait> {
>     #[pin]
>     registration: ThreadedRegistration<'a, TyrIrq<T>>,
> }
> 
> #[pinned_drop]
> impl<T: TyrIrqTrait> PinnedDrop for TyrIrqRegistration<'_, T> {
>     fn drop(self: Pin<&mut Self>) {
>         let handler = self.registration.handler();
>         handler.state.store(IrqState::Unregistering, Release);
>         handler.irq.clear_mask();
>     }
> }
> 
> This should make sure teardown order is still respected without relying
> on the user correctly putting the guard before `ThreadedRegistration`.
> 
> Any thoughts on this approach? In case it helps as a reference, I've
> drafted both IrqState and TyrIrqRegistration in [1].
> 
> [1] https://gitlab.freedesktop.org/laura.nao/linux/-/commit/c78e296690e643b790fb3195660f1229e3cdb5ca

I believe there is still a race. In this code:

        if self
            .state
            .cmpxchg(IrqState::Processing, IrqState::Active, Full)
            .is_ok()
        {
	    // <--- thread is preempted here
            self.irq.reenable_mask();
        }

If the above code performs the cmpxchg, but then gets preempted before
it runs the reenable_mask() call, then another thread can come along and
execute:

        handler.state.store(IrqState::Unregistering, Release);
        handler.irq.clear_mask();

clearing the mask. Once the original code starts running again, it calls
reenable_mask() even though the state is now Unregistering.

This incorrectly leaves the irq enabled even though the
TyrIrqRegistration has been dropped.

Adding a lock around these critical regions would solve this, because
it would make preemption between `state = Active` and `reenable_mask()`
impossible.

Alice
