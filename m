Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3AAC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2A810ED12;
	Wed, 19 Aug 2026 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U7vXjcRT";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146EF10E42E
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 19:51:41 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so49752715ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786996300; cv=none;
 d=google.com; s=arc-20260327;
 b=U0a5Vjl/MU3JL3rGdlUnAyepwQFZApCN8ZqDIApDS1AgHyXKSDjU07t3gJwqT4ecSY
 8lkwQFjn8EbX1J24n35c4cBFfLB6lsZ/aI9EuuMYnWF4Yd6XmJp6yJKJVlwyTVnWhs4t
 4NmoNPHU0piwS3xPPLO7cEV/VvrQ/hiEyow40D3ht9D45NrvfF71tWe1nQXXCKIzFTmv
 3gWt4ZjTuPpkbr18/XYweswp/uAfT3z4Ph94pV+i/B56yLhxid7agQUb00Yr+SZyBNAp
 vM/k2uQ28cm2pBgHgG97K2EpAdf9VHzr0FrCen57hgCtGI5yDiPXUKKLK22B/0T8eJLT
 KyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ABSJoD74NOKhQ+UOLggD7tv8RbunARXUT6aVeIs+z0=;
 fh=AtG56YTDzaTTJhPtDcbSxwF8+ftbwOEbE693jBUpF6Q=;
 b=GWG0FXfY/4vzhS0PNhcKrsCxf9yxCwMhKAu2jJgcLn+q/uy/q8D2gLDF20yDgEMzyC
 sjsN/ij/lRV/bjEGwyHiC6pEMCXzOOrOJxqy0Phv1HPHE79GhKTVBjPAkaIy2ugrDo7b
 DUs2dq0lCMpkbI2HiwmFfapjE4NJCp70rdMVlrCaktrt9q37SXBMBw12C8ggjVG+bfjv
 F6k32zn0sxmmmbQIsE2xBp3k6uf0Q/O98+rj3d2nb7X1y3/07GBvjzrwLojz5qq2wmaq
 Z/p4LAIo47JC///4Q3XwKfw86ajc2XVJ43FvlLnN657QnUwBF5hpXj1eJ6c+XqWRCPny
 7j3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786996300; x=1787601100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ABSJoD74NOKhQ+UOLggD7tv8RbunARXUT6aVeIs+z0=;
 b=U7vXjcRTLO9u369M5Amc6BdOIJNfj3mXlig7ubsDP2VY3oWc/ZYfxqtsxvm16eFdpO
 3woZ2rYgBn1ZoJB2bH/ztmpPuzRjnZBBux1XyxZovFKUTgJ7gnuH92kuW/Yx6HxgDHD0
 VG9iaXx38Lqbz7IoSy9mSnX4GFGKGIlklRKX1GgTAHqiH3E2//yd8gkqVgIBPb1IA01b
 JNI2dJqqtr47jNSRvA2gBx2TbTEFxx2AC9q6tnYFbmW7PkPwwdmFEr5V044JQxeKSr1y
 jKnNGBma4VEI95F3r5KvV/kcsMSb0hR2MosawBNVy2DE7D0Q6gbIN6BJKmMXIU0EHQG1
 uqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786996300; x=1787601100;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ABSJoD74NOKhQ+UOLggD7tv8RbunARXUT6aVeIs+z0=;
 b=VuK7a3nytaR4Utz6x9vGnERyGC7gJpcOWu0SgZ8raq1Y3lIkCZtrfp33McItdEKUYY
 +gI/OA6Xd3g4jqWUTy8akNYhaugWC5Kw/W2soz8cDLzZY9DxWFaSZNktoGtaZHBfa4hf
 pW+hm0AvZsrNBf11evkz3uo2XnHwxhSAkU3EgnlK8wQ51BGYHVi0Tq2BxS/Sf7zv2ax6
 +yZiWRWcMiYPXtqDjEKE+loCconN4dihRa+kYlKQ9+McAt34lLxGds7lmQADB13rSq8z
 nDMt7L93aqMCI1XwK+bhSTfHadF49TeyNmXfVU3mQEhFQsvsJaiW932FRuKNBP7qvYBs
 QDRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/XgVg1yVEQ6B4Bi/vhxCjEp9/uO4YMKHGswXEY9DeNWLPRBQs1UuRVSxsQ8VChdKNqwHFsQHRPSM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwG6PgGtsFQdrldsVpKCCM0Ryss/H2ZDql3uVXouB6Uv87jlkZZ
 Kz3b7HzG1+CwRhrVuVY/wTyejxVtxpIqEjJ5SLHvZOSj9zHWRPNoDkGdKqJ0GsewEdvsHLd9Hyg
 8d8CgyxkTyfrUM6LB1qWpOVS1HI3rD5A=
X-Gm-Gg: AR+sD13vGbVnm4o93wRRji6v8dtVczuMKWqBsp0Igv/btWd0gXlGaRAMSrGn7oD6JcD
 GMonv4bK+A9lxKVPwac72826/PdrgfyC/vJUyi8sInLTDaeyc/IbK4cr33TbDwA8jR7Oi1ncYZH
 GGa4NIA5kCEh9A0N0DA0YKvNvgbo3jewXnKPjUKCLaA0M3ylnfg6gdElz2P3g0IFACR5FSK7kXx
 9QMWnHmJErQqtHzG+2lglPATbVcj6FXX3I1cZCE+inSFC5mgJSCsjP+t9riE0NYZWnHDKYYSqin
 QachPDjGsxg/luNTPkeDNT1OT69dkx6mUYjynRSY08RciQ6bxQczU+0qPP/PSU0jimY96GjjnYA
 r7QOQ06WFyL+UwcbctO/ShxzQK49yfk8=
X-Received: by 2002:a17:903:3905:b0:2cc:aa36:c046 with SMTP id
 d9443c01a7336-2d3b0c5dad4mr315279655ad.14.1786996300433; Mon, 17 Aug 2026
 12:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-2-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-2-a5872e64d8f4@nvidia.com>
From: Burak Emir <burak.emir@gmail.com>
Date: Mon, 17 Aug 2026 21:51:28 +0200
X-Gm-Features: AcwNN1V4RUrrEQgmScJR1GkvVYLA4gn02X6StFpnyno6RAn1uKgn5cwzljFUwlQ
Message-ID: <CABwQupP-qu9S--ob82ZPDuiNH3LMwqZpjZ2LENg3hsGFGvr1Jw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] rust: bitmap: restrict bitmap length to at most
 i32::MAX
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
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
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

On Mon, Aug 17, 2026 at 9:04=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> It is currently possible to construct a non-`BitmapVec` backed
> `Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
> it is not part of the unsafe requirements. Restricting all bitmaps
> (even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
> simplifies a few things and matches `BitmapVec::MAX_LEN`.
>
> Add that requirement to the unsafe requirements on `Bitmap::from_raw`
> and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.
>
> This also fixes u32 casts truncating in `copy_and_extend`, which could
> otherwise lead to OOB writes.
>
> Fixes: 11eca92a2cae ("rust: add bitmap API.")
> Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
> Reviewed-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Burak Emir <burak.emir@gmail.com>

> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
