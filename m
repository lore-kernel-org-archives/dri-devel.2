Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8B3109447C
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 13:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B65710E07F;
	Sat, 21 Mar 2026 13:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZV3T/RL";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB77F10E07F
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 13:41:40 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2c0c7267500so147784eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 06:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774100500; cv=none;
 d=google.com; s=arc-20240605;
 b=MeE8Mg1mVlPwh0u91x/860geri1QXBGjb8AOH0MuEMllGcVgp07RIiKFuCUDPv1RZ3
 1sqdfSzOiOlvxtVixL80m9qWJ/k6cmIed3mtDH3oFiR5vnYt0LVc14ed4Av13rhmTm+B
 ofBjgdgXvvi7gNUF2hsDbRBn2jHNzsj2Sx1D2Z/Ilz/1GuKAPDBBUH+kHMIhjXTnlNOM
 2B2fIbdDtUaljhOPR4qYUOHBLx3yHRDMLJ0klbCvRzcNrzHaYMF/DpWn/6e9rT8VUDw3
 TcdKG7t6LscUPCGNvUyAwPGRjA3KH27E94ZrGFjJdzEphcr5j7MesYyaPni1PFHLkXB/
 RNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XLhX9/g2+09qUmS7UZocL6buru35hRvt9bcjyD+wrFQ=;
 fh=Zx7k/evclqtcg+fjdZ0yFEiARSya5GrtAVMyiXmcPmQ=;
 b=Zgnq7lO/tdw5HUZQ+DRQ6MeICx2/1QiHNv8wAS9A7pBQp95w3OPNoLRFhqE1Xg5vZg
 u2fTBKQv2RbM4GDIIU2dJCKaEpmXsZcNYdCnxrHq8MmYiPtnJv2VIOjUNlYxDMmVLFuT
 djB6cew1Fyut8bymA16C6Zso8ofJQYeUkaCqLdFPGu8YleQl395HlNQoviggSWegwL1W
 jxlo/IMLBX11q4Gu0LywlMHuUIfMIVQkCzcozBdT5+7kBafoO0u+zPU+tCaCHrphLuUS
 3dNCduLPIyQq7CUZu2Xfl3wm2MI8mQEEQ+7hWd/pczDHQh0A3kp4QZWn/i2QK9Ao7Yaq
 EDrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774100500; x=1774705300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLhX9/g2+09qUmS7UZocL6buru35hRvt9bcjyD+wrFQ=;
 b=GZV3T/RLZO5x0BwFrTO37AyjfYMwOP0A+slqHo8AYaeVxcMf5p4/JlMi7pAOaBz6xB
 slcDCN6ITntzb89+wzEYPVV/gSa7W+U8cNXUZ0ac2uZ2+tdce8Rbz09g/fi7uXNq97Oi
 OWPkxNIPe47k9dTEx5QY9XhC2hpz4tKW8VL9nkAw04+kr6t8l/7P/18PGA5VIbLaCmc4
 g8D8lPUggY05qe/8aNQc7/gqSWy5kYxm0e9KvRpYGkv6nl4Gw8rKqOpXdph1CN8t79TV
 bBYdG5WgT9gEEKpqyrmDk3rKgFE7Qvd427PLSqo9nbNkEG0al8F0U/W8LXf6XoPwVA2x
 brzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774100500; x=1774705300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XLhX9/g2+09qUmS7UZocL6buru35hRvt9bcjyD+wrFQ=;
 b=TLRqVNaxF1ZBHGY8EcZwPhrNQy7VmcFzUHrVZoWGkm3BFSh3z5WRDMaMks5z1qXVYD
 FNCYbZP7zVxZvbL7oDE8WUR5b/hvdxXGgYlMv5T8a+WYd5r5cbQRemPlUz3Nj3+NhDRL
 dbQ5U0KwjKy0Y4DJA9v7spx35YEbI79g14Cd2OhnOg86pdCPEeJnVNVpUqXkgA40++Ly
 yEdluXJ5Oq6HGmaylcptYNvyQ+DQQumR5gnT+Ku3R+YpcANJfi/JFVWwyV8u8/fbSK98
 1dbdE639LQKzPzIkKHantAaPswgbYyZaJj7PtEIYJ+V3wSkCCc5Lmtj9iJS5+sjXtfmr
 omNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVMBlGrxb6E6C+ZhvvsGx6Mr/ecVZzSBzyxhMdI1QN+Ru4SFAmzqMdrUIyh8K7j4MpCJrxWDPJI8E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmWamEArjb51Wlm+yLgzXZbC2VkUxFAR+ep1fIIDNUpTxsRM7H
 254/bhwtGYYHPjpnlEeX3bg8pP+m0pOW246T8vRxGhQjYkmSfdI4c2Gl43ciLoDjGfRG7sqjJol
 +C/hZyzq1Y+AL7PEJzFkk4Kuc4xCx4eA=
X-Gm-Gg: ATEYQzzmN5GQXwsqDw5rQQOqAtdU2ocey9VpYgig6impm1atvoHKcUS1ayD399+ID3P
 0eRBcN0cWL0qlpvhjHN1i0NRVCgugwGc/AxzTl+mqUsJydFbsaszlK6iCv9qr5/j8alCv937jmT
 40X5U+C9KLUnOxMmcS8YQVD1m0Mta9vYdo2IM1fD1DVru3ZfIxH9/sccV+a3NTyoJM+eeEBLmVF
 h/HweST2HTxVBFHoOcftcgu/Uq+ybbAiN8d7m987Op/yUbAZQroLqTA+4C57ZWY78+Rm/5mmCyt
 FX9RGhKRWb6Ch0MkX6ZsPJEk8fvBqom9tNSfy7FqshYjbpvDe7FFXL/ObFmKfOpVYB7T6QxUl6W
 orn381P2l1NhmoDAM3RPEaiY=
X-Received: by 2002:a05:693c:3105:b0:2be:687:5dbc with SMTP id
 5a478bee46e88-2c1097cc851mr1504671eec.6.1774100500037; Sat, 21 Mar 2026
 06:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
 <DH8HDA6Q6FU3.3JR57W97IO1VE@nvidia.com>
 <DH8HYCAIRCZD.2DXSNBFXXT6ED@garyguo.net>
In-Reply-To: <DH8HYCAIRCZD.2DXSNBFXXT6ED@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Mar 2026 14:41:27 +0100
X-Gm-Features: AaiRm51Hwdlg5eHPgbbbJ8KEe0n7xAmw4NZpb9mUA-Y19mwW6yxZqTznI1K4o44
Message-ID: <CANiq72kamU+XqG8AisK8uk9A2vkJeo0xcXZ7SJiisb9KMLK6ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
 Tamir Duberstein <tamird@kernel.org>, Yury Norov <ynorov@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 netdev@vger.kernel.org
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

On Sat, Mar 21, 2026 at 2:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I personally view them all as variants of BUILD_BUG_ON, hence the name is
> `build_assert`. I thought about `assert`, but to me that feels like it's =
going
> to host runtime assertions.
>
> I won't be surprised if we're going to have `assert` module in the future=
 to
> host families of
>
>     assert!()
>     warn_on!()
>     unsafe { assume!() }
>     ensure!()
>
> etc..

We also have now `unsafe_precondition_assert` in the `safety` module
which is essentially a `debug_assert` at least for now, which could
potentially be moved too.

Most of these (both build time and runtime ones) should be in the
prelude anyway, so they should be easy to reorganize.

Cheers,
Miguel
