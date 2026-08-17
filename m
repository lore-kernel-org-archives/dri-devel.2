Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8521EC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651AB10ED1C;
	Wed, 19 Aug 2026 06:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0XJqZjF";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9852C10E076
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:40:07 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d032846c95so56093415ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786999207; cv=none;
 d=google.com; s=arc-20260327;
 b=GIelXa4+bWemSCmAzFrTJMi6jP7Fg9DwpWGqC72sjCp6KMh5Y0rFM7/M0wM9Q5wwg9
 ygMeuzAl+BRAEc0p7+sPDGUKkkMMP4beWBfQm+77SK1ZRlQLXmJrdsoJG2zM8Eqpemjt
 ImFK4Z/Z97PISZLePhFB6LlhZBCBPKbo1CwScuBRctGWiCpxHqMTFCzMeJNtIerbVNUG
 H+UEgEO9QuudnzzG2204xAkEVvBe4/Aw6WKlwGBIwQboNBAW/Fplwqw1Jm5zCUl1/uP3
 +maEkTqYny0NcJwEqzZrgYUmj1cqoZbEOnHZAnp3ramGfy1yPrky0eweKgyxtLeyGzNO
 V7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tJ3MqtcDmZdkhQroQUtoHRF7FRZVKalhzLPmlyTLoiA=;
 fh=lRqbZLPUnSWHxqZ3ihxMFNch2Rch70ZpBbIdUn580ek=;
 b=ae+OXq0s8aUoHeSoALz/ow4zLF2E3SUymn+x435w7pdcA3HOocGsYjlmgslF0wF/V/
 DghNHf4kBwghdLRW769ldGRVJBEvYqooGmgcqQJxJYN6P0KhuYQIV1QbKIsxF0VypMZK
 GW6fxa7bg1DN5lKtO3zQCze4TjIdDy9Y+AUY9moYz861AkKdhV/ut6PMoIcwRALZZRj/
 eOkstQjxwRjhJFz7uLeTJQNrk715eZ6k+paoPMCVRglBJMs/n6YUvutvb7dcmZFUrBPf
 +Txt8u5vYMh1ToGsYnAykuBIiWmXvcFFH1r5aF9u1GifzWCRqNfebqTpaM4Bc6ihyT9Y
 vCsQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786999207; x=1787604007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tJ3MqtcDmZdkhQroQUtoHRF7FRZVKalhzLPmlyTLoiA=;
 b=E0XJqZjFuwxbNdd8xlE8r3E3gwvzyC2xyoOo3Twx13F9qfBNW878EerzDT2TRNtzCl
 BeLX3DfKs2A/iYnDYa3fmljFFWrgcqwf65nh5V15myqhrd7YKsQ/SB4eUTsOcqwMwapB
 BrklCzBjDLQLOECJ3fxG2sk3phbHBAMeRPmGKAoSYGvgsIJ/meue+nx7q0X0mZiswQCf
 kJZX4kehe14eGVNBFhsTCEXNhjl3XLDJbdj/LMg2cUTm/IfMKXQJcZ32tlygx9juG9uW
 vA3uiafahJaiIk27w40p6xo9YFcb806rUvser2rp8Io2LhlVqbzCI64X1hw4HPUIAkAQ
 yPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999207; x=1787604007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tJ3MqtcDmZdkhQroQUtoHRF7FRZVKalhzLPmlyTLoiA=;
 b=Ssxbn0JicOUfZT9pGsOGzJujUplLhmBJ3b01nHLZEiI87VzyvgJpy+9KYPjrzVLMC+
 YDjvPjYKjANBW2a6tmQNsmjfQhYiHpGn5OO/ee3fTia7tOzBIFCNBakk3yzCbj2zboQ1
 jKPbgAyMnul66srL/qI8wHnkIaG0tg2DtDveM4xHphljBDOHfE6oYfYQkJ6dLjIyogY9
 WnW6+pxqj/jWzpHgQTMT2ypTdDZuqC4HtJqmIxS07Dx/pTGfTD+f1wdutUJDhQ51gQyz
 Etor78Mh5pv7EAiQkNyD1l7Xr9JjnjlZpAf7J5CHYdxKYRZoBkE4fEZNpLihuFBYxbP3
 0WlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUUh4pLr5hsPIkXGqdpBZCFVFT+12yFls8UxekenXGBkv6J6IOFQRQBDJCVBKtSFpTYudHvthhYnc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYoRSGnIyiknMU/LN3M8LR+3cKKoRs5PBUtdFaMKuiHz8mf4oV
 rieFNQtiwy75W6jW1HhQ0NqjB93BZK/cWgIvPNfzoi29+u2uCUdj2xk6Gf9i1UqAjpKTD6Xlq97
 GIEQUdxDcOIeHHZKPkIYLvuk0y3eRJm7JL8DOoho=
X-Gm-Gg: AR+sD11jGFN5gB+haCmCv6GPnb9/86mJsGbnVPKPIWqY+aguvDjDnUN90YvXDeMGg1u
 r3o2GPk0+PSiM/gcqFelmZVDRbdnzLrP2UDPXS1IYY1FhGS2sGh0JkWrqgiiZd+3cMmgIiNvmCy
 00hL52EsR24+H3V/MDyABZsK/b7/690XqeBq4Bc6sIHk7IiMqHSP0nsOZAILw3B8tF4mAnYD/n7
 6KdiLd1N2Osxca1tbwmi2ei5p91iavfwQkG20pBjsuVme4v4cYZE1s9bkJrGiJMMOgdPDpv0zG/
 D+P+v1BXEQrK42NRuTiVl9NyswK9JDNBY0v2WVeMJlkg5qCw/xb31uaeDfKq/ZlOfSxm6W89q2i
 GQoYLrfz3alzswT6oK/21rsC7GGLRhg==
X-Received: by 2002:a05:6a20:43a3:b0:3bf:9aa9:b2a4 with SMTP id
 adf61e73a8af0-3ccda966591mr3211458637.20.1786999206862; Mon, 17 Aug 2026
 13:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-8-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-8-a5872e64d8f4@nvidia.com>
From: Burak Emir <burak.emir@gmail.com>
Date: Mon, 17 Aug 2026 22:39:54 +0200
X-Gm-Features: AcwNN1V3e1yEbV4HQwbBf0qIGYbj3GVTsQ2fE2mh4DfZX2sLIE0e2kB1-JqFpmo
Message-ID: <CABwQupOweosKS1hP188GdZZrik9E1Ab7r9DZBuwnO6X5zD4F-g@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
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
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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
> Current code in IdPool::with_capacity rounds the capacity up to
> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> smaller than this and still uses an inline representation. Remove this
> behaviour.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/id_pool.rs | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 382a5645767f..3e7c3d0c9dd9 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -115,14 +115,9 @@ pub fn new() -> Self {
>      }
>
>      /// Constructs a new [`IdPool`] with space for a specific number of =
bits.
> -    ///
> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_=
LEN`].
> -    ///
> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>      #[inline]
>      pub fn with_capacity(num_ids: NonZero<usize>, flags: Flags) -> Resul=
t<Self, AllocError> {
> -        let num_ids =3D usize::max(num_ids.get(), BitmapVec::MAX_INLINE_=
LEN);
> -        let map =3D BitmapVec::new(num_ids, flags)?;
> +        let map =3D BitmapVec::new(num_ids.get(), flags)?;
>          Ok(Self { map })
>      }

Could you modify the rustdoctest unit tests of shrink_request and
grow_request to cover a few cases where capacity is < MAX_INLINE_LEN?

- Burak
