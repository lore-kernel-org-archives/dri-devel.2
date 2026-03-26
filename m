Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E118810A88E0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431B110EAEA;
	Thu, 26 Mar 2026 15:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fty3dSai";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EFD10EAEA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:36:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-486507134e4so13556635e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774539400; cv=none;
 d=google.com; s=arc-20240605;
 b=byjggTPCebN+gjnhWzAfw7N9QhJFG6kff3loZDlGuWR5gniEe7nGCB6ibld1lgnlM+
 XeJJtKLUNwT1YPjhHahna4R2aYC3pjFEwQGIhhICEaCpSYx/5pTUvm9BQqQbpYA/dyvZ
 um3BBv4N66AkcajWGbXgwr0wUiNFZtsQzCqJyOzjcy4CpqZ3UDFuB7lFcUjhvSBRUp/e
 rGvXrXk5RpSI98jZdCTFxHMAJAoJ6te3EXcrIPcsrBI5afzLDATEhK4CB+boz49DFnNP
 FKb1+roeop2XKgly7DioANdnHyR/NCOC6jNCVIFF/AF23JUslPvEqXJu43RPTOaJ+GYb
 KEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JVUJdOtjMVLPcCHe5HdcxQkI21k69qCxIBe2YFRdubU=;
 fh=FAb1mEwhPkbUTCOB//hCWTgfL3nU8FKCLaW5YcmE6Fs=;
 b=Atm5cpfJZsOhQdiMlhGlgzsINvB5DyBt6HLeeiXnVkvX5JcRc8gkxBDJbSHm/CuTqE
 Dlen2KFhKvkJIR/HW5boKYmeESWWiuTmtgdBcPDTB+VHsMz2G7zmvra7udLYSqHUNyrp
 hpUfwrlhaoJDeBSHPBgPirIQIXql9kKfi0GXSJHv7WdfDCwVlPsqlHw6IoFEIHVsU6OA
 A3UiKejCHFtGKCmVCuKT46PvicP1/8ZJU3Qy8dFprb0zZ3INJ71LNGqp9D/JRUFVUcEW
 l19AaDrJ50XlOwFHwQQVV0ITe8E6T6CFn0Nb5QXfIk+mVdhR+vjA2fVCBwlw7GtSaGMg
 VUBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774539400; x=1775144200;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVUJdOtjMVLPcCHe5HdcxQkI21k69qCxIBe2YFRdubU=;
 b=fty3dSai1zzM7Pk2fZj6HipOB7GC+GLwOETrKHahj9cGg/InJ4RSRq0huPKAs3l2L+
 s+xVCsraGU6JAAK6JqjSPHA5glyqVuGaARqmUwpkikuSVqiab6PMQ9+6oYN2RBEpb+aA
 WbFnIyha753gAFN2zNtQH6ld0wlkeqM51vbSk1RIx6BhQtGcJyC+XOb+JGuzOCyy98GV
 7Q1UxK6fZsRyNhOYuDDDSJ0djx4p6AJkdEk3P+j+ze8ApK0nl57wVgK1IPuNxeNkRChj
 88KTQWQWk1Xp0IGBJ5r+VJ4BqqBDBwnmHu2jcNZvIN/U8KyHoMG28hfIEqFAqtcN3i8m
 7/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774539400; x=1775144200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JVUJdOtjMVLPcCHe5HdcxQkI21k69qCxIBe2YFRdubU=;
 b=UV8hIDNd+xgfEZUEClEIY1QplTMtZNiMl09/HBaYO/7UjBoAdhnxkFNO4BOlNQOW3z
 C9mj/RnF5rDopK8/CKnebIR90AhRgI0BLfaJwcVH4NfLmDvjDkND3s5ItsgStrDIpAZp
 +tIdDRnooCjK6d9+Zh9rvrz//ErNe4jpxNKEjoLTAEGmSjsI2e7lBUP857scuGYijy/n
 gDSS8wa9J7HFPJWLvpI/tw6C6Yz3fABy0ACgKKf36Kzq9GaPbs1Fz6o/NHRftjErHO58
 fnD9XVze8dhnpCrgOmr2UKoALFL9n5YA601KYRU3GJO4gptwA+Vkq8y3PCZ+MCd+0EbM
 nccg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCSs5S1IFhYQFCflCeCCUOKcW7sjXN51M0FcQlX7573tOVQOxrjA1Rd6LizHdUBvU7UhBRakLxiNg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAWrYqjx/3eXjKHJU+Lgh3eXuY6aCc0ireqcQAxsZvWs+/8767
 RFW75VqXKZT12rHxwLp6V9NnZSKK9Bg/4rhsmLpSzDQZzyn6hj7F7MLyxMinMAZotnqIeohEU4O
 cV26lguv60F/puoL937OnuNeqzoerR9BPl1R9H16h
X-Gm-Gg: ATEYQzzOWeTnIH0Y2UanQepTKEnumnkIxr1pw1NiJ3Nwil/FaQwgvFl8VVyWjMfwSDr
 wDimcn0knDnRKYM2lf4WFiHZBwEfzp75jVxuUaByX9w1XIvkA0KfAWticmFF9oxHCRR7fFjsCw3
 O7yeKKbvDqF6//9XBh50Y9UiwaFf27iFP1vV0QtlRM7rZev78hbPbHxPA0lZnnLPxjMJVA4GUNd
 /7ZNPx53qU18miFx7N0z68pnk7vJaGT+kPuIJ63S3dxVATg44nKOEI9iOOGPFqM3F6PUgqEzIP1
 CVHZ8kstJ36wMHJOULIApn5BUjTd4p2i1LilUQ==
X-Received: by 2002:a05:600c:8283:b0:485:3a22:69b9 with SMTP id
 5b1f17b1804b1-48716099758mr115935205e9.29.1774539399691; Thu, 26 Mar 2026
 08:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
 <a6fca446-ea09-42bd-a4a4-436e0dcedd03@kernel.org>
In-Reply-To: <a6fca446-ea09-42bd-a4a4-436e0dcedd03@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Mar 2026 16:36:27 +0100
X-Gm-Features: AQROBzBaQ7mNWIBO_7q2my-s0kfnUb7NSQGi88bXHPQVSbBaaQd7x7NOYvChrPM
Message-ID: <CAH5fLghfcb-z=peHb07-rspe5WKJOg9uYkWAN_eCQqT7EEw2ng@mail.gmail.com>
Subject: Re: [drm-rust-next PATCH 0/2] Fix sync::aref imports
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, Mar 26, 2026 at 4:34=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 3/26/26 4:25 PM, Alice Ryhl wrote:
> > Alice Ryhl (2):
> >       rust: workqueue: use new sync::aref path for imports
> >       rust: drm: use new sync::aref path for imports
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
>
> You may want to use kernel formatting style though. :P

lol I forgot
