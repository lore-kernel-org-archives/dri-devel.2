Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706D8CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC50810FC9A;
	Wed,  3 Jun 2026 11:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmT4HJtB";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4855D10FC9A
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 11:50:05 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304dc707bfbso549354eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 04:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780487404; cv=none;
 d=google.com; s=arc-20240605;
 b=VVj3RvR43qEOnB3iUdrZXO6DBGAIyg94klxT6x0ervRfHN7MNu71DKewLnnA/v8IZ1
 8uJcyT/ZDhb2VzyIbwFLQI2Nt4+NefbxJ3JhSbqFKgxg5i606z2FSiEHjdjEeENioUSi
 s+hiCagr7X59FtiF/+Bb/2Kjo6tbEls+acf8ALhlaCabgsxvFv1T82ujYb435PbNdeYA
 NlKSi+zBqJBTSU9TTaUEB5i197EC4JWEVNRTpDjbJ/40iAhN+XJOJFajkHHh1lZ5b/Vw
 3Z+XBtdwJKn2eo2cu87L/dmfFOswqn4G6yDap/Xg/9SM6bMn6hfLazK6XVSxC928/Upc
 MNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TLZHWIpqN74sQXHrJ+tZtAA2WHcfmMHzbUu8OcbGpHc=;
 fh=JWMkg3FWOHodoC2fqYsgYRgMSlqXzxNiU8PHUJxRSQ4=;
 b=GhLNf4Q7ygx1estZ4io3TaFXjhfWoosAddPWXQo7AimIpGRTc6jHMu6wG4XytEKBDq
 rUxM9Wzvs5gl2RIxUx990sioKAZOa8stnwdALUxUDwML4701ZMLcYlvnDF4SdANCC7ss
 JTkYvrmwhVljfGImysrZyNVri10k7zSJhhsNnEsrhdpdpVxD+m3DvMDO4LvjJbPzyIxd
 dTgykJMz1KUXOgwiF/CHvo7T4cnp88PYmUxG2sSl/VjQ+Wb3B0mWTs599ehYjocST2Qq
 19J2dqODLWczZsIye+OmjYoUldCfEiykoJ8lc0CuoLfEYnffLOIIvJff9SI7Lstp/6w0
 Yuvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780487404; x=1781092204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLZHWIpqN74sQXHrJ+tZtAA2WHcfmMHzbUu8OcbGpHc=;
 b=HmT4HJtBdvyqI7OVBz1PVvOn7XK8gobWd1bIwZu8Og2wFKUzBpO5XpqP21eqz3Lhqk
 CXBPQFgnx5JppAgsdy+iiCBizGC7ttTfLjOVOEPtOyjxvcLNJ8URH9IVmE4Qx3mp3C2Y
 /ZRs78eUw2Mr6Lfl57qS/aoJm078a8gaPtM/Acs7MufygoNyo53//VRmEPhTTEqZu7WH
 NkcIHKF0+jtUnKpE3unbCdfDjcMl0uf/HvRc+R+QR7KNwtNSyiTfG1QbIRWL1mM7jyhh
 9qBq+hgfkJuRIU0ZHeTj9m350ojE44aA7W7IVAT5swN8iauB4833zmDMvMTQlIpODFBU
 Mgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780487404; x=1781092204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TLZHWIpqN74sQXHrJ+tZtAA2WHcfmMHzbUu8OcbGpHc=;
 b=F0XPf9FION6UrvRZBIKf+hLYoCmEWC+5aFr0qZENTOGB1DPAYz4pHsMbYsED58GTCn
 gsTQvs9t2jxl+Ajtz4SRvU1HMQuAtKgElpCI/9m+KcpEANapWPiUdlRC5BbeMbPqCgRL
 JBn5inIdTSXH53dk2MsQP6gBw0jEW2mnIqgi7nTaeSU6oiZr7WAAXpNjLucMDi5WDMNl
 oKA3c2ZGmdjDZtBckjJkTDugGjncoVmwT/LmKNBrSAjErjg72NQ1v0v3KwwDIv1+2ex0
 KvnDmvQPYjj5r/hQcvEk6X+ARvso52YwsN0B6Q8kdw8r+768T54ZV//MJTQFevpQVCWo
 EiiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F+nkYTzSloyY4TXSuc+BQpzDLXMueqa5ie+JSYm0E64WEIhUypUju/HNylFihEbIkImv5eX2fGEs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVXJeGZZsxFbSCxZtSbqoJW6DjEC3VQCj164b6xBDUJuwswB7b
 FXIXpCO1cByC1kqinY5nlaIWTMXZDLvHRKoPbweY6YV99npJB24dQWHYKhBrzE93TyGHmmuUg/E
 mdhF504qN948P/8nk14sdN1ikEFWbSLw=
X-Gm-Gg: Acq92OHx3lC/usp7NmImhfl694ermvm3e99Zp8IHPFfs/uhtVe6S+LRCbgPREKQqZqJ
 8y/ay/peB4Hq81XFmQh8t4EgWAxMFP96l+gcNnFs5J7hXit6/6w4p5u1VmV7hxSwqsiSKI0MSWW
 9iCjo56FCj2I376sE0Mbm9S9jygeBxqhN2EB9qdLwQ/6AeBzdmvrlNsD6vH0Z4i1UF1qNnkZXhl
 YMpLGR5jSufc1CizqvODN7sTe4VKk+BOld3ldM+Q1dDT/I4lQB8G+5PeRJl5Nnvjrw00Nz35F/9
 ATFgvUA/DlGPJtRSwRQMcLzFYfYpKDY9JIBhXJmtpCJUam/CyT9kv3vYtSqxH4IwAAaReWn5ZU7
 z1bC8dwYoq26UWPxVw9pvpQ9onisEMW3UVg==
X-Received: by 2002:a05:7300:cc0b:b0:2f0:ddce:8468 with SMTP id
 5a478bee46e88-3074fc26eb6mr769327eec.8.1780487404307; Wed, 03 Jun 2026
 04:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260530-nova-exports-v3-0-1202aa339ef7@nvidia.com>
 <CANiq72kbzmLeFv58mkiKn+LvhCXmH5g7UsnTYTcVmJ6kyc+vLw@mail.gmail.com>
 <DIZCF27FZH6I.17CWGBTLDNSMP@nvidia.com>
In-Reply-To: <DIZCF27FZH6I.17CWGBTLDNSMP@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 3 Jun 2026 13:49:50 +0200
X-Gm-Features: AVHnY4KLkt_lJ3NQBEx4139A-z2PzHbNSKGJ40zqfE6a-mpUvOd_VHKVite3y1s
Message-ID: <CANiq72nTEPWds0VUKC02RLh5a3TLNyShikJD1h5TDc-26rrk_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpu: drm: nova: enable calling into nova-core
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Joel Fernandes <joelagnelf@nvidia.com>
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

On Wed, Jun 3, 2026 at 12:30=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Yup, I just want to have something that allows us to call from
> `nova-drm` to `nova-core` as it becomes increasingly pressing for us to
> be able to do so, but will be very happy to replace this with the global
> support as soon as it is available.
>
> This patchset won't make it for the 7.2 merge window, so if support in
> the R4L build system comes during the next cycle we may even be able to
> skip this altogether.

Sounds good.

> I haven't thought about that, no - in that case the parent `Makefile`
> would need to be the one in `drivers`? Or am I missing something?

I think `drivers/gpu/` should also work. Maybe it works inside a
deeper one, but I don't recall trying that.

So essentially you can move both `nova-drm` and `nova-core` (and the
exports of course) there, and then since everything is in a single
`Makefile`, we can just add the dependency between them as a standard
Make one.

I think you don't even need their old `Makefile`s anymore, and that
avoids the double building and so on and so forth. You still need to
emit the metadata, but I think we can pass the flag, avoiding the
custom rule too.

Cheers,
Miguel
