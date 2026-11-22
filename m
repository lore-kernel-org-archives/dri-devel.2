Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF9606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDltX53V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E010010E3F0;
	Sun, 22 Nov 2026 12:38:08 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7033710E445
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 12:38:02 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-53639b8903bso31695981cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 04:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795351081; cv=none;
 d=google.com; s=arc-20260327;
 b=RytItYp/tqk3Pp3THolY8Z+72rPk/uzgFdCkcvRuWH7Xp/EuANfcNK2X8k6l9ihpix
 Xpo4rL6C7PbJNtyNcPVqCrJFlFyxVwkDQu+beEcYu2T+yWvC5hrBRV4fRU+Maj63Kmdd
 jrIhkUsLffe4wDyiqwVuRrpv8qoEbumJqtoUkRP+Pb+NG0xsHw+2aQeBmDXgZ0LoxGs1
 SuO2h5p1pyAmzpISLKyCpERBb4UFxatg01+J6vFn63D7Mm2VzgOWFhSW3KooDqkYudjz
 9XESnpkGgJts/3d5wUz0SPKE1JbdVZsVUgf24OL+osJGTPUIg6n0M0LcpJ7SIdch48G1
 Wmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sSxa9yEgOlqZ63H+K7FWjY/eznutom2udTRUeQVQF9M=;
 fh=FmGg5uXl69wghfJg0cZJuJD/lcJc0qa+TM+dF/Vw5Xo=;
 b=IOqemcORjnd4TF0KIrOZvaAmVlplxAybxS9vdtNgGP8OdXpUetHYI3CGraeLNKMKNz
 Fyi6R+v/i6ioy269/63ICjBm+3j9FVIiKezXygMd8zKepGq6XGroNwB3DC8FVVseNBGR
 G+X246Qz43YaFAtx+wOl+zm8HbFatj+AMfM6OxJwb4tL6D8Jc0dJ7O1jgb5kUKxQxOBM
 5Zr38gjUfZDsBjpYORmn+ZtxhRykwix1Nv7Ed6C79l2sdehdrr0+njk8loVppQeJulMz
 4FL7jkMf+TbDgCKo2cT20p0lwZJzb2KLrcNSgAsyc1CQ+ydJOnyKw5JIByIi7tP8hMFt
 WnVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795351081; x=1795955881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sSxa9yEgOlqZ63H+K7FWjY/eznutom2udTRUeQVQF9M=;
 b=TDltX53V1v2fXgJO9PQcWmGNCi8z8TzHwYb2kXAxf3HswKZ4fq4+tz6cdOlz6JDQij
 PtFAkNGJXJdqT/pl5TG9aR+bRVrHT/ZAOZGMXaMw/Y6aljY08mo/cH2XfmX0X2Pl9pWN
 zyj0iLVmr21sM818z4sTjHt2oa5b/vgzVvMKgOMguBKETFfxkDuj/psv19KgUPT+c33Q
 d86HCDJ77Q94SNkwb2oXGBY47gARsCu1jx/0SUhBBF8Wtzqonk2cruk5Htkr238WZ8/h
 bRcEK3dfYBBm88tuiOmkO+WWH+o9iKFTOoVo6RJo+HN2TXe7PVEZt7NGqhl3BfBhR2w0
 Z6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795351081; x=1795955881;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sSxa9yEgOlqZ63H+K7FWjY/eznutom2udTRUeQVQF9M=;
 b=Rx5SRcqOgscXVtiJ6gUpxqSXARgvAsO+kPRfXXRzQ3oh6eDzn7LBQlY/QM8AluTPXp
 5ymIExRsY5zSKmAgu/IM/iW6ZDwYRIgCEekE6RIHdzHEVDPHY5mj1wHm4Wsh4qSdxiBP
 rSvgRo5fzUeFppvNPUjEboovRvwj0alTpgnst9YoYSl18v8NYbTSOF+YpBfSgrYTbLpY
 p2G2XnXdYW8rMMPe/wq9wL1Wyj9KdUh95ntHCfzI8i9u9/tpkAThbbmaGJvZAqiTHoly
 ULPT2zKYI3x2H96FQDumBTYPOYl095Rj2EpLpv3xokxypbEChrZvpUfV7KvJfXQMw/0D
 U2bw==
X-Forwarded-Encrypted: i=1;
 AL+hErEsopLNdY42flt0vlv5ltf6ygcAD5H0V4nJ/peH+51jRGxxN3qD9Q5wmTyAGDtVqwqyqOQcUpXeuog=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/odj/ULQFzF0b14wyKUCFccTAZHthqgQzEn8VtUu6GyXfs03RF
 jL0+71UfErcVWJCY0xxMiGYRs7PaZgg9Er3t4G5ItlF5XW/IeC/kOYNKOVpz6lvbGszrVKDLD9t
 xxql3wHgcFxLLyzQjVq6zVsJqK8k6OnbX2n+G7qd+KA==
X-Gm-Gg: AZFdTZeIAootK/SXWZf7omsKb5J5f8QM+ozEJudVbKC+Q4deQT3dUFTl9GXR++c3nYQ
 +UsQ5V+AVRMk2lYdbnlADRzAVW/N0W8ps60FGsSWEkh6BypGfG+x5InKhP7hPHIGrtZKt3zdANy
 b8rNgsEyogE07OI/1DGDOUZewEvB1o4i4L4PNZ427B6mx7NIt8WXuwd3ytgkynSGfZI/jyieJGJ
 wswkiLqJ/ITgVnZFLJe4xz0W10SbVX6cIYsHp+ijJyI/lNq/Al4a+qJod7U+7wTyBtG+vC53xuI
 qG/6TCwVIW4w0hyPz1+59gKWKxhye8tRY/RmL5blN1OrBLe30mA6aFAmTtq+8MeS4JVypQHbvtA
 kmhVz6t8eV75OEXDRYJMTpQdYsmiu2st4vGhQ
X-Received: by 2002:ac8:5a0f:0:b0:531:2eb:be76 with SMTP id
 d75a77b69052e-55d6fcf94aamr171245131cf.22.1795351081084; Sun, 22 Nov 2026
 04:38:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122072007.14685-1-mbkchelofficialdev@gmail.com>
 <CANiq72kV0YwG54i6fLSv1Rwtu+3Ks8XUzpdkZohY5tiH6LzhRA@mail.gmail.com>
 <CA+YDrKBYCB+AzOgDY6M6cczSyVNkY8me9UiYB-tZNz1bbanPnQ@mail.gmail.com>
In-Reply-To: <CA+YDrKBYCB+AzOgDY6M6cczSyVNkY8me9UiYB-tZNz1bbanPnQ@mail.gmail.com>
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
Date: Sun, 22 Nov 2026 14:37:49 +0200
X-Gm-Features: Aa3M54r8LittEhUI_zZQXdsqi47SWLexuaLd5JYLeAxAvAn9FF1NmJfcK0xT63Q
Message-ID: <CA+YDrKD0sWWxrgC-BaURdyuv=kmuh0HsfV7wYUJ2+-PdFvb9ag@mail.gmail.com>
Subject: Re: [PATCH v3] rust: gpu: buddy: store the allocator inside the Mutex
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Joel Fernandes <jfern@kernel.org>, 
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Miguel,

No reason at all, I accidentally dropped the brackets. Keeping [`Opaque`]
when applying sounds good, thanks!

Best regards,
Ivan

=D0=B2=D1=81, 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3., 13:55 Ivan=
 Tverdokhleb <mbkchelofficialdev@gmail.com>:
>
> Hi Miguel,
>
> No reason at all, I accidentally dropped the brackets. Keeping [`Opaque`]
> when applying sounds good, thanks!
>
> Best regards,
> Ivan
>
>
> =D0=B2=D1=81, 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3., 12:48 Mi=
guel Ojeda <miguel.ojeda.sandonis@gmail.com>:
>>
>> On Sun, Nov 22, 2026 at 8:20=E2=80=AFAM Ivan Tverdokhleb
>> <mbkchelofficialdev@gmail.com> wrote:
>> >
>> > -/// The inner [`Opaque`] contains an initialized buddy allocator.
>> > +/// The `inner` field contains an initialized buddy allocator wrapped=
 in `Opaque`.
>>
>> No need for a new version (I just noticed this skimming around), but
>> please keep the intra-doc link when applying the patch. Or is there a
>> reason why it is removed?
>>
>> Thanks!
>>
>> Cheers,
>> Miguel
