Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C107C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 20:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B37910E672;
	Sun, 28 Jun 2026 20:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ual3UC4J";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1412410E672
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 20:15:17 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gpLHj4Yd2z9tG4;
 Sun, 28 Jun 2026 22:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782677713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/88b3Etn343+GIDtpFPjDNRJuj4pU0CEfjCs57vTBs=;
 b=Ual3UC4Js0TCa/WK4fHeOAYPBx+3AzL6AtrRcYPBb+6XjddRjnDz2dHARDHaa0A8usrgWq
 UlqkzZkfaT9Te/6iu3TyoDuJ36VK1RC4wu0Mii4rV7OqJGe3cxda+cihess5EnOfaqwnPa
 S4N6nfD2wjX5Isca7xkkldkvCkVNqK+V6ST8PTIr3w++mV8OOARDHQ/Cu0+SkWC9xVJu71
 N40tErCU/7FLeY28rPFgBMeDz3iTcf7juQFZIc2+KIp5vRfT8d9GUAmedu71E7WD/UyzaU
 vxfNE4OxjVD7uIpe9z42f9ukFQ+ksqoP5rfmnrP+Dn81cLo43+AfIE0V6Pti/g==
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Jun 2026 22:15:02 +0200
Message-Id: <DJKYI6S4MUVP.3RZTF8FDRILYV@mailbox.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Boris Brezillon"
 <boris.brezillon@collabora.com>
Subject: Re: [PATCH v4 1/3] rust: clk: use the type-state pattern
From: "Maurice" <mhi@mailbox.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Brian Masney"
 <bmasney@redhat.com>, "Boqun Feng" <boqun@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
 <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
X-MBO-RS-META: 3u353mzh5e8kn59xdxsaheg4i3j17fjp
X-MBO-RS-ID: ebde9567693c9bedc44
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

On Thu Jun 18, 2026 at 5:46 AM CEST, Daniel Almeida wrote:

> +        /// Behaves the same as [`Self::get`], except when there is no c=
lock
> +        /// producer. In this case, instead of returning [`ENOENT`], it =
returns
> +        /// a dummy [`Clk`].
> +        #[inline]
> +        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) ->=
 Result<Clk<Prepared>> {
> +            Clk::<Unprepared>::get_optional(dev, name)?
> +                .prepare()
> +                .map_err(|error| error.error)
> +        }
> +
> +        /// Attempts to convert the [`Clk`] to an [`Unprepared`] state.
>          ///
> -        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api=
.html#c.clk_disable
> +        /// Equivalent to the kernel's [`clk_unprepare`] API.
Missing definition of `clk_unprepare`.

Best,

Maurice
