Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F0DCA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64E8112276;
	Fri,  9 Oct 2026 19:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hwVrFYN3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A64C10EB2C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:25:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB688413E5;
 Fri,  9 Oct 2026 19:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7E51F00893;
 Fri,  9 Oct 2026 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573933;
 bh=YYjFDpRjdPgF83cx2Uo/hOmq/Yc48pSE/LC8x2x18jo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hwVrFYN3lGbia/lv2Pv5Nhtcitxwep0/nAfJR9C+8LSlqKo9wPqdPNTPy0VnfDl+m
 u/n5HDZkRGMhTIGMs0p/L+8PF7wuXuXAKXaHcgBVlrcgaDUU+rS1WixjvQaXI98O47
 ZZhTacZPKEuxBJgY/T9XwYTQmxw6Gb1NKbLcumjuHdn+b3PNI/87xNRNF/fcuvmi6i
 VBodbQIqs7jLnuzbbZ+TAZjDsTz3qzFY/+58eu5AGA6k0DdxWkowECryw1bNI5rN+c
 alN139efFP6os9xVv9c3flocwGZ5qhpQsEepjxzJDa0HAOi7vPLb6c6C7d5YZDyPjm
 r89rhm0PBZ9OQ==
Message-ID: <sashiko-outbox-166000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 5/6] rust: DmaFence: Replace call_rcu() with
 synchronize_rcu()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: media-ci@linuxtv.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 gary@garyguo.net
In-Reply-To: <20261009191124.1022902-7-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
 <20261009191124.1022902-7-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 19:25:32 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rust: dma_fence: Memory leak of T::FenceDataType in DriverFence::d=
rop()
- [High] rust: dma_fence: Sleep-in-atomic hazard due to synchronize_rcu() i=
n Drop
--

commit fd18c02da88f26cc4c8c5dc518b90c8f1e16560b
Author: Philipp Stanner <phasta@kernel.org>

    rust: DmaFence: Replace call_rcu() with synchronize_rcu()
   =20
    The C dma_fence contract demands that a fence's data disappears no
    earlier than 1 RCU grace period after the DriverFence was signaled.
   =20
    So far, we achieved this with dropping the DriverFence's data in a
    deferred manner with a manual, raw binding call to call_rcu().

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 4e9b4a6a9471b..cefcde80bf092 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs

[ ... ]

> @@ -1022,59 +1020,18 @@ fn drop(&mut self) {
>              return;
>          }
> =20
> +        // Make sure none of the fence backend_ops can access data anymo=
re.
> +        //
> +        // TODO:
> +        // This would not be necessary if the C dma_fence backend were u=
sing a
> +        // spinlock to properly synchronize its signaled state. Fix it i=
n C and
> +        // then remove synchronize_rcu().
> +        synchronize_rcu();

[Severity: High]
Does this introduce a sleep-in-atomic hazard when a DriverFence is dropped?

Since synchronize_rcu() blocks the current thread until an RCU grace period
completes, and Drop is executed implicitly when a value goes out of scope in
Rust, this could sleep if a DriverFence is dropped in an atomic context
(such as an interrupt handler or a spinlock critical section).

Because dma_fence is frequently manipulated in hardware IRQs, could this
cause a 'scheduling while atomic' kernel panic or deadlock?

> =20
>          // SAFETY: Valid because `self` is valid.
> -        let rcu_head_ptr =3D unsafe { &raw mut (*self.data.as_ptr()).rcu=
_head };
> +        unsafe { drop_in_place(&raw mut self.data) };

[Severity: High]
Does this leak the T::FenceDataType payload?

Since self.data appears to be a NonNull wrapper, the expression
&raw mut self.data yields a pointer to the wrapper itself, not the actual
payload it points to.

Calling drop_in_place() on this pointer invokes the destructor for NonNull,
which is a no-op since it only implements Copy. Should this be dropping the
underlying payload, such as via &raw mut (*self.data.as_ptr()).data, as it
did in the previous drop_driver_fence_data callback?

> =20
> -        // SAFETY: `call_rcu()` is always safe to be called. `rcu_head_p=
tr` was
> -        // created validly above. The module must perform a `synchronize=
_rcu()`
> -        // or `rcu_barrier()` call to guard against module unload.
> -        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence=
_data::<T>)) };
> +        // SAFETY: The `synchronize_rcu()` above ensures all accessors a=
re gone.
> +        unsafe { bindings::dma_fence_put(self.as_raw()) };
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009191124.1022=
902-2-phasta@kernel.org?part=3D5
