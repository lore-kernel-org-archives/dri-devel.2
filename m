Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAABCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7545910F289;
	Wed, 30 Sep 2026 09:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BS+48xZq";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FDF10F289
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:12:35 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-33bc6ff6cadso716026eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790759554; cv=none;
 d=google.com; s=arc-20260327;
 b=eClT8/DgBA0MA077Jw886U4Dib1AbPp1AWnGS4u5ZzwKpBWoZLOJTG8XBbWBQ58eeL
 L4aQz88shPBat+i0xIS35Ckp5QRnNNsjvYM7Fa6Uhx8LctY67G2yOX+xRpvXRrBDjKay
 HOK4285/4eAuaEdWQetwh2Lupo+QsphU1XIi0JHzCrjvmJEjnDGiUiugg1oIwKkfNFS/
 2ofPtqnuVjPzkt156ufJpLkjCwxhPZOHlyvXyXshZNLROnia1kDQX+Ka0DNa1i5A/pRt
 ru/7bVkgvzh9wgJMtbg/JnbvYHbmOW6YlvQZBIu3Y0zdMJulQ77jRoaUlrMe8GvgNEbf
 PfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3sCYKDjhxCoL+MufuJuPd+TE5a5HbHhTgY09VgieO1Q=;
 fh=g9r7U4LG1kkBarAt9X2f1AWYLz4S+OSWAkrg+usAnFs=;
 b=UcefGjbub10tDHmzLOIUJaLzHmtWOLgYN8gjBXdqSY9HkGgaN6U59vMwYQSut2JuEL
 V4KZuBOqnEce62L1wGNdSosEpkitypRJzToetMYkjF6aqmKYH6aPY8Gc7f9ZcMBywK+Q
 NeWm8QvikVs86n62wwjMuzNkg//I3Gg5NVoTQLlwkeVPuRHXdIrnImgzHNd9gjR5t6/J
 wtaIH1F3QrKDz4DaN06+XQsRtMVp4MN9teFcqD1GcCQH4Wno1e2OnBG6iua9mBlUW9Fv
 L5q3Q/iRAHnrJjy4qrkdHGu+N1mDi3vSBCc8MHyT04POivLi1AcsMJBk/YKlOLybO8Bp
 bQGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790759554; x=1791364354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3sCYKDjhxCoL+MufuJuPd+TE5a5HbHhTgY09VgieO1Q=;
 b=BS+48xZqh3J63DrLIYszittwHdboneFDNbQlVsxrZkKByU/VMf1EMNhggdlfnxTipd
 8BVucSW9wSVBdnFl/Lgg8Du1ubR6FNqGWCNwb69Cl45+vNgM0XrkVlS/1U1Q/HJGsOZ/
 9twu0Stex/Vkgdcs1edP66rc47INbPuFFykyTD/xz5gDBxJAUUsZMDEaQkSzzAivWiI3
 Zdh8eOs9+KFG3rPbm4po9uEoJMlaPcQtuHfVr/jN5YKDK55nQZrCEHhWOAgjWr2f2gzx
 hWs77P7UzQAJsSRoPOQXFIN6RwP1YpySNdVwG1CzqhSbwXY8HOZL3Gm7ApvYsugqkwGT
 QM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790759554; x=1791364354;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3sCYKDjhxCoL+MufuJuPd+TE5a5HbHhTgY09VgieO1Q=;
 b=KtNhMmODxh4Eb6vUUGnZ80fwIZ9yfZPJ62dcElfGBGuj5ooH8uYK+iVm/x0i+6NzUD
 vnchSfBcic85pl9FZAGiKtm6bPxMVyf+VG/uW5VnScsoF82ArH3QVUqugu/L/b+/wiJk
 VomImQQNXJyj3Bpso6kBo4EVMHmnxQieDEOYU8MbOdG4E7AWVSJj5ZBWrVQHE8yDb2FW
 CGp4+SjAEbYvX/whhoZpnsifPUk8Xb5Ad2X/mjoap+88ZqAGI/sBGIYJWUXbjgrj+w3l
 IQ4kxiwc7wnK47nGvUK0BDOThMNWmcb7Qw2QhEoL0ig93gsHLiA1k0h1lyNcDxV+Ajhp
 RqFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByUThf+T+KgTH6XN0yr24MZ6Poki5zzxOVDb8bVEg85I7Dl4ZpY4NMJk4xbVLuHYN6o1BtvTeuoSVs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJM6/l8CEr+oK9tZwxDqsJJFaS586YXKcTW/A5AtATQYoQst3zy
 4wgwKCncdPPBbsL5K/vkixrLOHQCC7+Vv4AzOZ+6KnUEsCnOTrYU9bBURdU7OjcGvdl4J5jmY3x
 qbn6IHsj9ijkuAItd7I2Pm8bf37i7WNc=
X-Gm-Gg: AYBFou27LlF/IRPATiCu8eW4Fy4pzC1ISiVXhLS2KRtJXkxXNN839nbwedFytmGK1CM
 R1djgWor2yRnlV+mIXvQQkhBKmts/M08i/TOoqQAEN1WBzKnH+jeSvQk29cmmianMMLJ7XCvSJH
 GJqj0VqURlmSAjSFW3yBpdRaFnksrm8Fg4O8f2EPoBLvQpv6XHN1pnQGPO3srwUF1NazczJkPe5
 pFudviNsiJQRXf2eqXRTD9Ohpeg91069RyVHyEGeXmm50Fh3qvIGzkEGU8H0mFbq84AfISuit+D
 X4UGfo0A/72iFtQK2nqc/CTSj8wl+TC9+6b4XaBbborhswUr9SUtlR+lQFXnzWekPJbw/QClc6q
 bBKp7TwApVfPdVAdkQa5kxPfUvNQbAe0X7iK8NBF00rXIerW3utNVAQSnsTGq6SMOaAv3tDIIkS
 WkhyLdUEBdE9/BkoJJTpwynPfx5xJJ+Ndz6BMkxIJk14AeGn6dkC/CzCNH4aSqaA==
X-Received: by 2002:a05:7301:1503:b0:340:f698:fd56 with SMTP id
 5a478bee46e88-34cdbecb18fmr1744208eec.2.1790759554357; Wed, 30 Sep 2026
 02:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-3-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-3-0d6cca376cff@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 11:12:21 +0200
X-Gm-Features: AclHuK-0KwyFg0Dwivk-_8qXi4qsCxM4xdJVFSz7hSpIH-HUHIS-SB0FCeiFTpk
Message-ID: <CANiq72kcqVfvVj_b7KTHKrCDj63LMKpsfP30zafoYB8c924i2Q@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] rust: sizes: add sub-1K size constants
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Wed, Sep 30, 2026 at 4:44=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Add some more size constants, mirroring include/linux/sizes.h. This is
> useful for making `Alignment` implement `SizeConstants` in a following
> patch, because these are more common alignment values.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

If this ends up going through bitmap or DRM or similar this cycle:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I can pick this one up this cycle.

Thanks!

Cheers,
Miguel
