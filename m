Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D775606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rsfA6x9z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E276510E555;
	Fri, 23 Oct 2026 06:51:13 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66A710E555
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:51:07 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j9tvq5YVdzKnkg;
 Fri, 23 Oct 2026 08:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792738263; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vq8E+jHMyDXl7eoZ57S4Q2ik2oOMkXHS2FXEVqzJ5Q=;
 b=rsfA6x9z5gz9g+eJNQ2b7ucfNKLVP6pYkEfxQrRioI9qekqImCTXzDl1DvOCwwhMUWC2l/
 l6eC7wX03rSP3dpTBB/KdSKyhtVyCrJgisa4Ghgp5piIyo6YjIiFon14EECCJG571CWy1A
 UfhCXHLNcgzBfcsfdcmCQd9idoH1rnubsWfOTPsOvTZEczpOT+gcXP2v06Z0SarZUz2eMq
 TjR3uxJyFNn4XDW26dtaxENxyt81tG17P3mLwzYRRvCSVaJ3DtFAE5jP+4ta8qi64Fl1OO
 UCDr2+SUbr1uJtKsbshZJArI0+6X+FWU7iMXNYu9E0eLiYMNoLUD3zcBo2Xzww==
Message-ID: <948cd47aebbd0639492db1fd7bc3852e7e60af91.camel@mailbox.org>
Subject: Re: [PATCH] rust: DmaFence: Don't drop on signal
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl	
 <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng	
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 08:51:00 +0200
In-Reply-To: <20261022162701.2297062-3-phasta@kernel.org>
References: <20261022162701.2297062-3-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: o977mejxkh8hcuc9iopum4f67tyimxq5
X-MBO-RS-ID: accedf3891204f28d89
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-10-22 at 18:27 +0200, Philipp Stanner wrote:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SA=
FETY: `self.data` is valid because `self` is valid.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let f=
ctx =3D unsafe { self.data.as_ref().fctx };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let _=
 =3D fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
> +

When I think about it we probably want to address this in a series
(preparing for JQ upstreaming) where we also have my proposed
DriverFence::drop(synchronize_rcu). Otherwise this patch would need
both synchronize_rcu() and rcu_barrier() for formal correctness when
the FenceContext drops, which is just overkill.

If only we could fully lock the fence, all this would just go away. But
currently that's what it is.

So forget about this patch. I send sth new soonish.

P.
