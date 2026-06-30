Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ACEC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51C710E18B;
	Tue, 30 Jun 2026 08:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CtRA9+Tp";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A951F10E18B
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:35:14 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30ca8c693a9so276628eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 01:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782808514; cv=none;
 d=google.com; s=arc-20260327;
 b=X/A/vll1RiVcqX6MUUwju2FK/s0RLBv2Mu0C6wqKat5EsRQhpvlzdZ86xOC8rJB/kG
 O81yc9CV45YWdqydk/laS2ZAQaEQchPliDEsE7KWpvoubbSobinKi/a40IxlFzWiIwvt
 MU9W0qyT9m7Y5YtrpKIKgHlFhbJRoNkMYnG284W/xVJGRfNjNze29hNf2Vxb+fYSGvo0
 CW33/xpMBCXCeTVFukLXmFWDQYqRsZMuTBxa+6CQXK6/qi2P3qZPTBo4ntLaPY3JypEt
 CoOIP+cbYYaSh1clf4tZIpMW23/31VapbCQ4zLI7fIv5bRyeY6jk3U2Cfwc/2bkiK5KT
 S/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
 fh=pQI0ea17TyUeK7+l9KpyzkugB9YWZ7Hyse4ltigIkoc=;
 b=UMq3I51y/b4+9CmbUgVIWHoOWH5hCgjW8wBiyA5DhYoZxxIQe+L7JQTSDyhWQKhkdv
 Q8eyDPknyvkS6fMBW/zj9ddP8HldgD4Xgg/qu0JgAK2Xa8srMN/zdjjZd3abgbEvfN2r
 8Egk8LwGDBHcMu/SN4yU2C1w07XZfBYkbT8ajhs5Lpb5KU1Q/HS0REZYx/0Ei0kcyy+4
 63QN/pqLvThbhQOiw0fvVh8FFsfZNqG+eenKmi53/M7jPhQj0yk6UdPXlQQQA9KvzHmq
 coz5RsS+66dPPCxi3OzHG6OvjpzD5MKnw5aZg6cDFHZtWe5rk5xZv6JHIKIa2cm5fR5B
 k2+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782808514; x=1783413314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
 b=CtRA9+Tp7VNlMm4ZACmsVV60R18Xtws9uFb2d+CCNYHhuRIFyitfZrgFsLoAnM2wxz
 krVwp60wKIeAwtxLP8XUBWJvfmA5+MaGqJxXAA1JSrkO9F3U1SPPd8lpGpoKq1w14h+x
 mqJn6OeaBkPqVJtANl38tPnyMEenjJfHhbQKnw33MtUco97Rj3WRCWEZL5R8b2NaHwUu
 CW2BJs8BZOkCciviLbpNlRzPWTwLJ72HPRdkSTfkKLRALBfoupuC4h8gFtWu3+WQ8wCD
 NLaQG45jpnnnPsi3hcbexmyI+8e7796kNc+1zyWgVI0QSS72x7i0A3pAq/m7oZuK6Sk0
 itXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782808514; x=1783413314;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
 b=ZDk9Lw1g5rNk8IDVAdpZBCL/FvimHS4MlthIMCaQDjQ0R1uXs+GXcAyMxYn4KJM+cK
 hmOqTME/j7YfJovoRODIoZfWRtfIKmgbbEmcAv6K1by+84aBUXGuHorOaFU9FPeF1LLM
 r1ESgWQLNH7VIrTdd+FRWMneTXbO5KiSRcsCuosryX2Yy9UXfb1wrLtxoSnnl5siI8eT
 0YFezEHw0AcsZbc1/d8tBcZC1vtmlTZTNtw420t10KKaK42Z4LDPSk5AGyqZ+yRJkPtn
 3cNSbXKAj+tYCK96H44vtppXH6/U79nzBKlQv7j9i1jGjpGFcA7fOcuQI9AUCJlbo30F
 VAFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMWiKHk5SveeGln8TG8vABaaxPA3cEAsGFWT542y4IyiR7hyYTeoaOeBjo/eeTLu6ruW7mbRJ869k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2N823/cDTTcTfdbHllhmA1ehoUMjgIOxOgpA5PXlkjGtlDrp1
 23Bn07YsgOQfypdHqBg01Qtq+671D1jglDq6901WkdyXlMba53mrmGgnGIpm3GOkcXSWXymSC/9
 BqBbGciXf1XFRDVBKCWCRE6Pw7mWBdtI=
X-Gm-Gg: AfdE7cljOE0oqd3yUQ1RrngZ/q/S6c2cZBquMlQg/URkHcpzMYr8nYMI1jSbNkTSGGB
 ZfFlJMx1hO4TR38mRj2JYLem3ze1jIcku+sSOEi6d69+yEe3D3/b+Y04zIiV1s9DVHaYqpTHX4o
 TVOWltryPSOyVcPwsm+EuffdVmCN3Lgp3LlHBSWxejUVdJ+EUHVSudQ6ZV+u5cAPePcovNK+oZO
 GsggUxh0FXpslNCMv3hGNAjQt7eFtQuxmlC+iDDTM0vQ95bYX4Yqszv+EUtyp+WAKqsggJ5IT6u
 OcFKTyhqSZU+8xF3M6OVHOFeBMqShEbF4oofu9MlGqyxPzDwuY28K03YSs+lYo2XKCAhqPOd1BQ
 8VYrjfGT+jGyl
X-Received: by 2002:a05:7300:6ca1:b0:30e:dda8:e0ba with SMTP id
 5a478bee46e88-30ee150954cmr1003565eec.6.1782808513710; Tue, 30 Jun 2026
 01:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
In-Reply-To: <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jun 2026 10:35:00 +0200
X-Gm-Features: AVVi8CdhtqV-BYuDJ7-_rhOqSdDxdGUExu9BuuQ1x0bjmiH_24JXcG_HI6rxurs
Message-ID: <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Guru Das Srinagesh <linux@gurudas.dev>, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
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

On Mon, Jun 29, 2026 at 2:43=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> If the preferred style is to place each imported item on its own line,
> shouldn't imports such as
>
>      cpu, cpufreq,
>
> be formatted similarly as well?

Indeed, good eyes.

To do what we want, `rustfmt` needs the `//` at the end of that level
too (in the future, it will be without the `//`), i.e. the patch
probably passes `rustfmtcheck`, but it still needs to split that line
and add the other `//`.

Cheers,
Miguel
