Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE0DE9D80D
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391D789954;
	Sun,  5 Apr 2026 19:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r70ohNCF";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14B210E066
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:30:02 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2cb19ddda43so250156eec.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 12:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417402; cv=none;
 d=google.com; s=arc-20240605;
 b=A/UQRDdURnpImbIAiy7iFlWcmZGH4n2f+hUpYrzpRwdflDzwfg71LijfmMMALlO5Fd
 8+XbxHqoWYzsy/rPYuIPU1tbWwMTrunlcCtRP74EgxlM++ySOA3ePy2HLL9u8VcRIfpz
 gHNjmi4Tx14d2NL4AbHXOaEYtscvWQTe3yWgsI6dSX9s6WbfRsy9PTAmcP4hWCV62kQv
 pfgSwylc0tCjyuhbEbR3RbciTS4sjMjSI5BBicH0XxPK9hKwMQd4QRovyUo/7V8lHzXJ
 Nij1IglcBK3j1ec1YoIkQFxb0lSUFPEonPJgORr3GEayBVmdgDTTWD447WYrJoDEskQx
 3dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tF2TWpDhS6JNHMclno4d/CgtX1qUDK1fcIW7BQ+2mZI=;
 fh=AIf4R2zr/Eyj6lcFd5QM8VKstKAvicEk7Tuuer0toFc=;
 b=U7TaJVuh7CNKPmwL8B7Awa/rbLVRprxiKxHtGzNTk/Oo1jAOIU1sDkfxQ6k13tc2KL
 mOI8LYrs2045qaLeLgBRiXydkRxghTJKKn/C/qghDUKcyoYr4I20/jjdcZ8I/66nUA5O
 2U209OcfqfScuIbEH0af4Jnm4maFKpCqwgPMwAyxUfw88idtA7dQQwrwRhwe+Wy3Lalk
 CmHn53UTgVeWJPbSkb/RfC43LK33bDDvkBlmYr/o2a4NMaQftQdZtYGKXQRih4x+HRxW
 rxkOhD6jb1KeUirbzFlObxXVLQFCSvFkFkoNAqNyuEPWH39yP3iQnapuohe/0F5rFuV9
 bRKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775417402; x=1776022202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF2TWpDhS6JNHMclno4d/CgtX1qUDK1fcIW7BQ+2mZI=;
 b=r70ohNCFLBX3cZn2Xd31cf99ifzrYVb/TWf7CS+NCAnzG7CXDLXFiARiWEpYy9Gcn1
 l0pGWynvgRpLehn+g220D6ZpBqLOWqx64rbloZSzpsV0W44a48+Kl5KB1FmbJ4jWgrc/
 6RQyM7mywnJmdusRPrXvt7kMXwC0xYjQFw+HxxzMFwSfpxeX0uFLxRd09lcOofM0P2dg
 LQoJV33xz3bfPrRoLo8HH9+/pVFT1pVtCe2OBpfObe/4fBhkG7PMgyrZERVJJ4DcJdSm
 rPQIkPf6+HMVhM1FinhOqSUOqjjgyux9j48vhCTOUOMbKy7LL4cLlCZTpF6qlloOMyHC
 HkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775417402; x=1776022202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tF2TWpDhS6JNHMclno4d/CgtX1qUDK1fcIW7BQ+2mZI=;
 b=DII6FnvlmYDUdvcNOY2apA0Rm3aQ8KlObgTdYE4TKypZ9vM7Nw6jrLDRknFkul+2RD
 XCwWjtWNC2ohTNCYTtJVxUcxN121ikP7ndT621zvMHv/IStmt0ASQt3m4rNS1F9UXiei
 m5bMMC+kZWnW9dHgX8vgKGPEnCGWZMFvtvYZkPRGG93TleD0SyZ7HrQV/mbJbZlmBg0P
 QFqSqMBysNTLu8qZGWgK8YZab+wdba1B76ViR+kIxwCTLgNnhKw113vgWvbcQ6HPz/5y
 NUU8gwpQhEdbZTFD1v8OO1fxMWiUSyPloeEsnDBwLq5vpadzBFU6uZQJwL54PKMsngTe
 ksjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmODW4FCXO6L7s7q6z9CWkf35WycWJMlqeKaRzbqtZgyYtHZq6d+k0u5Th3Af6iUvU21nY7KSl/Ys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw94DmCj1V5oYtW0Q99yEpU3N9SGvnrandqM2Lq1FWX6EWQSuKs
 7GhyWdcZxuiaFa314JoU+J9t/aYZivHpu09fXNSqLngzKZwBVERgbHfjAYyfnImCuJf75lYqAGo
 0VNquaGZHaNCYZaU2zMknuTRiLERXAsg=
X-Gm-Gg: AeBDieu/aTWo+7zXKMGJuf/4CIR2iVKf+cqzHEmwzs29lSCzfYxgjvk1WLgLM1rg/LI
 gjM2w3UQsvwFDrHDk3cGsJScKJ3BMOjnySzBZUqG9DEuMEYN7j8y2wgCZYnqk3Cjyb1n+XPhyDf
 r2LFK+iDK3ZeBha6eF3cZIB1sfFxC1fWDBGJpCLD2VTzaNRC3m9zyu3IXUtSPZogcKjCvtFMPrk
 SPleEbZrzVo8FaTdLrV2BOYUWI+OZ4yEh70pdq7+CcMTNuYd7oXURfbEaRJ0OuQlQN44Equwew6
 e8naPqTXJdEzjjxxNeuKbvHvdiaSIyowEu4ENsBXBmSKQUNuyZvsUI6uNV9qja3zY04UuxXbkjp
 rOXsQ3UsIhLbBq1hpQ+4qocU=
X-Received: by 2002:a05:7301:1688:b0:2c7:2cac:8149 with SMTP id
 5a478bee46e88-2cbfc95a78bmr1941319eec.7.1775417401965; Sun, 05 Apr 2026
 12:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-11-ojeda@kernel.org>
 <177508434443.73816.5437391869400189147.b4-review@b4>
In-Reply-To: <177508434443.73816.5437391869400189147.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:29:47 +0200
X-Gm-Features: AQROBzCJ9cjSza_PQiGX42eHlVtWqYPN6hP4vKeYF-tVAvlxpiXLyawV-TKZkT8
Message-ID: <CANiq72=EL4pEagthmrQ=DTNe8-5jWMfgxxx+fsj=pFy3EX0zdw@mail.gmail.com>
Subject: Re: [PATCH 10/33] rust: transmute: simplify code with Rust 1.80.0
 `split_at_*checked()`
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

On Thu, Apr 2, 2026 at 1:00=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> "beyond" is probably not the right word here?

I think you are right -- reworded.

Thanks!

Cheers,
Miguel
