Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9854CD35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2DE10EE49;
	Wed,  1 Apr 2026 12:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OV53+E0K";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B009110EFA8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 12:39:00 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c5cf871adcso167213eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 05:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775047140; cv=none;
 d=google.com; s=arc-20240605;
 b=Ww48cZAY2GN7H7PWHHvbReVGoRyCJU3oOFXKj4gJKE1Twu6SGcNlPd18tdCwH/ql9O
 Ou1v9yLwQwKtskPTASuWi1CN005XRm5a7jbKKL5SKHbhHdRLXTwxCwxLvuBFpFePv9QE
 FEOSuy9TR4L+eD4mz6aZCj1WGp4IWgTgTLNC0hZxUXaGSibHHtByoyjv7UcnEuxi0tmn
 ExqH3x4RJDPAF5LXjXvvLNxt0z+EXGxdgsJksVsdHiO5nn6PZZJkU1fM7XK/C6vMss0D
 l4rhv7mvpA5Daqz/pGkLfG3VpsqecBtUsoQgLslHxJPsDprXzwR9ktheffnzhaTrUOjK
 XF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C50p4ZX1kB4/qlngVjB93jucX5ZFw4nyYPOJ+NDGmJQ=;
 fh=5Pbx+AXiy+ApL5HpogtyVqUOlr4mt1ohlMpDQaS5EX8=;
 b=WCxZkXzxVp77wGxGyiajVeZmco/a8lpjmks2XlVWdLJQD4QW+CNlNxxUtMfnarS/8M
 w5CooBJKQzym4rK44ICfXuRAJjW5vRi0qNnZPR/ZsTe+heJE/B2ujMHYRA/QvQ/SwbWK
 bw+veJF72zmIgzYgxPmfoIa9YHe5V2C+/zW+wtwSu8zCPncq8Jyx8eaLeMFkTuDzagJV
 etEfeaZNehhYTBceiKsu+Smy5zliVyQ8yatArdBHLAZfjC9q3uqtAQwuuJ19izfakxmn
 PvEozUSFiSkr0go5dZVVc+at0JIjXOwb44vQTfUsx4/FGyLmEGtRRqvgniPt97kYqLTh
 9UyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775047140; x=1775651940; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C50p4ZX1kB4/qlngVjB93jucX5ZFw4nyYPOJ+NDGmJQ=;
 b=OV53+E0Kw2OdonIchm7DikDMRGLzyWJdtgrL8dIBPZQiUu4fFya7ZwUBjfFNtd8tMg
 3RqHn5FuKZOZ0Y/JNYNdDpkImZdRwlI8F6pQiPLcAqltfdM3Cr77gZr3mrHIauNjtKXu
 BuIdlw2OWPu3QV8OcNMm4ds9/BDcvAtHSTOd8BYeFoeKuaw8FJGH5LZohpE4ucbpuIRn
 eK+PiK3k5HWQUbL1X9xQz/oum/o/z58mAnuFcN2BVnSt2ANDhEbzgfaly70ny56idYX5
 EFejoflX3UGbUVrQ+LQyaN1rW3tMKgNObvKUMdxVV7nWX3niM9rH/0KmZllJyy2SXZ9U
 K41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775047140; x=1775651940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C50p4ZX1kB4/qlngVjB93jucX5ZFw4nyYPOJ+NDGmJQ=;
 b=fCNsA7V9RYhm87ROQC0FBAdOQNkJ5XNu5RUul+JkKdvlYwNxOlq2Q81ngVwmR+XeiJ
 Mu4MwrBNODS7Z7bRusbuPtD5wAMI8bjEnj3KEihc0ntAGF3FKrXryfw7VvGOiBLgt3mm
 rMdAm7+mM3SXxVbNQfLeZFs5ZG4jzS6l3Al/FeQyJGTJitm7lMjW8BtELTijx1dea52r
 Z2pLPn9Eh7c/oJQgh6Z7Derfy2B4R57gLAA/fbf07TlHUqkyrHBpOIAoPNcNz6Ov2zWR
 dq6d7IaYmD+wEhCUHjWmTmEOPPiZTSbXV3IM97matjo5sL38Hx3tHQQq+5FGOENeyEcM
 3Pbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf5LIQo881VARRsw3WJOOr2jYP7vdaL7mZBLxtvmEYUHQ2+8TiGi4LVnSQTqoyZy+Hgl29k940Tqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx49mpzG7a8IglbgZx1dLSZaUvLZYZT7Z3WahEy2r6HUe5bZf1A
 2d9tQbYSaYCGGtIdch6q7E8P5/BrAwDw+1uKkcpvdWwQg4uDy6LsFjM1TKH2psP9SxGxGPFyour
 j9kCEDhyjIJKzo9KT5sYDjAVEcL9JSkE=
X-Gm-Gg: ATEYQzwVlLFobGlkWHDyb/tXU4a1vBCCwtTiCY/hC2r1+kgxiQ4T7o1RqYH9pDIlIvd
 vbMujmI/WwRN5RZUxQUKIczSU98L/5MQICuLRG8MCkOCum1gdkGezpsJmphqeM4jhmB22An+s4F
 24flT0+JcUPs34DnmcSGx7sg/XMXYhmxeD6IfiNV38CTHURxUslAT0k7Doh13upYWuJEmP6QBs1
 dU9uzFNxF7ehErEFyK8FIIT0u85SY7Z11OFyVxfz6JKFyoDN0uPkR69Y/TxVI+QRfciTXyZigbb
 m8UVj+ucy85thz/GnyPP8qFkj6BnJ9ds1u+89Y1gUAj0S/eCJmwCEHGOV+dwmLiUbajbWosDXum
 ZBYtHki0stHdaLTZtHBXEOew=
X-Received: by 2002:a05:7301:6790:b0:2c1:6416:2a07 with SMTP id
 5a478bee46e88-2c9321b7bf4mr857984eec.4.1775047139826; Wed, 01 Apr 2026
 05:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-2-ojeda@kernel.org>
 <ac0Ol1PaRTWNK6O9@google.com>
In-Reply-To: <ac0Ol1PaRTWNK6O9@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 14:38:46 +0200
X-Gm-Features: AQROBzB47ncfBs2Gvn4IVyEtA2T5y2xBZyqDi53mewiERXnAT8KcWfCgLbx6lUg
Message-ID: <CANiq72nk8Ti1bcjCO+5nPacz7JaH=x4+uTi3-+iu4H2ZfwfVrw@mail.gmail.com>
Subject: Re: [PATCH 01/33] rust: bump Rust minimum supported version to 1.85.0
 (Debian Trixie)
To: Alice Ryhl <aliceryhl@google.com>, 
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <debian@fabian.gruenbichler.email>, 
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <fabiang@debian.org>, 
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 NoisyCoil <noisycoil@disroot.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
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

On Wed, Apr 1, 2026 at 2:25=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Debian really *should* pick up 1.85.1. It contains bugfixes serious
> enough that the Rust team decided it was reasonble to release a point
> release.

I asked them about their policy yesterday here:

  https://lore.kernel.org/rust-for-linux/20260331190053.482607-1-ojeda@kern=
el.org/

Perhaps they just prefer to apply patches on top.

The issue linked above is the only one I noticed so far, and it is
quite specific.

Anyway, it is up to them.

Cheers,
Miguel
