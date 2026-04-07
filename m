Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8410AEDB7CA
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 08:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B5A10E362;
	Tue,  7 Apr 2026 08:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fGVIKqSe";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847BC10E379
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 08:37:42 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2cdf546f956so154146eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 01:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551062; cv=none;
 d=google.com; s=arc-20240605;
 b=BWK3fVlTph9yn+T+n0XqUtWs5UMMxgl8Hj2KvxgCSxAkkuWR8Il2Q8Ocm5MObmPNvo
 ByDDduKgM/Tu2UlMW2jDk+Ch6BzlitYAcjkYDlfaj7CicuGaM1MFM2kcHkhpPMEX/wsq
 +2+39DChbz33sh1MclFHCwkgqcXKSlcAA7aTYIEL5f7sTE9vNvB3Ntd+J4fLumiL1Kbe
 xea4N/o5YQLuyA39dlMpzTOp6roj9n+VYAdwBFuJP8dDNh/pig5b0GfI6jaZmpesncBH
 tKgijDXuoab4k2xIx9HRRPqZW8t0djrd0/PtSeixZtvXMOsjKY+abrCe9gCWhTVc4/7k
 roGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gy0ttEzqHnoPOGT+UhllrpZ7VKqpJE2isFAosOgHjU4=;
 fh=IYZQcDsDhSQQDoKuFFIGuTWYxkZ2gqDNiYKEE+NvpM8=;
 b=FyI6t/kEFWIwk4Q7FHRa1OBJhvyhTkk8nXpHqhx+eds5Ca7KvOM3lpjHUPjF1hC1EB
 SpPvd2z62BbOU6TAirUJbcw/iIap3t+9QKV2apjOSWLZnfkM0/bFJeXn29VxE2R+KqeJ
 rI9OktTNP7YRhSSRDk63s4i36FOnxzc6AM7+pYfH/JrebaVb7LZNVkfw5As28y461NRe
 qsvmaqP2zUxiicW5oNz25ZVJwk3tl1WzxBa9n80MabB4xa6IBVm2hLPaQpjD6EhLKasR
 bhsG6zIcCR/XiqC0JCaVp6ulQ6Uh+vzghch2caHkbGqy7FilkA46PH+u/zAHYhHNkmJV
 4IoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775551062; x=1776155862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gy0ttEzqHnoPOGT+UhllrpZ7VKqpJE2isFAosOgHjU4=;
 b=fGVIKqSeTyYME5T6cTR7/jndEDAj4fFN72oZMGXir+fAD43yqnKwn4G2MD+yPni/lg
 Wz8kbbey9JuUVGX4hy452xFxFmYAtP78X03CA2sfESpwzd11zcbJE4nfJviPzO9nUIkv
 9d93KyBgJvf/XZ5AbcoTn9dvCyMIli+9dyAzKwvz4Gvgctkhj2V0Xs9H9JYJEEADO8le
 HyY7Pg+3aiqC+VEUfILwY9z3YWPfs1/KLmgEQehmyn7LhYOOIjSO2cyQe6WffwyS8JT4
 RTSFsd/rQIwSVP82dMpXbvxZANovFGjUcXEbVtS/5cWKPNl/2VMoJRzNuqD+tQ+JBPh5
 ht4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775551062; x=1776155862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gy0ttEzqHnoPOGT+UhllrpZ7VKqpJE2isFAosOgHjU4=;
 b=EZSBqYpfKd2EZTZts5EGLl/BscKsVVQiTiNzOMVMGV3F6JO3JRV8sDCREq0Le7OKz2
 tgiwl6Kymkx6OU4zOOm3A5XUo7ZAgIg0FHsCu4trZ0i0v5+SGu+vWy4xd3h/kz7EIPfS
 uPCtjMmf8uqM28HN+F6OGLO4eq5K2wkGlD8Vo8ymiZln6z3xR+1q5gb3nNHVAMknEsaU
 veAFU16ah64mNLmmomc3evfLNWaLAfxs7zzE2Umofa7J8oRY6vJjpC/2x9NsS+a0h8cN
 VRExmDwsrDXLFmtTy5ri/wnxmDiGtS+6PymCylTQt30HIxNXqWhG8ImK7YVysQ2wHjXD
 9sEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ugqFZYTgp03NIJUha8zSGVnW1AEvF59lmgAXwamL5A9wZ40iPRo5xaOwdXV5vSL0OqWs8op8c4Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUpv2htOiD+DZhyaGU5dPSQxe6FIEA2a9L2/0M75qQyyG8VfhH
 I6R/aqqGQ3cPJw8fTg34P0JL6/vP2cghOWpq9RpjitAqtO9QnW8HAmR5K/FJlE7+xLWvqGJxir3
 8/NDgD3RD2MfR1iyXt6Ckad7AqIZNrEY=
X-Gm-Gg: AeBDieuchz0/PrNV57l1IbUZS+7BIAcS3wAxaI3uxseIpB+JHJxNh7kYG5WQHYBgsWB
 oSFNhNstgAmwWoaTdGu5YmAwGjbJNrYyHzaW3mmOGDj514L9UloZZZ2MYAjSrYCn0AFnvWFgVTU
 S/1/mX9DzTxGfyMivF1+Vm+yPkrMGGNYHRY0KC+LOlyXKYiwYo0K/efNvYl+0PC8eieV1VvBP1t
 j3AyymCf4nHJQFcUHGyS+tVITsId1pmk3D91cX/Q8o4LHepPP4QEKZ2KrICKCluRDJOCdSxswyt
 WYcbpA7A1+dbC4svNZMR7mF7iRUEy2vmqo0Najk8wvV4PEOkzDf0JB4dZ8x/8n+E6fWQRTuFC7j
 n1IZW893GNIRIwHT4yTCGSJk=
X-Received: by 2002:a05:7301:d1b:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2cbfcd54f9bmr3830933eec.7.1775551061539; Tue, 07 Apr 2026
 01:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org>
 <20260405235309.418950-8-ojeda@kernel.org>
 <177548573697.95472.13544191227699996309.b4-review@b4>
 <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
 <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com>
In-Reply-To: <CAJ-ks9kbHz_KYAXx02vgW1dN2pfb5MFoaSoU1HbJbJg2O8EUaw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Apr 2026 10:37:28 +0200
X-Gm-Features: AQROBzD3OQzI1eA28hVCCiGMvz4r5THmhHuU5dUr3xJV-N5wbeOjrOxDF8RLuuQ
Message-ID: <CANiq72mJTT7xFnhm-CeOZM_3ZwGdaQ8F2zUbONpPbqJ8g7DokQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/33] rust: allow globally `clippy::incompatible_msrv`
To: Tamir Duberstein <tamird@kernel.org>
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
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
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

On Mon, Apr 6, 2026 at 5:31=E2=80=AFPM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> You're welcome! Actually it seems the lint was already improved
> upstream, starting with 1.90.0.
>
> Link: https://github.com/rust-lang/rust-clippy/commit/c0dc3b61 [0]

Indeed, I had the PR linked in
https://github.com/Rust-for-Linux/linux/issues/349, and it is nicer,
but it would still fire in a case like this patch :(

So we could conditionally enable it for Rust >=3D 1.90.0 now that we
have support for that (and allow locally some cases like this one when
they pop up), but it is still simpler to just ignore it (especially
since it can be quite confusing for other developers to see it
triggering).

I think we may want to eventually re-enable it when we use no unstable
language features.

Added:

    [ In addition, the lint fired without taking into account the features
      that have been enabled in a crate [2]. While this was improved in Rus=
t
      1.90.0 [3], it would still fire in a case like this patch. ]

Thanks!

Cheers,
Miguel
