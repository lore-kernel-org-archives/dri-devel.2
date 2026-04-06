Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4584DE9D827
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852CB10E1EE;
	Mon,  6 Apr 2026 00:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AdmX5x4b";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134B610E1EE
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 00:14:14 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2bd801b4078so366901eec.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 17:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775434453; cv=none;
 d=google.com; s=arc-20240605;
 b=P6TPA6+F5LeQZQfTZQ5A0Ij+TU3vp26f/ntxnXsNYcrSPXJ4/gkoc2Zvq6xEdmMwXi
 BTexLYX6i/Unjl5/GLbgkSQftYSDn5g1eWy6wF35uSd/mdCw4r1jWsmIq/uiaIx1nqAn
 raeSMXbZjVtauQXzD5JEIznRJDnNgFmgxudretKELIOYwrbIZuSkr+R+MSS7jrDcpZNS
 09eJZlADTA1BwoReJSNlEEo2qDqbNrDx0cJtvcsQRxz+j9m763zJlf3YjglM+Okk9KpO
 WG8OFVX1zgXIHjb4imtNBXFyab1l4VgwVqexyGsWmZi56uIEMdHcmbRA9D4LL8Yx1hse
 cmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wEpvz0SusfCyL05O+8XHZ5HBN7Vc6GU6ixNlE1n3otA=;
 fh=STP46E+j5RmEA9Tk3t6k0nRPLe2DxksgwUHnVBMFPIw=;
 b=XL0xvnysI3+zOiWzThoEEgQWaKyjNzTrZOEr90ni66gBzFJsm3VVyL1j6AHz2s+UCO
 jK0kKWxhqpr3R8SvhlKgyDWMiz4FSOXWrY2gCwE/J3FUsMA1aP5L+9us4S93qoZwr9di
 JpZTQqxwy6R3YWE3MFrNiRUkIe3nOPez/FgAn4Y/C+64wkrTuxY6WxCnQT+JOqi+V9re
 s+uHx9x1NRTyX3I/0aLHr9tVybI05LMVksfEbQPNUUARP+02iMSzCFV8usEqqoN/xAnZ
 4igIPk1RdCd5nW8I9pWd93RFl2thn8/kPAv9Egx5kllGwoDal60SZ7aLYCvpcvAOOyJV
 B0TA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775434453; x=1776039253; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEpvz0SusfCyL05O+8XHZ5HBN7Vc6GU6ixNlE1n3otA=;
 b=AdmX5x4btWyZVxK8W19FlyF/tBB0D0z/zadJ8Wr9yNUcrfF8WukMkxV5BeI0vjmZao
 iDEu46u5ngK+59Vuru5C1QGZoVEXnGjU7JrcVBSbiFej1iAoIufU+lbYx8o9Qm+16ic3
 8MYmC9H2oFkK/VMLocIAQzzx5VEbAtKPbvFlwOOfchgNxCpIqcHKdAQZQLyv533pZ9or
 5RYkq6HI2q3v78d6vMmBqTOZxuurPNmna+K7VmTWR6iL8rfBqg9Qks6we2tfDjCNk8AS
 k2CX9Nb6X7QXLuEZYJj223YANS6Ur3r9ujOjq65Q/MuEAEqm0ezSH2NQzHkIi03kE+E4
 CCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775434453; x=1776039253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wEpvz0SusfCyL05O+8XHZ5HBN7Vc6GU6ixNlE1n3otA=;
 b=IowaFCtteYQoAz2A01wPgwXUis+rHDYjGzMsCnmofaWzC7YN3NC2NLun9pgdXbjv9R
 pQyXDTjMastcwR4TByXh0l0TpJOCTrSvQHzuvRtUMD3KaHoM9bTJvy0m5/JdHBj7sgRq
 2KJczveQl4fyVMOXnR4RcLD5y4Loucnmg4xma82ra9NUxu9UBBXWU9giRkKYZURQ48SQ
 sdZS6gEem70GcxvI9xkvIM94hJHcNqY8DkwCzY1UIaRWjPDtSJyCLtqUCyPejgtYrrLY
 uQWeHfvHyRhLauGvhXsomuLvgIjuyJoPSdHL2iabAuIV1bDmpKRYebtl3uPAj4XWGkpx
 swUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgc0k3lcmdnBkd6c+DFJWxQxaHh8JvWjAyeyoU9nsJEDbFt8K1zluHdwG0C0UavkmEPih6I8sa9Jc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKVum1xWt+n4CHGPY13m7IDHKS9+l2sQSpHGXhfZxUFsNbEKdX
 wX4pw2UYR+Svu7h5HieC2y7hSNKq9CeGOQTqVXGt3Zpy0lUitFnAUAnb2GY1g3snbE+NNhkHGt/
 gG7+st+h9IJ9X+0+ry6LFMhATEM65teM=
X-Gm-Gg: AeBDietDSILsRdbJn5l8JbHBVeEWvpSfqT5Q//EhvN6UBj8JlazD73xWEwkw1qRefQj
 NDcVTSg49nP9PBCA7/I0QNMaEml4bLAGWKLfRomeLUG7AbPoGw56LDZuDdosEoupLIlvB/J3fqa
 OSI55kkV/f7tOOj+CeauKLiv3x3vb60U5h3vKsAXDjtYG+/TfkXIaZsjeyIpvGWavuSveW6IeN6
 h4cCEnCUA8uYEfPth4rqGllnUopn0D5JFD+1vAE20eaMRHNrwbFenaolmhP8B7M4SznwxhdOzGO
 XgsiHkIhfwkVLp4rsHfF17ZCYhhwNMKULkVoIQ6+ektOoEUhrrLXHObkCL6aFWffWodw4SJBeeL
 fquE+FTeQEzxjplXGiYqhSXY=
X-Received: by 2002:a05:7301:6784:b0:2c4:acef:291a with SMTP id
 5a478bee46e88-2cbfbc7dc06mr2181016eec.4.1775434453241; Sun, 05 Apr 2026
 17:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-24-ojeda@kernel.org>
 <177508434465.73816.4492182082440539007.b4-review@b4>
 <CANiq72nqenC30r7QQAmdKxS8ehGU2SoSGr+LCnoTAGLegH-KnA@mail.gmail.com>
 <DHLMTLCY6U4N.3VOMQXRIT1RFY@garyguo.net>
In-Reply-To: <DHLMTLCY6U4N.3VOMQXRIT1RFY@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 02:14:00 +0200
X-Gm-Features: AQROBzC0xKqhkvjW35MYEt1fkyhl47XKSCgdBG6b_PFaPBKsGPkzdO2Dex1iVhA
Message-ID: <CANiq72nPjz4FiYUDDV5Xw1=ychH0DrhVN88hjygBnawLf7oamw@mail.gmail.com>
Subject: Re: [PATCH 23/33] docs: rust: quick-start: update Ubuntu versioned
 packages
To: Gary Guo <gary@garyguo.net>, Fiona Behrens <me@kloenk.dev>
Cc: Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, 
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

On Mon, Apr 6, 2026 at 2:06=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> It's still required.

Thanks for confirming!

> Perhaps having a repo in rust-for-linux GitHub org (or somewhere else in
> kernel.org SCM) where we can point people to?

...and for all these details :)

I agree that it doesn't fit perfectly within the kernel, but an update
every kernel cycle or so should be fine, I think, if you think that is
enough.

Otherwise, regarding the repository, that sounds great to me -- we
already had an old https://github.com/Rust-for-Linux/nix and
https://github.com/Rust-for-Linux/nixpkgs. Not sure if Fiona (Cc'd)
wants them, but perhaps you could reuse them (otherwise we should
archive them).

Cheers,
Miguel
