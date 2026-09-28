Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D64C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B065B10EA38;
	Mon, 28 Sep 2026 12:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZUuITdhl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1694110EA41
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:00:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AFC7C40056;
 Mon, 28 Sep 2026 12:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8486C1F000FF;
 Mon, 28 Sep 2026 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790596848;
 bh=wQNBXbzxJrFugBqSjapF3Y1Rp5E/yX+U3qLamlmKpMc=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=ZUuITdhlIyOTk+ZxLPSOoTMypDCEEKAhTUV1VJ4AqoedJhS83RLm7CN+Oy+0YkpSd
 6c8UTOkIrot6mkURHNtYQ+ujJUy4YdXQKjxf9upDm2kldr/Dqo3PZ8EB7fBw/nXcSv
 q/r94Re9qmpaL2v/S85c4RRsOReefpi+qWy5qlJaLKtrOEUbDpFcoaTJsxVTafbBMM
 nPOjOf1zPVSI6zl35OmMBatNkCOMkhp6+sGHrgVHd1ODIruzUIdGkAoMrDwMPf22Y7
 e6z4ePww0RVPnGqT2D1eMppKcnXEldAd2u3pYb/62UBDu85yxxTgAHiF/baU/MXLZy
 X7/nv4a8SeAfw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:00:45 +0200
Message-Id: <DLQXLV1FYMQS.JBP531K4P4T8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
References: <20260927144417.1280385-1-dakr@kernel.org>
 <DLQX3FCYMAGD.3MS8E1JK5J7D2@garyguo.net>
In-Reply-To: <DLQX3FCYMAGD.3MS8E1JK5J7D2@garyguo.net>
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

On Mon Sep 28, 2026 at 1:36 PM CEST, Gary Guo wrote:
> I think this doesn't need to use `pin_chain`? You can do
>
>     gpu <- ...,
>
>     _: {
>         #[cfg(...)]
>         gpu.run_self_tests(pdev);
>     }

Unfortunately, this produces the following error.

	error[E0382]: borrow of moved value: `gpu`
	   --> drivers/gpu/nova-core/driver.rs:140:62
	    |
	119 |             gpu <- Gpu::new(
	    |             --- move occurs because `gpu` has type `core::pin::Pin<&=
mut gpu::Gpu<'_>>`, which does not implement the `Copy` trait
	...
	129 |                 gpu.run_selftests(pdev);
	    |                 --- value moved here
	...
	140 |                     Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_=
ref().get_ref()))
	    |                                                              ^^^ val=
ue borrowed here after move
=09
	error: aborting due to 1 previous error
