Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5628A1076389
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D47F10ED2F;
	Wed,  1 Apr 2026 17:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffeo3cdA";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F9210E3AB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 17:36:39 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-124a7216c9cso5565c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 10:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775064998; cv=none;
 d=google.com; s=arc-20240605;
 b=DJGnlj9TrEnRfhNQ4upkctXARrHdI+VPdOmA4ovRjBXdb72OThBoFjHt/chyACTBiV
 hN+GdKZil+GXS7NuxH7iaT4pSFGiry8TBk49twqOw2nf7othCS2pDTdM0AamJ/Cm434A
 qYY1fGMfNjU/CZ4cHMNAF09pncYPTRPYyONN5Nd+yIwhiFOHoiYXiPvp23R4k69w8zJU
 xR5eKCDRfj4VAG3nwDCiLWG8pVP6Vp2fwp6rEFUf8dCT1tFAzVUQR4I98qRufMjHIyBv
 vkp+S95874W9MYTE70V79NjT4WvHuNadCjGzAeZJrBpsVYVGRZmRJvX9xtDsGSBB0MOw
 3g4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Madpyzu+7zvyLSmbgHorRXu83g1kA3bqkxQ/QKvvzXA=;
 fh=5dKZx5mKVCi/etmBdfxL9eFHDRS3qy0ctZXjlMn1R0k=;
 b=PO6uk/zw/NPK8UQ8711Bey+1qsFYXUOULfszi+2b70nVVaCWWugTkF1DbW80f526xu
 PrGqiMiATs3mTB80miPMevi4IIMai6ZLamcef95v+SWicrN3sw5kbUc9XBZndeMBMlCV
 682YNgqhRi/fz16//1ik8NzzLSL6G+kYIRdZzzPhSc5UXhVc4Hqx5prQNPHnWALe1G98
 tHrA4kLcImiJw4/cMKfTo8w8c9ooJ1R9HaHeavZB25zGywXI1FH/QM+QLVtHuHQt4WNk
 roFVnjpefQ8YgSQ2Py5jJNfVbaHnUHxCn4sXJwQpjayejvDel8o6oJwhumS2t09ATWbP
 tgXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775064998; x=1775669798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Madpyzu+7zvyLSmbgHorRXu83g1kA3bqkxQ/QKvvzXA=;
 b=ffeo3cdAsPx0AQnVdPUMGxjSjMFpsW8Qe9nlok5MNma0xS7koP4AZDSsDAaTiYMqQm
 HBP7PqOglC9COIXpnKBnk+JeNSY0duWiCaZwddNHaqeHVO27a3VTlZ4I9HGqMYbyjD6o
 igras4rVWBz1L8bZDQ9xnEgXH+DWKqpJsCl5D2VohsDqQGUcB8PP98cIzUaME+jfefYH
 t1h/exWS2ZNljqVI4mnlSlFntMEOxg6XkI3B93lLKUNJV5qs3P79BsniIx6cHfg5PzlQ
 SJ8Yn8KpMoiWVsAXXIDG/9U7WVH7SwyQxxQX6oPo2hAZKPGtK9lcPgwDRBLfXcN6KL1y
 /0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775064998; x=1775669798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Madpyzu+7zvyLSmbgHorRXu83g1kA3bqkxQ/QKvvzXA=;
 b=R9Q89DHRc91gmYC/ijP6HYO0DOqi9Q/25eis7aR1kayO5+zQscwssoq/3VxzJxfni5
 23UH66rYXhO7GPsWfBko4GDwU97SVnDd8oUTZvtoyx5kVhw/DWx8s4qVPwJjxCgKEgbn
 eYUOqGU6natuCLEpiOr6y08aAT22naXP+gbC3ZxovqdZulK+e1GcX81+8gGyFiANm7VZ
 ysiGmyCykaExBNn3ofMznK9YH96nFqEkeRRtVOFQKs0ddSramgd3DPeqbNgNdDAU3F7y
 Ers8ZzpugP/igQQ/obn0WNGRnV1CARLkr3sMvEqujvv90B0vF+9pnctjBhQDJ5SgjIoS
 P0GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUXorpKt5EksLXZUA9l4GSzBDPrSz8LobjgvV1PzoxOqDCUVWrqrSbO7q2LAqL+5D8mcy1dZcUge8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxX+YU/Ya2iek/3NLVgZdpwVQSSiTUWdA6rdALRkO5/YgMAylk
 9+JBVZuKcAzOdesLaU9a49uZh2l+pdEn5KwVTcRBj525NbTLjyN2K1BVA6ZjbwN7XGRGeyseq6Q
 LcFCnaOJqC/FGySYP7jCnGtGynIx1b6Y=
X-Gm-Gg: ATEYQzxQSe8CCXtYyL4iN3CmeDvJfrS0YjrK3eyLP9i4/eWlyBqeha/Mh4d62xEMz1w
 BaE8uy9qoASYqhb0UY1Dv6aYcfuHF5XIntrn420rUecPD0baC6vFUPZRVurxudHmZIyGnAa1tRc
 bek5KiBwTL0yLJSjQThPFXwdX37EsGPBYJMJsKswiQUCw/WRU96wxgfkEpn5HQGDmlNCFX7e4RR
 67f2gWA1o3vwwUyBFTFF+YKEjAF+OeGl+JB8Gw4+yp2GNvJqoKN/EqdyPMkvr0H/NRNgyisUUoC
 YdlDmvNANKNy70/2XvbYw/hYyFH7huJ0xesj5CirRamXodloT0SFNPylg1137hKkBSMLbYBjik+
 Ys27kWMG3Nk4LX/sIi//t/3g=
X-Received: by 2002:a05:693c:2c97:b0:2c7:2cac:8162 with SMTP id
 5a478bee46e88-2c9326aa500mr1010168eec.5.1775064998156; Wed, 01 Apr 2026
 10:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-9-ojeda@kernel.org>
 <DHHVEPJHLGDW.1E6KDP9BUFG5U@garyguo.net>
In-Reply-To: <DHHVEPJHLGDW.1E6KDP9BUFG5U@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 19:36:25 +0200
X-Gm-Features: AQROBzBeO_yfCUmMruxpBPrHPRt9Z-RBtWsQqT4MIRVUyc-eOkOj6bAx0WG8aNs
Message-ID: <CANiq72mnnro6UD3SYgTOG+kipwkTBvbEAGH+jXUa3kLTUNje2A@mail.gmail.com>
Subject: Re: [PATCH 08/33] rust: kbuild: simplify `--remap-path-prefix`
 workaround
To: Gary Guo <gary@garyguo.net>
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
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
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

On Wed, Apr 1, 2026 at 3:59=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I'm not sure that I parse this. You do remove the filter-out completely b=
elow?

(I see you saw the other commit)

> Looks like this is going to conflict with rust-fixes (which adds the
> --remap-path-scope). Perhaps worth doing a back merge?

It would be only a couple lines conflicting, so it should be fine.

Having said that, when I was doing this, I wondered if we should even
consider keeping the workaround. In other words, locally for
`rust-next`, the "normal" commit would be to remove the workaround
entirely because there the flag doesn't exist to begin with (i.e. the
workaround should have been removed back when the revert landed).

Then, when conflict happens in linux-next, we can just keep the
addition of the flag from your commit -- the rest can say as-is, i.e.
no workaround needed, because you only enable both flags in a version
(1.95.0) where there is no need for the workaround (which was for <
1.87.0).

It is also why I added the second commit here, i.e. the "make it
conditional", because I was testing that indeed we didn't need the
workaround anymore.

So it may just simpler to do that. What I thought was that perhaps the
workaround is good even if we ourselves don't pass the flag, e.g.
someone else may be passing it. But the chances are very low,
restricted to a couple versions, and the error is obvious and at build
time anyway.

Cheers,
Miguel
