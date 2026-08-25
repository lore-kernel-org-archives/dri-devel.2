Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C2DC61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1412210EA22;
	Tue, 25 Aug 2026 12:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N7jyc77a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5497F10EA22;
 Tue, 25 Aug 2026 12:25:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0244E4180D;
 Tue, 25 Aug 2026 12:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960DE1F000E9;
 Tue, 25 Aug 2026 12:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660741;
 bh=hlnynskX6eMKZznMm9zjTCvVP9niPycx1IYBNmvE5K4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N7jyc77a4HGE/Qz4CWxFQVQ6JT0xG1JE2KIF4h74Dos1rVLvZxdSKrrVNIuncgf/e
 YPBeutARO7wVWdyzmQeW8aMCJDi11zygF7D+BHWYbT0BLsxC5jHY4eyEgc9/29ekn5
 qH69MyswM28DQuGDd4SWCkiMaK7vOHKp/h0CUJdBZp/RC5cmy52cBdzLJfEspcvb5w
 Sn5P3OGHNHBrBQFlUh9JflDqQyGr+JvvfO22Sb6yA5LdxoMFNjU7dZHpgN/ahNfULk
 9rQHOX/qrd/A+7V4ylPFs5DKtjg8VdOPzJmJL5yqefLhxvO7bvmtRp2Jl26xFrB8nC
 gm7Wzycarmf+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] rust: hrtimer: restrict expires() to exclusive access
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260825-expires-v2-v1-4-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-4-90411c6217c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:25:41 +0000
Message-Id: <20260825122541.960DE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced `expires_unchecked` method is private, maki=
ng it inaccessible outside the module and defeating its documented purpose.
--

--- Patch [4]: [PATCH 4/6] rust: hrtimer: restrict expires() to exclusive a=
ccess ---
commit eb28ef35be5861cd1df93f56841e97d8fd3ed101
Author: FUJITA Tomonori <fujita.tomonori@gmail.com>

rust: hrtimer: restrict expires() to exclusive access

This commit changes HrTimer::expires() to require exclusive access via
Pin<&mut Self> to prevent unsynchronized reads. It routes the read through
a new C helper and introduces an unsafe expires_unchecked() method for
contexts guaranteeing exclusive access externally.

Link: https://lore.kernel.org/r/20260813134834.1562995-4-tomo@flapping.org

> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index e6570a6162035..bdb6aaa228396 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs

[ ... ]

> @@ -567,27 +567,36 @@ pub fn forward_now(self: Pin<&mut Self>, interval: =
Delta) -> u64
>          self.forward(HrTimerInstant::<T>::now(), interval)
>      }
> =20
> +    /// Return the time expiry for this [`HrTimer`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must have exclusive access to `self`.
> +    #[inline]
> +    unsafe fn expires_unchecked(&self) -> HrTimerInstant<T>

[Severity: Medium]
Will this method be usable by external modules or drivers?=20

The commit message states the intent is to provide expires_unchecked() for
contexts that can guarantee exclusive access by other means.

Since it is missing the pub visibility modifier, it appears to be private
to the hrtimer module and inaccessible to other Rust code that might need i=
t.

> +    where
> +        T: HasHrTimer<T>,
> +    {
> +        // SAFETY:
> +        // - The C API requirements for this function are fulfilled by o=
ur safety contract.
> +        // - Timers cannot have negative `ktime_t` values as their expir=
ation time.
> +        unsafe { Instant::from_ktime(bindings::hrtimer_get_expires(Self:=
:raw_get(self))) }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-expires-v2=
-v1-0-90411c6217c7@kernel.org?part=3D4
