Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C87EC01CB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F37F10E4F0;
	Mon, 23 Mar 2026 11:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qganW63i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E4710E0F4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:22:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B02CE43CC2;
 Mon, 23 Mar 2026 11:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5093C4CEF7;
 Mon, 23 Mar 2026 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774264934;
 bh=go8U1XtnO0q6YRwkROqXDA629zNBZ7J7tyDxLbpQpm8=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=qganW63irxdnYI/+eikR1+lCUs8AqhHmM7rj2xJHEBn+59kLGkqSVYmZiDkVFBS95
 cmca6THQy2FnHPFS6cd554eS7tXPqtyoq+Iv3eVHl927FQnLZpEbA8CkANFeInLSN6
 RuoeDnlgp1nC1oswGglYZYIK46KcpyfG6JKX2fiL1PGSCToSmAqpdZGgACYfxF2l+M
 1+YTwyn6WkWFVkSkcolOY7LdkYFaZzT+VPhU6dxKAlwk5xTsW2trRRUYXc85CgYshV
 jKb3EVvd3uZQqa9qG75HZiv/dPoSAztGvEQthdpFZuU1Bk13gxytjEkUsuUPxnJhZ0
 mQ23uAIOgGpgw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 12:22:08 +0100
Message-Id: <DHA4FBLCHNG0.3D8IVG2GFQRLP@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 07/10] gpu: nova-core: falcon: introduce
 `bounded_enum` macro
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
 <20260323-b4-nova-register-v3-7-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-7-ae2486ecef1b@nvidia.com>
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

On Mon Mar 23, 2026 at 12:07 PM CET, Alexandre Courbot wrote:
> Introduce a powered-up version of our ad-hoc `impl_from_enum_to_u8`
> macro that allows the definition of an enum type associated to a
> `Bounded` of a given width, and provides the `From` and `TryFrom`
> implementations required to use that enum as a register field member.
>
> The next patch will make use of it to convert all falcon registers to
> the kernel register macro.
>
> The macro is unused in this patch: it is introduced ahead-of-time to
> avoid diff mingling in the next patch that would make it difficult to
> review.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon.rs | 82 +++++++++++++++++++++++++++++++++++=
++++++

Why does this live in falcon.rs?
