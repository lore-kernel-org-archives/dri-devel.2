Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE63C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9083610E48B;
	Mon, 28 Sep 2026 08:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qZHnr2GI";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A3F10E48B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:33:03 +0000 (UTC)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4htZM10m9RzKvhy;
 Mon, 28 Sep 2026 10:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790584381; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPQiJZRjfltzxHJi5k9HU87/LqeEBeKq9w573KqY3SI=;
 b=qZHnr2GII/3uXBtgXhk9jwe1cKSNnnxbS1eS0cUNSfxgvLUx0tdxWEI3/YaMPnq5pqdjTl
 0pLd+FSsXbJl37nBHb0y7m8KXaqXkeE/QW3Jlw/QhJfyZxSaOls+h39hYAvx2brTTcqRTZ
 EsCb+b4kG1+ZHZsuoSuxjT2fOZwrNxQGMipPN7+RIm1grTE02NhaRtQcRtqVka5pBi0QGU
 aO9Iz1yAfPThuBJFAM40Lg6jpLwDOLJl6HdHcgql/BDT1L7jtYUTsvOy7QEw5y31Tx0n9N
 od2Jaxa9JV1CTI80iRAiE8t+7JMJwYE3PQoZPFV67UmsSz53C6Fl15T++Ozqsg==
Message-ID: <a44b26ceb273f0cdfc04a4391040c08386b31e01.camel@mailbox.org>
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: phasta@kernel.org, Gary Guo <gary@garyguo.net>, Alice Ryhl	
 <aliceryhl@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng	 <boqun@kernel.org>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>, 	linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 10:32:54 +0200
In-Reply-To: <DLQSQE8ZXLY1.1XFW8PGSDLICT@kernel.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
 <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
 <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
 <DLOILT0V4HCX.31L2PE7YIAKY3@kernel.org>
 <ab1241777ac432666bb1564d875211bf142a6398.camel@mailbox.org>
 <DLOKSGU61PUG.WSZBN04H0A2Q@kernel.org>
 <37a2858a4687e4d9bbe0aba4c1861b96875c4ed7.camel@mailbox.org>
 <DLQSQE8ZXLY1.1XFW8PGSDLICT@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 1xuw3zyrf31yye8ku3bcs35ptp84s696
X-MBO-RS-ID: ac8c0f2cdd2425f6d3a
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

On Mon, 2026-09-28 at 10:11 +0200, Danilo Krummrich wrote:
> On Mon Sep 28, 2026 at 9:52 AM CEST, Philipp Stanner wrote:
> > > > So I suppose we agree that a warning is fine. It won't fire in JQ
> > > > anyways, but might benefit others.
> > >=20
> > > What scenario are you thinking of?
> >=20
> > Drivers doing "rather questionable" things, like we've seen a great
> > many times already ;)
> >=20
> > Note that the dma_fence backend fires a WARN_ON if a fence is freed
> > unsignaled, too, for the same reason.
> >=20
> > Life finds a way.
>=20
> I'd rather you engage with the arguments I made above and give a concrete
> example of how it "might benefit others", instead of resorting to know-it=
-all
> platitudes.

Stating that I cannot know nor conceive all possible patterns and
misbehaviors is quite literally me acknowledging that I do *not* "know
it all".

With this patch I was just trying to accommodate your post-merge
request for replacing pr_ with dev_err() or WARN_ON. If you think
neither is actually necessary, that's also fine by me.


P.
