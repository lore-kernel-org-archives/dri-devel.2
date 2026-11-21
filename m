Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C6606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd5S5z/o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A415C10E170;
	Sat, 21 Nov 2026 15:03:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E6510E170
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 15:03:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 2137643C99;
 Sat, 21 Nov 2026 15:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 905791F000D0;
 Sat, 21 Nov 2026 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795273409;
 bh=eQB56/5t/XA8YNjdW1AGsKpdchPczQ9QuXajQh1BUOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Xd5S5z/oB4m5WYQTvAMLKfWiJWIGTHuEopAc/jQqsJrsQpXJuXHwHRkMyEfDuiVe/
 jgM4s6nU9YncFTPYK28gQNoNdwRfxNg1RqU9HgNmfMihdm1BrKLu+/dg3tcRZd4pZl
 n5RizFp7FbqDtVhxKjIhAbBJqkNn5ZTXGS33ZLQTJ1or3kLgwmN+zctFGHPXq3Vhie
 5wP8bZivR+doeG+1ofZRhS0fmIE0FPpMzHMkDMxAD9pjC3sAGAndwGpEC7ykbyIYdx
 qNE2wUY2OOjgDMBdrC8KFD6Grsqyb//RUAKaQFc6z6lr9WQMV2g7eEr4p4WWhI0z09
 G4LxdOsndrQQA==
Date: Sat, 21 Nov 2026 10:03:27 -0500
From: Joel Fernandes <jfern@kernel.org>
To: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] rust: gpu: buddy: store the allocator inside the Mutex
Message-ID: <20261121150327.GC946893@joelbox>
References: <20261119111850.33270-1-mbkchelofficialdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119111850.33270-1-mbkchelofficialdev@gmail.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 01:18:50PM +0200, Ivan Tverdokhleb wrote:

> [...]
>
> Signed-off-by: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>

Thanks for fixing the TODO I added!

Reviewed-by: Joel Fernandes <jfern@kernel.org>

> ---
> [...]
>  rust/kernel/gpu/buddy.rs | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
