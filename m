Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE20CD8C8B
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4AA112D63;
	Sat,  6 Jun 2026 07:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O5sDAOeR";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA1F10E4D6
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:02:59 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-963ebce7076so455385241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780675378; x=1781280178; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMM8rItwjOBKBZTiVFQDKLbinjfJL7SeunmDuhS3L9o=;
 b=O5sDAOeRvb5JdZUmdugayfdDvh6W14YYRxAJJ44RBhtQx3kLmGw14gXLronXHoQ5Vl
 6E8ssWWwuhowBGnoQCpxMDLKxlHfI+aMdFMcDFu5F7jzTru+5p6WiKqzdMzOU/9YRWZ7
 JZHAIPoadZLJ+zVUuXZvQ70s01by4aAcBhbV1IkyDyYeXUnAF5Xin7Vyh99yyrsEPiET
 z2oi7HEB0oK88PkvphkiUNICkS75r+ZKy/H3U5VOZ+86husNiKP2J/0Ci8JGMvevv4uz
 8ICVG7RFIxtwtjCOpIg6fswvthXAYbnkwZbxH50HZx+licIPx2SAkC+fq70Fgf7b1KRd
 q3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780675378; x=1781280178;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GMM8rItwjOBKBZTiVFQDKLbinjfJL7SeunmDuhS3L9o=;
 b=BgzTliSVmAh2r6s0azBfiJMrFKmTIU5PIOWso7GOeHM1ZSUX9SjL6uwz5tbRVSLqWn
 TQvNaHFK5chRolZnfabSDhzl38fLfI7B0PUBd1XrvRtl1EA6ExMKeHDZMoGNDAnocTmo
 8m3ejKoKZYR8MRc7ie45FGuNFMLqZWa0Y/8arARrZt4YBps75akixv/qzK0QLBRHx4rn
 TpMM4ZqQb+nFio8jzKhKbHetBO2Y4xOJqDt9+EQjSovd6fAoOYRyLYnYgBJdj/WFhtDV
 tEFHfHL1Ny33YHrPWUQ6CMmYq80NHjFW2zg40B6O7km4ciYYYKLDmDPuEuLfxXUIfWGA
 3+CQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cOSbM1Rj19/Vz0qzSX2wVGO5xayG3QqAOWcn/MFxknd8YsIewxJUNSvM85ZlRXW7PFwyN1Oe2PNc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxhu04Zyr/8prk7E77cF+DQz1PfoyvbT3urXhTH7MxCZnySnHPk
 Uc5YEKDqOG3Ffk2S81EEa27KhqkRaRn4QgjiY6L42HhWWm+KFALsmiLr
X-Gm-Gg: Acq92OGOxNweZZJCgd9/EF7zB2AoIJx5F1ppqv/0jonVIlcTGnBRuZd7HaYzpnJcHQB
 BiBQB6vZ71YSyyXOGQ+5M97xynyXEVuUh1H3aT4B1aNT10l6msuOoHrhEy9n5tsDUwVpR85g5/Q
 7WuXnZYVEUvY5qgUK1P0Jg/02ayNVj73mchVRXRufDqBhfuQPOimA6Vk0LYpHwLCoc4s1uDUivN
 ojIfQsEdxP7Gm+hp0sL7hZYHs6lOKlLagnbC3ETs6ALNNq9CWAJ6F5qqPOzFeHGbEbTp4faOUD2
 kIzM868Uadtrs6U1Q1QAoDlvEHAuK9DUrPUZVd9126XqCbj+ummrgdrF8jrHx19gE1vOCCeVzTc
 4D0VSlORv1c2S5syNgLWzG3Z6GodLACyitVnOrM+/WpmI/Iux97yydMEtU9AwzeYhdrhVg/iIX1
 PJsFH55lf5jZVXP539iusJWMdufAwE1LPqmaUy6WvpeEcNQ9WTSAPNuxRQQdSbhKeJNjj9x0Zx
X-Received: by 2002:a05:6122:3d45:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5ac4f952082mr2315135e0c.7.1780675378285; 
 Fri, 05 Jun 2026 09:02:58 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f1:c241:abe4:8c1d:3d1b:d7cb:e7e9])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96413f9afe7sm6908115241.6.2026.06.05.09.02.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jun 2026 09:02:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <FEFE0522-FD7A-40DE-8B2A-09FE2F33F327@gmail.com>
Date: Fri, 5 Jun 2026 13:02:36 -0300
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <48CE71C8-7A67-4D09-84C2-A0B83C32B169@gmail.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
 <20260603191405.4c75badb@fedora-2.home>
 <09096455-BA79-4E61-AD88-44DA57C5BEA8@gmail.com>
 <20260604101552.4232733b@fedora-2.home>
 <8ff2de94a50ed077a4cfe520a081f2b8b438a375.camel@mailbox.org>
 <FEFE0522-FD7A-40DE-8B2A-09FE2F33F327@gmail.com>
To: phasta@kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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


>>=20
>>>=20
>>> So, by passing self by value to the ::callback(), you're basically
>>> telling users "hey, BTW, don't forget to defer the drop to some
>>> workqueue if you think it's not atomic-safe". And how can users know
>>> that the thing they're about to drop can be dropped in atomic =
context?
>>> They basically have to audit the ::drop() of all the resources they
>>> embed in their type implementing FenceCb. Not only that, but they =
also
>>> have to design the thing so the deferral of this ::drop() doesn't
>>> allocate, because, obviously, allocating in atomic context is
>>> tricky/fallible. AFAIK, none of this can be spot at compile-time (I
>>> remember Gary/Danilo mentioning that we could teach the klint about
>>> some of these rules). This would leave us with runtime checks like
>>> might_sleep(), but most of the C putters (xxx_put(object)) don't =
have
>>> might_sleep() in the path where the decref doesn't lead to a =
refcnt=3D0
>>> situation.
>>>=20
>>> TLDR; Call this PTSD if you want, but this is the sort of bugs I
>>> struggled with on the C side, and I can predict that the exact same
>>> will happen in rust drivers if we expose the FenceCb as it is =
designed
>>> here and we don't have a way to check the soundness of the FenceCb
>>> implementations at compile time.
>>=20
>> My guess would be that the existence of unsafe-traits is the =
admission
>> of Rust that this just cannot be guaranteed by design.
>>=20
>> If a driver cannot know whether this or that is safe to drop, then it
>> would have to defer it's dropping. Or would there be cases where this
>> also doesn't work?
>=20
>=20
> Although I totally understand where Boris is coming from here, and I =
agree with
> him, the reality is that the current &mut self design doesn=E2=80=99t =
solve this. An
> unsafe trait could work as a pinky-promise by drivers, which is =
half-way there.
>=20
> What we ideally would like to have is a bound though, something like:
>=20
> T: !Drop
>=20
> If I recall correctly there were people working to get support for =
that on
> Rust? I think there are two things here: !Trait, which is not =
supported except
> for !Sized IIRC, and having an auto trait that represents types that =
implement
> Drop, similar to Send and Sync.
>=20


In fact, ping the pin-init people here, i.e.: Benno, Gary, etc.=20

What is the magic behind =E2=80=9CMustNotImplDrop=E2=80=9D? Perhaps we =
could apply that here?

=E2=80=94 Daniel=
