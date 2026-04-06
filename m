Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135F4EF4EA4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 09:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C9710E211;
	Mon,  6 Apr 2026 09:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ObDdco2B";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D80C10E218
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 09:03:23 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2c7e5f38a69so203267eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 02:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775466202; cv=none;
 d=google.com; s=arc-20240605;
 b=bESyO+dEblXzn0s9ZorZDucbowe3K200oE5jEcTprSjKKNG3a3MMD7hQuK4Dxt3tKP
 0CYcWUm0l0T1rQbfYK3/l55DxU9k7cSlRnEpiAspjbfs3yinuwRpKYWZuna9m+t2+znn
 ffxjrQdIW0MS+UBv799axtUiAWxrUpNTjXFfjv2ywm5nZkM1U76svN72MGGK5VK2dRh9
 J04hu58ER06xoE6IZFcwGYe6gnkZ2U0+qlGOTvTvjNGi94qblKBN254USZMQaBARKSEc
 YA8ItxktTKxj/Rw6jB8TRzwz5zBLopjq+P6LhRSK6c2XYrfiTpPjgaUL36gwSPVbduMQ
 LsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iVamUPJfkbP2PYNa14ddDsteyLquBt95MrPlozlxwT4=;
 fh=66fvQBFEBzPArdokyHMKly7QseCNImZqex+F711MprE=;
 b=LtULBqPJBW+pG9MOvXDj0eBKz+k9vJySI72jkh9iWC9UtYS5zDOfrJ0Y1q2KhASh1Y
 9WBuOtMAzt1lH1fqXR/A+3Hdf11GjvNrCqJVfg7guLgr/5HanosSdm+hM7YZl1Aksv2T
 NNVglWR2SIOokj+b/+TS6xNJ1BSIvtsRl6wHb45hHIET6XkhZyK7NeDROMn8EKo40dC9
 Ny7PQq8I0s/422GNgCbK+NXdb9PUls/aIAtMUBkYM9IWhl/HnWa6XLomHEXUFaDCdPNh
 16GuGR7AFPKIHhdHv68mtzLRSnKi5nV/TcBWWm1ekwdoK6L7SyGPz+BG/YFEKMCjzljk
 dayQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775466202; x=1776071002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVamUPJfkbP2PYNa14ddDsteyLquBt95MrPlozlxwT4=;
 b=ObDdco2Bg0dx0e99TdS7C3X/cHhJdQ7lmNzTjSSaEmQvEklwUZtMmIxT4aCUcRsk/S
 cXoKOp4VCnenQ6ZS6kGsWMUDl5hWeVDogZ7FL79ExKkwDquTSLh+1b+2KvS8eM4rN+Iv
 sA8ZsQzdevx5sR1Ry8WQQAjOZo4oJschAwcFATPFg9wVvys0i6AkdBfBUZLPWnvvsB4a
 OKRgWrk+UFxcYAY6I6LeSA8RZwJ6cOifF4sA0fIKyzXHKMeg5TOvjo8up+GiDXc3o5o0
 Pwi/fiCyb/shxJKBmAIcY6P5P4dfwrQ/zg7rO1pSgb3yV3Vj/shshlvwgziqmUUw7Veg
 HI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775466202; x=1776071002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iVamUPJfkbP2PYNa14ddDsteyLquBt95MrPlozlxwT4=;
 b=pv15jR39MTcxFSNsVMaYMp4Ad771aJg5FlDtWklUtxCquiqOKnuO2f/yJUw358+GSr
 gxoDYtgwSvWnP7D5KaLYGQiHuAm090Ca4r3FR3GolPiwF63F1MbpxjQQQbreiGnlmr3x
 Lwgr+KvFbpOUvJjBkoBNjBM/duHyPLMs1IGPclcIV4NgEHvGWYJQ0aLxVViE3pLdVqFJ
 10hSBR8m3dBqzA0dVFLrysWn/cIc3GnDS1dr/jQAreFZjINTVajJPpgenxmNFgOMbjNd
 1u5aClZFIqtVpo2aQd4jLmRATmUYRo2bLXSncTFRsxQyyCA1YZBmKtpQ02BSZ8rYezIG
 hjoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc1/AQp9KvTiTsYTNgLkug5PvHR6ix6EWYUeSEkkKsGGMmo0rdUJzk6TInD4KxrashWDuP7YMSZAs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz20p+wmvPlTGZEXfMm31qfbeGWIuIFOOI6WjTPkpDsYKh2Izb
 mTZ+vWIRFVPDTBK3qI3NUvpy7RLEWwN1Dd5Y8koYdE6DIJ/thnd4FdCp+m/tGklh4p3eN3EsfDy
 SwiQX1Esj9vAOsyQKfYYqa+RmfYmAq9Q=
X-Gm-Gg: AeBDievCB2s2hiyFL3gsa0YzlcFBsp5xPItDKOL8cNDGIBQeyGj2BVEFrveyQrvwsGS
 UGUbJzxKOO3vXDaGL9i/nAZ3YaMyKqKQRldlyGLI9Kh8Db+8M13t2J6D6XaQciodSnJcYcAnNRR
 EU6/DoSN250/EcaI+GT4/RtBRJYow5U4CbzgV8DDfhNMCZF8QtLLheF47D8HKTOgesIJ31Z0vtj
 SZjRPH+CkRrjyaHzq5aFxHzL5oRfPSgFP4FvGUgNGL6UqB3QtPDOqaPQDPq3Yz6YkwlIAhnWAJs
 SC9dPX6j0K+7ntVcjaGfJyNEmuPiL3eS65S2u/bHw+twj4bE2RDI+sBCizB7+rE9fM2bNpykWWe
 Y7N+qlUkWh6H11c4BsdVmwQo=
X-Received: by 2002:a05:7300:2315:b0:2c4:76a3:bdfc with SMTP id
 5a478bee46e88-2cbf6897126mr2280931eec.0.1775466202269; Mon, 06 Apr 2026
 02:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 11:03:08 +0200
X-Gm-Features: AQROBzDwpcCEtASRfptsJ0WJ2jdyaJlOCl6SPsL-e-w0TnWmNnUbHOjTvtft1Wo
Message-ID: <CANiq72mnGArtgAbe7xXZCYW1x7Zd5hozfnzoftaGy9rxoLO4ew@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] rust: bump minimum Rust and `bindgen` versions
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
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
 Gary Guo <gary@garyguo.net>, 
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

On Mon, Apr 6, 2026 at 1:53=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> As proposed in the past in e.g. LPC 2025 and the Maintainers Summit [1],
> we are going to follow Debian Stable's Rust versions as our minimum
> supported version.
>
> Debian Trixie was released with a Rust 1.85.0 toolchain [2], which it
> still uses to this day [3] (i.e. no update to Rust 1.85.1).
>
> Debian Trixie was released with `bindgen` 0.71.1, which it also still
> uses to this day [4].
>
> Debian Trixie's release happened on 2025-08-09 [5], which means that a
> fair amount of time has passed since its release for kernel developers
> to upgrade.
>
> Thus bump the minimum to the new versions, i.e.
>
>   - Rust: 1.78.0 -> 1.85.0
>   - bindgen: 0.65.1 -> 0.71.1
>
> There are a few main parts to the series, in this order:
>
>   - A few cleanups that can be performed before the bumps.
>   - The Rust bump (and its cleanups).
>   - The `bindgen` bump (and its cleanups).
>   - Documentation updates.
>   - The `cfi_encoding` patch, added here, which needs the bump.
>   - The per-version flags support and a Clippy cleanup on top.
>
> Link: https://lwn.net/Articles/1050174/ [1]
> Link: https://www.debian.org/releases/trixie/release-notes/whats-new.en.h=
tml#desktops-and-well-known-packages [2]
> Link: https://packages.debian.org/trixie/rustc [3]
> Link: https://packages.debian.org/trixie/bindgen [4]
> Link: https://www.debian.org/releases/trixie/ [5]

Applied series to `rust-next` -- thanks everyone!

Let's see if we find any issue in -next.

(If someone wants to give tags today, then I am happy to pick them up)

Cheers,
Miguel
