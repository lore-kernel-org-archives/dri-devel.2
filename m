Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83391CD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E497511A5AD;
	Fri,  5 Jun 2026 08:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l7JgVzhe";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE81D11A5AD
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:23:48 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304cf9a02f9so74957eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 01:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647828; cv=none;
 d=google.com; s=arc-20240605;
 b=JbJo282FKnJM71rwHEatLpr/8L1XVPh1Wqh8wjs9dtYi9x9rsapL6K9Nde/Xx4GRq/
 W6y4vxnbfmNXh4Dxs2ElqBK91zqphgKigMmgZQfVpFjovbax8he/KxDV/kyxEzMLmCct
 2xEHddEXkWHrkAnfrfKhBbZeiH9O02Gd1PWC9pDHFGA6WIgVvfNqpDl7OOjvcgnmrQvJ
 u1V8Nnh6JeFd2tpOYJ7BDHgwI/g/HdCzxmp20P6BIyH1cF+NbwZXcC784qBICOJwoSZU
 gq3915zaCtY/hRG79v2PhqmcCFwmjuh7sZ29c6GwAZL4A3jGIMM7vd4qDlktIFL3n6Es
 F7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7Sd19hW4Zhi7QaeR4Q5YXb6X/rEi4eqFLIxE0KT8DhQ=;
 fh=7XEey43EPqSSVeqaaHdXjq+PdvYZdpDmnq2JzTcI4Gs=;
 b=Jm2Cx0HQAk60vLynOe5+282LeCei2PM5OMGmLfRjuIx/xl+v+l6Hcqq9BvgAXu04Ls
 hv6yhl/tEpEhSZ8AUdjCwZCOXHzSf8iDZAEyptMqK7o8BKjPXV+UpmHbtQ3aUY7lpmPg
 gACYqk/CLmZc6LJTu5JmjwaDel2I1T7HbKjpJSFxI3TdnjIQl2KepO+JjFd+YdgL3c5U
 ERoAPCoEmPXnH3qBs+pzPrVa/DX8LE9yAuia4SClWnmsSasm/3sMhGKrYOK5plGewMSk
 oc74UZAiDzeUwXRdKwBDEdRvWlrfqGzsHlNaNev01ddFtO43+tBxoXNFLgIXEUURZNUm
 leRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780647828; x=1781252628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Sd19hW4Zhi7QaeR4Q5YXb6X/rEi4eqFLIxE0KT8DhQ=;
 b=l7JgVzhe/8lsFwhQajEek27S2UBXh4b7NsDTK7GXKLltONOYL18+3enI4k2wM3dHON
 N3bF/S9D0/HvvGeMVeINtcV+VvEHiHFrDizBnTfYj6c9thx1qvrRRUYWoRyPNrCNfhJ6
 BTyF9Zjl2kGbnv0tNRZTvCTKgXPDXFP4ibB6MYbzR6y6pE9kvC+RRwWPTYYvgBO5qOm2
 J55qcup4C24zJ2Znpni1UtcF0M9IS6dCz22N9mgYl4s1szj3K3yCwLj2nweYvp0YSF0a
 f5XlpZxzlzCPeMOENmZjbffSo2vkJFAtcV47lMtMcD/h/dGVWneFPYVq+GodYcF2RnyA
 ycaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780647828; x=1781252628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Sd19hW4Zhi7QaeR4Q5YXb6X/rEi4eqFLIxE0KT8DhQ=;
 b=WoYhvThlylLc2uoBY0wLrKhVWfjnXA/ZN8Y+dS+WPchCMkesMkDHIXr0tvL8L5YkXY
 3QREjOS/V8fH7VNvUqWPtsw7s6QTMxorLLx9ZY47efDPmI1GY4tAnCZ0PQjLBQKZpW2J
 pLEHThVDaj7doZWC3IG7PHzDtr5RRgqeAEeu2kFv0RL/GLkmKTE7m9c832wQ8/YbfHyq
 d2eNH7DyMJDY5nknZ1DX/RZGXTXaed/SwMXF0i++Wl366t78ca0+eggXx6eT7sHYbIe/
 duh4oKXPSuhhryfMN7KIMPNi5RC1njgKLVUsiztVzyiHTMu6Gq7hIeNRzSAOoQOoJTrU
 g4lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+b+ugQFgNhC2K2P39+64kqT7lTg2b9nPq7ZxPIhSqRwLgeTCmsPB02IF4uz+vZOM+Op2kw5LO2hk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC/8cNxWBz95QhmhcY8ccoNWyvMY+4SontCr7X32k0DLGYxZES
 9wmyYw5KOpOpsHuSdYYThYksEerO858trO0eKtogmFtzyC2zVd6iu3pACBWrh4EZF+qzcQRPEYS
 BAemrzMMF2Ojb9C4CIunbz1A0sM6dVvU=
X-Gm-Gg: Acq92OEfxHiRpzIV0/u5g7NfLIt2c2D+l2Tal4egy7DqSYsOLfkLROylAF6pj1vFwe8
 Ru8a73CGWwPloty/MlS6uIDp6G63A7DhY//er+Z3BVR6w2HqmfkmNClPE+NEGMH7vxOFP8VZYKY
 CoiOpoNVSouXSL6xCgUh5PR5ggPeegGuuMrjpb/2htbWq/Nj5d2rqnna3hx9T+vOPMj6HnxlJqM
 iHYyA7n1ngWcFpor/G5xFe8Mgkf1PGBVEFhs8Qa45DtDiH1v4Gm4ewEyenrcO9pAbCYyOu1tJha
 y70Nb2iMTOnvTZpJ8Ll7OulUM9YRP75s3ziZ7n1jzAE08CeeAiYd4b68GV2RonNT9x+Ugx9T99W
 VvyZcwZBjnlehgNjJbYhSu2G1typ9r1XS9g==
X-Received: by 2002:a05:693c:3749:b0:304:c73b:79fd with SMTP id
 5a478bee46e88-3077b21905fmr565626eec.5.1780647827968; Fri, 05 Jun 2026
 01:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 10:23:34 +0200
X-Gm-Features: AVVi8Cc0V_mPWbgZwqJ5GOMV5Xx3qEWLtYtwsW8Dxd-NGXwfyyP5qAGAP7_StUw
Message-ID: <CANiq72=87b1heSP3ssk4+9E4+1Vy_Zk9eSC_9EF9Cs_mUT=hpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Rework index projection syntax
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Tue, Jun 2, 2026 at 4:18=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This series reworks the index projection syntax in the pointer
> projection infrastructure to use the keyworded syntax to be more explicit=
.
>
> Doing this allows adding a new panicking variant of index projection,
> just like the normal index operator. This is useful for cases where
> compiler cannot prove (or cannot reliably prove) access is inbounds.
>
> The new syntax looks like this:
> - `[try: index]`: Fallible indexing (replaces `[index]?`).
> - `[build: index]`: Build-time checked indexing (replaces `[index]`).
> - `[panic: index]`: Runtime panicking indexing (newly added).
>
> DMA sample driver and nova core is updated.
>
> Danilo, we previously discussed merging this series with I/O projection f=
or
> patch logistics. However, I'll need more time for next version of I/O
> projection (implementing view types that have original container type
> erased) which won't make it this cycle. This new version for projection
> syntax rework is minor changes only comparde to v1, so I think it's worth
> sending out so it can still land this cycle and get out of the way.

Applied to `rust-next` -- thanks everyone!

    [ Reworded docs slightly. - Miguel ]

    [ Fixed broken intra-doc link. Added a few extra intra-doc links. Rewor=
ded
      some docs slightly. - Miguel ]

Cheers,
Miguel
