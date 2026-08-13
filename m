Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F09DC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5F410F28B;
	Thu, 13 Aug 2026 10:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FebEXiLh";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108AA10F28B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:04:18 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cf49dc28ccso3653995ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 03:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786615457; cv=none;
 d=google.com; s=arc-20260327;
 b=KRl2unx4oEqe1L1J0DTp/NDMemIaKa0/Cv7+MGP40fxHIS41YODzXe31IC9nb4Sj0h
 Vb+a3gakpG0VC6lEF6jCAhYZat43gXPAmUL8w+fgf+Q/9dOYgns7Tu/WCkycGxo32XuX
 DHreLLizMMl5kfz8yclwYlVFiigH4e4V4aCWTJ1Pxho6rvZ2G+pqTrMc9+TH3xeLE94X
 7/CLWFrMogxDFjvyYEcFZJ8txjB3OGudhlY2m94lRlCT373TqwxF7N55n5oBYPcGUeeY
 ENIDLgr9kbCGmw1K78Ru0U50qTlH6O7QTZRnls9mAZp2TxAXLmlAgoBUrGkXryX8WLxg
 oxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
 fh=fz2RsUL5urfMbCH4GweWVJREngFC1XN+p6p20PT8Oyc=;
 b=C6Jk6HAKhKrBYAdnrui0q1IG/enH2TeL2R2wU4Yjx166cXIIklaiGLXMUG45mKrZRV
 WIYQ+Bmso9tIzlJKdFmzH44HCoHExImJq0vYsSllEd5DLulEPKvC8rgYZnA9KjmZu+Ii
 MWf1bAAbJ39Zvux1NNtHYRUB8VQyjZyv5FOoHq1VAaJBqCka3IjHB8cRVwaFqQACLYD3
 dL5f++AW9MPx35K9kcqjDhVkE8Cv55dgAZu93URRxc3hW5J+cwqmxCoMKnKAum3Zcu/D
 u3BX07IJ2X9+aaUs1eRdR6PQ3aIZlOkhW2FwiynoR1DuxFyV3o7Cv9jCtRmLuv92macK
 sunQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786615457; x=1787220257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
 b=FebEXiLhj9x8aVaH3Fd9SXbL37Ad3VFaqLqOnx9xFH64A4r3oonpw9t3NuReCovWkh
 l7BIui6Ic8+EqZRdgHPHL56yhrx2VxLDFE0jCqr1ozmQR9SXKLs8bIJdxrWmBAFktc9c
 E+AqxowlXU7bkyelmAjGSfTZnqZi21Bgz6mZluQn4xCnMUqT4d+pPoo3Gi+j29pGEWCz
 cKSo8vgUy++zim9Fh0WAS2SWnl25MKR9RN/BYdb3ESCb6QAQ/k7iXpydao91NbLq+AgP
 dNNZvDPuqABryxD0TtongIQkf9Dq1d8U9It0DeeJGjpktakhoTYH2Hb4Bz1Lh03k6SIk
 mzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786615457; x=1787220257;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
 b=ghxWmoK6Mqb62PI+/DMji+13tu98mBS5r4R8Xq8R+GGTQlC8D58kUKuUy4uscA0aJh
 RS9quGoDwFEvHAvjrRdQyLbPWJhkAjPephL6P4QkRvDCMaNmc8Ku0/qJ487fKi7F9v/K
 aleFERj5mqSfmyIZadylUqs0NmolHpmohMQvRG/pWYn8s6vje15p/RV1Nuh5BKk6A9kW
 TTImiCPbu1CSpyOYFmRT9Ytg6YNtmo24vdlo1gWEUyZnuIbCL1+7my4sFvZvu2TCfpgi
 vYfPm8N1IVM0zKDUuCtfdgXqyyXlvjZX1qmEpRrmukOQeYP+cBdo9qTTtC50tQVwjJfs
 Qz8w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0r3t7MwghWp+P0d17/Xgl4K2fR6FQTix2RPpPBa3UYd5u2JbwEafr3wRaj73jzujR8SVSsz45Jv4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFLWby2OnckcH0pSZdISKt8ucpEB8uTKMrHYUSyAXpvatT/1yj
 YNRd3AfrHAbalWDF4qa0gzRXn/95n6dOpVsxFkpXOF9NTDTOQ0QCNZ3fraly+ltQGqWhqYjYQ8A
 VywYPxNFSS2cQrw5D0ZZszRQpXlDGvE8=
X-Gm-Gg: AR+sD10TaC1g0MtDOoVdtB0GIxRQd76jhBo0FsltjyUZgvHkyHeePIqC+mMD+K4OA8g
 xfmbBaWCntoU3e+frm+AHiLxTIb+qQB4oBv2DD7oUJLV7L2Of9KjDow6IVfuvIo/nReAtO5TuwD
 M5DnvspKEQhQ0uKErZY5cA25s874BYl96tv9eEYS+GN8zqd+o/8BSclF//UtmWvEeMbZKEo6oMM
 0IuLvTnPsFGfD5JqhI5f+Pp0bts39MGhWS0evyAAUkH9hcSDGGnMAhVwpVSyouQmYwXONv/W0E7
 VjmnkTpnxmGmcs/ZSuNIEr7+ZIjsZOHQxS836QiVlSFRUTfC6BAKxwyCX+hq+ZGQ9w+Ydzb9pW+
 l2w5qcbXF72KvJylyjZ+EUY6r/lsCh1+jva+/Wm1PSbP6IEeb7xlbpU3qK+AK
X-Received: by 2002:a17:903:19e6:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d389b61bdemr35547795ad.3.1786615457444; Thu, 13 Aug 2026
 03:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
 <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
In-Reply-To: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 12:04:04 +0200
X-Gm-Features: AUfX_mxe0Lg9da-FioFXEgvJltaWUVJqtXi0b-R5y4sq5pbip1KqobICrYsDddk
Message-ID: <CANiq72=Whd+u0cA88++KyeOQQrsBK+NqK-586jNX7L=_Ocixrw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
 Alvin Sun <alvin.sun@linux.dev>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Thu, Aug 13, 2026 at 11:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Ok, done -- Danilo, I took your diff and converted it into a proper
> commit, please double-check you are OK with the Signed-off-by:
>
>   ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
> `#[vtable]` `impl`s")

We also need an `allow(dead_code)` until we actually use it
unconditionally: a2595ed13816 instead.

Cheers,
Miguel
