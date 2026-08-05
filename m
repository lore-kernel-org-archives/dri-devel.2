Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E4BC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0317810ED87;
	Wed,  5 Aug 2026 08:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ClxQ/urk";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A212A10ED87
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 08:53:36 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hFPMd0Nc1z8v3n;
 Wed, 05 Aug 2026 10:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1785920013; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0kt3sEJS8rcr7Ny9au6AZUWTZNIDFJfeA7AQvFZCaQ=;
 b=ClxQ/urk4c9SN8JoHvnh/q0WeoVUP4gioobjOGgfJScoNUWMi4Qtolmxvb7rv62REeUgUd
 xmz084CzYTOlNvvBRJ1KlsOhMVIBg/EQz2IMTqpr5CJnLoDahwSwrmkjmu9T9IqPbGgdzm
 096U07oURIRsZKehleklN/StF9ErOU+7G/11sMfgzN38Ob0wSO5KeDIc3GD5EQ7NaJJNIz
 fnIxv4ETgzkagE8CSDJlEYKwe5/9x1pJcrG3uhgP4745+ol1ieMjqDdGC6p0GcsEVqzdlj
 Oa65BUZ5KycxNXQX2/R4cKR6iZRIKVAfDT8/1f8MWpmLdzjIZ5tsW1NeeNqHnQ==
Message-ID: <fb668789376a8a2289cbfe4ef64d9e1bdeb5ff39.camel@mailbox.org>
Subject: Re: [PATCH v6 4/6] rust: xarray: Add support for index reservations
From: Philipp Stanner <phasta@mailbox.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, Philipp Stanner	
 <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng	
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl	 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich	 <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Lyude Paul
 <lyude@redhat.com>, "Paul E. McKenney"	 <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett	 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt	 <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Lorenzo Stoakes <ljs@kernel.org>,
 FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Eliot Courtney
 <ecourtney@nvidia.com>, Mirko Adzic	 <adzicmirko97@gmail.com>, Daniel del
 Castillo	 <delcastillodelarosadaniel@gmail.com>, Alistair Francis	
 <alistair.francis@wdc.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Date: Wed, 05 Aug 2026 10:53:19 +0200
In-Reply-To: <87se4t7xy7.fsf@t14s.mail-host-address-is-not-set>
References: <20260722144931.1070312-2-phasta@kernel.org>
 <AR60HaAmgoRArB0MtLSPafNeuclmXBF50OveeRR2_bXpofTeHInyi-US9AnrgXyIEZYKcEYGLBGd5lzHqCkOFQ==@protonmail.internalid>
 <20260722144931.1070312-6-phasta@kernel.org>
 <87se4t7xy7.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 4b0cfd47b01dcd78a8d
X-MBO-RS-META: jtwn9mu3nfmca8ahk9b1mbjx5u3tsjwu
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-08-05 at 10:50 +0200, Andreas Hindborg wrote:
> "Philipp Stanner" <phasta@kernel.org> writes:
>=20
> > One often cannot allocate in the kernel with the desired flags, most
> > notably in atomic context. Pre-allocating the memory is the preferred
> > solution in such situations.
> >=20
> > Add support for xa_reserve() in the Rust abstractions of xarray. Create
> > a Reservation object similar to a lock-guard, that can be dropped once
> > the reservation is no longer needed or once the index was stored to.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > Please regard this more as an RFC.
> >=20
> > I need pre-allocating in XArray for DmaFence. How exactly we achieve
> > this is open for discussion.
>=20
> Do you need to actually reserve a key, or do you just need atomic
> allocation?

I would just have needed a position to store to, but the fence sequence
number would be the only reasonable index, so you'd also reserve a key.



Anyways, please forget about this for now, we abstained from using the
XArray in the current revision (v8) of this patch series.


Thx
P.
