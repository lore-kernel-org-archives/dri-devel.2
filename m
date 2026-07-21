Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD74C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F2010E3FC;
	Tue, 21 Jul 2026 15:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="foDFq9gv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC1910E3FC
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:32:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A21BE43E55;
 Tue, 21 Jul 2026 15:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27EE1F000E9;
 Tue, 21 Jul 2026 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784647943;
 bh=q5/zi7cNrAXqMYuiX3MH0iTCnpKZXOPQtuIcMMtp6BM=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=foDFq9gvx5k/WUNMRwO6oPryQ99mNdJsoBTaxbg2iTH4UNN8w78Ug1kjn6bMaK9yX
 ZT0/LujqZx6Fk9YQvP8+vQy3EHkKkpKnkNYE+iyrX9pNTJEHndC/GptWbUQWyk29jl
 hwdzsyFlbSjKwObSPqXOJjNuIxWIEZm/tRuq9SpXV4ctJJe3rdvZH14glAXRc0cAEt
 H/pUR5oALHPviHwJ1FZmSo4FloHBxeefDtHq8/fVVH+G7LkOU45d+SptMbyeA9Bozt
 PsgPuSQcNTngIoCw9UvTij+E5iHQ+/mhD3MRKVQEgp9ci44gygq7EcFwzE1U3IEec6
 IhUuvsOpwv19g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 17:32:18 +0200
Message-Id: <DK4CW8JXVL8M.2KKRMJVCD9AYO@kernel.org>
To: "Laura Nao" <laura.nao@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] drm/tyr: add Wait type for GPU events
Cc: <daniel.almeida@collabora.com>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <deborah.brouwer@collabora.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <kernel@collabora.com>, "Beata Michalska" <beata.michalska@arm.com>
References: <20260721151423.444175-1-laura.nao@collabora.com>
 <20260721151423.444175-2-laura.nao@collabora.com>
In-Reply-To: <20260721151423.444175-2-laura.nao@collabora.com>
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

On Tue Jul 21, 2026 at 5:14 PM CEST, Laura Nao wrote:
> +/// A convenience type to wait for GPU events.
> +///
> +/// Wraps a [`CondVar`] and [`Mutex`] pair. The mutex synchronizes predi=
cate checks
> +/// with wait/wake operations; the condvar provides the sleep/wake mecha=
nism.
> +#[pin_data]
> +pub(crate) struct Wait {
> +    /// The actual wait/signal mechanism.
> +    #[pin]
> +    cond: CondVar,
> +    /// Synchronizes waiters with notifications.
> +    #[pin]
> +    lock: Mutex<()>,
> +}

This is backwards; if I get this right at a quick glance it is basically ab=
using
CondVar to implement a WaitQueue abstraction in your driver.

What you actually seem to look for is a proper WaitQueue abstraction, which
could then also be used to simplify the implementation of CondVar.

I'm already working on a WaitQueue abstraction, since I need it elsewhere. =
I can
probably post something in a few days.

(I didn't check your use-case but you may want to consider completions and
simple waitqueue as well.)
