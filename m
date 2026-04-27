Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAC3FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36DB10E285;
	Mon, 27 Apr 2026 08:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FnSSCVVa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32BBD10E285
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777278033;
 bh=i1vjJALIDaFsj4uh/5cp75KPISUb4APzAkpviJnOHLY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FnSSCVVay3RYT7TQS3vMPGVKJihpMtf/5br0ucloKOwZ6UUZDxf0S7nDN+L+srxEM
 Mv4v3C/2tJADeKoXg8i48RbV249shlIQXfOfHKIwhl+9xaGu0gI/iMVUASZAaWdhol
 1BtkgxZ2ZLB/ZBaHmFZWG8cQdEN7gndpy5hy61TGKxYJd1jHs/eJ6viOgQ7HmnZ4LC
 hNWcdTOBv3g5AxPG+nhZWLqlJkN0BRthCwNstnuLtOFfIaCrQJKhD0ju5P6F6A9aqI
 OEM8sOLfsQ5LAbgEXmSkriR8Cy1EB3VIEiAmqgwyjX+CtRenjwKiASsI3+u3og+hTf
 AlwO7ZAN4mdBA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DCF0717E04F2;
 Mon, 27 Apr 2026 10:20:32 +0200 (CEST)
Date: Mon, 27 Apr 2026 10:20:28 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Danilo
 Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, Gary Guo
 <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 alvin.sun@linux.dev
Subject: Re: [PATCH v4 12/20] drm/tyr: add parser for firmware binary
Message-ID: <20260427102028.25e370b7@fedora>
In-Reply-To: <20260427080926.73950-1-work@onurozkan.dev>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-12-a5d91050789d@collabora.com>
 <20260427080926.73950-1-work@onurozkan.dev>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 27 Apr 2026 11:09:25 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> > +        let fw_header =3D Self {
> > +            magic,
> > +            minor,
> > +            major,
> > +            _padding1: padding1,
> > +            version_hash,
> > +            _padding2: padding2, =20
>=20
> nit: I would write it like this:
>=20
> 	_padding1: 0,
> 	version_hash,
> 	_padding2: 0,
>=20
> to be more explicit.

OOC, why do we need these padding fields? It looks like we're not doing
doing any raw copy/compare of any sort (fw_header is built using values
read through the cursor). If those are not used/needed, I'd recommend
dropping them.
