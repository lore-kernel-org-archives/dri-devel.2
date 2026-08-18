Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE66C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7D210E509;
	Tue, 18 Aug 2026 07:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bat+YVCR";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC1B10E509
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:19:01 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d01548ac96so571575ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787037541; cv=none;
 d=google.com; s=arc-20260327;
 b=Qq6FGCmr9kdn56smG6b2+g5sowy+moYiJIVM3gf/9qLJ+dSCGl/MAul1fruWVmlRRz
 rFDtVVsYMTbzXyseBda7LFh4YV06TliKj/CeuYME9L89VPja61+v30xM4mo1HiKIriYw
 oWpPNA9I1XpYbb9Sn2Ca7mGvHXKVSKHyTER/gM15NPaejesCG28a+IPx1PSy+bjbW5M1
 LPTGvUMBNDjM8h11D1sYiGlZ7hhzMYlVLE5tS46fS28DLawW2OL99T+hDeLBJ+Q83Sjt
 IXxmkT3RnoQ0rZy1buh663gtn07Pj/a7+y51NyxOuKtg41b9UcE/v3C/M6MiKuuKI4Uu
 N45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WhPSBBPQGGZbolI+iA2pgFPPV7f1s1z0AqjG9jtoWO8=;
 fh=X5ke4D1IwdbVEDmLX7hWBPun945cYux17wWKIZIMVJs=;
 b=nnyoh5SUfmCnNzpGyvXJjnISwXFARXJKNJC+vDdDBJSF3qmSofU8BYBTy3FXOgCJ3c
 X+ysHj2qO3aU5wEsVu3n3RKkZfJgnIYmQAgGIiZwGh6BlYKAAZno2NxyI7tgZ8zugSUb
 QVYQeClulAZYL/ib2c3BntPxS3WyNfUrquwk4yRbbMZxpsZq4uXCqQwxJeq2+U3QfKB2
 wc/zDlnjdqNPv5DaM2tsXLCNrcv2981vPTnzpszvLGkiU9kKv3C/kxTtVE0PiPfEfU0C
 i3RLPfSoQDLm9g1UJGaM85tfBMXH0Fghr7qraHjFZgKWLPj0+PIaDiGAmAzPNufcRNa4
 B3WQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787037541; x=1787642341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WhPSBBPQGGZbolI+iA2pgFPPV7f1s1z0AqjG9jtoWO8=;
 b=Bat+YVCReaySSyUZ+3LW+f4YTVXrD542ZGKV94YDvhJCFlC+TNr8bufqZ0rwRHggQy
 LuDcOFboBvAN6L6WI1wOFpu3KzdQDKYZWKYe8KdSrLrSW7XcsypEJ00h22iqNbo7NNYv
 RUClWOQl3UIHJYJSTlpffhWd39ZrnNyi0a5MGR6RiqcD3RxAcCPPxvr9UcO15gEzgQHa
 i9t3AjeRacXyBD54Tnx932Qs35mv3W4RT2KlRoFX8MUAJ6Ylc3AEb6zp30YLYQZW2S/s
 DXeV634/OoA7OJkjEeYt6LTwGgt2znztAual3BQjmYuPfLGm2+uMG8IG9YOCQZuS0yO3
 rGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787037541; x=1787642341;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WhPSBBPQGGZbolI+iA2pgFPPV7f1s1z0AqjG9jtoWO8=;
 b=FbXDfP6gF1K1ns5B41xHmy0D2eYvp4/Vpv6PxrlX5vvZ4VmzE/Vu5gCKYs8VXjrv+w
 ICea4vl7ZyUjAivihdCf5f9ZqEjjX+itNlEg2FBuRgZCURGfJvo//65fThBPt8ggc79E
 DwNwmhiwLxCHZDKCOcV4Z4kzRkV0OtIhAsGKUoxd0CviyD++pftRLIM1gDTP056ocrLP
 X037lu3nz356xjiDfxw7OnJLE0tURGrX459MbIEr/hX+91CorvnSQ9r3OOB4Pwl+ulX9
 YPydcev2kx0aZdKpYh3a33RfI2pYKJIBT41tw1kUq3b7zNc/DToNYcsj+oBusuV65Dzk
 oYUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQbtNeO2eM2QB21mKx+j7RdqDzfBYpUac4qve6jKcwjF90Zjjtp4lhYN82Rl/vXy8uuI6qg8qGuVU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA1LzJHcn1vM6Zvwj96HQIP93TbAzKHw2tImjUGAtN9z1qG8Ox
 aD+z3+il0MDnN8ysl6dZCpEVUb7ktabmaE7tD3dNPSJyknfNAX7dWWg09IF7vaEQXyLXf7ePzzJ
 bqP5rl9S37MDHGGVCSixmnHaWNiYr8zY=
X-Gm-Gg: AR+sD10dQPaTsIF50+XGcRBmNDW49XMW210Uv9PvGKOUihzknhHAv1n8zifh3JOaMvD
 8qYHwDsum9oQdQJV9/Ok/pZlGlHcT0KZDJjROQNudrmitAogpr4QaKIIDCujl2F810JJFwz6xFy
 kUO+Sy/kadoG6SBjVjDdtRePxCnxVTKxraYz55j2c25r9dWPLhJZ8ehOdFDDeO/Vd9Q8wdvdnzL
 QJOVYCFfVNIUljoka+eMoQuSVuPjsyrwoeXkuC/6OXwvHOUxH4D08WlTeLOQug94dy/IeIkMvo4
 2CB1JgpXmMsEX9HFoL8l9onHrpRGtRUw15+o51LidgkexUfR9oEa7eph1zWOum7qU+uFTZ5nNQx
 h8wS/wF7WKghLkTlrXNgOV7flhQsO4gO91m6uhLuy82ilnl70SkP9KhsHyV8d
X-Received: by 2002:a17:902:850b:b0:2d5:cbd3:8eb1 with SMTP id
 d9443c01a7336-2d5cbd38f48mr29929495ad.3.1787037540543; Tue, 18 Aug 2026
 00:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury> <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <an4xDp29VX8Am0uR@yury> <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
 <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
 <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org>
 <CABwQupNA=NuctKz0FRaJsWowf+=24C_o7u8twFFeUZ+dq6u+Jw@mail.gmail.com>
In-Reply-To: <CABwQupNA=NuctKz0FRaJsWowf+=24C_o7u8twFFeUZ+dq6u+Jw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Aug 2026 09:18:45 +0200
X-Gm-Features: AcwNN1URGomC3yROmR3KTAJ4h6I32rNk_7AiTcL10HUoEZg2QkO9YMIizAjUoJk
Message-ID: <CANiq72m=bbjgMZy-BCsB0hajMJcKb+j=jeMN=e4++B-XSUOzeg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
To: Burak Emir <burak.emir@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>, 
 Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
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

On Mon, Aug 17, 2026 at 11:36=E2=80=AFPM Burak Emir <burak.emir@gmail.com> =
wrote:
>
> To add a minor point to this, if rustc could figure out that a
> suitable non-zero number literal can be treated as NonZero<usize>,
> we'd not need a macro and it would all be very ergonomic...

Yeah, that and/or `1nz` literals could be nice. It may be a bit niche,
though; and we would like good ergonomics for our own custom types
too.

Nevertheless, I will ask upstream Rust in our next meeting about
https://github.com/rust-lang/rust/issues/69329.

I added it to https://github.com/Rust-for-Linux/linux/issues/354 as well.

Cheers,
Miguel
