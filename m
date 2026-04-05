Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262BAE9D826
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D24710E1D7;
	Sun,  5 Apr 2026 23:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjJR9pVb";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EF110E1D7
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 23:15:53 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bd801b40dbso273772eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 16:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775430953; cv=none;
 d=google.com; s=arc-20240605;
 b=MnO4hxCkcjyR+kz50XbcOwneJYGqwDvfCxJr5xKV1+afltS4/JqVNvxf+CUSfWPg5q
 szZyuZOrnzeB//x7GfYEvfIby0H6rKv91ubDg+BjMpF/wBmvDdCsUWesVeeuUfn/libk
 +V9Wo7U0pLHp6auHQO6le1FPPRBRh2aMXEwEm9Z9VFXAglpecfAk1UeaYKoaAUsa7RgJ
 xUSFPdhpJP3AZRv80v58HiYz89ZvXHXLF3XKwr7fe1bWgectsXkE9RCKvJkxSEWk+qOT
 4mzACNEO/6ZmjCdXRQApz3p8iIMmjtAZitCUZf/+ZamVE0lfkE+quor+PbAQXyXYGWhe
 mUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7nRF2alQvQ2aT54Jx0Zl/2nZdMqcYryRscNapi5ZMxM=;
 fh=t2+VYa3T8XMmJl+UecRbLRrTis3bsT8OXyKXRv2G750=;
 b=ZcJ6KBGshN3T+OIdmcbCNJHiaN4Gbbo3oEy7y34hkhYW3BWSSuJ8OA8DTXHBZmmoNI
 DektiajXEmW2lalzWuyviAIWi4fbH6NPzkRjRWUGPhQ7fI+Yh5C7n5aky8/AubiQO/2J
 4gWD90aXoQHFBvTID1y7ho3Dv2t9xoLERF6o58kvohVdMONngYLhYs+93yP1qAoOwUIz
 e3XRpIgmE6ekfPkSP52ZQtibMAu7iINNecK2w32l0q52HK/+pXMqDwscMiNNqur0jzzc
 aC2taYDM0/hZDDP605z0ETDHzlCYtpa43Lk4snzi2jaCdzm/360/e1UXTjBiN45s5nNj
 7SxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775430953; x=1776035753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nRF2alQvQ2aT54Jx0Zl/2nZdMqcYryRscNapi5ZMxM=;
 b=mjJR9pVbqN9wKoIoNc7hGRSETuNn9LWjr1JHb8J0C1iRNvq3Z8LZhBA7m913ef1skA
 1GwfT7Cl3j8S7B4t11w9pre2AUEZYMqeEj2R3OLjgnuGApT5s9TVSd7zI8vcOWQVOFPp
 hXcWJ9l21Ac2MBuzYcLmx41WLg9mRf8YclHN4ZU4ZcCcxqU+JciQxDI80+0NHzbXHs/v
 fc2VBFErjVGWFj4E+u5uGzj02TSNX1OgveMh6V2I3kasXEg7vGLUgBVFwWXSdJjXRlra
 M5eg72m1Bh2knvBiPZ83mbi7SveuGzBzmpUrqwaMMI5n57cn2EuiEVbJFqrABGPP8gmh
 fFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775430953; x=1776035753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nRF2alQvQ2aT54Jx0Zl/2nZdMqcYryRscNapi5ZMxM=;
 b=CbVk8P3Lrx8Dj4Ahh44p1MK0KvkVC9Qp36wuew/birk8LwUZAyl7rmJNOilThzmFs7
 EXV+7VKAy2WX2/Kh60kUCtRbOLrg8STK6FDbUl1UO508TP+3qv826o78bqRlJt1Dooe9
 4BqaQxFrffRjbOxxj5XBob+8S262UhnSicsOgGOviIJcweMWULK8OfLPp7rLiKebBpdU
 HjKOu66ljDmPf39QPgTOhqDaNF5n/sxybidar/e04o0t3Q4Wdj2viY3//lhkk7gJPZZj
 +9+5/ev7rGLOXvrbfofCFXkmBRy4Irm97O69TH4wsB26WIGUSIszOL7qCqzJjIC026TP
 t2pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHSLFsq//3mbPMJ0SeRAtX/vFbOYcH7cBbdKGB77lRuLurPo2JlGFBaajE7eYeG4wkrmsXhOqjZVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZsVex5StIgYkoQCw0t10zdg4Yfs5YbElKo6czlSnLDl6jGcB9
 T8ji1ULcMDj/qCfVFhAyGdFakgVwtGoBEPS85BEr4n4YZFpZpHuoReeuawrBOPEWABl8HFMvBix
 /GPyUyNEjh5mGDSg2YVNPMfTs5T1SA/k=
X-Gm-Gg: AeBDiesOali7Ae0+N4/L8j3iRdThotW8ym6yJTrG++54v0KMHxSK0r/Y75BR7yP/bug
 otoVBjiFSKIKmmrDYxLVB74XaqMPa1h6WETWC+bI/7oz2BrqTH75iL/NIT6JQmuwu1Ef4qmzTjx
 j1KQWiO4XY+edKfUzNtq7iPoXwnBm5P/Z7/oMTPG3kr3NHIk41YHOgaSGN+6nzx9wyM9qCqDy2u
 XkMI+uJuqgJ4+xGmPOXiiAO9Ymy1R7kTBVzZJ0ptqhJX1bGPrmLMcd85ahdznAgNu5fBve4X687
 iq3fMqASisjI8VLBRLNVDMObkm5UczWkb8Jk32d+eYYICGWPbGaSvG1KinvapZBIiaUaoctA/56
 jrOxI+8vAE4bksIT8Tp2p974=
X-Received: by 2002:a05:7300:fb8a:b0:2c7:3a7:c795 with SMTP id
 5a478bee46e88-2cbf669b785mr2053063eec.0.1775430952689; Sun, 05 Apr 2026
 16:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-33-ojeda@kernel.org>
 <DHHX9O7V06VZ.G0N1CQ7BUKFO@garyguo.net>
In-Reply-To: <DHHX9O7V06VZ.G0N1CQ7BUKFO@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 01:15:39 +0200
X-Gm-Features: AQROBzBr0aNQIDV47zgxZ35JmTq7j6zQBNm1bxMAs_nutxdLV5rErBhW_SWV5gw
Message-ID: <CANiq72mTaA2tjhkLKf0-2hrrrt9rxWPgy6SfNSbponbGOegQvA@mail.gmail.com>
Subject: Re: [PATCH 32/33] rust: kbuild: support global per-version flags
To: Gary Guo <gary@garyguo.net>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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

On Thu, Apr 2, 2026 at 12:28=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> I think I would prefer moving these down.
>
> The current approach append the flags to all variables, which will cause =
the
> following equivalence to stop holding after the flag update.
>
> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
>                         -Zallow-features=3D $(HOSTRUSTFLAGS)
>
> (Per version flags doesn't go before -O anymore, it comes after HOSTRUSTF=
LAGS).

[ For context for others, Sashiko reported the same and we also talked
about it in a Rust for Linux call. ]

I have been thinking about this, and about potential other ways to
achieve the same thing. I think the best at the moment is to move just
the `$(HOSTRUSTFLAGS)` below, but not the rest.

The reason is that it is closer to what we do with other user (kernel)
flags (e.g. arch flags come after the general ones). But I am
wondering if we should/could set all the user variables later in the
`Makefile` in general `HOST*FLAGS` later in the `Makefile`.

In fact, there is already a limitation with the host flags: `-Werror`,
i.e. that one gets appended later, and so users cannot override it.

This may be considered a bug, because commit 7ded7d37e5f5
("scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=3De for
hostprogs") says:

    While it is
    possible to avoid this behavior by passing HOSTCFLAGS=3D-w or
    HOSTCFLAGS=3D-Wno-error, it may not be the most intuitive for regular
    users not intimately familiar with Kbuild.

But passing `HOSTCFLAGS=3D-Wno-error` doesn't work, since it comes
earlier (`-w` does work, but because it turns off everything).

I am also a bit confused with:

    While this means there is a small portion of
    the build that does not have -Werror enabled (namely scripts/kconfig/*
    and scripts/basic/fixdep)

because it gets enabled in the build (I think it is referring to other
targets like the config ones).

Anyway, for now I moved the expansion of `HOSTRUSTFLAGS` in v2. If
Kbuild (Nathan, Nicolas) think it is a good idea to do one of the
bigger changes (e.g. for more `HOST*` flags, appending it even later),
then we can do it afterwards.

Cheers,
Miguel
