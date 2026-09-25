Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67457C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C800E10E1CB;
	Fri, 25 Sep 2026 17:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XUKSdv7w";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4742910E1CB
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 17:21:55 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hryDc0jLZzMl31;
 Fri, 25 Sep 2026 19:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790356912; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xb1vQYsbfVcJiuLlcnMnP0BgQS87PDLHTwEVGJsEmis=;
 b=XUKSdv7wDvfAMRjCSmpiqwAoJpEn6K4Dph8KYF7GVQGhaAXkq4s2bmVBZ9KF/wy2e1uOK7
 FQradnqGjjyEtknwtYEc/OmPqkGi9HvX8gHZOfmnCmba6aa+ar1TlyRS0ppia+T+YNtWld
 NwN5H8J2/UdFAnGHJ+9tapQZZ1U1dT2MAVC8+3M8EJXRkJjT6l8YT0KsL/CR1y5WBdxvI+
 usxUVdyi9DFK2gTCF0SdDZSWWIRsDA472CmRIqcmVm1wNVBEu20z3fSjIfWQjiqRcijDlQ
 H6LhIx1qjmPVqxz9uyhMEENr8Nvw0HcZSPyjRGLAyH5V2EgBwHyK1YHnp8E0Ww==
Message-ID: <ab1241777ac432666bb1564d875211bf142a6398.camel@mailbox.org>
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
Date: Fri, 25 Sep 2026 19:21:45 +0200
In-Reply-To: <DLOILT0V4HCX.31L2PE7YIAKY3@kernel.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
 <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
 <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
 <DLOILT0V4HCX.31L2PE7YIAKY3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: ee29a2c5e2aeb6681a5
X-MBO-RS-META: yqp1koqfqjg36e8eizcijcdqkxoh8iyw
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

On Fri, 2026-09-25 at 17:50 +0200, Danilo Krummrich wrote:
> On Fri Sep 25, 2026 at 3:08 PM CEST, Philipp Stanner wrote:
> > The driver can avoid dropping half-forgotten stuff by calling
> > jobqueue.complete_all_jobs(ECANCELED) immediately before dropping,
> > which allows us for having the warning without false-positives.
>=20
> This would just move it up a layer from inventing a new type around Drive=
rFence
> to invent a new type around Jobqueue which does that instead.
>=20
> But the Jobqueue won't have any procedural teardown, it has to teardown s=
tuff in
> drop() anyway, which includes dropping jobs already.
>=20
> What I'm saying is that there's not much value in DriverFence::drop() hav=
ing
> this warning in the first place, which then either the driver or the jobq=
ueue
> has to work around on teardown.

I guess we agree that it would be a horrible bug if there's still a
command buffer running on the GPU that can access memory which might
have been freed once the associated fence signaled.

So I suppose what you are saying is more: there is not much value in
the case of *JobQueue*, basically because all the jobs live inside of
it anyways.

So I suppose we agree that a warning is fine. It won't fire in JQ
anyways, but might benefit others.


P.
