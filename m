Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32534C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 12:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F5410E1A2;
	Sun,  5 Jul 2026 12:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="elHdHxeq";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41C410E1A2
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 12:22:36 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-380a02c71e2so761417a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 05:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783254156; cv=none;
 d=google.com; s=arc-20260327;
 b=gkl0lWMIoRFXhxjtTbqcNrcz52CTPlCkeZZatk7xlt9qx00LNCOEH75UsMhtX7OhVq
 nANZmpVzfnwUq9Kw1oREckGuF1fr4oMwaDBCv8hgCvK5WNyZxBghyyZGrqHvlfsVeP+A
 p9UovdLBUqDkBloQHbGXPcpY7TdrL1D1YyLNTZqCqbpBZ6Ox43jXKW+YDBizZFCOV3lm
 yhzbfzANmB7YcAzJBM/SA8kxlbtnsCk0uqrRIQ89Mp46RCo697VsjWHVMz6BvYRIU5Yr
 CMeQfd/ha9KcG+oXoDJ7WS2Pu+Pi4g8tZJ8+wDTKroTsjQtCRvBeg2boE2UBxWy5bHkb
 73rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
 fh=g2Wd/XsNkuwMavYQknIPC0gOnaH1srUkKW4NNvPnoHk=;
 b=l97Lq8P9hXiI9TjsEurSIRHEMXXw/0wHW0ffLxJ67ef+4iuiKkyvbZ1GsOK/tXFYUv
 J+dwsoYh5CCu4bj60LLBSpYVOKsXjbPv31PC+TavxbFmOXWl/+YxmeAO1Lch0ae/jEj1
 KGvEJNqnnmeJhqPiB098xwXnfFi7i/wp6Dk2LOZ2VWzqXoQdqnRHhvPvIPiCGFMn2owu
 ztqsU6rAaWpnH4HI16TZGbpCiTCHkwCHp8HspNjQGLXP1vizbAxSTA6zsQgsZLb2E9aC
 P8pDdOseRsNEgb0IB6P++6lTIp2aAJ2BLEhbPvGu260UKaNKtsVPxXiP+3nibgejwqMz
 Bgog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783254156; x=1783858956; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
 b=elHdHxeqo3p4hhfzKXgYbC/l9H1IjKdLuVNv8ienhv99nyLBBtxLH7M7J3JYvSq+bm
 G06dl89dHolaCCR2hUssGVlsGV0SAW5mFV4G7EiiUemsNqRRvxAkYTzyia+a+mkdpp/e
 K21uPdZd/00OzueI0SVn9KN4q23mnCAe3ACJcxBAWLvLC3Vgykh52sdIQThV5hx8FI+l
 97XBN4NRiMu6RgjIiMiHgRV+hv6lvJsRAyTMpvkc+1WDz1bYElJ6hq8C7idxFJlN4v8c
 nYrNfXLCqnYno8OYOrp2hJQTtgkOkFGoXX6amgSLjEQOc7iVjBy2/jJdUFk1R051ic0d
 rrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783254156; x=1783858956;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
 b=TUXdjZLTJ252Ui/gW5sQ96yTLp9m8H2HdT8UnjrVl9aLXLBgnYf0vhRq9TrreMk32m
 JJeCNQBNJHjR6PZRmqRtLYHAIjBHwtyHtZqOodmA7MUv7KQMz1u9s7I/t8wimwJYXB9e
 VgUmtgXNY33OjBz24TVRLG2yBBllt4DC48escqpny+s7+NpqxvY7tzgydwF2DhqjkvmX
 LJCzMq33I46SsrlarOUYpCw/SRUxrW59IJUDdwiYQuZF9A7vIlpu2KwxyQMufk8+Gmt+
 i4eAeLcNjZhhxLnSDi7cw82iHP7EyXvt12E8zMdSUcNBz+G3Frac/RQgimnW755Z3o99
 jgVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzbJii+JHQUyZezQsL62pSxVHSrJr0f72yneDd/Ie95DlrDlEGbx8cYdtDaGZv2VLjIOS4vbvAQVc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxY/Mvaf6x4WNORfuunitWPq3hrgI14OLVv67evmS3NMVlrLWhM
 g+k3feJLdmDS7hNGZrYuJj57bF2qj4ViSiyAPat+WfNiLUveqdqSpUji/Wbqd52d8AMfMbDI/Mx
 Sv9xH/UY+QWpuMG3kC/+5cBf2VHL5BM4=
X-Gm-Gg: AfdE7cngFFPZX+mlDpeAainapr76L1GWXCrQ6cYNMaE+62PMj3R9649ERTY+c+4svjq
 q4iNfltcelOEt++WlDit4/NsZDESGc39TeX4s+BHeAhjtaZzLBMraNTCHmBfsOBX2EXz0FwC0kl
 UxM9fpuPW707ziNWGWDE8giddZgx/8XtIFf2Hr17NYLWA6gAj1Qho6DwOg7PrRGXJzAzK5tqq+m
 868FrPAX4KhmSzJPYYGkF7Kjet21UqIHQ+dhGq5jVkE8WY5AgbeGFeAlaWVzRhVxZ07Sb8NPEpv
 YAg65XkTxxC6sysg+DaCiXMrbZLnJC1UBxSyo6BwQBmzfxMYaV1U51pGpcfDmBn+fCddBHiCSd/
 4VrLS0nt7q6JQ
X-Received: by 2002:a17:90a:a416:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3835a16bddcmr2702118a91.4.1783254156186; Sun, 05 Jul 2026
 05:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch> <akmnh0AKFfu9-OYn@gurudas.dev>
In-Reply-To: <akmnh0AKFfu9-OYn@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:22:20 +0200
X-Gm-Features: AVVi8CdKZk1uQg3RyoO9gWWnGdg1D5rtqZ5BcTTqS2w4TtsLqn1TqMImL9QufHY
Message-ID: <CANiq72k0zokLC_L2wPJRDb_CyvnJznOSKUgTaiHo87GT6Pwyag@mail.gmail.com>
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various
 drivers
To: Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
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

On Sun, Jul 5, 2026 at 2:38=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> Miguel, could you please indicate if you have a preference here?

Gary is right -- it depends.

Generally speaking, it is best to do changes through each tree;
especially so if it is the kind of thing that may be prone to
conflicts.

In certain cases, yes, I may take treewide changes, with Acked-by's
from maintainers (and very exceptionally I have done it without that
if e.g. it is trivial enough and enough time has passed -- trusting
that people trust me to do so).

It is part of why the Rust tree exists, i.e. as a fallback and also
for convenience in certain cases.

I hope that clarifies.

Cheers,
Miguel
