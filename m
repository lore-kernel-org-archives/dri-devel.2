Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ED510A88E0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3574810EB25;
	Thu, 26 Mar 2026 16:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mheXMdvo";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C968D10E25B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:36:10 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c153272250so144801eec.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542970; cv=none;
 d=google.com; s=arc-20240605;
 b=ZAzM8YJ0Yotmd7B6MQE5B6bXz2ffznQz4hqFA8fKfp27NQoRjpXjDDyLuW6QuyEzWe
 SrDbDzzUN/iUIUzottqEwOSk41Wrr/NvNAZpnHzW8ONMltIC+bMo4n+5bPuC5T7FPe+/
 5Tkxydk9IHuq5t68eV9btp8WvqNgOC72ZwxPV61bXfmdbs+UHXrzoQpGSV8ZNFiKYluf
 xPSmaZnFCYpmWyF3FLUV2eNJEVsUk7XQHAUGUWVrlDKntNQF9XTlAZXrQorrBgez/DgT
 mVhfEsjEaRTp7JWZmGI9gxTnOcYdnK9Nf5Tvp9AX1QHaEEUwN8+jm15gN3jBt8kopmvf
 AJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nydeAOXpRYVwIW4c1YTZfBGPxow7LreCLUi0+NKHYUU=;
 fh=AJYt1MT9dt3GG0/rcEIQLyeFS5SwWy/r3eDJNWtkWc0=;
 b=lrrW2vttAtSA8fC7QdNG2GPVR7g0XQYWv4AWGo68RwLyaz9sW/Ef6DmMvMqWxhYmYa
 rhnNHXTYfIdWuWYYsm0Oc8I0Sat7TuKWMgCoVMrhA9gODA2lVf8dPv5SBrCxyVW/GHjc
 tEy3Ofmnm735Ave6HNcyjprX784JK3qQwvwsnaSPLulMz2kL1O62NL7zpVgr4sdsPTuc
 yEHkP3lRhNzZQq6Z38NXkk3mJngG69baQQlONxTw3VONCmI8OANYM5tXec2GxczB3no+
 mGf8e1pH+ZQNw7Win5mWAibFmiMUQ/lXbe4QT0JqlRKur0PWHeiItxPb1Nbv2TelArZ3
 e1CQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774542970; x=1775147770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nydeAOXpRYVwIW4c1YTZfBGPxow7LreCLUi0+NKHYUU=;
 b=mheXMdvosY2gRSmsmSJxHqjm8Y79iGxZLgHgqg2Rn/ZxeGNGc0Y0amxlxwIiR/CiCo
 4+NECmLRep8eOtOhLbOJeAKMifq2emfUnpu5nBYPFbOyIQWinctqhpiTswfOf1SxN3Yh
 e6bQm+dtBBa4iOVgozIk8YlZ8B6wX5IlMjnLl+Eja3YsVTD+z3iUqxMamHD3pNaY3eDA
 0iydPGogWkfngbOLZ0aDLgBLPo0LouEesgXC8N8HWW4BfM/NVlmqP8dxSmaaPEH0+oe/
 f48ecOD2Qw0A3eVVTYVJ9ndhOwVrxO/8jCRioDtjn/RgJSspgsg47Qu6GYxGdgX2lE9Q
 CwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774542970; x=1775147770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nydeAOXpRYVwIW4c1YTZfBGPxow7LreCLUi0+NKHYUU=;
 b=SuaeV/WHqXV1h0whFiavZAtNGoVPUi/LA40nAWAY09XzMTkqOnHjgw1d3E27AoVeoO
 zpsmJiBLYTsCcsn7ApB7k1//Xlp4ZDltX2LTaz6j1GUw/3/LN95qotg/VIqkgzYq44fB
 aHyV/4+A7W+DewQvZy2ZN3sUogc8RP79vyR8S/FCRQsZgBJlT+TT7+uyCOBleYUI8bUV
 7lN+5hPgFhpCwJ7JJT1SFnsGCw9txO5ywiiiBTGcQAwQdtNMZDi2e7zPZ1xArvGB8h4O
 4Gfgw4DQdnnmjnWndZkHnq0iJ3sdTpXxQuVJBe/CszrvCvK0SU6ODglOxc+PiTyHr5Xe
 KZ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA+E+eYcMOc2i2Cu8MLRGvaOXDsj/h/ZdHwe/gMAyA3G3xL1AGMDNFoNv3IZYzB3o+R/O9juzeLsQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy77tNguETJcOFas6CCbqzymlBXOa3mWhzxETnw2KxK0nkIlOiC
 aLcbhySy2L/O7hx2s/kNwaNmc8QMHKGTfNTyEnT2fPOvUcuMMY+Kg2ktSQLt367BGZN52FNkj3t
 cS3Iakz9K8OSgMoYr9DfyiFwJ4bx3MbM=
X-Gm-Gg: ATEYQzxY1D/srNCbpeJSU3oNCQDwuEjbomdF0ZzAnGzFnHdLqYr+AR1o2oq2dHSOpAE
 6ExBf7mzw+NpRYIP5K53sbj/hvx4jdyZaqVbzStLA52XHoZLKYV9vAKNlYa5LAiaqscspi1AcEY
 LovFfsSQTYmvMvWt7KniO+0XtT0S6nqncB8u/gg8nOlESsJhw4y3//PwfIiedkx4KJ1knqpuO6g
 XLcHg6KZtsxTmd0r4PvbjF2vFu8KgkKIW0QQJeodqkHJWLRweQKVrjEMYFPuECSkIXS8vsNTYby
 JTCj93Z0Apeicqmvl2NvA+J0sOU8nFps4FXzZs1kIxf7/PAE38VGVxFgYDp5fTQ16nQ808qXdIJ
 dXUUhCE+Nsvu24oEkKQ0sJHY=
X-Received: by 2002:a05:7300:3b04:b0:2c0:c55c:156f with SMTP id
 5a478bee46e88-2c15d389680mr2432111eec.4.1774542969928; Thu, 26 Mar 2026
 09:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-3-074badd18716@linux.dev>
In-Reply-To: <20260326-b4-tyr-debugfs-v1-3-074badd18716@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Mar 2026 17:35:57 +0100
X-Gm-Features: AQROBzDQHHLoflnxMNt36NzcqIK5070iU_W4yEb_v-_RwpsKDpwB2QFMZ_oaOeE
Message-ID: <CANiq72mg9nAMrFNc4Tbn7rXeSoZGETTZnUtKBieVT3XLBmmhYA@mail.gmail.com>
Subject: Re: [PATCH 03/13] rust: sync: set_once: Rename InitError variants to
 fix clippy warning
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, 
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

On Thu, Mar 26, 2026 at 7:55=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> Fixes clippy warning:
> warning: all variants have the same postfix: `Init`
>   --> rust/kernel/sync/set_once.rs:68:1

Is this fixing an issue earlier in the series?

If so, then I would suggest just fixing the patch that introduced the
issue directly (since you are not the author, you can use square
brackets between the Signed-off-bys to indicate what you changed. I
agree with Gary that is may be simpler to just allow the warning.

If not, then please add a Fixes: tag pointing to the commit being fixed.

(By the way, if you do keep this patch, then please copy-paste more of
the warning, i.e. it doesn't say what lint is being triggered. In
addition, the imperative mood is what is expected in commit messages
for the kernel.)

Thanks!

Cheers,
Miguel
