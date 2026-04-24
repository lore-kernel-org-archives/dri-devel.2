Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E83FE51FF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9836910E072;
	Fri, 24 Apr 2026 10:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y4xlt/sB";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460BC10E072
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:26:43 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2d935b4b15aso467370eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 03:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026402; cv=none;
 d=google.com; s=arc-20240605;
 b=Feh8vCt18L5AOyNutdDtofoTCo0AZQo5ASmNH8dwBvFAv5ziZZQcfWsK2bGKuw8fwZ
 Dfw6lstbEOA7TgoidNnwqEucwNDeFzSWkOL+FQDomYkkiQ9fL8OrYqW9gXoq7LxPC1fg
 eSlp0bC1+iIZVxYPFo7KasBvNA5xiuYP4wogNR2GCjPSdlZXy1iulUKUBfTXMUOOSVMM
 w6Pim0zCcUQg4caYJoeIi4jbaFBh6lAVx2BwYsEczObJna6+gi/9K6UAa/3Wwod4eDmH
 j/0YfFm9GnTiMd4FNN7Cd7oddEEvafF99ad1lR4md5xWJlf5+MZitPRPNriZCTw3tpOS
 89fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j0xKFe1jeJhx1ESLTH8WRadcy9BjbQbmpsMi2ljEDVs=;
 fh=C3W6y8Sn4RCE5chycY9KrZBAJUV157NodSUcv+JqBII=;
 b=jLVWjj9CiYldNAFUj6t8KVzL/mJYgC5frEpZedbiBVvpJHyFIGKN0b7zBF3Xxb+bnt
 B1mJlVCFmhzybHftEfODr0OSMvb51khFemo6+7Yn6E+/2mGn+OaCYWpDwT1GTqvMY0Ff
 sTyoFIWpObY30wshLqqPlftC64H2JJ/H9rUBJ0hG8oQCmHCAddr4J7qgeuWILMY7TrKY
 NqU18mr+8UHJ7l2dPBBo49+moKlobwQ23dz5bxEjnKbwe7CQtuwz3LmnrnPXQNPEDTBS
 bYJdcDkYJUoFtHyjdbr4bB38cHJJivXOy2OJuuHeUcLXE1zgn2xCvAK+AiUPJtzverpd
 3fPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777026402; x=1777631202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0xKFe1jeJhx1ESLTH8WRadcy9BjbQbmpsMi2ljEDVs=;
 b=Y4xlt/sBUdZcxQ5v38Izf8zVyUYayuGLWj7MZvYD7l24oYZLVV1lmcmYCdvEFygwjT
 lKS9HQJCyo6Kp6JU1JPMR49KDHJ+2toWJJPDD+4miXZwB8IzpyTexYhPLHmLZsQcCQTU
 ZCgmqtz1H5QshJkWwhcFvGvVrolz1RYXD7c7w5rD0mc/H1EwiWo4cErKae9szhiOy4s9
 wnclHrIwdNPrRsqUe5W3WKYcRiEWYjTS7H5eZYVthe9Yf15k3nniilhur+3/a1l7B4Nu
 qoaKyimzDHF2Ggva8JQMkkKYMGlQFbH4RTYgBe84jIYUst9oaeJKmG74m4ZQaBGEzl5Q
 vddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026402; x=1777631202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j0xKFe1jeJhx1ESLTH8WRadcy9BjbQbmpsMi2ljEDVs=;
 b=g5fnJSxSaBxPik8PDs1X5cSVXoj7L+9Dx72HkQzkGIlV4QQ292RA2bYCWekZcu8jC3
 kqZbwAsqBKKgmZTKCFoMe1H+/7fxwukPvGW3g/JvHI31l1LQ1BDNEhOr6pbhL/6c9IQ3
 Uore0QWCdc2NC1bJCQVuOEIUGh+Y5W61Ce1vHQO4wqu2kI8uVjTt6bl1772eKccz6YHp
 wRQALrANsgqq7I19MHiwxx+8KUlWlIezP7NbcRRsMFCWQ7JQSQ8QSQn70Tz3UQRe11kX
 22/c9RNpuuuyyPeIyjxyk/2Oq2EXtBDVwCd7yp2JXTW4y4T/VPqomytEv3M6b7g1cMtH
 o2QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ86Fb3KEeRIh4dGIQEoTN0ra2yk3dc/l+pB2rzL64/N4GIkqfMfRe8+kIYyFjj0b6mHNWXIH3ogNSM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzjjb6aBxTXetbRM9YDEdqNfYWzzvweDliTtomnWqXYb7QY+72g
 kqY2ecPsNYhIYyLmn68an0RhBS8u1vSr6fcZ2DmTshUyUhIzvFVwJYJhO7u8//s8+IYHniGQU8j
 yWOLglaCIE1Za5DQyqquIE6+kcLZk0/U=
X-Gm-Gg: AeBDietA84OIxODr3ghsl1m87y+BtQ+dwseVgxXidtJ7K4+5E7AVL3SEqToJwK+61E8
 YTjR+VeA+uv/QdHByHtrymOzrFhjGlUfNkFDoymj3KK8Uwk9JtDAzayJv5ZBfIaCAw8iBcYyV9q
 CclVfn3TtpjWhgJknKlt8MU7jglt7jmrarWCQsnlECOZcKZ03sLRbRoDApY4kkgbyAg7Oi/aj1w
 CIjYlmVsHKxdRBY3DBhCzknw6+pvso0udSMQXNcBXNnOi428YbEi93h7OxMkuaQkfYItJqtktEi
 pWH5H5n4oD0tWwxnjhONzk104eZAOszVx1fCy+OW0OBNPZ4IGDn5AR6Nooj0NZfiRe9FA0pg+Yv
 h/ODxgis1GxwWXNAEGzrdOXBmbX0pnp4PCA==
X-Received: by 2002:a05:7301:9f03:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2e478a2e850mr6554300eec.3.1777026402324; Fri, 24 Apr 2026
 03:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <20260424101425.6bde0e17@pumpkin> <aes7L3M1d_LvvGKa@luna>
In-Reply-To: <aes7L3M1d_LvvGKa@luna>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Apr 2026 12:26:28 +0200
X-Gm-Features: AQROBzDET6d-0hjNl0HV899j9TcLUcNjD1kIJArKfIFhDWI5iKiWhVLnvOkXFjo
Message-ID: <CANiq72nsYy-EUSMynykb=6QyR62M7hT61RoTO3F0-vw1oBMh+w@mail.gmail.com>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: David Laight <david.laight.linux@gmail.com>, 
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, 
 npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
 jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
 rostedt@goodmis.org, ardb@kernel.org, sumit.semwal@linaro.org, 
 christian.koenig@amd.com, ojeda@kernel.org, boqun@kernel.org, 
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
 a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, simona.vetter@ffwll.ch, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
 llvm@lists.linux.dev
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

On Fri, Apr 24, 2026 at 11:43=E2=80=AFAM Link Mauve <linkmauve@linkmauve.fr=
> wrote:
>
> A possible solution would be to change the core crate to not divide
> u64s, but the last time I tried to do that I couldn=E2=80=99t quite figur=
e out
> how to do formatting without it, maybe I will just open an issue against
> Rust.

Yeah, I have some context at:

  https://github.com/Rust-for-Linux/linux/issues/2 ->
feature(compiler_builtins) and a way to avoid certain intrinsics (f32,
f64, i128, u128 and 64-bit divisions/modulos).

We have discussed it at some points with upstream Rust (including
related discussions about having more `cfg`s in `core` or a
`cfg(linux_kernel)` etc.). I don't think we have an open issue
concretely for it, apart from the Clippy one to flag the use the use
of the 64-bit division, but if you open a more general one with some
details, that would be great.

Thanks!

Cheers,
Miguel
