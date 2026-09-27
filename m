Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DE7C98328
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 00:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424C210E350;
	Sun, 27 Sep 2026 00:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V5icYsbD";
	dkim-atps=neutral
Received: from mail-dy2-f23.google.com (mail-dy2-f23.google.com
 [74.125.229.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECF110E350
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 00:08:49 +0000 (UTC)
Received: by mail-dy2-f23.google.com with SMTP id
 5a478bee46e88-32be7127c64so219834eec.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 17:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790467729; cv=none;
 d=google.com; s=arc-20260327;
 b=D/0AnLqusTTFjeE0dWVwW2fhfsXEfmLedsVHFjtwRPq6S4wLLwPgC/OxAPkq4CgnGt
 5WXzi3W2iOw5R+rt+bjc4sxGNNfWb5Pe/5Zj1GDztBdCtI1wR0NG0hE/CLAWmPLwB0VW
 3OS4Rc+ZrTFF85+K7kzn8rVXO/mfKnDRsSFjiYqwxtz+g9DmVMerWyPmUTodvpRusvVr
 sVyVrwyihH2TnzfQGjtQhilhH3IraPHQr0YQGm2g4y036g5IMY8q73ZMA8fxjA4zTSgG
 kG39MYXWxUDlybm60Mg9Cy3wEe0i8TNz5NF+k/l36cRS6715fHeCKC9ZEmZPwtz+Q5Gl
 NVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xn5PZ6iiiFBX0SCeMBxmphmVE7WTRrTX9RR4bP5Nfho=;
 fh=5n+EJ8wh8cc5ZGiit0Mo5GJebpjRPM563cOwlQVEwqM=;
 b=IWgQLuVX7ZGBgcPiKf5iAc4ylg9Xgm8y7AYKLV6FtFvLm9QiaRVKUAF/EOfOjFrb4o
 9Uz3WT6YGYvhwslEvYv9f2irjYidCqWA1gA0gaOoIH8ZZOp1vhoS3xz2NFvI+nSIt1LE
 vZA22cH0DRjiWB8ECrjX0bb00o1eiv4exDZeaYg/OJNCwHch4ubbdeRxJpmFMjOhkwx5
 r/9dO4qDo4xxjAVIEZu3zuJ5H3Ud6Vesaxpi/685vqPd2xn9Nj2zBjJYDHK97pXaCsD9
 rYU0RcbpIsdsYpId2QiY7idxXSzCWXzpzRBouYAS5QtmIRIh7cjIMgXjdq2aetUPYKOe
 RzlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790467729; x=1791072529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xn5PZ6iiiFBX0SCeMBxmphmVE7WTRrTX9RR4bP5Nfho=;
 b=V5icYsbDT4dsfNAQ2REoLUwuzetsLPI8omBdRF8UF3Npb5HzVPfnAr9fO2somsJ2+v
 TPhuYAh1pd5lJFfvg6oJFFlmtee9jSwA/Kx/4Z5NfptzxhDKK99t/A/XSFu6+m9/huEm
 AyetOcNB0sWK16Q7tkwKO9JCT+0GBAOHVeKk8oe69sb9TQ6V66cm6ExvfcaZDEVUajDs
 AhA4d1syzeXnYXtP+Ssd7PhwyEVh+hrVB9S3zltmCPf872Coojhy4+2nEAQUKfwaCEC6
 WBnp+8HA3VcctoGZrJD00No9yw7RHYz0SwEelDHjzuwG4xJyLuLitk85WpaJDtw/8abM
 rmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790467729; x=1791072529;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xn5PZ6iiiFBX0SCeMBxmphmVE7WTRrTX9RR4bP5Nfho=;
 b=vIF/aNQE2Ks+H1ECrpk2RQ6QGow+RNoYkw5HNFz0RGJ9pb9whcPUsr0GHNy5pwQjIu
 RY7Lw/1n/9BA4+ifXydbvUM8lvy4zKpv2Bc/MvG4xU/Q5wu5+tL800g2jopXPWu3FuMr
 iXh3slMl8PVBBQ5MOwxMGoW39PhBsUainN1T2MW6yy5hiVW14mAImCm8kMc3mJ3HWp3E
 Xaju8F7dsSUwPO6d5RAoMdOUPBrRScXRGiyiGV/RpgPJOTBJLdd5GkAuolEvnhR/7Ikb
 YG2iFC8OdDS/xewCSe6naY+kLPGg0SmRCX/GIT0SyK/7FVZTiuuXJ3Fc/eifkqvOHCxo
 of5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByPomYrZQeOp/7yAwk61b3Rsb+1OiOWNoOaw4hlpVUe4dZ03vqnugjxIPuPMHSI5A3ve7rhF+xZQG4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJmjChHOk1/tdmwk7BEqkA4IHJCNhTCt2YJveJuuO69LoGShnYd
 yuP0rb8kzVGjzg15LxIsYWrmQ4CtmkG0FRMQqq7BLv3zx6pXm3Oi+qO1FePVUmJcERfHNabVjFL
 rfwRYk/5wU1SUcO4lLd9/TJJ4dk1+QHA=
X-Gm-Gg: AYBFou2bwXtQeZDpqyClg7fd7ZA9PMRrBgq1t5J6fnJML90HFXkQlSJODCrg5cca2QB
 hUKcQYjIuuoKpj0nvUvb4lwbOtd2WQVO4a0pNs6FdJUSHbC/8vkChTypKZB7qoDFpCSItt+S3TS
 Gv9f6tPXoC6QGhK2QuGNZTtwLuhSo6e1AhWDixvVsNROxbLTP+mX0J3L6D8aHwFnHVq5TlKUgJm
 3M4FjShhNvr2Uvks8pqlneABAgHP7Oit/6iGsBCXz3oo78j7KYOUJiQwwhDrh5QUxyErcS2ylOr
 qeJHZeMwWQBwoV5n1opciCEJSRaiwKRaMbbyZSbcVx+nP05FfaM2TXtj/6NyFHjWAxUnUlb2lo7
 ji5FM9uc5uDKmljhPKAg0qK1356VwD7oQ0YI0wOxYS2bv9N8ltnT+vNZGPsDiL+GeI1h0m9XGnE
 SwSJ47VgywOL140J836LgXS/GkZNTW6ENTFh7uw9dmsgdzxZr30Xw=
X-Received: by 2002:a05:693c:4099:b0:33b:ee8a:2061 with SMTP id
 5a478bee46e88-3427169bcc5mr8229144eec.1.1790467729056; Sat, 26 Sep 2026
 17:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
 <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
 <DLPE0D8F96DE.91C7E0MAERDS@kernel.org>
 <DLPJT1IUSKQO.1CAWHDECQAFPO@garyguo.net>
 <DLPKN532X7JJ.14Z51ZIBUIK94@kernel.org>
 <DLPNFF0JNNOQ.14JE7RL8LT79Q@garyguo.net>
In-Reply-To: <DLPNFF0JNNOQ.14JE7RL8LT79Q@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 27 Sep 2026 02:08:36 +0200
X-Gm-Features: AclHuK85J-R98H_gMYqDRew3PEoe-FlnfCLidl5BzuhsD9_CB8w0JZU5OM3YYg8
Message-ID: <CANiq72kvkAWmJEgOathMVwuXFzUURK1dVN=OWmczykVWpSTv6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Sun, Sep 27, 2026 at 1:49=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> I think the skip-on-error default was added in a version newer than what =
we've
> vendored.

I was going to update, so that shouldn't be a big problem.

Cheers,
Miguel
