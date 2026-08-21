Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F13C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2962110E28F;
	Fri, 21 Aug 2026 08:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZgUcEiAN";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EA310E28F
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:32:11 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbe4592c193so82219a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 01:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787301130; cv=none;
 d=google.com; s=arc-20260327;
 b=dxnNVl28NpH1QmbHb6ttKflQ0keCXMRWRxIQcVskoHWE84IjpA4iBv2mW3VxXIWpex
 UOkotiGnQX0+TL/s0hP4X7wa313pYXZEVT9Wg3nZfg9v2bxXiQ5y4bl2oxKnQ5sJnOIU
 6D25Lc6dvz/wN+0D64+thtUDJhxtl9Yvc22rCs9jy55V/dtk9oXES/X86ppPNZqKQUjB
 y7r7j/nsXJ39U5/dq2QJtEssf87gHXRB/HhtlOr2Gn97ShLfEZDFjefDA8a1aukmav7U
 vaTTDccI4QdIfi8ugwdJy4VUiCdjDWL1DwZSx31Kh+TSrsxxCT532ORmPGpOTR579Dd6
 9YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VAJaZPrYdKpg7XFLHJhHHgjNPw07ISwWrW3nvc2Fo0U=;
 fh=p5h8lDjxFZmRLL5OE5Y9/HFwvQP8FE8r2vE2ey4WLdE=;
 b=cpC2FtiiGA3B7XaVvS3n0XmMpa+fEySlWbLnsq8mEmlVC8ayiur5zmwB8cBq/9GyZ/
 qd9bTzT247JsDEQaFsIRD6hAlzgMRFPc7EmQiUavoSxoZtJQmCxVyXinsClPQ4hKfOsw
 RCJ1p0JChf7jjzIZpP41ruSiglwLy4sDuC/JYvABuwFfCiM8F5zU7LzZ5oy8GgYpqtp/
 n7U0vySAAgAUXgL8cdMBMKV2nVzT7ArtbxIYNXIAr+5EpOF6GhFu/JW7D4sS6nCruVJr
 crdnWjrid0I/yHKu+aa/BKNTCOm4KDwT97/Jbn+o9yTohrDZ1W/2K+fCuSHsW8ud0ieL
 NHzQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787301130; x=1787905930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VAJaZPrYdKpg7XFLHJhHHgjNPw07ISwWrW3nvc2Fo0U=;
 b=ZgUcEiANGx+8ShYmxkmTtX30egP9Ds6heJ53F4sM09G7C84DJTqng8auRuB+ZzA8eu
 os81gPmeXaJFInr9kjYvaGNBlD9pXuhAGAm9uGNuG46WDpL9fLh1f/fxrQOF6WFnyfFw
 Nn9mPc0yUNE6DHvnqMNCoj3WCRVMAqS8awavNTejkdsaXxZSWNAUMTk4WJYhSjjm4VT8
 9rx9HEJ0LrXONMalpCh/cQeZZw+TmdkVRN/eOB5oMCGNMbebIhGF+DcgeIZORA4NLRke
 7M5OPmbKSQG9SzGyujqRM+PeMQzLiwjr8/shgajLLPPM4p49oEpodC68+FPQLNefuxlQ
 HtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301130; x=1787905930;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VAJaZPrYdKpg7XFLHJhHHgjNPw07ISwWrW3nvc2Fo0U=;
 b=Rub6ELEPrtA2ZZvZjJ4kvCkVWnpJ68as+AMsQMECupTVazMj1W8qCnVXqJrXURikn3
 rDJKcfWpDLq07yzaT/MN05vGIj20Nl2Jztf6ZaG49PAwuoPwiARH3FVPkcHn8q0fMG9r
 tfvtRzSoBFx+c3zg0IXlnjhfGf9zRrlOIhPMEa0nbRvk7aPGhZzxorAuL5ePR5VzsYo6
 QX9vOnxTFsY2xx3EAugyFYNWaChcFl63rI3GGERDpkcIyoosB8qmejvowKqInylORcGz
 rfxP6FCEwvjgXhfwV/JaWyZoa3ck1FjINsFbEoyxMA4dYlW15HOoTMZzGci+D0j/ICPl
 Jakw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoR+8d4qFUXzFzLwB88peghUeqTa5js+0eIpxJxIRNGUwgVfflv6dAP28lx8pll3LRQp757wMa7zU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l1xQyak4WVfXPP+2yuwKTsLt5dozaBtg8ZSwzDLT2xLI+p/SJl
 tlxPGkWxtUgRae7B1Mae9vr6R+4k3HJoSMGB7aOWWayws/VSuszT1IXpAo/4qP2XFltEAysPZIf
 dts8ysNx6n8lemKZkhccuZEI9EXxeInI=
X-Gm-Gg: AR+sD13p3kTGSk6i7qu6alxpr3kOmA49780LT1RucQiJUufFgqAt9NRvm4ieP2MRtvB
 itsibb1EVyuaivbTOzFKq7xKfPPm6tND7ouIKBOV8CNfN42ipfmIbsm0uRdY4giQi0z9alUs52v
 TOhFz4nitjHE3wiS1kmkp3fK9tKEiw4TdCayk8ZZzT6CAWoCewd8NF4J91fwL7PBZL2tU/5tYIm
 tVTGftk0xCJSi9mSqG+kYZof5xDjDsEW/zX8lZkmyoh0ajaTLSoz4eKo/ApOQTpE+HSwGVocrsx
 36qeE1ffhgkfNcmvG7DaFqs+kapKEocJNtr+DXvL/IGT6iGfh8VFg3kKz6E2+VTR64utyWrXcjX
 TH+7vC9tnhyeLYWUgdzLL/f8WddNO00AE1szB7nx241FjL05UgJiovu1ScoWc
X-Received: by 2002:a17:902:da89:b0:2c7:ef84:c58e with SMTP id
 d9443c01a7336-2d64ad9ed06mr43504345ad.1.1787301130519; Fri, 21 Aug 2026
 01:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
 <DKUGXCFA0Q77.36Q64A1AN6FX5@nvidia.com>
In-Reply-To: <DKUGXCFA0Q77.36Q64A1AN6FX5@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Aug 2026 10:31:57 +0200
X-Gm-Features: AcwNN1WPzmGqvT3e2iXW87UG3n4hOQXFPsxJelyLou4Wnmg4iCK3mbz0zVXSqfc
Message-ID: <CANiq72=ot1SVQRxzX5NmyTspzf-eMKca7DQMdUMSHtThn+kfpg@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] rust: bitmap: add contiguous area operations
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
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

On Fri, Aug 21, 2026 at 10:11=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> Mutating methods should definitely keep that check, but for querying
> this looks like a legitimate way to use the API.

If there is a need to use the API in a certain way (and there is no
other intended/"better" way to do something), then yeah.

Otherwise, having `debug_assert!`s or similar are more than welcome.

Cheers,
Miguel
