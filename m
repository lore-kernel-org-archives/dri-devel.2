Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15BBC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4689B10EA3D;
	Mon, 31 Aug 2026 17:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qcQ7aGEw";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7308E10EA3D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:55:03 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so313819a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788198903; cv=none;
 d=google.com; s=arc-20260327;
 b=Ios+67Tsah/IPlGThYO4+Hr/ir3QhvZaZfPBTpH3UQnr22dnx4yLJzExFSRoTjRL5f
 vI2tmywQBcMw9Dw1as2bN3TCPXV5g1KnRpDkV6DP59raR1OEOd/KAbwyfdBXNOxofsJv
 68eTOU3kKZP1lsW83jQ1n/DCKwZMt2Jpe3G65uL7nHszHUWozLXgHY7mR5J+Vdp0CWwS
 Otu4B6KlhSiaq0GXH7KKp3x82IKw8+1GB1IjAFXpANBKZj6EENvaL/tW1FZPxMc2doH/
 VnHsdTl11m7yhpxK7WCzdiotkcX+6eV9WMF2Ed4tCSTO+PJ8x5RFbdc3PkhvE3RxgFGa
 sfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N/RETsztnDkAzUQrwJYe3M9VfKmr+8nyYXoQh9ATtTg=;
 fh=4dkCcpy/3JBfSlpyWwGj1t0QNxSdT0THS5QaQLh05BI=;
 b=mHEXLfGza6ZDh/XJo76F0L3yLHG0Y5O7qDif7WEJL9jK9KvqAlEb4+krOxo9f5n9vQ
 e+CuRYYFpPel/sRKRJvZcxNaDUwZZ0Xrp0gO3o14Q5WVhWSXH5OUN47fwjWSAopyrUCG
 OzPQ6Pou5Ftwy3wXvhfu6+iNIbZiLrvVgrbI2V+mFf6UjAOvP34+aSDQ+EjGtTRGxzhu
 c9aqXdoybRqMuiUBEJgFyi3mozBZ2cX+iztUloa+fXCDNXIcyhhYP6E2pjKatSWZgCAd
 llAQf5suN4nGbQXeTQX+zrspT1CfBSR+rspvQIu2w+4bs+YDmCwvlA9D2R0e5o/fsnTo
 BYfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788198903; x=1788803703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N/RETsztnDkAzUQrwJYe3M9VfKmr+8nyYXoQh9ATtTg=;
 b=qcQ7aGEwGjU5FXdCqe+aG68deZ/ubTo5aCUYFTEamVI+tg8NxFkGrF1GEA1x3GXBdu
 l6/7JMBj/18DB6jD/GQAV/Qq9GjzaBzbd0j/thDuZeD2iDKBfwhBcbxQ8JuPihuNo1mu
 JJ+UikiK/joAS6uZSWrY+YVXkdM4Ng3szGK68gGL8pfnm9GZ4XI4aa0gzJl4U+dPmlEa
 kwcKOQ3yu53GtEz7fPtL+UmvbMcnc1QYsRddGpa4wdU3OmPvY2l6oqNOK9me/Qdhz3/a
 Z3GmRG52u64eADmFnA+STKV5A/MaSupZ5VAlzCgh2qOAwUaK8fuCw65wT6grkvGyrDDN
 5p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788198903; x=1788803703;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N/RETsztnDkAzUQrwJYe3M9VfKmr+8nyYXoQh9ATtTg=;
 b=UxSf2DcwT1KQeCAchDlx4ZMzEA/grrPwR3iu4gKwCk0DWr4Lm7jR7j6++4YG4DLy9u
 NaJdJCpIjBOk87ChOsZhRbP6aKLzJL9SkgfEP3hGbUdSXjT+TpkDDOUhVEgaFl2bMqDw
 gVqxKDglHwgvQbuUbP0ZaHzq8w5UHuuJ+g4Uk5LW9JyjZyCZKtzVFPvch2XpMV3e9+hL
 md4gQIC0s8YdAbbq6VWFBLdB20Gq8JTxSEHG3kTasayn9zwonhqrEbncSODGMQ/rTtqR
 H7gen3jkhSnJ31xuf4sYHRQ2qmSgLTBi4Nc5qdppDbP0oAGw7soVYnSdrGSYoRvJ/2xJ
 1bxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOAPGUdW6T38sAmepwP7ApIlSFn+8mVqDxKOtZXbgaN2iFRnybpPefomH+4wavT2LsiLDWrldIcDA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kwZbwAEYy1sxS0JRdyb3D/NgDa7yHV77W8t29ydriqCFsGr0DW
 gheDGEE8gv515OwjFcYzS0q05g/OpAdJ0URHC8xmxeuFZV6u7gfRBiWlOM/2dUweaD/+fAVdFlG
 y5P2htMm5CtgOIBfJqIZURSGfQcpBZVs=
X-Gm-Gg: AYBFou19K0JAhk0saxLgd8vkUnB8vnX0PVdaU0El8CG2PyyM+tevjm1bOrEI8U4ptvz
 dIi3msMqcR9hH6RMe374svpPS22c3372ha2j9fikBLeqo71UsGKY4xXOB916vJ/fmQ749bOy6TT
 XdYMOXy+Jofks9PrvoIo/C77x/3tmD+Fh3SMyIHZMxUAVpqLfHLt9Y1g1Ihw0VsTs4albEGHNpW
 SpBIWh3oLgtar6hgQPP5mTYsggsXeIBMk/7YIH9r71RwGObmFVJMRMwJk1xtQ89xLSr2FPCrRIi
 OPzKsF80x7EgSwI+cGYCa8rvt7Lr+im4p2Z2xNDvkkN+pJPqNHQMVQG01shUjzj4+1F+9W+Sp8Q
 vn/hqPtTtHg/TGR4K8Y2eQoPrXnjTf+bxJz++nyl8kGyMYHCHgW4HurkEzsoW
X-Received: by 2002:a17:90b:4b87:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-398ba6dc4f0mr13662063a91.0.1788198902732; Mon, 31 Aug 2026
 10:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260826145642.43807-1-ojeda@kernel.org>
In-Reply-To: <20260826145642.43807-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 31 Aug 2026 19:54:48 +0200
X-Gm-Features: AcwNN1UHVFX8Gn5Pcu2VxHXdKlDsBxvZVLchmQDGmj0obMMvoJmQt1OhITRIZ9g
Message-ID: <CANiq72=TjVOxDj631gCFMKAeXYbjycmZe74ChXL=rw4H53pQzA@mail.gmail.com>
Subject: Re: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint
 for Rust 1.100.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, stable@vger.kernel.org
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

On Wed, Aug 26, 2026 at 4:56=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:
>
>     warning: the loop variable `i` is only used to index `self.decimals`
>        --> drivers/gpu/drm/drm_panic_qr.rs:410:18
>         |
>     410 |         for i in 0..len {
>         |                  ^^^^^^
>         |
>     note: for this index operation
>        --> drivers/gpu/drm/drm_panic_qr.rs:411:13
>         |
>     411 |             self.decimals[i] =3D (chunk % 10) as u8;
>         |             ^^^^^^^^^^^^^^^^
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/main/index.html#needless_range_loop
>         =3D note: `-W clippy::needless-range-loop` implied by `-W clippy:=
:all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::needl=
ess_range_loop)]`
>     help: consider using an iterator
>         |
>     410 -         for i in 0..len {
>     410 +         for <item> in self.decimals.iter_mut().take(len) {
>         |
>
> The lint did not trigger here before because it could not handle arrays
> behind a field access such as `self.decimals` -- Clippy was improved to
> catch those cases [1][2].
>
> Thus clean the warning by iterating over a slice rather than using
> `take()` so that an out-of-range `len` still triggers the same bounds
> check as the indexed loop.
>
> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
> Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> One may want to keep the loop in a shape similar to e.g. the one above,
> though.

Jocelyn: I will likely send another rust-fixes PR during this cycle,
so I can put this one there if you agree with it.

Thanks!

Cheers,
Miguel
