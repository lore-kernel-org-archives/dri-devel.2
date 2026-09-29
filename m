Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD47BCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1956D10E9DB;
	Tue, 29 Sep 2026 11:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="i8QLL7hk";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4258010E9DB
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:15:25 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff9621c5dso21213425e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790680523; cv=none;
 d=google.com; s=arc-20260327;
 b=QWeOcPjPeOARnVU9g14FE8BLqaendpVP4HhFzoS6FQKQW/IY0N1xzhd68ZtcZZy+XS
 VFs4v/A4GGjawkuJ3S3KzL9Ju48ZNkePKZjjkd/UUHShtOEC3ol9wChWW06AoSgl/Z+Q
 mtOw/pRg0YNb0CHkyaX1OOxiwJIPiY2B4NM40UbWAKcWg4gDikV9y9DwDEEPRY+0yLcj
 AkX9zSNDh28O7xDi7U9g2NZKuyUHpwsr8JsYCqza/vna4J4/ams3xeI+pgRNKs0k+tOY
 Um0SszPNrMX6ahc4W9nPzKMeCdYuWtCNRP3AfqS2Bm6dcYHkft4db4YdirnDcHN3e300
 fETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2Cw/IYS5ZpcKxcOuBKXbmCN8n5qb9dlHBJN4F23RgHI=;
 fh=Pg6WuU9yGrOAexC0hh8vsGvnqP4+/36VD/TWeFn+v3I=;
 b=TowzK532PAAhbIfUFXI9RVuDmuK75vHYPEamOO4TU+KmBYunlY09erNBxSNmerPzol
 AKrcg3wN8k76q/115Tm5Atjozq//cwwHy3A+6svOeE2LpMJ2OBX2K4/R5XObGxNGF9hb
 gRYTP0F+jMD2tccYyEK9KwwGRqckA6z4CYCwX1Ib9CZCFxZ6wGMlG/PhcuPaKnRYsJDH
 U47493+Zv8eeO9s7ySg0L61eCEZAi9i4iyQSgqiaQ8bmb5peTPdm0ST84DalmIPtAlXk
 FybMxEdwpynFEWdeCUjH3WIDsCTFwfxNSEjL1wcIssIznRYkr18Vd1YerZPG7KngcZQW
 ib6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790680523; x=1791285323;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Cw/IYS5ZpcKxcOuBKXbmCN8n5qb9dlHBJN4F23RgHI=;
 b=i8QLL7hk3K7rOD/RbbJ2pIXel/WWwh3Q8tzCrzdrPZk1/ZOxSC9wg5+IfFNUtpmqu4
 qfdP3GMg5LLrRnms+wWqrvV8XttoKRiKZGZvhUZYM1WSdnZ4AIUjMJ1FuVudsk57MIbL
 bW/NdrItWeHVfj0lks5VW07//3aD31Lkk9CRe5YoNu/39rno9ziWyO9UTx8tgtFBwzV4
 bQknKlHClWK+wP543Thsy/PE/P15Hx7QH60ZNKxoJhB+DjzKGputdeP6K6EPtFTu24h/
 nop6FV+mNZTHyTO7Cxt11cXZUJG6/ZpskzLJFC97zrd9wuryYxpt9IU5trSMLoFZonLC
 3+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790680523; x=1791285323;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2Cw/IYS5ZpcKxcOuBKXbmCN8n5qb9dlHBJN4F23RgHI=;
 b=eM5JyIOjlkImvvQFhJAdl5t6uSQ0rgb6BDxoRBYqcKRpDoZYl7OMiPC/iTIs4J51VK
 /Hl+yqwSrrgaundxNNOI9qJYh+4EwE4W6dHjYLZRlDOV3wwRigYmnw6JjyeOjqksn6rE
 lWTMfViijgM4y+t3zykuyzVD9sOQDer1K4CW9BEMOblCZhDmJmJBzC+jQ2XDhk698WyI
 V1WSCbNQMZ6B9Kzi77MdvLyu6lpLLoFfB3CmMb6lC+PZAJvAPUMnFXJR0wdcBJ/HRA69
 /Zt052N7fXA5MtDgcUuZ26LJtCG3WC/tJin5KoOrCCK43huCPEPFBX1rawuakRw7kej1
 83CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTWeh4KrZ0XN8UwtWIvwggcyE0IrNXGqwkmvdpazJEnw1Tu+9VovGoB0bxjSINH7sZnbyh7VtgitQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mKiL8CT+GT6oumREB3lDHKNY0l0J/MGkKs/TlDEBoDOAviLdxs
 cQ6xExIZ8q6dSWcGKPKcfIiVPgmvuA/a3dtw08IxYb2+UQr8ot43SgqjK6Xym20CP+IoTKrPc1I
 Xz/8R6ywPmiFThkb7NdEErQ+iJHVsfMoSo9mPAS65
X-Gm-Gg: AYBFou0ZuGjFybymCgygTMZjfujX1lS+JwLUPnEJVogiD3/ZwgL06BuGqSwemsOwID0
 lDkfpqt3lW4TJxYuJCVS28g3sZ8L2ZrSO62d+lXLzdAgRrgp5ncg1fmLq7mbYO1qAjZjzph8Phc
 bLxl5JVgul+D7Fr/4Ym7sAKkM/ODVMrRhwACnJg+zLjQrPR0C+fWUNC1Nrdt2VsBtZLVsEQIb6o
 sp1Cc85etOOl70TZwlt1cfizWSkcc7mUlvYgTK6Y7RYs1yl8Zyaxta9hJVHU69U3st/rGZJX+kO
 9pZozJFaD+7T7nCXgrOwZE/f8enfIj0tE1g3ffoKp8BY8smqom3Bb65bU4qDBXJpL8dcbzNcaKk
 NzSYVhDllGE8vSyGuRvTKK/WBEz+gql2m5FTjAfQ1YFqKbiFW4Z4T
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49fe66f9fe3mr278996775e9.31.1790680523000; Tue, 29 Sep 2026
 04:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
 <20260917-cv-v4-1-547ef5727451@nvidia.com>
In-Reply-To: <20260917-cv-v4-1-547ef5727451@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Sep 2026 13:15:10 +0200
X-Gm-Features: AclHuK9UFcxmG9GmUlSlAWSVdyiMyuABuak7MzbC2Kn8ucmeQP62kVdtbhyOryQ
Message-ID: <CAH5fLgjV=qMfG25TQnTruHeVQkVuitzAyUV7frsx0DyGFA8yUQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: num: add cv! macro to create values from
 constant expressions
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
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

On Thu, Sep 17, 2026 at 10:35=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.c=
om> wrote:
>
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> `FromConst`. The value is then converted and appears in the
> associated constant `FromConst::VALUE`. The trait is implemented by
> NonZero, Bounded, and Alignment and lets values of each be constructed
> from constants without a verbose turbofish syntax.
> For example, `const { NonZero::new(1).unwrap() }` can be written as
> `cv!(1)`.
>
> Add the `cv!` macro to the prelude so it doesn't need to be imported
> explicitly to use it.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
