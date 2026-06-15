Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1AACD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5E810E39E;
	Mon, 15 Jun 2026 11:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFlCb6/w";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B356910E39E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:47:39 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304da3b4508so376222eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 04:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781524059; cv=none;
 d=google.com; s=arc-20240605;
 b=T1LqOMvDCNj3oraMOa0W4InXCC6HElqGTyENCCr3KZHTI6uKnH3Q4uSPiUkt1XPCTi
 NS7wiX/b20ZBJTfeyVzpRl37G/QQnSpVzGkVcib91LPwTpNgezuIPeYUj+QtyqKy5gFL
 ntbypbkbmaBpX0bSA0ZqjdveRGB6y50nbIxTpfkjHTOR4DWdIXvhlFD/NnZRPJ3YEYGZ
 7HhPA6z2WFetGaWT38qJSz8G3TXJXqPLb5A/1A2DSfiFAgkJwbEbHQ436Rn9o8aMyzgo
 ciGhpcZRTSatHGN2/nacJm2B6cy2hzUjPAYRD69516iFmNFrR+oRJ+xo2AfbUK6n4fBg
 Jbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RRWyWl9MNHhiDK4KIqS4y63xpkwXQM8SRd+8elETUN8=;
 fh=6yzii0DKV7qL8Eypw2K/SqC0oje+dgGBHISulvElFDA=;
 b=cwkDK8gp4ICxoEz19QpICWMa1a2199IH3oRnhggMODy2f8nAqvHFJkExV2iXOVfMPy
 oNHyby2Iibk0lJKpHwMqtA+dqrgtPrUOjwkKC+iov6kmMDJ743kZGlwhBO6LtaAGJngM
 L1qMZaLNr9oLRDCe/iggxF7l1Ma526YU2Tdes6tvYgWNfy7D76PcfhgJyB5yveUF7tOo
 YQZAwpWgfVWef9vTpSKGQA5MITHpzdPG/LXidWHgYlFKLIr1ImsyzT9NMeHYEl7yKzi6
 5DGiaM/0NvPKJiAFcWCxYszRvDs27hrHSqo4lxmZYFI5Mnad93llOrhjxJtZtCGC461U
 ZsNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781524059; x=1782128859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRWyWl9MNHhiDK4KIqS4y63xpkwXQM8SRd+8elETUN8=;
 b=gFlCb6/wsS9c3mO5ASGOFqqYHt+zyU3LPmMzOuZhLJe3s1nYGYkE3lDxLqVuGTE6Ol
 3in8cb6Wqnt5cNnIAFqNdAS9FghwErrIKh3y3FJmJemb93KNeGhWqSej+5iFexPL0V3J
 yDpe/VY2ZzBP3kfELjN6G7Ugnd88+DN2QYimpuF2X1pEO1bbAniCOq/9otfktjKUI78T
 Qkd74d/pWOYzkBdAEVkC+u+ULBr5dV9BY4JAgfT3E/qtJzOYAbHcST/BQrkaqB5p8MLl
 Bq3hpxjym6JPLIjEde4ov6graO1txsL89iVGjThzKoRftMYdOOSBr5FGXIba0qhHX++p
 PjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524059; x=1782128859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RRWyWl9MNHhiDK4KIqS4y63xpkwXQM8SRd+8elETUN8=;
 b=aUA9pYrYHzA50cndiGPFoCBPzmmFi9PzIa0ffinS9s6C4YPSBloHzC3p5I/gsor1su
 uUt7vIHT4M4ZQbVrheqsOTjvQu0LgFGqFVLGtgPNv+TVSwgCYjyZrR4FzdeYAhyGXeIC
 /+9THEnZVZ4HygSzFNsEp1dHsPG3Q5sd38IVh09JLjbrM5Pc01qz+epGqUW4RvdqT4Qv
 6Lab+E3Nj/ecwvoanxF4zG8dTOlhKEOGWOxVAEeaaQWyj60RQSYpr2uOFd5xPT0A1Zmy
 eymIRbnfRxmY4xV8JCPtML5tyxjQ3Qr0LECPP2hNYEuOuSA495xWIM2xJ06UkCAoo98H
 vVKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rU+jVl7TPwvGTZRp+45h+aZC9WbuYIno47IxpTCNvSivRKiI9+TdvVFjKRh0myQKGvMnsXfhWXT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+VIOeJBEywAuYed0mMKB9+oULPWto5sVVCgASY+EBjNowR7Dz
 teaNMhuZGGE8Rq4lTr8HUG48pyPshr+baZi9IY17vlCswtVzjvIr/0ErQzQbuCtOrBoHn+Y/bPL
 8CqQBZ1655p1DET5RZcNKFGg1q1zcZFg=
X-Gm-Gg: Acq92OGaSQ3prkohUWXWvqO3ks2Lon8zenuOjIu/cmc7XcHJN1H86kb4n2Lz3LqTSHQ
 fdvCITY/AOi3n1AFixUE7t4ZHm+s3h5C//hYIrDIp3Ya4I0/SHelGDmXhXYj8Hns2gevLhSmzXy
 bSbatZN0239ex57/goYHgx1LVRRc4GFrTbqPtzxdlubr6HqY8nlncElNeZrpSHzwTrJ4TdXWNoR
 m8k66sDFYwMYty77UB/5pCeCyJ/vgzQyf5MdKuK70CmowXzJKOmRk/csPLtH3t4w82cm/AfLT4b
 U89Tix0EwmE75jq5ajrLeqFzlnifylRmG2wBlEFhvOsBFV0wAcpCHFLxodxHjHz/rEQpQachAMG
 eloFXB/OlqJ3sz+dQi5/aS68=
X-Received: by 2002:a05:7300:ca1:b0:2ce:db5e:354b with SMTP id
 5a478bee46e88-30820093556mr3538872eec.6.1781524058794; Mon, 15 Jun 2026
 04:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
 <DJ9BPBO51J9U.FQYCSB4SSC8Z@nvidia.com>
In-Reply-To: <DJ9BPBO51J9U.FQYCSB4SSC8Z@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Jun 2026 13:47:26 +0200
X-Gm-Features: AVVi8CegjUXU8O3nUA4IWQxEABTAWlEoMDkVbcmMfj4RlduFup8ycaEWEgohXlQ
Message-ID: <CANiq72n4LzuHdu+D0BT0iew29rck1OydryyTw5j8JKhtW0prNA@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] rust: io: add dynamically-sized `Region` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, 
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

On Mon, Jun 15, 2026 at 6:03=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> s/should/must? I guess we are running into all sort of issues if we
> create regions which runtime size is smaller than the compile-time one,
> and this is an invariant of `Region` itself.
>
> Maybe this method should even be made `unsafe` for this reason? The
> caller will need to write a `SAFETY` comment before dereferencing the
> pointer, but IIUC this comment is bound to cover the pointer invariants,
> not necessarily those of `Region`. Making the method `unsafe` would
> force the user to cover them here.

Given e.g. `dangling()` is available as a safe function for any `T`,
this necessarily can be safe too.

In addition, in general, in Linux we have been trying to avoid
unnecessary `unsafe` tagging, i.e. we try to avoid using it for
"merely dangerous" operations.

Thus taking those two things into consideration, then this should be safe t=
oo.

However, I think you may be pointing at the safety vs. validity
invariant difference (terminology is still up in the air as of a
couple weeks ago, from a quick check) -- it is true that technically
dereferencing a pointer doesn't require library invariants to uphold
right away, but in most cases (especially so if it is not your own
type) one needs to be very careful when dereferencing pointers w.r.t.
the library invariants of the type too (because otherwise it is likely
you end up with an unsound module or just UB soon after).

Cheers,
Miguel
