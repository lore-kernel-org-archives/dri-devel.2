Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA0CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F4610F3C3;
	Thu, 18 Jun 2026 19:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n10j/nLD";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3640310F3C3
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 19:14:19 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1364ff8099cso50156c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781810058; cv=none;
 d=google.com; s=arc-20240605;
 b=crN8nagksJ4EnJlBrpnDD9XV6AjFo6t5uyzp+ofoo92Ss4IRUpiMWjRT8bLgtcrC4h
 BDbzCT74yd5sZQUhLkAo0cF5/z4aC5OJeHfJ/L+gkiNXVhhsUgEv2/hrugDRiMrB3XfK
 9sWw9qP51jx6TrxL68JGU71WalpEjsSqdPrzoEJxrczbJkVVBedSTlCyxZJewnDASGTZ
 qH1Bs9njke5JeJ9lVfAlcQW8u4cnjWnYWR7Zh6G/PNn5OGX3E26wAxTF8vP9nZHUV1pd
 qYMalPF+OAZw97idPLVIprWeQAwR60NKqUYBbG6Rb4IPBDG3Yvj3jUUCE8UMEGUodmYe
 cb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3gIhj8csyUjzimg3goW3Pzqun4T3ZR1YGiH42Uwliks=;
 fh=RaxYfLgC19tXH5apQZwZMGMsH21i+M4cBZNX0cUhens=;
 b=dO9Wmu2/uCavrtyWpHbFLDyMlynQuXidNbObXkcmBEyM9vz0/8MuQq/CZQaurOIEDX
 iRMGSjNgVXfavoBTWiBo9euvYhFWDVopFB5riUM6cxPpefyFdsqXFpnAUibigki0ltqD
 930T0ikqhgsKEQ6gpj4S9MdWk4hfbtWbtoBMmiu0y7yBLjyPL+0BqoE/o1DrXR/USQ3Q
 KXH55Ly9Zf7uziaxzczOYHrQ1ML2Gi/LUGkZQQCrOTDQLD2xabeRhyD27DEbYOowJMWQ
 qJtg+SUL+69bfVfxyNS3bzQAe+TY5zksI1l6sos5Mc/kmRKgz7I3mfqepLNTOlgFctJ4
 ZCCQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781810058; x=1782414858; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gIhj8csyUjzimg3goW3Pzqun4T3ZR1YGiH42Uwliks=;
 b=n10j/nLDn0UQ2W5pgqHrwX6eAaZwugUWyavpGb9YIcKxkqvqZ0Ri/pWX0VPiBkkgSp
 HcPPgUQnGiuUQKnC+5O9cgQr86MlemapBzGmeUo7F9GjnQ7zh9Fw2tnu402+Yf/iOmHW
 NQx1bOF0teVJptCMHY6WLwNDhrWMqFWTOCbKe6zaQRmVUjeoi/qFvF9bxzlwTatp8Pcm
 OjWqxxfmvAMDH13AWXLMareJKceTmQfQwIu9onQniV7wnd5bFr4DeiTb542IfWNKMGFZ
 mmjX6HJzBhdeeXp0akTxnHATqCcrC9uBMkMvXaC/pnyAOcYdaZth5t9kbVtFiNzEnvtU
 i38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781810058; x=1782414858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3gIhj8csyUjzimg3goW3Pzqun4T3ZR1YGiH42Uwliks=;
 b=QGEUdg3n0QA5zp4KEa98Kwtxg6t0VXcGk0CxPZaa8+Ia58lWUvab9JaYW1TA0IN29/
 mt7mIj/inh/KZYLx6Gj6+LovDKLocvjOIkQjMNDzRgNWT3G8Sc7ZhqZhAgjqXLuHq91K
 5TidUVtnWBhsqU/DdWIFfWDzfd3jOvjHYO9m9p2rL0yRc/YlKhqPeontEYMqsztUErqV
 6qZhnnkCAd+7v5dI5p+h5IhHU6EPT3I6uOpJ/p67RqdoQeKOHafgejrhIfV7AAxhoIQw
 I2RwBMsoq/Pdb88iZ/TrmeofMbYUn/8tGds7U9kc2GL5nZGTg1MrPAsdL31pcySjEy/k
 OGYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FXlF102ur8tl2zAVG1snMlFXjwfhqJdBmnlVx4cgQkHWWV/E1kMW+BW7Mgl8kZ//ImNLBfIM+0dw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxnzh5vrJCnxw4hKeioeh3n1FjjizgFJh7wvBB7xIXHwgD14uKZ
 JttXf/E0C0dXDIMAsb2lUGimNzm6NuNgYIXgG1TsF2JXcJeucS1tRTmwsCGM8lCvSOH8Xb4iQJw
 k4m1fL7hzhWPMUtACXStdMWRgixsyYFM=
X-Gm-Gg: AfdE7cmM8MsB4viYLjgvaedTwXcdW6aikr4+5h96NsBCWsnJjD0gRBmm+nxiZlbgFXG
 JJs8sPFXBHYlgRQFfhPg/fdiywX3vuOEGGvVIH5U84LwLlNptaDa4ORYGtDA6Cq1FwZrmmMQr3L
 /XWK3Li3WXA1c7LZ+Io9SYVI9t1kBBk9Me0np9FbjbD/f4FyLg8/Y+ipJe2SC1lVhg7CAIFB/pI
 iNPWrbNLS5F3xC/nxQXzSjuY9BaJIpH3cQ00jB6zFDPee0T0fSVIHIDlSwblO3psld+fi4X/NKp
 PTjSyK+7nYOT/HROZ+UGcTipU7tTLbtbiOG+t1aIZiaGRb8Pe+YQIN0lPs7PR3juREGzx+RduWo
 XHN89rqGsb8EG
X-Received: by 2002:a05:7300:230b:b0:30b:e4a6:1aab with SMTP id
 5a478bee46e88-30c074f8c21mr216868eec.8.1781810058121; Thu, 18 Jun 2026
 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260618132628.3811068-2-phasta@kernel.org>
 <20260618132628.3811068-4-phasta@kernel.org>
In-Reply-To: <20260618132628.3811068-4-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 18 Jun 2026 21:14:05 +0200
X-Gm-Features: AVVi8CeC-ql5SLxnogYN7t_D3e3IE25SNmVufxe0bxI6l-UhWmyMsdwZiyoyB5w
Message-ID: <CANiq72ke2pfkhHB-_x0dTKUbktkTvLsu7z5eCFYVyL1CH=O0Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: error: Add ECANCELED error code
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 Asahi Lina <lina+kernel@asahilina.net>, Matthew Maurer <mmaurer@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Burak Emir <bqe@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Eliot Courtney <ecourtney@nvidia.com>, Mirko Adzic <adzicmirko97@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
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

On Thu, Jun 18, 2026 at 3:27=E2=80=AFPM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> +    declare_err!(ECANCELED, "Request has been canceled.");

Please place it after `ETIMEDOUT` (these are meant to be sorted the
same way as in the C side -- we had a patch at some point to make it
more obvious, perhaps someone can resurrect it).

Cheers,
Miguel
