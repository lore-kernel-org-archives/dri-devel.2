Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6B5C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C188410E04A;
	Mon, 28 Sep 2026 07:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Caqixg5r";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A4710E04A
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 07:52:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4htYS73SwyzKnyW;
 Mon, 28 Sep 2026 09:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790581943; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0Q12XIqRS+/VWq87ADVWPUIHoe67p7zh0+nJPxnflQ=;
 b=Caqixg5rJHjQeJ/TDqXNmxaiLWFBIVoBy+TjcBWjfBw8vMZgCImfWKI1aH7/JWRp3Hyk+s
 Jla1+WSMYnumlTc0jwJ6ezFPrxkIwsPnB//clPVnOYaZJbQNfbkRhdKyRi1H1EW0H+5zAg
 W2Cjg1ZfbDOkIG3+d1LZzxd2l6rv1decxfSo+myl+fJTrKQclTRAbDr0KbB4K2dVHPZQIn
 vBYES3/YUKl8iv7waAFh28POikqWthTkLbmz+Cvb2sxRiR4vM3hbEaRxZFwbHRsmZzYsEI
 y2q1Uos2Y5dijtGm39svGvLSOXEZ6EG5NBGa4dN7f99Cw1m+bq6CTm+yJASeLQ==
Message-ID: <37a2858a4687e4d9bbe0aba4c1861b96875c4ed7.camel@mailbox.org>
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
Date: Mon, 28 Sep 2026 09:52:17 +0200
In-Reply-To: <DLOKSGU61PUG.WSZBN04H0A2Q@kernel.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
 <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
 <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
 <DLOILT0V4HCX.31L2PE7YIAKY3@kernel.org>
 <ab1241777ac432666bb1564d875211bf142a6398.camel@mailbox.org>
 <DLOKSGU61PUG.WSZBN04H0A2Q@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: yrbjxiebmrubnbhr6kqippf3d7oihwb3
X-MBO-RS-ID: b2a0f0269502aff8178
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

On Fri, 2026-09-25 at 19:32 +0200, Danilo Krummrich wrote:
> On Fri Sep 25, 2026 at 7:21 PM CEST, Philipp Stanner wrote:
> > I guess we agree that it would be a horrible bug if there's still a
> > command buffer running on the GPU that can access memory which might
> > have been freed once the associated fence signaled.
>=20
> Sure, but that's unrelated.
>=20
> > So I suppose what you are saying is more: there is not much value in
> > the case of *JobQueue*, basically because all the jobs live inside of
> > it anyways.
>=20
> No, I'm saying there is not much value in general. Whatever thing owns th=
e
> DriverFence has to represent the "device access" of some resource, which
> already naturally establishes the relationship.
>=20
> IOW, whatever thing owns a DriverFence is also the thing that stops the h=
ardware
> in its own drop() implementation; anything else would be rather questiona=
ble.
>=20
> > So I suppose we agree that a warning is fine. It won't fire in JQ
> > anyways, but might benefit others.
>=20
> What scenario are you thinking of?

Drivers doing "rather questionable" things, like we've seen a great
many times already ;)

Note that the dma_fence backend fires a WARN_ON if a fence is freed
unsignaled, too, for the same reason.

Life finds a way.


P.
