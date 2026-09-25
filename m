Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DFCC98325
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4CF10E27C;
	Fri, 25 Sep 2026 15:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nsUUFKyp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC2810E27C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:50:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 695E141880;
 Fri, 25 Sep 2026 15:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECA61F00893;
 Fri, 25 Sep 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790351410;
 bh=rLydLkoX2buj8K7vNFnDF0+lONdi8sW15E9C0o2QLsY=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=nsUUFKyp0SwC7LLYJO118a3NMMnZb2Z+IKDrpC4p0kDCspgxzI3F+15oHPRnXM/jN
 N9UKKzJHZ826boWgKsq1Yl7xNC9bqI/IjErTlxs0xWcTux2JhJ+vuZMcOnSXEnz1f0
 2V0NxAuP4T7iSaxQB+J4SVgh5u4ORmdRwfjBG0WMtU1yIfsrnPTzYlphdLK+QbeN+Y
 O43FAZWbsZ4bKZtF6u/mN56dxiJL556nH/VLRlctH5UEuOv3wGEK97b70fvZkPnAla
 +tnCasWrYHbtpVfz/R07+oiAh4hl8XvX4Kmmzn7a0eSEnNfWmhnGTF+O3GJl4KlZIi
 EijrSBJBTxqLg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 17:50:04 +0200
Message-Id: <DLOILT0V4HCX.31L2PE7YIAKY3@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
Cc: <phasta@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
 <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
 <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
In-Reply-To: <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
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

On Fri Sep 25, 2026 at 3:08 PM CEST, Philipp Stanner wrote:
> The driver can avoid dropping half-forgotten stuff by calling
> jobqueue.complete_all_jobs(ECANCELED) immediately before dropping,
> which allows us for having the warning without false-positives.

This would just move it up a layer from inventing a new type around DriverF=
ence
to invent a new type around Jobqueue which does that instead.

But the Jobqueue won't have any procedural teardown, it has to teardown stu=
ff in
drop() anyway, which includes dropping jobs already.

What I'm saying is that there's not much value in DriverFence::drop() havin=
g
this warning in the first place, which then either the driver or the jobque=
ue
has to work around on teardown.
