Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D52FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F9810E342;
	Tue, 28 Apr 2026 17:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="CoErW2PP";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9413910E342
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 17:02:45 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43d73422431so10810361f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777395764; cv=none;
 d=google.com; s=arc-20240605;
 b=gVIiECgmtqiARwkqk38fmr5YhRwjzeJI1E3dh1IAvloxeTHRM+K4Nng89606Likcxa
 Z01xwM7pVtUtsWpBIkBnpM8A1492ghE84d8+N2i0oItAegchRl8b8/dderHTE+p+/AFg
 JZigZekQEzk4L/WvUVltcIfTY1uE+VO07l24d9HwMiDTCtvbt6lDc3N00kS1L/wtlOpo
 ipNy8+bghRtI6LfdUxYtj99uE34vin3Gc/RZPMGqj+fCMG+NP8HtXinD/CXK4GWrvx1u
 /IB2NfOZzLapZ6v4Da5WZVKzij6qPoDRcBjBl9nBVcRsHLLPWVWyHwuWkZWHsBBf16ub
 VZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HwVvM09PKVWHntGCwz8WwRzxhlVbD+GpBKDPzitmL5s=;
 fh=IgRJfkNFPww5DzGMJEecboRnQCnS+8ox3TOa9pacFlA=;
 b=VQiBYcwzVXU9Wfk9qKQStapntPsgX9UjtJgTujQWvtPFxG++bJ+x9kCfaEnZbb7Hnh
 SQ8ABgtOYqrJYJqTb84T4y9UyGaWlVGBUj/9u/SFJ/7l5nk1fzc3k44vbWxNtieQoIHn
 eQSHSGs9vmnVAstHZzTb1v8fQYvHOEnc5vLRY8hx+3jx9O9PjbBll2KIX3d41+FwfgpK
 vipxyOrmz47VQkpiBmYFh22PzXddsEXUpRSsTRKqb8BMGS6MR11Wg4i5CSk5Ts4veHRo
 TxAnwjAOehVZCEw+63HddVevUQTeKKNvP0C+Kaaw793R+JthcNI25RGu1pQL5DHwgVFd
 tfoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777395764; x=1778000564;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwVvM09PKVWHntGCwz8WwRzxhlVbD+GpBKDPzitmL5s=;
 b=CoErW2PPJGaK0RfoL7JylSG3YNW+xyGy9OXq6dT55cGuAxGCzb/wKE0hzsKR9Uo8ad
 pKm3u68mZUFW2exigbTz6xVs/0TFHtljoT3eNrhf5F/X+vE5J6DvCiZhmPQqTJk4ryEY
 6WV2CSn5aa9KcS+5OmzNKbl7EEO6F2MA7KklQLS87NOdEZBu6tcXS+dCRxmA6N32oOFu
 LbPq2vp8gBLAgT0CrWv6M9UQsm96/+paVjv66yyHsKSb3JJr5tgcQpZRZG6Ol85MKT9y
 FBLho+huqv8rdgNqTmjepUamcGf8PKdUIUTmY0ApePuWIwt32yn/ylBm9zGCbJXm/xNa
 JZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777395764; x=1778000564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HwVvM09PKVWHntGCwz8WwRzxhlVbD+GpBKDPzitmL5s=;
 b=PqNj3bfr39LrlqZsqmoITQIPGtUm8wHeT0IoE1bVNUZ49/fwGegZIXLvzTR4kWiyh3
 HNhIeJItoFc23L5Zaa0+TY1t1LrhdABulcAEv3gNihwzVUbiF2G1O99tPOuNnBeQDHu3
 fZS2OzL4nu2GUHIhL7F2JJgJctiTBZt7b3DuLijUkFArqvnsWJ+hbuk+IQs8jOrsYTu8
 P685C0uEpf+z6KCSfaGdav1hs71ewMEdQQBR1opJlt/aXGkZFTJWOW+XKEtBPHVtuNwK
 xT73Bxz8VThO7iWj5nr069HYoQM1jvrNxuD6ENaBtPF0NtfV3EdT889Bs3Ajd+llExfn
 p15w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TNXrNH4fHK9ZabfxytMYeQTFB09Cfp64D1XdTpCvRQfFfEmmLmLb8PxVrZHJXDjYi1CqeYD75kME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yytkg/ebziCDoACjcmtpFpQNO3RPZWRbJQE0PrEnDghWSipOFGq
 umr4CdJIXGemP5jg/gmJHfgs4jk9Cy8wGJpevnGAlAnaBz8G9K/s3VIL+z/WXBgMZbLmiWFTN71
 saaCjyHL3mICRUTwKL53PqkFdP3+re/HLugUIIY2W
X-Gm-Gg: AeBDievz4IkJbsNagsWpjqTBgSuIIsQZB2kUt9If2hBGCLIAdpYIQMu8s5CgMPJLh6Y
 SDva8eGi1AsR9OungZhD1u0/KObgGwNG0NFtzHw6k9JbyQxh7LbHmagPqYK37045jWI5H6X8lta
 vLG+vmI9RnroxILjg1k1GqMT2G9MQTd2DgzFGYWaBWs1UV8UGtbtuKsqrjlusjGjVFodB4PMrW+
 sI6PcmvSr1bykCmpqS6r/tJZC5X0AdQnM3Z69gCK3ef8/8o5HO5YjgrvZrC+WraZBcCMlyN479R
 suFdkXQZ59kst7EzSM9dUj2yKtStjPiokRzrlPIVbkLF9FlvfmATtf5ww6c=
X-Received: by 2002:a05:6000:1843:b0:439:b8b2:fad0 with SMTP id
 ffacd0b85a97d-4478e6b3b9cmr219739f8f.5.1777395763425; Tue, 28 Apr 2026
 10:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260427100704.02190859@fedora> <afCSUYIbV2ibZuOM@google.com>
 <afDjQMYam_XjGC5q@um790>
In-Reply-To: <afDjQMYam_XjGC5q@um790>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 28 Apr 2026 19:02:30 +0200
X-Gm-Features: AVHnY4Ik_8fb4oFZwvMoHcSuNjcM1UmouWDgkGJ5PuCkY4HsiWijf6VGxqB9mys
Message-ID: <CAH5fLgg73yex+UxpQeayrW_m9P1_u8gTSFzJSyz1a3vxZfZbuw@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] drm/tyr: firmware loading and MCU boot support
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev
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

On Tue, Apr 28, 2026 at 6:42=E2=80=AFPM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> On Tue, Apr 28, 2026 at 10:56:17AM +0000, Alice Ryhl wrote:
> > On Mon, Apr 27, 2026 at 10:07:04AM +0200, Boris Brezillon wrote:
> > > On Fri, 24 Apr 2026 16:38:54 -0700
> > > Deborah Brouwer <deborah.brouwer@collabora.com> wrote:
> > > > Alvin Sun (1):
> > > >       drm/tyr: use shmem GEM object type in TyrDrmDriver
> > > >
> > > > Beata Michalska (1):
> > > >       drm/tyr: set DMA mask using GPU physical address
> > > >
> > > > Boris Brezillon (5):
> > > >       drm/tyr: select required dependencies in Kconfig
> > > >       drm/tyr: rename TyrObject to BoData
> > > >       drm/tyr: Add generic slot manager
> > > >       drm/tyr: add MMU module
> > > >       drm/tyr: add GPU virtual memory module
> > > >
> > > > Daniel Almeida (1):
> > > >       drm/tyr: add parser for firmware binary
> > > >
> > > > Deborah Brouwer (12):
> > > >       drm/tyr: remove unused device from platform data
> > > >       drm/tyr: move clock cleanup into Clocks Drop impl
> > > >       drm/tyr: add shmem backing for GEM objects
> > > >       drm/tyr: add a kernel buffer object
> > > >       drm/tyr: add firmware loading and MCU boot support
> > > >       drm/tyr: add Wait type for GPU events
> > > >       drm/tyr: add Job IRQ handling
> > > >       drm/tyr: wait for global interface readiness
> > > >       drm/tyr: validate presence of CSF shared section
> > > >       drm/tyr: add CSF firmware interface support
> > > >       rust: time: add arch_timer_get_rate wrapper
> > > >       drm/tyr: program CSF global interface
> > >
> > > This series starts to be quite big, and it seems new features have be=
en
> > > added to v4 (interactions with the FW). I'd recommend that we extract
> > > the uncontroversial bits (I'd say patch 1-2, 4-7) or have them applie=
d
> > > to drm-rust-next right away. I know it's tempting to add features
> > > between revisions, but the more you do that the longer it will take t=
o
> > > get the foundation merged.
> >
> > How about I pick up patches 1, 3, 4, 5, 6, 7 for drm-rust-next now?
>
> Don't pick patch 1 because it depends on the Device Context series.
> The DRM device only because redundant once it's Registered, so we can't
> remove it yet.
>
> Patch 3: "drm/tyr: move clock cleanup into Clocks Drop impl" applies
> cleanly to drm-rust-next so that could go.
>
> Patches 4-7 need conflict resolution.
>
> How about I prepare a new series of stuff that could go in
> immediately and that will at least make this fw-boot series shorter?

That sounds good to me.

Alice
