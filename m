Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5C6C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 12:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E619410E1AB;
	Sun,  5 Jul 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6kQvGak";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACE110E1AB
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 12:13:00 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cc7e132d3eso1407335ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 05:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783253579; cv=none;
 d=google.com; s=arc-20260327;
 b=KP/zeCUCZI8E1zCAO9FvjZ3sstjbQTbIZFhSaYcWugzKXl3J5fbPkFQUkij0LBJxof
 GmwnsZ/x30HKQddJmxAP0bA40dCkAi8LyOWXp9AylEP580rO/L8EqLIJjfnhDeKgJ5uK
 Td6/9h9FSpmE3ZRnulzC97u0KZeOhQOlxTgIgBsYeOt+89g2TnKcoqrk1G1McKxBPyR6
 1yFJmvb3+kYBBvatYLQF5AQ7zQkygSpsx1GvLIL2ZYgTejcH/nBw5vq+YKMN4BY9/X2R
 K7BUkCMGx7L/Bud8B0b+67G5pJHXHcUm3MWCvrQ4I/g0LllduDO3nVERubeqQMcj7QJW
 nrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
 fh=7A++hxupKH+sKI4LkbwiRZYztRPKoHjt9ZMbzyfycRo=;
 b=nVfsn1J5C7yC09TaNhcNs4GWQBjHfASjmALAO6y8YUXg6beQlg8OgPQenEg/iEB4tE
 5RuXY1ZYZHcnye9u1HLH077WG1gd7BP2RzpLJqTatSoXAQdS0qnVH4PfpTL2/VjDnD09
 vmC9FwfR8veAlrsee0DoWx1gFXjtyxtRWM6SFIulmLaujwwBKUv3sY1xYdmnLY8aWLzz
 DnPUFNqtDlKdXHLGBWpXKZu3bJOq60SE/swx+1LXtzwWo1aE9JyazU2SCgwxbjIraVUZ
 HGQo0DgaYLIQf5Cksn6C5sN1T85hSNquHxWuQCZfZUl1y5gVpuAOWQFRXYytv/PHnKFT
 EoDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783253579; x=1783858379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
 b=C6kQvGak42H97JI3p5PHjaN0mx8qRjyjxm0kINUUV+fgqS6LWAMXlw92zgYbCunjYG
 pdu1Zxpw5VsoYyYVP+9u/3HkUUf6NYDVD8vR794/CaT0o3GBgjCnaHHYl5nXAfTo5Awx
 gBcMoQmOHiEoycvQoEYf6nhc8+oJXs7+DZLjysI1obmloO5vxJTbyGmECV8IetKDIXDA
 nvaYEc2QTxHtIq7C8NmUyMCDD6cnM6yPa5KVTEzAzsieGxA9522HzFW34U0Jo/HtS3ml
 zJTIsAVCPNgV5Q62ALIYBQRhKfhZ3aitHKmCkGPQK0mBwBLOYWXqKa+2AqY9YSVDgyFC
 EFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783253579; x=1783858379;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
 b=TVSzxAV5KHq9d1GpM0cYR8dd/yEivwDepjBtcO+vNDmQRns2xCIQR3I45J7OA1eoAw
 rrDpYVQFEn8QZ7T8m5jmfzA1KAJYZwHLd1e0ZxmaZglPKnAERFEH3FopjwNutuwnc6Bd
 DZGgzjU9vcCfSgwQXpUzgMZ33fCuyaD1Crh+mLlh6dWADhlo93Yop/tVMrv+SpQPqNja
 mnx3PsbzcJ/PtzKAQvhlOHVF8QyNCqv1UPdsXRApor57HkFCCXzTS2FZZWvzcowBOG/T
 2lpK8Dx0VhN31xsusm9y2Xh+6hpXa9ORpAZpYYfpjtyzu4BdoJom7Pll+ON0bv2lLAyG
 3IbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPbIXLwLwoKqn/CVxhUIn5LF4AszTTUFWI30vHAm2WFi6ApVRgwk1RypiysPFFIZTgMMN2uDv1lOs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywz8wsnhUUDyydVJjM0DIrxwLEiwB+F++Ka5F8iOQQqryoIYa6q
 nFHXNOnQzg0E4C7q0fPrSNYg8mcKAKE5QBWJCTBGZ3SE5rhEclzDIh1fmvF/Wo3udJ+ygZ3MF2v
 qSQH5kw50zTqrEiPffI9Y2ASAuzxRJn0=
X-Gm-Gg: AfdE7cmjigTBZpVBK4bvBSLqClikTc9I6rG80jY4ZotQxjYJqVOLKcfq6F73u2ZTZfP
 KlIc2XtuUMb8wppxGLnj1UNngSEARg7FHHcvYxe6VbW40EVCMxhjW7ifchxlt446MPIFFEEOTro
 VvLGw4HTIebpBlkRpfeN2cem6qFzxq16e74yB42PS5e5G99Q8tuowPaSUHTXlezpuU4f1Xgp6qm
 xYgZWpK9h7erJGkindj9uNLENl0P4Faxjldc1lvZC6fPQ5kpdXwNXaSoB+mRblYilkT/2cdtazK
 8RaFuicCBZjSENv0LXxlGwNlEF543mil3OUo9WuYzwQ8vaIyWaB3EsIwJgI26CEtvOJlGur5hQu
 hCpyEi6wdOVf9
X-Received: by 2002:a17:90b:268f:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-382802beaa9mr4128789a91.1.1783253579563; Sun, 05 Jul 2026
 05:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
 <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
 <akmtA7EbVBdhRAOq@gurudas.dev>
In-Reply-To: <akmtA7EbVBdhRAOq@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:12:47 +0200
X-Gm-Features: AVVi8Cfl7DMeNQYuJP9tYThrU-TabLAul_khYoWVx5WCyAQG55ujZm7jKpKar4U
Message-ID: <CANiq72nESZyX95XSKC3zaog=XSQF09bYJmre0mUbtQ42-Ly6tA@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Miguel Ojeda <ojeda@kernel.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
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
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, 
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

On Sun, Jul 5, 2026 at 3:02=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> But unfortunately, since `imports_layout` is an unstable option currently=
 [1], it
> cannot be used straightaway.

Yeah, we are trying to get that one stabilized -- upstream `rustfmt`
is aware and working on it. More context at:

  https://github.com/rust-lang/rustfmt/issues/6829
  https://github.com/Rust-for-Linux/linux/issues/398

> However, .rustfmt.toml already has a section of commented-out unstable op=
tions kept
> as a reference for when they stabilize. Would it make sense to add `#impo=
rts_layout =3D
> "Vertical"` there? If so, I can include it in v2.

That may be a bit confusing, because we still need to add the `//`
comments. And if you add them, then `rustfmt` will format properly,
i.e. you don't need the unstable option.

Put another way: the intended workflow is to add the `//` and then to
run `make ... rustfmt`.

I hope that clarifies!

Cheers,
Miguel
