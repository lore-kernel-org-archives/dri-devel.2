Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85972CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D84310E641;
	Thu, 11 Jun 2026 05:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cgsRfb99";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621FC10E641
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:09:50 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304cf9a02f9so444272eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781154589; cv=none;
 d=google.com; s=arc-20240605;
 b=eC1LJKLtnu/HHWhQZTacBxwcqqpCqhMKcxOnXW04SFTscCKaDJjrpiaPlscVQ+JJdc
 6FQOmTAVsWT+MRV+Kevl6GlEafowbIBOx55jO31tT9DJ4ohDbGRupE0bO17oxdcmUXvz
 GGXyk/joRG/r1JX1lxmqQN7HNlfmcVyK7tnRmTT/XLxykWbZIudwSo1DH2o5SFXZvbR8
 ipShXMmF/tZG+YS11H5v/oL5TlMp7CKRq1qyNUf6qOb6ZS5K90d+zXIN3DfAhWtCmFfC
 fWfUKAkTUbrNeWS3ze0TtyHFcuhzRgFHrpdzOkEE1tR+8oX2Ta3/nmZC+D2TcB/9j7jW
 mF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lyFerlgaYrMaDYJQQ4DjXG7o7AcnUs9BuBitZg+XRxc=;
 fh=XHUN00DOWefu8btF/U3khlR5nPOJRbSsgjrUw44DGPc=;
 b=QcmgN3Iq0pxkr1xZmJopDP7Y9X14yaPyoNzD7RRl6Ib1HDb1bNcpHkJ2o2HRUJXdiw
 fMul1yvy0hXUSHNeBuzLHYxT6cDb053XuDIzPE/WlRILkC59lTsu9Sh0Z9aUosnoN+tr
 9g8l2APo9YzLhb0gZFXH39T/9wUkSebxeCNwA4dsEsCIqqoyWT1cG/J4YjDzD89NRs7X
 SPg96/7Kv8uQ+btNSttWH4dT6S69q9+NchHqJlTef905SuPsc2SZ5WTCwSWBAldZZls5
 dWrr+pMXddhzxXOMqRRmE7UD8E/QFqkt4cnoEmp6gHQ/XvhJ5pFn+jUhsSiFsFqW+I1b
 fzxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781154589; x=1781759389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyFerlgaYrMaDYJQQ4DjXG7o7AcnUs9BuBitZg+XRxc=;
 b=cgsRfb99myTtuAGBy5rJunNYkBjIbJ2owyye0EDbFlEL93DylQvRER5P2f5dBoQfYu
 OaKZKQsdTpsqo562xwv7i13anixumxo0uLmrH2IEtzm1j62WYMvqdRTXEwBFEFrptMjV
 FMSZEI02IvOjHPZ3nJuo0QXjWwNZPWbpRtKXJTPO5SoQRGEF2k3Qo1JIvILwIOIBsJFu
 lTOWeM5QVZM1EfZTRukwfTSZQuqv7XIxVbYYOkj9mvJCWAJUhR359KpW7gYRvpEKcxcM
 Ey2K2Iwf+IlYdRF8SFyCLW6xRAaqkzkIDjm7yt3e33a1fb2zQowtisBQzblLBN2OSd+u
 yMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781154589; x=1781759389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lyFerlgaYrMaDYJQQ4DjXG7o7AcnUs9BuBitZg+XRxc=;
 b=SfE1G8aDOXKUORAdfR1DpxpNrsEQkWN8D0GSsdeCcMlfl7HWGz/B45H47cw18o++jA
 WuqqyZqT474uPi3O/4JmavAHwplY48guUbeNH8fF0MzqxNOSrbmKkFPxwkWaa9hukICk
 ERvbApQYsMWvYmhuzkLIai05ckevR5OLYnSIQu32GP7UZr6wr4OsFLW2m7fIGBwikEps
 XZnL7VrxKILZfX4G8+PzSvtgi6IdzUIZrtKtUZGP2yV67fNGjMm5mUCHfuUy/qHkDFAS
 uTC2v2OQlipaAmmhdLqFWB9nS/4GI3QeYoVNsiBSuhllq7ZN4st6eCo+7cAim8BRM731
 FGSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ88nHfr7Xudflt8t/9DMPyEui2SasOQMMDu3iXryaRQXZ8EQ7m3f9e8vUlIMuJf2fo2A2Q0uCF5AUg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3QPTSkHFrYDIU5zAiFb8qVyJHxLVYx7nluLCE+mQbxYUxVqiZ
 XBKIbiJjfnSduJ+V3lA1//A+ClYsWfj/xfE6RbWxJwWB4LhuepcllGXPc3viO0EtHIq9FXvWaT6
 /OvdQHNsy8NqlLGMBuhzc5xDpywUfyf4=
X-Gm-Gg: Acq92OFfrxkew8DD/iS3wuEd4YxQgkCUP56+oA+A7xEogMyzB3AFVN6LHRM7D/N71VJ
 yadXcZp4wwdEZvpUxHsJ63mYrUasL28N06viE+8HFNfisv+ZvW4wfnk+8kR5zWGHvQMMmVRkT99
 uNoMwewwHpn1bW0+OnAhNdJG3TnjLh1S6XIh9r32jE+vUfBTy1Qg66yyXho8H5oJDqZ/nOQ+DYW
 vuKQPg/fd1OPMk3AzhPPGjyL6nmc/clgU4y9jtheAjzjVb4y0yf4cDQpbL4sZg7dxX9fKYFNpND
 hlNSklPO24NnDuosASUh3J7XxflFIt5B+VIzyh2wiAxt245/F+Ngl1blzCWrhmAK6FLCcI41BcW
 2Fb6owh7ZA02kt2f9bPyVeCBKLx9furtrggc4o2RVbsS/
X-Received: by 2002:a05:7300:aca2:b0:304:d700:1e90 with SMTP id
 5a478bee46e88-30804a5f5e2mr536231eec.3.1781154589390; Wed, 10 Jun 2026
 22:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
 <20260608-io_projection-v3-19-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-19-c5cde13a5ec4@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Jun 2026 07:09:36 +0200
X-Gm-Features: AVVi8Cf920yVhFg_hQqFb2LNc7XWN7dI5ldNW7tmfqMVwtmKAogJd1U0zilXmbw
Message-ID: <CANiq72nLZPG_Cnf+R5B4CoxzbLpOWy39A+hiVtetDD7zT6MgRQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] rust: io: implement `Io` for `Either`
To: Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Mon, Jun 8, 2026 at 9:59=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +/// General purpose sum type with two cases.
> +#[derive(Clone, Copy)]
> +pub enum Either<L, R> {
> +    /// A value of type `L`.
> +    Left(L),
> +    /// A value of type `R`.
> +    Right(R),
> +}

[ A summary of what I mentioned in the call yesterday so that others
can see it too. ]

We had `Either` in the past and we ended up removing it in commit
28753212e0f9 ("rust: types: remove `Either<L, R>`"):

    This enum is not used. Additionally, using it would result in poor
    ergonomics, because in order to do any operation on a value it has to b=
e
    matched first. Our version of `Either` also doesn't provide any helper
    methods making it even more difficult to use.

    The alternative of creating a custom enum for the concrete use-case als=
o
    is much better for ergonomics. As one can provide functions on the type
    directly and users don't need to match the value manually.

We also wanted to try to get developers to provide more concrete
enums/names for their use cases, instead of using `Either` whenever
they may have two symmetrical values.

Anyway, if we want to re-introduce it, we should likely add what we
had when we removed it (possibly just reverting the commit), which
included examples etc.; and probably add in its docs some guidance on
when (and when not) to use it.

Cc Benno.

Cheers,
Miguel
