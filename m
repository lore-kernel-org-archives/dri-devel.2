Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCD4CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5502210EA25;
	Wed, 30 Sep 2026 09:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ANwOoBv1";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA6610EA11
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:12:18 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-342c08bf64dso339712eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790759538; cv=none;
 d=google.com; s=arc-20260327;
 b=bE5qVOwUpElTi/KPt4TPEVfkboV0hfsNc34Th8yOUQ9Kt8As3nggQE/BakNiYHOpyN
 qtOufZMqRwpkryixjsKaaMtO/0P8ujAdhCY48jPsgU5In8y687h2ZzW76sv83nlzEsOr
 4L3Ta4NZ1W2jTNbZMP/tVqATt4QHodwykqPMRxTkxvngzzV7iiTJO75pzqwM7BXqDH+J
 rFhzeVFOYo22aFlfevYDZwaOfrwxLQp+wzlOrw2BuffCZoEVP3jkMPbQasqgUWGyLTDy
 Fsj/GJrXgi1bRog1K+VRq+VIfrYGlAdHBV4A0M2wAsKCo0KToNeigI63W3t2l+V+rzlD
 DLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yNQ3x0EFDEytueLl/Xid8kyTJCTBY14KPltDPVK8LHU=;
 fh=/Aueotkbrsh6ZtmEJyVFTZTp9KK7i8JIFsPwJaZGlTE=;
 b=AALrYiu38n3JezFFNDxkKqryGvSHc0ZYJAWDcmFTvAAFCMaGg55I0CBhlPKgL/FQQV
 M4MbBLzjXWQWz8y6wdUDZQ7SfBb7fHrODUbdVslrLSfDyvpbEG7zW5wwP0e8FMde0xkK
 8KwRba0Hzi4wxCKIP72SzATl9PmhSr8OPt43fDyi/FqGDzAmq98JGykVFND69cU6cMhb
 fVnLj30YtCwQ3A6dUGkmYueHZz6uvkME13x/bRtKz9Aa4+vaIUL3Z9XuuUb42MCBoccP
 7zPKGasD7IsJqwEx5Um0qIO4jZ4buauqNwhIT6f5+8bLOdnPUSs3bMthvBvRzIUa3GyF
 yvoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790759538; x=1791364338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yNQ3x0EFDEytueLl/Xid8kyTJCTBY14KPltDPVK8LHU=;
 b=ANwOoBv1YJggQKMZKU0+xPKQXd1Fv857VeTm6hl6iG00lUBps0nw1NdhxLaaLek2za
 wfxRKxNiXkmNdbq8DeSRsNRBrgFBNaPzUUyTu7sDsFnVQUOohp0Jg81wm8iiJzO0MCAd
 Z4lbRgStJYa5uet6QlRw8k5CVIwymqXdYCkKyLAg3BfF3OSBsDKXwM7hChFPsolCAwEY
 samB3FZsEaYPHMH/AINXw7QrITwNS8kpz4YeJ28pBWaWBGlWKfS28goE4mNiTP8hsYnb
 jCFb2GoTPJfpNZHvfwOfB4Wt25OZ+npux6laTf6/qymCAnkNs83vxQdUK9PpVqX3nRgf
 R0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790759538; x=1791364338;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yNQ3x0EFDEytueLl/Xid8kyTJCTBY14KPltDPVK8LHU=;
 b=Mz9dGKAo1fmXY5PFLWaPUJg1MdOnTvC3ix2UsfSARYxsijpFSwXDarAxxSGOXqI3s6
 zZAdSjJCvMB6OWmBiinpCIMG45jvSVRovhmKwqPK2m5fX2laA9ovkiTznmyNdP2oNlQX
 q4SMDpgUsmflOzjcR/aI7XlR8n4hpnjZrTo8icdPr+penO/VadtTTjDxyqX0qLO3Q3OO
 2XT8SXYixeaAoROLv34AwwXHg3nuuwlf5PbFNasknK+BS56WRkCAZn9gMtu4PpIveEqh
 IQ9ebRDWiuxy4321bIvJE2JFT7UHdqXdYTZYs/9Obo3QyvKiEX+JbkB3iul3fNPIK9C0
 OqaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+5E/zafcuG4wWfA2lNwOznQwLWy/g3ybVYYcOyXUQmDSPljmwvaAgXt4h/J7XYaAlPKUXLbtWACA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxiOP5thLoRb3gG1bSlghUx1HLmhFIM0NIZTyWNz+1e2b4Pyha
 Y5funKXlYqfT5L9QEGRrvXP/mxVrBx6KaYlHb0wlW4hjDz5e2Yi5kM2zJyfV10uW1DevfkhgRJK
 5ghFIemkfc6iCnZ5wR8HntlZqbh2my5I=
X-Gm-Gg: AYBFou20TesaOW6nIpi0Wh2WWtDZ4CqRG2YoA6tWrDW8PKA/pZPFl+QKzQvdf5avd4I
 uvvmEcLAvq6zmv1s1cOjY1zJ1un9A17faMpJg0YttEyy7G8G5n7UHf9lFZcwHp95S0S/Hqm2yq1
 VVGHCylJ8wFiujJhLzVfhKVnM1fpGbgfDpEe8L7tNuNHGt8Ic83fwTuAMKPe61baPf+Gd1gYEES
 9rWur4Mu+UiAXyR9iaDlWm+gwRhGRTgDki4k0ETxw6rmt0VDp1TLavcWV0Gxyey+q0E34VkrpnE
 4t1cV9DJ1LAbpcArPLBy0j8RqpFkn62usJHU1ISjpXpFZCKToyd7oI558Cb/wb/sqOFuBfG8Tay
 Oy6RrP5+sljetZagAVmzJ2hiYFwrt/GzXaYdRhFPeJNi88v1PRG5gOBHgtcGxNOebRKQ6CTVgAZ
 z4DYX6KnVEo/k7OGO/dU/2OPoXwr9FTsdUroAVVF3h260KlIrBLGA=
X-Received: by 2002:a05:7301:6192:10b0:34b:101f:cdaf with SMTP id
 5a478bee46e88-34cde6749bbmr2001616eec.1.1790759538076; Wed, 30 Sep 2026
 02:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-4-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-4-0d6cca376cff@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 11:12:05 +0200
X-Gm-Features: AclHuK9QlKMhXKITkkBnbYFPptADooLzR8_3Lk9f3AVt-2WcqKF5YbgcQH-UReU
Message-ID: <CANiq72nuhGkeDFwyWG91xJTAV_uio5PM_PoYvXLCWF7ebKBLeQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] rust: sizes: implement SizeConstants for Alignment
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
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

On Wed, Sep 30, 2026 at 4:44=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Currently, constructing an alignment is quite verbose [1]:
>
>     Alignment::new::<8>()
>
> It's unfortunate because it disincentivizes using it at interface
> boundaries. Implement `SizeConstants` for `Alignment` so we can write
> e.g. `Alignment::SZ_8` instead.

I don't find the former disincentivizing -- it is how I would expect
to have to write such a call in general. We do have the other size
constants already, and `SZ_` is well-known, so the short form is fine
too here, but I just wanted to mention that I don't think we should be
scared of seeing colons and angle brackets. :)

If this ends up going through bitmap or DRM or similar this cycle:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I can pick this one up this cycle.

Thanks!

Cheers,
Miguel
