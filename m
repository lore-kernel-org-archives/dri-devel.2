Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18281C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1EA10F1DD;
	Thu,  2 Jul 2026 07:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FtFphR8m";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C0110F1DD
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:55:02 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-37c5d42ba2aso132965a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 00:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782978902; cv=none;
 d=google.com; s=arc-20260327;
 b=PofQfQf8w6AqoJsWj9tb56oklkiEYUVbeYh+W36e0i0OjQJ65kssRvkWfxItjPGARI
 DW3QIGDAirxiQs7yXW79TAzPmqk7cDFOkxLJ3BdecnfJvN+P6NRVQIsFA01nPNnxEN8P
 dF/0U9bmJusXIKCvydMpuUpux1TINDfLhekAJ2A4hFX9AE/ln3SrT/ElQ0Aj9uQvnCzl
 x1KAqob4BfgeeJLtc+bNUEPXDKy5yf9RdS6A09H41g20q7IfdPLf1Q9YGvMQKyDxl21S
 0xCU89HUyWPfPj7G2X5qqwOPvhO4y6PnjylMlnXJBl7cSe7On/mnLD13fxDQQcQhDYCy
 mDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3wHUzHYNxBHACocz+MHx2rhMLTU+c4Oe46o/2eS2jTY=;
 fh=1CyyzrPECxrX2R/Tm0WazWVO2Na8k32DtnBRn816954=;
 b=ht7s9ubW3AfMOnfkT7R/Zsg4TnKackIKOmDcdfSSgSoJ4yFC2lFZxmfditHh4SfoK8
 Ln3roJ34DLx6Jqz1yptSzQ1oDxFVV3oo4QggOGj3/hw+hRP9D6hF0+DBm/Z2ac0tcmFV
 RsIGW1jY1T9Ezs0oxB1OxSjFvpYSQdEYde056JKjqUQvzuEruJf+ZfKgA28aoO1i4rzj
 bIb885kiTrpV7HarmVyOPOYhXsRhCTJod3YF1CwyitQD8wR2Z72QGQxvcR7/5SGXFoad
 9ayCzwnNxE6WrGvB5wlYXE/l2bsFLyc2tHUtOJKeUdZIc6U+fnOLEPD3KX4q38/bsbKc
 VRKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782978902; x=1783583702; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3wHUzHYNxBHACocz+MHx2rhMLTU+c4Oe46o/2eS2jTY=;
 b=FtFphR8mEHDAVyTYLZama58/imWZ1/hky4dAk+5S4Kt8p0VKQ6aEq2pBhh9GK+kS3b
 8+FOibNpqzxEqRCOtuCIfXZNSDkffAmbp9Qv10NLDxYFx6oIlyGUVG8vSsqs83Dq0nBF
 sGZdRDc4TF2jT+5oD+1vYXt4hAlNo8zvhdkyQK1TCKxcPD46M30doBDr9KeD1DFsgHyg
 SFaXmLBO+sZgA+SFHxeyjBrFyElDzzRwI9mMFhYvATSADxbBnSJP07gkAtyhLXyBMhGH
 bpEMb/9gOy8K5sAOlEM5+m9w+VJA7kg5LW4piW2xke+xZkzkGfixjyvevHguWlKDx+26
 4T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782978902; x=1783583702;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3wHUzHYNxBHACocz+MHx2rhMLTU+c4Oe46o/2eS2jTY=;
 b=YCSbFQBJR40La+5RHycD7rnHzaZKJoz33g0wsboB6z86ZDZ7nQ1E3oRmYWgIyHLkY6
 KiRy7tfBM7vk3tIIFMypG5hulr8GCCNCj9hLDLl0xs7Fa8aEhWGhwK6ZMUqsNf8CGsyY
 P7AFyK46kjusAs6a2rnVhOw9goCNQ5WvPkU4N3XzuWOXvt2TH2yFlgsijpBXZGiZiaar
 LvkH1Te3cIWz1mUm5jtX/UFyANzQ0rX8z8cnBl97e1w7aanhoHfiX0DnYP+Z5nHEOYgD
 QyPZ6RSi0CfvoGuWx9Ylea+T+F10tWiAZle2Lib8CZMinu8vHurSUtkevRUzqgz5ggAL
 Sd1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzPRuKjkbQ55TYcQR0GtfykInww1GryT1rXdeqtk6VrlJXw1oC9v6hkUcGMEiJ+wRtDVYDjpXKVHA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwUFEqFL/jyHVx9jQVT1DIvT7OJ7T4CfeEmE5oiO75ZDTIA3Gl
 8kCE6u7yWQUbV3z7u8cbBV9dgnJv/7q9wOmqFQce0WvywWB0VvT4+vCqNda9NTJWoMDyTlHNQON
 RZYCVyUMxwk9LhNzJhFmejQ8GgaKlf8A=
X-Gm-Gg: AfdE7clTmCv8WRFtbLr4F89slofTx1yLFRv86uwPwgvldcyqbbqiSVhwBNBtg7FwY6b
 woPmVp7i5rGGzEz7Sd4nBOJrXBWEd5tMtclNsScmSs0kuJJwrZ0D1cZo6tKzgzRJcnpZpFGKCKg
 PC2DaTwS7x3kt5j3oCdF8a/9TYepRaA0Y3JFsLmdt+bzDNyGkUHTnWNnIAHYzIICoMFdIDE9EKz
 x/bDuFX9N6o/1D+G4wfzeSG84pYf81oad/TwSYe2m1oWGsSMgjL29LiwodxqDnJpD2Y9ZkflAJL
 sD78P42NBN7U/3ektHluSuLxdRnw17c7GsjPnnyUtNFr81kUe1SmFi1DxShoD68a/4437e/G5iC
 CSmSdLk7IRU5lynR+Ygelz/I=
X-Received: by 2002:a17:90b:164a:b0:37f:e7e7:ac3 with SMTP id
 98e67ed59e1d1-380aa213029mr3471079a91.3.1782978901663; Thu, 02 Jul 2026
 00:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-nova-rust-analyzer-v1-1-5209f486f10d@nvidia.com>
 <20260701123703.152958-1-work@onurozkan.dev>
 <DJNON0M9N1LM.SSDDO8N9AM2B@nvidia.com>
In-Reply-To: <DJNON0M9N1LM.SSDDO8N9AM2B@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 2 Jul 2026 09:54:49 +0200
X-Gm-Features: AVVi8Cc-jeKWuhlps3fpukVFGOkqyU8Zzqr229Z3ERQ1vr56XgIj4S5V-0WLn90
Message-ID: <CANiq72=NSt8bKamtL8BpkwBAMRs9cnbXj5XvT7yB11ZY0wWdbQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: nova: fix rust-analyzer generation
To: Alexandre Courbot <acourbot@nvidia.com>, Jesung Yang <y.j3ms.n@gmail.com>
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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

On Thu, Jul 2, 2026 at 3:09=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Ideally yes - I expect that this is something the improved build system
> will handle correctly. The current Nova build rules are a temporary
> workaround, so I wanted to keep this "fix" as small as possible as it
> will also be reverted eventually.

Yeah, the current approach is just a workaround for the missing
information, and we will be able to just do it "properly" instead.

This is fine for now (and it is not the first "magic comment" in Linux anyw=
ay).

Cc'ing Jesung too.

Thanks!

Cheers,
Miguel
