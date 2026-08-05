Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FDAC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A77510E1D5;
	Wed,  5 Aug 2026 08:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VVRL+6iY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F376A10E1D5
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 08:50:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7020600B1;
 Wed,  5 Aug 2026 08:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19E71F000E9;
 Wed,  5 Aug 2026 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785919855;
 bh=zM2Cc63xKCxAoBLXLPcSeNbDsA2llpVWwzg9g5qE0zM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=VVRL+6iYv1yhmElNNYw6kF15OzzK/W6LadgQ5dpUhJ2TRgfyuXDlpWh10nJD+DpWd
 PliDDQ8qBUFWG+U4Qsx9jeNhhx7bko0rx9J4V4qrS2eaTPdykRXH4GWZp6/OS2S1Th
 sG8NjzKLBC+AY1Vx6y641p6+K8HNSVtjOslJL408yMR0cmEI++Tzqt3F2tMI1/jEj6
 BP77nXqN4T+B7c278RGEFoWXj6XUZmTZqjTmrFOVghjyPZtlEKyiyniCu9xwhpA0NI
 40hxzdMrIBspnu7Po9RCQvZH5qGy2MozxK2mPoApLPDwbHXHeoafF8UUAH/wkNO8sj
 3qtiSxlXrsa+w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, Lyude
 Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Yury Norov (NVIDIA)"
 <yury.norov@gmail.com>, Asahi Lina <lina+kernel@asahilina.net>, Lorenzo
 Stoakes <ljs@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Mirko Adzic
 <adzicmirko97@gmail.com>, Daniel del Castillo
 <delcastillodelarosadaniel@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 4/6] rust: xarray: Add support for index reservations
In-Reply-To: <20260722144931.1070312-6-phasta@kernel.org>
References: <20260722144931.1070312-2-phasta@kernel.org>
 <AR60HaAmgoRArB0MtLSPafNeuclmXBF50OveeRR2_bXpofTeHInyi-US9AnrgXyIEZYKcEYGLBGd5lzHqCkOFQ==@protonmail.internalid>
 <20260722144931.1070312-6-phasta@kernel.org>
Date: Wed, 05 Aug 2026 10:50:40 +0200
Message-ID: <87se4t7xy7.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

"Philipp Stanner" <phasta@kernel.org> writes:

> One often cannot allocate in the kernel with the desired flags, most
> notably in atomic context. Pre-allocating the memory is the preferred
> solution in such situations.
>
> Add support for xa_reserve() in the Rust abstractions of xarray. Create
> a Reservation object similar to a lock-guard, that can be dropped once
> the reservation is no longer needed or once the index was stored to.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Please regard this more as an RFC.
>
> I need pre-allocating in XArray for DmaFence. How exactly we achieve
> this is open for discussion.

Do you need to actually reserve a key, or do you just need atomic
allocation?

I have a series that solves the allocation issue here [1]. Tamir did a
reservation API a while back [2].

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/20260604-xarray-entry-send-v4-0-965f6028790e@kernel.org
[2] https://lore.kernel.org/r/20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com

