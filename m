Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CA2F46C72
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 19:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D38910E259;
	Mon,  6 Apr 2026 19:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GRwM/PIy";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B011D10E259
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 19:01:48 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2bd5658b901so258249eec.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 12:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775502108; cv=none;
 d=google.com; s=arc-20240605;
 b=gjZjlzPUOj54zDUk2phl7Zt7Gt2m9c2ZjnfHmoUMeuVS1YK+xgxAn8LpsgGjxtjwQ/
 40IlJTOOYLRzhy6vX08vmZCysZD/8TbcOrRwUOhWPYBxb+NMriJtewcI5ZTdXHZ/j4Dn
 TxShuhOgKOqzqZQY6AKbwXJcsTkKzLb8m93qLHOcpZlm9ZdScZUz8bhkBbSTbDv/4D4Q
 JyuEy63LbKCq1jZ90kFXW/8O3kWEMGOEkqssKXgWicDAzeWNrDK2TlSsoiBDTW+djGe1
 kictDLiD5EPpzY7xXnhR7LQFNyomhHBAf1EWlUvYBQ9tCV2tuDkM4hOhUjwIxsAvT9cG
 lruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gf3VuwShgbYg5PZ/J/6LyKGap1JcrY8bWhqVawvmQIs=;
 fh=DYzp2C9vmGntlu7btcsep0HZU3o/E2fP6PXPe4gblrE=;
 b=GiMkV9bVjmuEohNRDGOaCibi3ekmMw/rGUpLlbXhnZFUVe47OVKbL4Ys5av4x7kuDE
 jZHus0kbKpSkb4Y/4vgJRJdISllZ8IAoHatG5Kfoy+VVaAi//7TOOJemHIYqKAgryjDB
 JMy5yhn3QloPNbhdUGC+t3BUSt6zhkrYMcuH2GErfZ9Avy688KPeiHtZsuB0VnOYw05E
 DDvrl2D6Kpu14k+vK5KYC/5Q9rAqQQdIFeqUHe5ijl1LKMb1illxoXzuvTpnoIqE6ggQ
 oBWnUO2Jc3sVMY+ofdjivhcbzT4kK1REvjkdC4lGBeRIgKAG8SOIFKNMAsuN4aSbV1he
 smZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775502108; x=1776106908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gf3VuwShgbYg5PZ/J/6LyKGap1JcrY8bWhqVawvmQIs=;
 b=GRwM/PIyjkvi/5NyR0xFxBqWCbGa8dhgUQZ1D9OYZb2A1dH0NzAM0xhwuNfed8SjvU
 OppPHK5y26o6o8VQLPuDX2kWSkbrbGDXNLLXezkvQCiqG+5g7ITTPiV3DZc8pm0y1rb7
 DLJjgccQjcc6GECG0UZmMY/ITh779/SmePXaKJHRJ4xourNefpBqTSHEDwta4yJaAKjh
 UOLhwUFg+eJjUwT76ybaZ9nSc6aUsCwRUrH8dBXGQY6CMLYUOuDMv6R3QuH0ml4I7xZg
 X9DF3q2Ai9O9Kox/l75cvCSRy345dY6SkXHhaRThRcMCQWxO92h6DwuLV83DuErlpWFF
 ikSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775502108; x=1776106908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gf3VuwShgbYg5PZ/J/6LyKGap1JcrY8bWhqVawvmQIs=;
 b=qu1AC3ufVgp0vu3QBWBEQMY3bDt6enSbgF4pohu/as37mfXmZ6KRRUb3i4fxBojs0q
 FtFJ0oMNJhgGauAnwmMHPKVLsNqFdU8hpfE4+RxIZqkjKcgo0Y2n4v41SOonnc8JZLrw
 p6AGodVsZGeO2ruDNCbul4H4zPv+g8ZZJRKHPLNVn4Oepnfr4xAOpTmy927oC3jCnaOy
 MBZvjPqMgtM4bUfbEVTpejQYZg1FAjAmD7uu5UfljhkWhlVcXpZ6wc3Du4FWx0XvuH7g
 T2mjIq5u2oxnZ3PhtjDXjXmh55NVobNqmYqKwo4zGLJmfNLehlAg074Xt+jSFy4JXjUw
 YN5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMg9klJ/u+xPGRDz+w+3+aFs+WDcR6fvWT5vQBEepRXnJxrPVZZNew3htOzSALR68r8BTKy3nceVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA06H2iZaimkl/ARRmiB8f4qFJOkKKShOupvk97HfTQrZJ7GXY
 jTQ0S+z/MUGiZVtTNtgGaGFV/kunGGgN0W9oglz+ffrMP73cDZAfjAeZlNadLt17Cwv6sk/sDhs
 IgbDiauhRwusGTCxkrSZVsU6cujYtJFk=
X-Gm-Gg: AeBDieskT0/jqAPJdZU5rlcrthgSf5We86MXsc3+fLi9PHEuqkVUR4ttDaEexINQYsa
 jpBav4IRy87KO9JYUpLlsTU1a/+uW60tZCcP5CdNu1Va1ilhpPbaGQR2OpewOs8CYE1/d4rD96f
 g/UOWV9WcbihJDC4Rg7P8ucpi2rew+xEUdWz0QGUw2XLmGYTahJrYV8zLaiX5ijZLg5DR9oanN3
 5LvQZKthGaiW7JNwjy0nZIcHMQbsSms1tsSPPR8/57dOajmgkaqxwVCoZabpMRSnC4OktMfmwB0
 gXzL71TFnFo7kruAUnpTzv2I/qqD/eXXJfKJfx6p/Vl/xNlXYzDHVhoNxpsqdAvuzZ5iM5ied4W
 pNe6zqsuZSeLePJd1atzSLqw=
X-Received: by 2002:a05:693c:2b02:b0:2cb:6653:ea05 with SMTP id
 5a478bee46e88-2cbfcf5295fmr2949463eec.4.1775502107727; Mon, 06 Apr 2026
 12:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org>
 <CANiq72mnGArtgAbe7xXZCYW1x7Zd5hozfnzoftaGy9rxoLO4ew@mail.gmail.com>
 <cf28afe0-ede5-4d1a-9824-65a1448f8161@nvidia.com>
In-Reply-To: <cf28afe0-ede5-4d1a-9824-65a1448f8161@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 21:01:35 +0200
X-Gm-Features: AQROBzAfx15_qleB1FpEnqVT3LDjlhAucDNDkuNXvaEMC2J19jPyg217OqF9cWw
Message-ID: <CANiq72n4tmTzqbcHCnzUBFyLVmJzB-AJng_1FgELJCWr7hDg4A@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] rust: bump minimum Rust and `bindgen` versions
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, Simona Vetter <simona@ffwll.ch>, 
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

On Mon, Apr 6, 2026 at 8:51=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> Looks good from the perspective of this patchset. I am seeing
> one remaining problem that we previously came up with a fix for,
> so I expect that that fix is staged in another branch. But in
> case it's not, here is the report:
>
> On today's rust-next, using rustc 1.85.0, at commit 232e79c72f57
> ("rust: kbuild: allow `clippy::precedence` for Rust < 1.86.0"):
>
>   CLIPPY [M] drivers/gpu/drm/nova/nova.o
> warning: consider removing unnecessary double parentheses
>     --> rust/doctests_kernel_generated.rs:4240:14
>      |
> 4240 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), poli=
cy.cur()));
>      |              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      |
>      =3D help: for further information visit https://rust-lang.github.io/=
rust-clippy/master/index.html#double_parens
>      =3D note: `-W clippy::double-parens` implied by `-W clippy::all`
>      =3D help: to override `-W clippy::all` add `#[allow(clippy::double_p=
arens)]`
>
> warning: 1 warning emitted

That is already fixed and in mainline: 487f9b3dc6e5 ("rust: cpufreq:
suppress clippy::double_parens in Policy doctest").

Cheers,
Miguel
