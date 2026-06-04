Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FB2CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9DA10E601;
	Thu,  4 Jun 2026 11:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="m9k3HnRc";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50F610E28B
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 11:10:33 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so482168f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 04:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780571432; cv=none;
 d=google.com; s=arc-20240605;
 b=Y8RiajZJGpdHWnRQVpHcqCVKZY+h2bQGVoIbJ1JZ7NjumRtWhu5U69EyRIyY1DUHmG
 UpBU6u6DNSSybcSDr7VGIWj/V2qgJDJvakhHrEpNygYiGJpGdUW8hg/fPIZJilPeGNzN
 yRHZrwCswWGix7r6uR7luqgfHpaLhsVl7+N2FGZNbcsjKGE865Cgi6nF8BlQuCsEsR7H
 diUfPRz94+V9VlAYMZqNfWslMvvWhFRvGTaaWd7QRXRFC5b6xroKMoaRvYqiJOmxZANB
 dwjMETAw/uCOFenGz35VNE6KCAADPCAuKlKglnJozKF3RCAcprf8cD5YHXSHlQUBZNdb
 +Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eSci7xLpxgYHSBUqhNqtJbViKyYVOJoOaMBk8J7sasA=;
 fh=nxVHLp6RNbHbZ4r3zPK9MvaLb+Q6sMXd3fdg0u55AwI=;
 b=Q/UYvdnsA1CMhDO3kzLRBSfBIuDVbcNMjPenHKv2TzGqQ2wn5gcSM6DSHvMih1XumI
 vrG5LlCo79ATSfjGG8iKLYIn5cjzr0RacCVaUJ15pN19qeg0guzU+ZDIPky+BaGWs5qs
 SDqaxjboscwigwODztJu2bP0nxwNKyeCBzPxGDFi4epUq1d8EWBbNW8gzxxpnHwl78D3
 RUPnh5kPYFeC6q9HJacM6lTq13Xn91+uXzWLc4W5zfSQwYv65ldgKBjVlCqs1W7XZJMW
 D+dzDxYGMYNmc6pEIpUonQQBI6PT7+fGHKQ3kFvdThahtPjVU7D/dEsJPTuDlYm4Dckh
 aIBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780571432; x=1781176232;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSci7xLpxgYHSBUqhNqtJbViKyYVOJoOaMBk8J7sasA=;
 b=m9k3HnRcLqoGxakOmA0nk66f+Roe8DzaqLFrMY87t2uKOGRMKHEDXiyJLkxGcDHxsw
 o4t6pO7VR1DaDiYh0P2k7s6wvyQQeN7GEu+t8yos4F+qanYoNsk8++Z4BDXraF1rDkPN
 kusjoVfHzi22xMdDwpmYdoy/vfViJnRjjWYdx7iiw9/apEab2KiqmBTKOho49kpZTYFa
 aedQ/apbhJEF1vSj4FFlRv8cWdkOcZWpG75Nle/0NHLKBD46YfaRnFHMmHCI77PrfA30
 q3IhkMffIf3MWGhiJGn18uW+P/zdnhv1dRtrPUrU20smzRMkI6HqghbEuXhD3eavfhoO
 p4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780571432; x=1781176232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eSci7xLpxgYHSBUqhNqtJbViKyYVOJoOaMBk8J7sasA=;
 b=Ur6W3JoJJtT94sBq4uoAoau0XYZpeq7cs8wG35sLHDAtRR9vq3tlHUtvbKoq82gEu0
 spc7hZVNMM8mxj7dGHTeJOeKiNDB74eNkXk8/AJNa4Uz6kC1dG4nquN65uclf1ghjPdF
 XjH56a1HNpB1ARmyPTqtGKSZRVPsfa/QA2QZCEH1uAcvsL/tDCQvzVXZLYSQgzsyJjjp
 Af5la1YyFNta1fKRJXlPrtoYEKtRHbYeph00hdCahX1UcL4a4n7N0xkq30WVA74qblhf
 fOBcQzxFroBnxriS9xttToyOn46k7AUXImc1UhI/ANnVSlLsAQpyXPSwNb1RKrB1oO8o
 NFvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RV6i5VE/+bjT5rjYXv6ML0LjOoJzd7ALhZqBUc7CYteBwS4wgV6FXWfYRPh+AGpz59Znec2qunIA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGDpMlS+DUTEekIiYBXEW0pyPqzrNXAcdKFiwul6IQ/eGG/o1t
 Dq+QHtyPwNPVsCENZDMLOSIDKJk5gwEDbjFQTZRFziJnSAuEApOtQ395xHWOWd8ccnjASBQuof2
 vDoMjHT0uy5UsI07l/qBnOFlbR3y7QMBBxPKwNzbc
X-Gm-Gg: Acq92OEsyVsielMgPzURhIzGGGqAV6Kzu7XgVkdZwrJwHuofMp5mXDL/F6laBVxG1qL
 ZxVD+jkAazBnZuerdpKLFt1HLt2MrHfGU5G06XskAY01uhdTKZjRNit6Nqx5YXcc86ruXqklzUe
 PfJElWw7sxIL1KlZ2wAxFxreB5dFqq3D4GHHib2krWQ5UI5D4DAoKqdy59ao0upYcxXPwzarV19
 7SeBxSuKUNdDNjqUTtMJoYIOnYM2YhUrg5PQ9B1Qe9dx70Sr7l/zspclbG/XEmAn4fI/cI6Nypw
 MCiKaiCEDzpWrosahzdzU2V+X01V7L+MvAgAwBt9yRjWGvtcSQc60FjNr7s8JfHIqp08ex329CA
 G6yY=
X-Received: by 2002:a05:600c:4fc6:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-490b5e95f44mr117890035e9.14.1780571431900; Thu, 04 Jun 2026
 04:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jun 2026 13:10:20 +0200
X-Gm-Features: AVHnY4KT0fbb0zrOV-n0xIWvnd6M6oIkQFpOjNPef2gzJpQvDH0c138r3Ikq7Iw
Message-ID: <CAH5fLgh8L0gshrfaHWxdAqQMtXY5XEm=TT2cx6C8W519Pj3+Jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Rework index projection syntax
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
