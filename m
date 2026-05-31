Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E8ECD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 17:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C2210E702;
	Sun, 31 May 2026 17:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AHSYeL/o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D3D10E702
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 17:57:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DBC96008A;
 Sun, 31 May 2026 17:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4BF1F00893;
 Sun, 31 May 2026 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780250244;
 bh=OpwwfpuDat0PLBpEmIVKRTwlA8l4xHYQHuV7EJjt+eU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=AHSYeL/ohiyf+9qZFwNCkh88Ediyj90Je7rFdaRyHJ6WgOUmqQfiTjPiT+rogzXeZ
 pANqpaGD/nbhU9O3wrfTIFlNHsQaJPjeP7S6vtYVQ1yrdJ+M61VW7ygmImSQHCX79n
 1qFfTo2cYVm0gVX5EWcj7lfEJ9JUvSS7IENd4/fWFOWt/os1tGMa5AiyUhii58e9YI
 UYJXONQzdZOB2l65Rk8qrosXWOLeCaBKLfg2gKi9hALfx1UO6/9sTMeux+6vO6QpFB
 Sc/+wc1SMxvqkdQYIqr4ezD+RWJvzl38bxXMdMEknYiFHIWZZotvkt2hGzQoCmq7W3
 4ryPk2chCInNA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 19:57:17 +0200
Message-Id: <DIX21GVNFWF8.2AT1AX2B1NV6K@kernel.org>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Markus Probst via B4
 Relay" <devnull+markus.probst.posteo.de@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
 <20260531065838.7352-1-work@onurozkan.dev>
 <b6191edf3dc052fa86fae12fa5746d0c1c9c45ed.camel@posteo.de>
In-Reply-To: <b6191edf3dc052fa86fae12fa5746d0c1c9c45ed.camel@posteo.de>
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

On Sun May 31, 2026 at 6:37 PM CEST, Markus Probst wrote:
> How close? Should I rebase this patch on top of the srcu patch series?

Since it isn't blocking you, it would only make sense if SRCU makes it this
cycle, but this series does not.
