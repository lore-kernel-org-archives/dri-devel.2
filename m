Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34203C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8644710F3F4;
	Fri, 21 Aug 2026 19:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lbB/+F33";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B0F10F3F4
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 19:48:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E9C540688;
 Fri, 21 Aug 2026 18:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF91F000E9;
 Fri, 21 Aug 2026 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787338426;
 bh=faklYvsUYtiYNNAww6C21n15COVHm0WVD3nEOm9HrwQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=lbB/+F33FXPdKhFo7wLNDZV+cRNrJLVb1ITPCDj5ZrMC2b04VPYS+9Py8bpFQoMxa
 BsqZ/WJSb4dW/VLXpT97AlInBg2zawb2DKSdS1n0HYhj/E4yq3s9E4jTZTa4SOn7Jl
 6wZvJ8aRvONnYU5F37+uN/haA2ycDLxJtNWpU9dbFsBFL4j6dtEd9KaszZuKz6oCF6
 UMM8KyknLrSutiuhBIuL5Maix5lrrX4iihMmqIco6Wjt/v7n+9Lcebjpy6wgXsqwIX
 KxGXVyaW/V7rUHcvSEC1GY0KqfEJhv3YG3N9htzJ/oOzE7DWJ1M2pgfGCtu3kISuY0
 llODWXnsDV2AQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 20:53:41 +0200
Message-Id: <DKUULBNAMK8L.F52N7AN3QB5M@kernel.org>
Subject: Re: [PATCH v6 2/3] drm/tyr: add GPU reset infrastructure
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-2-7b4e1e041fe5@onurozkan.dev>
 <653D47F5-0AF3-44B5-9896-F0AA81F67B61@collabora.com>
 <20260821155814.980146-1-work@onurozkan.dev>
 <2AD43D0D-2B01-47E3-AACB-32032B3358C9@collabora.com>
 <DKUS768JV9RM.36WFW7QI27WKK@kernel.org>
 <74217098-8793-4701-8292-FBE0DB31FD48@collabora.com>
In-Reply-To: <74217098-8793-4701-8292-FBE0DB31FD48@collabora.com>
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

On Fri Aug 21, 2026 at 7:23 PM CEST, Daniel Almeida wrote:
> I agree, no argument from me there. The problem is, when the GPU is reset=
ting,
> things are far from "working". In fact, things went so bad somewhere that=
 it
> brought the device down for everybody, and the system is taking steps to =
(try
> to) bring it up again.
>
> As a user, I very much appreciated this when games went down, it made me =
think
> that the problem was important enough to report, and also likely explaine=
d why,
> in that particular hardware, things didn't really work 100% well afterwar=
ds,
> which prompted me to reboot the machine.
>
> Two outcomes could have come from that, a) filing a bug on the game itsel=
f, and
> b) telling the kernel guys that their reset code wasn't really working 10=
0%
> well either.
>
> I do agree that "Starting GPU reset" is frivolous, but at least a message
> saying that a reset took place, either sucessfully or not, is better than
> silence.

I had a brief look at panthor, and it seems to me that this reset only ever
happens when the hardware is truely malfunctioning. I.e. it never runs unde=
r
"normal" error conditions, right?

In that case, I think it's fine. But I'd still rather print where the error
occurs and about the error / recovery condition. The "Starting GPU reset" o=
ne
still doesn't seem overly useful to me.

In general, the reset prints should still hint some additional information =
that
helps to understand the root cause.
