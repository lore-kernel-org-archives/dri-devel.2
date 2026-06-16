Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D841CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F9C10EBD1;
	Tue, 16 Jun 2026 14:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LTxHIQlt";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D0B10EBD1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:39:04 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gfqPK5FTGz9vDY;
 Tue, 16 Jun 2026 16:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781620741; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KxbCI0+dF9Yh6qhrQaRpgiRe7M3XGzzBaYd+GoTiQg=;
 b=LTxHIQltp9Jb5AWLrvwe8SqWrnpkF4nDJ5r/qelMwNEsG9u2FOyE2VdwXQasYxcAtGBvw0
 YmGiEOSqAg+cv4UQmi57i4RUoDn7QUtakB2XWPIMTEMHHwquiGxl6tukBP1M2eF8lrdbQe
 MgpW66pYgCFslIPLtkPup7c6o2aA10tcyBt6YD51q0hUqBDXu7r7p5/jMOn26Z+8nn6Duy
 Dwrv/ebL8R1UPb7/Jr8HWG9lf8gmisIYmf5xBwlY9w4HtGX3Wnuuym83XD/bhcMWb+x61A
 5umHYnr32jINweHb3XKlncqHXu7UnYCSq4QYwro2WT19KN3A64WdXBpMUqLI3g==
Message-ID: <d074d3105a2c1d4f594bc6d7b0b09e62757790d5.camel@mailbox.org>
Subject: Re: [PATCH v2 5/6] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Philipp Stanner
 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Sumit Semwal	 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki	 <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, Daniel Almeida
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes	 <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Krishna Ketan Rai
 <prafulrai522@gmail.com>,  Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is, Boris Brezillon <boris.brezillon@collabora.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rcu@vger.kernel.org
Date: Tue, 16 Jun 2026 16:38:51 +0200
In-Reply-To: <20260616124755.460550-1-work@onurozkan.dev>
References: <20260616082819.2943886-2-phasta@kernel.org>
 <20260616082819.2943886-7-phasta@kernel.org>
 <20260616124755.460550-1-work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 1m33qybtqhatn6fz6y69qwsq59hq7btb
X-MBO-RS-ID: 38cabac8855db3dad1b
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

On Tue, 2026-06-16 at 15:47 +0300, Onur =C3=96zkan wrote:
> On Tue, 16 Jun 2026 10:28:17 +0200
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // DriverFenceData is repr(=
C) and a Fence is its first member.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fence_data_ptr =3D fenc=
e_ptr as *mut DriverFenceData<T>;
>=20
> Either the field ordering on the type or this code is wrong because the f=
irst
> member of DriverFenceData is `rcu_head`.

Yeah, that's a bug introduced in this revision. Thx for pointing it
out. Already fixed it downstream.

I'm just wondering why my test did not blow up.

> >=20
> > +}
>=20
> I am unsure whether it is safe to cast the pointer in Fence::from_raw wit=
hout
> Fence being #[repr(transparent)] as the layout compatibility is not guara=
nteed
> explicitly.

Shouldn't #[repr(C)] do that trick, too? Do you need both?

Who can answer that?


P.
