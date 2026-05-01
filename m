Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E2CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 10:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B3810E19E;
	Fri,  1 May 2026 10:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyZQWc5G";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A296E10E1A8
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 10:24:58 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2ee4e75bc93so43467eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 03:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777631098; cv=none;
 d=google.com; s=arc-20240605;
 b=g7xifNeFOZqerapZuJlLRLhn3kGRyX8+E0YD1cTbzd67RY0Nkokld3raoJz5yLwrll
 GRvPjs+q6BoXfcmr58T7dgqsNE2PmahPKMg9Dw4Ox6oiH/oDuCPxFT6/I3uRBQm92JDp
 djQ7e5d/NJpguggjkpmbPNkKIwM9IetYB0yICOod/JbB/42E+U1buG1CD6dndCsul9N4
 vgaA4NVJUyXUkmy/QuoOuhs81Yx+RlWGsv1y6/bXAyowYdhfv3IfqX/D82JxsG8RKMuE
 t7xvIwLPpBAVDbQ3vdz+aOUSHSq1ac13dV2KbE548xYdNZ34w/SUWW9myhQvrFxlztw+
 UK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ueeBZ5rv/dNboibk79RP10UA95sIWbIsy7oXRFid3cI=;
 fh=o+5Izuwwsz1/Yaerr6eohZumeU++ydJtM5g1x67GASQ=;
 b=Yr11JcMtG1FWyMqY99VVd3MBHS0G48AYB9Z98KPfa4HFNLSS2C1yQbtNh8Vl7sagRX
 c4sFgbTu70HoIfJnjBxRjXTIFOT8b2+6D6+EBDLU3gxFNUKD6UOwbQl6zWeMq6eeCBvM
 vk9Sx1xBC+m/rDLyrgnLsMWAXvBJikhHZj55NrSML+QLojs54dbmpZKkbC6yHHyogSFv
 pSS9NC0Z/LBOW7PYjuasxQ5wfFUeRfiSKIVcztkH3bVh3odGL0xy4T8dZRDYb1bXhCTg
 1GN2cYCF3p+oxAMi/xBJQTaJ/mlyv3u5rUxbHhS1kVK7o923JLJJ7UOHHTfBXG6SLR5y
 vAKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777631098; x=1778235898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ueeBZ5rv/dNboibk79RP10UA95sIWbIsy7oXRFid3cI=;
 b=GyZQWc5GNXsw7zPOnDHzKuJZalWSQEWSHqTRh98ZYxIP6zin4QNAN8U1bIzRUl3hV/
 Xnsjv9Bst7PpC2mKBi55UkWbgcvTeEo58roc1//MfhQk+9g3U2yddATiGQ2QY3OCdM5L
 kvh+uc6JIeZ082QZOh7Irn3TrP8nhMu4OXlTDNo8DLBrJ03+aWcCTCeW2uydloIEJD4G
 rc+crAbT6h+Ium5L5kSEO7SCc9QkEv2EJiPtjX3WS5Xe3DWQzMgBpjf538QCrHlplz9A
 bvoYCfZ4FaTQ0Sqvb9c7oyFpoIYYEi6BSQkADnmHL4s4TcbLfvpLE5+8ABHhPW8K301H
 a0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777631098; x=1778235898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ueeBZ5rv/dNboibk79RP10UA95sIWbIsy7oXRFid3cI=;
 b=Gug4xzVD647LHVpIBmRREcV20/Ly2TUGloJw72YYbRY/PuKetfTvCZ+2lx70qmdTLV
 kAaWPmDPZqW5ldcFdqEL4jrxOtQzolVI4J1CZ0TdsjJWHUI776F23TxV/GHQQPWypkmC
 ilp09QM4dNEPc1wWfQ19A1z6z9065g9DjjGanhBNBD+isC7g+KVdMLVcIUM3a2UPFw3A
 wdLg0oN4mQi3Ns4BgLoYpKwkLIcC2TKNcaEcqon/UR/D+CsnCX6ZoO9WKXJP1BboY3Ao
 NW5HdY/Xl4Zj7MC+hIyGQ4IX5+vyYlo5AzQh5pohPRKu8cEG4g/4Y8mkas1ZOc+8FBBo
 50aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Tw2I6eK/Oi1w8ogCgjJ8ZdfkXsfzeLapiBSMV38GoBVOCuU+aBzmfD5+tatwBr8CZGe3ofmXWeSA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHxja7YZ4gNQ06hMFtYPBZwPo/lnXoBnUpPY/Z7WzBb2EejHHw
 QehmUTTB8KdR84XcbXxGXkzupJlSB/5lP9ijDLmFihtNykm+SFVBsiMpFlJ1IO/cEsIY7iknva/
 oj9eHOknHq65VOyszLjWQCTlzhZhKgXY=
X-Gm-Gg: AeBDievKlYZgxH2bNl4WewBabBl7yrfLL6W92jcywE5OYgHAA0QUDKvgQ233cDjrkEi
 YJmnEsrEwL6y3WI1SKIGj8l6ngkEKPv2mMUf8mBQrbGsW/lFpNBMZnHJToMI7yumoANwKuLOVmW
 9bziDl5VqExjV+cy8DY2xLDekGbiXBIwBkNV1nIRR1g8m6E1KI0AuI2hZ2CJk4Pmy9qcZt2WGhk
 EGpV9E3CPhUxiOHNuLsFrcwUeN6o1ysrRD69eKtk+STnkr/kRgE5zVrzeqwsraBgxKiK3u/7OKD
 7+6eEiRe4VRiSePAF7ZtWorWXzcTjZ687ARIj7z/eMhlnk/PoOgQTkBAlkU0Cj3nMaTYC0iqYMi
 X+8EpE7ZPEszbIZ5asQCVr2UxIYo60vcCmw==
X-Received: by 2002:a05:7300:e128:b0:2d1:9b35:4f03 with SMTP id
 5a478bee46e88-2ed3e67f9bemr1559146eec.5.1777631097781; Fri, 01 May 2026
 03:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260430-nova-exports-v1-0-7ca31664e983@nvidia.com>
 <20260430-nova-exports-v1-4-7ca31664e983@nvidia.com>
 <7a33e348-4a08-4f80-aa6e-c684b4d7f1c6@nvidia.com>
In-Reply-To: <7a33e348-4a08-4f80-aa6e-c684b4d7f1c6@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 May 2026 12:24:45 +0200
X-Gm-Features: AVHnY4JU-fOQK36-2tr5_8MPKm5fMckRl4BPWEv-q30y-1R-UoCYMfDc0_YhnfU
Message-ID: <CANiq72nuGa7x21DcKr22ghi8bfrbATrBhcq-40zQ=3XJEVV8tQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] gpu: nova-core: export Rust symbols for dependent
 modules
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
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

On Thu, Apr 30, 2026 at 5:22=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> How does the rust compiler know that this function can be called external=
ly if
> it resolves to no callers within the translation unit?

Like Alex mentions, that information is what the `.rmeta` files
contain, which are generated by the compiler and consumed by the
compiler later on.

They contain stuff like generics that you point out, in order to
actually use them later on, as well as many other things.

In a way, you can think of them as opaque, generated "C headers" with
all the information needed to build later crates. Other languages take
similar approaches.

Cheers,
Miguel
