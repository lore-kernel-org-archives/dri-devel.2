Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32851C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 21:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B50210E600;
	Thu, 23 Jul 2026 21:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OJUQOWwC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59AF910E600
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 21:01:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9CE5600AD;
 Thu, 23 Jul 2026 21:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587F61F000E9;
 Thu, 23 Jul 2026 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784840484;
 bh=N7P9e1r3CovQaZxuR1nAPyHLIxoqZVRNBW5i/3MEaYM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=OJUQOWwCg4/XQ7v2Thq7hATmGaeSoHahaqWcZDY2C0A3crUULV0qYErWLyMvWNQ6F
 REpRylUIrirJVKmKxJTMz1DNi4NVZ1CcHDWtk/433yfTyhfJlZGFqVNu4V2/LPIA5h
 FTsDTHfCzsnYJhhhM5GMGjDb7urmApsGr9Yrwqn9S5g6J18BZSjYXMezaCVjI4nt9M
 1WbdJkECfRssA/lkiyEatYAkB81E/ZzwhuBF1aIIhCg746E6kffyQxIMwcna5yQnvn
 w9M4a5mMhpRuPcrD3Drp5kYwMDspRG4rCzfURQPTn3hd/gQ3T9mVGy0c4JyAA2TyR/
 94yL8gYMcCMyg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 23:01:17 +0200
Message-Id: <DK69583TKES2.2ECSGER5Z77I6@kernel.org>
Subject: Re: [PATCH v16 0/3] rust: add basic serial device bus abstractions
Cc: "Rob Herring" <robh@kernel.org>, "Markus Probst"
 <markus.probst@posteo.de>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
 <20260723205912.3441137-1-dakr@kernel.org>
In-Reply-To: <20260723205912.3441137-1-dakr@kernel.org>
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

On Thu Jul 23, 2026 at 10:59 PM CEST, Danilo Krummrich wrote:
> On Sat, 18 Jul 2026 15:33:09 +0000, Markus Probst wrote:
>> [PATCH v16 0/3] rust: add basic serial device bus abstractions
>
> Applied, thanks!
>
>   Branch: driver-core-testing
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git
>
> [1/3] rust: add basic serial device bus abstractions
>       commit: 99f59aa82341
> [2/3] samples: rust: add Rust serial device bus sample device driver
>       commit: 4b2c9156d312
> [3/3] MAINTAINERS: serdev: Add self for serdev
>       commit: 6b71fef6f05c
>
> The patches will appear in the next linux-next integration (typically wit=
hin 24
> hours on weekdays).
>
> The patches are in the driver-core-testing branch and will be promoted to
> driver-core-next after validation.

Greg, since I've dropped it from the queue a few days ago I've now picked i=
t
back up.

Thanks,
Danilo
