Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA88C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0CC410E1AA;
	Mon, 10 Aug 2026 07:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ViiVWbZH";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079A310E1AA
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:48:15 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hJRgv2Mm8zMlDr;
 Mon, 10 Aug 2026 09:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1786348091; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcfouqGkbtN6qbgtaKfsihWkqZ0FKvP4t7FAWyvgg3k=;
 b=ViiVWbZH8vUUunF8Vd0PWAu3HSRksIQ9wiOB+zo9xu3rhYOC84nlsH7di9G3hhbeYZxSP2
 WCl+f9V615ix5sjUwX+AnN6Y0A4Xe5jpj+DBVdbYXLn1OmrOWiudIyoTWSWY7tg9exUXap
 gVEPbTy+Yi4IB4GH1SKZQY4CgNeaM7vlh9om3T31EaSxe7Jz/i0XQb94Refz1BOCmbAGpe
 OZd7lUsn/Nikk9iUfybN8obV24vjLwq8OzWUuJ3BnRUXsreuqhyKXmzYFaWidBOtk4ewfj
 M2cG09kFLzRAg/3TFj4o2L/EE3ayEaFFUa9W6S85R5DyH8T50R5iXFox69UVsQ==
Message-ID: <91325da652d7840509015c043c8cb7b4450a00f3.camel@mailbox.org>
Subject: Re: [PATCH v9 0/5] rust / dma_buf: Add abstractions for dma_fence
From: Philipp Stanner <phasta@mailbox.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Lyude Paul <lyude@redhat.com>, "Paul E.
 McKenney"	 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett	 <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt	 <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Asahi Lina
 <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>, Lorenzo Stoakes
 <ljs@kernel.org>, FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Eliot
 Courtney <ecourtney@nvidia.com>, Mirko Adzic	 <adzicmirko97@gmail.com>,
 Timur Tabi <ttabi@nvidia.com>, Daniel del Castillo	
 <delcastillodelarosadaniel@gmail.com>, Boris Brezillon	
 <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 rcu@vger.kernel.org
Date: Mon, 10 Aug 2026 09:47:55 +0200
In-Reply-To: <CANiq72nZ25wkxVHpz9GTA_m5E_vyBmRKdDSUNMsJAZ=6zk=zhw@mail.gmail.com>
References: <20260805145949.938505-2-phasta@kernel.org>
 <CANiq72nZ25wkxVHpz9GTA_m5E_vyBmRKdDSUNMsJAZ=6zk=zhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: e1q7rg1nfpbi93b8n3c9nfpegttm8ggb
X-MBO-RS-ID: 32b232e1d19317e22c3
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

On Mon, 2026-08-10 at 08:00 +0200, Miguel Ojeda wrote:
> On Wed, Aug 5, 2026 at 5:01=E2=80=AFPM Philipp Stanner <phasta@kernel.org=
> wrote:
> >=20
> > =C2=A0 rust: types: implement ForeignOwnable for ARef<T>
> > =C2=A0 rust: sync: Add abstraction for rcu_barrier()
> > =C2=A0 rust: error: add remaining error codes
>=20
> Applied (these three) to `rust-next` -- thanks everyone!
>=20
> Please note that your Signed-off-by is required when sending a patch
> from someone else:
>=20
> =C2=A0 https://docs.kernel.org/process/submitting-patches.html#sign-your-=
work-the-developer-s-certificate-of-origin
>=20
> I added it here on apply for you -- please let me know if that is not
> what you intended!

No, fine by me, thank you for fixing it

P.

>=20
> =C2=A0=C2=A0=C2=A0 [ Formatted comments. Added the submitter's Signed-off=
-by tag. - Miguel ]
>=20
> =C2=A0=C2=A0=C2=A0 [ Relaxed `'static` bound and added `#[inline]` as dis=
cussed. Added
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the submitter's Signed-off-by tag. - Migue=
l ]
>=20
> =C2=A0=C2=A0=C2=A0 [ Formatted documentation. Sorted tags. - Miguel ]
>=20
> Thanks!
>=20
> Cheers,
> Miguel
