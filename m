Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A67C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5372210E33F;
	Fri, 21 Aug 2026 20:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ysc2aeAl";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1B510E33F
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 20:07:17 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7e9f4ab2a6fso101219a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787342836; cv=none;
 d=google.com; s=arc-20260327;
 b=lj2vsmHpqzj3tS/8Y0Kv3UXclhPYDf3smpKXsHlO6WXC7FVsR/CPZGgtDeotnpolHZ
 5HAXYoGJP/9nCwScUD1qdGzd56or9a2HO2ioIOPhDB5GtpGjYRJfe7ayoz8V9/I05VQj
 CPE8CGf8i3fPZNAg/D799QsR5xecLXaCyb++iohF/aP1iOMzKtAz+2HZW7h4fRfhemeA
 Y0Q5SHH8H0uhL+Hcf9tWOtWHJ8Nqv8toZggsT5RjimPaneTSuDLkMdYFKVOQQUQQE0Gc
 OD1iftsoAI8YEnf3Grl6JQy8Xi3St+OVoD8dEQKxB1mQWbwWJr8UtNNZ4eH2NWL/R2mW
 blsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5nG/DZhGK8Y7YLUZZ+pZCC7PZWOsMHI2qlWWbSO6I+w=;
 fh=HM/iPt6u2HLeXDccmstOQtnmyoOeWW13Ny0VssJ8q64=;
 b=iwcQADRSbCUZNPoshAq21wk32S+0AR5Cc2E9k7xoQgDNUuacxdrhIFfO1yG3AlFTHn
 dWbEp1VxDvIMjN3hE0raSRW+i/lOZ4Jdr37rjQtDuETf6vYQP2T2opXfQWHjBDTaDk27
 JJc01YlUgE2Ih1LRcHEDCglhl1Tj+8fHeJ7IzZ6E1c3HTjV24JgYBNlwPPe887ZeARYI
 2TYKlwbBPw29q1aaQWgYvb8pncw3lS4eZm8iJ9HYXAl0LOa6igw5hwpTtRvIVt64SRwf
 nOlC5jRimK/cOKursl7868swv8izppKmpsCHGOnDgsaHgjf6EKrAyzz4Kzm3o2BSCzUN
 0y1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787342836; x=1787947636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5nG/DZhGK8Y7YLUZZ+pZCC7PZWOsMHI2qlWWbSO6I+w=;
 b=Ysc2aeAl+dwSnalqn6wDXImh8XgVRVqVTyyhKMoumRIEnSYGL2KmWSwxFO53wRahZQ
 UeDHfMZmmp9wrPw01cynDPIpWxN8x9KKrx5YBm8cphQOipuemqYb7ad4E57EIP5BOtQV
 dyRThmA1kcuYpJO43pZ66zt4U+Cv/dC4XoZi8tYY6sF/fyp3hJ77f+zcOm6hiPl6ba6F
 qcfn8MW0vENOwbYyDftg7xqQECJhwS++SLEhvA16HtNSdsQYBh0xR69FjtzBx5Sj8SZd
 HJHUrtSlIMVHSPvAV48bITcHT+Hu1STPAiGyxYEQShMcHr6l0afMXkHtkmKRWTIRVp2W
 Oi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787342836; x=1787947636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5nG/DZhGK8Y7YLUZZ+pZCC7PZWOsMHI2qlWWbSO6I+w=;
 b=o9SNXZ/LlhGX9SW3NDbl1toP34aLa0asd6MFFrBZeRLJdNBoqZFb0FoB588hTzFQRz
 tnbp//6rp6kgd0gZvaRZQmAq52GCcS85dRBJc07TBPEIL4OmXTqV5UlsWA+GXWn8fvvF
 0TE+BXv5vTImnj7OH+cCKy9nzhwYS44YGBHMn4SdC7ECnaYYvc879DuPFupXLH/LFGuE
 keGZIV9MnCsTYYfC24B5AoqX3CmDZJukhTi5y3lpjvSYIsjBnzksV37gmCNAkcXyogAh
 3cKdl36jgxO+/HEB/jZwrThQTYNoiIikZg4FbV/osCoK2cs7yz306QRs4GiwWjJnJNDo
 bIbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpZRw+Mfb2n6WWlN+vmt4okwTiH2OZujuBrDUYS97c9A7Ixrg8dTAoyTBm1f3tJqJH1y3SmdhKon8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi/p9VwI2FS8zE4dC8kV/WKX2pWcYGLEuCgqZpatc+5YTIOhiL
 ONsYobCsFa3+O4A+DmpBQQcsmdFQyaWXjRqSCrxSBRBNcAxAGUcgY0a6Lg2HGudz1CZYXM3Tm0T
 ueJ2kT1bFqcspn8mmncSCypRcLVhySGBW/BdRNWI=
X-Gm-Gg: AR+sD127Q317P2muuapk4QGFf7T21KYTOpNU/nd536wdq3Vz3Bb7OdsG3nu4VMF+4mG
 1H91e/fqeRLaUty3qR/aNYxm/Aw5vV0w038UNb/3QwiuAHURAjn7uW1Z9xk9vjvVux9Nf4LaiLU
 z9Lo0Xv8FZtdaMMDIylzlCXttbzW4MDxs2KB+2ep5ycHf427FoGqLsTAWEYH7n0OITtYxueIA3n
 Io1/ZtMv6qpJu73UJV8UMRpRPgMnswegBuC8PTaJgb+X01jMkbIUw2ubBTKbGAhoaDZsUGQjWzE
 cAelX3DiiNiHU+Nowv5qGofbWGnzl0TrLMH4rlOFIJHVuR+PrBi5hBHy9uQU/P4t2yKjKqFaANh
 xkw7XaADm2289QESK0JxbmCOAU1ESl/3vdYa1/qytX0JUhwUKAXtqTShLhKwVGPyTfScGVIM=
X-Received: by 2002:a17:902:ef01:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2d64aff2aa4mr82872185ad.2.1787340944584; Fri, 21 Aug 2026
 12:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
 <DKUGXCFA0Q77.36Q64A1AN6FX5@nvidia.com>
 <CANiq72=ot1SVQRxzX5NmyTspzf-eMKca7DQMdUMSHtThn+kfpg@mail.gmail.com>
 <DKUKM1RPFDA7.1MBU5EY40OJ4J@nvidia.com>
In-Reply-To: <DKUKM1RPFDA7.1MBU5EY40OJ4J@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Aug 2026 21:35:31 +0200
X-Gm-Features: AcwNN1XAwQYarkYaZO96R1zQNSWSUsItJpmCPtqUwSLujolMS-yXhhZvmEccbTM
Message-ID: <CANiq72=sti1OfTHzGWGE+EJxqBf_k73QFy=G5HwowSF=xCwtmw@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] rust: bitmap: add contiguous area operations
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
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

On Fri, Aug 21, 2026 at 1:04=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> I'm not super fond of the different behavior introduced by
> CONFIG_RUST_BITMAP_HARDENED.

Yeah, me neither, although for a slightly different reason: I am not
sure why debug assertions and/or EB cannot be used for bitmap like
elsewhere, plus why having a custom config option is needed just for
bitmaps. See e.g.

  https://lore.kernel.org/rust-for-linux/CANiq72=3DtKVD13GD2Bzmt_LnC4SiOX1n=
kHQPcz2BS=3DP=3Db23e0Yw@mail.gmail.com/

I think consistency is important to help maintenance and to reduce
mental overhead for both contributors and maintainers.

Cheers,
Miguel
