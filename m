Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD3AC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FC710FA57;
	Fri, 25 Sep 2026 13:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VJvFRdzm";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C48D10FA57
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:08:15 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hrrbw0hB5z8tb6;
 Fri, 25 Sep 2026 15:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790341692; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONHK6in2QFugTZAdE+WlBVZjzs5/SaRPqlOjW5r82d0=;
 b=VJvFRdzmjasGynjExD+5PDmk22sTHro/QyZxhGQWYqt0lxEugNgqvj/m3YEVmDzrFhnbZX
 lz8cIzjEiLThuScQ4227h1Z003PNsshSx75JzOfJeDjHL/I+No8gr/jSP+gAVgAupXqIsh
 oXUryIjzA6DtmGUYKJ+jPNBXAGiAAsaXyYCqIrHqMTd4F/OqBBItzMlOPtMz1Q3KSFkOVk
 9iyNonnsfhwNhPPj/JGLmzIaF2F0qCpBps55l7mYVwFpgd6lhnKIcA8dkhNp35LNWp058o
 /VFMOWLHWURnaxC57nXjUVXPyrb1DuVUJWekcR0VZjoxtC19A/fwe9ekHs378Q==
Message-ID: <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Philipp Stanner <phasta@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 15:08:05 +0200
In-Reply-To: <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
 <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: b787db3ca691950e030
X-MBO-RS-META: 8c6mfob1m1qd7hgqm67bx3qp9g1rki55
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

On Fri, 2026-09-25 at 14:30 +0200, Danilo Krummrich wrote:
> On Fri Sep 25, 2026 at 12:26 PM CEST, Gary Guo wrote:
> > On Fri Sep 25, 2026 at 9:19 AM BST, Philipp Stanner wrote:
> > > Replace the warning print with a dev_warn!(). To do so, have the
> > > FenceContext carry a reference to a Device, protected by the already
> > > present lifetime.
> >=20
> > Add a lifetime just to do this a print doesn't sound ideal. You could u=
se
> > `ARef<Device>` instead?
>=20
> Yes, that's what I recommend in general.

Weren't you super opposed to refcounting wherever it's avoidable?


[=E2=80=A6]

> That said, we can also use WARN_ON() instead, which avoids the device dep=
endency
> to begin with and still provides enough information to find the "offender=
".

WARN_ON() is fine by me.

>=20
> But as I mentioned previously, I don't consider this that bad of a condit=
ion in
> the first place. Signaling with ECANCELED on drop() seems perfectly reaso=
nable:
>=20
> When a driver does a teardown of the channel (or more generically the exe=
cution
> context) it will follow the RAII pattern, so it will be very natural to j=
ust
> drop the Jobqueue, which will drop all jobs and hence all DriverFence obj=
ects.
>=20
> IOW, driver will likely invent a new type that does the same thing on dro=
p, just
> without the warning. :)

The driver can avoid dropping half-forgotten stuff by calling
jobqueue.complete_all_jobs(ECANCELED) immediately before dropping,
which allows us for having the warning without false-positives.


P.
