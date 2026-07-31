Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF3FC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B702610E186;
	Fri, 31 Jul 2026 06:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIGklpFf";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD06210E186
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:30:03 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso1190405ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785479403; cv=none;
 d=google.com; s=arc-20260327;
 b=cmiZWZoJ6+tXg7R9npnXw+hHLtEwspeRV9tHgyZVH6UMHGFVeC2SFKN3mWga15EUct
 lANheQRRC+AFpX1vnznOgfd8QdFLeMx8thYMD/fB0g98HK7zFMv5KvN0CzDjmPgSjETN
 lQPQbFNei3S7HSwhduleOk6cgsBL7Y1Wtz7cp7UV5QsUVTfU1AIz447PxR3KfgUWopf5
 fqlrt8cc87HyxtZidp4Y8cEg2o4pR8EWNZcYgIsXsqzjNPoEZW4UARe0/FoSJsTpDEHY
 WxRbxHbp6ykyGRjMYCNTL0WpLl40TUQgqPE2ySGxg6oRdMgKVFic9Nb1Jkc6sOI9Ts1s
 4SMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
 fh=7TH0HF2cIFihxvLj/VFo304eB53u7MjKujKek0/ba0g=;
 b=mFgHt9CX9NYSaHHU2JBECLUw7nSDeNlUpPeKJfFc/BRoaf8s2PaIb/eLraBWXFccUO
 Vy5Ytv0it2mqpTXcSM/R1lcciM4lQNUkqp4l+UvUglsgfu+l+v33gCDDBoXxDdaMQTY0
 5WXBoA0S40/WTsGr4pP98O55+1bAZyBxxCG6lAmtO1d6jD65micj8LH85u6J5QhjQf9o
 JNcQSHhmYTpijLU7MV77L/cfKLbd6c+0jLTmfMQfm6xw4Q2JAeh8PS2ogZxuuMoZF1LR
 X17xngNTDJh6GBDZQFZdrGgVnsJPDyO3W2d0aKNEBzDTarMV8IAAIjekAz0cYFaxC3hx
 aATQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785479403; x=1786084203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
 b=hIGklpFfyEK+1z0+bbu264EJ8tqpAbpK+Upkatws20yLQmBLnQBnWO93Ch7Cua02bL
 ApzV3kp7OQflat6C4uwW8Z3oe50ylJTGLl+yBSeRSfKOiSdiJNU7JeYtGiIrjByQwgC4
 faXqlTE7D5po7h00sdyVJWdrICk/KoD7HNVCCXXbIkXJ9FybBrkO0mTTQpSZV9MJgqXc
 CS/d7aJN/AShwekByJL1hH63bTjqCB6WQ14/GvXmIvNUOKD0nO1idNkJU2bQ1v++xuSj
 +G1CHNR9hXXoryCcM1Yc6mKPV4MksKtaSE0bHt3gu+gOEhQDBTAF+Y9OEjLjpUV7I0g5
 /Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785479403; x=1786084203;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
 b=QjBkiZqVM+/HqlcWYCQj8P/ItUwsQR83qAIRjw3AicpSWOxdggf6KrK8VZ2MV7Up1r
 DPhQD6DyGWs1Ewz+V9nYSGA8ZN8e+auy1jv/vMoFejfn+nBLzAjsMc6MWTf1kUH+qEaY
 fR5meYd3oYDNrnUizaPaZKHX7xweHySX4tz/OsvDLqiF9tpznEsFSExrZ0RBTi/O04hw
 XC8cdU67gwthuFIE/GXngXMZnpuxra8jRFzhBqqHA7zAPzK5BLGWbx9FMaQnFHDEBbgq
 kqhDwv78d7XFJ6k0ufhTSQG+3q7oDVPTLvf6HUpywvgf95QcxT/yCsnPQ8RLH81gHrli
 SRqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB6Dm/joHbjGOuVuN2wi9wAl62P3RDGlZb8Dcj84I7RX2T90a8jOyU1NHCagJ47N4mlMraiEv4M1E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz54NvNhNcW2bN+YsM5NB4xmnM9ETgHALsIQc7B5x2wnnBfzYAt
 EO3DhBpfdIpqh4NeoOjzzPKg/ezgucz7xQxWio+GVlIj+/A95jeKLWgvqOskggGQcVls2oB4x1S
 KlnN2ioo4hHuL2B5pPnp3l3Z32WOkOcY=
X-Gm-Gg: AR+sD10odkFEfqV/Tz0pvBMh+rmIH78PQpR/nbVadzYJHhLl7KNt17NxtTh46Hh7H6i
 yXgHIW06kU4aEXCdnvLWch4lTZzOgc3owNoC1IoN/2xO+d5t3EoqQNKJ3cwKi0Xf558je2sSuDe
 5pJk1z/Yh8DpUikT3Zk2mGXe3JUPIcu5rTg6tKFioGPVvpYX+AXR0hrFYryT//Ek2fW+69r65xe
 Er9zMXydwXqGQh2V56PtDQ7rI9ZttHm4TyVmUOdSOVgxnQKM9L+2wf5JdYoZi6t2rUpyvd1B5lc
 oluu/AAeZ43fxOsK1zDLUcnxmB8yPLxom7WC06rN6RdSFtkJxHXzQH71JrecTToALrrVrEIYdL/
 VkvvVFmr/VwH2WBF99iDmkYhKRXxnfkUeY1Uv4QeNk3uoMeZIlQSpbKLFMts3
X-Received: by 2002:a17:902:ceca:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d046ef0048mr13066585ad.4.1785479403240; Thu, 30 Jul 2026
 23:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
In-Reply-To: <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:29:50 +0200
X-Gm-Features: AUfX_mxTwoRg7YuTGPUdUHKCs3gSMN4l-jXSn1vTLDoexparxESqmVPaSYuvKs8
Message-ID: <CANiq72kkuKsRAF-r+2OyZbjjgvC+jvqMSXR=LgmqTNRaWQZ-nw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>
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

On Tue, Jul 28, 2026 at 10:39=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Back in v3, Gary suggested this series go via the rust tree.
> Would you be happy with that, or would you prefer a different
> path? If so, is there anything else needed from my side?

That is fine with me, but let's see what the modules maintainers think...

Luis, Petr, Daniel, Sami: what would you like to do? This touches your
entry, so it would be nice to know what your thoughts are /
Acked-by's.

Thanks!

Cheers,
Miguel
