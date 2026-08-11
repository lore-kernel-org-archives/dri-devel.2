Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1839CC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B34210EB83;
	Tue, 11 Aug 2026 12:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUEHmUje";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB4910EB83
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:31:34 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cecdc24b1cso2556825ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786451494; cv=none;
 d=google.com; s=arc-20260327;
 b=Q4MKx95diDjoXfYESmqkkvJUFJwZ4r+3ppLDAfljGdg/UgKoDlOeV8P6desDGRH6Yp
 6hUsI4JcPFgaDMpCQzawhy6YvOjj/HEkxj2EDChgm6cORolvpuBKGuUFnOea666NDBZ3
 2joePYJbRk9FByyJkuoEcG4NpHQjvigY0WC/kAE09nm/j8Th/BXDncuLYopOilXE6z7G
 hBItdFvDiJaxc1AtZBktnm/B8p+EOdal0WmBpGHaX/TB2UrZoTz42VIDS44hoADNthb0
 /ZkvUcY+MrBDuvYuI3f5n3DIfWzGOB8t1M53i9g4l1yzl4awq+gdTEI8WfTvjXvZR2ux
 z+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Kvo9TKdttK5rv8KXZKEyC8pu8fV4Pu3XcvOG69wPlb0=;
 fh=oY9k2k9a8OVXKWPrAc3xIWN/bdqQ64bspbMrwfAcd6s=;
 b=blv0sB4BIRAZSmDW03XsU9gM8ffQs9Oh8BCP9+cPi8yaYsSx+dTr2EW8jWqfawCTou
 uVeX0+PAOPJj1rqhjKV7HKriJuyj3H7VpmtP5EmThE9ghlLXHslIxj0EpbdUNBcjrWgA
 yriO+45I6TzQV8sQtmID0ZjvSoziRcDJesAiOn2GJd7ZF4AkR6v10SyInz8TDy0qQkbY
 KLnUc306vE1QeqSD5O+chgt0ox3aWAtBbxXxA7dFCVDKGSGHtgYK7KHRagbcrpvnvHxU
 wqiCjIQxl7lr2YWV3iqDwaYTbqbBhius89r6hn84RNrHBkvSIwkBuMrT6KH0dAa3UAjP
 RVPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786451494; x=1787056294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kvo9TKdttK5rv8KXZKEyC8pu8fV4Pu3XcvOG69wPlb0=;
 b=lUEHmUjeg/Dz83CZwfetNmViTUTvHtnTwwL9sH47zRcXDh7hDRMukI9gqU+mHr5TDt
 2Nc0y27Fgw1VPoBs4eG3xBv+Uw7TBPr5yKObBKFWBXXj3kTfEnbpBYNDDUi6xIfdiL4u
 6dh+NZVjDBpW71+PjKox8DHq3Pf05Jl3shTPXbaAkaXQAES4DLk3rKC/jY7HibHkc6ac
 gh4ACSCc+Tkr2dRtaU3ec/h+yCeARH2h33mrZ6G0pg/crm6hiqKbXrDDxLHL5qdMORW9
 GhljFRuTkVY2KJll4pe834gVFtL7Y1v/FemO2JcCbp2JlwfaTk0+Kin+ftQPYoxgf14/
 jsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786451494; x=1787056294;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kvo9TKdttK5rv8KXZKEyC8pu8fV4Pu3XcvOG69wPlb0=;
 b=Rm+4GAVNaQUu6zwI4UmtPWgSASIAziKjmbrFYps+XORVO+x0Zh+2CDWB+BfAYJ4tPv
 uedTl+DEOO8eak7zVQNFx4itE0zkBfaAY7ioC3rsrQnlOU41hGeGIxQ3sqQKYZTVCZO0
 YjQS8/MBNqNzn4HNA3v4WSebpyVoDIA9wPnuhmlFaHTRQKqFgjRt0hnuZpghu9d1y1t6
 haaWFkbOHsH395DZTnjseQx6ClR1qNWjnf3BvgRP2LxrqhoaQrHHliHnM6sW6ZxGnSWQ
 6U0ReOFaCMAUhJLhFIitT6Ze31ijUHFlBpLS75yTT9DUBh4sybUHzh6XZ0BofhjkcKUt
 E0Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX4GAYSUwdHRcORkuFrSl5ypawETkv+DvxdA0+dE3HjEkKNKUqd7PU2uyr3B88vNfWNbAP6qoU3nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2dvk3N2vTVjyc7wJLuFmFPOS2nKzBPVMuZSvwtCKsNKlI0xej
 lfZXPx7LpGDG9HKFoxZal9uWEQ6idqsPrqrGaQqGNbaopJ2G3Lbytlls1OGfYCWXTAv7i4SFYCJ
 1U9tBdPbogq8xduLOohyNV9KgJriKrMc=
X-Gm-Gg: AR+sD10Sp2y0hfhoqRS26V6bmgHPoLSSphtFDo2odMQp37fHlwqJrK3/bzfSJ9Ymop6
 1ypF0BBRviMXkrQRrzgzUf9O8LSXwI0S0UlN2QoieZyjFujfCuir6EbmDLlPO/Fo4zo2JosAMqn
 oN9KwlgXtJxDk4FA8oldcwc44ahGILvTzPdX7tfV/Keojs+0WL7CZesJIHHJhVtiT839tWiOoAB
 H0Ydsi5elmBsM596QjCykG1PlJIpBGex593KKnDcFVFkODuLvdW9nE1ksGJ+ZRRY0rghpDB33eb
 yIEkIsXumWz+yio1z/4P/AUiu0IfwFzh1UAwzQoA2E3bbuy72ux448So4OJST0GuKKi2bHz0B/M
 PmtddBAKm71Vpvw0BbJRgEtEkg8Beu6tg+dxbuW00GiZs5pGTr6RELgVRbRq4RquWGcoyWUdR
X-Received: by 2002:a17:902:e806:b0:2cc:d6de:d58e with SMTP id
 d9443c01a7336-2d317966388mr23897155ad.4.1786451494065; Tue, 11 Aug 2026
 05:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <DKLM8GXJGFL1.302CSI4V1NF27@kernel.org>
In-Reply-To: <DKLM8GXJGFL1.302CSI4V1NF27@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Aug 2026 14:31:21 +0200
X-Gm-Features: AUfX_mz05pylmKA9x8ysF8Rltnon1TiS8QMQm-gLy33uo5KYaSzY0l5rcB4vQvc
Message-ID: <CANiq72n_DLiGKpAq+a=a165AjN9zcYJFR8q1eFb9AbBaYKToyQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] gpu: nova-core: add PRAMIN window support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Joel Fernandes <joelagnelf@nvidia.com>
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

On Tue, Aug 11, 2026 at 12:26=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> I think it would make sense to route them through the Rust tree this cycl=
e.

Yeah, I asked Alex in v1.

Cheers,
Miguel
