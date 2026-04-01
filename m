Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3242D2ED08
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471B310E313;
	Wed,  1 Apr 2026 13:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ItxiVNpT";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E5710E313
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:31:51 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bd5658b901so286289eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050310; cv=none;
 d=google.com; s=arc-20240605;
 b=GoT2yVuBZE2hdG3mGth93GvqtTeiiACReow4LAWP2Qq0xyVy/3kkLCK56FOtEHfCsU
 3AULMh9ncxhCxzIt12PPsdZOf3qJvYiJZloetg9iFVhmC/bQMbJqLACeDIo1p7hjtJF+
 sFJSKmyZBAPGDnDTbQSSVczjj0pvvl8AfIeoFVu80hDN/8263zewJ1QRYU0nVaW5KzSD
 dUywQbe+GwFuJ6+m6r7VB0wrU1Wbk5jHnoHiYmTCz223A4836eZcwAtHwVSUrRDX8/Ov
 upv/4lPjbDIJKa76cpkc+7Qxxgg5mzVg1Ghop/86t/X/QuiM1H/dQgtuHutSvKvooYyY
 jRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pxwyobpuf86TQi+f2j4+wIWXBQigp/e8eZSaPuRG5TU=;
 fh=XeKHkO1mCo7Fq1/COwcbLjd4W3Q5siQ9MGGLw3wsrhE=;
 b=Ts14AEZV4E/VlwKLYUSNS0qUkWBaIm70D0J5PvsAcbqZyix4uD11b5q+u0k85XCSZk
 aSFMuLfIECjaCBSbCi3ilj+yTRa8nh14lp/UlZ4PHmm9a8MI89pG5hqyp5sGo0AzAiPe
 sfBBsV5zfNhuK3VaDRPi/irwKzEFBYoGA1k4zCbRk3YKz9sjlYo6Mcsi7J803ZFUGX1n
 JygW79XyP9Fy+VKbMfZs5vc6y5yy2BSybE/CfVIAr4E2ulbgzh1bzxXp8ZqI9UpbWGai
 aA2YETMT1Lq09EOu+SS0DVD5TrLxRkDkEVPo9KVnjbVH0Zd6wOG6+xZOuOH24tsma3WA
 ff2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775050310; x=1775655110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pxwyobpuf86TQi+f2j4+wIWXBQigp/e8eZSaPuRG5TU=;
 b=ItxiVNpT4xbfWP8Wr427Cmu19/dn2btuLUjkjP0eLcwv/K/9tXp2D7DwuI0cPqSljd
 mo5inN8jOVMrnjRT0A+3UuWTxSVu0SN4FkO1a1AgIjbyuVXdCLiA0hXwkbC1KXXsA50j
 qNl4HOihioMjyu2NNXy9aDslI5+DCEq2+4FUQ5xBiPq1nAL26ER9TPPG8A6DB7UWOAi2
 2N597jDcd16iC8oBtDsUMCDJORsrwCTiz3qX3Wts2L99w5ZeQK6chn8E1kEtDz+uh2dm
 9CIoBQlOygMJC7dED6giPQ8lIiAc8mQulIAVczyJQMmpA1F+A56MjP6072ZP5KyveNC/
 8LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050310; x=1775655110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pxwyobpuf86TQi+f2j4+wIWXBQigp/e8eZSaPuRG5TU=;
 b=WPT/tbck0FrHAeeGxh12aHGqtARgop/RFiVp64oyhW8GXc6SmQX1YdQDPt8hZDKo/5
 tMYVawqt+O96Cb2fDp9H1aW+IKb6mpsYx1Y3GflwQt2+lRTC/vNaf8c+SgJgua4HU8ka
 kyxfKL/0Xnp1PcNK2kPAb8BOo7rbN76WplfKkoRk+tQ1sQCHj+6JjkZLedkijwF/zUCR
 m6q+s3Lb6y/2IhkhPbLyqTG+kdweau4EBqESxDfSKW1dToyL7ETe3O3enN687xpDcPI1
 /VyvLyoFdsezY7IzkO/VBNowhjeSrKaVTPpQBjkSOKK+mYMDMxe4bnUjs2hRA8S4Qm9X
 B6wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB5OFvt/imjX6Pra+aUpmKr0JdpQJCY9c0dC/wdBd3W4ZIZyDvdXFklB6VTMLLVceZeju/VQOdgF8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi780d+WAXTsK059rWw5yXqYZhXmVMfgBmCnAYRIwhY7FJny7s
 R/au51dkwa7nzIvxTOFEzoG7jff02uBzaS9Mz7+Bslc83i64TL6auD9J9UHlMoq+px3gmJxDVlN
 s6wRcazodWXAHQswEP8ea9gF9By9/zzM=
X-Gm-Gg: ATEYQzzE96X8EDRqo5+Xae1Gbtam8D1rfmNfE95MxHD5Rp5c0JMOIXTKyXJBsqGTKUS
 Z0J92gl2hEHf+o3uDPB7aCIwMqawN2JtoRO46deCH+37Q2KjLwzakXXBtJnJ9WGzNGxnvskTR1p
 Zx0/oUk8hB6In+QhWe5vOkINc9BfKcmGtk5picuYIko0vHi52RPm9hFZVoOv3ygWjbvOmYZZeIU
 etR51Ca6TpDak0flERsTNf5MgQkW8JFNKVIR7wnbHOhN7PgFKBpGj64r+FFmBKTChrBo6yubf2F
 RGlj1t2euvrctpCS6+h5hvjw2zaDWnS4ZgymC8QcnTUtrkgkQGxhR7OW+G3a6IQSTPTnZiKwMdg
 p20BnidkkFMz4IRKiUp9NvQpcCvk+ihApmg==
X-Received: by 2002:a05:7300:fd16:b0:2c4:6ec:141e with SMTP id
 5a478bee46e88-2c932bab66bmr849425eec.7.1775050310241; Wed, 01 Apr 2026
 06:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-2-ojeda@kernel.org>
 <DHHUQRB9ZL54.VQZ7OUZNSYDS@garyguo.net>
In-Reply-To: <DHHUQRB9ZL54.VQZ7OUZNSYDS@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 15:31:36 +0200
X-Gm-Features: AQROBzD4KmXruNHpjUyy0X5nLhLhXQUuTTY9eP3fb4LBTyRyQ4wVkUjvlUGGI0w
Message-ID: <CANiq72=FBbJ--jrzYyKe3T56YqT5eU+0DXzPG3Ho7a+D9rfu=Q@mail.gmail.com>
Subject: Re: [PATCH 01/33] rust: bump Rust minimum supported version to 1.85.0
 (Debian Trixie)
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

On Wed, Apr 1, 2026 at 3:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This diff fails to apply on linux-next, due to conflict with ece7e57afd51
> ("docs: changes.rst and ver_linux: sort the lists").

Yeah, sorry, I should have added `--base-commit` -- it is `rust-next`,
i.e. 3a2486cc1da5 ("kbuild: rust: provide an option to inline C
helpers into Rust").

There will be other conflicts too, e.g. in the list of features in
`scripts/Makefile.build`.

Cheers,
Miguel
