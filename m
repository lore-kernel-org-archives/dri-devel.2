Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB1FE9D800
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F369F10E1C8;
	Sun,  5 Apr 2026 19:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iiyvQZWw";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F4910E1C8
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:35:59 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2cc175eec4dso117354eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 12:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417758; cv=none;
 d=google.com; s=arc-20240605;
 b=jUv5xee12/cL9X/MnB3E+vlo4jDXwAfoZJQNJTueXRWBybGk+Gy2oVEE3lSzR33Ou9
 tLhCDkHRBvYScdmyOpLJyymT9zwuv+bpTIWbmtEq4RvejvQn++rxBnjwvS/Q1Nwea31q
 dYFfZDFv6NE/CIvoUk87e8dPuKyQX68JinTQ9yyxKdxd4XgUgcz2h60wsxcwKe7d8uOO
 hDkJtYyW2+nl8rEqTgZhfIAGuDrkZDezbUcxZzg58LmPiHroUY+JUxwyaEViJkgmzYb5
 ExCUSWYRINxRQYyF0BwAKcN5IJ1b7HG4GpL90ENPRV5msNFsU6sak0bdqRQ50+mjLh/4
 y4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BfjKSt6DEr7n25ZH5xS/6Npl1F2WZyz5JjVGM21RHvg=;
 fh=v0XrsosR0AL2uv2VfDyFKdnQtPpKttyNTjxdXlzvTRY=;
 b=dcVCcIrqV17cPGVnmAB47TFk2N2RUwkjTJasT0GCC0wdIRgI7WYLzWxV8pEzJ6CEWY
 WWDCvP3xwhbah0TqBcqolZt26SgJ3iemA2t8HPVex6ozuP5DtzcI7rqVut4VJa81gJXd
 0ab9jYr7vZJRzyxp1h/ym1OaA3NS/dzJD4E3oRsoSBWB9MPVkXuj/MSEu+KisPuoyteh
 Hy951XwnchFtfqtau4oeuIysQFGY24ATPD373hL4cTjTPO9/iNqc2OHAiT4PdHatjnGx
 fC8kSTl76Ebl16gLrWv3DvYqpiUZhZ7zJk9ubdH2lHUc/iAuEgoiPkKkLj3rw6wfZSkx
 7s0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775417758; x=1776022558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfjKSt6DEr7n25ZH5xS/6Npl1F2WZyz5JjVGM21RHvg=;
 b=iiyvQZWwcjQKaxyaxGPnNiu8f0sSJagijPvY0K9SOk33fbrQjsXvQBIlcAoB0IFvXP
 7vnRS7WFhiPKIkjSJrxZtBlmR/V2SkFgckwkjcUCZqPxBdLImyE5wRdUylqBNlBNuoTV
 vaM7EEW1IbLOsyTAK0QCaTDSHJyXop1HUnLqeQUIq9NHhfEEDgRJkuDcVqjn0/TIDI3f
 usJSiUeEBNxr8+Kseone2NwOyknNBobNw6m1Ov5goWIEDeXjK+L5LNnulPdWWIWaBCft
 GfGc8dl+jipQx25MbJoFNxImYdWTIQ9T+GPbdnvkuZOSQvs0ggYhBgnNjMtHt9TPetNC
 Ajpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775417758; x=1776022558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfjKSt6DEr7n25ZH5xS/6Npl1F2WZyz5JjVGM21RHvg=;
 b=HXT/dgYGGzA+4YyIoSEC6q4SeV0HSyThClhXRzrhbxfzEePdx9rtDBzgICSS5BoC6y
 QE5AiEN78LZvukXuTYzJn6YgzxUKync9jPPR0kbylft5bqjaFMNFBV/sY6s/bbYCH6iA
 ml1znl2hnOUeTvTufq0ury167e5cTMipm6gBqra2Q3JmcAjB6dQy8J/BGwZGsJKMuKhA
 oi0M/S8iAcpGVnz1PH1+g0aQsdDFRDKiRh47E8XsXDDEiEMGPX10N0/d6hWlBZK/pIJW
 HwNMeQbhKRznP5OTSMAW8rQoW5kskBvgeMdF4J4ek8OAlB3IbOusFO8dZ+QzuiMpA6FG
 gpHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/y8x4QAWQFgQ17t1ALnKOxG/PhmeX1b1QRZPsjhwiNcBsQE5qBEWbk4efY5ldbSmK/Rkz3BbKoZ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT79mb55UJ6e3i9Wu2NYpsN7wv92odcKyRdz5WBZb9RdZhhd0S
 gD10d/ug/dazOCqN4JLHEHbfG0rXW04tCqnxR+Y8DH/DWuOCHZJZVIMgMDUp1MGAmEvbhKMcxli
 q3rG9nJSra1HQnl9yk5Vkv5dYEghIDo0=
X-Gm-Gg: AeBDietJM1rmiD0ZIeve3g5q9Jh9fXJ+Qkx3MmFIWCzPlHNowWs1TJgXjzUe+8i7/Y0
 H7l5FIMkhAnmh62IO+YX3R+ASubCSyTBiW4FoNMRFdHGRvXHr7QPfFT6VpE81CRyskUuyI9/UWT
 8sJsZMsz+ARC5YCSfovx/TIe732lbmP6H+BRUfXvV6axb90IncpyP27alxCSvnIFKsbnTW+fU9x
 XXZgEHYSy8HUqj++nFMdq4MUwPI1RAkM7LssAQbblhP7uCqnfdBYpcNJdWbEIsAwllBAVotklT7
 Qpic5F8/jAADGhOSUGrHuf5h1jsvXNLmZ43C1fPOYRcI/SAVju5GO323yCZBJyXd5RxQvlHH8eP
 AP7DUU/dUP1zuieLuNedEzZE=
X-Received: by 2002:a05:7300:dc88:b0:2c6:7f49:a862 with SMTP id
 5a478bee46e88-2cbf9afb2abmr2166610eec.2.1775417758303; Sun, 05 Apr 2026
 12:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-24-ojeda@kernel.org>
 <177508434465.73816.4492182082440539007.b4-review@b4>
In-Reply-To: <177508434465.73816.4492182082440539007.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:35:45 +0200
X-Gm-Features: AQROBzAMmQ2fYtLyUeAFSvUDsVE_iEOg6GKNUQ48f6LlPWNoSXcMUKGWx0A_W0I
Message-ID: <CANiq72nqenC30r7QQAmdKxS8ehGU2SoSGr+LCnoTAGLegH-KnA@mail.gmail.com>
Subject: Re: [PATCH 23/33] docs: rust: quick-start: update Ubuntu versioned
 packages
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

On Thu, Apr 2, 2026 at 1:01=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> RUST_LIB_SRC is also mentioned in the nix section, do you know if it is
> still needed there?

Yeah, that would be nice to know.

I tried on my own, and it does seem still required (at least with
those packages mentioned in the example). But perhaps a Nix user knows
of a better way to do it, anyway.

So I kept it.

By the way, I think it would be nice to have a "standard",
well-maintained `shell.nix` (or a flake or whatever is best nowadays)
in the kernel tree somewhere, i.e. one that is known to work, that
covers most tooling used in the kernel, etc.

Cheers,
Miguel
