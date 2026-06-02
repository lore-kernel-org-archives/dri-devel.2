Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A87CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D166610EF34;
	Tue,  2 Jun 2026 11:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gOjx6e28";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D1A10EF34
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:01:22 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so18257535e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 04:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780398081; cv=none;
 d=google.com; s=arc-20240605;
 b=XlzzMKPofo3sLEyl96N0fIytadd3I1mQFuVITTn3EPls8PWRgcLt03b4MH2sAFoF5W
 qSxavxPgSYwY96OeRGaxlQHDdFGsIGl3TjNlNIozBieMSvlaBCn0jsXPMxbbJfZ08rIO
 Qe8L7XM//KUUQQ8xQhB0n4rl+Gi3v7xEJi/wDPKxYk0o6uzMSBP/lO0g8b950+H9z2cF
 yMYodza1O9dNEsbi7RjBiBBcghabQv73FC/ttJA3OFX81jRBp1a5S3wy8X/VYBrlAXiR
 AdZMKhq//w/tq6GtMDNw3ECpjoI12jyYr8nbvTnPJStk9S0KE/iYZytqKuk7HI+nvkxx
 85PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bu2OrHUrdv8mY3erGyGbB8ppYLrym+SFyVnHvC8BRas=;
 fh=E+rmdh4QDXTySMsmIt+HOsMW+9uisx0q4Q1u5HQPK/4=;
 b=XZpPfU4Z1U9zsOErYijMUk4wqCMr6imRcrmmORDrRbLahBIxe6DN9vuk5ANSwihOWk
 PLUbeC6W4/1vtRBOa1NlsqwGIi2hFZrECn0FPEy9Z0KvRZKky+X04XsL0QPQZiONSJHg
 cqgpIqCK22PbRTt97HU8Mja5kuq3zpUAx1tzf7Dc0qiKz7UvLN7QYeaP6r941A6NtxNr
 2ntB9v9XzsHDAVEj3M6c01FLiWp2e32uo8wkGBx/jxXCQSUKULmAZd/KeC5FEqI9+RTd
 xo00WA5o2mSJa77iknt1OWwtkIJh4JvLY0C93L46EustCw9MzUQN8zMdkCs/9RDiM/xl
 v97w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780398081; x=1781002881;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bu2OrHUrdv8mY3erGyGbB8ppYLrym+SFyVnHvC8BRas=;
 b=gOjx6e28vmKH1Lb3VKgNUNTf0M5JvUOy+BtP+kR8Q6zQKRGx+3DL3dZLC2k9DDgRnO
 9t/ywV/gC4Qw7uwQmt+0zyLDvauxHVlQtFwZLx89N5OZumMuIYfZ901nA0hxejVqvVj9
 pGjwwtU3NEkaEqagS3IcoB5mYonGwMpWfalsYFSPlT0TfzBT+3eQT36bVT4QHCNMfChI
 jZAwgs+dDViGGHtrlLERIJNmawgo13MALCG21llPclbmrNGNjtO56AlS9Ib9WgBhTKXd
 XyIWQ1KLwJympHFwrzVxcLV7t5l5+T1C6bKlUNsg479GheGqu2h3RIyY43dRKEZBzDVZ
 VPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780398081; x=1781002881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bu2OrHUrdv8mY3erGyGbB8ppYLrym+SFyVnHvC8BRas=;
 b=o/T3jRVvbwmxbOfWjitLuqCqwigtopWq/R2jUh/KLOleKtzN6VVWOpHSyuDbAubsjR
 7s1Xz7jabcX/GmG4HFg1qrCCO0QsOU55riuxobSSVoRZ/xU27qegaWhctuLQnmylTLzY
 hJoL7Y+rRrMb4m4P0Um2DkpBRBhOutx5BTmaBiZdjoN9oQZnL0XwEuWSsOfywRNbB3rX
 H6GvIlREiz3m3uKsn+5SffnL1mT25dctmbE89+LEXGRYFKNQn0gMmQHVooFV9m3dHzPJ
 HscTCkSL1hn+73wYubx/d08IiWl0XMPTtj5H8U4cUy103InXqYJdJcXkZ1xL+DGeYcJg
 cnFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ99tIy7PcP+MgMBxIFcRAIfZ8RBw33MWHamv5uA8dqjM15Y9Jaoc6opnZnokp5mu/eQutI52nkLfto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzj1a079unTp8/yeMPwGUwKz/UCdO45CzinYmeHpbp55thoT92R
 K7+VY1cK4zSR8T82Zzf3PwFrCEvplqxjd3y6AJfh2/zej210h/VjLg23MkQpmIM90lE4Hogi7J0
 NBEKvaN+SjWBUbxi4sNgrdu2F8tQvg+CPkxyRLKuB
X-Gm-Gg: Acq92OH2FM1TZwN1foV5uiBnBsjN1/cc5xDJABmDe2I3MzMI57dlyR7iNHvEAaTUPJg
 8XlihvhZFe3JVe2u6A9ganKCkX9FpJ0GZnB4O21Z/ButG3cV2qh+8fl4+p2BNpQxEiEXd01G7Ic
 PAg6+cTQQVhnlPN6A9jC24LsDJW2TgdR8mqvHv3bWzk0qHB1TWqafOeO/JzujiGnEchsuedutOv
 4U92Ad1im+y4Qzt5/2vYInL/l9kYqoJD3Uy6+aGbfP+kt1VumkDom4n+7eOfw6IjaSTdD7Dc07t
 l6qIRqVbMN/GKmBB9YacYffN4b1U6+/EoRYWFGG+sO2fm6+u8OUL3c8ftbIJyW6xkbhHFMg3+B1
 xRffH
X-Received: by 2002:a05:600c:870c:b0:490:b2a6:8c2b with SMTP id
 5b1f17b1804b1-490b2a68d7cmr31498225e9.10.1780398080374; Tue, 02 Jun 2026
 04:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260529000106.2257996-1-dakr@kernel.org>
In-Reply-To: <20260529000106.2257996-1-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Jun 2026 13:01:06 +0200
X-Gm-Features: AVHnY4JUvKNlcBZ7jut1VhY0EFa3b4OvoHyV8efxn_w3UI8lZJxRLR-PKLgkXcQ
Message-ID: <CAH5fLghfiSY66767FBzDkibD6+YUHXKdCeoYymsDp2i9F45RRA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: tyr: use lifetime-bound IoMem
To: Danilo Krummrich <dakr@kernel.org>
Cc: daniel.almeida@collabora.com, boris.brezillon@collabora.com, 
 deborah.brouwer@collabora.com, gary@garyguo.net, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

On Fri, May 29, 2026 at 2:01=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Adopt the driver core lifetime infrastructure for tyr.
>
> Separate the driver type from the driver data and use lifetime-bound
> IoMem directly in probe instead of wrapping it in Devres and Arc,
> simplifying register access.
>
> Changes in v2:
>   - Don't return Result from GpuInfo::new()
>   - Use "drm/tyr:" commit message prefix
>
> Danilo Krummrich (2):
>   drm/tyr: separate driver type from driver data
>   drm/tyr: use IoMem directly instead of Devres
>
>  drivers/gpu/drm/tyr/driver.rs | 29 ++++++++++++-----------------
>  drivers/gpu/drm/tyr/gpu.rs    | 17 +++++------------
>  drivers/gpu/drm/tyr/tyr.rs    |  4 ++--
>  3 files changed, 19 insertions(+), 31 deletions(-)

Applied to drm-rust-next. Thanks!
