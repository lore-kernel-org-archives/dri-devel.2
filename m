Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A61BCA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB6C10F3E1;
	Wed, 30 Sep 2026 21:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XT2jUSSA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3310F10E298;
 Wed, 30 Sep 2026 21:43:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39F65601F1;
 Wed, 30 Sep 2026 21:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451721F000FF;
 Wed, 30 Sep 2026 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790804597;
 bh=9XRsQIPFhVNyzXB9n5MWns+D7GBRR2fZhi9ptJ44Pu4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=XT2jUSSAf5rkPWrmet45jQfPoLj3i8O4B4KMw1WfCB1WWZ/3vBOFUHjrZwsfFRQND
 GIf3Mf11CdHUzDX5haKnjyrjHlPY2EYqvqoOdt9ik65hampFGx6gLsbclP0+AbBOZl
 VTmSvCe843dFBhrJt15V+ntINOVYhXKsMtrSxez00+YDS7dIQBDnyQ59h66MJLipji
 EeS9NvBY4WJxEtEOw0srpfxNY6Q4e6weeiKkepBXuilYBer1PN5Dnzio+9nZ6ws0B+
 mGRxjmiDjKMzILOGRUTWNPRdyYlbICcyZ2OYpthz42YRfvtG5ZNRcw6X8X/c0ricbn
 ZrQDYZ96Fw5lQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lyude
 Paul <lyude@redhat.com>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/6] hrtimer: add expiry injecting callback variant
In-Reply-To: <DLSOFOGGZC92.12KYHEALX1271@garyguo.net>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-1-90411c6217c7@kernel.org> <877bk3ixp5.ffs@fw13>
 <DLSOFOGGZC92.12KYHEALX1271@garyguo.net>
Date: Wed, 30 Sep 2026 23:43:11 +0200
Message-ID: <87qziah0uo.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain
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

Gary!

On Wed, Sep 30 2026 at 14:14, Gary Guo wrote:
> On Tue Sep 29, 2026 at 9:56 PM BST, Thomas Gleixner wrote:
>> hrtimer_forward_safe_from_callback(timer)
>> {
>>         base = lock_running_timer_base(timer);
>>         if (!hrtimer_is_queued(timer))
>>         	hrtimer_forward(timer);
>>         unlock_timer_base(base);
>> }
>
> FWIW we did discuss about this option. Here's the list of all options that we
> come up with:
>
> 1. Take base lock before calling forward and release it afterward (the one you
>    mentioned above). This one requires exposing the base lock (at least to Rust
>    abstraction).

Why?

With the above C core function Rust does not even know that the
base lock exists. Rust invokes the function and relies on the guarantees
it provides.

And the function is not Rust specific at all. You can use it to paper
over the i915 bugs too, no?

> 2. Prevent timer operation from within the callback and have hrtimer core doing
>    it (Andreas's patch).

Which adds overhead into the hotpath and creates yet another weird
"scratch my itch" API.

> 3. Force users to stop the timer before re-arming. This was dismissed because
>    stopping the timer will require waiting for the callback, and this is prone to
>    deadlock condition.

Obviously and that's one of the reasons that the code is implemented the
way it is, which puts some reasonable responsibility to the users for
the sake of simplicity and performance.

Now you want to reverse that and add overhead and complexity to the core
to cater for the potential stupidity of users without even solving _all_
related problems:

   You again forgot that simply setting the new expiry time from the
   callback without invoking forward() has exactly the same issue.

Maybe you can prevent that on the Rust side, but the C side still allows
that so your magic new callback is just providing a false sense of safety.

> 4. Add a lock to Rust side that all users must take to forward / start. We don't
>    want to add a new lock just for this, and taking base lock would be more
>    favourable.

There is a reason why it is documented that this needs external
serialization.

Neither this magic inject callback variant nor what I proposed solve the
underlying problem of two competing contexts which try to rearm the
timer to a context dependent expiry time.

All they can do is prevent inconsistent state, but the price to pay in
terms of overhead and complexity are very different. And as I said above
neither one of them solves the 'set expiry directly from the callback'
problem.

> We consider (2) the best option because it avoids several pitfalls with (1):
>
> - It is impossible to forget to forward and return restart, or forward but
>   return norestart.

Forward and forget to return RESTART is harmless. All what happens is that the
timer won't fire so some device won't work as expected. There are a
gazillion of other ways to achieve the same result.

Forget forward and return RESTART will result in a hrtimer interrupt
overrun warning and if you fail to figure that out when implementing
your callback then you (and the AI you are relying on) should go and
resort to HTML coding.

> - The base lock is not unlocked before relocked, so the forward and restarting

What means unlocked before relocked?

>   is atomic. So it's impossible to have the condition where the forward occurs,
>   but before returning RESTART, the hrtimer is concurrently queued.

What's the problem with that?

If the callback invokes hrtimer_forward_safe_from_callback() then you
have these scenarios:

#A
        callback()
          safe_forward()
            lock()
            if (!queued)  // true
               forward()
            unlock()
                                        lock()
                                        start()
                                        unlock()
            return RESTART
          lock()
          if (!queued)    // false
             start()
          unlock()

#B
        callback()
          safe_forward()
                                        lock()
                                        start()
                                        unlock()
            lock()
            if (!queued)  // false
               forward()
            unlock()
            return RESTART

          lock()
          if (!queued)    // true
             start()
          unlock()

In both cases the external start() wins.

Sure in #A it overwrites the forward result, but that's what the user
asked for and it is not at all different from this sequence:

        callback()
          safe_forward()
            lock()
            if (!queued)  // true
               forward()
            unlock()
            return RESTART
          lock()
          if (!queued)    // true
             start()
          unlock()
                                        lock()
                                        start()
                                        unlock()

IOW, you cannot prevent the forward result from being overwritten and it
does not matter at all whether the overwrite happens before or after the
callback returned RESTART. The outcome is exactly the same. No?

And no, checking hrtimer_is_queued() before invoking the start sequence
does not prevent that simply because that check is lockless:

        callback()
          safe_forward()
            lock()
            if (!queued)  // true
               forward()
            unlock()
            return RESTART
          lock()
          if (!queued)    // true	if (!queued)      // true
             start()
          unlock()
                                          lock()
                                          start()
                                          unlock()

Even if it would be protected by the base lock it would result in a
temporary state which can be invalid when invoking the function:

        callback()
          safe_forward()
            lock()
            if (!queued) // true
               forward()
            unlock()
            return RESTART
            				lock()
            				cond = !queued  // true
                                        unlock()
          lock()
          if (!queued)  // true	      
             start()
          unlock()
          				if (cond)       // true
                                          lock()
                                          start()
                                          unlock()

No?

To prevent that you'd need a start_if_not_queued() function:

        callback()
          safe_forward()
            lock()
            if (!queued) // true
               forward()
            unlock()
            return RESTART
          lock()
          if (!queued)  // true	      
             start()
          unlock()
                                        lock()
          				if (!queued)    // false
                                          start()
                                        unlock()

Even that would not solve all possible problems either. That's an
application problem. The core can only provide tools to avoid damage but
it cannot prevent application logic bugs at all.

Adding complexity to prevent that has been pointed out to be the wrong
solution by Dijkstra long ago:

  "Complexity breeds bugs. Simplicity is the prerequisite for
   reliability."

Don't get me wrong. I'm a great fan of Rust, but I have a background in
ADA programming (admittedly from decades ago) and I studied the
limitations of provided safety measures in practice enough to know that
Dijkstra is absolutely right. There is a reason why ADA grew a massive
static analysis toolset around it which is sadly not easily exploitable
due to the design decisions of Rust which borrowed a lot of the
incomplete ADA concepts... But that's a different discussion to have.

> - Unlock/relock have an overhead (we didn't quantify how much impact this will
>   be, though).

The extra lock operations won't be measurable except for situations
which have high lock contention on the base lock independent of the
problematic scenario. If that's the case then the extra lock/unlock pair
will just add to the noise.

> I supposed another alternative is to add a mode in hrtimer core where the base
> lock is not unlocked before calling the callback, and expose base lock APIs
> (like option 1) so that the Rust hrtimer abstraction can unlock it before
> calling the callbacks.

That's even worse and Option 1, i.e. the core function I proposed is
_NOT_ exposing base lock at all.

So what's your actual argument that you can't build a "safe" Rust API
around this?

Thanks,

        tglx
