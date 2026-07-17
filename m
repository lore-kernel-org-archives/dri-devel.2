Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86225C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D485A10F530;
	Fri, 17 Jul 2026 12:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dksEjUek";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C0410F530
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:07:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9B8A41AD8;
 Fri, 17 Jul 2026 12:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A341F000E9;
 Fri, 17 Jul 2026 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784290074;
 bh=pIiPYKYAZ5yqfaYtBU1aN9NCnjIXiX7eVRmLeeGSChM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=dksEjUekMBQC6JJgGmvGEUwBMZSSoafNV4Vd0wrDczC1aj1O0d8FRB0pJ/ESq4UtR
 IlFpEKBSAKL18Kpic50Lu5oz2OuYEIoMnkB7Eit6TDm5QT3IjODj3Q/1YLSexsPIRT
 hTvYY2QYXwPLRPW3NSomonlMT4La1+3ofHsrvhns9p335J7dYGxhkQnF0xjVboThje
 yc+V2PQbFuNaT/jmQH4B+D1RaElWFKG9hAs3SvUgh4LFyG2I1V8cWBSMr5l6L4tD0q
 8Msio+iaeI5BRZ9bmHxe2j5lo7Hc5cAAK89LKyIcDIk5/6HDhJMvP/WcybrneHz95Z
 6/eN/9PcOlhoQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 14:07:48 +0200
Message-Id: <DK0U1HB4RVRG.3S824JZSFIF1@kernel.org>
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
Cc: "Markus Probst" <markus.probst@posteo.de>, "Rob Herring"
 <robh@kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
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
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
 <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
 <2026071719-afflicted-eleven-1be9@gregkh>
In-Reply-To: <2026071719-afflicted-eleven-1be9@gregkh>
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

On Fri Jul 17, 2026 at 2:03 PM CEST, Greg Kroah-Hartman wrote:
> Should I drop this from the tty tree and take it through driver-core
> instead?  If so, no problem for me, just let me know.

Either should work, you can also take [1] through the tty tree, I don't thi=
nk
there will be any conflicts.

[1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@ke=
rnel.org/
